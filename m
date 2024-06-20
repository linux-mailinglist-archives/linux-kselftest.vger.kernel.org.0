Return-Path: <linux-kselftest+bounces-12341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072CB910BF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADD91C2476E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4A1B1509;
	Thu, 20 Jun 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jzq5CtGR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32541B1501;
	Thu, 20 Jun 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900327; cv=fail; b=nl3bLMyz34w1RbMRmvl9TFeUE3OZPabv8r8XnJ4ikQ18sKENCMjU6d1WV4ULV9oVpYEqSufGECcAz2w5OUDEiFRvry6WesjYXDU6Bi3BzhltfT8/9ZCeVDqnB7MMaqIQzE2A9MMSfYt5hvWkTVBmO+ORHejPFxP/qMKniKa70HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900327; c=relaxed/simple;
	bh=BmORdeSnPKz8RALce8/FDXt5WmpGPSjkjDaCcSiibYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cwL9oEl7xUJ6xcmKdeYRTeHGPvgjnn/ZiyEz4ze9ENVWKRPNKC0BmfI60j+BQQyFa+WitwlffoRybrKW9k+7PRp8aBo7/ptY+HjTx4L++X7QrONrXcQyhQheJ4ZYU2xvd4lJWXT7gSiei2IiPK9JojakwctSw/aeKNPhAp0l58s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jzq5CtGR; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBh0wCc6+VB3yXBsWEWRw99Rz37JdSBMtAaY6E9QS3dVVLO47TX9fBimj7NBIoBFVo5uabx48znqAqcN6SZW0DOk/G86Zc99WdIuR4O9x2JD9Xu4HDuBCwYMuB5ChlVrm9+cPzrNOD/8J1FXw5wL1DTYwKxmTg2h9xbVK0S988DLo0nkBbp+nb+/ruvx0cWGFTlTgcr5dr725ehXyXVyT/zPMgV9D5s0y7aVctop4Q4O8r35bf+awAvNRtq1WwK0VicbvvR3pj8Xr2Yc4nLEhRZvZFj2RtwUUfz6U/UIqhLWLg0GipHk6LwZP3z/WpeoeJabGWAQcXnWTQtJ0J0hSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwQvaWxESbNGdxTodkuxkEnwHTNLzrZp8LiXofxfV5o=;
 b=Fbxln8TldSwubMbwI/VIih3QBxZ+68aA/RZaiR5EdKxVvG73RvGGIWThrsHhm+rA4W7cYAOw4KMOqIq3n6y6ZbCdewNOo9bpRddz/yHX28ysZiLagX06lBWxvAUtJGGWyF81uSater8b+Wi8zhjMTWKThV9BnL6YweW3tpM1dTy6wpCF1x1/37WJ4CE/hM6kIMzImQFVTHR9LDf61tqsdrSBMYFNSxB6GhG2KFBbjFp7nTS8FvvdcsUkPB8UEHnQxZWB72HBBQayPFdQyTqnjCK3F128lfZiF5POrBv2qYA33w5YXSCZg/qh3Odkg9gW0o2zPsl3VtxPU/ELCmh7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwQvaWxESbNGdxTodkuxkEnwHTNLzrZp8LiXofxfV5o=;
 b=jzq5CtGRBa5qumusmPa0jDIB5w8Me+QaZuZaWdm2g5whLnUomeEx8UnQl1SU9C7SSzPQrZvUGixgvmIKfB/P1QE2jN8Stt3Sax3g4vmsOUHyfkG+9xHeyH68POoQMVkrgHoO89ZuOyOpKYEH5YJdsImCflki8dAU4Lmce6NIjT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33; Thu, 20 Jun
 2024 16:18:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 16:18:43 +0000
