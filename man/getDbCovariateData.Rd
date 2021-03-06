% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GetCovariates.R
\name{getDbCovariateData}
\alias{getDbCovariateData}
\title{Get covariate information from the database}
\usage{
getDbCovariateData(connectionDetails = NULL, connection = NULL,
  oracleTempSchema = NULL, cdmDatabaseSchema, cdmVersion = "4",
  cohortTable = "cohort", cohortDatabaseSchema = cdmDatabaseSchema,
  cohortTableIsTemp = FALSE, cohortIds = c(), rowIdField = "subject_id",
  covariateSettings, normalize = TRUE)
}
\arguments{
\item{connectionDetails}{An R object of type \code{connectionDetails} created using the
function \code{createConnectionDetails} in the
\code{DatabaseConnector} package. Either the \code{connection} or
\code{connectionDetails} argument should be specified.}

\item{connection}{A connection to the server containing the schema as created using the
\code{connect} function in the \code{DatabaseConnector} package.
Either the \code{connection} or \code{connectionDetails} argument
should be specified.}

\item{oracleTempSchema}{A schema where temp tables can be created in Oracle.}

\item{cdmDatabaseSchema}{The name of the database schema that contains the OMOP CDM instance.
Requires read permissions to this database. On SQL Server, this should
specifiy both the database and the schema, so for example
'cdm_instance.dbo'.}

\item{cdmVersion}{Define the OMOP CDM version used: currently support "4" and "5".}

\item{cohortTable}{Name of the (temp) table holding the cohort for which we want to
construct covariates}

\item{cohortDatabaseSchema}{If the cohort table is not a temp table, specify the database schema
where the cohort table can be found. On SQL Server, this should
specifiy both the database and the schema, so for example
'cdm_instance.dbo'.}

\item{cohortTableIsTemp}{Is the cohort table a temp table?}

\item{cohortIds}{For which cohort IDs should covariates be constructed? If left empty,
covariates will be constructed for all cohorts in the specified cohort
table.}

\item{rowIdField}{The name of the field in the cohort table that is to be used as the
row_id field in the output table. This can be especially usefull if
there is more than one period per person.}

\item{covariateSettings}{Either an object of type \code{covariateSettings} as created using one
of the createCovariate functions, or a list of such objects.}

\item{normalize}{Should covariate values be normalized? If true, values will be divided
by the max value per covariate.}
}
\value{
Returns an object of type \code{covariateData}, containing information on the baseline covariates.
Information about multiple outcomes can be captured at once for efficiency reasons. This object is
a list with the following components: \describe{ \item{covariates}{An ffdf object listing the
baseline covariates per person in the cohorts. This is done using a sparse representation:
covariates with a value of 0 are omitted to save space. The covariates object will have three
columns: rowId, covariateId, and covariateValue. The rowId is usually equal to the person_id,
unless specified otherwise in the rowIdField argument.} \item{covariateRef}{An ffdf object
describing the covariates that have been extracted.} \item{metaData}{A list of objects with
information on how the covariateData object was constructed.} }
}
\description{
Uses one or several covariate builder functions to construct covariates.
}
\details{
This function uses the data in the CDM to construct a large set of covariates for the provided
cohort. The cohort is assumed to be in an existing table with these fields: 'subject_id',
'cohort_definition_id', 'cohort_start_date'. Optionally, an extra field can be added containing the
unique identifier that will be used as rowID in the output.
}

