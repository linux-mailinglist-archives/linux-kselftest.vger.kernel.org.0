Return-Path: <linux-kselftest+bounces-10462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B88CA792
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 07:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7650282902
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 05:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9EF2EB1D;
	Tue, 21 May 2024 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oufSa0Xm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC9433B9;
	Tue, 21 May 2024 05:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716268431; cv=fail; b=t1MNGbX1wOXCQL0AXQ0vPSnHBTKpIhxFg3wcjt2aF4nenB7EUFYNkb7Hdbo26ZQvWh7pm+ZalC8XADIJRQsP6I6xAMfyL1SpHIBmtcxd7BTjYy402mBdpUjwAiG4VF0eaG5gO/K94KpiwHSQJySVIFq4s3z31fWZblnJjqIXDO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716268431; c=relaxed/simple;
	bh=WlaeTAwytkOsZ4IKEY6jEjNRIqFE/BzDz5Ryz8qmUm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kNeTL9Az3bQLWwQ5UfiHYSNGUok2Y/rfnc/N+/XvmMZbDHsInns+DdW3dS1LHkvr22nmqqVVaUBZpvuiQ7DoU3X7EBGpLwh17zaAlPRU0v+/HUVgX45ZZh0qdFRmc57z0qiLn5thUoVS7V4qrEQOjREjFqx2TEMpwZAA0KRnAR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oufSa0Xm; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQpCgls96ueF0sPvKyo0vxRHUdZ3gVxV8XlNbiGysU4glqTccBnj6AE6WaPEwRVNqEyP5w3blrlbYs1/FQLcPgWmee/R0SOv3RITsuETwJx2TlOBNgejd4TPds4LcyMt2sPvO/mwpogB3XqJdDIqAg/z2UgiQ/iCxVmosWSTrpFw8n1MLTMDlry55cB9vPRSFokfIeZW4GoZywkT9Ii2iTnjPItWM+4Hw2qn56Pkol0GK64Q+2Se2EDx5X3eJXf409bixvTKSWBbTwWJ6mG6Oamnz5GeK+/m6T3h36viTghuM/lLnX92v6GY2OW0IiZ85DMrBCqCAm9eoKSCDaacSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKp2/iE9hyVh35swmaQAZzMpm1tEy0iNoRwrohoGLMQ=;
 b=PfUAxjpTiS5a0ZSeBg6zTWMeCm8iaDlg6Sl0ltdynY6F2FqDeZNu1Oo2cl285FfcDCNVa67YZRnS0013imyDWHoqVYmmy2uEJgFvAjeTodo21q/H/7nkTMOHryqgY9X5UU3oXctWdqNKSZfARFdKpCaSuiLV1VELRtQlky9blZNCc4L39RmLh/BjM9eNrpdAyufqmrjkVd+x/8RVoRvP8jMhSy79TIzKvHRNcFaeiLttY1P6RqIiD6NsYF7rcm4qb5jwKDdjYcjdMtmT7vFxCckp530C8jAzMaNQQ3mmtcCTBYObEzgW68RbW4HgLTuDci/xT0EJmglS0TowD2Ahug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKp2/iE9hyVh35swmaQAZzMpm1tEy0iNoRwrohoGLMQ=;
 b=oufSa0XmPk6DFrwhMY571zmjd5tri+UhDtFwG4hiPYKV9n3kvWScjd9I4o4XPgLq/KQBfvswQ4BrYoZUI/sTqRMlWCDYg2oCDFQOP2xmCuO/C4xFlrGzgBT14pwaK4nJIN1rHKHSBfxxi+L0KlizR15vtJq9EaLXB/XoNLYOetU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 05:13:45 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 05:13:44 +0000
