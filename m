Return-Path: <linux-kselftest+bounces-11625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CED902C58
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 01:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5276EB24489
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B708153567;
	Mon, 10 Jun 2024 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U/88Gwdh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07356152178;
	Mon, 10 Jun 2024 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061102; cv=fail; b=Lk87eGA6Ep3Oxx/58HgiTLP2SYlJoYh54tHvQsTEi+2NPU9Fz8DBVoPS9eeHRo4bm2t0XUQW7fPONcM4YqrvKRyJ/Zz1Tj8K03oS59NDkv+pWCNwRQsTD5OoXSQ0jzzsPqNFPLiaCLDIA/U10ip8YTtQ68BKnZRO2j0QvNfb8+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061102; c=relaxed/simple;
	bh=HMgSG8UkjeWErtNe1andYEpfGcAFGBVJ6ibXuKvKmmA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E4gODxz0pf3GkZIax6NwxtBIwERwnvHxgyPl2r28wDZ7iBD2/8U8aUyiy3YNQi5acBLZY9MKGCTwKWqv8MK0gT0kOIHm4Wd/hP5EZNHSDpb1OJ3dXRL9JFTEBAFCiF0v53j7IMJ+f77vhQRAHEsNlv4tANoft7B7VAU4J0ZT0N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U/88Gwdh; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSKEqcxmQJDQlvoD3tNeVvzREqZkm+mcc0ewGLR0Rwe37qtc8wsXzKsuw6uan3xEEQkpe1DP9bPoXMf0d0uIiVzncmdUATMERM6KGyFVNXVQN5NKnEGBJ7aOdYbyQvxAN8xHiHoU74ekWhNPazDxsYb2P6qOguAOIqlsQcFSrBV1mVdBJMTg4BiyE76DTUP8EaV+vsUzCRZiZlRQtnrAlRopT6bhB1Dmfmq7vf5klVg+4E1TxAr357ceNuI+0jHee4zlQYjXfB9yBbbVzgWDI3V7MP0OiH4PDyrhgSmyTT/qhJ4nZp/0R3WPkhfspM4ZLOiT6ze+8GDXFI2X5UXO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNygtwb2wnTXpfJn1S3LaaLSTo239Rak/iLV0Pld/1w=;
 b=PnINjiqfP1bdCRW2BUjjdbf6lJqoM7Uas6fvTAZagRUQl4EOctan0hK8USEp0OolOBOaRbrx0GAAGUt9A56zR0bkKPXDmb/XdM9Rsc1h/6nExvpoSNc4SxEuR6vaJhWat7XIyIJxyfsEGRsK0k003t/BYrzh7xeVYS5Afkhh1ztAS3JngvvXxnrqAXtMIzHQektdS25PUujxzUBucbAu/c5xrJnvvvFgXEQg7ZMunF65yrcN2grgAOJ6lEyYd2Glgcf8o+7HzYpbYvL+UT3Ex59v+afju0+jxtdCfvxKYg35jRJj3F/+ljlEh46sRdEQtWKHegoptfXVZCuEgV5iuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNygtwb2wnTXpfJn1S3LaaLSTo239Rak/iLV0Pld/1w=;
 b=U/88GwdhLKCCZk0aO6XNI5GfG+jHMdFFsWF59Q3wlXeS/aUxgHW4Qxfnl0gFuR/lZM8XNLqnxfs0bebvt5xftH21nteKbcFubq1pV7QlewMQUoI4QPSwKiZkZT1PPXn1mOZ+as5LFRhjo9A/uub1I1RVnNO//VBy5EXhefkCaFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 23:11:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 23:11:34 +0000
