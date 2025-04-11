Return-Path: <linux-kselftest+bounces-30593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B59FAA85D24
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 14:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF7B4A032C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7702029AB16;
	Fri, 11 Apr 2025 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BA5XhV/a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hDoYpOuG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0980298CD5;
	Fri, 11 Apr 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744374984; cv=fail; b=Csa3EGhFYMgye7j6GCQ6Izr2GNhzeBgNFT/UEUqpFJYbsJrrSCKP1T6NTx2+dE1J06TqY0JA5qffJx2Sstmp1PSIku+dGiybupGd57vVSrWni99pKozzlER70G0H/rlc1Ce8/cBmj9r2KuzlJHD0yvSpf6IicLQ9twsZJB3bsR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744374984; c=relaxed/simple;
	bh=yWVPa2qQDAFaQzkPrVM3hjJizAfOKBCb3GeiK7JZAa8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DTKHugmnlNRP+Tw7H21dxj5NBUHZ/dxciOrovbp4dvQNiUHUyJu7oexuTS6BvV2TackAKzHpgGuW1ZDhPDNjRgj8TLu+NczbzKLJuNl49zkj34DT91P6f5wuEID2k20SN3EWDSdN9s5tYj9o4a/jsRCtWk5QxDOQnnrgRbRspeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BA5XhV/a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hDoYpOuG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BBb76f004019;
	Fri, 11 Apr 2025 12:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yaVX+JyMAfdnD4FCpNB1KQdoFHgF+CyKvMOyn0N6lkg=; b=
	BA5XhV/aL6qgh6AUmKinf4hgqmlJ3mu6fBXhlMuO/BzexJ5MADh22jwXD7jaGHgu
	ei3n67eEQv2GAhviL0jI7OoY66U/lDFIEz9n0tlNPP4S0tQIjTEWDnT5WwcbOul6
	cAqgFnKC9ybtxA7uWQhf7gQ4N5aVTDgU1cVNGLaBmWeAbXhoMcHPX1aOtH+2Le71
	3FqntRzcv6bYxMAvBZqQkgr8LffAyY3Jj9H4+u+cKLrslgwNGC+TsFhqmZzML+66
	KBPHQ2jTspAlhMzaJhKqlkRWdQ628rUnJsAnLG6mUBaDbJhMZ6hPymWdlNyvHNx2
	vezRf0c3syFUtb79BPM/YA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y2c2g3ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 12:35:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BBTJXs016286;
	Fri, 11 Apr 2025 12:35:47 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydkn50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 12:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUQ3Vjw39Q5ADJu473iItBRNxdf5FLrnM/tAgao/GcvwwwFYlBkPVNd1mVDNvXgBFPF4EXYeBkefok4tBfLQ6GKLGcHEeukqsOEnakBQ4bQD5mkNJBNna70cmvJOe5TlkgmU4uNrBKy95XC+nbu5HMoerFH8xIMZuKDSSZE75RZNqpfcReCel0Ft123nDlixJM86r9JCLZDT7fNJeRUCjBB6gYuNDsWu/XGl3hWq7yUgELJ7QNTEhmFnkHSqhXZJ4XKYzuDRXdxL7xds/yTBt3clUQ9nDH3l+B0qbi5eFaIf9oPRAkc927htSMQ6CZ5hcEMYDKfzYfksEHatC5DWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaVX+JyMAfdnD4FCpNB1KQdoFHgF+CyKvMOyn0N6lkg=;
 b=HUvIJRiQ2rd8DN+0G+WbK3BgXyEdF35YapuFwcz20dZImAwgHkV/NtjUCf9Eg2bR2jbZOMj1paupdFDtOgZbyLepZ5jsA4WWamp63n9Am/jFe0qwUgshkY9H7g8qzJlzMBwbgbekT3WLBhL5VPta8ky0uwi2Ecq2ZvuKYGkncuBotLLSuHnyeQEvMGnMBMUnz62rvAqlZyA5odSRPhM28hnvWJBsNRpGvcjtqPW/wGnBh2ZmZg1NnpcVw3NsguLo5h24pfIYVCW1pxSKtl1HWXzss/9nc8RoqwPpRjC5zF/hfqCkXzv/OtjZugG+/p3oVR76KA4+71uOltT/E0e6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaVX+JyMAfdnD4FCpNB1KQdoFHgF+CyKvMOyn0N6lkg=;
 b=hDoYpOuGdoqtJZv92EGqIL4XGhHrNBHnmhX4IVUji0RWobjYox6MXtF45ynPGGqgPtTaXASMJyMc+9tO+gTj+Yxq0Br6IpdBq0WSd7BZIxOXV00FJu9qI3BZw7cnFb5ynGeIsdQupKc+Yw204TOfg2s+5jQUaUsSxjNvgbPam1I=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SN4PR10MB5560.namprd10.prod.outlook.com (2603:10b6:806:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Fri, 11 Apr
 2025 12:35:44 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 12:35:44 +0000
Message-ID: <480536af-6830-43ce-a327-adbd13dc3f1d@oracle.com>
Date: Fri, 11 Apr 2025 18:05:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/16] iommu: Add iommu_copy_struct_to_user helper
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
        corbet@lwn.net, will@kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
        vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
        praan@google.com, nathan@kernel.org, peterz@infradead.org,
        yi.l.liu@intel.com, jsnitsel@redhat.com, mshavit@google.com,
        zhangzekun11@huawei.com, iommu@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@lists.linux.dev
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <65b51f57d08069c9da909586faf4e73d247a54f5.1744353300.git.nicolinc@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <65b51f57d08069c9da909586faf4e73d247a54f5.1744353300.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::29) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SN4PR10MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: 921a5ed4-36c6-404f-e07a-08dd78f56059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bldYbWxUdVR3c3RURFBlWFVHNnR3VERScHRYdHpkaVpCdFRrMjNwK043MEln?=
 =?utf-8?B?eXUyd3E2TldJdkJNNm5RQ3Rza2NwQ2Vad0JRME5JS05MbGsxZkpQZm5pdzZT?=
 =?utf-8?B?dldxazV0L2FsUURTVTZHWnVGTldLN3NNTlRTQ1pyT1BSUTFRV1JkYWdDMFUr?=
 =?utf-8?B?b3dYTGNlS0VRVzE3NWg1YTFHd2JkRTFUQTlLelhrRnQvSC9KZENqNWZ0MlNW?=
 =?utf-8?B?SDRkemFXcXJGaUh2Tmo1VVF0VTRCNDRvWm8zOGRxbVdoVWtYdXc3REc4QVhv?=
 =?utf-8?B?NEhmY2ozRFdGYnY0dnpUMTU3QmJNVWdQYXA5QWNpMFVMdG9vSnJoRDlNMElC?=
 =?utf-8?B?STRPTGZZWHNZb3UrVkpjUSs1ZXA4UERkUzJSZzRMb2JoOVY1dHMrTlVRMGxL?=
 =?utf-8?B?UkxJSzYrWjhUNkR5RjBKSlZSRE50dGN2NUUrbE5UTDQvMlpMOXkrdkxvYlN6?=
 =?utf-8?B?TXNhRWU5aCtUVmZEbWYxMDIzc1J0bHM4THlDWXJMSUdWNGRoWW45dFJkcTJR?=
 =?utf-8?B?U2lubk9ybE5rU3N3bG5sNGViZ0RGeEVSV2JESUNTczl1UTNUM2VjbEVTenVx?=
 =?utf-8?B?RWI4U1dsdGNsNVMwOUtTTy9PR1dKazJMcGZjTGthRlNzdW9FL3Y5aTVXWEhJ?=
 =?utf-8?B?cFlIUzFDOUx3TjBRNUtJRTJ0d2Q2M2pwendnU3I1TWhQeFpRWjN4R0dNdzVO?=
 =?utf-8?B?aWJZU2o5WXBYR0R4Ny9UVCtiMmJpWWtJaHBtdExuZGk1ZTBySlBjaGJNR3Vj?=
 =?utf-8?B?OTlKcGpLSEg0RHFrbDBqLytZQzBOc01UT3p1WllzL1VrS2hEeUhuaHhTZXIz?=
 =?utf-8?B?bVBxY01OTktBMlpvYmlTd3hDK2pHdWt4eVNLUGVFUFloYk54aXN6bk96QWhU?=
 =?utf-8?B?TE1EZFYvQWVEc2ZkVUhrRG9RemNZWDhtRkhZbUVNb2JsUUtXMmhyWWl5TGw2?=
 =?utf-8?B?SWdZYzFtRzBpd044bkwyYmhwcGIveEFEUG9XMDJRZFh5UTFRN3J3ZEIyK1o1?=
 =?utf-8?B?eElqTDNnS1YzSGw5S3lOUTRSbEZtQjNNRDJ2em5mOFNnT1dLMjh2ZEJ6U1hP?=
 =?utf-8?B?bDQ3R2NScmR1VWR2b3dVdmpuSXZHdTJWcUJHZy9NRUx0ajk4Yk0zMEEwd2pW?=
 =?utf-8?B?aWkvWnNVRTBMbklJMk5RNktxYlNuME5SSWlDaWVIMGlWUU5ZaSthU0NzQ1di?=
 =?utf-8?B?ckIyZ1c3LzU2YnZaZzYxQnlJbDlPOE5yK0ZTa2lqZW5Mb1hycGNIU1YrL05w?=
 =?utf-8?B?R0trVlQxYjRvclRyVVZNYi9leWlNeVk4QisvcFU5SUJ4dk93Rk8vUk5nS013?=
 =?utf-8?B?SUwrbWgrRXVaVEZFQ1hXUXVPREtKRnFmQ3NVOEE2MTIrMUN3WWd5NmpPdmtK?=
 =?utf-8?B?MFhSaXpPS0RMZFdZWFJQTGRHLzRTRmtWV05zUEJXREZSUDdnY1lNNFp0OFdR?=
 =?utf-8?B?Ym5OZHZwNEJ6eTRtUklHSmxLZDE2UTR1QTRQUGNWVDEyVWcyTmdqanJQVEUw?=
 =?utf-8?B?c1FRbjFaU0dETng5VGEvcjROV0JVeDdMN3JmRzBkaTNqdytkRlpQYkxoc25K?=
 =?utf-8?B?OWpwSnhEaDlIN0VNODRZV0lYaDBlQkdHeVFpRUNRQ0lBSkttOWhyYlRYSGRv?=
 =?utf-8?B?U1plMTFaK094NTZueTFiNDhvSEZwU2V2NFQ2Rk9FMFlBUFNDWDNiZXNtNnZ1?=
 =?utf-8?B?VFpZellZT2JjaUw3b0dsZEhWSFJmMkxXZWlLQitYWjJHY2RwazNyd0dFazRD?=
 =?utf-8?B?K0dFSEJUVXljejlwbFpZSUVyZzNiQ0l1QUVkR0NoWmd1bVE1ZVZRNVVrWHBh?=
 =?utf-8?B?SGdqNU9VeWZTRWJzQVp0ZmVoUWZicmhiWHFsR3FZSFVDMGY3N2JwVzV3dTBz?=
 =?utf-8?B?WTJkdnNKODBJRWd5UjJwalhPREJtMXZpL0ZOc2pkaFJMdUM0Z3dnN3hVQmRM?=
 =?utf-8?Q?yg/0LP42NlQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3ZxM3JFTlVqWVYrS3B1Q0JkZXl6dzI3M0NhcHkrakJiZGk3OU4vOEpvSWxP?=
 =?utf-8?B?NDdraFlXVTl4M1Fndk5ybDUxSFJVMnZOTnA2UUgrcFJpWUR4Y1phYzc3bVVa?=
 =?utf-8?B?U3Rrd1MvYnlMVko5R3ZyVEpXL000MnZ3a29PYlpqamQzV2pCVmY3c2VCV3dS?=
 =?utf-8?B?M0RjU2NjbkduVzhNWmtOVEdjNXNIQ2ttMmMydDM2ZU10dHUwRkV5bUhQbVQw?=
 =?utf-8?B?eDVnRDJlNndxRExDRTdKS3JQdE9kNkZJMXhGNWNkUmViQ1pxZzdiUUNZU3M5?=
 =?utf-8?B?QmdDclRXVmkwLzV2Y0ZkYXFEL0JQQ2ZkdGZXNUx3T3VBbWsvRlh4dTlzd2tD?=
 =?utf-8?B?UjE1V0R3NHZObmFaVHhIZXNSbGorZnZHam5HUVlrZElqSms4MW5KL2lJN0Jz?=
 =?utf-8?B?SnJ5M3V1clk1T1Raa2IyM1F3cmlTMXNpT01HUWV4eTRGYVFBam1LRnljc1Zx?=
 =?utf-8?B?anB5WmFyU2Y0T2VaZzQxYkh6eXVheWYyQXdaaTRSZll3NzNwMWwvSDFvL2VW?=
 =?utf-8?B?U3YzOTJKWjBZRnJ0UVliV1N0bG95Tk9xd0QyczY4aXVTbEdyWnh0SklJdGky?=
 =?utf-8?B?WlRlZTBVeXJ2bUdLdGJUdjEyTFYvVFZhUWZlTTJxUFprK0dzZjlrT3c3L0Yz?=
 =?utf-8?B?MWVKOWhZdmE5bVZkMjRnNWtLdHhNRHZKVm5Eb29sa3RRM3lYMUN2M2dYVTFZ?=
 =?utf-8?B?ZGcrbzZ3U1dFZmVud2J2Z2lLMVRDTW9PUEpLOFA4Y29NTmVHZHZDd2R5S0s5?=
 =?utf-8?B?OUtsS3lCeWVsZldvS1JDcml6M2JrSm1NTkZheW80M2k4angzUDYvNVJXMkF0?=
 =?utf-8?B?bUZmemlqUGs1ci9BcXhZbHgvZ2wrL1M3SjdEcjhUTDVtWTUzS3hWUGVhTG54?=
 =?utf-8?B?U05RV1NvalBHNHRqKzd3a1F0djFQWi8veG0wN3BYU3o3WU10a0E5RlZjelVB?=
 =?utf-8?B?cTF5emhmNDB1SVNReHF0NmtuQkxRQ3VQRndUNTdCYzdJZTFCUzBtMk1KUkNw?=
 =?utf-8?B?UE05a01MMU9EUGhKOW9xUEtGS1A5VWhpTkVmTFFQazcxdm1ob0w3ZjBHMzQ2?=
 =?utf-8?B?eGl3ZTJkYk1sQ2Y5dHk1ODRSblJlckVXd25pUktvTG9MZElGVVBrMkVqK1c0?=
 =?utf-8?B?MzcwbzlYZ1Fiejhzdy81SEJMWVBGNDBpdGFxcHJybzcvZEpvdlpuK3ZWZjMv?=
 =?utf-8?B?alZ0U05RQ1FoaFNRNEkzdjRYODBFei9IK1R4ZVZVKzVOVTNNTmlDc3VxV3Bo?=
 =?utf-8?B?ZVJuUm0zbFhhNnhPamNNMGdNc1lIbVJubUtqMUFUQXRjVENQK2g1QzV1a24x?=
 =?utf-8?B?UEpMVmg1VTA2SzloNDltVnpjaXhadTEwNlM3VjRQQXI3TEN4UDZBNlkrTWJE?=
 =?utf-8?B?Q3ViN0RkSGtIdDF4akllSmJnc2x5SVdYbGhDeFFGL3pCeUM0cnFOaHZuOUw2?=
 =?utf-8?B?L3B1aVlNYTcrU2F3WHFaTTIrNHY1NzBzQjVNREd6ekpic0g2UVovOUErSzk1?=
 =?utf-8?B?V2QzcjZIMHQ3TUZ3TmRpSFpmRDV2cHR2c1M1cDMyQzNXSG9ZM1Z1NTNEeWRT?=
 =?utf-8?B?SlYvcXJpZEg3MUhRUVBhQWJoT2hXVUR2QU1oNmNOaEJLZzFiSnprNk1rWGVQ?=
 =?utf-8?B?cUNTL245NG51NHFFa3pUNzVvNGp3Qjg0ZHF2WGcwR3NLcDNNdVAzblNTVzhG?=
 =?utf-8?B?a0RaZTYrNmdxVEREaG1SemVyOWZmUHFZMWlyd21WZHNJTTVXL3M0c0oxSm42?=
 =?utf-8?B?Nzd5SzBQb2M0c1RtMG4zM3RqWVNQWVpEK2VrNUQ1d3Fub09qOUtJSVo2UmIw?=
 =?utf-8?B?Q0c4UVVacFhPdU52dnJFNHhpUlZraXZjTk00RXA2Vi9EWlptMnMvc3o4d1la?=
 =?utf-8?B?VXpIcUZtREZQUCtBZ0p3VzdEaDFldzB2WnVvZTkrcU1ncktqeURWcWl6bUIx?=
 =?utf-8?B?b2g5YWMyaTJyQUhaOWxvWEhYdyt3Vk1ydHpzRkxKUEtZdmtFYm9NalNIdEVS?=
 =?utf-8?B?RjhuaXpRdW8zUnAxclpkdFRDdEUxMDBpSVFlWVFSN3R0c3JITjVFUjU1dVZK?=
 =?utf-8?B?bXJLSU90d0FHaUg2TzRVcCtqYnlpZU1odzhaRkdwRmpOekVvRmkwb1dMRXIw?=
 =?utf-8?B?VFBVUmR3RFJVbGlldmkrcTVnZUJRYStqR1ppZDAwc29abEk0bEM5S3lQUGlE?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ShMzZpWN3LuDmjSyEMDAL8ZND1sqtmVH4mcZq7uvExlOVd+COfF32N+OWJfXZsQbOExI9Wf5yCJaGpp6rDNFuzIJcfUewidGy3TWYdNolzkCqvCwV+hOyu/yL9hcbx8DehlxdFtNeGnM40b8jgFqk+Cd6w53Q/MsXQhZ/2BDwn2fnVaYzWIX9fVh6gca5n2OaavUA3ptnmWg9fQhvO3tHXf0cR3yKJkEDFbU2Fp82V4T8XHjjq0d5GhEPhKQYXXJ5o1j4ItPWP1t6P/udpT5sBF5aEx/CgA9Y5XzcFFnxpyxzXGVI0yFh9rjZ7h5s7+ZDMXT4HLw6lci2y2Y2bCP2HzJ67G8KOei30cYbdonuuQ/Wg2fV2FE1b6kpFWAS34W35OvWHQJy9CH50M8gdcwfE1UsI3S/eyxXpQK8PhBqxZSAHJX5vc5Fu/jv18dWAB39YXEjnbqH+1tbQva2ePRvq8UWvERdUyAGKFjvR0ECTP6APOoBL66VMB1rpJ7ZW4DwsPvD95h9oOhUVWF2Fg/vpf+HiTDYyOoHEFtuiude/kboskrytqofVeB7ic4yyoXmdVqhhxvEoC/p+XNy0n0dbaxT6hF7lHVOEAbO6ucaCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921a5ed4-36c6-404f-e07a-08dd78f56059
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:35:43.9557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQpo8R/HTIXeRDNTYFOYFeixWuw427jMhxuX1f1UwAjpFbdiSj1sk6pLWQ1GBX3kCMeFTe/dzdysia4nTjqANxuCPsHFmgeDQkjFVyNCu7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110080
X-Proofpoint-GUID: SMJvHTZ8K3sxu3GfkdEfPheqRCRIFFIp
X-Proofpoint-ORIG-GUID: SMJvHTZ8K3sxu3GfkdEfPheqRCRIFFIp



On 11-04-2025 12:07, Nicolin Chen wrote:
> + * iommu_copy_struct_to_user - Report iommu driver specific user space data
> + * @user_data: Pointer to a struct iommu_user_data for user space data location
> + * @ksrc: Pointer to an iommu driver specific user data that is defined in
> + *        include/uapi/linux/iommufd.h
> + * @data_type: The data type of the @ksrc. Must match with @user_data->type
> + * @min_last: The last memember of the data structure @ksrc points in the

old typo  memember -> member

> + *            initial version.
> + * Return 0 for success, otherwise -error.


Thanks,
Alok