Message-ID: <e2755213-0ea1-4b77-886c-294068940bd1@amd.com>
Date: Thu, 20 Jun 2024 11:18:40 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 3/4] selftests/resctrl: Add support for MBM and MBA
 tests on AMD
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <cover.1717626661.git.babu.moger@amd.com>
 <3c2034e3391634b35192819b69eabd7db8cffa8f.1717626661.git.babu.moger@amd.com>
 <61fd7414-a36c-47a8-8633-163cb29b0e2f@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <61fd7414-a36c-47a8-8633-163cb29b0e2f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:806:120::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6cb530-3fb7-42f8-006d-08dc9144a786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGl1SFU4YXpmRHRLT284KzBLZWxuQUM4ekVyelZSK0lrendsVStVdkR0T2J5?=
 =?utf-8?B?WXdqM3hJaURwNlpTeDZsOVBrbWt3am0xejBEd0R5dzRjR0s5amk4MWlxZFli?=
 =?utf-8?B?Qlp5N1M2Tis0bUE3cDh4Y0JydndKeDhKbWc3QlcrQlp0ZkhuQWE0S3FVV3FV?=
 =?utf-8?B?b3lpRUJ4dmcrVU1nT1dtbzV4UkdKdCtZZVFRNkFrWlBXWmlOZWYzamNYZ1dV?=
 =?utf-8?B?UDdKMmVYcGloUGRCME1RWm1aaVkvMEV6aVZzNE1IZXhCMGJJUXhqa0ErSy9o?=
 =?utf-8?B?ZWJZRFBPY2JheTkyRnZ1NzVURmFZcUpSaG9DY2dlZVI3TFQ5NVNzUm9oeUJM?=
 =?utf-8?B?N1kwSmlKUVVNVDAwMFQzdldPNUI0dXlhaEU1cnQ4TVcvWExpanpNNFJaUFlp?=
 =?utf-8?B?SGdpS2dybGZTa2V6bVBESFBCU0VIWHd6akNtdWlDL3dSU2RKc0dIYXZyM0FR?=
 =?utf-8?B?aTE2WWMvOUl5ZkJ3eXRsc0hnMjI0Skt6MUhVSzZDQjRvcnR6Y25aY3VLNURD?=
 =?utf-8?B?djkyRVVTdDlvZ0tIRERsTXJmOVVRMmhlZCt4OVhUSVpjb3drbEt0NTVLRTh0?=
 =?utf-8?B?dEQwSDMzMm5Ca1psMnRTMzFkR2hJRGZFc3Yza0tOY1IwZUszZnpEa0ZibnN5?=
 =?utf-8?B?clBDWnpKSW01ZFNVV1dKeTdIcUZPenYwdXhQdXp6MTAxOHk4SUpYRzJMUkVi?=
 =?utf-8?B?a2ozdW0wU2lxSndLbjBHWUVqNFpoYUtwREwxcC85UUdubFBPZ3dUdUEzeTNS?=
 =?utf-8?B?L0gvNEZ0OGR2eHBQb283eTd6bUFWNWptOS9CNCt1cmNlUGtUYmltcHNDQmtP?=
 =?utf-8?B?TGlKeFJ3enF3VjRnZCtZU1FIdHBmSkhQa0xpbHVZTWxjNmxtN3BKVS9VdEZD?=
 =?utf-8?B?T1RKT1dvM2UwM3loTjRFVG1EVkZoNk93K0xsZkFzOEZlc3ZnRzRrYTBTZjJY?=
 =?utf-8?B?MWRxY3RCZnJsVHpBekk1aDNRQ1h6cTh3MHVtazU1NnJ1Yk1jWmRrcGJLR3B1?=
 =?utf-8?B?SXhXQVhVN29WWkx3Y2ZyQTdITUVEL1piL2wwOTdwMGo0akM3Qnc3Yi9zaVV0?=
 =?utf-8?B?cUI2ZVFXYi9wZ3Y4b2doRFF1b3lzWDhHZlVWekwwdDdLK3EzcmhuamMxTndB?=
 =?utf-8?B?bW55aEdWVEkzRjB1NDh6bUlxdHQ2bXRoTGgrQXE1akg2cjJ0N1lBb0pMaERK?=
 =?utf-8?B?Y0c2dlVhY0JaSWk0TGtBTjBEdHM3aklJL1JmT3FYbXl3dVBlVzJZSWdkZDNF?=
 =?utf-8?B?NnZOZUM4QVN1UVkzZG8zSHI0dDRDWURFSFo4WTAvN21oa1QyMXVRNm41Y0RY?=
 =?utf-8?B?N0RhT20wYi9GNTdvYkJKZWFodGxxREpwMmZKU2toNWRPSFJ3RzA0RHdCSXhZ?=
 =?utf-8?B?azdseW9rbUN4M2hPb1VRMVNLUFo4Z0hCSnJXb25uSk05Ynd0R3dUNVhzZTVt?=
 =?utf-8?B?RnlYNzZzMTdXR2w0RGhWSEZvMEU0NHpQNXhvdUI2VG5ramVDUWNrUUt2c3pW?=
 =?utf-8?B?Zy80L2RIQlBLK2thNDlZZktBVUpwMTNoYzZlOXZkNmpPS0lFM3p6K0RnQnBz?=
 =?utf-8?B?akxBbGF5RlJtMDR0ajV5WlBOR1JRVDJtK1NMQ2U0UFp4WXFtblVlT0l3UXVE?=
 =?utf-8?B?dFFqak40RGtGRnlCMXZsZXVHS2RlL2J5Und6UEdLNnp4enNQeWIrTEZwUEJU?=
 =?utf-8?B?azZDNzY4cG5nbVR4eGJVMlRhZDZiakMwOVdCQzZaZWl0Mmd0cVNLQms5MENY?=
 =?utf-8?Q?/quL+vIYQ9zipQEdpOnMVP8tC1xpLTnWw/w1NYa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlNHRnE1bmJtRkh0MnJkRkJ6RUowVXlvZ3kwL25PMW5pQ2hDWG9OOVpNZlFY?=
 =?utf-8?B?Q3JHcEE4YVhVRHcxT2xneTFzdEdhWWZicElLK25YeGNTd3JodXNrQjJLZ1VX?=
 =?utf-8?B?YmxFdmZrRXp5TlVRVml4bTVmZ2xCOEZqdWpkcnZEWEYzVW1BWllwTXRQTngx?=
 =?utf-8?B?eE1nWm9JVUhQZEdmRW1ZQkJnOTE1dVd6eXk0a2YyWWF1dkxIbUpFMFZDVUR2?=
 =?utf-8?B?OHpicm5CZDdLOTQ3bzIvM0IyTFdNMlFwbndVYmZUTHhQUjkxdmJWTHBhMEpo?=
 =?utf-8?B?dFF4TXZ3N2xDUVRZektmOXNDK3dOOVBva1hORmJRbnhhYk5Fb01Za2w2NHpV?=
 =?utf-8?B?akppc3djaWNHcThLcmxCaWV6QmZhaE5VZzZsa3MwUTVBdk44Mm9uNnNVWUFV?=
 =?utf-8?B?Z1VOQ1RQc3BLMlNQdStjSzJLbW5uallzSjIvMkw0bXpnYm03dkd3bmxYWTli?=
 =?utf-8?B?d1JibktEUDdLYzJYTEVWdm9VWUZ6S1FzVXZZOXc3VDMvSno1ODZkNEF5cFJV?=
 =?utf-8?B?MDRsK2ZFcGMvRWs1SEwrS29EdTA1UDAwd2dnRjFITEM3R1NyTlEzN2pvYnVZ?=
 =?utf-8?B?S09Oa3ZEWlpTZFN0OUs4WmNDV0t0R1dFVlFqQzFGOGxqWnBFRTJFUDZoMDU0?=
 =?utf-8?B?UXBRVXkvNlNqam1RWmdobUc1SHlxV3M0allPVWZoWk1YK0dtaCt4WWMyenNO?=
 =?utf-8?B?Qmt5RVl3N3FidDBYaVVMeS9GanU3TUVLLzU2bW12RHNsNVRKY2p6RzEwQWZi?=
 =?utf-8?B?SE42R3NremdFNnhhWUFWMlZhejJRcTRuQWI5R1Q5Nm1GNXB2UEpwbEJOQktj?=
 =?utf-8?B?QkNUWEdhM0NyNWxIR0tMNDN5SzVsZjlQZklzOGY2N3ZqMUxveUt1d0JQcHNL?=
 =?utf-8?B?OS9PSnMyUndWeVVLNXlyeU5UMitsVmljbVY5OWxubmpxM0haaDRMUXNEWXpB?=
 =?utf-8?B?SkVGWWo2Uk9YckR1WklYZjFLeWs3TG01anJQQjIxZXJwRE9CVlJ1U3gvbXh3?=
 =?utf-8?B?MHFpREhLbVFlUnNZMkl4RUl3bjRxQ1I3eDNSdGJMUHVrTHVuL09nTVNUNVZw?=
 =?utf-8?B?U3JUcHE0dFNGVHZhZXp0WUtRUkJKTzBEYk1RYVRSTE9GWE5yQW81TGdVdFpR?=
 =?utf-8?B?Z3Erb2tDU2IrdEh0M0xubGw5cVBWM3lhd3VyeXdWVkJXVWk3SmpKdnB5MDNl?=
 =?utf-8?B?bnJhc3NlM21WL0RvcS9NT1dFdTAybzN5UXdVSU0rbVdNMjM4MGU4UjBZTmNY?=
 =?utf-8?B?ZDRzdWNGaVkrbXJtNmt1ZXN5eFAxZ1c0NXh6TlFiNWYwcmR5N0NxU0VmZlZP?=
 =?utf-8?B?Sk1zVW4zYitkTE0xNVlUZDNNZkU5YnR2MWRpTUUzNGpkTVRzQU9xWm40ekg0?=
 =?utf-8?B?UmhMaHF0aTdHY1VxdEVJUnZVUWVnRkJMZm5iL2swaGRqakRRcUZ5T3BWOFlK?=
 =?utf-8?B?a2pZM2ljQXl6M3NDWU5lL1RLUjd0L1RGQmc5cWRXNWViK2xmcGZHMllQWlpR?=
 =?utf-8?B?L0FqTVR5UzNOY0l5Q3BMMWE0VndwY1JIaFgzc3lRNEZmeFZmME9JUUpiUjdM?=
 =?utf-8?B?MkR4VTRuQm5QcFZlNHpZUHQwdys3cHRsa00vZ1VWNGY1eHpsOUllL3lmUExG?=
 =?utf-8?B?cFBBRkZud0Y1bW1yQjVSMzdlSXdTSkFLVVV2L0JnSlJsSUtVUU9wYU9tVmxD?=
 =?utf-8?B?ZGxkd0JCWVdhSS82b0FqUERBckNqNUpvdnBNWEZtTG4wcDMvUnFJRWxkZXB6?=
 =?utf-8?B?Vm1ZL09Xb3lOU1ZKTE96b3hTRlU2L2g4RGZSbVkzbE81Q2c4WWx0WVdnK3p1?=
 =?utf-8?B?T0dRYStpWS9EcFVZREU1WWpGcGFlSmtzZ2xqZ2V1Wmh0bmRFRzlxbkZzSXNp?=
 =?utf-8?B?eU82T3dSMjNwcUZNYThIOHArRWxQOXh1d1lvaERkU3N4L1M1dU9TMnM2SWht?=
 =?utf-8?B?enRBRjYrNVd3U0NrMlRVWWtqMG12bU1MU1dWYzlzOUFPVVFKdUEzMlN1bGpv?=
 =?utf-8?B?RXY3NzNrSDdQZFAxeVZiVUdROC8yUlhwMHR0REVIK0F5bzJKaDY3cGVoU2x3?=
 =?utf-8?B?c3RHRDZSWmNES0k1amt1eHJyd2VGV0lEQXNycXFNeld4cFBvSDRIcithNnF1?=
 =?utf-8?Q?2o4s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6cb530-3fb7-42f8-006d-08dc9144a786
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:18:43.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjVOrTbr9NSkS4LsAH53QXar3SqEUwAfil9MJ842yd4pMyl95o4cqURJc/DaVcRc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

