Return-Path: <linux-kselftest+bounces-22086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A579F9CD6FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 07:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662D528103C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 06:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2C18593B;
	Fri, 15 Nov 2024 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KfJ4+Bj8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901A3BBEB;
	Fri, 15 Nov 2024 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651372; cv=fail; b=heVBDKAtBInV2UBMFe9880+c3OAWQR5cmvvz7dw6wBpUMMBfhSO8AFPUhomCuBVyAJTs7Kuif76P07+aLBz1oUBPxr+lMs4fMmdPmRzvye+37W4Wa6eVd90Y9Hk3a/wGsezrMZez7sSJXJyrGn3WUwd3EzbBSqGoikkDNW8PJXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651372; c=relaxed/simple;
	bh=AVlULtw5kHEnEOD/yaDSVOuNj7O2KNuCYVSD2iaEH3c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aLp3mogGyUQZzSDgppgvzyK2dcs/0W4HyPxjdxm83FQFYbrCxRV65mFohJQZqTQyDSZmmDy6+VGsH4gogkOV8DkHV8ox8d9x6+iHhdB2LaP918rlbQZ0lpuUBx+FXLuvUJjZ/rUaDQCVBD7zu20AdAlFfFaehA2fS1lMy9iJMcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KfJ4+Bj8; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBMtYNL72k8wshrQvzHm7HvJ86WQFXbDIDn2IyJ1CBLq5iFV/UqMG8kotu8NzL7w6QzOIZS2kEpnWHPuhi3SopIv7N6y6Tldi/IO7Kumz0owI/6ApZlY/NgBbg4V0Qv7CQr1FD7OXPETn4iEjVjQ8oa4C+Rd7c14v8FPGSHMeoPZ/edPIQ9mCCPpPBZXrHOTtmkTnumydTAYwU+fdeXUvLhh+u5vxeF0iRTMP644mdseUuuDTLwoMDnQ18PC2/7aF+DLjloAtwO2VHXH1auX1G0xNgB54qny1K/3Fvv9JNX2FnYgcG+D3OXWX9SgHVuJxFJ54mp7zw+zL45em1a91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hFK3nUjDn2mPeOh9nKOOZ0vJafOhVkFEt3fxv34x74=;
 b=s55NgJ3VxHNJjvgnBpTj2B+tfX3NOH8dEZUjprquiLAdR6w6qs121UAsETYIrhddFzsgTML5pHSF5wVe+O0pvnOWRnc/zUHEEmtZQEnX1IvOMZ+/x41YdOzoM/+CTMCFYgE7yI4ljcfLEuQ5FPRtinoleIT7h8LflAime9IpJFFq0xcmZsru67Ool+F4VICEgchz+ypzqiFqyolXlSzuBcXVbz1Bk7rM7RngMsUr7aJqm+0j9g1Yen8d2y//eRd7cAlNW6Occr22Gm4/q43Yx10uoIyydlkhp8mEPEzBjxEQGm01oUCgaL3idaihem7+LMnNzmHn6jsnrKNAPJ4q0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hFK3nUjDn2mPeOh9nKOOZ0vJafOhVkFEt3fxv34x74=;
 b=KfJ4+Bj8GEVKc4I93EecFAFjUEA2nIK4tTiHNR3Cm/EU+MNQTFhD2zT5NAMnGh/9XfAX1pvziDzDTpv0KK8kYheTQzhdSREpMgox5p9fueh3/LiPn5ok7oMKbD2+N78fVTNZvlFMWygvEJuDYdFUAoYZCSf3MgDXU3TL1TfKcVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 06:16:07 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 06:16:06 +0000