Message-ID: <bc7e5454-3683-4422-98cf-ab5fb492f820@amd.com>
Date: Tue, 21 May 2024 10:43:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] KVM: selftests: Add an interface to read the data
 of named vcpu stat
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 manali.shukla@amd.com
References: <20240501145433.4070-1-manali.shukla@amd.com>
 <20240501145433.4070-5-manali.shukla@amd.com>
 <20240502-c23f757478f11e7b087377ee@orel>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20240502-c23f757478f11e7b087377ee@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::18) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: e08d15fa-26b1-4a40-a52b-08dc7954c96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjZHL1R3dGFJNng4RkNSWGxMUVk1MWNucXFZQU5vdk5ac0xqV1ZDL0pvcENO?=
 =?utf-8?B?WDR2NWRuNFN3cjdXVzA3cVFsR1R5WEhLQTFSOGhWNitzL0VhYlZ6RzFCM2dI?=
 =?utf-8?B?TEtzNVR0cmtiYVZaYWpxczFKcnBoYk9rMDVtV2FDM2pEQUNmQnMybDlxcjBC?=
 =?utf-8?B?dzQvSUs4SkNzdzZHaGhJYVV6T3M5TTZ4ckdpR05Ea2ZkOWJ3bHdkemNDQkZn?=
 =?utf-8?B?ZG5mWmdUNmY2dExsSWRLVjhqZSs5KzdOUHlNYkdsV1czWXQ0ZTJIOWE0cVE1?=
 =?utf-8?B?RmxscW1zUDZyRSsxNEgwZE5kajRwWWFwZzdCQloyMWZyVXpidUpLSUJBcHEr?=
 =?utf-8?B?YmVVQVRySjRLRXdMU0pyUXJMYTZEaEszQnVpRmt2STArSW9DeEpNUWNlU3py?=
 =?utf-8?B?dmN2VXYzOFdLcjRIbS9BdUVCZ2Jqc3lDU2hNamNydFd0REdaWCtrSXdVbzNW?=
 =?utf-8?B?T1Q3NHAzbjVsU0RQNm0vaHQrSVNmTmpnR3VReDdhdmROTWtLZjEydGphL3ZJ?=
 =?utf-8?B?NFFqMFBpN2ZmcHZBMUxnU0tCa2dFNXdFQU53VnZoNXFmSjFSUEtaNE16Mkxm?=
 =?utf-8?B?bnAweWE5eEJpV0RiMGl1dnNDTFpUZEtLUXpvYXVHcEVxMHRNT3lHNjlmY0Ev?=
 =?utf-8?B?WHZZSm93MHo3RHNnNmlHK0dTcXAyZDJJSUdvbEtMcDVVVGhTdWowaFFuNE5Z?=
 =?utf-8?B?NEhFVnJ1VWZYaVJBenEwNkdIUUhKbmt1bUMyQUFXaVRXeGNkTnBRZDBGZ1do?=
 =?utf-8?B?U0lkUlRQQ0JweFRwbGV2VlJhbUlBYmFYWWM1OGxMdkZnb0phL2NyQlQrSElh?=
 =?utf-8?B?dlBzMFVFOEEvUG9LQlhzbHl5K0dYek9aeUkyNmNOQWlHVXFSRVRPRGNPbHJ4?=
 =?utf-8?B?K01XQXFINFBySGpjWkMzakFPeW8ySlZ5UkV6ZG8zS2xJM2djOUVNdTVwT1lz?=
 =?utf-8?B?RHdiODRJRUplaCtkeHJKWEJtdFRpSVNwdU5mYnd2U0VKWW0wL3JGK2RWcmRh?=
 =?utf-8?B?cXc4R0tMUUZ4R2ZEb3VmMnVtS2IwOUtQYmpwNEFiS1hxb3FrSjFVSDRaVmMz?=
 =?utf-8?B?cklyWmJMajdjYlg4ck5mUVdqS2JyN0pWcWRXc2ZrRFl1TmZZdGs0SEU1QWtw?=
 =?utf-8?B?NUR2ckMvVXdvbjhsVE9KNG5ZNnNHcFYwcFc3OVNVK0NEQVNYS0ZnR2dMNXdC?=
 =?utf-8?B?Vzh5ZVdrMFdyYlpGemdDZit0OUNWNU1OdzJHQWVDV0NRM2JMdHdNcXN4eXUr?=
 =?utf-8?B?YlJkVlRGclFETXQyWWtvbUw1Wld6Z1JpUDFLbHUrQklUeXgvTEhGTkVFamRn?=
 =?utf-8?B?cXl4a3RMaWIxeFdQQllZc3dnamhLUDV4UUZER0R1dysvNnQzcnlZcU0xR3U1?=
 =?utf-8?B?bnBpUWpEWkNQMWw5MnhacGtvQVY3ZlpQc2I0Wm1FS21IVGpxOFdrUnpFMzhN?=
 =?utf-8?B?QmRYQlJCeDA5NmhaaFIxWmxxR0NQbmVNeWVKZzZCZXF4TSsvRW5EblBkaDV4?=
 =?utf-8?B?cGxVa0YyL2hwblp6QXVmM2p6WTE2ZDdwMlhiWllXdnRaSXpPbkpPOEJRNW85?=
 =?utf-8?B?ekpzaFFvbzhsY1ZiaUFlZ2pFWURPbTRDOEpWeUc4TGxKNmRtS2paYklwMkNR?=
 =?utf-8?B?akdrbzdPenlrNjRLdml4cUgwTjlmNkhVNks0UjB0MEZwRmY1TEkzeUlzaEpC?=
 =?utf-8?B?blRzMEM2MWVmd2FaTmV4ZDZtMVBVbVZ3ay9pRS9BN1FFcTYzUXppa2pnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sjc3MWZsNDd4ZlJtS2Jmd285dExJYWtqbVQwNmcvZnF5bHJZaTlzT0c0Qkor?=
 =?utf-8?B?bW03RWgwaE1ZWHRvbkM4ZWo0OG1vT2hYZ3B3L0J6d0MzM2UxeUhTQllQekNx?=
 =?utf-8?B?bnFGb2xueDBnSXkxdWJKYlJyVnBQTjJVNVVvOXNZZnd2a3hRN0hnZkJvb3h0?=
 =?utf-8?B?UVU0UVhCdFRLSkt0N0FqMFZoRlN0WjkwVGVnOXV3NFlSS3dZdlJ0K2trZHlq?=
 =?utf-8?B?U1BzMHo1OGlsRnhWYkEwSUVhQ1pNTFYrdkp0eml2U2s0Q002cUhTZnFuYVpH?=
 =?utf-8?B?Unl4SkRONWNkK0UxQWFXLzB6RGoyZ2s4bjBjSjZCYzdpVnVxR1NscEp1ZXc0?=
 =?utf-8?B?c0ZmQSt1UWY0K0I0dTdERHRzQWpVbGpYZStOUktxMFBvV0l1T0xwKzFnM1lh?=
 =?utf-8?B?WFE2WDBMMVVHb052YzhuVnd6M2pDMTRIL0JnV2tQemxKMitFU1ZwN1J2Sndm?=
 =?utf-8?B?V2JlcmhzM09uWGdzQitPUWh0RG9IM0dpS0hMTjVxYytpMXBob2RqVEQ0cU1v?=
 =?utf-8?B?L3RnS1ZYRjdOaFRQakRZeXdGODZjWit2NFRtbjVpVGN4ZVU2SWM1bndBZFJq?=
 =?utf-8?B?THI3Z2k5TW1DMmFmWmhmSFdiMTMycjNoVUlnSjZtZzZsT0RJRXhRL01KME82?=
 =?utf-8?B?MER4Ui9zdGdWcW1FcjU1YnFwTy9oa2ZrZ0VuaWFqTHR1NFJTa3g5Rm9xTWZm?=
 =?utf-8?B?MTlrODc5Um00YitzR1pJeDA0T2V2V0o1blZSRkdJcWJ0eldQZFJHMTlqbS91?=
 =?utf-8?B?bUF4S1N4Mmo4WG1HN2x0SnZEU2tWWjluSnZwY1Nxd3czQXVQSnIydTlpVGV0?=
 =?utf-8?B?Vkt4UUE4SGhlZW5lV09kU0JRYnpxVnk2MVFndDM2d2xoSCt4VkVSZW5DVzNH?=
 =?utf-8?B?NTVnL0ZRV2x3YTBJTHpyQjJKbTJxOVAvbEgwbFAxeFVLSm02ZGN6aUl6YTJX?=
 =?utf-8?B?a1RmT0NUZmV3UkgrTFBPV25uZVcySld0THpOT08xdmVhcXpqUmNLS3hoVmVO?=
 =?utf-8?B?aGdVTG9ORWVQbjFFZ3I3VHdiODlnS3Q2Q2xWd0w3RDA3dmtTc05ydW9La2Qy?=
 =?utf-8?B?ZU9HUTNndmRGSDNTRkV4VFlJTERUaEswekIrWDJidjJQeEY2TFRScVBrTlpW?=
 =?utf-8?B?WDdiUjQ1N3pod3dvQVBHUnNiUEVSeHFTd3NOajhmM1djS1AyNG1VZWp1bzhh?=
 =?utf-8?B?Y0t6ZDNweGJUeHJuMG1kYkFSZlpxQ1IxeDdGd2x2YmtQb2F5S0V4cGZLMEY4?=
 =?utf-8?B?NHd4ZnoyQk9XcWIyMnhtVHRKUzMzZW9FOU1ZQVVZTm5LVXpGSk5wbERCMW9E?=
 =?utf-8?B?eloyckgyZGN0TEpDZTJJUW05aTBvWWs4N3BOczhKRzZXMlVyMGdOZ3cyZ2Mw?=
 =?utf-8?B?dzJrTElEQXBlZkFpUmFMdGI5cWRLT1VCekM5SFhDMXVRbGtSM0FtaC9VYmRD?=
 =?utf-8?B?Wk4xcXMvakYvZnRyMXlIMEVYZEQ0ekwvbWhkZGpyYUxqSmdHa0V1NHB4UUhi?=
 =?utf-8?B?WUI0aXo5MVhZRWNvYlNuZmdLOTc1QWdZcDMxMHVWMU1Vd1FBdFZ4cDkzNVFL?=
 =?utf-8?B?MVlnTXFIaWJYR0VuMWNiWU1raU9MN0FISDBsd1BaWmcrTzUxRFU2MmtVTzdI?=
 =?utf-8?B?K3dXaVdWQ3FQc0g2OEM1Qjg4M3l4NUhrT3dtWGZWbTlDd0RtRzhPaytEL09H?=
 =?utf-8?B?WElOeDdLOUt1SFprYng3bThtc0czQStDYXAxNy94UFBPWmxRMkhnUXpMekZ6?=
 =?utf-8?B?dTR4VTBiQWdaM21hMVA2WTROcm54MWRIeXZFVVN0VWxSbG5ZcTNUL2FHS0hB?=
 =?utf-8?B?c1JZRDZ6bGRvbHVYLzE2Ri9Da2VzVWo5bW9JUDFjQUNNYjdvL2NGTkJQemVm?=
 =?utf-8?B?VVpVQlpubjlRQTdvQ29sZnZldmUyM2xwci9HbmtNSUt6RWJGZlBFSlozbEhk?=
 =?utf-8?B?RFlLN2tKMWZtU2Njc2tZS3NIVkdtMnB0RmxZTGJ5RUlQWW1jVXVPbjBZZXk1?=
 =?utf-8?B?b1BGYTFlU3h3OE41MUt6aTI1NHQvNytHWnhMbnZSUXBMYm1rWGV5T1NSSDNr?=
 =?utf-8?B?RmVUSUZUZ3VLRTBWMXpQcDJnbUFQcTl6bTFyRHJrL1BJbnNQbGJ0cFJUVVpP?=
 =?utf-8?Q?ZxQcE43q3ELCMYZBkSgXDnNGU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08d15fa-26b1-4a40-a52b-08dc7954c96e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 05:13:44.8752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAm/3LSk2wxw7Yhu8MIMrl4aGP0ZwwGAFYCA2cj83/hbK4fw3a6WQ5sNyIO/D7tsBIRj7mzOggnF4UPfqaOfCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353