Hi Reinette,

On 6/14/24 13:39, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/5/24 3:45 PM, Babu Moger wrote:
>> Add support to read UMC (Unified Memory Controller) perf events to compare
>> the numbers with QoS monitor for AMD.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v3: Made read_from_mc_dir function generic to both AMD and Intel.
>>      Rest are mostly related to rebase.
>>
>> v2: Replace perror with ksft_perror.
>> ---
>>   tools/testing/selftests/resctrl/resctrl_val.c | 80 ++++++++++++-------
>>   1 file changed, 50 insertions(+), 30 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c
>> b/tools/testing/selftests/resctrl/resctrl_val.c
>> index 23c0e0a1d845..ffacafb535cd 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -11,6 +11,7 @@
>>   #include "resctrl.h"
>>     #define UNCORE_IMC        "uncore_imc_"
>> +#define AMD_UMC            "amd_umc_"
>>   #define READ_FILE_NAME        "events/cas_count_read"
>>   #define WRITE_FILE_NAME        "events/cas_count_write"
>>   #define DYN_PMU_PATH        "/sys/bus/event_source/devices"
>> @@ -128,7 +129,7 @@ static int open_perf_event(int i, int cpu_no, int j)
>>   }
>>     /* Get type and config (read and write) of an MC counter */
>> -static int read_from_mc_dir(char *mc_dir, int count)
>> +static int read_from_mc_dir(char *mc_dir, int count, int vendor)
>>   {
>>       char cas_count_cfg[1024], mc_counter_cfg[1024],
>> mc_counter_type[1024];
>>       FILE *fp;
>> @@ -152,41 +153,56 @@ static int read_from_mc_dir(char *mc_dir, int count)
>>       mc_counters_config[count][WRITE].type =
>>                   mc_counters_config[count][READ].type;
>>   -    /* Get read config */
>> -    sprintf(mc_counter_cfg, "%s%s", mc_dir, READ_FILE_NAME);
>> -    fp = fopen(mc_counter_cfg, "r");
>> -    if (!fp) {
>> -        ksft_perror("Failed to open MC config file");
>> +    if (vendor == ARCH_AMD) {
>> +        /*
>> +         * Setup the event and umasks for UMC events
>> +         * Number of CAS commands sent for reads:
>> +         * EventCode = 0x0a, umask = 0x1
>> +         * Number of CAS commands sent for writes:
>> +         * EventCode = 0x0a, umask = 0x2
>> +         */
>> +        mc_counters_config[count][READ].event = 0xa;
>> +        mc_counters_config[count][READ].umask = 0x1;
>>   -        return -1;
>> -    }
>> -    if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
>> -        ksft_perror("Could not get MC cas count read");
>> +        mc_counters_config[count][WRITE].event = 0xa;
>> +        mc_counters_config[count][WRITE].umask = 0x2;
>> +    } else {
>> +        /* Get read config */
>> +        sprintf(mc_counter_cfg, "%s%s", mc_dir, READ_FILE_NAME);
>> +        fp = fopen(mc_counter_cfg, "r");
>> +        if (!fp) {
>> +            ksft_perror("Failed to open MC config file");
>> +
>> +            return -1;
>> +        }
>> +        if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
>> +            ksft_perror("Could not get MC cas count read");
>> +            fclose(fp);
>> +
>> +            return -1;
>> +        }
>>           fclose(fp);
>>   -        return -1;
>> -    }
>> -    fclose(fp);
>> +        get_event_and_umask(cas_count_cfg, count, READ);
>>   -    get_event_and_umask(cas_count_cfg, count, READ);
>> +        /* Get write config */
>> +        sprintf(mc_counter_cfg, "%s%s", mc_dir, WRITE_FILE_NAME);
>> +        fp = fopen(mc_counter_cfg, "r");
>> +        if (!fp) {
>> +            ksft_perror("Failed to open MC config file");
>>   -    /* Get write config */
>> -    sprintf(mc_counter_cfg, "%s%s", mc_dir, WRITE_FILE_NAME);
>> -    fp = fopen(mc_counter_cfg, "r");
>> -    if (!fp) {
>> -        ksft_perror("Failed to open MC config file");
>> +            return -1;
>> +        }
>> +        if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
>> +            ksft_perror("Could not get MC cas count write");
>> +            fclose(fp);
>>   -        return -1;
>> -    }
>> -    if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
>> -        ksft_perror("Could not get MC cas count write");
>> +            return -1;
>> +        }
>>           fclose(fp);
>>   -        return -1;
>> +        get_event_and_umask(cas_count_cfg, count, WRITE);
>>       }
>> -    fclose(fp);
>> -
>> -    get_event_and_umask(cas_count_cfg, count, WRITE);
>>         return 0;
>>   }
>> @@ -213,6 +229,8 @@ static int num_of_mem_controllers(void)
>>       vendor = get_vendor();
>>       if (vendor == ARCH_INTEL) {
>>           sysfs_name = UNCORE_IMC;
>> +    } else if (vendor == ARCH_AMD) {
>> +        sysfs_name = AMD_UMC;
>>       } else {
>>           ksft_perror("Unsupported vendor!\n");
>>           return -1;
>> @@ -228,6 +246,7 @@ static int num_of_mem_controllers(void)
>>               /*
>>                * imc counters are named as "uncore_imc_<n>", hence
>>                * increment the pointer to point to <n>.
>> +             * For AMD, it will be amd_umc_<n>.
>>                */
>>               temp = temp + strlen(sysfs_name);
>>   @@ -239,7 +258,7 @@ static int num_of_mem_controllers(void)
>>               if (temp[0] >= '0' && temp[0] <= '9') {
>>                   sprintf(mc_dir, "%s/%s/", DYN_PMU_PATH,
>>                       ep->d_name);
>> -                ret = read_from_mc_dir(mc_dir, count);
>> +                ret = read_from_mc_dir(mc_dir, count, vendor);
>>                   if (ret) {
>>                       closedir(dp);
>>   @@ -250,8 +269,9 @@ static int num_of_mem_controllers(void)
>>           }
>>           closedir(dp);
>>           if (count == 0) {
>> -            ksft_print_msg("Unable to find MC counters\n");
>> -
>> +            ksft_print_msg("Unable to find iMC/UMC counters\n");
>> +            if (vendor == ARCH_AMD)
>> +                ksft_print_msg("Try loading amd_uncore module\n");
>>               return -1;
>>           }
>>       } else {
> 
> Can all the vendor checking be contained in num_of_mem_controllers()
> instead of
> scattered through multiple layers? There can be two vendor specific
> functions to
> initialize mc_counters_config[][]. Only the type setting code ends up
> being shared so that can be split into a function that is called by both
> vendor functions?

Yes, We can do that. Will add it in v4.
-- 
Thanks
Babu Moger

