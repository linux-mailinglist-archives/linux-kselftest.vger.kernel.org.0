Return-Path: <linux-kselftest+bounces-27418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F63A43858
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 09:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A218919C0E80
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CCE261588;
	Tue, 25 Feb 2025 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iPX4ozMX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G3uFsk+L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514526157A;
	Tue, 25 Feb 2025 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473712; cv=fail; b=TQAj8TmNTKKthhIzHJmDt5bsYJciRCRh2OUZdKkk0z0g80GPdWJeUwdrwM0rwV4ZJMvtTIA2O0pyYrvP7ASjM56crtkuWfg+k/weqegkcHviUarhn2fXK1wcILcjMp+/zTQKsdEEYPHL09du8kx4DwBnFRyW/P7GnoQ0xrX8hGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473712; c=relaxed/simple;
	bh=DwRBbP9H3wtmbZmrYQgi7gLiUtC4ieFm+5eeJVIbbcs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mr1Lnvl0BcIMjce5nYDgVTlljUbmtANc4e9iEb/h90bb7EqLHZVFq8NyIWOAjyWYaMTzYdKc9zDQqV3vPGi4nG31r7moGV+3DyzgzqSDMc9bV/HKX/1TBRopL+PVyaM081if+Yk3JW5LaPsQlUPYZ0OoODoV2gSaXboIRVBNw/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iPX4ozMX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G3uFsk+L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BplT002840;
	Tue, 25 Feb 2025 08:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ErvnVfbXhsBMmO3crh5CdMXJBYwVhJOYksZX/Kws74c=; b=
	iPX4ozMXFSLpBigH6U1Hde9C3PtBGkherk7hntaEoGNWt6FHzN52fTRUy5MLqY7U
	wBxER5D4tWbvX++1oJaCiQ+Gr83jGBcwppwjrcfwQ2hh2/MAgbLND0BKD/w97UiK
	DbzhSqndBYeb9q5r3eaAn1gh0oLeZF/Pf/8arwT51UDxtdJL37r4IMLGNzvAr32+
	wegWQBW1iCcC/g46mXb0THalUuMBC4w/bPru7B9BWrXzEgxt0UqzCLJ5JYnNXtsF
	WP2X5kN+MHwOFCwd26O3dBZjTMM99czboga45kKJ327lPIsIRaK4nF7KsCufSUYj
	U2WFp9b9Xv+knPfG004gTQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9cfdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 08:55:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7JRK0025310;
	Tue, 25 Feb 2025 08:55:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51fd499-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 08:55:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJDiCmRSWjdFTu1+p6FIKfVULJi5unLDO4e1VXk2lUGWHsir6M95AaQHArgHXueGtbztYOpvWEppeIfWFJoiIWJsww+ZMkVwYITtQSu0mPADD5hZfkudnlL9rbqfYr+TIoMm2wcocHXhoVIEX4RH2ROw3jwIYYkWeq5OVnRy+rGgYc3tyBTkBMZWI7V2EKEdTO7J0TbKQrdeZ2ugi6iw6UbTZ3uSmRxYQDdnotw73sdju2XMf/YLot50eWNcFzCP3Ry48Hf2XnVEwlFrGQiv6EHuPzpX9eM0eXzMtStErAdhMKwMQdhSh8MasA0gP2arLJ2qQoDiKB31lFoGKbNH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErvnVfbXhsBMmO3crh5CdMXJBYwVhJOYksZX/Kws74c=;
 b=eCN5+vs4kML5ylzG1nYTU7pcrRvbpwLg5lbNGvUYOTF95u1PM1c3JzbPciYpPX+IlCZlrEwWL0z8xDj9KQqRcl1Ice/uFRtes1C6vaVzWYXwxgvjtSJYE9XkDxVId57bSSu6saNBoIVPh11536S1dUMvc5AxwwfZVuFPn1DZZ/dlMW/i6UmwWIdRvLUPpUanLwa5PqBE23duGx+MSVLPBc1XmcVB57xw9gCthPdLnoFye19Wz1KYepjKpHpD7yM4FWXhVCKU1Nl4Ce8vih9j37wJoB9ehcKgWtb9V/+MPMSbZHOW3O1drBGpv2eCk6g8D40ubXffaqcDDp5P9BLqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErvnVfbXhsBMmO3crh5CdMXJBYwVhJOYksZX/Kws74c=;
 b=G3uFsk+LHi7KXV3talP9GVGyU+I8MMEvjkbtbMp7bfMwGgNnT/t4EpA/EpoxsYXlyUQjjdQNhJnpc872sg0LyFtK3jwxbcM6osE5PyM5FSpCK9cjhRn9o0sKNnMaMAFRpOKcLCsczGlSdcVDeGDIpTQO+MWeszqHQNgQCpNU+rs=
