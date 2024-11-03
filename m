Return-Path: <linux-kselftest+bounces-21350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2BF9BA5E7
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Nov 2024 15:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094012818E2
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Nov 2024 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499FF1632C4;
	Sun,  3 Nov 2024 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zrD0xas5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41559A31;
	Sun,  3 Nov 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730643795; cv=fail; b=AG1jWhF7qHbiCRREyCXR9SzksfwfR2h9EEaEneIEzsMAeJLG+NUjsRnGidu75xauA4lEozgf0Qpb+1KLjtFdfmxSY3evjXrxlh9sebbsyHz5REhpE2kbWDhfyifXNOBzZD0/Z/xFBcwAb+2qAR1QHz3ClUwtmj4EsQEoXHTs0ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730643795; c=relaxed/simple;
	bh=R//BYe6uzIs1YqLHgTZiKmQfstjs7Q40pD1UMX0NYkg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ql4FFUFgpaxTcxnI0za/1naJKieNZtaRl3J0R0NbHM/qvIaK3pZQ8YXy4gMNckpTP7rZqYDOpThhCvKQfMi8sZDTaNubfXHW3GvU7n7xsywAN1hdQIQi1Bj15LUgX6ELhSohjFeNoNtN66JiU2O8qhvt+YwCt8voH14c2fWnt84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zrD0xas5; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjzEXD3q6zXocwEPND1FPLoB3bJxLK8cHIyoZYY0o2f52zKSX7+CxfrnWWsUQXwdy9+uFmJQNoXl4Wi617qX1O490sbjj3pkR4OAb+Psj2oNijOMOUPIMNe0QfoZVPmZRcUqQ0FNMkjKH6GIdf/CRQMBW5Vw/SnErDEQFxDkLmcsWHgHJ+GMtXfahg3MgVQwtNWsEeyP4bJWkpDFZ/lPvRqiGYFkzF0T/+b56o1GK0DSXHi9zgRUXqzaVib7X0iMXLZ9U1KgNpTjUKBoFA3i4hQ4u3EeqR5l3wdOydXo/Q0kIkFY6G1nfLYX46GjKRmpjMQKTzuSv0nzho1bFlycPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GgxN44ehDD5WQrwnzjj1T5+nSt2WCTGUiDoxJMGKdU=;
 b=eCI206+zDETy7XYZlo00K+iXubk9VM8lbNxs7Re8q+iaacJDPr+dm4l5JhE3QO4FK365evfMxplUGGsxAEHFGg5xhifDzpecc6mhjcRgwG0TrLIqynF+BwHg2zn8pkx+oyfsZE61EFDJDrWLG/U5PwFejg+ONfbLa1v7SXd45VT3sNpwjPXmL1/kkD2rjWp8Wn164g7rltQJyxdeO2ZQx0J7C6JueW4sS4n/nlP4CvJu+mVJMwUxZxiAnAmF3JQTg1J0tddPaDCyPcAxolzemiVoWOsR8PMQzwPLYkMPb9egBWc1foXuuYPO6KkmYKOFqX1Wa4329eWyFAfDrpCOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GgxN44ehDD5WQrwnzjj1T5+nSt2WCTGUiDoxJMGKdU=;
 b=zrD0xas5uc4omg6lLMfjbGcxEizJQkgM2VIlIySIS1cxlXyfzMaDMSNxAFG0nBJPgDbA40TssMPjCq4T40qCxDy/r8fe8/sLX51tM+ct41eTwWcuLcS9jvbNn4R+mYBnwe6e/rK0q8C12ZedfdRdezI5Pw8+r/W+aOeNb3bszVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sun, 3 Nov
 2024 14:23:09 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%7]) with mapi id 15.20.8114.028; Sun, 3 Nov 2024
 14:23:08 +0000
