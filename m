Return-Path: <linux-kselftest+bounces-11587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F44902807
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 19:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F64A286DB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F75714884F;
	Mon, 10 Jun 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="klFUu+L0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39314B978;
	Mon, 10 Jun 2024 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041893; cv=fail; b=dub6Qr9XsJVI4nTfO7HxscyLBnKplcC07RZyLL89I6gf5j2es8uLx0vI8taVKeqNE/D/pPyQBMS9Y8Ad45UwXC6Rzb6NNp9iKpjVlGJyHhbgTTt7Th2B9o0lnQmM/EdB2EmxexQFIoPCxuJIb4TU7S+sFtdEHvZD8ShOAN7ViV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041893; c=relaxed/simple;
	bh=a+xp4L6pcnIGb3g0XrS7uZFmvaYunwvuvC2WcKsLRTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NFdUj1h/LMJCXx1dElh2djCvcaCAI80BCAVeYrgZ8T6wDONakLMKgHmHSTNEzNHxJbDS2nKngWps8c1CE84ZzuM3X+Hu3Yj4tCQ/j40QbJcsVhnxi0BNZoKGZJ7CwSR04dJwbYZPA23hxJF5orprXwwFn2BN0oQyFYhEgsb44ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=klFUu+L0; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmRn0PXHbWtIYW1ykKjjdgtFq2rvpaNMUFR5p5nwWmRl6+44IR29Kyi6JQRVRQP0fk2tWOXUD2K2+g0P85crBcAz7gb2bNmMCbFFY8Cf5LBmuj8JYZPw3VZkiyO091JF9pAqCxJnvKrCmLeMhVcDk6JnEcnDoj90z8eVf7+ohKtwW7112EA6UJsqGAVwrF4+GhAvhG0UJV+C12myiU21xPfofTQNBcS919Y76Zs1ucCfE8xH8kT8SiwxoUY4uVIhrNku3XEFyOa5YoSPmy+i89Q2MrjZj3vkBbhLW/Eb5GFDN8lhbFwoobGDwQJgO8Sf8TLmbbmVTf5vToDHQlU+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mW1dJwcFjejXwtjh93jH+bFn6/XJWi72t9a85vliN8=;
 b=AGdK6/Az4CaOX4y6Gs0DB3SNTRM08znrLyNTXIWLm//NGpTJhw9hF37VPTQZZkvTPo9yxTJYVvQXED5o3XxSwgc3wU811g1q84GhpXo4wTV6pRg9sx4mtPJceqXl/paDc57wIH6dgoHDAU0DVLGEMTWVwImb+cdXhLB/ib9nBoQj2CadbEnWj5YxQy2XjMTE7ScDPCx/uXkECwy91kJcFxP1j7+c/GjaJZCayjqPsSYq8WED1W/4CK1CYP8QdXum0bNY88hbpoOeSXQCYU9EENVj/ovRDq9N0chTs0w1a36zVr51kQ8iHyTlX77CkewhFHMxU9b+OXMyEwm4SBvJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mW1dJwcFjejXwtjh93jH+bFn6/XJWi72t9a85vliN8=;
 b=klFUu+L0GqnNSpnkPd+TVPZmyMSGds8tRGKjzN1e3kmi5DF8Jyt/XYm+VhgLwteBFKF64R7TzS7zN9NxPIyP5ppbWevB7IXiHwtcYYChp8ZEqWWEreA3eSo3pQn3iJohri6otEDjhoME0gw9864LBZtsBaiY0rmgnTtyXok0Z4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 17:51:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 17:51:28 +0000