Message-ID: <714107c4-cd94-49df-9443-833dc19d473b@amd.com>
Date: Fri, 15 Nov 2024 11:45:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Basic SEV-SNP Selftests
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 sos-linux-ext-patches@mailman-svr.amd.com
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0040.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::17) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: df3acd3d-db26-4bd5-f43c-08dd053cfd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk1XM2duYVFOZmFPY0JWUG1ia1BBaWJ6SVdJVVU4TTYzZFFqSGhVUW5YaU9x?=
 =?utf-8?B?ZnRVME9tMXZKc2RzZ2g0clptMUlPanRFbzF3NDMrcVlvVFZJRTFVVWF5WkVz?=
 =?utf-8?B?bEdCL2F2eTdvSVRZaDZEOGs4bGtUSVVUVWJNSjlZbTBuVHRxSW1GMkIzQnNN?=
 =?utf-8?B?UldpcTZ0T0tTN2tkUGVuaUo0OWg2ZElGRkoxeVZCRUh6MVd1TEhXdjhIa3dV?=
 =?utf-8?B?dm5LTWc3UHNnRTZUZE84YlFGZGFtc2RoL09wY290M1dURGhaMHlDaEp3WUcx?=
 =?utf-8?B?dy9pZXlaL1A0eTFjQjVOeERiSXRNMGNLUUJNOXhDWjJIMjdBaTNIOHRPV0Ro?=
 =?utf-8?B?anF6N2Q1WlI0MmxmU3gxMHkwak8ycTYrdS9vRlc4L3cwRzMveFZDcWJFUGJT?=
 =?utf-8?B?bmtFY3BieFdUWGllUWpHd0tjNXBaU3Z5aUNtd2tqcytOcEtrWnNxcDhzR3Bu?=
 =?utf-8?B?SG5xM2kzWlZTUE1oRUI4QTNZaVJxdjVUSGxYVGorVXRVSStlM2VUS2JoTURi?=
 =?utf-8?B?RlFsc0hUOTZpQkd5aGxsUFkzRENGOGlnOEVFRzZVVlpQT3V4T2RpREk5bUw2?=
 =?utf-8?B?cXc3amx1QW41ZVF5VDBHckN0WWd6cnk0bjQ4dGVrTHNTcGU5d1JxdWdqM3Jz?=
 =?utf-8?B?VS9sbC82Z2NYakt1TVpmSmZMemd2VEdkQTZNVVMvaUs3TFFoN0ViMnVWSDRt?=
 =?utf-8?B?aXI0UHhNNHBMNEFwMGxraGZzSjFHbFdBN1pQVm1Ma2MwaEZwamxuOUN1ejBN?=
 =?utf-8?B?aWFET1VuSzFtZVJqOGpLR1N5dVZ2cTBpc04zMmtVSlZzVWYwMGVFWFZDYytP?=
 =?utf-8?B?L0F4Sittd3RSTjNJL1ZYNmtDckxDZUlIZUZSYnIwTTRwYnhrZ04vN2NwWE95?=
 =?utf-8?B?UVQ5WUZRRDJscElkWC9YdGtxcWxlZCtKR2w4NHEyT0ZlMGF0SEFoSWJObzhQ?=
 =?utf-8?B?dFpBalJ0N1VUT1J2Q1ZoMThvQkFtNGNEdEVrM2djdTJMd2RSaklpY09GSmZ4?=
 =?utf-8?B?YjRQaEkxM3lVU1U5MFlzdHpFZlNUVmZkcTl4aGpZTzZGRi9XbGVUejRnTlY3?=
 =?utf-8?B?OWRLV1Y2NjFnMVJaK0ErVEM5VWl1Z0wrM3QyUi8vR2EvWm00WlpCbGlPeG9n?=
 =?utf-8?B?R09tZk9HNDdrVDMxUUUxMGM5VVk4S0xQeHlKRGlIc3diQ3pqbXNaNmtmRFFN?=
 =?utf-8?B?L2VtWXM2MjdqblgxczVmTDRTNUNaSTQyTHFVWFRuVHZUcUtrZjBpWXdHWG5P?=
 =?utf-8?B?TFBDanljbnRlajluSnV3cDM2UTNSM1puS0REc0JxQk5jOG5VZm9kZHJOdmVp?=
 =?utf-8?B?SktzQmZ2anNRREd0Ym5BRFV3V0dZTEgrdVhEZi9BbStMYVVTM2NPbGhUOTgy?=
 =?utf-8?B?OG5QK0g2YWo2VW1NWlE1SThMQTRSUFh6WWpUMVA1dE5vSXVEcDFUdVZ2a3Vj?=
 =?utf-8?B?RHlpK05kUW8vQVpWbFVjYkRBUVdxK2ZzYTd1RVBqTy9VczVnY2xYRHBFV3lt?=
 =?utf-8?B?aU1GYldiYnNjZFp2aFN6WGQ1ZU1XQU4xME45VFRXVFJndFUyQlJza3NnaCtp?=
 =?utf-8?B?SGxRNDh2S0V6aGhFOXFSdjF0eEVQdnozYlFoK3ZMb0tKb3U0QUJUK2pITVZj?=
 =?utf-8?B?aENhMGgyNFFvOWdweDNIYVBrV3o5bUtLZnNDamlRMERuSEZaNnpFYjl3QTJu?=
 =?utf-8?B?UW9LMjU0ejBNLzFubU4xV1ZMWCtqUEFpZ01CRWQrKzcxT1NuYmpnY3hicVdn?=
 =?utf-8?Q?DrVrjr54V7dw/zak/6TM57+ewiAXMe6MN8vlUCM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1krQzNTbm56SHNnTDdaSTVHZmZVdTRzaGJ1ZHpWUE5HRDR6K1JRcVdyRHcz?=
 =?utf-8?B?eDd2VTNsbjB2UndpU2FHYmlHTTZhdGdrTnBERWRHSFo4OFBQSzJpeHJyK25B?=
 =?utf-8?B?djVLdjFXU0tvcDI4MWZQdXVxVzIrTGVqVXQ4a0xpb0Q3c1oyNlJnLzZpNnlH?=
 =?utf-8?B?WERqMFRXSzcwM2YwUE1pTkdJc3pseVlLaUsrcW1oZFoyQ1ZUUnQ0am03Q2o3?=
 =?utf-8?B?Yk81UndSTWhDbWhTWFVOUWtDSjhpTGJxMjVCRDNvcEtJaWNoOUN1K1VpdFRh?=
 =?utf-8?B?WjdmdDF2Z3RCWmZpSzdKTlFaZVBWamtwakpaYVowcU1mcTYzak1LSWhhUHpE?=
 =?utf-8?B?ZHQvWVpLallTbVF0UUR3RUo2UDNTcUNnS3FOQkJ1a3FoYk13ejRWQWFVSytT?=
 =?utf-8?B?UDVVQ3NlcFJ0RWloQkNIdVM5ekFsSklzbE1KQ3BycHYzMjI4MmlUT3NIV3Bx?=
 =?utf-8?B?TjlLTzdOZWpKZFdoVUtXODRGZlRjNHRySU1ROTQyVHlFUUwyT1NZNFlDV0Rz?=
 =?utf-8?B?cjBXTnR1cGdkQW1jWCtSYUlrbVNkZWVTYUxDTmdRMXpKWEpNQnowTFFITWU2?=
 =?utf-8?B?UEFDemNoRWZKWHpKd3d0d1dpNTlrSlZLaHdEeEtSbUw3TUJ6Ym8yb1FWQTNp?=
 =?utf-8?B?T0tmaEx3YVl5bS9NbGVvNXFrSG9mMlJ2Vm9qemtvWm1sZUdPMGtrYWdyUk5m?=
 =?utf-8?B?elZxWXZBWldMQ3h0U1VkdHZSU2FGYmIwNFVJSWZOZTRyWWExNFMwanFYVnAw?=
 =?utf-8?B?TCtSb2ptMlVLZzZaRkpiazRaSm9iWnF0ZUlyeEcyRTZKZHEvRGpBRjlLNDBP?=
 =?utf-8?B?ZU15ell0TlMyWDlmdG9UNnFSQk8vU1ZKUG5LQjBMOG1zNWhORlJFUlczUWpQ?=
 =?utf-8?B?Z3pEaVVFTURCa3BSR1JGUVNhL1pJa3lpNTFmZGZ5OEcxbkJDdERIZ3l6b0do?=
 =?utf-8?B?Z1poWkxHc2ZYYTNDY2d1NGRsbXlLWkU1dVZkN0ZwT0VLTXY2ZVZaNU9PMksy?=
 =?utf-8?B?VitRSGxHRWhSVnVDaEIvTE5KWURXazdmZkxEQTlYTG1RTlI5U0dtVEloYUlM?=
 =?utf-8?B?enJmTFhXVjgzWHhuVXE4SXl0dStYRllVaXFDUlN1UkNNblYzYlVCNmk1N1c4?=
 =?utf-8?B?bnhyVzRUeGI4bWdtUmRURm5TOXlMZEpRcGEwbEgrZEdreC9oZDBybXl2cFFD?=
 =?utf-8?B?Q3VGNXdOaDhuVEZlekE4c0hxdVdRVFhlcXRTYmljbDVNU3I0TWxxUWpXc054?=
 =?utf-8?B?VTl2Z08yWUZrU3VCcm1GVXVGUk9jUS9hcmM3ZFF6SEZ4QVo5a3JJc3RWaEFn?=
 =?utf-8?B?L0xmUEZlMW1kYWI2RjdMenpyRGtabE5XMHNvaUlLcGZWTUg0Z2R3dGpNbEhD?=
 =?utf-8?B?czV1OTZTNnNCWHByd1NUZUJ4NmtsS2JiTWRWMzRZditlTTJsVDZObXkyTHN2?=
 =?utf-8?B?VW5zU1c0TitOMWNEU281bWttbGd2RUZIQjVhYTJNSDlkdm54V2xlYS9CRTdZ?=
 =?utf-8?B?NjQvd0UxUDVlSzFpMmxJWHBNbUZOd0h3QWg4QnRUVnJ2NlZ2cDZzQjVCNzIw?=
 =?utf-8?B?cVZmUWNpMVZoWmQ2Y2tmaWtSbGdreHhRWEJPQTVKR2xUZ0Rpbi84djNqYWNX?=
 =?utf-8?B?WmhrN0xGejdjcmY5NURzS0lFM0d2QWx1amRPcUQ3SVk3K3RmdVNZa3lXQTR6?=
 =?utf-8?B?ZDRYcVlKNWRtS3VmdjlValpxRnVuS0VvaG9MbkZPYWpPZWVIVEF6QU9KcXRY?=
 =?utf-8?B?bXpIVG5RbmhOeUVUVzY4c3I4NGtnSFQzNFJrTHE4N2lLMmpoeFZVb2VYSm1K?=
 =?utf-8?B?UyswNkhLa0VUcnNPRGhlZEltZ0ozT2Uvc3VuVVIwZEVQb1pUQVI0Sm56LzRH?=
 =?utf-8?B?TWw3UVhQSG5IbXpoQ3VZMXJkWDIyM28zSllRa2h4ZjRyc3lSZHVBV0pKUUti?=
 =?utf-8?B?UnpFZXNYSXNQL2o5alY3Ylo1Z3JFYld0T2lFS0JJZjZIRE9HNzltdllXNHJh?=
 =?utf-8?B?NUlEbkJsVUlrektDZUxXajVJVlI1RnVZTnoyZHpnSCs1TFpJRTFYSE1vRFA4?=
 =?utf-8?B?TmNOWjM3TkhLcGlqSFlWR3E3dW9rRWpWdE02dzJpdjRJcXM1cDc1Mk5Rb3FN?=
 =?utf-8?Q?Wli8uUJVjpRZTJDOSCsi+DJ5/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3acd3d-db26-4bd5-f43c-08dd053cfd6b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:16:06.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdgZw19fW6JSiKkXT+vXF6gQJU9IgXRTexfb+2J0Yx7dZFxvFhxqr0x63nHw8tbOCw3R/sgXUzeH+/LrySEY8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281