Message-ID: <3078aee7-acbe-f912-9a99-941154dc4b13@amd.com>
Date: Mon, 10 Jun 2024 18:11:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2] selftests/resctrl: Fix noncont_cat_run_test for AMD
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, fenghua.yu@intel.com, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <7679d70a0ea939db13ae9dac20de56644460d6df.1718035091.git.babu.moger@amd.com>
 <6a78de4e-8d36-400c-9eb5-d3d6aa9e1e23@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <6a78de4e-8d36-400c-9eb5-d3d6aa9e1e23@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0086.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b4ba2b-3806-4e99-e73f-08dc89a2ac2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkZ0azFLZHpnYnh0VkNCNitQWDhzMjRUczd1M2RYYVhuZElDQXBOUDVsaVBM?=
 =?utf-8?B?a25Ya3ljbVJ1dDVMWVk4UVhERXZPQ2tpUFBpNklUZXk2SUl4YmcyRmNwNk5q?=
 =?utf-8?B?MDhsVkVaMkM0bG9nYVJEb1RIWUpnYnZpZW9kYW5NaGdtdGJ5M3Z6T3BlSnRi?=
 =?utf-8?B?WDhMUElkazFjSnl5djB3QVhPOUVhcmtwYXRZNGhhdEhlK1pHZE4rdEFVd0Fh?=
 =?utf-8?B?TnFTQnpaMG9RQ2RMNFZiL3M0alBZbzVaU2wzaUpXc3BJOGQ1anJVSHJpSDA5?=
 =?utf-8?B?MlVQMUlSQXlIbWJkcGxiT1hKR2V0SHE0QjFwL0x2bThtWXplR003RGp3Ung5?=
 =?utf-8?B?ajBUWi95ZUlkS01ZVGU3VUZBd2pCYlFqL2ZwcDIwTFpwcEFhSSt0djU1QmIr?=
 =?utf-8?B?L1VPNjZIbVJNdlZJVmhPbHhFUXJxKzVhbVUxeGcvZE9qa2FJTU1ZemhZb2hX?=
 =?utf-8?B?OUlvWk1uY3l3Ujh6VXUxVnBVSGcrVUh5YWU1ekFsVU5aUEYvd2VqMTJMWXAv?=
 =?utf-8?B?M0IzODBEa2ZOcVM2SGlFdHE2NzdWWnpoOVhIT3p4Q2ZvcGMxVUxJRUc4ZGl2?=
 =?utf-8?B?bWxPc3dWMnN0UlRVUUdYQ3dCL25sa0JaK1NIOGZKQnpSaTJ3d0FYa0FUYXRH?=
 =?utf-8?B?ZHpqRmk5RElWRWdBOFMwZ0NmTlYwbHExbURrcDhJeVZ6VkVpM1VNRGhqMEhT?=
 =?utf-8?B?WlRmZFV6aUVGaXRpT1E3bXJjeS9taFFyTml4TU9aYWNpajBEeUwyajJPRFI1?=
 =?utf-8?B?akpxb3kvdm9veXlCUXpKNzUyRG5tQmd0NmFkL2ErUFJOVEJkTXlwT0xUWjg3?=
 =?utf-8?B?TkxOWmJUR0o4L25BdTdTbHBKNXE0dnpzVTl5blo4bjVpR2JydlRZOVBUSXIv?=
 =?utf-8?B?bzBqZEg1ZDBWWWpFWDYxNTZVQ3V4RWJtZzRFcWFFdGpydURQbFR5SlhWVHNR?=
 =?utf-8?B?OGJYNEk2R0crSzY5OHNEVVV1c1p6MHgwZzUvMDNyeGpkelhLZUx0U0xIOStL?=
 =?utf-8?B?OHYzUkM4RU5IcDczdm8vSGZuMGZwOXpGb25CNmkxSzB5akFhQUtoTDRSclpR?=
 =?utf-8?B?WEJiWk91TGpCQkcwVERuc09wNnJuMFdZeEJJbTVNQ05xM0JUV2x2K2Q1c1R2?=
 =?utf-8?B?Umg3UWl2SERKZlg2R0N5WjRSQ3JtZkJRR3JEdUhIekhiVzlmazFWWkszaDBP?=
 =?utf-8?B?bE5oV1RRZTd0RFpuT0hzL1lHMmVKUE80OVJDRGsrT21GTThZcGM1ZzdNVmVn?=
 =?utf-8?B?TXhnVkdmc1ZWWFQ0NTJUYXpTdkQ1M1JOZVE0SFVnZEpIektHenlzOGFqWUNC?=
 =?utf-8?B?Q0NXdzVjTzNBWEI3ZDBYS0RWaW1wam1lT0lXTHJXRXhYN3BaQXYySFE5UzJh?=
 =?utf-8?B?RWVXNjlRcVFrN2hoUS80QlQ4b1JzOGw4V3NuZ0pvZVpVc0syWVlORWZ5UGVH?=
 =?utf-8?B?OVpERnQ4RHBNNzBQL0Z0NXR6eitTbkNtcUFnQ3RyNmRJS0dWS1lyb0dEQ1Zl?=
 =?utf-8?B?cVBRcjYweERDZU5QMWs3YlVLQkx2U3NhM1dDalYweHEwcmhDa3ZGY0RQY3BN?=
 =?utf-8?B?Ulg1cHRVQ0toS2ZGWW1DYk42NHVKa2ZFY0Npbm9qRDlkMTF1dDRnK3B3ZXlz?=
 =?utf-8?B?L2pCaHVDMm9hTWxCSjFMV0ttby9SQ283a2g2NThBMEt0WDVQVTl0NTJzSkx2?=
 =?utf-8?B?TEhONUlpdm5sSkVKMWRTR1M2VE1lcm44dWp5MHdUb0ZpQXVSQ1I2N0V6NjJ6?=
 =?utf-8?Q?OUnV+VFVYFe67xxcwJL6M7ohRv/u4z8RXuMK9Y5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVF0SFpWZzVEWjhjVEcvdmlkSkswMkx6VERWLy9IcDQ2VTQ3Wk4yYUhSYnFB?=
 =?utf-8?B?ZU9XLzBxM0NGaHAxdlVlUHA1Z1JpeS9rZjlQQ3RGQWE1OWpteVlYNmhnVVFT?=
 =?utf-8?B?TXViRzd1K1BzNVdwS04wcUx4QmtUeVdQeGt0N25teVFtS1NJR3BlQnZvd3Zt?=
 =?utf-8?B?QmdtbXFTYmZFa0NsNFdPMlQ4OVRPZElLcmVKeFFWU1NLd21sWjg3MmlmcW4y?=
 =?utf-8?B?b2tva0JGNitpNVJyVzE2SUhNUHRYZjFXamk0SEh6NkNYcmVucWFnT2I1VCtJ?=
 =?utf-8?B?M0FzQU1qQWRHZUFtN2wxR0hmQ1JVQjN6amlLNlBvZ3R4WHBmZVcwQklPMGk2?=
 =?utf-8?B?L3RCLzFDSEt5THdWWEJqMjNFZHduanY3UFkzUCtNa2pXcDMvQXh0azFHQ0Rj?=
 =?utf-8?B?V1RqQjA2WmVVOWxQNGNwbks5QnF5d0M1SGRoYTV5VmRFcGliWW5LS3RqTnM4?=
 =?utf-8?B?UUdGc2ZGQlFUNzJqZ3BUWVVscklpNEJVd1hROWNJTDlTRzZiYmpSeHpwb0tI?=
 =?utf-8?B?KzVQcDdVanRFNlAyZ1pxa25UVUFIcHlSVXZURkdZMm5XTXFKdGFpSExRVDVX?=
 =?utf-8?B?N2E4K0lBaFF6N09ETzBja2lTUFRYYklNZktCaHVyOUt5OXMveGFKbXJnZFNL?=
 =?utf-8?B?eEJWS2NCQUluMkxBdkZFa2dIMVFidXVFL3dqNGw5REtQbE1mY3ZhSlAwVU1B?=
 =?utf-8?B?M3VVR1dnQUhpYXovZkhDU3lzbmQrWXBrRlQrOXhwSHNvMVY4OHBGY3dqV1N5?=
 =?utf-8?B?RVpzT1MxaDNPS3pZVTBwaCtkVzBtU2k3Z1BqSllEVlFkUmpuTE5haEJmNFVS?=
 =?utf-8?B?Tytad0xLcm5rV09mWWRaemQzc3ZCSTBPdlNLNGNzTUQybXZmQWx4ZHZpUFlB?=
 =?utf-8?B?akpsSFMvbHl5UWg3SmlwczhTZVRTUXNSRWhJUEFSUHhEL0hCaUtyUnF0Qjhy?=
 =?utf-8?B?U2U5WU5KNDY2QmswaVhGQnBZTElXMmF3NGg0eVdlRHN0aTdPNkdYSFVGZ3lZ?=
 =?utf-8?B?dkFrTmo5UFdhTityek1WT1QxNG9Zb1VKNldNVmpQUGZMT3dQdDFWeXpDeURV?=
 =?utf-8?B?TjVlM0xSbG80bzQyWGFFMzREcVZIY0k4eVYyUkhzZU05V2piWmlTVFovK25v?=
 =?utf-8?B?dytva290K2ZoRU15aFlhMFR2SkxHb05sWnA5SW1kWWE4V3NucFBOOHhZWk41?=
 =?utf-8?B?WHNRQVpSbi9LbE5uRVdSNzFFYnpEazRYdDUxb1JyTU5NcnhQbERGUFpZMDdB?=
 =?utf-8?B?cmlVU3QzS05SVWZEWklpZmxrQ3pUQUpBaWI5cmZob3BYMlZpSHpkamVuc1pB?=
 =?utf-8?B?WjFnWDNEOXhGTE1QQnQzVVFmVEpUdVhKSTdFT0l6RVVhTlBkUEFRRUJJVThO?=
 =?utf-8?B?ajJjK0YwQWhRc3pHTm1aMHJzYlpUb3JiRUx0ckxCR3VKelMwMnNSSWtkdnBq?=
 =?utf-8?B?ZmVISGRXQ0NUWktQdFBpd2JVcnBZZ1lmbk5JdzQwaXdpOGxNQlhaSmNJNmla?=
 =?utf-8?B?cUJVNGJ5VEtVb0Mxc1lQMTBSakh3elVWZjFZQUlTQXU5RGpicEc1b0xTSG0x?=
 =?utf-8?B?NkV0SjJDNkxxb3piMUJCWFFzRHhQZUYxanBnK1BCZlUvb3JFeFdlb0plUnVT?=
 =?utf-8?B?cjR5eGRSUDRETjRReUgrUElobjhSL2k1enFpUVpyM1cvcloyNEYycWd1eE8z?=
 =?utf-8?B?cUhOZzBjQkI1WERZVXVEcTdrdWhWMWhhQUpwaG0zWE9hSUdjNkVLRHZFak1O?=
 =?utf-8?B?aU1Cc1pjbkdpNjYwWGcxeitXQW9WSmRSMFZwNEVua01KSzVQbmh0WUV0eVRj?=
 =?utf-8?B?aFRvZVNQS0xPMUhmTlUzSFFMK3p1eVljVncrUnZXZE5GWU8zbGZiVW9TQ2J3?=
 =?utf-8?B?c2YwSkpjTGRhT3pVQzRDYlYwcFh5RGkySXRKWWZnUytUUHJINERHejNwMUdt?=
 =?utf-8?B?ZWRKL01sVEpDaEYwS3pGVFdXajl3Zlk2bnFyRjVmNkZkQWUzYWRWT1p2V1lL?=
 =?utf-8?B?YXNLQjhxV1ZEQXMzOWpuNXdZN0NIaDQ5V2tNV295Y2puU1RoNzhaYUhJN2NL?=
 =?utf-8?B?cTJaQ2hkTitxMUh1WTViVGxDa1J1S3hEY0xMNVFXUGVwT1VyQk95KzhEdmw2?=
 =?utf-8?Q?/KaFHyStwlVHMiyFML0G9DPqP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b4ba2b-3806-4e99-e73f-08dc89a2ac2b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 23:11:34.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PyNq/GHiMyYIZ0rgfxoyjY60puaV0tNjzskn7V3qdyh97OWiZdoouVvrzwaX5zz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854

Hi Reinette,

On 6/10/2024 4:32 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> (please do not send new version of patch in response to previous version)

Yes. I saw your comments on other thread. I will take care of it.

> 
> On 6/10/24 9:00 AM, Babu Moger wrote:
>> The selftest noncont_cat_run_test fails on AMD with the warnings. Reason
>> is, AMD supports non contiguous CBM masks but does not report it via 
>> CPUID.
>>
>> Update noncont_cat_run_test to check for the vendor when verifying CPUID.
>>
>> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT 
>> test")
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> The changelog needs to be reworked based on discussion in other thread.

Sure.

> With that complete, for this patch you can add:
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks

-- 
- Babu Moger