Message-ID: <0e153d27-fa1d-4c47-8d4e-a2004c991ffc@amd.com>
Date: Mon, 10 Jun 2024 12:51:25 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2] selftests/resctrl: Fix noncont_cat_run_test for AMD
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>,
 shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 peternewman@google.com, eranian@google.com
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <7679d70a0ea939db13ae9dac20de56644460d6df.1718035091.git.babu.moger@amd.com>
 <91052cec-071b-7cc7-5f85-4fa29ec2aea4@linux.intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <91052cec-071b-7cc7-5f85-4fa29ec2aea4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:4:ae::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 60953e25-e388-46c1-d378-08dc8975f41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2hJTnBhOUlob1VHZTVYN05TZ1NUVVdYRFk4cE1xWlRRRTQ3MEpoYTZReWcr?=
 =?utf-8?B?anBobTZiMnZ3TmlIQmdiMkJPUHB1cFdyN0ZGV2tOTDdVTDBlNGtSSnBzZzIw?=
 =?utf-8?B?SWtpUXJqamJBNFFDd3BiQ0pYZ1ExdTFITW5LMHkrMzJLbUloU2pZNFRJaXBv?=
 =?utf-8?B?aGpDbHdmRWxpMXg5UTNtWFhKY09XV2owUE5RSGRtY1loZTltUG1FTC9jdnc0?=
 =?utf-8?B?eFQ1U3ZoVnBYMG9BLzFRcmQvUjBrZUNsMWtwd0syWWg5WWo3czc2K3Nvbmx2?=
 =?utf-8?B?amxkaHBWVDluZWZzRlF1elhGRytkT0dublpLUG15V05mL3NyNXEzS1V1L2tJ?=
 =?utf-8?B?SWNkcXVXS005eXZLdjZZYkZrNk1renovSkQ0TDZOQVU3aXF1c3B6d3I4d2pH?=
 =?utf-8?B?Yi9JQnJaTFVjK1Z0UmVCbjRDSDUzaVJiaEtqMVBxc3Y2czhmM3lrOGEwTGky?=
 =?utf-8?B?OHpIVWlNT290UmlaMGVvZWMybGJtc2RpL2hzbE04UU5LaVJqdXdBeWY4K0ky?=
 =?utf-8?B?Q3hDODlNMU9OZk1VYVdmNmpESGN5dTFyM3puaXgvaUdacDAzZXR6ekFObXFr?=
 =?utf-8?B?ZFYveWhEK29MYXFFamZBd0VRK082RmJBRFVDaUloWVpwVzFNK0Y0c3dhQlRy?=
 =?utf-8?B?MlNJcUpnc0sxeDJ3NVlLMFF0TTdDcFh0b2pEUlMvOFdSeWsyblZFdWZjMXRy?=
 =?utf-8?B?dnpTK1dpZSt6V0JVOStUdC9TekNjNldYSTZvR1c4YkloVVBKbFRqWmdKckNY?=
 =?utf-8?B?VFZQcElodC9USmFqck9LTlRNMFpWMTYrUU5iTXJWTGR3NWVMN3pVUG02MDg4?=
 =?utf-8?B?OUlTQldUM1I3SThJajRQcTZGajA1TkcySlVTc1A3aDBHL1NmeUE5NWdQUXR1?=
 =?utf-8?B?b04xeDVZRnFoaUtLdWo2dThidHB2RTBxaHlhbGlrNlpWV3hoUEtjVllVQlM2?=
 =?utf-8?B?UmRzNG1UTlBVeDRHSXZPT1p6LzZPSXQrTEZxNllJZWQ1UG8ra1BmMHozdkFX?=
 =?utf-8?B?eEVaTlFSbEUvamhCZG1vNFlhY3Z4bDdhbXNVVFhmMXo1ZzQ5TW5WcXRZaVkx?=
 =?utf-8?B?TnZBMS9YNE9RUlVyMVpSdTRrcWxOdldJUWpCaXJrN09WeGFYQ1U4TGg1dStJ?=
 =?utf-8?B?Mll4dUNTMVBabjBQU1ZsZHFmSm1xb2dwMzZaMkU2QzJ2OE0wbnJlMDdwNzh6?=
 =?utf-8?B?eGs1MGo5c1VmYmRtT2FvcXA0MkxQMzRLLzV5M1ptb29NaThISnBFcVdScDdI?=
 =?utf-8?B?S1poNmM3Ly9zWDExY2tVNEtIeXpiT0tzNnoxcGpwYWQ5aHVwRlp3TktvOEt5?=
 =?utf-8?B?cUx0OHNmYkFUOHdaTTg3dnhybHRraXFlS0o5M3VydC9oWXlCcmF3NHBVQU9K?=
 =?utf-8?B?Qjg4TmEyZXFDRjYzdDZZNU5KdSs4cUtwWTJWN1JJTDNNdXpYdW1GdkdTeFpu?=
 =?utf-8?B?UW9ZdENrQ0pvbi9oRW45RWNsOEFjVHJhWFdZa0tsWGFHRXJsK2YwR0FJQWpZ?=
 =?utf-8?B?NU9KTHdQN3plN2pDRmFYNDM4MXBQNXJBQlJtRWM3bkg4clQrTXNubEJNcHd1?=
 =?utf-8?B?Y20rLzhMaGdOa0F5NDdvMnJJY0ZzSEhrRVE0RVZ0REE2aHlSMXp6a1RYV2JI?=
 =?utf-8?B?UWM4cTRlZE9uS1V3QTROTUFxZVhqL1R2WnVwRVFKWjBaZjFtRXNTWHkyeVB1?=
 =?utf-8?Q?CnFA0q4JrZvb2AoKcKvM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTJaNXNzaE4zajFzblM1WkFza2RRckszSXdTU254VHJzT1RwUHF2aFNvc0Nr?=
 =?utf-8?B?bms5TkhKRmgwcXl2MmxsMnl5a2xnbVpveC9KSFlqMU9aN3Jud29CRWFoYm5s?=
 =?utf-8?B?NTlvd2NKUzZycUlRcG44eWZjRVh4RGpJRThTWko2SGdKSXpTbStacE9zb1Vp?=
 =?utf-8?B?WlBTOWlSYURjNzVnOUlDa1VlUjJ5QlRZWDhPb2JQc01MN2VUTDYwZVY3alNs?=
 =?utf-8?B?aVpwcncvMFBWVm1kM3pBcHhlckRGQzlvdUdhOW93UzVDZ25JN2pFeGcyU0xQ?=
 =?utf-8?B?UE9aZE9KNWlhOGNaK0NHODZGRHhjWktJa2x4ek5DSytTcjU0VXB5S0VBWWVr?=
 =?utf-8?B?dlNSWkFjRXJaZEJxeUY0VUMzRSthK1Q4NHlVSmE4bFJSM3M2Z3AvenhXRmZm?=
 =?utf-8?B?RXhSTGlwODdQRGJBQkVIZk4vODNHdjhicjd0dHhxTkcvMUc3Zk5OcUN1dWFa?=
 =?utf-8?B?ay95b0FBM1N2UmxPMUFXUmhSclRsSEU0KzZNOHpLeGNBMGc3S2pXWWZ2L2dR?=
 =?utf-8?B?bEl6WkV4VURVUEpVZnRpSGNXSTBhUm0rOFNVVU9LcHZKYkJPTmdzVk8xT05u?=
 =?utf-8?B?SFR6RXVPQldDL3NQU2lsVUZFK1dNMFZHcFlSRnQ1L1Q4ektUVHNDNUlNejRH?=
 =?utf-8?B?MWo2ZmIrSUVKLzJUMTFhN3p6S0IwRFRsNzNNdmRzTE5xRVQxWnIxdWIwRFF5?=
 =?utf-8?B?ZVJOSE94VzdRY1MvQzlFT2swSTFGVGtlVStuVjZJVGxTSFFzTlREUGpmT2tT?=
 =?utf-8?B?ZzkrRGxkNTBDUjJIaHA2VmpyTVhEMXZTZ2xaNnVUZi9NSGpZeWFtRUVaY0sz?=
 =?utf-8?B?MGVSbGM1M1VHeWR1OXdDS1FaUGlhNUdza0JRUThvT2dLK1d6RmgxNkFnbDdE?=
 =?utf-8?B?cVBxWXppajRIVm05Ulc4cUoydEpTSS9ObERBT09hR2RXN2hKZDd3T2pVOEVu?=
 =?utf-8?B?L2NDOG9acUhjTllOUEkrUVVFUGxjTzRBMFVWUVdpaGtHTUZURFlLZ2hJZzUz?=
 =?utf-8?B?ZkdBQ3hFMjNRdmEwbnZuWElIYWNhMVRWUlVBOXpGN3d0Tm1hZkVYS2RhWVkv?=
 =?utf-8?B?NldpNHUwSlBUZ2pHcjhscC9ra3pqUnZ0V3drckFRZ2xtb1QwUFJ3ZDYzaTNt?=
 =?utf-8?B?c2RMdkxNcU5aOEdHbUlhbW5pYzB5ckZKK3dYbVBFaVBkaHJLdVNTZEl1Q3F3?=
 =?utf-8?B?NThvaW9kNG5NSHU0R0JQOXdrL1N6RU5wQmhVNXJiMVU3djR4OVc4S2RvT3Vq?=
 =?utf-8?B?azBSNlB2VTI2elF3TkY0cVlTdDljaG1hTkFWMWI3S0htOFJoeUdhaUdZVnQ4?=
 =?utf-8?B?d3pZb1RrdnRzMExieHpFZ0Z5VWxoWVU1a0ZTVHZXWHU4aVZ0cDhqc200em1E?=
 =?utf-8?B?SlhkSDRIbjFPcnk3dit5STZRdmthMnRzSHBCTjViZkZ0aE9WSy9GNjVIOXhO?=
 =?utf-8?B?L1dFSFowNEs3TVRlcXFRR2R0TWRoR2FWdkFqUTJMVHFzOHcyU2xaY0xTaHRi?=
 =?utf-8?B?aGk4K3poZzdLbnpDOHBIWmFzbHd5TWErdWZVRE9CeStUUVB0Z2p0bk1Mblp4?=
 =?utf-8?B?R3VUNWh5Wk83NUh0S1lmWE1tM09mVWpXeFhzT3M4VE41ZXJEZlA1bzhwYW4x?=
 =?utf-8?B?d095YkZHc3dCQXZORFNkN0U4eXlQaCtOZVlKNGxiSHhudm1hSGU4UHhvTjNu?=
 =?utf-8?B?T1RJZW8veEc2QWtyanhmZDFsZ3ZRaWJqbnhOdGRaRzg1czdBWEhja2VhRTFk?=
 =?utf-8?B?dFRudWZIMXNOd2s5SUszZndTMTUwRmY0MHgwSm14WVpXMlo5SjdUNzEyczJh?=
 =?utf-8?B?RlU2ekQxSktZV1YyamZiaVg0WkxaQ0JxNkVBU1ZDZmFrV2g2UzJENTBDbWdo?=
 =?utf-8?B?ZW1jWGRMcS84aUt0SDFQaEhQNEZUb2tiTlFieU53Z1kvMHdHdXJOVUYrZDgy?=
 =?utf-8?B?YlhhL1lDTFA3NzlubUt2Nm1FRG8yVjBzM2tVa2Z2VnJCdnFlL1pnSDhpcStP?=
 =?utf-8?B?T1BuYzNsVWJYZlNnUW0xbkR2OThJOXphTzJnSWlCUUFRUHBYWEgyNzJJK3Rj?=
 =?utf-8?B?dUdNZTBQNW1HN1p3M0s3bGxMTWlpcFNsK0RWcDhmU2lLY2pRZis2SFg4dDBG?=
 =?utf-8?Q?AfSo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60953e25-e388-46c1-d378-08dc8975f41f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 17:51:28.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/hmDD4qf8WUsxcoxYASX7PFIRLBa8UNQ+5Jezj1YSSP+wwCBv57O2GnRUNp2Jbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953

