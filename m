Return-Path: <linux-kselftest+bounces-27913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719D4A49CA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E491884D16
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB1E27183A;
	Fri, 28 Feb 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bR9KuiVw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184F183CC3;
	Fri, 28 Feb 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754708; cv=fail; b=QEZDdCbLZz4PmvTeN8uwkasZmmq54eYs3OMjR5QcToSzYetdCcbH4b3Rlym36je0cN9b2NxqnuVJFMcTQQDM+n2zTvWem/rPNzqTokNMPgfIXNWqBtRNc0we9LyQeIYSqtjwzGXk2jeqtclqQFGCNUXr7dskTz+sCAxPnVbmx+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754708; c=relaxed/simple;
	bh=/zYmCxQAi0JtZMDoO4slFzhWKw3hH9ZW/jMI8qaT5RI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZVzeAK1mOYVbxgosFTfOCuFGKgBtYmHVJMK9CqVjQURZrfQ14UVt/L6suC0ix06A8XRowLdrzfdCOlhnqvOLDFxRz6QF/xcI+JpnesRd9iEUozQNvSZcooC4oqhvSrOS3myAku2kcOxBo02ELS6WI+9pH4zZKqOu6SXeqI+8kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bR9KuiVw; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFqElGHNj/bQ5sqAgZBQ2c9I+Dm0MMEilfque7A1ZT8SDqTZx0U9FxvLb2bpIfsflxs3xXt8uXkEdS7qYjTAcXS2MwB8meeMzdS+j3p/TY0y+gsS/gLEvv3spTtNqu/72FHvY8I1SofEvj28i1UIfctzNHs+35fszIMS1qZuBBNlZGyOoh3SshpDhoSXnI96Sb8xkjWIq94xHbA/9/I9sPucN7RwcuIk9L9SJZfgggeyk+QfJDFAZ89HARiDvxcHl83oj334FwstXnU7cWXe/xK2iQcHZyQcm+kEqaF+MYhfDg/gVDu50g8VYX6OvgKqb5gyFp24p9ccTTL9wRCChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcfhMH4tQnwZFEfXOnC5rSicDG1UYIKgxoMK/rQLfq0=;
 b=PowLXPtmLmx8ymDFuvGQkS26gaPBDJ3h98TWjeNuO/7zMATYOOg4Vra+LHCD/HJ8QOOUBPNyAOhZq724fzVWVp2ikjLLlDnWCNMcoqi5OtC2cdLGI28AAjPURZIGPLMaKUaaL7M1HTARbulCRRB2/kavE20Y+IOtZOJLhpUCJaJm6kDKsU/6r155u1NseSHJVk7ke3RL8kEVbcnkOws/wTq/siZMhc39TUC1bxKhjKLmf14krIc+w4gwxC+uljtwHThApJKrZ2NgLC3dnl0wVpOgC0OMcuPNLYnd4jN2vOoA2RXfdIBQxOPEc5DkSUjsQjSJC+3YF/NNIAWJgW8cQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcfhMH4tQnwZFEfXOnC5rSicDG1UYIKgxoMK/rQLfq0=;
 b=bR9KuiVw52fiZ04z9I8acy9rAMeinlkJ9aWQUJg7LVjPA0SDjeDAWO6v/VSj/F3plDlYqcf3yGQx7Em848Lyh/FrEMNPtYe8+G9UYx15mIBrs/rxTNv3ijaVwsXcHGL1bAk0L4hhPZCO6PNohMKFsWY/cDnet7TMPzrBcsoUoxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 14:58:24 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 14:58:24 +0000
Message-ID: <0e510d57-571a-4176-8a0c-999a5dd55e66@amd.com>
Date: Fri, 28 Feb 2025 20:28:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] KVM: SVM: Add Idle HLT intercept support
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, neeraj.upadhyay@amd.com,
 Manali Shukla <manali.shukla@amd.com>
