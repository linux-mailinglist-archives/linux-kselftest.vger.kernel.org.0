Return-Path: <linux-kselftest+bounces-20665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C43419B03AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 15:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FB61C22187
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E98231CB2;
	Fri, 25 Oct 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CMyj3DCM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="In3AJ3k8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595B1D2B10
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862101; cv=fail; b=idKYdVOdwMq9VD9ndj3XcK96mtT7+vgG6VuSjVyuKtbyI/hhDt6pLd795MSftXnkfiTHuNQEPZZTKMd8fFpjpK3RLpJmcnbjy+5xwtlNPeZoTb2XxkOud2aHKlj0M5uG8jfR+JPkpOSxcqUJiPFLxeTkby8S1CKFonCxESV0vHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862101; c=relaxed/simple;
	bh=FrabgcJy1VgmV03vj2mehwVc7Xzta2+7iH3TVeiQQrA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oRYLOBQtVpbawlP44Tu8S9ZH8NDm2jQ0R5IJgOci1QFASPZ7FaZI/jUqzpzzyRS1HKsrl1UOAKLsPbsqudReBBWdYcaXXPK1Ki+6UVfoB5EPq7of9DhW5Z5EfhL2WlqIUitj6StcSfZFavV2GBvyKx6sSLpqlbbJwt4vxlC3lT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CMyj3DCM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=In3AJ3k8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCU7p1000335;
	Fri, 25 Oct 2024 13:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZK/RCpHyKMrY2K9Qj3W5VxZ1/8ytYcjsxH7TE39bY3o=; b=
	CMyj3DCMIKg9Xz7OyuC++NwjP5FdZ87zLIMFNl2ensjFx7GoOkWkiiuR8SgcMZuf
	eceofbisNjxjvkhrxIfdZi1yJXC7xGP33cYi1TZJwOMsv1+TE1UYg9fi2c8pATlD
	3GZJMofgHliHbYfnjv1CEbCXys0QvQrIrVfYsC+eBg2Dfgpxuf6MwODAm6tKWUBb
	SHZTSKpitvDW2FOQEkAT4bc17lasJl1cg/GTYQMhYH2JPy8kkm9iT2GCsVE7MmCh
	f6W4DWAIifvKiKtq1Aoffu15sKG9YhDGaLJ3wNAT8aWobJEStXEF12ZywQac4ox6
	72pvgYxbIrwxmrv9jZPaqw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvwy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:14:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PC7Uvs015769;
	Fri, 25 Oct 2024 13:14:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emhc978h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:14:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lj5YGOGPPLR3bRHvSCrlY9uJmzZ1HTdF9S7Q7NoHQpdevPR8g6IeU/XOT8PgnuClWxnLGuP6E3UTmxmyxW/RbOkdLDiTc8gzrn7e2INzb/ghJYaFU0gI5ddHJ2FqjTcKbd2hSVRpUHVuZMLq9yfVog6h16mcIS6MbWH3TAvdMfY5hGPYlrelL+o0AsYLMkSSyH3j70APb36vmbn9ss0xF7eGPA2K8oDQq6yGf3CwYRIFczZ7MbWQGBcRYX5L4MG5fzJpqUHVyNa9YnjqnJnxHJn84lD22cQZ38vCR3qv4TOJJUIcXeMxTQpWYnpuzagA4HrUSawht+pZAIy7yIi2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK/RCpHyKMrY2K9Qj3W5VxZ1/8ytYcjsxH7TE39bY3o=;
 b=miBiV8hRo9P6oPRQmFMMkV70xzEMrLBHE1LqpMuLIIYUyJhtMaRWfpqm2ec1Lj9zJA2SxxI8FrggeK3DEOBtZZ80YAV5ZDHUkjVPeJnLWUGoDbA7pQMiZT3Tj4xwI+cS4u6XDg2CrfMF2JCSvNzugvfSbrCnG0JpqIqjWJYJJxV3zTtYxtH2wc8Vp2sCRmgv659HHvxkT9t5lFn7o/903zAL0PA1fw98CWGE/hTirDVj4SfHrC1Q9HCS4HEa9/H24GfZUNPlO4MdPe9q47uSgsKB49Mn2H4lim0mL97FpJCmG98d19M/sWao5+Ao7Dyk1WNIvdV6eN8sKvyg+9bNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK/RCpHyKMrY2K9Qj3W5VxZ1/8ytYcjsxH7TE39bY3o=;
 b=In3AJ3k8Q7SYK1XoJOVH8woxj8m585ugOFbsNdxB9rR+Na9So/QFve9cMRSfzHA8BnT0M5trXXJGjQtYyLuR8w4llzEK7AvgsJiRhTcjVrs0r8msHlnnFJBMdcL+yRDUQ5ppiYC+qyYVjHbq4r79RTCin3RX6nL60GwSbu5SvGs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB5947.namprd10.prod.outlook.com (2603:10b6:208:3d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 13:14:47 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:14:47 +0000
Message-ID: <e9d513bf-3e6d-45c3-be10-443f7c8b07da@oracle.com>
Date: Fri, 25 Oct 2024 09:14:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 9/9] iommufd: map file selftest
To: linux-kselftest@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:408:f8::25) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 4710c53a-5290-4e5c-005b-08dcf4f6ff9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzZTeGwxdE52dnNEcElpbnZjOTlnSUg0dUkxRld3ZHlldE5INkZXenBZait6?=
 =?utf-8?B?YkNIUEl0SDBzbkVqUHpHUkVBZkdJOXQxQkQ0YzJtanNTcVlzRzZmMEg4dG85?=
 =?utf-8?B?Y0RvVm9lVzZPMWNrRUhUSUpsRTRXZzZJUlNzQ1ppcmtyMFRkMnhNalQvSUQv?=
 =?utf-8?B?b0lEbzh2VktDcWhrcUN0SWZWc3M4MXBLZ0lWUEZaY2JuZUtMKyt0N2p3eDVX?=
 =?utf-8?B?eTVQTDBTR21lU0VwME5vL2RQMFJnSSt5TGdTQVNNQ0RQTGtPQkJwSDYyUFdS?=
 =?utf-8?B?WFRmSUN4M28rdmN5VUJZWkxpWUptSFRTa3hFZU02aTBRaTJDeXVlZnZ0ZDhL?=
 =?utf-8?B?SnY2dDl0ZXBDODdNVzAvUHdROHRwRFhVcG4vUmE1QmpvSjdqUlhOQ2dySjJI?=
 =?utf-8?B?OHppT1hBQzJ1dklibWxnekxSZ041Q09neStkbHQ4L211Rlo2dFZncUt0OFJI?=
 =?utf-8?B?YXpUZW5IV1hNV25LTTJTV29NaStNZnJWOXhNYVRrNWU5NWx3MnEraHBiWDJP?=
 =?utf-8?B?SmNKWWxBTUd6RWs4MDZ4UXpvVzY5RGwrdGJJY3F5clBlRGRqbE5wdncrbmJk?=
 =?utf-8?B?VllJU0lxVFdjZDN6R2dQbi82WEk5REN3Sk5ENnBOUHg0bTIxTVBDWUZhM1F6?=
 =?utf-8?B?WmhRRW5Sb3hlZzVxaEFyRVhpUk13Kzd5R3JrWTVaOFRiYS9VL1o1eERXaVZB?=
 =?utf-8?B?Y1dyWnBNK3Rmcm1KWEg1dWh3V0x6cmVyb2VHRmlzcmlpUW9Ia3RKOG0vUkZX?=
 =?utf-8?B?NjQwS3MxTzRDaDRNMUg5ZEYrWGg0cEd0T0RZZEVRMzgzUkNLWnNndEZQSHMx?=
 =?utf-8?B?VklQZlRyU1dlL0hnMmh2Q081eVdNUGJHeE9VeVlmRnZPK1pQS1UvL1NMUWUy?=
 =?utf-8?B?YnhWc0ZWSFlGR3g4YXhqV3ZIT1NUbU4zc1ovVExXbEszOHlDS1VXNXNBa0pJ?=
 =?utf-8?B?eVFNbE4yQXcrN1grYkRwQll0VHJVNjJKcTdkckNOTGhBSm5rOFdFSGVobHk5?=
 =?utf-8?B?bFNUWWNVeHdZRkNoZjNVbTBOY0pYNjN1RTRybDZUcWRsK0F1eGVpOGx6ejFq?=
 =?utf-8?B?bDZYZmZGaU9RSnB0L0VZdVNRU0p0NUlZc2NlOGhFQkR5ZzIya0Vuc2RMSjBP?=
 =?utf-8?B?Y1NrNEVscGpCKzQ2Zk5FemIvT054TnVqUFp6c0pMemFkMzRNZG5VSmc3LzN2?=
 =?utf-8?B?bTI3amR4OXViMTUxWGd5RFdDdzd5YThNNWxsSXdJcWxka2NwOFpxbDY3dUhl?=
 =?utf-8?B?R2FNczgrTy9yWTIrdm9uRitGVjNEN3Z6V0QvS290NmtqUDdzWWY2QjNjN2ZL?=
 =?utf-8?B?TXRpQ2pZdEx6Zk5ObDk4b2lSSk13MmxIZ2ZlMEVaK0VoTWdSRGdLUjA4WjUw?=
 =?utf-8?B?NjlXcjAvODBmNGdxUEVRK2hDVnAyOUk4Q1FGUUZ5TzZGYTFaOW5lY1pDRzNY?=
 =?utf-8?B?USsrYmlBZ1I1WTJubnJ0T0F2bnVVc3J3MjhJSnNBOEx0NVZGMEwzcVBwWU5T?=
 =?utf-8?B?Lzh2cnFlRVY5NUNUREorNmdqZjJ2TVdzOEhLNmpkSGlUaE1KTk1Ha1JFRWpo?=
 =?utf-8?B?TDUrVStIMDNCa2JnNWlyS2J4eVJCT01sUWhPR0lFK2JqOGdqMlUxaFBUWDlX?=
 =?utf-8?B?MzNNVHdkVVJsWVBHdEtwaXNDZEw5ek5uQnRwbDQvQTlEdnBNNUFLL0Urbm5C?=
 =?utf-8?B?RFRKY0pKb3BDc3Awa1ZEK21BbU4wYy9QeGVpUk1oV0hSejZSSFRDME1rWEJv?=
 =?utf-8?Q?cHCHMeesR5a8Qybt+W3dNerPnmwL0Wh1fHBLnRM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eS9VNUsyWTRYOHlBUUZYOVJnYWpySmhMT3RsNC9IRHZEaE8vR1BWSzRhOUZS?=
 =?utf-8?B?NnlPeE1oanVtbUIvU0o2bm1yNm9wZjhleEJ1VnpnRE00azhCVGFGZjR1QmxS?=
 =?utf-8?B?TUQ0QjNJN2tGTm44S0RBcjFoVnE5ZHlidlNGK2lzK0YwZU1sMkEwczdZRCtD?=
 =?utf-8?B?ZjJqNlNObWFBdTJYU2l1ZXBKMS9Rb0hta2ppQ0ZHVE0yMWFKcDZQdFdncDNt?=
 =?utf-8?B?UGVWSytwa1kxQzZjOS9TaW1UT2I4bG00YTQrMGc2UE0wUk5oT3lwTDJDQnVu?=
 =?utf-8?B?WmNpRmExZExkMjlCSjM1bFRpVUdlOGtFNHhoRzdIV0Z6OXNsc1UycXhWbmly?=
 =?utf-8?B?NkFJY3E0aHdEcHd4T3FwV2NoRmZyMWtmMVB6Y2RQak5sdDFNVS9LMENnbGV2?=
 =?utf-8?B?c3FEUjhDY2ErZi9ETDVmak02SDVLTDZLUG4xc1BqOXpoM0RJVTl3Z0hVUGtx?=
 =?utf-8?B?OWxzZXRZRGpGNjRQa0xwV2tJM2xidEE2cXp3SUVLakRWSityTGVOem0zb2xw?=
 =?utf-8?B?NVN5QWpDWUVaNW1NY3VZZUVBL1p1ZjRSc2VKVkN1NG9UUHZveFpvZ0pNMjRK?=
 =?utf-8?B?Z0VvazNFS3Z3MGkyUnpDS283OWR4M0VQc2dVbWNzSjRCbXA4VlhEUWcydVFO?=
 =?utf-8?B?WWlraXJxeHhLTEx5enpkUlRscTdhcHVaNG1xVzdPdE00NFRxVU5Mb3dKRENa?=
 =?utf-8?B?SklCRTBMbDBDQ1NMRHlhZlM1OHBGU0N2Yng0V3huU0ZHbWtVMkQxS01nbGly?=
 =?utf-8?B?NzZETFRvNnN4cWFJOVNiTE55UlduQmlQSUR4WVRVeXRxRjJwT1ZoSXFyWnJn?=
 =?utf-8?B?blZyS2dvcCtVWjFEZUtTTThyMHEzK2xqZlUvN1VyTmJjS25OQVBLN0RWZHJI?=
 =?utf-8?B?OExjT1NDOEdBYmUwalRWWkxPR1dtV25NRkpQT0czejNrSXcwbXVnVURUUjV0?=
 =?utf-8?B?TnFXMlZ6WjZTSUtlbnRRVmFGQmVsNWlsRnpzcVRrYTJFQWpYK3BGekFraHA2?=
 =?utf-8?B?bUNEWXFOVEF4ejF1SDI1NkFNZHhpQllDczg2NmhsU0E1WmplVmM4anZpaVVP?=
 =?utf-8?B?a3YvRUQwWitTQjN1UUFxaHptR0JGRUwyeDNnellIZkdLWjczRC8xMkFOMFVJ?=
 =?utf-8?B?UFhDM3FPNFR0UnFLRnRraTVpTVdLekErZ0lQV2pHcU5ZaVJtSG5oQlBZSW4y?=
 =?utf-8?B?ZlVWUk1mUlRBaE9aajR2NDVFaWtWVlNXUVZHWFBXMlQ0R0FKOTR3QlROYUM4?=
 =?utf-8?B?Tm9vd0toRFJjeHVmQjkwbmx3amhORC9zeGJHT20yK3BFRER2QnFQayt5b293?=
 =?utf-8?B?OW5haGlTaUdkaFh0NnM0WEczOS92VWhaQnIvd0ZRUWl3UzF4cUhSS0hCV0Y0?=
 =?utf-8?B?ZjViL1RjV0lnMEJQMlRnMy9ObU5tbzYySTZ6OUdMV3g4WkhPdnVwYm92LzhR?=
 =?utf-8?B?OEVsV2E3QXFDWnVuVStzTCt3cFBRWWtoSFRGZVF5YXVCYUpOTWpYbDk5SFlu?=
 =?utf-8?B?S2w0NUVvbUlhY2NlemdsYnI0MjVVZjN1RGV5c1JYKzUyQVZ5TG9yNWhTclhH?=
 =?utf-8?B?VnRQNTU1dXFSNVNJeFFjL1BXQUdDdWxwbjBUdDBzRUp4RjV0UUZmR1V1d0g0?=
 =?utf-8?B?S0ZIdDVvY3ltaDB3UnM3aWVSTHdIb3JmeWNUQXBXbnRlV0R2a0ZSeDZFOXdB?=
 =?utf-8?B?a29oaVBQLzZDQ01WcEJLRTc0WFpIcThlMm9Ga2sxRmR2d3U5Z3dQd3VyaHFs?=
 =?utf-8?B?VWd0YllMSlpRQ0szZnRBaElzc09oVi8xbEtFRlJUdGl1WGRlRExVNUZZVUkv?=
 =?utf-8?B?WWp2UzR3OVdkN0FremIyT2lVTWhacTUvdGtLa041QlBlaVkyK014TUFFSW43?=
 =?utf-8?B?VGxOd2NlNFNCVlNTelVMeWw4c1JxYklCbHg5SCtPdWlqZHpaaldtbGdPdDlP?=
 =?utf-8?B?Q0tRTEdQeEtjZVdkWm1ieEJJSEhHWGRWYTJHbjVBQVpOcGJNOTdLRTBGeGlG?=
 =?utf-8?B?Rm5mVEdURkxWWHFNQmtITitXck11dTRJM05wTmhtVVorUWQ4eTd1SXQ4djMx?=
 =?utf-8?B?Y2xxUzV3b01wRnhPZ3ZBTXVTZGFERjVrandBQXRZNk1nWCtDWkVCQVV2bGFF?=
 =?utf-8?B?TmVjVHJsY3p0QWpIM044eGZJSjQxMU4vVDBESEVMQitlV2czaTJKZlJINHZy?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EuSyqLEyws1fipi9fB0IOLi+IQSt5XZLyz5iNr6UyfV4nsUjXhc1EgddL3KJRbA3dqd9ilDzrPesCq+EKWvGArbOEFrBwfyiZIq+FSHr90piXK1ZdaXlxp81v4ucO+u80ZE1o+fep1zrO6lZYbZpXWHnfcgIafrOpaFAGPBRs2ypSGpHz3bs80ySDhGVLgH6lQ5jHw7lQjf6HxeDFnUSHK0oprJeyjThpCMwMWEWeqmJaKVjfulfvmpYu/6Yy3CGovrBF6cg8xejqEvoAYOEIrsSCAsbMBsfVJD0Jbasj+CmZrVkgcJ+o4KE8k/rT836JFFTKdEtpItkMPDOCToHksgXKbQn2NfY6UBkIrB8Zq0vLy3u7lTefO9YuAN01/UCZHpVZLVM7mXOhV95Kq2sUwZ+J2sh8LOdFrVgbAtMedbGTRMZZ6Ns7nKZsjRI3f4Z9pesp9EPVnNYia9sKWEOgcwk6YYZWDaFI6IRShMz7hKtrXbCdADxbMuD43ZgHZg96UJXKHa5/OCxZtNzbAP0sHDyWeJ3L7wOMgYgmdZL+VCMd2RxbrHz+43F5yrW0fpA8Nk/sumE3pyA76xXgYGjxeuYNcBWqIiNDBR715Kfd3E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4710c53a-5290-4e5c-005b-08dcf4f6ff9d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:14:46.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09cOYNjoGIu6y6C06xegwUtnUqQuZLo+l/kP2prSHoq5JD3GXxFnKCaDg6iXIj9lgnEu5nXWuJlN7NbSszFdEVxXAtl/LlKIah6eCyG6xFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250102
