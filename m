Return-Path: <linux-kselftest+bounces-16559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3C3962D04
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 17:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79067B2441A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322271A38D6;
	Wed, 28 Aug 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oU5J48lm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692371A2C38;
	Wed, 28 Aug 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860378; cv=fail; b=mGu0CfaSMmbEvFJqoR1wFg+NGsiBwf2r3+zyLL/y/zp+FpFG6pzJ1YvsGkTmvz1fL4VqGAi1q14SiWiBI1gNtv73A42TKZ3FJcMLtzKO1ZTv4WQpEGI50VBi0cB2LDrrjxFMG7bBvTrT67h0nsusUz3msTjAhoIk5iBmVFkeM/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860378; c=relaxed/simple;
	bh=3VJ3tXjVFWI5YaIp1pU0PcK8vOM/DvlqJrZPXSG1Huc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TkvNKget/KFUfVOAV5drd5MnV5U+zx1qFKSAwha5IXGQbW0CnC46QFtyxuLPUxkMIGXKSrvR65nSmACpFpCJcIcwyRSkR54l9hQ/+DSBm1YvOTKkD0I+B/+6UbRTiSYlQmKH/R64RF+FZHhhfrJdNlsmC6ssfMQGs6cA+41r9wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oU5J48lm; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlYq3O396hDaTTiEjqdc5nHyPLI5EjTVgp2QgLa9ybd+JIiKSUalevIbjjpfJpczH1Y0XTKd9XeEXEIEjb0e0SQfo2PWgDFqNzJ2I0NgUt1fZzdhwQAL4nUv5hm3R8p9BJUDwF5e+O1AvZDCEjtXdDxA3vSJM6cCYoe5GTokCas2oRewLfj1QkLkFeisbB2A/OpUKl0eNTdie/keLJOg6FEQShqW9R4RBPVQyzmWHBvqgse64R/cfXd8F1wxOiPkgpSUlFoDKn4lxaH/s2XnCkiT0yePvZe7MTmOpAAttSi2UPhE1e130JQg1j66LnOKrZGwfGYCaLBPYfuKmW6zeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSU85RHVOuVLE9yV1hjzkBowHkLGr6pc/3OZcaAdfhs=;
 b=FLu6ceITXBKEFmfrdfo3ePJ99HlW1zE6b4/ExDV/W9NEqHCNMevrAQKai/uFEA09K2ZuVyBNrN8HBDI3/H1NnXFhovk6RxX3Ef2TUIXIOSJU299IrljnccIAR26EAuvBOEhtmnTfhEf7/8Ywak3vQySVVUQyUfngEMgBwKhUrGpqAATVaY2s++FlAoLaEdBbBzsjPXKXCkqfKOSD8JrVB62imEgHDs5wV8nQaQjdTVbmytZjF7tG2iKeQGiJHNwrjry+s62BGtvQB+ri5xagNjMGN0/HRfDbgI4X2PMey7+064Lo9EFjKZQvCGoZWcnTwk5YOAFS8+j4LX4jR1fV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSU85RHVOuVLE9yV1hjzkBowHkLGr6pc/3OZcaAdfhs=;
 b=oU5J48lmtRb/qbbakwK2TO1EvjB0CLrFK1NzjZsfkCwoymBRQLQ345Z8GfCWX52f/cmdkekQyj2dRs9eU+CfoqCkS9LIc0Gna0SyT3mSuDGR85JgYcI4zEj446AxzfoD/imD9tobkhsA9iILBGJf93Nd7la8uYJrz2CrPE0lgJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 15:52:53 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 15:52:53 +0000