References: <20250128124812.7324-1-manali.shukla@amd.com>
 <20250128124812.7324-3-manali.shukla@amd.com> <Z74_HQaQ1jY4eKBB@google.com>
 <454ba4ae-4be7-49ae-a9b9-3b25cad8433a@amd.com> <Z8B3l8VGA2RHRI1j@google.com>
 <9e35b27f-affe-4345-8a87-07f4f285b63f@amd.com> <Z8COoix1SiBV-AFW@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Z8COoix1SiBV-AFW@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e01770b-a7d3-4e39-ceff-08dd580859b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG5sd0ZiS3JNT1BlKzdQekVSZzZzdGgzcUtGWTRSOXdreVB0eGJXbGo3cnFh?=
 =?utf-8?B?Qm5nQ3BjVTJKVENscXVLL2hZU2hTWXpKdFZmR09Za21IdytqSTNuTnFSNXlq?=
 =?utf-8?B?RGt0VmN2Y24zamdqV1BBYjlEdDBTNCsxYjRqMGJIVVcrRzQ0dU9iTmUyUW53?=
 =?utf-8?B?TUdiOEdRak9qSE9rNFNiay9wQWFNaGlZSmVmcTJkR01Ydy9GMzBWQ1JoYVR6?=
 =?utf-8?B?cVhYQ1JLVWd1SXdhVmNRNThTbCt1OEorazdMY0kyNjQxSGRLL3AwRlF5NVNq?=
 =?utf-8?B?d08rNkxxRDBvc2VUcWNpaFNQZEVCM0FYUjdmeG9CTll2TCtPbGxKQmlTY1JC?=
 =?utf-8?B?czlVVDVVNjhMT3N2dUd6Tkw5NUY3bWNJYTA3Wks1bnpHVTFFblhPMGZDbEFR?=
 =?utf-8?B?TVpycmQ0RjBsRmx2NmhlQzErN1RHUFF0VHdJNjcySHFYbUV2dExrTFltUjcv?=
 =?utf-8?B?VmVRRDNYYTJzRDVQeTBpMDIwOXpBRmNzSG9vSXJ3YUgwTFhKMWxvTXZRcjJi?=
 =?utf-8?B?NHhWRHg1VXh1SG5wVWRWZG82c1M4bnRuQU1tYkNzT3g1VDljSS9ZbU5QUncw?=
 =?utf-8?B?SVFrOXRWQ3pLMUNZL0hTUFdMRzQyeVc1bVVrOVkwMG9KZVJWVC9YekwweGc5?=
 =?utf-8?B?TTlOajREUG9SejZwUlVyRFlISndiSlk2WE1DUUNhV2kzMmgxZ2tDL3RyQkts?=
 =?utf-8?B?U3puWXNwWnA0Nm5PZ1BoVTM0VHN6by8zNHQ4bzltb1QvYW14SnRncUE1cExa?=
 =?utf-8?B?bS9hR0VrUENhNnR4S0J6Z1VaUHJXcThGVVBDWjgxdnUxVUYvZUs2SE0wdzZF?=
 =?utf-8?B?aDFTVDRtejdubjgrVTZOZTcvOGxLaTdiU21zNGxRaGFjYmpqWkRlU3dBd2JK?=
 =?utf-8?B?TWxwVCsyelkvZGRxYmZtcXcyZXEvemNlb3pOcEJqMnBNTW9DSEVpeERCaC9K?=
 =?utf-8?B?RCtuM09hUnczQlo3OXRNajNkYkY2ZWdkbVU3MWJZN0I5RHRlT1lxYStqaHo2?=
 =?utf-8?B?Uy9mOCtIVzNNYk13VE42blN2Rlh5VWI1WjJYSS8rSzE0ZjRyekZhWXlQdGVD?=
 =?utf-8?B?OXNmelMxTGhVZnpyMDJRUkljSnVCdzZmeitENmtXUjNnQlM5VjNrYnZub3lC?=
 =?utf-8?B?blFabEQwNUE4NkMyY2hYQk5nclVST3pKY096QTkxRWVpcG50ZHZZeG9DOWxT?=
 =?utf-8?B?K3BkY1RKNGU5TDRHODd1V1kxZitwUE40ZXJJTEJZMDl0MGlZWjgzYTlJNDNW?=
 =?utf-8?B?VUVQSTlObzZROEYvYzlCNmU2VUx3L2I1REc1NkRITndFcE1aM1Q3dERSUnBq?=
 =?utf-8?B?d2NIZmVOT1VscU1HYUVKblVyYmt1Ykp0ci8wc1Z3UzhidzRlYXlmWmtaRHc0?=
 =?utf-8?B?Q1pJTmFYMzdWcGl4dU9qa3d3Nlp3dmtWS3ZaWEhpN205dXExTEZMeHBNM0Zn?=
 =?utf-8?B?QkZLU1FOWXRiYmNCUStyV3lzcml2TmFPWXlXbTFvamFTanErWGh0ekIzdDdv?=
 =?utf-8?B?cnFhblUybGkvY09wcnpHVHVlMHk5NTkvWlJvbXQwMzlCZjdNTWQ5UmRuTXZq?=
 =?utf-8?B?SWZTREMwTFJZLzQ0Q3V0dVBTTEpabGY3alJ3OS9aZUQvS3Jrd0VUUE1qNE5D?=
 =?utf-8?B?QVBhZ252MGwyQjRNZER5M0c3enk3Z0lTNnM2YlQ1V1dhQkhXU21LYUNXcFBh?=
 =?utf-8?B?cmVSQzdVblFRMVhOUGtYWGRsS3Y4YVAvUmsrS0FIWXoxSFQ4cFRGelgvZXJM?=
 =?utf-8?B?WDhrWmc3bTBnK0k3QS9rblRKei9BanVTbzNBRktISnFGMVU0K2RnbnhwWWNk?=
 =?utf-8?B?VXlxd3ZlZVlHZkJwUWVLejNKY2h6UFFHUWI0cWNaWkU0UzFyNjVZSGxQTmts?=
 =?utf-8?Q?C4v0iUv1I8bYB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW9tK3c1SVVpSzJuTm5qbGRZOWZGY2lPYTBHM3AzYnBCRzZZVldvQkdidDBm?=
 =?utf-8?B?Tmo3Z2hJMjE5eW1wVm1UR3lEZUxnZC9JRE04MThZa2JCbktnb3I5NnpMTkJs?=
 =?utf-8?B?bEFFUzlSMWMrVkgrL25LMUV0UWNhT3NzS1lrYmFNalkzam1ZTEkrQ0NYaURV?=
 =?utf-8?B?T0MrWE85NjNZRStUdWJMS2JjNDlkWStIM1hIOWRaUURYdFdnZlNxSkdKWmhV?=
 =?utf-8?B?bzU3WGxjWng5YzNTRjdITVN0V3h1bkl3Q002TUp0VlJadlBrOTZVb3k4VVVG?=
 =?utf-8?B?alVwR3ZScy80a1F1VCtFanZDS3FUQWVWamtWVWprWWsyUUtXb3cxb1QwaGc4?=
 =?utf-8?B?YjNUeGhvWlpuZzdHTVdEQjB2RjJySElEcWt3ZndoNXRCV3RuUktGTUlWN0VV?=
 =?utf-8?B?d05XVWx4VTBGWGlxTHJNbDQyTW55R0swVHk0T1c4UlVHTWg2cUtFNzgwUE9W?=
 =?utf-8?B?S1FaanZaOXFMbFFsVFB3QUU5RVBwaVljSEN1ZHZKVkdwMFZMVmFpdmxmYmVE?=
 =?utf-8?B?aFZjaUV3RHZLc3pXOWU4bGMyUmYwZlhDTU5CQTNUVjI0R1dzbUFLcDBoejFF?=
 =?utf-8?B?N2FBK1orL3UwT0dNcGdabGViTE9rWDZla0o1bGZPVmx4RnBEMndtZmZxQzdI?=
 =?utf-8?B?REdoSTNuYThrY0MyOWlzK2NGK0VoWDVTZFF5cG9JTUYyU0o2TmpkNDVWeXlZ?=
 =?utf-8?B?eW93Q2dpMWt5KzlqYkRuWjZGdVRTcTJKYW5JZU5KYlNQVEdTVGIwZFJhMlJj?=
 =?utf-8?B?VDRBd09YSHF3L2tua01MTXJXSktUdzRtK1VoMnB6SlBSZEppWnlJY3BOaDFP?=
 =?utf-8?B?VWtFMk1kWlBOc2lSV0hXSEQvNWVpWFIrOFU3OFRZWDViUTZaTjVTS0xmTEFX?=
 =?utf-8?B?MWZMUzZCN3EwRlV4NTNMWlg2TWtTVElRVEI0RVBkWlI5YUkzc1lkRVA2Wk0x?=
 =?utf-8?B?TWVZNE8vZ3QxVTFwSFVqR2hKL0RscDBXTXdnQ1hwVStma3FZSHBZRUdaSUEw?=
 =?utf-8?B?aWZCL3hHcy9TalV6OWRqR1kvNFhIcjlhUldFcUxvQVUzQlFPRHpZeCtLVURN?=
 =?utf-8?B?aGdNc1JvTGEzdGVDTVFkMzRFN1NkUnFtNzhLaEVXUnFObk5RT2pKUHJSZkhu?=
 =?utf-8?B?UXArQS9KOGhqdTdDc3lvMDAyRWxhR2dLSnp5MmF2eEFjZTFBdGozbWNiWFB5?=
 =?utf-8?B?ZVFVZ2tZMTVOZkdFMFJ6enpkL2dBTzNrU2UxOVo1bjRIZGU4d2ozaGpZdGho?=
 =?utf-8?B?TnZuNGxCYS9QYlRWTTkzdzRiVlY0MDdRR2xudkx5a1BxM3BXUGJIWkZLb0ZR?=
 =?utf-8?B?amZYR3J6MXZoQkUrd0dtb0ZsYUMvUHN4dVFtL3p3WHlHQnZSMnZBTDZHenJw?=
 =?utf-8?B?M0dhT3d2SHRoVkRPODFLdGNGK1dieEFuRm0rMVN2bjBWeW5FY2Q4dVRjOHpT?=
 =?utf-8?B?QmNGSE1URm5ZRUhhNkQrZ3RHSjkvc2xXb0xLeVllTHNWa2czNUxxOFVHQzhL?=
 =?utf-8?B?Zmk5alNLR2lZVHBISGlTVmUwdXZ0SG5nWlRhc0lZYVh6TGhONUtsTHZlcEdM?=
 =?utf-8?B?MTdNak1yZHFUZW1KRGxUUTU4VC9lcnBhWkR5bFB6NGJrUFk0Tm15R0k0MU1W?=
 =?utf-8?B?dXBka3NzbDFUSEY1WDBSdzUyc1g4SDFMdlpTRWdHVmxaL0xVY0pDKzViVGRr?=
 =?utf-8?B?QmxadHIxWlI4NExxSWJWUFlJcUt4YzZFYmkreUtqTVRFVU93NDFObWkwdGRQ?=
 =?utf-8?B?dUJsNkNzUldGa3lpQll6MkhwK3BQZ3FVeFlIWHVCTEVHN3BYSEpBZm9LM1Iv?=
 =?utf-8?B?OTFCRTZoZ1lEdmRLbE5oYzhDSms1bW04TmRWZXVmUGJLRCtaTGJZYnlWdktp?=
 =?utf-8?B?cUkzVk1WZENuVVd5UW1aTmlIZXhCSldJRXFKdTUrN0VadlZJS05OOUxwZ0RS?=
 =?utf-8?B?a2xPa0EvYVVzdmVCYkhSQ2hIZmN0QWNTdmpmOTBocWRlTGlJNk5kZjFRSEJX?=
 =?utf-8?B?b2pEN2x3M0hlV3F2TFFOU0ppSlZ0b1RVRmZTb3BibG5kdG9QemlzaWVqL3J6?=
 =?utf-8?B?SFFNYnREZ3lvd0hIbEd5WVloRHpBSmh5RzBFSzg0SWlTQ2c5RGJpSFdHUEZr?=
 =?utf-8?Q?h6N4FvdX/eRyhiuP2c95kXfWv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e01770b-a7d3-4e39-ceff-08dd580859b0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:58:24.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ED57v+RMfnktupTQvfWiHHwC7zJPSsdDNExUGOBHG7weKxV+WuLNPHvwymEncSOui7gZNHXkqiUv9pTlGOYjwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965

