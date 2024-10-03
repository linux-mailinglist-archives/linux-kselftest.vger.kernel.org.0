Return-Path: <linux-kselftest+bounces-18968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909ED98F214
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 17:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E44A28325B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0A1A071C;
	Thu,  3 Oct 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="o6qB4D0h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68994823C3;
	Thu,  3 Oct 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967932; cv=fail; b=ePMxLCNYCDcvGoYYK+j9yOPJl5wyqN1EBfcjKEa4jlktoD6xeWTvfQYkpcGBhAY2yn2pij4NlLA5nzbctkgf9oDbnRU24nVaYEqTnH4h9uWiM4tU+pKRkvb2YRM0dKW9vZX/1E+dqEN+NGuqswB5lEJB+bh65UZcOK4IMGaxa0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967932; c=relaxed/simple;
	bh=XdPqeFKvbZiKq5N5fkytr+vNRZQrvqfDLWBulpn64JU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hut2jnBksct5Nk0VK2UNi7tZe+a17hEx2eDt0QA1q30V3AD/kGdMYnLOfYRKwPiZdjAIxwMi0BflQ2vKMgiWQ9VK5hoI7SXmAdhtnqFeBoDerxbxSqjOAh70VrI1mrw1pogswpneUbyWh2zSFa7LQupsRr83OKeRrJtFAnxJuzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=o6qB4D0h; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493ERAWY021582;
	Thu, 3 Oct 2024 15:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=XdPqeFK
	vbZiKq5N5fkytr+vNRZQrvqfDLWBulpn64JU=; b=o6qB4D0hfY9JSP1wlGXi9OJ
	QzGJJs8/lDKrVgabN+5L2N7cLHYBaFsmkUy+bboYyclLCcxh+T3Zd5ehbd2Exf/7
	gtwrANMj/Jl13MnVN1bhswWUjRcf5lmhQ7m5gYUo84uRATMtJSSQ4lf/YVYjGmcY
	Wy+nxJWsx51fgkreXctwluEc3R1eN72JkNjVZE0Ybqw3Qkj9d9srqn12hJuIIqtM
	aoOyGLISD6GVVC86qOEW7iBB9WhHbsO65FLK3Ttx9YTEhx/bw2Ff77aT5GaBMvRt
	C+whSjZYpT2/RHecDt3mokvRigDeM0S8mAr9LLhU8MTVb1Fuqt4zTxVyVTPGPZQ=
	=
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41x94y4prk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 15:05:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux4K2vr0MIFu4iDVVhUzwSeCpV6qCv12F4Snx3BEOA6Db+4Kx2qAdU1q/ZiyAadpdqwqVnZcvVn82t+7L9uW+vZLUNF/8OtWRW3NvhIH144sX6UoGXwCkwpdzNWRcE3pOnhbKEDNXwnCqFdaNASqYnsnJvLQfoFcQvxlJ6Lm5Vsa5IAbvPqEzWsiaTyItLSipMW4OA0HWEsiI9nrqJNhEBT0wMUV9QFJ1AvOaOYqmwYrGWmBLj4xzCGlu7LMgz+0nzyziPSYTB4GhG6NMNekxXmiPkMPpjHIeI8IJkIbMBCwKKAixKtObwah1XoHFxDBfyscb05tyKiGNhOSHrF4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdPqeFKvbZiKq5N5fkytr+vNRZQrvqfDLWBulpn64JU=;
 b=XGqrv8yepH/ZBPBm+mIhJY6rr3bFIbgbpzoK2NpGRavda+TFbgLY2VzS63cPblysHaCr7HXVRIWbfzWGVcOePwUjyhPXON26uAJ989w2Xbm9YI0a9uAfxgGCSLWYR8Q7uKy4Mgf1nhh87PSvdfOV4TA8woZLtgZg429sbQsjJ8XyCJj2Hn46ecvU8epk4zieBeYXYeiZoJ9xTLw5QmTWsK+ssRraEqbxtVW+7XwRx8vyF1IpZVYTkUbKNtMZCMdwMt83g/MlgwVRxSMQRyIwfwZyuX7tPNmkerr+2VVO/MVvqR6HzcMjEA6NBkeM5l6Z0YWty6lR1LaZyXDr9SKMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by BL3PR13MB5193.namprd13.prod.outlook.com (2603:10b6:208:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 15:05:06 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 15:05:06 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Jakub Kicinski <kuba@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>
Subject: RE: [RFC] MAINTAINERS: split kselftest entry into 'framework' and
 'all'
Thread-Topic: [RFC] MAINTAINERS: split kselftest entry into 'framework' and
 'all'
Thread-Index: AQHbFZ/hTrxRsX6JLUOqrwpwraotobJ1HOkQ
Date: Thu, 3 Oct 2024 15:05:06 +0000
Message-ID:
 <MW5PR13MB5632FECA88BE3F0711032738FD712@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20241003142328.622730-1-kuba@kernel.org>
In-Reply-To: <20241003142328.622730-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|BL3PR13MB5193:EE_
x-ms-office365-filtering-correlation-id: 410a5c15-7cdb-405d-51dc-08dce3bcc46e
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVdiaGYxRWZMSkthejNrS3dSWDFaSERGWjdJelFXdnFaNjBmcDNEbkVvaXJk?=
 =?utf-8?B?YnRWTTd2K2V4TzU5V0hJMzQ5Q3U2YXRjYnA1ZVk3a01xcGZEa0ZpcGJmYzRo?=
 =?utf-8?B?T2Jrd3pka1dHM0lYUEtZRzF0V21xN2VCeDEvZ2x1K2FhTm1MWE93ZXJFV3BS?=
 =?utf-8?B?amVrTllNd09nT0J0Wm1qZHd4djJTM2VwZS9zbjlGSHNVbVFpYVlaRnlvbWNR?=
 =?utf-8?B?dHBWWUM3RDJDK21pb054QlpKaEZwZFc4cEJYVXBuODcyaG9FQ1hFc2dTZnRL?=
 =?utf-8?B?T1pTRm9wQUJLMkVTYTlvUlBEYm83aCsyd0RtdWJucHFXUmEvSTF5emR4eHVF?=
 =?utf-8?B?RVRPYmJ3ZzZ5ZG9SdGJobGF6RzNPQkVzRVQ1SnpBdUdPOElUMmVNM084OVZj?=
 =?utf-8?B?THNqRy9XOVlXZEVyZXRPSU0wUTQyOTBpV3Zkcmtnbjc0OXlVdWdMbEUrYTkw?=
 =?utf-8?B?MXRtOW4zM1J3eWtSVCtYalN4T3FjdHRlbFQwT1RIRUhrOERYZkVpWlNILzJn?=
 =?utf-8?B?ZXg3Vmc2WU1ENSt5ZWhhaUhBeVhNb3dJVHYwQjc5MDQ3WWkzcDZCTHcyY0FR?=
 =?utf-8?B?STNkZzZ4TkozWWNYaVlOUWdRUWh5a25wRUpFdGtyclE0RnVnMFg2Z05lbnNy?=
 =?utf-8?B?ZExNK21kNlg5WXZ4cWdVSW1raGVsWWJBVFJ2YmRBV1VkRnpHTi84QnZHdmdR?=
 =?utf-8?B?cU1VQ2RoaGlLaGFXTWNhaU5Fb1JLbWxzY3J4NWltU1h5ZHI2ci9iYXhNUXpU?=
 =?utf-8?B?Ymw0WGs0cllYQWN1QndrV3A3MU9hdkEwVFZxOVh5NkpnTW9FSTByb213SXky?=
 =?utf-8?B?R1BCdXhmQVVzaGlUclFvejZjcUJGc3h3WlBlOVNjcE5KQW5Tb2JBSm9keE41?=
 =?utf-8?B?d0k2UGl3NU9nVjZaZnN0Nlg0VEkyOWZpeGdkaW80MzNlcXAvTUF0QmpqQ3Fm?=
 =?utf-8?B?ektjMGhkdVBRV0NuSUFYREFDbm9idUJQZ0NkbkdXNk9tQzNua3ltWmJ3OEJC?=
 =?utf-8?B?SnJyNlhoZ2ZoV2lKQTNRbUw2ZEdwZGg0MWdwOXo1Nnh2VFpFV0xxT2JId0dK?=
 =?utf-8?B?RmxBZFVMWUFJV1VpeFQ2WkRzZFExcUdnQjBhR0o4aHpwaTFyVHd6UDNNQk5q?=
 =?utf-8?B?bWh6eHYwODVweVRDVXd3dHd2NW9KVm1IVTJtSzhHOERNb0ZFU3NKK05kWCs1?=
 =?utf-8?B?L2VwTnNVYms5YkFZU0NKMHoxWVhBait4Y2taQSszMkhsb1l3azhIS25LajVq?=
 =?utf-8?B?KytFcWJXY0E2U1JzdDU4N2ttQ3BQSDFaSnNNekNnYmtuNUFrWkViV28rbHV2?=
 =?utf-8?B?MGcwQlBmSkpSZUJ4dm9IV3EvYzRwZktKQ09UUEhveXNxRzBNTVhGbjFiUkI4?=
 =?utf-8?B?aElpSDhSZ0RJWEd6Z01WcHJnZTdTNUpFMW9IWE0zRTBmR2NJU3FjdFRUa3l0?=
 =?utf-8?B?VnNjL0dLQ3pIS0R6dmovWEpnaWNMc3FUU2p0bFRBODZQUTUwMzJYa1RpSnNw?=
 =?utf-8?B?NU9sUk4vZ3dZa1JtbTc3Y3hnaTJhYWNxMDRHOHhHSU9sTTI4VHhJcXpTNVNx?=
 =?utf-8?B?NHJuR0w1aDdWMGhycmY5STRJbEN2aWpENVhVQktRMml5TXFVemJiVXVnNUdv?=
 =?utf-8?B?RmFRRGs4b0l6NXk4Zm84bFkxTHVYMWdlK3RhY3gxMUFIcGpTM2FFb2RtNzNE?=
 =?utf-8?B?WUdFZE5iUUFhMG0ydWo1aUZraHg4d2JJaFU3ejF2SklHQWJybHdmTUVVam5Q?=
 =?utf-8?B?YXZIclJtRE1HbElMc3d5ckVaa1lkSnpaZk03bENzaVdDREtwWDU0RjVhTUZT?=
 =?utf-8?B?SVBCOXpkZGdaQ1BBMlZBZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDY3YnZGZ3RldmRoVzJKUThVYy9LSURMMlNPRTUwQm1oOEQ2Rld1b0dZeFcw?=
 =?utf-8?B?dW5URWNmQ2xUZ091aFBkemJYdkVWSXJUTHd1ZUphMHB6TUdJdXcvbStWcEdW?=
 =?utf-8?B?VHZqV25BTVNOYVp3Qzk0UXkvNlJWWkdXVHVlZGhmRnNHdEJhbzFEQURPUVpN?=
 =?utf-8?B?NVZVeitRVmF6M2tkSm5SN09MRlZwS1lUMnZhVkc2UnFwK040Y05LQkFXdElw?=
 =?utf-8?B?SlJzWm5CQmxJbzk0NlZyNHl1S3lYQXVSUWkvYm9wREd2K0dpNnNvTkdHMTE0?=
 =?utf-8?B?dG1WanNqbXY1QTRhTThrZGVqMmRpbytEUkhxb21QZGxMNnFMSXpSTlFNK1Np?=
 =?utf-8?B?YmhmeURiZ1pEVjYrdmZpNVpndU5XWnpEMzArb2xVVXk3blRqaHJnS1R5SEw3?=
 =?utf-8?B?dDJUWEJkUXlTR2EzWVhyZElEQlZiUUZHMlpXQnArOSt0ZW01cytkYzZHd1NE?=
 =?utf-8?B?UExRbEk2S2laNloxTk1xOG5uN1p4UmlnQmNDY09PdnJUM1pqcWhidkRhdGx4?=
 =?utf-8?B?R1BsYmI0bU1UZTBON0VNcXVsUFhQWjRvcGpjN3ZydHJiZkZHNHN5MmpkMFkv?=
 =?utf-8?B?UkQyWXlUZWwvN2VLTzEvb1RFSXdjcnppQkpyYUFjczZhcUVOTXpMNGthdDRR?=
 =?utf-8?B?cFRLNitxQkUxQ0JXZUNNZS94WG9UQVJVUUxzcmliVjFsM0hHM2ZlM1JQc3pp?=
 =?utf-8?B?Q1VuS2dic0s1MDk1RFM5dDJlQkJrbXIwUWZtSjNxSGcxdTV2NkVvU0ltdnVS?=
 =?utf-8?B?MTJVbVpSMTBOT0ZBQ0JwZGxKekY0eVFVRENkd0R6VWN1bUhIeFNGam9ZY0w0?=
 =?utf-8?B?KzdKbUd4VEFaZ2syRWpKTHhTVjBIZjRuNEJUOFVmT2lENkZQaWlLVnFudXpP?=
 =?utf-8?B?TVhuTFFxOENQK1poOGJ6azBUVzAxVGtZakp6eGJRWkNBVGVYMXpDVlpNaEhL?=
 =?utf-8?B?cDRWeTdBZkxjaXNDT0JsTVpCUlA0azYwTzVaQVVJNHdqczlJRTY1NVBGQndj?=
 =?utf-8?B?azRhYWVyandETy9DK2ZTWG43TkFHb3NTYXRsT2lmMU5xcXJPQVU0dnNwWmF2?=
 =?utf-8?B?NkJ5MzNIU2kzSXFhSWJsWVBMb1FGeHFGYmY3UFRiUSsycTZEQW9wT29MOVV2?=
 =?utf-8?B?a3dmRXNuQnI3Mk03OWdscTl1V05ydUkyYlpIbVp2bU9OQlJDM2thWDhZUzlH?=
 =?utf-8?B?ZjYzR0pZanRZYWJ0b3kzMHQ1ZVBNUDNMZ2FmVUl3eTVuVDBTOEFTL3E4Ty9N?=
 =?utf-8?B?K2U0MGxVTkFtNzFEWTUvQk9adEc2YkdCbis0eFgyZnB1dUJxSG1KZXlQNVZv?=
 =?utf-8?B?KzJDZndNK0Vub3d3THdFOCtHZnlUajBCMGN3Ny8rajRoWG5XQzBmUnJ1Y29a?=
 =?utf-8?B?RysxbS9mQWp1MnZHWk54RDB0UmEwT2NuWFpjQVNtRmlvVTRDT0xBMUZEOWxu?=
 =?utf-8?B?a08wc25pRG96NGNTNEJ6YmVsWmNsd20rdlYvWWlTNjZwdk14cnNTcG1LSUsv?=
 =?utf-8?B?S25VNGw0NXorSytNazFOMlVGNWFaakFlalRqODNMZ3N3ME9WRzl3SkRmR3dP?=
 =?utf-8?B?OHNNU0lKMmErbFNEblpnSEJTVzQzWlJnZVh6TE1PcXE1VHBqYkt0MTZjU0U2?=
 =?utf-8?B?R3lyNlZZSHFiRkJkazY2d3dHc25nUUtIUk13R2pTWFlCanBnVXlBWmRNdTdL?=
 =?utf-8?B?cHc3M3F0VFVjdzJEbzZmcUJNNzhwV05YZ2taVUtoMzdVdGUrUTFUczZpaWFj?=
 =?utf-8?B?a056MGJkcitGY3BUVnY4OHFjbkNqcVRYbVBoM005dHI4cEFQdzhNY2JFTnd0?=
 =?utf-8?B?SDZJZHhuQmhsUmp3QmVjNzNHeW5FMVp2UUVNbUY1OCs1RkREdGFUaXo0TUdS?=
 =?utf-8?B?RGZUTGdkN3luU1R4WUxJS2IwWmRzUm9Ta0F5K2xXL3pLanFRWkpLMkRDdklP?=
 =?utf-8?B?UlNBNXA0bzhtQ3ZYVk9IWThDbjVoWjBjMC9ST0ZTYWdRUWpsTTI3aGw4V0NF?=
 =?utf-8?B?bWFITVByTVcvL0l1QURWeUJ2djdnMXp3M3Zzd0VBVGJ1SGFoZlN3OWlid3J2?=
 =?utf-8?B?SUVrRDBZUDlsUktXY3lZWS9WQWNHd3ZXcjRSK1NBSjFlRkhzV3J2cUZTc3lL?=
 =?utf-8?Q?3w/4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EOLZ5/MOUCTGpMnOBvgWLYRMg/MCCBoQKqBvYZkZ8w8DgYdwOCcQBrJ1floSqTYrhyGvGrNSqxondPjOaNVJ/7fqzRBoDseJmgjLSOLRMsv2RPpgXkF1sR83IifPCLiS/lHU4DtpsIlkiepb4nWDLixKitBTDv/tgB2p7egHVQ8feXPILlGE3RSyHFCA3Fqt1wwpk7T85lU1FoA422VUuguFHIFJ3czl6X+vILcxCQbE0s6qvhHqLTiJdfdhZ6OlPBcmF1D3IyKKqssKUVCuBW4PsTqvSG68ug7722j+k5E7qV9xXyITPDc3YqpigZ06ogitCCtTr/cKmko1vbQA/0KfJmq1fqYP1Saxag0gmTwLG2J62kUK5mHZg5sJxUmzuxnXN6Fw7/8cULZImF3PqxecJVARbVuyI7fJppJwO+iPhybBIRbbhe5l2XvGgqn/uxUMfvpj+8lLzeRkHf/NugkGhrLo4a8Tb0A3dBw4uaBm8BcxOt++rdCHnJS9ler7+vwONgfluoQ/GgrcnExZ9b7ZFlzmnWWo+jdekj44nsfVEKcLXO/kHhBrn47zldRXdojymoSZXE6z+9PJPpiF5JOv9HkONsIk0iom1LmrM9qq5nbr96QUa2xqCJnstyXQ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410a5c15-7cdb-405d-51dc-08dce3bcc46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 15:05:06.8652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJeYIEYNEjYbFPY6QZxR+xKV75NlllHOvUjXaaq+U37VWau4edFVYne9zWaqM57uxfIzphp4UxH4QKzjNNlcWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5193
X-Proofpoint-ORIG-GUID: DBByaGjmVP6O9-n31tvXnGiIUott3vG9
X-Proofpoint-GUID: DBByaGjmVP6O9-n31tvXnGiIUott3vG9
X-Sony-Outbound-GUID: DBByaGjmVP6O9-n31tvXnGiIUott3vG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBUaGUgdGVzdGluZyBlZmZvcnQgaXMgaW5jcmVhc2luZyB0aHJvdWdo
b3V0IHRoZSBjb21tdW5pdHkuDQo+IFRoZSB0ZXN0cyBhcmUgZ2VuZXJhbGx5IG1lcmdlZCBpbnRv
IHRoZSBzdWJzeXN0ZW0gdHJlZXMsDQo+IGFuZCBhcmUgb2YgcmVsYXRpdmVseSBuYXJyb3cgaW50
ZXJlc3QuIFRoZSBwYXRjaCB2b2x1bWUgb24NCj4gbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVs
Lm9yZyBtYWtlcyBpdCBoYXJkIHRvIGZvbGxvdw0KPiB0aGUgY2hhbmdlcyB0byB0aGUgZnJhbWV3
b3JrLCBhbmQgZGlzY3VzcyBwcm9wb3NhbHMuDQo+IA0KPiBDcmVhdGUgYSBuZXcgTUwgZm9yICJh
bGwiIG9mIGtzZWxmdGVzdHMgKHRlc3RzIGFuZCBmcmFtZXdvcmspLA0KPiByZXBsYWNpbmcgdGhl
IG9sZCBsaXN0LiBVc2UgdGhlIG9sZCBsaXN0IGZvciBmcmFtZXdvcmsgY2hhbmdlcw0KPiBvbmx5
LiBJdCB3b3VsZCBjYXVzZSBsZXNzIGNodXJuIHRvIGNyZWF0ZSBhIE1MIGZvciBqdXN0IHRoZQ0K
PiBmcmFtZXdvcmssIGJ1dCBJIHByZWZlciB0byB1c2UgdGhlIHNob3J0ZXIgbmFtZSBmb3IgdGhl
IGxpc3QNCj4gd2hpY2ggaGFzIG11Y2ggbW9yZSBwcmFjdGljYWwgdXNlLg0KDQpJJ20gbm90IGEg
ZmFuIG9mIHRoaXMgc3BsaXQuDQoNClRoZSBhcHByb2FjaCB0YWtlbiBzZWVtcyBsaWtlIGl0IHdv
dWxkIGNyZWF0ZSBhIGxvdCBvZiBjaHVybi4NCllvdSBoYXZlIDIga2luZHMgb2YgZGV2ZWxvcGVy
cyAtIGEpIGRldmVsb3BlcnMgb2YgdGhlIGZyYW1ld29yaw0KYW5kIGIpIGRldmVsb3BlcnMgb2Yg
dGhlIHRlc3RzIHRoZW1zZWx2ZXMuICBBcmUgeW91IHRyeWluZyB0byBzaGllbGQNCmZyYW1ld29y
ayBkZXZlbG9wZXJzIGZyb20gZGlzY3Vzc2lvbnMgYWJvdXQgdGVzdHMsIG9yIHRlc3QgZGV2ZWxv
cGVycw0KZnJvbSBkaXNjdXNzaW9ucyBhYm91dCB0aGUgZnJhbWV3b3JrPyAgSXQgc2VlbXMgbGlr
ZSBmcmFtZXdvcmsgZGV2ZWxvcGVycw0Kd291bGQgYmUgaW50ZXJlc3RlZCBpbiBzZWVpbmcgZGlz
Y3Vzc2lvbnMgYWJvdXQgdGVzdHMsIGFuZCB2aWNlLXZlcnNhLg0KDQpJJ20gbm90IHN1cmUgYSBu
ZXcgbGlzdCBpcyBuZWVkZWQsIGJ1dCBpZiB0aGUgZGlzY3Vzc2lvbiBuZWVkcyB0byBiZSBzcGxp
dCwNCkkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvICBjcmVhdGUgYSBuZXcgbGlzdCBmb3Ig
ZnJhbWV3b3JrLW9ubHkNCmRpc2N1c3Npb25zLCBhbmQgbGVhdmUgdGhlIG9sZCBsaXN0IGhhbmRs
aW5nIGFsbCAoYm90aCBmcmFtZXdvcmsgYW5kIHRlc3RzKS4NCg0KTGlrZSBtYXliZSBoYXZlIHRo
ZSBuZXcgbGlzdCBiZSBzb21ldGhpbmcgbGlrZSAibGludXgta3NlbGZ0ZXN0LWNvcmVAdmdlci5r
ZXJuZWwub3JnIj8NCiAtLSBUaW0NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFrdWIgS2ljaW5z
a2kgPGt1YmFAa2VybmVsLm9yZz4NCj4gLS0tDQo+IFBvc3RpbmcgYXMgYW4gUkZDIGJlY2F1c2Ug
d2UgbmVlZCB0byBjcmVhdGUgdGhlIG5ldyBNTC4NCj4gDQo+IENDOiBzaHVhaEBrZXJuZWwub3Jn
DQo+IENDOiBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnDQo+IENDOiB3b3JrZmxvd3NA
dmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgTUFJTlRBSU5FUlMgfCAxMiArKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
TUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCBjMjdmMzE5MDczN2YuLjlhMDNkYzFj
ODk3NCAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4g
QEAgLTEyNDAxLDYgKzEyNDAxLDE4IEBAIFM6CU1haW50YWluZWQNCj4gIFE6CWh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1rc2VsZnRlc3QvbGlzdC8NCj4gIFQ6CWdp
dCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc2h1YWgvbGlu
dXgta3NlbGZ0ZXN0LmdpdA0KPiAgRjoJRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3NlbGZ0ZXN0
Kg0KPiArRjoJdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0Lw0KPiArRjoJdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbGliLw0KPiArRjoJdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGli
Lm1rDQo+ICtGOgl0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9NYWtlZmlsZQ0KPiArRjoJdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvKi5zaA0KPiArRjoJdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvKi5o
DQo+ICsNCj4gK0tFUk5FTCBTRUxGVEVTVCBURVNUUw0KPiArTToJU2h1YWggS2hhbiA8c2h1YWhA
a2VybmVsLm9yZz4NCj4gK006CVNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+
DQo+ICtMOglsaW51eC1rc2VsZnRlc3QtYWxsQHZnZXIua2VybmVsLm9yZw0KPiArUzoJTWFpbnRh
aW5lZA0KPiAgRjoJdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvDQo+IA0KPiAgS0VSTkVMIFNNQjMg
U0VSVkVSIChLU01CRCkNCj4gLS0NCj4gMi40Ni4yDQo+IA0KDQo=