Hi

On 6/10/24 11:20, Ilpo Järvinen wrote:
> On Mon, 10 Jun 2024, Babu Moger wrote:
> 
>> The selftest noncont_cat_run_test fails on AMD with the warnings. Reason
> 
> noncont_cat_run_test()

I want to mention the test here. not function. How about this?

"The selftest non-contiguous CBM test fails on AMD with the warnings."

> 
> (In general, use () when refering to a function, same thing in the 
> shortlog).
> 
> "the warnings" sounds like I should know about what warning it fails with
> but there's no previous context which tells that information. I suggest 
> you either use "a warning" or quote the warning it fails with into the 
> commit message.
> 
>> is, AMD supports non contiguous CBM masks but does not report it via CPUID.
> 
> non-contiguous

Sure.

> 
>> Update noncont_cat_run_test to check for the vendor when verifying CPUID.
> 
> ()

Sure.

> 
>> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v2: Moved the non contiguous verification to a new function
>>     arch_supports_noncont_cat.
>>
>> v1:
>> This was part of the series
>> https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
>> Sending this as a separate fix per review comments.
>> ---
>>  tools/testing/selftests/resctrl/cat_test.c | 32 +++++++++++++++-------
>>  1 file changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index d4dffc934bc3..742782438ca3 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -288,11 +288,30 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>  	return ret;
>>  }
>>  
>> +static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>> +{
>> +	unsigned int eax, ebx, ecx, edx;
>> +
>> +	/* AMD always supports non-contiguous CBM. */
>> +	if (get_vendor() == ARCH_AMD)
>> +		return true;
>> +
>> +	/* Intel support for non-contiguous CBM needs to be discovered. */
>> +	if (!strcmp(test->resource, "L3"))
>> +		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>> +	else if (!strcmp(test->resource, "L2"))
>> +		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>> +	else
>> +		return false;
>> +
>> +	return ((ecx >> 3) & 1);
>> +}
>> +
>>  static int noncont_cat_run_test(const struct resctrl_test *test,
>>  				const struct user_params *uparams)
>>  {
>>  	unsigned long full_cache_mask, cont_mask, noncont_mask;
>> -	unsigned int eax, ebx, ecx, edx, sparse_masks;
>> +	unsigned int sparse_masks;
>>  	int bit_center, ret;
>>  	char schemata[64];
>>  
>> @@ -301,15 +320,8 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
>>  	if (ret)
>>  		return ret;
>>  
>> -	if (!strcmp(test->resource, "L3"))
>> -		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>> -	else if (!strcmp(test->resource, "L2"))
>> -		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>> -	else
>> -		return -EINVAL;
>> -
>> -	if (sparse_masks != ((ecx >> 3) & 1)) {
>> -		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
>> +	if (arch_supports_noncont_cat(test) != sparse_masks) {
>> +		ksft_print_msg("Hardware and kernel differ on non-contiguous CBM support!\n");
>>  		return 1;
> 
> This looks better than the previous version, thanks.

Thanks.
Babu Moger