On 5/2/2024 6:44 PM, Andrew Jones wrote:
> On Wed, May 01, 2024 at 02:54:32PM GMT, Manali Shukla wrote:
>> From: Manali Shukla <Manali.Shukla@amd.com>
>>
>> The interface is used to read the data values of a specified vcpu stat
>> from the currenly available binary stats interface.
>>
>> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
>> ---
>>  .../testing/selftests/kvm/include/kvm_util.h  | 66 +++++++++++++++++++
>>  tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++++
>>  2 files changed, 98 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>> index 63c2aaae51f3..7dad3275a4d3 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> @@ -518,6 +518,72 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
>>  	return data;
>>  }
>>  
>> +/*
>> + * Ensure that the sequence of the enum vcpu_stat_types matches the order of
>> + * kvm_vcpu_stats_desc[].  Otherwise, vcpu_get_stat() may return incorrect data
>> + * because __vcpu_get_stat() uses the enum type as an index to get the
>> + * descriptor for a given stat and then uses read_stat_data() to get the stats
>> + * from the descriptor.
>> + */
>> +enum vcpu_stat_types {
>> +	HALT_SUCCESSFUL_POLL,
>> +	HALT_ATTEMPTED_POLL,
>> +	HALT_POLL_INVALID,
>> +	HALT_WAKEUP,
>> +	HALT_POLL_SUCCESS_NS,
>> +	HALT_POLL_FAIL_NS,
>> +	HALT_WAIT_NS,
>> +	HALT_POLL_SUCCESS_HIST,
>> +	HALT_POLL_FAIL_HIST,
>> +	HALT_WAIT_HIST,
>> +	BLOCKING,
> 
> Everything below here is x86 specific, but this is an arch-neutral file.
> Please structure this in a way that each architecture can share the
> generic types and also provide its own.
> 
> Thanks,
> drew

Thank you for reviewing my patches.
Sure. I will take care of it in the next version.

-Manali

> 
>> +	PF_TAKEN,
>> +	PF_FIXED,
>> +	PF_EMULATE,
>> +	PF_SPURIOUS,
>> +	PF_FAST,
>> +	PF_MMIO_SPTE_CREATED,
>> +	PF_GUEST,
>> +	TLB_FLUSH,
>> +	INVLPG,
>> +	EXITS,
>> +	IO_EXITS,
>> +	MMIO_EXITS,
>> +	SIGNAL_EXITS,
>> +	IRQ_WINDOW_EXITS,
>> +	NMI_WINDOW_EXITS,
>> +	LD_FLUSH,
>> +	HALT_EXITS,
>> +	REQUEST_IRQ_EXITS,
>> +	IRQ_EXITS,
>> +	HOST_STATE_RELOAD,
>> +	FPU_RELOAD,
>> +	INSN_EMULATION,
>> +	INSN_EMULATION_FAIL,
>> +	HYPERCALLS,
>> +	IRQ_INJECTIONS,
>> +	NMI_INJECTIONS,
>> +	REQ_EVENT,
>> +	NESTED_RUN,
>> +	DIRECTED_YIELD_ATTEMPTED,
>> +	DIRECTED_YIELD_SUCCESSFUL,
>> +	PREEMPTION_REPORTED,
>> +	PREEMPTION_OTHER,
>> +	GUEST_MODE,
>> +	NOTIFY_WINDOW_EXITS,
>> +};
>> +
>> +void __vcpu_get_stat(struct kvm_vcpu *vcpu, enum vcpu_stat_types type, uint64_t *data,
>> +		   size_t max_elements);
>> +
>> +static inline uint64_t vcpu_get_stat(struct kvm_vcpu *vcpu, enum vcpu_stat_types type)
>> +{
>> +	uint64_t data;
>> +
>> +	__vcpu_get_stat(vcpu, type, &data, 1);
>> +	return data;
>> +}
>> +
>>  void vm_create_irqchip(struct kvm_vm *vm);
>>  
>>  static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index 6b2158655baa..3de292ca9280 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -2256,6 +2256,38 @@ void read_stat_data(int stats_fd, struct kvm_stats_header *header,
>>  		    desc->name, size, ret);
>>  }
>>  
>> +/*
>> + * Read the data of the named vcpu stat
>> + *
>> + * Input Args:
>> + *   vcpu - the vcpu for which the stat should be read
>> + *   stat_name - the name of the stat to read
>> + *   max_elements - the maximum number of 8-byte values to read into data
>> + *
>> + * Output Args:
>> + *   data - the buffer into which stat data should be read
>> + *
>> + * Read the data values of a specified stat from the binary stats interface.
>> + */
>> +void __vcpu_get_stat(struct kvm_vcpu *vcpu, enum vcpu_stat_types type, uint64_t *data,
>> +		   size_t max_elements)
>> +{
>> +	int vcpu_stats_fd;
>> +	struct kvm_stats_header header;
>> +	struct kvm_stats_desc *desc, *t_desc;
>> +	size_t size_desc;
>> +
>> +	vcpu_stats_fd = vcpu_get_stats_fd(vcpu);
>> +	read_stats_header(vcpu_stats_fd, &header);
>> +
>> +	desc = read_stats_descriptors(vcpu_stats_fd, &header);
>> +	size_desc = get_stats_descriptor_size(&header);
>> +
>> +	t_desc = (void *)desc + (type * size_desc);
>> +	read_stat_data(vcpu_stats_fd, &header, t_desc,
>> +			data, max_elements);
>> +}
>> +
>>  /*
>>   * Read the data of the named stat
>>   *
>> -- 
>> 2.34.1
>>


