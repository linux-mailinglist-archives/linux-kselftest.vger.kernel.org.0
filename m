Return-Path: <linux-kselftest+bounces-32432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2CAA9C3D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 21:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51293A8D2B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C02638BA;
	Mon,  5 May 2025 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ffovOM1M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QV4h4alv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314E1AA1C4;
	Mon,  5 May 2025 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472186; cv=fail; b=RExKhfysfNT9karV4jBVKdy31M11rEbYOtDn9LsOJgRBnVl93iwKNi6MFwT8yX60ZqmnAzsiB31Ff4hItFN7e5r+EbwNc1K23FiaycfcJrUXsoC5BexoqB7n285UIOqxygsPD6WG9UHaUXkSc+Jd29KgWjwXwDOpXtz7NcfWChM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472186; c=relaxed/simple;
	bh=lLzuxLNHGfPp9uZJwoLFxJu7nSWs6u9w7CqWbi9ojJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hXC/EbgoGSssvl+Mk2OerBDktRbzF3I55z1UlKtD1xOlIPq57kcSHfUj1AlQORmuAsTzBD6mwYNtbOH+FtNJQouXMFxvWsLc5qRu0zRzOckpTuiFvBpxpZX71kkuKa0uSyOiemqYSNMbQxx8b+9N1SwOz2JBioq1EqfjG8O6LrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ffovOM1M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QV4h4alv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545ItrNW005166;
	Mon, 5 May 2025 19:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TtDL7GEqco0ipDquThI/tlhA/hSY9mzOkWzae7gECu4=; b=
	ffovOM1Mxe3rN2La+w84RsfkQ2BVMF3HEUnQFT4vgq30Lhu17Oz1b03YsFPx8CIx
	S7cbhB72HXO0SRImU2k5r6SwpjVI6406KciAxgUnZ6l8xxpQmR+DeV8N+0W0Bmzv
	R0nEN+MQyb7m8yWVjJqJrMb+oVI2B5BfknOZpRCQNvJcSzE4phigFkIKdQTxw/iS
	T3DVxTO6tUVbI0fULo7vbWrthhKJ2rlLPu1COP8C/Oalj0VhNaUdynKCn3b8pNsJ
	Wz2QN/Psw9gRIF8hxVfvFGhnlD4Q46oMfjfisYXMJbDomv6pYasRPfNLRUkW5QIW
	bYavLDwXsYlgX/Z/1Tj6PA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46f2e5g44f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 19:09:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545IrR1u037596;
	Mon, 5 May 2025 19:09:24 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7tqc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 19:09:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gij20GGMQEbqpfj0q6ZbjPAkxpRswy7g/p0WqeBvKgz74qIMZYRgdUGeAqFZF+xRqIWv/TeEE+p9/HBpBATYFuiRKpb1QhnzBu6ShJmXh1S5BV4tnB9tvbD22ADVCSANGJDRfY7lALurf0Gl0Jch7/9TagXtFMGIQxFVmLJ8Vulw7atTNdkV96wkCbpIttRGsrwEBwO6OTBQx25RZp66MS0umv1A0WaIrz98216jwZCcI1nIFvQfhL2sO7PPDDzxhtPnSwb1Nb2zNCnfu9uIMtPXUYqDKB2PmskS9Y7YuFWoi3mpzppaRdnKF5GmPdthwLA5BuGlXN+lglhAo8zI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtDL7GEqco0ipDquThI/tlhA/hSY9mzOkWzae7gECu4=;
 b=mqCrDJh3e5Mzy7hoHAr+YMwSVTzyfNMdXybohIYzC2DyKwMKzojoX6d5LY+O064OsSTkjW99i68K4tC4XDVfH2xfhW6xgAdtahUXYerTwQXKsiTgNNL45wqfiIaE01AXn07w9JNLBsb+AtQgqq0FZk3ST1h+/7lHBp04xc5IMFg1QCB2HcBNLmz3bRXYeb3LlMI0Xm4sOfQL3LHDoISF60hAR58PaR10PYpZmJyVVf2iWbDu5LwbzFHIkf9bHWhRSh7p54UXYOvDEdwrdsu0QuMkL+jX0zkoEQ/XmTzEXN8nPONk1GpgzC20HH0ek17jpmCIvH/lrkrTUGN8c52/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtDL7GEqco0ipDquThI/tlhA/hSY9mzOkWzae7gECu4=;
 b=QV4h4alvqGwUYJSOcki85wp2DLHpYJnqDwzp2jQrBJwjWCv+zB93RsrLvXt9wQ169UbOhSaDnfqUmI0CqKFskrZ23nxgBhULL3fyoovnfH9+LznP6MqnrW3KVDXzRIxHroFd7fLOuNwzItJGjYBi5jx6bXrwy7mWLEycVf87n6c=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MW4PR10MB6393.namprd10.prod.outlook.com (2603:10b6:303:1ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 5 May
 2025 19:09:21 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 19:09:21 +0000
Message-ID: <fb08370a-99de-4ff8-9188-4f9472b9d838@oracle.com>
Date: Tue, 6 May 2025 00:39:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] iommu/amd: Use the generic iommu page table
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Justin Stitt <justinstitt@google.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <13-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <13-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MW4PR10MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e5706a-8f95-4cec-7d74-08dd8c085717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzYzV2haQVZSazA2ZEtsQzBFdmVpMDFXTjlya3ZsdjNBU3N1SVBDRFBndEFV?=
 =?utf-8?B?bEM1dWRhRE1ZbEhLVE9EOGlIQU10TkoyOFJVdmxJLzRac0FpeTMzcXB5UHRX?=
 =?utf-8?B?UUw5eURHT0psNVFKRVRGQVV0UTg4Zmd3UWFJT1pIY0RnT3dMOEpvVUI0RTR4?=
 =?utf-8?B?Q3hNUmFLV2VGZi9qWngzcnloaUp2Z0k2UTB1UHpvQkFpUXMvTXhwblAzNWt0?=
 =?utf-8?B?dGhCVW5YbFBYK3J0M28ycTRVZG5VWWpmUUgxdVF1YjBSVm5oRnlwZzVBa2xC?=
 =?utf-8?B?Yi8rWGZnRTQrWkpBejlEcjloNkVCSHhENmpzOHFWMGUyYitzd0szK1lvRk1k?=
 =?utf-8?B?L3k4aXZ3aU8yUTlIVmt3VDMvRWpibDVTRmRGbjZWV0xhdVlieWlkZHNQVXFJ?=
 =?utf-8?B?TGE5bHhWdi9kMTQ3ckp6OVVyb25CYzhkY3dKK2hBU2lGOUxEcHA4Tnk1WjY0?=
 =?utf-8?B?UjF4eEUybWZlMzlCYXBiK1ZuZmxBSjBmUUpjQlJpY2o5V3h3RGtCS09hYTEx?=
 =?utf-8?B?SVZrNnJtWXMxSndzVzlZNmoydkx1RzdhaEFCU1RoZFFZeE9LdHk3aThEdjFt?=
 =?utf-8?B?MVg4V0YxUGFMMmhFRFF6QlpCRlFTSzVPN0E3dk81UkkvME1raFFZRlBXY29F?=
 =?utf-8?B?TSs3dUdnM244aVZLVXRiZXEvMU40T0JrQkY0R1BHTVp4RXBrclVnY3FaOWFI?=
 =?utf-8?B?bUM1U09wRU9US1dhdm9SQzlJOE9rOTk2aGJndVJiRGFvMURWb3ZYdjlockxr?=
 =?utf-8?B?ZU5qRzZCUU56OXV3UyttRHAwVmh0NzhMOFpYWE40bGJYK3FHSjlUSEU5U2NZ?=
 =?utf-8?B?aXV4eUREdDRZVDlnUnZCUUhNRnVoaE03dGY4VUdlODFUYTFVRHhZU0RCekor?=
 =?utf-8?B?L3Mzd0wrZWNvaDYwdlRwVVBsdFR0aUNBb2F4L200TDBWTUNrQjVJZ1hZUHF4?=
 =?utf-8?B?U1dRSk9HSTZBVFRSZkR2NUczRmdhSkJhc0h4eklLUGNiQWdnc09VLy9Va1hq?=
 =?utf-8?B?NXZrM2t3RzM0MkswSGlTaThjWXVxS2hrc21FZnk3TU5yRUZQeWk3MDNhcWlv?=
 =?utf-8?B?TUxWWnRrRVN2L0pPT0RTNEJNcS9YdEVLdXFPN3MvWnNwNEMxblBkeWFzYkJt?=
 =?utf-8?B?cGVOMlNRSVRxV0V0dUZIQnc2NU9qNTJLU2RDYmVQTjRRcC8zU3N3K0pTSTFv?=
 =?utf-8?B?Q3dmKzk5cit0blNoek5hOWJCSEkrRFVYOWt5U0lxWUkyN0czbkYzS05mTlkr?=
 =?utf-8?B?RkhKSklBbEVFQW1GWklJbjVwZ3I5QW1DcHBLN3EybVo2OGswQWE4Tm5jZVRQ?=
 =?utf-8?B?WkZ6eGNjQnBWUkZKVU1GL3NHclJzaHliVGhZcmNub3ZPWERPSVo3cHgxa0ZY?=
 =?utf-8?B?b3NjQjRIbkd1RWNSaG1SS3doVjZtdzVVaTlOcnprL1BNTW81WnkzYUNFNGts?=
 =?utf-8?B?Slo0MlRPVjZpL25Wc2lzSFcrY29sNkZNWjh3ZkkwOFY1U1lNRW5vRExscnVY?=
 =?utf-8?B?dWR1SUdVNnFZdFgrS29oN3V5RWczK1loYUk1dTMvQ2FldGJ4RUdidEhGWE1T?=
 =?utf-8?B?anBPSDJUS3JvQnNyZ1ZUdlN1RWZxTU5hbFpzNUlJRHpZalN0QmpCWUxwaTB4?=
 =?utf-8?B?QzdReG1JOFhoVFhtN0dlMDFLeFluSCtrUzN3akxKQjBNbkNRSkdsTnhhOUd0?=
 =?utf-8?B?QVJ5cDZ4L0UyR0R5NWpUQlZ0VlNaZGY3UmlGUEVyUzNua2dSS1E4R3pnT1o0?=
 =?utf-8?B?VFY2ckZFRjlSRk5uWFBsWjBBdWZaOEtFd1lPbk5Tc1lyWkgyYzZqWG16SGdL?=
 =?utf-8?B?elFRNzhFMGMxSGdFL0cvaC93TnhlVkZqaXk1ZVZLRThxV3RnQjdUcFZRMkFw?=
 =?utf-8?B?MzI1Y2k5RnFSVkk4V241UjRrN2pqV09BZ3dqOFU5S296b2ZDdlFsTS92S1hq?=
 =?utf-8?B?ZlZ4aklLS1VuQU5RVk54NGtPOGZyUDd5RHNZdjhtaGRndGlxVFpaTklrQXZ2?=
 =?utf-8?B?ek1DVmtnNXpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkY5WHlXUkZDMzB3T21YR2E4aGJpSE5oZWhCcDRtblRaVVkrOTRsQzRQbWJE?=
 =?utf-8?B?VitDUXo2L2xBcDhYSm0xeVhVbFZhVFpPVWowVHZaeG9nSGRqZUNyb1lDbVRV?=
 =?utf-8?B?QlgvTVZEWHdobVVUZGFpUFNSRlJNWVRWK2h6a3gwc2o1TkZ0OEJkemNoUTlQ?=
 =?utf-8?B?NGVCdlVrei9wQlVHU3V6OXVJY2FEeFYrcTFqMDJlcFR4ZlNhMmZCOURvYTFY?=
 =?utf-8?B?dmh6Um1MOHIxRVVqL09wSE9OQ3VQcktHcUg2NWFTNEZpTzVueGtXTHZEMFdD?=
 =?utf-8?B?Uy9BMzluZ1NRVWY2V2F4OTMyL2NDTkhXc1o5REh4amYxMjh5L05NeDcyeDNI?=
 =?utf-8?B?Smd1M2w3V1F0YW9STkpOS0lQb0Nad0l1M3hIMk1Nck1XVW9wWHM3dmZjdVRM?=
 =?utf-8?B?cS9qdDloeDlFZ0tjZUlydU9yQ0UraVRiNHg1YzJTUnNMTWUxNkRuUkFjQkds?=
 =?utf-8?B?ZjVTcHkzTHYxN2JLNjhqSlhHSzR1T3RtNkw1K3ZxQXp2NWF6OUxpTzN2a2ls?=
 =?utf-8?B?bzJ2UUZTdWRNdTVIZEhZb3F2T1YrVHNqdjZVTldkaGRtVUt3OXBhVGpGekVN?=
 =?utf-8?B?NFFVc3FvQnBVWjJPY3FMQ1FadXRMeVdPT0hXSTBWMXFSQ1RuOHJBWVNFYndx?=
 =?utf-8?B?UlliSEFDR1JidHNsdkZ5dGFNK050UGhZaFppVFBlYzY5aE1adkptT3ZvVzJV?=
 =?utf-8?B?anNrdnZBcXZPRmJZcTNwUUMyNitrbHVUaDJhb3o2WVhpVmQzSEFhZlFGaC9u?=
 =?utf-8?B?Myt3NDdtSWxqMTZDeWR4dG5ZMjhCYitieTRneDlnZmtBUVgxak1lOGdRRnpE?=
 =?utf-8?B?ZGJSRDcybjJKdm1FbGNzdyt0c292N21hNWJFWkd3UkJaMy9NM0RsUTdPTUFw?=
 =?utf-8?B?Z3VXSmswQ1JNcno0aGpLdkhRQTFvd2QyL0crekxSVEgvUkJhcFpyZ2FQYkEr?=
 =?utf-8?B?ejZlck9GdkVGQ0tNYkxMVlZ5RFRsU1pSeFVnRWtseXp2L2pUaDcxaVQwbUcx?=
 =?utf-8?B?MFBmaXVtdWwrZzV3dmRkU3lxRFAwOC9QVFRVNE9VN0N6VUxDNVgwUTBmR01y?=
 =?utf-8?B?UnZCVDVtemJZTFVlY0JZd2dlQXBWeUpNeDMzOUZLMUJSTjl3Z3JkRG5LYURU?=
 =?utf-8?B?TXNjZWpTTTF0eURVc1BkVURoc0ZwMnpZVmMzdmlqSi9wTWtua2tXbmc5NUwr?=
 =?utf-8?B?S0NiMWF2T2VkNTdRUFZNZE9OOGhVODVjR2RjZ1V2SEY4K3JmZFVsb2RvNDJ2?=
 =?utf-8?B?bUk2MXhQbFMxcWE2eGNHdVd6K1hJZmhWUHR1VVlmejFiT3k2TzQ0M3hKSFlL?=
 =?utf-8?B?RWUrS0FoVFVxTTE1aW02dmlBSFIzSFZJNmszeC9VaVp4Uk43S1ZIVnhsc3pi?=
 =?utf-8?B?cnNrN2wwUU81QVVDK1FiR0xOYWdrcnhaNnh5RXp5OGVzSjd4cGQrQ0tEWjdH?=
 =?utf-8?B?UVVPY24rSC9sdTIya24vWE02N0RWMkQ3ajl3ZXY1clZkNitmRjlUalo1UG5G?=
 =?utf-8?B?ZVB1ckJPY29uQnFpME5XSitES1BhQ3hwcnNuZlNHQngzOTFnUitJUVJ5VnBM?=
 =?utf-8?B?MFVHQ0FpdmpGNWNXeHR0RTladUhacXNWQXB4ZmREMENSQ0IyQkRaZnRkc0FY?=
 =?utf-8?B?SDhKYWRaUFcwNTY5TWF0RGpETWhXUXVsVy9xZnBlSVJLNWsxbDhjaURMM3Bx?=
 =?utf-8?B?bGZ4aEZQVmdiWTBCRm9rdVFHY0lLZVdTbFZQNkhBV20zS1FnRjBSQnpVNDZJ?=
 =?utf-8?B?b1doK0pDZWxIbnhmQVVDbHBxNHFlMnFXSkRLT0tOODNzb2FlaHNsUUlHNVlP?=
 =?utf-8?B?dHZiOGVpTkw0bGQ1K3RCVG96S1RVK2YzU0dJajJOTjZxd0JUVFBxQ0l2YVVN?=
 =?utf-8?B?SUwwbVpsNHdXeHk0Vzd6SGRNRW91M3prZjhqSjU0UUhsaXVNVVd5cXQ4M1Jr?=
 =?utf-8?B?b2MrcDFiRFVTOENDQkc2RHYyajJzSjI1c3ZYbHdiQlh2dERJWkhjMkVFT0VF?=
 =?utf-8?B?OFJJS2s3OG5naFdSLzRFRjJWMzRHNVFzNDdYQXl3dnhGcCt5SWk0NEV3bWVK?=
 =?utf-8?B?S1dXam11ZzFGSjdFR2ptQTdhMmt2c25Ja0loMWRDWEZ3Y0p5UDlOdHdYb3hj?=
 =?utf-8?B?SlBrMzhneWFVeHJlUGFoM3V2WktSdEFlazUxZURHSkhPOFVzdXgwM0VUemF5?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4FTXqNdKt70s2eGQGFmMIx+T2aUUMN7njC9l5URDLL2MKKdxXF4a5JAejrmZSNkDAvh9f6VIViIEFqMdLNb/MfKy7on37pXhbeH2JIuhDwhi38gw4jVqbsFBsuVFtbs+IM9wJUw8CDdR/aD0mRC2K2lrAkrX9JpW5Ui2fmgvPyyEBQuXmJNX6RiXsvhueceTtCISW2i8uC8Rz2fmx/a+yK5dFC7D/e77LQSGUk9u4/oSIDtraHf8vLGuY42KPjRf/WInoS3zxxkdQCrGxMU/urQVc5w9bzNCdYBp8ARCmAMagD4Kdt0V2cGZoNazsL8zpF/aWRVegSbvpmECH9/zbNRv5X2LyTQ7wLEzi+Tw4zv0C5JmfRSyawB8XFS+3Xw6+i7N6NRl8zAYtTLtgscacoAYTLiKvnMVm5mvxaCKMBSlk5yrbOANH+732VloHQykVcsGcqD9DvfEnzc3ooalUBsxXPNXW8UKrpz+9E/rxGGP6Kl4A5EbZxzt26b9CFEka7sAdvppqClJjQwt/vZEdZboMQVGUaQeO2M8TZg4ejI3ZtcjCv4Svjxx//TvVI/Un09d8LRiV2IP+Zn1ZH6bnVY97MVcanBGUOXmxfVnOvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e5706a-8f95-4cec-7d74-08dd8c085717
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 19:09:21.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+V3wUQsEgMppzowEds0fT7CO7EdFryFLnkioBB+9QThIHtll/8128Pczih7N+gUwfwt4dexSNm2hW1wccZnoEPR3a4wkTiW4xD71wXTncY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_08,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050180
X-Authority-Analysis: v=2.4 cv=fcGty1QF c=1 sm=1 tr=0 ts=68190ce5 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=bleWj8w6O0rdXbL1m9cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pDTLueLgnQwuZc9SQ1wvIf2VCYT7yjz8
X-Proofpoint-GUID: pDTLueLgnQwuZc9SQ1wvIf2VCYT7yjz8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE3OSBTYWx0ZWRfX2On3NhNDY3uu i7/3+FgREdSme+ek+71NeQ286+2PHj1zkOjxFgpInqhKLo//Nl8raDaDXEQzbcHJWOy+D7DiiId hpz6vBeKIxOO339LBl0tbPFpRXTGrdxS+nGilOvXtZpzgADZa4gEtcVvgt6TxRM4gafBxp2wlC3
 JET23aVNGedppoKRrPp2eilHZ4YgRmgRYweW6sTaA17fOgYiJGts3QFb7y7kkqa4Suru+FGbF3s ZqYtNdgErXgakXoCKqvJQXpI2CagzB9jwa5iYv8RyS0EmxluHY4mD9oqOEPHxmVATO/hxZNc4EX 0nSuwyfDsjae+D8HR/eBlp55VzEnzl/5ZaPF/cdYx1QsOBcnLydRYfjwuGQsWpaRW47mtcHbcrb
 EMzL6pLSG3IpgZZJH+e3e4haWc+24J9GnS+3hiQjWv/Ht4vf5UeJyd68S4ClLfS4EyO2lv5x



On 05-05-2025 19:48, Jason Gunthorpe wrote:
> +	/*
> +	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
> +	 * Unless we run in a virtual machine, which can be inferred according
> +	 * to whether "non-present cache" is on, it is probably best to prefer
> +	 * (potentially) too extensive TLB flushing (i.e., more misses) over
> +	 * mutliple TLB flushes (i.e., more flushes). For virtual machines the

old typo mutliple -> multiple

> +	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
> +	 * the guest, and the trade-off is different: unnecessary TLB flushes
> +	 * should be avoided.
> +	 */

Thanks,
Alok