Message-ID: <017bed8d-c4cd-46a1-89ea-25dcbb20c7b4@amd.com>
Date: Wed, 28 Aug 2024 21:22:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] KVM: x86: nSVM: Implement support for nested
 Bus Lock Threshold
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
 <20240709175145.9986-4-manali.shukla@amd.com> <Zr-xGHQJXc-S_jTP@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Zr-xGHQJXc-S_jTP@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::6) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 97299d4b-b4ed-4b02-7827-08dcc77979eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGdpYXZoaGhnOUphV2lNZGhQdXp3ZUhhQjBHZGdlRjZWVzgrdmpIRlBxZ3E3?=
 =?utf-8?B?eE1vU0tzQkJLNFZobXNjOGg3U3piQ1MxRkpyd25VeEZnaUdhWmZjYVdaMnlC?=
 =?utf-8?B?YmFSelI1MW9NS3BmelI4M015all6aEdoeW9uNnBsYnZrWDUxWHNPa1V4QnF3?=
 =?utf-8?B?bjB0V2IvTE4rRFc4KzR1YWRRQ21uY3ZxbzZDRXFNcXc3dFdZN0cxWWZXS3JS?=
 =?utf-8?B?d3A1cWNUZHRicXBWYzJSZGk1QldmT29CWFRqODdxWEdsYTgwemxpbE9sZXBL?=
 =?utf-8?B?clYraGlGS0Q4VkhxVFRYOWtYTXJjc2VES2Z1SGJHRGFCWmJsSlJvSHZJKytT?=
 =?utf-8?B?RFFNUlI0bU9JeEV3QjhSTGZIKzVTanFMeVZhQW0zenh4c09GSWZwUk1ydTVJ?=
 =?utf-8?B?THhqSnhEekE4VzRYNVhTczQ2R1dvaVV3WHBLNWhFblhTTkRZekNZWko5QnhT?=
 =?utf-8?B?MEVFZ29HZEhlUVN6UGgzUEx5aHdEQWdSMVR6UmFKSGJGYU9oelFIVk9FS3h3?=
 =?utf-8?B?ZzFEaWlpOVBBcWl0WFNYN2EyUUxCZFNkTkFPdXlUQkZ6aXQ3cFVaMHJiS0Jr?=
 =?utf-8?B?c2tTZS9YakU4b2NlMDhGK2xSVkp5VVlBZ1YyMVBzdzgzZE1NTldXRUdDMzQv?=
 =?utf-8?B?Y2UxaXJ5M1IvZlBheUI0TWJFc1V2QUJKcVZUcXI1ekI4N0lzcnRyK2pDZVlj?=
 =?utf-8?B?bHp0S1lCNDdzajdzbVRKMGo4YjFMQThMKzNHb0tYMzNWNGpocWhiVnp6T2VO?=
 =?utf-8?B?b3NyNXZHNTVlanJrdEtSYXNnS3BUMFlFSGYyL1hBVFphV0dUazZ4RjVraXd0?=
 =?utf-8?B?c0RvWFlzY3QvZ3prV0ZSWS9pazQzaVpERnJTQm15ajNiWnNoZVBIR3ZlbmZJ?=
 =?utf-8?B?MCtnQytyVGw3emVNaTl6WExyUXlML1dmY3RBK2xUSk5YN1FLaXhEZ1hMNmZL?=
 =?utf-8?B?UWJNUEs1WHB6V2tVR0tvYy9UWGgzMUp2L3pUY2dGVFlGYU0rVUdJcWlraDRo?=
 =?utf-8?B?ZG1GQ0JKdDVBbmxjc1ZwdXlzUjdyNmZaTTJYemtqVTh3M3pYRlNhZ2NyU1Js?=
 =?utf-8?B?MEoyZGtOaFdBMXBFUzZCSjF3K1JGb1ZXWkdjdUdiNGl1MDROS0hjNmZFT2VR?=
 =?utf-8?B?Q3ltK2xVVXhPUW1FeUlRQ3pqTFdkK2V6WlVPb0xJSHN5SllsWDg4MG94WjZu?=
 =?utf-8?B?TmVhL0FnR3ZCMGpSbVVRZzRpWDI5bTBvZzFmYkRmdjNrR2ZKWTFwMGtHM0dy?=
 =?utf-8?B?SGxMcGduV2JNd2xnVmtGbng3VUhPZjdFWWhGUkFkVjVObzVuaTRzbWIxaE11?=
 =?utf-8?B?UmpuT2tVRWtGcjJRQkFUNjlHdnJwODAzcSszdk5FZlJQMlBxcFdvV3FuekF2?=
 =?utf-8?B?ZmU2NHhIT0lLOFNhQ1FEbE9tUVlVWkhwYzdJTDdtY2lja210NHJMMk0rQmhy?=
 =?utf-8?B?RkJxZmJJeGp0dlo3ZzJXTTAzaFZlaWlLdHlsWGFNWmFIa2Z3RmlvT2NoQlVJ?=
 =?utf-8?B?STZuYzlCM1NOSWJxZnRnTEkvSkxHQ2dVK01EWXhNcURmUnlKOUpXMDhMOGlG?=
 =?utf-8?B?ZFV3STA3L1A3eHJIaCtEZGoxN3VycDJkaVYwZHN0ejdMTDFQS2tEZm5JSE1p?=
 =?utf-8?B?VkNRalRqNitQOVU4NzhzRGlKdmw0akZIMmdXWHNwNDdpNWFwN09GdndUd3R6?=
 =?utf-8?B?Y3puenliUWJiTjJaS2k5cjZ1UWt1aEpFOVJnVlV2MktIUTBoN21aYVdndVlj?=
 =?utf-8?B?d1pKTFhqbTFlSTh5SWRyYzNPMzNYYkhmS3FyS2ZLYWFPK2xNa3VZeE4yaFA4?=
 =?utf-8?B?MENRWGs1R1d4N2k3blRWdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXQzNGNtWHRaRXBKSmJ4dFBiWXdIMGFtZFRvN0Znd2dyaWhmVWYzZjM5dU9U?=
 =?utf-8?B?Tzg4YkJKd2xvSDNocGl4VXYzMTFXZTNEdVJRUmQyNkhDN1FkcjJjZitGNTlL?=
 =?utf-8?B?c2xrRjF0dXREMVN3U1N4THdrR1FQVWdNNmw3a3Q5M3czcDlUeFQ0S1h4eTht?=
 =?utf-8?B?NTNpa1Roc0FrVlNUTkoyVVo2YmxWZGF5bFIwcHRsOW4zdjdwdXc0Vmp0cWF0?=
 =?utf-8?B?M1IySUhEajRncnFyTjJocXIxRGYxbG00azRHdE14UmZLU0U1VzBnRUhVM2c4?=
 =?utf-8?B?ZmwvU3FBc0g3WGhDczZ4Z21MSGsrbTJBSHpPejBpWEx1QzVBUU1iR3I0YU91?=
 =?utf-8?B?Y3BDbU1kMzZaRGgveGpkSDdLenoyNVk0Qk5HcmNPWXdrVFdaWmh6UEtHWXY4?=
 =?utf-8?B?V0VsU0xGbHdEVmo0K2grQ1VpQUN4NHRkT0hEcFY1ZVRuRy9melpBNG5aVjIv?=
 =?utf-8?B?TGFwSDJQcnpuTlBDTHg5QXkwNVg0eFR0Z2R2Tk1XMTFIOWR2U3VRcDRWc0Vn?=
 =?utf-8?B?K0YxRFVGQlFaSFRLUlcrVkNPVTdUY2xydUtyWXdJTERhczNadWF5aGtJeHJZ?=
 =?utf-8?B?aUZaVlhQVWdJanpkYmMrcGRWc29OeXppcW4rNmJWazRjRWV3c3E2cGJDY0xh?=
 =?utf-8?B?Yld5YTBlL1J6RGhIOFFmNGxJamcxR21FS21OazcxS2pyYmoyb2FZcHVheTZR?=
 =?utf-8?B?cDdySnp0NXI3T21BckE4WE1pSzdYNk5sSytEWGdadTY5VjkvK2JZTjFHODcw?=
 =?utf-8?B?NlNib1hmMHdqMklHVDVaV0xRUDYxSXppZk9UcjRvYzJRVUZ2SkU4bi94Q1ox?=
 =?utf-8?B?eTZPVFdieFBkVDd0Vjd1QldTKytLR3BTZnFSYTJJVW9iR1h6bVVlMktsbFBk?=
 =?utf-8?B?N0ZWUVBjUWhzTVVYR0RwY3RIVEJncnJpcC91dDBoY1pxS01KWDVhQ3ZvT2NT?=
 =?utf-8?B?R3lEVk1xaFNRL0NPZk14YlFrZjVwNVEyaGZkZXV4SWtaRlFzVHI1eUVxQmtz?=
 =?utf-8?B?ckZaaHNGWGcyOHhEZkJ6YWw3RHNnd0tBV3lCWE5mT3cwdUNKUmNmNFJpaGF3?=
 =?utf-8?B?cXVHMWczOHBKWTIzVmtyeHhpc1ZHdjJ0L2lxREo2TjhDVW13T0pxT1ViWXFT?=
 =?utf-8?B?b0NOSUxtV1ArTXR3ZElrTHpGNkROb2xyN2VGU05VMGE4ZkhQUHh4OUZtKzVq?=
 =?utf-8?B?b3hBZm84czJtcE55S3QrSGdHajR5QmpoY2YvVFlUS2xoelh5am5EelpnOEtV?=
 =?utf-8?B?ZE15dDNmcEdWMUFhMTVkSHFmRTBTYjR5clZJUjJ6ZXhJSldVNGJpV1hzVURm?=
 =?utf-8?B?Yy9pWFNyQUNNK2ZqbytObE9zWkxnMEMxVFZtZEVVeWtTazVlZnhQenBYU2JK?=
 =?utf-8?B?YmtmRmdZTVNnTUhrM3E5WXA1VTN1U0NXREMyWXZ3eHliQ0FhYTY2bTM1OWRa?=
 =?utf-8?B?NS94bnN6dnFDY3NCa2FHUzZiWmN6RWdDRVRKTnR0VUFYOVUxY0luOWdXZm05?=
 =?utf-8?B?YnJlUkJLQlRKUU5PdXV5M3dSclBNdmgwa2IyemdvdWJlVXh6NEJjRkRtZmFL?=
 =?utf-8?B?d0xLNlRka1ROSnNTd2lNaEpIR1cwZnRBb1NhOHozeVJJQ042RHhYa2hnTWl3?=
 =?utf-8?B?NU03K29ZZ1ptaWpjaXA5dUJRTVVCVWFxMDZra3NBNWVQMzhldFpncG45ZVRj?=
 =?utf-8?B?by9HcVhLVUZRSDlYbGtMblZzREExZ1VXTTVIMWVSc0hQTmZNODB5dmRiTXF1?=
 =?utf-8?B?YzZzNlZLejIxMnp1NEtSdWt3M0QrU0tBMVBDZ2ZtclpUQk03Tk5VbnFmYXJ0?=
 =?utf-8?B?MXFnTlRlU0ZFbW11L3pBb2JCc1hLTEorR3pKWjZPcm42MjE1M0dzT0U0MEFQ?=
 =?utf-8?B?U1pVWFZWWU92elNsbUpyYUhKdjluR0pMekhCVC8wRUJKM1NmYmY3bzRBSXBx?=
 =?utf-8?B?c3VsVTFiMDdEVFNhWHUrbzZKSTdIOTRQc25pcWRXTWpCTXNsSENlVnJqUnBa?=
 =?utf-8?B?anZkVmIrMkpydEVnQm9XdUgwTVp5SGM5RE42NmlldkhDOEhxdE1mTnhwQjc2?=
 =?utf-8?B?R1JZZXoycCtJaGZYc0ZaK2RNUmdrMVY5UkM0Y1BEUURzMjZOT1JqdjF5R2w2?=
 =?utf-8?Q?FgCODfyUzW4SuD3MUod+5l0Fw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97299d4b-b4ed-4b02-7827-08dcc77979eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 15:52:53.3862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPi+Kn+aEbV5t7LsQifzfR5QmEAsLro2rrZprxmLeHCp77tNIAtGWQ2F/v9zdo/yY6Sq3gEiDn3uoW8salakqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408

