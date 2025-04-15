Return-Path: <linux-kselftest+bounces-30877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF25A89FDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 15:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDC51902736
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E62C186E20;
	Tue, 15 Apr 2025 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GF5iB0ND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106013AA53;
	Tue, 15 Apr 2025 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724795; cv=fail; b=f1pDWZqvs1GMa6UwU1Jn6VNb7kKQN8Xz4dLMTsdtAX5IqGd1mY4iF4Rvubrm16zT1MgXug2BEdiO5Ym831uDEuXWz9ZjUUSJO25FZugCL/qtqaamn0roBiyhFg/aIpOvt2wimBXDElGlU/lw1e/JL/qMY3+N9t59X/W+1K5Edz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724795; c=relaxed/simple;
	bh=RVVXghNnzFizlWxZox5mNW7d6DZ/BCD5uwafc14YY6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WN301M990nipiAK/Qe0Y5VdDyyhPGMAJQi4Yf3DzOdyaNRWz4LSMqUM/d2LxFHbeNtuzGhWT5m0HoyRAe6j+F92eKH/aXMb5OtRcYnQ7tZSjb66pcvvelAgf8rHgkLfrK3igZ/TfXu3viPdyBlg8KWL8aNNUDs2Bb9bgpal5GCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GF5iB0ND; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgXIEdmWadhA2ffjvnyavn5jPlmIXDJP6ip7nohvnYh496RvQCNPu6z8YimS+oQ4Rm6iiBFKQJBl3WYkqF7Eews2Pa/e2VJTOvxBE6X/mZAmSZzGSU3YtyNjckHc9BWSjI+3f9TafW1Ma7/nKhNneQkpbJeYsClA6fPubuUQ3hv3Y7IwWPGwy5pnDj47lUmRg0U2fFf5NwQCqRqFWZ8d3p9mAKiR0bxtGNn6IPKb8b2TVLK20jS8qJjUUPoaA4dXTmN5kkbLkoBaiGdx3zBCGLvHbxKAy9bmJ/x/rsPNaaAuJw5Fhipqw6I+xYhxJM/QTVCqf0cPsl5eRmOr8wmFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeL8IpEtGgIRfKR9E5aFe4j5OaT2wB3YsAoWIGwm2vU=;
 b=RFOptDqxuUCxO6zzO8iJ83m2g5gcRlZHQrjBUgc87ppESDf0GEdccwi3Un+MTGLxaQAHA5YiwhRiTzzZTE88K1LWifyzLbLWohpPTYIVMU+rmZaC8wh53m8MRl6DbiBdsV/QhXfWLJsMWNFMR5xoifX+3DaETzcZ6giV6Q8QIovS5mW2yc2XPCWiWDlH5MZRGGUp3WALX+kui+ER52Yx8a7M9R7tntltcXLX+6dDjOMpFf6D2mwIATCToHwpH17AfUM1sdGEXaTNNTjbsWQYJac/Qig4yIxT+pTfaVdP7vZiCmPKE2q41kKhhb87ZWrDrslXpsd/tb1Hp5ozDDpVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeL8IpEtGgIRfKR9E5aFe4j5OaT2wB3YsAoWIGwm2vU=;
 b=GF5iB0NDVbgNxcpC2qrUvFtaoWyNhnguHfaVpVCWB358Vo2khfuhiRyRdnNyCj/fdy5KlenUOqB4BhGBrjDAsqihW7u9X8ulp979/8zoaaQHEHmnExWEcaEn7yUfnAewc2GQ4eNKhhEClG9HB0dNjjMhjrmPMENfY4G5kPYJNOLajv9vQHVh4r6/34zsjQD+FO91u+NWsfKt/GA92vYKnmhbKJvqBEzoIxlfLHLJOlLxykxISi1n9rpalOf8RR6w2gPV4jRg4Rk7GYsL9dqVsrDEZQpsCLivpEGEmSomNdgZP1qB1uVKE9UQwOfyQGY+3BPyPV3o35UYNFV8NScxAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 13:46:27 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 13:46:27 +0000
Message-ID: <9d549c29-1036-457f-a909-65c9dcc08a62@nvidia.com>
Date: Tue, 15 Apr 2025 09:46:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] rcutorture: Fix issue with re-using old images on
 ARM64