Received: from CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22)
 by IA0PR10MB7579.namprd10.prod.outlook.com (2603:10b6:208:493::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 08:54:59 +0000
Received: from CH3PR10MB7211.namprd10.prod.outlook.com
 ([fe80::4c63:cc47:6a4:e38e]) by CH3PR10MB7211.namprd10.prod.outlook.com
 ([fe80::4c63:cc47:6a4:e38e%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 08:54:59 +0000
Message-ID: <35a53d53-5144-4a3d-9f59-beb84835eb3b@oracle.com>
Date: Tue, 25 Feb 2025 14:24:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests: sched: skip cs_prctl_test for systems
 with core scheduling disabled
To: Chris Hyser <chris.hyser@oracle.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        "shuah@kernel.org"
 <shuah@kernel.org>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250221115750.631990-1-sinadin.shan@oracle.com>
 <20250221115750.631990-3-sinadin.shan@oracle.com>
 <ed7386c2-50f9-4fa0-8a94-fd67ae2bba4f@linux.ibm.com>
 <c5f8d593-e667-4b39-936b-21c5d92f7016@oracle.com>
 <SA2PR10MB47149CA0B28DBAC122A960E29BC02@SA2PR10MB4714.namprd10.prod.outlook.com>
Content-Language: en-US
From: Sinadin Shan <sinadin.shan@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <SA2PR10MB47149CA0B28DBAC122A960E29BC02@SA2PR10MB4714.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To CH3PR10MB7211.namprd10.prod.outlook.com
 (2603:10b6:610:125::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7211:EE_|IA0PR10MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 2838252a-66d7-4795-1c95-08dd557a153c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlZkTG9QMHMwN09QQmw4VHRPZFRUVE54VVVpU2U2dm82eHgrKzVpSjlwQkJC?=
 =?utf-8?B?ZGhHMnExR3VhdHdSMW5TbmVKWXgxTHhpenYwR29qWXJnMnNxSlMyTUQ1N1BJ?=
 =?utf-8?B?a1diVXFvaUZreFVTS0xFSHNEbTNNd2tkOXpUQVpFamNMS0pCYmorclRDeWs4?=
 =?utf-8?B?N0JQaFZrN2hxWmJUTFByUmhoUG5xb3pMSFdqTGNxTE9TUG9JdkZka29BdXMw?=
 =?utf-8?B?NVY0SkFRamlteENSQXZuVXRVYVlyTk5jY2szejNzSklwRDlPK2ExWkRDU251?=
 =?utf-8?B?U2tjUHpKMGtwdFFZMFlyWlY1czlRS0crdFRMVGhjVTEvMGduVmlibm5qVTFl?=
 =?utf-8?B?QmlmUWtJMHNZWEdkSk5ZUU5DYWFtaUZNNEx1S2REZlE4VVNRQ0w5UEhHTGRx?=
 =?utf-8?B?TWJhYit1ZTVxSHRNRXlYTWlISmpVUGJ2UEhMK0Jva0Z1eEZpSndldVdwUlI5?=
 =?utf-8?B?ZmhnMVQ4alRpODE4MGdIRjRQaWRlTlk4ZU5oY3czcCtURHBjT1RwbkpTbnBW?=
 =?utf-8?B?bkpYSGM4dXlXamxJTGlYWW5yQmdZYVZTNVpobWZ5STNCVE9oRThyQnh6MC9u?=
 =?utf-8?B?L2JDcnBXMlN2S3FJQUNKQXlobDRjWVIxME15SnN6RGM4NVJnTkVPMG9LZ3Jq?=
 =?utf-8?B?SnBqaUg1R1ZUZkR5b0h2WjU4S1FwcTlmajNQWGlseW1JTG1FM2hIMmJKQXMx?=
 =?utf-8?B?ejFYdUcwYjJLcktZVUZJVEszK2xwdDhVVUpmL2QrL2dpcFl2TzUrWlhpZThB?=
 =?utf-8?B?V2xJQThhVHM5dnpZNTFRdkRPRG5XSjAxTm8wNWRUNGtLdkk0ZWRXdzZ6Yzhz?=
 =?utf-8?B?NG9IOVJ1ZXc0Nkg3TzRJRVlLOWZYcmVVOVFHdnRvWkpJNGJjYUJWSXRHMXJj?=
 =?utf-8?B?NnZvNGhUSDAvZUpHeVZ2NEVoRjZGVGtrOG4waWdZak5hN09JZWMxSXdLSWZk?=
 =?utf-8?B?eG80S2VlQ09vL053aE4zMGdybmJHMVdMMGh1b1dDUXp5QUhkaFRnemRBMG91?=
 =?utf-8?B?cTc0bHMxakRmRDU5OVJMZWpLem82L3AwK3VXZnd3UmV4ZG5NY0NtVGMxSUxh?=
 =?utf-8?B?VzR0TkRBbHlkN0x5ZzFQbUMwcVFQdXpOWXFZUmN5T2dEbXBxRlF4Y1VFeVRU?=
 =?utf-8?B?alEydkZvNC8yQm5HM1E0YnBnZU84VkpZbmRUYVdwZFRoOXBGWXQ2eGltUXBZ?=
 =?utf-8?B?Mkl3L0RRVkVZNC9va2FHZ2F4QjFMZmJyL0k3R1Z0TGR2ZkVnNGo4M0JRMC9L?=
 =?utf-8?B?bjhoUTB0V3NnNDM0NVN1ZDdKWnFBN0NRTXJ6aVVFd3ROYXArUGtjM3laZ1hh?=
 =?utf-8?B?dkdaRlM4Tk1Cc3NVRGpjSU96bGVuVWdkZVV6d0VucERUMUtUZ3MwY1RlaWFB?=
 =?utf-8?B?Qk1hODhwNXVqM2t3L1kwM0hRSmpiK3hkbGJYUHA2SVlhVGdmZTBCYmU2RU1B?=
 =?utf-8?B?R1RBV1M3UVNISkJzaGtTNWFVRGN2czBCRHdvRU1SVG1kSWg3WHBkZnl5YnBB?=
 =?utf-8?B?ODVZclJVVFlDREhIS29KNHpTeFZtMkZXK1lIdEp0aUxLRHpYY3hVNVJmR3lR?=
 =?utf-8?B?UXdtRzBXUXgzWUorR0Y5UmZXVFBxSVVMWFRxamZiZTEwd1VjT1VoZFk4TWpV?=
 =?utf-8?B?eFNZUXdyVy9lbGdjU000NVJFRkpVQ3p0bzZva09vUEh1a2hOZzVBYXZjZ0lp?=
 =?utf-8?B?YjhTQXlOd21Gbzg3UDRjZWV0NDByemZoOEgvUXlmeDdhU09LcVZmNXRnQVNE?=
 =?utf-8?B?M2xjd0tOMWpLTmUza3FsQ25Kcmt6bldyVW56NlVxV3F2cGtyUXJ4UVpqV0Iv?=
 =?utf-8?B?c0RHWlJXOC9Ga1NFUTlSYmRzRFhuZEcxK2owcFBFU3pYVi9YQlMzKytGTS85?=
 =?utf-8?Q?C2ylxXuFhb7i3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7211.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3pxeDRMa2xRTzdGMDJJc2JRK2dTZGpKZmtPalRHcS9ZbC9NcG1pMGx3M216?=
 =?utf-8?B?ZWdMRUo3K1VodGNlcHdDT3ZSU3NrVjR0Z2QzOTVybDI5QzI3QUNHUjhFMzZZ?=
 =?utf-8?B?YXZQc3h0QmFld0tEWmtxQ3RPbHF4bDZvWlBiWDlXNnlrOHhLcmU4ZUFWakNr?=
 =?utf-8?B?dDV4UTE2ZXNicDhGakoxQUZmY0tJdDlnMi9NSmZNd1lCVnNyVGRSWkpud2ZL?=
 =?utf-8?B?RXNuNTRzcUhtNjR4K0ZwWmlPSGlkNml3WEsxTDlldzRIS0xLNFkyRWd6UW9F?=
 =?utf-8?B?QXUrTDREaHFyWWdMMHBOaW1zblBnZjduSjRyc1huanVnNC96RTI0T2VFYlp1?=
 =?utf-8?B?ejIzNnlDbHRoZ3JjNEZrS0tPZWlLYkRvK00xS2Y4YXNzNHpyT1BacE9SWHNW?=
 =?utf-8?B?TmdMaHFwTjBjZk9vbTV3SEtoamFWS1dqMTVVSnNQeGk5YXhNcEgrR1Q4SUZL?=
 =?utf-8?B?TWcxYy9yMVovSDU4ZlBScHdPUlgwQk14OUpIYUdwRy9uQ1hLb1lGSy8veTJV?=
 =?utf-8?B?UC82YWVLQm56Yk41Ni95dUJVc1NXRlZEMUVrOEh4U2pxYnNxLzg5aWJFVWNH?=
 =?utf-8?B?TDhTZXExNzFVMGhuY1h1R1MrVHB0eWhmYkZ5RVQzN08zSFh5SkdSalpZQWpE?=
 =?utf-8?B?UG1Ga0J3VjlEM2wvMXBFZEUzK0dvZ1crUTM3Yno5K1lxaVVDSFJDSFQ2Q2dk?=
 =?utf-8?B?VTdlclJoN1FRQ3MvSDZSYVhuTWJpNU8rbE15SUtobGtKb205WWRKdlRxZWk0?=
 =?utf-8?B?VUNxMnU3NUJUeUM0b1JaaC8xb2FMTG1Vcm9qMXcwWEp2eElvaEpsWTVZYXhE?=
 =?utf-8?B?WTRQR21Yc1FVUkVYZGFSN2RTOUtxQ3ZxcjIwcHN4dnVxdkkwMHVuVXpTZDFu?=
 =?utf-8?B?eVdWRnV0N09kWlJiYUIybGEzR0RGNjJjWUdQdFRoWEtWdkVYK3JxNkJPaDNn?=
 =?utf-8?B?N1Qxa2xBYWVKaWFORElFcG5SZlBsVysxZ1QxaE1PaERPT1haRHRleVFWWEo3?=
 =?utf-8?B?YWNRWFJFeXB5ZUNiRWllbk5EaStNTGw3dS9VM3lXOEkvSlBYdW1YbERPQXJT?=
 =?utf-8?B?ZkVKSEQ2MVc2Q2JPT0g3ZjhMQzljNk4zL0JxVVh0MkpoVm1LNDZuM2sxeHNI?=
 =?utf-8?B?Nzd2TzMwcEFOZUs0Z01oUVJSRXBkZWZTS1NYOVNoRjZ2M1Y3TGM5bHZMU1Bs?=
 =?utf-8?B?Q0JNMGhzNm5KT2t6WVhxc29XZ0lhdHoxbHRPUVdrZVdTZlRTakttUGZ3UWVS?=
 =?utf-8?B?Y2Y0SkRnT0lkVit0UEkzUjcwSlZBcjFGdXA0ZXpGcXhmVUExVHVWRHhjUmF6?=
 =?utf-8?B?YVhUT2JjUlFYencrYW9zeXYxTThsekNnREhveGVzQ1M0NUdGcnRHTmVtdjFI?=
 =?utf-8?B?U0FMTWRoZnpPTXVHZHlxNTE0SVlrWk9MM3NSM2VGbTVwRW5OT1hrSEpYTlVI?=
 =?utf-8?B?dGxsMkVpY0RqZTIwOWFvMFRDKzlQa1NVWEhZNzZVOHhPc3kvOXhidlNUWjdq?=
 =?utf-8?B?RDBPaG0rQ0JGb2I0NUx0am9idkJqcVNyYTV4ZVRkSTFBR0pCRklyOXB5MEwy?=
 =?utf-8?B?K2RwYUU3a2xMSEEvaEx3RlA3N3ZaU2tUOUdNU3lxS1hpNzZBV1RZdHdpOWRP?=
 =?utf-8?B?SWRTUWVBRmsrNjFqMFN1Vms2NThzeDNRSGtVRmpPVUVEK2VLdUU3ZVRIM3dD?=
 =?utf-8?B?K1ZQejgxS1h6ZGhQa0gxclV4SUFzckl2OTdCM0xzbHladk9CeW9QcExTOFVV?=
 =?utf-8?B?ODl2TmU4cU9qdEFoeFpyWWZSYUlpUlhWZDJvT0crR1gwdm1Wd1REY1ltMG1y?=
 =?utf-8?B?RERlZlVOZVI2ZVFHT3VRalFaTVNpNUUzTkZEZkh0amJNOGpRUTNOV1ZtWmdB?=
 =?utf-8?B?aXU4SGNCUzdGcDV0dm03M3V5QTJPcURnaEdvR2Z3ZmVmS3o0dFU3VmZ2UTky?=
 =?utf-8?B?TzBkQWlWNG9nK1dTaTJ2ZGJrdnBpdThVLzI0eFZ2TldyTUdOK1hSa1VRZGcw?=
 =?utf-8?B?NHJkZXRsT1ZFTGhDalZtNzc2UWdKSWF6RWdWeHNGV2dVSkI1VVZjOHlEUVlZ?=
 =?utf-8?B?QW9hWi90YjlaNVZsbENtWm0vVDI2ZXdvT0IxMnJRNWlFL0hqZWF6RzhHMDJp?=
 =?utf-8?Q?aI0N2CSmtoO3E/QbiZ4YeneBW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qt0k4CmCzWFl9nubJL9tEg1+uLwm/KY2K/g2LfPiuFCPy4/ZSQbyuYIJc0orVTTi7c4lk3IyiA9vrZg3D1Pz7Iv0DoMGucXp9gXKrSGN7xzBhWAegt4P99GVhlXevO9zcOhAL3+wG0edq9PRJ2BPc5wS0ljlKU+Prw60H7lrDeeG/OmZIgdfvH0mDGjPtyFLq4tQNzlgoFpoO7esfAJXeJcDzQJg1p5Fa0AXdGjKLF2EjdA3Z9LjCTNcmFg4ch3QLaDVfBIIeH83R9DTLqDGxp75za/HaW413NwEdW+MhZagrigbdFL0ZPWYAdOl74ynfMkBTwjT/CiTWpSGD51+z3/jpNNSqoygUIbAZ2rIK1s/Bhxa9E7HrJAn/J/CpqlPy9axMx4Nuw9huESF7pVG7jBSlBigTWCr6wz5g7VyiGori/EEIqC17BoYaWtY6w/Whum9X3xOFOREAGKuKzgs9+ilfTG1DTbTOSZz8BRPyNq14xo9Jvez9J/pIOQR5DxNfNcVCPxJuDHO6zerF46XbDKvKUWymq1MBqF1zNErjAXwtNR8DJrPgOmWihc7Gpu6B0vYVYNd0KwmZgKZssr/HxnojnVs7sCWxRgWftyF6WI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2838252a-66d7-4795-1c95-08dd557a153c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7211.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:54:59.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9thrhVHNi6reVLxfLTrEVBN+dPVy36BuX81bA892uOEewFRU3jhPqvuWJV3pyKyS33m1GtjQ8IHbAxpbhe5f2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250060
X-Proofpoint-GUID: UuchcZ8dUVh9lPr7jv6YeANme3xoSusU
X-Proofpoint-ORIG-GUID: UuchcZ8dUVh9lPr7jv6YeANme3xoSusU



On 25-02-2025 04:32 am, Chris Hyser wrote:
>> From: Sinadin Shan <sinadin.shan@oracle.com>
>> Sent: Monday, February 24, 2025 7:10 AM
>> To: Shrikanth Hegde; shuah@kernel.org
>> Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; Chris Hyser
>> Subject: Re: [PATCH v2 2/2] selftests: sched: skip cs_prctl_test for systems with core scheduling disabled
>>
>> On 24-02-2025 01:49 pm, Shrikanth Hegde wrote:
> ...
>>> If the self-tests are to be used in development flow, these checks may
>>> not be sufficient.
>>
>> Right, this particular case was overlooked. To handle this, the test
>> could take a path to the custom config as an argument. I shall work on
>> getting this fixed.
> 
> I was thinking something along the lines of just calling the prctl.
> 
> If you call it and SCHED_CORE is not configured, you will get an EINVAL. Unfortunately,
> passing other bad values in the other prctl args will also give an EINVAL, but if you call it with a
> non-existent PID (say max_pid + 1) it will generate an ESRCH if the code is present.
> 
> So something like (and I'd look up the maxpid on the actual system):
> 
> int check_core_sched()
> {
>          ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, 32769, PIDTYPE_PID,
>                           (unsigned long)&cookie);
> 
>          printf("ret = %d\n", ret);
>          perror("Error:\n");
> }
> 

Thanks for the suggestion Chris, this indeed would be a better method 
and also fit in well with the development workflow. I'll give this a try 
and send out the updated patch soon.

Regards,
Shan

> -chrish