On 8/17/2024 1:35 AM, Sean Christopherson wrote:
> On Tue, Jul 09, 2024, Manali Shukla wrote:
>> Expose the Bus Lock Threshold in the guest CPUID and support its
>> functionality in nested guest.
> 
> Why?  This is a rather messy feature to support in a nested setup, and I'd much
> prefer to not open that can of worms unless there's a very good reason to do so.

Agreed.

> 
>> Ensure proper restoration and saving of the bus_lock_counter at VM
>> Entry and VM Exit respectively in nested guest scenarios.
>>
>> Case 1:
>> L0 supports buslock exit and L1 does not: use buslock counter from L0
>> and exits happen to L0 VMM.
>>
>> Case 2:
>> Both L0 and L1 supports buslock exit: use L1 buslock counter value and
>> exits happen to L1 VMM.
> 
> Yeah, no.  L1 wants to attack the host, so it runs L2 with buslock detection
> enabled, but the highest possible threshold.  Game over.
> 
> If we take the min between the two, then we have to track the delta and shove
> _that_ into the VMCB.  E.g. L1 wants every 4, L0 wants every 5.  After 4 locks,
> KVM synthesizes a nested VM-Exit.  Then on nested VMRUN, KVM needs to remember
> it should run L2 with a threshold of 1.
> 
> If we really want to support virtualizing bus lock detection for L1, the easiest
> approach would be to do so if and only if it's NOT in use by L0.  But IMO that's
> not worth doing.

I will drop the nested implementation in V2.

-Manali