On 2/27/2025 9:41 PM, Sean Christopherson wrote:
> On Thu, Feb 27, 2025, Manali Shukla wrote:
>> On 2/27/2025 8:02 PM, Sean Christopherson wrote:
>>> On Thu, Feb 27, 2025, Manali Shukla wrote:
>>>> On 2/26/2025 3:37 AM, Sean Christopherson wrote:
>>>>>> @@ -5225,6 +5230,8 @@ static __init void svm_set_cpu_caps(void)
>>>>>>  		if (vnmi)
>>>>>>  			kvm_cpu_cap_set(X86_FEATURE_VNMI);
>>>>>>  
>>>>>> +		kvm_cpu_cap_check_and_set(X86_FEATURE_IDLE_HLT);
>>>>>
>>>>> I am 99% certain this is wrong.  Or at the very least, severly lacking an
>>>>> explanation of why it's correct.  If L1 enables Idle HLT but not HLT interception,
>>>>> then it is KVM's responsibility to NOT exit to L1 if there is a pending V_IRQ or
>>>>> V_NMI.
>>>>>
>>>>> Yeah, it's buggy.  But, it's buggy in part because *existing* KVM support is buggy.
>>>>> If L1 disables HLT exiting, but it's enabled in KVM, then KVM will run L2 with
>>>>> HLT exiting and so it becomes KVM's responsibility to check for valid L2 wake events
>>>>> prior to scheduling out the vCPU if L2 executes HLT.  E.g. nVMX handles this by
>>>>> reading vmcs02.GUEST_INTERRUPT_STATUS.RVI as part of vmx_has_nested_events().  I
>>>>> don't see the equivalent in nSVM.
>>>>>
>>>>> Amusingly, that means Idle HLT is actually a bug fix to some extent.  E.g. if there
>>>>> is a pending V_IRQ/V_NMI in vmcb02, then running with Idle HLT will naturally do
>>>>> the right thing, i.e. not hang the vCPU.
>>>>>
>>>>> Anyways, for now, I think the easiest and best option is to simply skip full nested
>>>>> support for the moment.
>>>>>
>>>>
>>>> Got it, I see the issue you're talking about. I'll need to look into it a bit more to
>>>> fully understand it. So yeah, we can hold off on full nested support for idle HLT 
>>>> intercept for now.
>>>>
>>>> Since we are planning to disable Idle HLT support on nested guests, should we do
>>>> something like this ?
>>>>
>>>> @@ -167,10 +167,15 @@ void recalc_intercepts(struct vcpu_svm *svm)
>>>>         if (!nested_svm_l2_tlb_flush_enabled(&svm->vcpu))
>>>>                 vmcb_clr_intercept(c, INTERCEPT_VMMCALL);
>>>>
>>>> +       if (!guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_IDLE_HLT))
>>>> +               vmcb_clr_intercept(c, INTERCEPT_IDLE_HLT);
>>>> +
>>>>
>>>> When recalc_intercepts copies the intercept values from vmc01 to vmcb02, it also copies
>>>> the IDLE HLT intercept bit, which is set to 1 in vmcb01. Normally, this isn't a problem 
>>>> because the HLT intercept takes priority when it's on. But if the HLT intercept gets 
>>>> turned off for some reason, the IDLE HLT intercept will stay on, which is not what we
>>>> want.
>>>
>>> Why don't we want that?
>>
>> The idle-HLT intercept remains '1' for the L2 guest. Now, when L2 executes HLT and there
>> is no pending event available, it will still do idle-HLT exit, although Idle HLT
>> was never explicitly enabled on L2 guest.
> 
> Yes, but why is that a problem?  L1 doesn't want to intercept HLT, so KVM isn't
> violating the architecture by not intercepting HLT.

What I initially understood was, since we're not showing the Idle HLT Intercept CPUID feature bit
to L1, to fully turn off Idle HLT support for nested guests, we should completely disable the 
Idle HLT intercept for L2. So, when L2 runs HLT and L1 doesn't intercept it, it should trigger
an HLT exit to L0, just like it does now.
 
But after thinking a bit more, now I get what you are saying. KVM has enabled the IDLE HLT intercept
for the L1 guest. So, when the HLT intercept is turned off for the L2 guest and L2 runs the HLT
instruction, it does an idle HLT exit to KVM. That way, KVM is working as per the IDLE HLT design.
And as you explained , the existing buggy behavior is also avoided with idle halt intercept
being kept enabled for L2 to some extent.

-Manali