X-Proofpoint-GUID: ZgcEQxqeVXq0pYFpuI3EqRuYBI7YLzi3
X-Proofpoint-ORIG-GUID: ZgcEQxqeVXq0pYFpuI3EqRuYBI7YLzi3

cc linux-selftest

- Steve

On 10/25/2024 9:11 AM, Steve Sistare wrote:
> Add test cases to exercise IOMMU_IOAS_MAP_FILE.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   tools/testing/selftests/iommu/iommufd.c          | 124 ++++++++++++++++++++---
>   tools/testing/selftests/iommu/iommufd_fail_nth.c |  39 +++++++
>   tools/testing/selftests/iommu/iommufd_utils.h    |  57 +++++++++++
>   3 files changed, 205 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index 4927b9a..88b92bb 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES */
> +#include <asm/unistd.h>
>   #include <stdlib.h>
>   #include <sys/mman.h>
>   #include <sys/eventfd.h>
> @@ -49,6 +50,9 @@ static __attribute__((constructor)) void setup_sizes(void)
>   	vrc = mmap(buffer, BUFFER_SIZE, PROT_READ | PROT_WRITE,
>   		   MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>   	assert(vrc == buffer);
> +
> +	mfd_buffer = memfd_mmap(BUFFER_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
> +				&mfd);
>   }
>   
>   FIXTURE(iommufd)
> @@ -128,6 +132,7 @@ static __attribute__((constructor)) void setup_sizes(void)
>   	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP, length);
>   	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
>   	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
> +	TEST_LENGTH(iommu_ioas_map_file, IOMMU_IOAS_MAP_FILE, iova);
>   #undef TEST_LENGTH
>   }
>   
> @@ -1372,6 +1377,7 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   {
>   	unsigned int mock_domains;
>   	bool hugepages;
> +	bool file;
>   };
>   
>   FIXTURE_SETUP(iommufd_mock_domain)
> @@ -1410,26 +1416,45 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   {
>   	.mock_domains = 1,
>   	.hugepages = false,
> +	.file = false,
>   };
>   
>   FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains)
>   {
>   	.mock_domains = 2,
>   	.hugepages = false,
> +	.file = false,
>   };
>   
>   FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_hugepage)
>   {
>   	.mock_domains = 1,
>   	.hugepages = true,
> +	.file = false,
>   };
>   
>   FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains_hugepage)
>   {
>   	.mock_domains = 2,
>   	.hugepages = true,
> +	.file = false,
>   };
>   
> +FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_file)
> +{
> +	.mock_domains = 1,
> +	.hugepages = false,
> +	.file = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_file_hugepage)
> +{
> +	.mock_domains = 1,
> +	.hugepages = true,
> +	.file = true,
> +};
> +
> +
>   /* Have the kernel check that the user pages made it to the iommu_domain */
>   #define check_mock_iova(_ptr, _iova, _length)                                \
>   	({                                                                   \
> @@ -1455,7 +1480,10 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   		}                                                            \
>   	})
>   
> -TEST_F(iommufd_mock_domain, basic)
> +static void
> +test_basic_mmap(struct __test_metadata *_metadata,
> +		struct _test_data_iommufd_mock_domain *self,
> +		const struct _fixture_variant_iommufd_mock_domain *variant)
>   {
>   	size_t buf_size = self->mmap_buf_size;
>   	uint8_t *buf;
> @@ -1478,6 +1506,40 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	test_err_ioctl_ioas_map(EFAULT, buf, buf_size, &iova);
>   }
>   
> +static void
> +test_basic_file(struct __test_metadata *_metadata,
> +		struct _test_data_iommufd_mock_domain *self,
> +		const struct _fixture_variant_iommufd_mock_domain *variant)
> +{
> +	size_t buf_size = self->mmap_buf_size;
> +	uint8_t *buf;
> +	__u64 iova;
> +	int mfd_tmp;
> +	int prot = PROT_READ | PROT_WRITE;
> +
> +	/* Simple one page map */
> +	test_ioctl_ioas_map_file(mfd, 0, PAGE_SIZE, &iova);
> +	check_mock_iova(mfd_buffer, iova, PAGE_SIZE);
> +
> +	buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd_tmp);
> +	ASSERT_NE(MAP_FAILED, buf);
> +
> +	test_err_ioctl_ioas_map_file(EINVAL, mfd_tmp, 0, buf_size + 1, &iova);
> +
> +	ASSERT_EQ(0, ftruncate(mfd_tmp, 0));
> +	test_err_ioctl_ioas_map_file(EINVAL, mfd_tmp, 0, buf_size, &iova);
> +
> +	close(mfd_tmp);
> +}
> +
> +TEST_F(iommufd_mock_domain, basic)
> +{
> +	if (variant->file)
> +		test_basic_file(_metadata, self, variant);
> +	else
> +		test_basic_mmap(_metadata, self, variant);
> +}
> +
>   TEST_F(iommufd_mock_domain, ro_unshare)
>   {
>   	uint8_t *buf;
> @@ -1513,9 +1575,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	unsigned int start;
>   	unsigned int end;
>   	uint8_t *buf;
> +	int prot = PROT_READ | PROT_WRITE;
> +	int mfd;
>   
> -	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
> -		   0);
> +	if (variant->file)
> +		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
> +	else
> +		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
>   	ASSERT_NE(MAP_FAILED, buf);
>   	check_refs(buf, buf_size, 0);
>   
> @@ -1532,7 +1598,12 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			size_t length = end - start;
>   			__u64 iova;
>   
> -			test_ioctl_ioas_map(buf + start, length, &iova);
> +			if (variant->file) {
> +				test_ioctl_ioas_map_file(mfd, start, length,
> +							 &iova);
> +			} else {
> +				test_ioctl_ioas_map(buf + start, length, &iova);
> +			}
>   			check_mock_iova(buf + start, iova, length);
>   			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
>   				   end / PAGE_SIZE * PAGE_SIZE -
> @@ -1544,6 +1615,8 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	}
>   	check_refs(buf, buf_size, 0);
>   	ASSERT_EQ(0, munmap(buf, buf_size));
> +	if (variant->file)
> +		close(mfd);
>   }
>   
>   TEST_F(iommufd_mock_domain, all_aligns_copy)
> @@ -1554,9 +1627,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	unsigned int start;
>   	unsigned int end;
>   	uint8_t *buf;
> +	int prot = PROT_READ | PROT_WRITE;
> +	int mfd;
>   
> -	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
> -		   0);
> +	if (variant->file)
> +		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
> +	else
> +		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
>   	ASSERT_NE(MAP_FAILED, buf);
>   	check_refs(buf, buf_size, 0);
>   
> @@ -1575,7 +1652,12 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			uint32_t mock_stdev_id;
>   			__u64 iova;
>   
> -			test_ioctl_ioas_map(buf + start, length, &iova);
> +			if (variant->file) {
> +				test_ioctl_ioas_map_file(mfd, start, length,
> +							 &iova);
> +			} else {
> +				test_ioctl_ioas_map(buf + start, length, &iova);
> +			}
>   
>   			/* Add and destroy a domain while the area exists */
>   			old_id = self->hwpt_ids[1];
> @@ -1596,15 +1678,18 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	}
>   	check_refs(buf, buf_size, 0);
>   	ASSERT_EQ(0, munmap(buf, buf_size));
> +	if (variant->file)
> +		close(mfd);
>   }
>   
>   TEST_F(iommufd_mock_domain, user_copy)
>   {
> +	void *buf = variant->file ? mfd_buffer : buffer;
>   	struct iommu_test_cmd access_cmd = {
>   		.size = sizeof(access_cmd),
>   		.op = IOMMU_TEST_OP_ACCESS_PAGES,
>   		.access_pages = { .length = BUFFER_SIZE,
> -				  .uptr = (uintptr_t)buffer },
> +				  .uptr = (uintptr_t)buf },
>   	};
>   	struct iommu_ioas_copy copy_cmd = {
>   		.size = sizeof(copy_cmd),
> @@ -1623,9 +1708,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   
>   	/* Pin the pages in an IOAS with no domains then copy to an IOAS with domains */
>   	test_ioctl_ioas_alloc(&ioas_id);
> -	test_ioctl_ioas_map_id(ioas_id, buffer, BUFFER_SIZE,
> -			       &copy_cmd.src_iova);
> -
> +	if (variant->file) {
> +		test_ioctl_ioas_map_id_file(ioas_id, mfd, 0, BUFFER_SIZE,
> +					    &copy_cmd.src_iova);
> +	} else {
> +		test_ioctl_ioas_map_id(ioas_id, buf, BUFFER_SIZE,
> +				       &copy_cmd.src_iova);
> +	}
>   	test_cmd_create_access(ioas_id, &access_cmd.id,
>   			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
>   
> @@ -1635,12 +1724,17 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			&access_cmd));
>   	copy_cmd.src_ioas_id = ioas_id;
>   	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
> -	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
> +	check_mock_iova(buf, MOCK_APERTURE_START, BUFFER_SIZE);
>   
>   	/* Now replace the ioas with a new one */
>   	test_ioctl_ioas_alloc(&new_ioas_id);
> -	test_ioctl_ioas_map_id(new_ioas_id, buffer, BUFFER_SIZE,
> -			       &copy_cmd.src_iova);
> +	if (variant->file) {
> +		test_ioctl_ioas_map_id_file(new_ioas_id, mfd, 0, BUFFER_SIZE,
> +					    &copy_cmd.src_iova);
> +	} else {
> +		test_ioctl_ioas_map_id(new_ioas_id, buf, BUFFER_SIZE,
> +				       &copy_cmd.src_iova);
> +	}
>   	test_cmd_access_replace_ioas(access_cmd.id, new_ioas_id);
>   
>   	/* Destroy the old ioas and cleanup copied mapping */
> @@ -1654,7 +1748,7 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			&access_cmd));
>   	copy_cmd.src_ioas_id = new_ioas_id;
>   	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
> -	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
> +	check_mock_iova(buf, MOCK_APERTURE_START, BUFFER_SIZE);
>   
>   	test_cmd_destroy_access_pages(
>   		access_cmd.id, access_cmd.access_pages.out_access_pages_id);
> diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
> index c5d5e69..2d7d016 100644
> --- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
> +++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
> @@ -47,6 +47,9 @@ static __attribute__((constructor)) void setup_buffer(void)
>   
>   	buffer = mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE,
>   		      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +
> +	mfd_buffer = memfd_mmap(BUFFER_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
> +				&mfd);
>   }
>   
>   /*
> @@ -331,6 +334,42 @@ void __fail_nth_enable(struct __test_metadata *_metadata,
>   	return 0;
>   }
>   
> +/* iopt_area_fill_domains() and iopt_area_fill_domain() */
> +TEST_FAIL_NTH(basic_fail_nth, map_file_domain)
> +{
> +	uint32_t ioas_id;
> +	__u32 stdev_id;
> +	__u32 hwpt_id;
> +	__u64 iova;
> +
> +	self->fd = open("/dev/iommu", O_RDWR);
> +	if (self->fd == -1)
> +		return -1;
> +
> +	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
> +		return -1;
> +
> +	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
> +		return -1;
> +
> +	fail_nth_enable();
> +
> +	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
> +		return -1;
> +
> +	if (_test_ioctl_ioas_map_file(self->fd, ioas_id, mfd, 0, 262144, &iova,
> +				      IOMMU_IOAS_MAP_WRITEABLE |
> +					      IOMMU_IOAS_MAP_READABLE))
> +		return -1;
> +
> +	if (_test_ioctl_destroy(self->fd, stdev_id))
> +		return -1;
> +
> +	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
> +		return -1;
> +	return 0;
> +}
> +
>   TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
>   {
>   	uint32_t ioas_id;
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 40f6f14..6a11c26 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -40,12 +40,28 @@ static inline bool test_bit(unsigned int nr, unsigned long *addr)
>   static void *buffer;
>   static unsigned long BUFFER_SIZE;
>   
> +static void *mfd_buffer;
> +static int mfd;
> +
>   static unsigned long PAGE_SIZE;
>   
>   #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
>   #define offsetofend(TYPE, MEMBER) \
>   	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
>   
> +static inline void *memfd_mmap(size_t length, int prot, int flags, int *mfd_p)
> +{
> +	int mfd_flags = (flags & MAP_HUGETLB) ? MFD_HUGETLB : 0;
> +	int mfd = memfd_create("buffer", mfd_flags);
> +
> +	if (mfd <= 0)
> +		return MAP_FAILED;
> +	if (ftruncate(mfd, length))
> +		return MAP_FAILED;
> +	*mfd_p = mfd;
> +	return mmap(0, length, prot, flags, mfd, 0);
> +}
> +
>   /*
>    * Have the kernel check the refcount on pages. I don't know why a freshly
>    * mmap'd anon non-compound page starts out with a ref of 3
> @@ -589,6 +605,47 @@ static int _test_ioctl_ioas_unmap(int fd, unsigned int ioas_id, uint64_t iova,
>   	EXPECT_ERRNO(_errno, _test_ioctl_ioas_unmap(self->fd, self->ioas_id, \
>   						    iova, length, NULL))
>   
> +static int _test_ioctl_ioas_map_file(int fd, unsigned int ioas_id, int mfd,
> +				     size_t start, size_t length, __u64 *iova,
> +				     unsigned int flags)
> +{
> +	struct iommu_ioas_map_file cmd = {
> +		.size = sizeof(cmd),
> +		.flags = flags,
> +		.ioas_id = ioas_id,
> +		.fd = mfd,
> +		.start = start,
> +		.length = length,
> +	};
> +	int ret;
> +
> +	if (flags & IOMMU_IOAS_MAP_FIXED_IOVA)
> +		cmd.iova = *iova;
> +
> +	ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &cmd);
> +	*iova = cmd.iova;
> +	return ret;
> +}
> +
> +#define test_ioctl_ioas_map_file(mfd, start, length, iova_p)                   \
> +	ASSERT_EQ(0,                                                           \
> +		  _test_ioctl_ioas_map_file(                                   \
> +			  self->fd, self->ioas_id, mfd, start, length, iova_p, \
> +			  IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE))
> +
> +#define test_err_ioctl_ioas_map_file(_errno, mfd, start, length, iova_p)     \
> +	EXPECT_ERRNO(                                                        \
> +		_errno,                                                      \
> +		_test_ioctl_ioas_map_file(                                   \
> +			self->fd, self->ioas_id, mfd, start, length, iova_p, \
> +			IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE))
> +
> +#define test_ioctl_ioas_map_id_file(ioas_id, mfd, start, length, iova_p)     \
> +	ASSERT_EQ(0,                                                         \
> +		  _test_ioctl_ioas_map_file(                                 \
> +			  self->fd, ioas_id, mfd, start, length, iova_p,     \
> +			  IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE))
> +
>   static int _test_ioctl_set_temp_memory_limit(int fd, unsigned int limit)
>   {
>   	struct iommu_test_cmd memlimit_cmd = {