To: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250415133622.1563137-1-joelagnelf@nvidia.com>
 <20250415133622.1563137-3-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250415133622.1563137-3-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::34) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: e3382eea-dd78-4a99-ace9-08dd7c23eb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2Z4U0p5dmhjcHhGYnJaamFYMWFJcDVsQitlYjRPcklwYjVyekxpcEkyMzFi?=
 =?utf-8?B?UC8vT0NTYWxaV3hXMFN4WVl3cmxicVAzdjdyREV6K0hpSldkTXNqRkRveXdr?=
 =?utf-8?B?T3VHT2NYNGd5dndja1RkbUY5N1V4VTBvRmhKUW1LRnZIQlRObXJFWDV4Qk5x?=
 =?utf-8?B?a3ZLUlBBcXc2WTcxS3picVc1dG5Zd2xZUEwrQ1FZU2k3TlFrbytXRWd1WDZT?=
 =?utf-8?B?TlhvZkhONnM1VlhpVnQ5RDhWM0wrWWVmQjU4bVQ0K0duZHBadml4S0E4Wm5K?=
 =?utf-8?B?cTBneTJZMFhaaDNnRWNDejZmTFJnOUswbDFKSUdCd3QxeHN2OElXOStralJ4?=
 =?utf-8?B?SEhDSWs5MlZzMnNHaCt4SzMycXJZN2cydktLWFlsUFNaYlp1QXZSM091V1Fp?=
 =?utf-8?B?aU5Wd0tRTGpVbXc2Z3pvWXdmWUgrRHVSU2RGV0k0MXhNQUVWZU1JNlJ2MmhX?=
 =?utf-8?B?d1NQVERGeHJsWnJYNmJEbjFvcTJHU2s5bXFOVGdMY05tMy9jTnllTEpwY1V0?=
 =?utf-8?B?bkNMQnJmUWN0dEY0cmF5V2lkTkgyUE0rMGNveVVRWUgvWlRWNXdKVG9HUG8z?=
 =?utf-8?B?TVBGTTFJWFFYdmFCYS9wL3hUOFNveXIwdFUzc3U1aDhwbW5RR3BVcEkzZHFH?=
 =?utf-8?B?bEc2SDhqZnZUR3NPNFpveVRRR1JuUUxCTlFIS1hBdzkwU2xMZE84M1JSamtj?=
 =?utf-8?B?S1llZ0ZmVU5DSWNYWEljTS9meHBCSC8ySWM1dDUxYm5YN0ZwY2krYmp6cHhV?=
 =?utf-8?B?YnZwZTdFSFdDQjF3WlgrOUUrSWhqaW5EOEVaQkJnTW9mTHQ0VXRUek5CYzcv?=
 =?utf-8?B?dHhwM2gzblJSWHUvRzhCeEt0ZjYxazU3RUxoWHZWaFg0NmFESVFhazROa3JJ?=
 =?utf-8?B?UmF6U2IyaXR4a0FXYzl5MTM1YWFtS0J1cFNweEJkd1Y0L3ZPV2JNMWJKb1dS?=
 =?utf-8?B?Z3Y4enpGZ3RDc0puZXQxbDg1Z2w0V0VKOEdRWlNzRUxrVEF2OFFvNVlad29N?=
 =?utf-8?B?VVFCa255Smo2QnlwVVlndno5QjNVUE85WW9sVy9uWXlPTmJXOFlaNW1Ub3hi?=
 =?utf-8?B?QW1LNnpHbGxhY2ZEY3RoMDFTSjFFV0M1TUhoaHpuTTNvY1Y3bWxXYmMvcUJz?=
 =?utf-8?B?RXdabE9KU2N0WXhBSWtDT1RDWmJJd3VhWjdVeEhrYXE4dmJLdi96d1Z5anNa?=
 =?utf-8?B?aTlpdFh5RG8zZHVXNC9HZlRMUXVCd0czb1NuWHlmZ3B2U3J3Y052T3prZThj?=
 =?utf-8?B?U2t5L2tJQ2tJRlpJZ283N3RxbmlvRHRwbWUzaCt4Vk1uSlNDcUJSRWk1RkFW?=
 =?utf-8?B?VWUzV0lXak9sVkhYMkR2bzlvdElOOW1xRmMvMFR2eDNIN21GQitGVlR3VlRW?=
 =?utf-8?B?WTdXSDR2MjVvYjJuZ1l0ZFRPNTdIcTlmNWptVitqdi90NVZkbzhhakdnN3Ns?=
 =?utf-8?B?aURrUEdpdVJkT3JZN2svZUhlT0xUTnowYzlUUlloVVc4V1FheVJwdVA2a0lT?=
 =?utf-8?B?SUJkaVVDMkRzVTM1UWM2WldNTXdhU0JlZDF3WkRBTEU2eGpNU3RTZTB3RFFK?=
 =?utf-8?B?NjdSZUV4T1EyYzBGc1VCb0IzY0xuZitNanc0MkdmV0kwdGVlNVJFNDhOMUIy?=
 =?utf-8?B?Mkt3ZC9TU0ZMRGxFa21pNFJQYzU0M3JTaHhMVDZEcFZGRG5tQ0FhNUhib1RR?=
 =?utf-8?B?dEZhMmxvWnZDaU12eTlnbnptcDFkV0pEU3dWR1FyZUhXdytyUUlGZE5teWx1?=
 =?utf-8?B?eGc4YmNnVGgvbnJyejNxa2ppaDZEWG1ZeUFyNnFQc2pUakFMUUZUT3Y4NFBS?=
 =?utf-8?B?ei9hT0p2YzhRbURQVTRHd3VONjZ0V3FOYWt6QWxsVjZHWDlJMXZ6bkl5Z1RJ?=
 =?utf-8?B?MFd3Q3crWTFWQkxaUFl2bEFpWEVEaFVPazE5SXBlcEg3VWZIUldQNExYaVE3?=
 =?utf-8?B?VXJWR1ZCckdyZ2k0aFdvazdzQlg3SytOU2p3OEFKQXY2T1Rwd1JJRGlheVBi?=
 =?utf-8?B?ZGlTN2xrckNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2FQcGkxQTRLMExQNjBQamRDYktVdEVkWEZ0c0RFN0FJa2s4NDMxWmlxVXMy?=
 =?utf-8?B?QU11N3pJVitRaUFiRDh5dFFYTXdUYWNsOW1nUElaMU1xMEtaR2xRS1BQOUVB?=
 =?utf-8?B?S2poMEswM2tKWGJqV2xxQjhMVXdZRGh3dUo1UW9Rc2lWNU5zOW1YNVJ5S0Rn?=
 =?utf-8?B?MEZtTkJQRVFaMGlSL2pUNDZ2K2JzMWNYNVVHNXY4dE14ZlJHaUltWEhUNGJp?=
 =?utf-8?B?V2lFZ2NqZjc4ODVqbVB6OTlrWEU0ekRNY0wzU1l6U3l0WW92ZCtLaEphaUMw?=
 =?utf-8?B?aDdKN3lsa2hEa2x5UXBsV3RlQzRDL0VIYmZiNGQvZDRzRlg5MmV0OFhzOVJk?=
 =?utf-8?B?bjF1VEtvalYwL2JtOGtaQ0liYjdDMXRpVzZ0dzk2WER5dEpEdVB0dU05NFc2?=
 =?utf-8?B?U1grRkJtenErejhKSFF1ZmhIeXFxQUt4UklaN0EraERtZUE2YUtVVTYvR2Jq?=
 =?utf-8?B?eHFEcTNkNS9mUXJCcENiQ2ZqT1p3RzJpTm8xeVJOcUtpR3JTRXp2UFcxb3Zi?=
 =?utf-8?B?S09mdCswM0d6MEhFN0ViR0J0RUE3ZmtLWkFBZnZXYTc3VkZZOHlvV3ZDZnV5?=
 =?utf-8?B?RFdIVkJLSE0ybkFUcWFabFVKdEdVbWhRNHhWTHhiL2k2OVRrTng3a0FoQ3NP?=
 =?utf-8?B?SmNqMUdRK2w3VnoxdDlBQXNwNVMwUlBhalZrWjBma3ZIN2RKekFkNDlqU0hr?=
 =?utf-8?B?MURiMzdwMDRieGM1Skc3TGE3L2dFSDBsSmliODZwdy9uSlZWWmZUZkZyZDdu?=
 =?utf-8?B?cFRGeXpIbnJLMDJ6dzdxOWg2a25xQjZON1BEYzdTSStBb0lRVm1xSWpOdWRY?=
 =?utf-8?B?WnlHdzV1MGRxRzJOdXQ3SmpFM1BTRzg3TWQrQ3MrYnBJK2dJZk52QnA3SS9Y?=
 =?utf-8?B?cXQ5TTFHRTJRNytMWmlMclZXMFYwZ08yVm9vdUV3WG55WXZFZDJxeVpsbUJn?=
 =?utf-8?B?WmFUUjRjd1FBRWpwbDl3MmZYMU9sU1lSNDVhQ01PNVdCRjI5aUFqVmNXbjZQ?=
 =?utf-8?B?QUNDSDQ1TWZUYnAzczEwTk5paStSeVNWc1JsQWk3Wmp4VFBGcU1LU0lFTnVW?=
 =?utf-8?B?U25RblpRdlJTVW5rdUx0YWVia2lwUVU2WjRadlp1YXJlMUluNVVLUGJKekx2?=
 =?utf-8?B?U0o0Ry83L3R1emVCN1F4U2ovS3ZwTHBUMnd1SkNUeUlwNmZ1VlU3WWRreC9V?=
 =?utf-8?B?UWtxWFJRa1A4Sk0zNTIvUDMvb0NuaWd6ekJwOS94RG43MzVjWG02S1hPbUhP?=
 =?utf-8?B?R1lVbEdqcElYNG1XWUZ6SUxlWDFycFNaYVlRYmxYdmpiaFdHbWxNTVQ0elpK?=
 =?utf-8?B?azhtM3hIVko2c293QWhnS0NFZ3h5N21JL0JSb0gwZ0FQa0hXZ2Z6eGk3QVJB?=
 =?utf-8?B?Y2Z6K0JwZ2YrNzdLK0NPbjR2V0NTUnkyTGdWOHNWM3BLTThraElTODFrZ252?=
 =?utf-8?B?Q2dWWHg4RjBUNDcxUWZqbWp5QmQvN2Q2bHdxb1JiVnBGNThhcm5JK3Z2N1hU?=
 =?utf-8?B?MnlNVUFYamYrYmp3Q2dRbkhMZkdLL3o2UkExNVZnY3hBeFNlaFVsMm5yOEVz?=
 =?utf-8?B?OVVwMUVzLzk5RWh6NHRXeEMvZHNsbXBWT1ZuY1VHUkJ4NzF3UzlmeXZrSkZV?=
 =?utf-8?B?NUpRaDV2SUxDSjQ1am5xVDE5N2xQT1o0VXNLbUxpRnN6elJRMGZKMFN4a0xB?=
 =?utf-8?B?eGZnUUE1cnJQd2IxR1lzbVpBMVpSckRKOWowTkpRaEdIYTVwdjhZK3JaYk4y?=
 =?utf-8?B?dEtFZDJCZzRwNllRQlhucndsM0FPRlBLWm56TGtwRW9vd2U2YS9pTy95b2Rr?=
 =?utf-8?B?LzRrbEtDc2tVRlNCRjk4WlI3eTNsS2pydzlkRWo2L1ZLdDZPMXBHakpVclYr?=
 =?utf-8?B?VStjUktZdG50MUdERUVlbk1QdDBqMFBHdzc3Y2xEaURPOCtkNE1uT3NWYzlo?=
 =?utf-8?B?Tk41cWRibmcxeUVacS92ZmJRMnBudllWZHNOaTh4M3R0cFBQK21YdncvWnBK?=
 =?utf-8?B?N2hmME5iNlpJc01vWmRwcWVpcTdPSWtQOVQ2clhkYnpnY2hEQ0tQRFh5M1VG?=
 =?utf-8?B?Q1RhckNaQmNURmRPOXdveGxmTXpDcGJlSUlTaTBWWGFSTXFYY0M2dVp1RE1M?=
 =?utf-8?Q?Rqol99wOaKADgpYfQ34LheOMe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3382eea-dd78-4a99-ace9-08dd7c23eb5b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 13:46:27.2839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bR5JhY3RenypVn4uyXsnimsI7iNm7PDTV9A3Z+VuepVoDtnugLdDkr/9fc9W955TEWLqH3i3eODOcCdY2TYtDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810



On 4/15/2025 9:36 AM, Joel Fernandes wrote:
> On ARM64, when running with --configs '36*SRCU-P', I noticed that only 1 instance
> instead of 36 for starting.
> 
> Fix it by checking for Image files, instead of bzImage which ARM does
> not seem to have. With this I see all 36 instances running at the same
> time in the batch.
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/rcutorture.c                                  | 3 ++-
>  tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 74de92c3a9ab..df6504a855aa 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2412,7 +2412,8 @@ rcu_torture_stats_print(void)
>  			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
>  			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
>  		}
> -		n_gpwraps += cur_ops->get_gpwrap_count(cpu);
> +		if (cur_ops->get_gpwrap_count)
> +			n_gpwraps += cur_ops->get_gpwrap_count(cpu);
>  	}
Oops, this hunk was supposed to go into the previous patch. I fixed it in my
tree and will post with the full set of torture patches later:

https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/torture-for-6.16

Thanks.