Message-ID: <74089281-3208-435d-93b3-22f1d794dfae@amd.com>
Date: Sun, 3 Nov 2024 19:53:02 +0530
User-Agent: Mozilla Thunderbird
From: Manali Shukla <manali.shukla@amd.com>
Subject: Re: [PATCH v3 2/4] KVM: SVM: Enable Bus lock threshold exit
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Manali Shukla <manali.shukla@amd.com>
References: <20241004053341.5726-1-manali.shukla@amd.com>
 <20241004053341.5726-3-manali.shukla@amd.com> <Zw6rJ3y_F-10xBcH@google.com>
Content-Language: en-US
In-Reply-To: <Zw6rJ3y_F-10xBcH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::11) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f36fc6f-8d5c-40c5-5c76-08dcfc1309ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3V2WkRIMDJoQy9ZbUZoQnlMMGF4aUI5eFJSUW9Ta3pQZ1pSRWhPT0dHVzJQ?=
 =?utf-8?B?M1dYdFVjY0tCcUNmU2VDVkorZWlPc2dUWm5mUkpNV0ZCZEZXNjQrU0tnOFNC?=
 =?utf-8?B?aGNndXdpakxhUjlNZ2tHWHJ5RVU2TDJpeHVqL2x6NExEcElsZHNURzlWYTJM?=
 =?utf-8?B?VzdwSWtyQlp0UEFPQ21tNGlrVEZhd01UbkswRkkwbE52WVdyS0FweXozbTVh?=
 =?utf-8?B?UFVtbDlIN0tJWGVrbmhKOU1sK2hUL1hHalV2WGl4YVY0TGhVdGFtelFrYWxi?=
 =?utf-8?B?VGxJNzVwRFZHbytvWlFoMWlKVnZWYnVqL1lXbnd3T3lFYmgxT1JOckhZTWpF?=
 =?utf-8?B?VXN6aUoyemwyZUNjdzlJaWtreWxITkx4TnlEQUREelkvWkUrT1JMK0xDMERQ?=
 =?utf-8?B?Tk55TGg2RFRIOFppbG12Um1VaHFJbm94L1ZsRmFqd2sxMVNJVmo0TFEwUE96?=
 =?utf-8?B?VWxIdUl3ZmJlWUhodmRmMDBDVkE0WXBBRVBmRDdPbXBRK1V5TytGRzVqWXlm?=
 =?utf-8?B?b2wwdkdpN0dUUXlTWm1xVU1mTlFSaTJlNEt5TWxzTk84VlpqRGxmV09MZ2tP?=
 =?utf-8?B?K2o2eW9HSVQzNkMrclQvbWprK1V6aW1mMmtCU0FHMzRDV0FGVWJCMFpHcUJN?=
 =?utf-8?B?WDljSTRHVVNTQnBzcmE2V01Jd01vcE5zTlZaY1BWeU13YnV0Y3graWhPNDJi?=
 =?utf-8?B?RUZUOFgyNFZtT3dOcjV5OTROZHZxNStnTk8rWGdjRUtiZjd2ZzR4SkpYZldz?=
 =?utf-8?B?VjNXU0NYTGtEdklxdDNoN0ovRlhud21zSzFrVDB2ZnhKQVBRM3kvS09hQ2ZO?=
 =?utf-8?B?ZURJSWVYR3JTVTdIcHErTWw1WkRFN1B4dmc1MWR2aDlZRGgzM1VkK0tLK1Y5?=
 =?utf-8?B?V3IwNXdqc0x1QW1VL3FYQmFsc2xEZ0pxZkJySUFSRGVWZE1TTHM3NTYwSGE2?=
 =?utf-8?B?cjh3TnM4TUZXR1plZElZTWhybmlJMXdLQ3JwLzU4ckZIR0dQQmJQZysrc0pw?=
 =?utf-8?B?MWJoc2EvNWVPOXRCYnFaaUdkWnF0L1NGNFVQcHZlQVoyNWRVVjMza0sxZ2lF?=
 =?utf-8?B?eUxYb2o0Y3lpd3FWMlUvbVNxd0QrWWllNEdIbXV4ZkVpRjZ3OXhOeEFDNVU3?=
 =?utf-8?B?QUcrbEVHZUVjUFVVbUNuZWZPL1BOUXY0NFpmdGNpYmVQSlhqUWQyK1VEZnR2?=
 =?utf-8?B?d04vUjgyRnFOVU15NnBuYXhGdWpRTzF4dFN1MDJyQUZoM3pXbUFpeVEvWFhO?=
 =?utf-8?B?NVFuNW5PTHdqc1NtanAyY2wvSmNkbGNGYUM5OVB1OVNQNWRNRHBmd1o1N3kx?=
 =?utf-8?B?R1pMM2dHTGtOYWZ4bFNRTlhqclA0NlZ4S3RZVFJGL1grUGdBanJsNHQxWTZB?=
 =?utf-8?B?bUlORGYwV3VJZ1BTT3Nua0JiWUI4eUlnbXZZdFhjdEJady9PR3o1ekljNnRN?=
 =?utf-8?B?aXV4YUtXSll4aUdwUHRzdkI3TmFaL0lzOFdOalZabVMxdysyWkQ4MEE0dHlC?=
 =?utf-8?B?WWJ1bHVlNnhKOWpORlZiU0ErVklrNWxtanZMa3BBVFZvUFh5amUwbkE2Tmw2?=
 =?utf-8?B?ZmdmWFd5UEZ5Tkg3dEk0WmpXUzBrUnJGSmswUStCdDUzVmUxTWM2QUtLV1FB?=
 =?utf-8?B?T0RsY3NGeFNZTXpUSzJld0VKdWlTZ2pWdUdBeU4xL2lMbVJsT2RXa1NkRWxk?=
 =?utf-8?B?YTlZTEZHV1Z3eEY4b1VQL0ZROHA4Z2I4VlNMUk9LYzd3eHdxY0dkQ1NxQ1F1?=
 =?utf-8?Q?gaEM03x/yqiQ6wFPWY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzZRdDJITkVKdm1zNzVoTkpTNXFxbm83Wk5TcEVDRUFNUVBJejI5NXRDZnJy?=
 =?utf-8?B?bHBrVTROYWxxWlV5VkNUeWxRNi9yWVdRUFR2WS9UVTNYOWJ3cWlkZ3ZhY214?=
 =?utf-8?B?NkpuNW92UEtabEVkWTJIeEU1MUdHSTZzZWpPREw5VmRER05POGJrdUNRTXNO?=
 =?utf-8?B?eUdQN0xPdk1jS2toZ1J1eVhPdkRibmVndkppekhvbE9rcmxQKzlWRWEwVG0x?=
 =?utf-8?B?d3ZpWEI3bTlPVDNqczZXd0V2YU9RZksvcHFrcUpvYmpmZWVoWVBhQVQzNEZ4?=
 =?utf-8?B?M044SjEvVjIvbEx4cmxBQk9Tb2pGLzh5ZzFwdm8rVTF3QWYvOUtpbFh1VEFv?=
 =?utf-8?B?Rk8zNVk5Vkd2NkJqb0QrRnBHRjZBV3FNVWIrTkpxclVpeDFkaGJuZG5tOEVu?=
 =?utf-8?B?SDhDUUtxaUlROHEvVE9waDJMNjQ3N3lzL2NicGUwV3NrMjJUaEFJNHJNR1N0?=
 =?utf-8?B?VTVmYitaN21venVRcmxXcG1xWE5oVm1TOVVscytkZ1NYdVJENnZOYjFETWxK?=
 =?utf-8?B?ZkpFS256MnJ6NGVIckRhNGRIeGJmS3F5a2RneWVFUDhFUlZvdnBMdUlQdTZP?=
 =?utf-8?B?VXBxdlZaQmVsMTFPY25DKy8waHdnQ2NveHVXMTBFSGJ3dHNvS3RHSUVpWnJu?=
 =?utf-8?B?WlRGV3g3THBJNDRuUkQvZnpidDRMdVRLVlNzYmEyRWN6ZDJsN2RNMGpJMEV0?=
 =?utf-8?B?Z3d6Skkxb0hIM1p1b1dady9VU2hvZWt5b2cwelNnemM3ZGltUGRKNHhtY1Jp?=
 =?utf-8?B?QUZPRWEyd0Zaeng1d2RQb2paZ04yeE1ScmpEb0p0dUQzK3hRRUgvOVdyOWJl?=
 =?utf-8?B?NXdQRHAxdHlJb3o3dUtudnIyUDFoWGkrMzJZYS85SWZSaGVXMThvSndYUTFw?=
 =?utf-8?B?L25KMlhGZk1ET01VRWR6bmlMMW4rWGlNUVNTL0pMSHhSQk1hbHFkTzZuTTZH?=
 =?utf-8?B?bUszeHgyc042TFBScitpbnNxMjVub2dMMkdHMHN3Z2NYSzY1WGFZRHVvdU5X?=
 =?utf-8?B?UGhBVm1CZ2oyUnpKN0llMmtVZFB4a1BqUXJGaGtTbHhzUVA1Wms1L1lxUnFW?=
 =?utf-8?B?cjNjNWF3Z3dOd1dENnl4eUZBbCtWSnpRbERTaFdBNFg2dHRzMW1PckZXTEM2?=
 =?utf-8?B?ZzdRVWMxMGJGVTNuWWxLVDMxd2wzcElEMXlIdVg3aFByN3o4K1hpTjhwME9W?=
 =?utf-8?B?bXQ3bm1oc2FRNzUydDFGK1IybGFxRG01bURZakpJdkZkei83VmZWb3VMRGRQ?=
 =?utf-8?B?bmcvQkI5R212dG41SmRQdWtnN1VPVy9wRm5aM2lTbEd0MkdDdmlEVlJXSzZ5?=
 =?utf-8?B?c0Q5NlNNVzhKZ0VFaWpvczhDQmZWYTM2Z01rT1JUajV2MytLRlRQdGFsMXJl?=
 =?utf-8?B?RVdJaW1IakhsSC9VK04rcVFmcENFbU91ZEN2SVAyemtnZUhoSG9uRTBEMG1H?=
 =?utf-8?B?TXJBVkNTL0VBODl6OFZjTG9MaHVKSGY2MDZmeGh3OXp2VkluNEJ3ZkdWNDFQ?=
 =?utf-8?B?cWZtRmNYUkFRWndDNTFNMHVkNlRVcjNNT1JpdGYrMEEza1BwZnpBMUdQUFM2?=
 =?utf-8?B?a1c1VXNDUmoyWlZpVzVxSFVHMTF6OURhUXljdFBNTVh0dmVoQzUvNnNFREl0?=
 =?utf-8?B?eWVMRHJMYXRGZDl0T2JjcUphaC81TFVheUgrUjZReHgxeHkwb3FoYzZrNmxw?=
 =?utf-8?B?bzZMQU9wcWFyTmRSSitFQUVOOFpKRDhiMVlUdnEyMG1QbW8xc2FOTVBBRGtn?=
 =?utf-8?B?WDhLY1hyMnZ6Z29UdjZPN3kwblZjTVRVcjJSVk9KSGE0d0h4Y0lsY2o2MFZm?=
 =?utf-8?B?K0MvQXd1WW95RGxEeUowY2J3U1VJRG5qUE43VFVLaU5yYWE4ekRHcGwvQ1BR?=
 =?utf-8?B?MjZCTVdrek1zRUNpWTRZVjRCRXFkdW4vMjIvOVVrSUFxNms5UTVIWTJudSty?=
 =?utf-8?B?Rzh6MGpkZmFqam1icWxsWmhpbWhYQTcxMmpTZUNSenlBOVROclkxT0paQWNo?=
 =?utf-8?B?RGJlZG1HRHZBL2Jqb091NmxjOTVDSm55L2lXYnRNZVYwdVFFcnFuL3BuZDFC?=
 =?utf-8?B?bWJNYitWdjNuL01kazd0Z0VIRGhBMDZWcWxmL3BVT0ZGVkFsZWxCN3lsekVC?=
 =?utf-8?Q?cYLPTo7Z+RGKk6BvMJJMuSuWA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f36fc6f-8d5c-40c5-5c76-08dcfc1309ce
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 14:23:08.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3JtgXv5JfW/3mOuEZTP+0lnazMmJlFrDakxDAGBeduZRexkYdt77urV6x/vo8Rzq1o750coXykHyT7Pm7u1Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