On 11/15/2024 5:10 AM, Pratik R. Sampat wrote:
> This patch series extends the sev_init2 and the sev_smoke test to
> exercise the SEV-SNP VM launch workflow.
> 
> Primarily, it introduces the architectural defines, its support in the SEV
> library and extends the tests to interact with the SEV-SNP ioctl()
> wrappers.
> 
> Patch 1 - Do not advertize SNP on incompatible firmware
> Patch 2 - SNP test for KVM_SEV_INIT2
> Patch 3 - Add VMGEXIT helper
> Patch 4 - Introduce SEV+ VM type check
> Patch 5 - SNP iotcl() plumbing for the SEV library
> Patch 6 - Force set GUEST_MEMFD for SNP
> Patch 7 - Cleanups of smoke test - Decouple policy from type
> Patch 8 - SNP smoke test
> 
> v4:
> 1. Remove SNP FW API version check in the test and ensure the KVM
>     capability advertizes the presence of the feature. Retain the minimum
>     version definitions to exercise these API versions in the smoke test.
> 2. Retained only the SNP smoke test and SNP_INIT2 test
> 3. The SNP architectural defined merged with SNP_INIT2 test patch
> 4. SNP shutdown merged with SNP smoke test patch
> 5. Add SEV VM type check to abstract comparisons and reduce clutter
> 6. Define a SNP default policy which sets bits based on the presence of
>     SMT
> 7. Decouple privatization and encryption for it to be SNP agnostic
> 8. Assert for only positive tests using vm_ioctl()
> 9. Dropped tested-by tags
> 
Tested-by: Srikanth Aithal <sraithal@amd.com>
> In summary - based on comments from Sean, I have primarily reduced the
> scope of this patch series to focus on breaking down the SNP smoke test
> patch (v3 - patch2) to first introduce SEV-SNP support and use this
> interface to extend the sev_init2 and the sev_smoke test.
> 
> The rest of the v3 patchset that introduces ioctl, pre fault, fallocate
> and negative tests, will be re-worked and re-introduced subsequently in
> future patch series post addressing the issues discussed.
> 
> v3:
> https://lore.kernel.org/kvm/20240905124107.6954-1-pratikrajesh.sampat@amd.com/
> 1. Remove the assignments for the prefault and fallocate test type
>     enums.
> 2. Fix error message for sev launch measure and finish.
> 3. Collect tested-by tags [Peter, Srikanth]
> 
> Any feedback/review is highly appreciated!
> 
> Pratik R. Sampat (8):
>    KVM: SEV: Disable SEV-SNP on FW validation failure
>    KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
>    KVM: selftests: Add VMGEXIT helper
>    KVM: selftests: Introduce SEV VM type check
>    KVM: selftests: Add library support for interacting with SNP
>    KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
>    KVM: selftests: Abstractions for SEV to decouple policy from type
>    KVM: selftests: Add a basic SEV-SNP smoke test
> 
>   arch/x86/kvm/svm/sev.c                        |  4 +-
>   drivers/crypto/ccp/sev-dev.c                  |  6 ++
>   include/linux/psp-sev.h                       |  3 +
>   .../selftests/kvm/include/x86_64/processor.h  |  1 +
>   .../selftests/kvm/include/x86_64/sev.h        | 55 ++++++++++-
>   tools/testing/selftests/kvm/lib/kvm_util.c    |  7 +-
>   .../selftests/kvm/lib/x86_64/processor.c      |  4 +-
>   tools/testing/selftests/kvm/lib/x86_64/sev.c  | 98 ++++++++++++++++++-
>   .../selftests/kvm/x86_64/sev_init2_tests.c    | 13 +++
>   .../selftests/kvm/x86_64/sev_smoke_test.c     | 96 ++++++++++++++----
>   10 files changed, 258 insertions(+), 29 deletions(-)
> 