On 10/15/2024 11:19 PM, Sean Christopherson wrote:
> On Fri, Oct 04, 2024, Manali Shukla wrote:
...
>>  
>> +static int bus_lock_exit(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +
>> +	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>> +	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
>> +
>> +	/*
>> +	 * Reload the counter with value greater than '0'.
> 
> The value quite obviously must be exactly '1', not simply greater than '0.  I also
> think this is the wrong place to set the counter.  Rather than set the counter at
> the time of exit, KVM should implement a vcpu->arch.complete_userspace_io callback
> and set the counter to '1' if and only if RIP (or LIP, but I have no objection to
> keeping things simple) is unchanged.  It's a bit of extra complexity, but it will
> make it super obvious why KVM is setting the counter to '1'.  And, if userspace
> wants to stuff state and move past the instruction, e.g. by emulating the guilty
> instruction, then KVM won't unnecessarily allow a bus lock in the guest.
> 
> And then the comment can be:
> 
> 	/*
> 	 * If userspace has NOT change RIP, then KVM's ABI is to let the guest
> 	 * execute the bus-locking instruction.  Set the bus lock counter to '1'
> 	 * to effectively step past the bus lock.
> 	 */
> 

The bus lock threshold intercept feature is available for SEV-ES and SEV-SNP
guests too. The rip where the bus lock exit occurred, is not available in
bus_lock_exit handler for SEV-ES and SEV-SNP guests, so the above-mentioned
solution won't work with SEV-ES and SEV-SNP guests.

I would propose to add the above-mentioned solution only for normal and SEV guests
and unconditionally reloading of bus_lock_counter to 1 in complete_userspace_io
for SEV-ES and SEV-SNP guests.

Any thoughts ?


>> +	 * The bus lock exit on SVM happens with RIP pointing to the guilty
>> +	 * instruction. So, reloading the value of bus_lock_counter to '0'
>> +	 * results into generating continuous bus lock exits.
>> +	 */
>> +	svm->vmcb->control.bus_lock_counter = 1;
>> +
>> +	return 0;
>> +}
>> +
>>  static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>>  	[SVM_EXIT_READ_CR0]			= cr_interception,
>>  	[SVM_EXIT_READ_CR3]			= cr_interception,
>> @@ -3353,6 +3374,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>>  	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
>>  	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
>>  	[SVM_EXIT_INVPCID]                      = invpcid_interception,
>> +	[SVM_EXIT_BUS_LOCK]			= bus_lock_exit,
>>  	[SVM_EXIT_NPF]				= npf_interception,
>>  	[SVM_EXIT_RSM]                          = rsm_interception,
>>  	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
>> @@ -5227,6 +5249,11 @@ static __init void svm_set_cpu_caps(void)
>>  		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
>>  	}
>>  
>> +	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD)) {
>> +		pr_info("Bus Lock Threashold supported\n");
>> +		kvm_caps.has_bus_lock_exit = true;
>> +	}
>> +
>>  	/* CPUID 0x80000008 */
>>  	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
>>  	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
>> -- 
>> 2.34.1
>>
 -Manali

