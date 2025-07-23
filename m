Return-Path: <linux-kselftest+bounces-37883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C598B0F7B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13ADF3A205D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 16:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6E18BC3B;
	Wed, 23 Jul 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ATdYWNyB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC871339A4;
	Wed, 23 Jul 2025 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286497; cv=fail; b=d3njqPaXHBAIiwesnPBLZMeL9+i4rNKb0UM+V6s57zC1vLv1yQNr4A+m5V3cgPGRDjoNPuBKH+sH3qvMCcmIiLIZ5ZnSjvJEvs1bxAMfJ78wRr0yRLjEGkO0K/jw4O6D7O/pdS06QMWLRmlv1uF+kk9XWK6ofCnGiJ9N3/qEuXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286497; c=relaxed/simple;
	bh=SEMiSvdjCLN+Q5R+OyrwFSpx/Ubi//qgZTaF8KKqDSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tL83M8QYdGad7mdQ8YWGIlzTp5dCurdblJ7cq+62o+GDV7DdMovvAVOvbGVue9vsFDZgDYX5U5ml+dwvphqJe4APYFLOTkKlupugKCanck0owIl0nLDkpZXaBhNDp01nSjqDmi/JSnP6klt3KDGTVofRA+k5MvMR6el1Or7EHuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ATdYWNyB; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5wBTkYaZoJO/ixJpHUG4JVxWIhiZaDvVdwRFBB0rU0Cox064MvktN15U+bfCEuLxS4Jvn8k4frTx4jFvYZ80iyMsW/P+KL7Zaeif9TZdZrdfj981ZQUBXfiPePn1KkzMpXSsKjbJdRVpLemGrvEqkrNDm42GXKzhJglQC9N5AYtjv+sfDvX4pmjPAR1/g9VtaoyBAc3oZiq9sZjILoZLgOdfP0p2VFcAblqDOKvHRQ6rMzKttJBWVEP1nhF6cwc8In9NfldcU/7/jbosn4rjrJ9CWJFCWyuXHsBr4rwLiRIhO9WuH5RkJN0/qswXKh3ZcM9zUglviWgFNmJ3cdohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DADgzYP5BOxvLW41Gt2uIOd8ZwHP6DivrLoov+yBlqY=;
 b=W0uRkH9k/B3PMvntZBI9AlxH45lUpMdn/M8TIabhWb7SEucYXsrBjwtcApfkQAi55hznvd7BQ22APjvLXg852iboaZAWRlojXw8TOTbb7MmSnyoX8899gamyyYLyqqtyAr4kmWsPGzwpBb26/fgSekFYAh3tfjiztaoBT2JcHyKD+FxiDp82ImFsBQ0CEoFOMFk8qBJWTlkZQyEMaXWxjCXXzCVMEHl3vlRUzVDdZR1rzJBLAkUVn/ExAL7tCkoZ9TUUnppXqiaNvu9DzRtuRTVrBxlalbDgZNnwAma0/JRRV0nUB4Wce2BeJvQvnNR++GTDjEoqOJgmvS9MR26vdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DADgzYP5BOxvLW41Gt2uIOd8ZwHP6DivrLoov+yBlqY=;
 b=ATdYWNyBsVi0mk9bA5IVXEDt/2obzXVmxmuiuVSG4AtyxGS911ZwVFBBc4BcS8dOH4leSrLnrHu0G6i7VVDhMsYgwZga4clTjpvT4zI/aG6vaumw6C9CJIh9qxhPVVXl68ytCopOH4EJGG1+g6pZRGVOCU9p3t95Ma2oC4cKjrPYvlFaoqssuca6UXg2v8KrCjKU/orIwna2yB5QZcqUVbWZzdb64K1YpE+tZ8SGVI9R07isRFtjIlolYwfTih9yteYlB0mbZhtW2RjK3olAARTmlEu59EefWmo2LPQHZm+RxyeCgNBA9IxLzw03hJzSqsk3d7sSpCwRNkHArU7YIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 16:01:28 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 16:01:28 +0000
Message-ID: <dc36ad04-c9ae-4e28-bb9e-c2670e5549ab@nvidia.com>
Date: Wed, 23 Jul 2025 19:01:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 0/5] selftests: drv-net: Test XDP native
 support
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 horms@kernel.org, cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com,
 mbloch@nvidia.com, jdamato@fastly.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 Mohsin Bashir <mohsin.bashr@gmail.com>, patchwork-bot+netdevbpf@kernel.org
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
 <175323423849.1016544.9128937268934260157.git-patchwork-notify@kernel.org>
 <48bb190e-073c-4ad8-841b-f6d0572cb0fd@nvidia.com>
 <20250723071253.54a97c65@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250723071253.54a97c65@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: d88d7f16-55c1-4114-9cd9-08ddca022e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGlqRTdPVnFLV2ZRMmhhRWQwOFF6QW5Ec1dLZThYam1UM3NWQkdOR3RwRWU0?=
 =?utf-8?B?U2x6VmlKZnF5Yk5CMjJQQVcyOWUzdTJrSGZTcDdXeGRjZFkzZDZwL095dUpU?=
 =?utf-8?B?eE9zbE03b0V2ZjFnbmNVUGZoOG9NczhwaHE3cU8yRm1iMk5GZS9VeEhuK3VW?=
 =?utf-8?B?elEraHJtMnV2RjFlOVZwc2xSekgrMTB2dWNIRXpoMDJoVlRGbkRDdVNNTmM1?=
 =?utf-8?B?M2dSV0VVc1hDSTBoQzY0ZjMxTHFBWkRSbDJqZ1kxdnhqM0RycS8vcnpka2xh?=
 =?utf-8?B?cXlqQkhuYzVJOHlUeDhWSlk4ek9BR2E3MlQwNXBSdmh6T1g2RmI4bDlJT0Zz?=
 =?utf-8?B?SzFoSWU4dDNtSG5xbHV5M3k5RnNKZTN0aE82RFluTU1CS25aSTdFcE5qbWpL?=
 =?utf-8?B?Q2RmYlZGR0VNSVBzYllUSVdpS1BqRHdZbzh1STdVZVZGRzdTTkFMU3dMdmJw?=
 =?utf-8?B?cmxmU3JaY1A0RllPb3pxV0pGWUF3N3dWVTVWNnE2cSsxT2Z2d0dQN3BuaHMy?=
 =?utf-8?B?TW5xV3NPRGlqb251TFVCc0hvNmhWNkpsTnJKOEV6UmNEOHMzSGNhMmJhdUxK?=
 =?utf-8?B?NWs1d2tJM1NLSm1qbUZvdm9FU1orbVIyMFpRUVpZcCs5dDdRWU5YMmtMQ2lB?=
 =?utf-8?B?Q245a0xQZml4dVY1MUt2dGJJWXdqV2VhNU01SzUvUm8wRmVwSTQwRlRzOXpH?=
 =?utf-8?B?Wm1LbWJ0SnZmdURJQm1MNXQxMG94ZkRudDhBTVdPUEo3VU5rUzc3bTZzSGtu?=
 =?utf-8?B?dUdONzNyYUVYZ2I1YjlwZnJ0c0FYS25aSzZPWGUweHJlQmJpVUYvNHhUTGJz?=
 =?utf-8?B?OVpMeXpkMG14TVRMUU9XMlYzMkZic1NDak8wWXRLSys4RkFpVkNGOWFDL2lE?=
 =?utf-8?B?SHF1dnl5ZUNMcG9VQjNlV05TTm5yWGJkU3U2bGZhV3haYnVrbUY4Q21Ta2hs?=
 =?utf-8?B?VUh4bkFDYU5tSGErZXdVdEQyMitkZ1ZDQ3c2TXhpWE9vOStKbGJiUUEwSXJx?=
 =?utf-8?B?WWpOVWgrWkxmdjk0M0t4VTFweEdFd3lFc2sxQ1M0UytYY1hMNUk1NmR0TzB3?=
 =?utf-8?B?OWllQmNEUWhERmVMVmtSNXR2djBjSXBac04xeWJNdHRlVlp5QmozSnExZjIx?=
 =?utf-8?B?dTNtR1JxaVY3bGVzT3VnYzNVbUh0eDRlQzlrQnl3Q0Z3ellpakhOaGpTbjNS?=
 =?utf-8?B?bG1Md09aZjVISE8wZVlRMGJCd2t2aVZZOWVuMDNMcERRWHFNNXlvWmF6RmZq?=
 =?utf-8?B?QWZVUDd3R0svWXFidFNLdWFLWW42aDB2MmxDTE5CbnI3WTZndGlpWEtQVkJv?=
 =?utf-8?B?ZjIvSHBaWG4xL1BCL0l4OFFSQjdDNElhL2hCZGhUZXB0NUNLb1V1OUlkanFo?=
 =?utf-8?B?VWFnS01YYzNEMDFhcGFIVnFPcGdKNGJJRDF6cTNjRVRGWEcySUxSSjZmaGU1?=
 =?utf-8?B?eVBJVzU5NFhUQUtXeG1rSEZrMHdkcEhNS3RTMVpKb0YvTS9pSEI5MEpBNFF1?=
 =?utf-8?B?em9pNlFZalNiMVVuTEtwem9ZdWNETHk5eFdzMjNybjRFaEFWM2xvYWdmaDNx?=
 =?utf-8?B?NmJpVDJBNWRjMXk3NGp1Y2tSSGFxN0JqOWxBMGtkalFQUWlSYS9wNEFzK0F6?=
 =?utf-8?B?Sk40Tk9hNVYzTWs2RytIZXZRZ1JOS0lyOGtQSFBxb1QzeVA2b2Q0VVF4QWlt?=
 =?utf-8?B?S2t6aXpTWkpveWlaY3BEQ2lUTnpKalAzWHV4Ti9BRWZLZi9wa0tOTVdQN2gw?=
 =?utf-8?B?ZDJCVjREdXBlZ3BYdUNsNHQvUm04Q2doR0dHT3QzdXdQa01EemllMEVPemNs?=
 =?utf-8?B?NENmellQWVN6Q2owSXJ1KytGNUEzLy85WVM0OGpkYXhSUU5vZUJ1TTdudW5v?=
 =?utf-8?B?b01XSlp0VUNzd09YZG40ZHMvTmhDanV2S3FtTnRxS01SZ3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1Q4TFhmRlFjZys3QlQzTnhWVlo3ZGQxMlpncEkyYWV0Tjg2SWprVHc5RUt3?=
 =?utf-8?B?c1JuUFBBL3l6OVpuM2U4dTB0VWZXbHNjamdpUXZGQjVubHMyMzVjMDh6L2d0?=
 =?utf-8?B?YzZyeDdUMEcreTJCcGpMaXhpN3hIVVRFcnlmaU5pbjFLRWNMcThLYmh4ZUV2?=
 =?utf-8?B?WmhjYXZ6QmhLWmZLaERCNzZYcE5icGhxRzdiTmtwbTd5cUsyQkp4YklDclEx?=
 =?utf-8?B?eXg1ekkwVzMzUVlVOG1hTnFaRmYvRUdrbkdKRk05ZHNETUoyc3RHYk1GVm5S?=
 =?utf-8?B?blN4Ny9nVWxzelFWdkZjZnlya0JJVnB0TExrR0h5bHBxcG55WHJjMitESEs4?=
 =?utf-8?B?RGZQT2xJVGdhTUJ2QWM4cGVZNFlBUkNzQ2lPMUNvTkh1SDhvbjRLRWMxcFJ3?=
 =?utf-8?B?cDMwZnhxSVc0UGExcGYxdXBpdjJpemsveE9rcWJ0NFJibXIrVEtBTFlwNUlP?=
 =?utf-8?B?am9XUEZibzh4K3QvWnhxeGxpeVpWenh5Z2ErTGRXMXRIWXlpdWREVldQOW1Q?=
 =?utf-8?B?enREN1phNkZZSnJsQmQzU1ByK1VUdXRoS255aEtpYUk1cmNRWUIzWXF2VlVW?=
 =?utf-8?B?eW1xTVJ3NmhSTDZNbWhlQUUwZnJWdUZqWmxoMndnaGUvTFU2NEF1NkU2a29o?=
 =?utf-8?B?R1owcVJ6b3V0VVc0TU9BK1pDbkhiQlJBVnFWYjkzLzI3UVNxdTFYVWhHeWtY?=
 =?utf-8?B?UjFLUU9hSTdySVp2M2NJZGxNVkZRVUNwbHJZVnRLenBRd21BWnA1NGI2KzNS?=
 =?utf-8?B?aUIyM0E4OWdFZmRnVGRpM3FIcG1pN0J1a0htL0pVdWZNUWZXa3FZbm9vUWdv?=
 =?utf-8?B?M3pXOGJFUUo0b0draEJ1MUtKMkVsdnRMWGhYR0pYVkpiandtWWNSMnVUWjZB?=
 =?utf-8?B?NFU5UVZ4aDQzbDcxSWxZcTdRTG5XKzQ2bFZLbHNId2s3aGx3c3lialU2dE9Y?=
 =?utf-8?B?RmxWWTQxTzJ6SXhycnBSZXNvZVNYRnFlTEUxU3NXSE9ObThUajJxdnMzN0Rk?=
 =?utf-8?B?NzlVSm5ZR2x4RDBtS1lSdXJYT3ZIeGwyc2tSSFRNR2ltMlRZb1RseTd6NzBu?=
 =?utf-8?B?c3V2RDkvMmtudko5alYzSk03K3BPbTBVNFlKU0dmWEtBdmZLemN4WEdNZzlT?=
 =?utf-8?B?YTkyV1daT2UxR3RvRHRuWGZZYnRJVmVFNnYzMDlteE9FWE9DM3ZrbS80djdT?=
 =?utf-8?B?NGVrVlVid1JIeG5KbGlrYXl1bXFCMnhUMmxpbGM5VHpPUHl2ZktyVWlDWHRY?=
 =?utf-8?B?Mjd0RDdUSU9vSXlObkltNW03NENoK2pWcWFyNXAwRkMxY0ZVOEFnNHJVeG1x?=
 =?utf-8?B?VlFuUlVpSG5BcXh3eHdGTmlkUDlTbE0xOStXZ1R0OHcwaXkvckd3ZHQ4Wjg4?=
 =?utf-8?B?Qko2dTFsMG9qNUR2QmJmeGkzeTk1TGlNZktjeThCOUdXNThWZ3l1WXIvelFW?=
 =?utf-8?B?NStPMW1MTCtpM0VtVWV6Y2owTkxZaG1jRm1xQlk1eXdpNlpZMlFlbFZubGFm?=
 =?utf-8?B?bysyVVpSWkc3YnRrY3BFOWFqTXhJbHl3c1Z5bXA0UzJESEtENGJpTThQeG1l?=
 =?utf-8?B?bnhMZmVUb1l2TGdPRFAwMjhRcFkxbk5CSlVXYWJnRCs5RWpudFVRVGMxNmF2?=
 =?utf-8?B?cHpZaU02NFplUDJaSGNUWkt6eG0yU3ZaOUNLTGEraXd3L0RQVWpZV3dQdkFB?=
 =?utf-8?B?YVVJL0ttRjF3SW90Ti9TM2lHdmt3UTVOaHEzSEtLQlpzZUZJcVR0blRtbU1k?=
 =?utf-8?B?Zk00R2hCWVV2ejhMZXdWcU54VU9kZEdnbjFFcGUvZGozMHVhR01BUzduWitL?=
 =?utf-8?B?OGhaSlV1Q3ZKL282b0ZGN0RxcGp1aFdzK081cUU5Y0EvNFFWTlpPamlpNDF3?=
 =?utf-8?B?SVFjU3VhQ2Z5QW90bFFLMFREK1phVVhaVlBmUENpa3lEdmlxS3NoTjN3S0lQ?=
 =?utf-8?B?ZlRBcTJuSzc4a3FtWTE4VXJvb0NqRzIvTEhyUFdtQ1dOK3hONUxqVGRlMHQ2?=
 =?utf-8?B?OXlEcEU0QzhLR3dzMDFFRnhyVVJnMEYySGlqZHBxVW8xVFRIQkUwbDZGNUc0?=
 =?utf-8?B?aE8vM2dyUVRoRXVvV1Z2MFJ1L29qSFhBbGVWTzRlSTlVSnFSdGhNWGorWEZv?=
 =?utf-8?Q?MiXGJoZoV0pRdI+hPliENcrMb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88d7f16-55c1-4114-9cd9-08ddca022e93
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 16:01:28.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9bOMxjIsDPPfE3rcgPQ+vxxqsxdM1tVyD15n3dXqQt3fYvVoRqiVuzf4POaFigg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115

On 23/07/2025 17:12, Jakub Kicinski wrote:
> On Wed, 23 Jul 2025 10:11:57 +0300 Gal Pressman wrote:
>> On 23/07/2025 4:30, patchwork-bot+netdevbpf@kernel.org wrote:
>>> Hello:
>>>
>>> This series was applied to netdev/net-next.git (main)
>>> by Jakub Kicinski <kuba@kernel.org>:  
>>
>> Jakub, the test was still under active discussion, and you knowingly
>> merged it with buggy code, ignoring our comments.
>>
>> This is *extremely disrespectful* towards people that spent time
>> reviewing, replying and participating in the netdev mailing list.
>>
>> I expect better from you, and other netdev maintainers which allow this
>> to happen. Please uphold your responsibilities as maintainers towards
>> the community, this is unacceptable behavior.
> 
> Man, I just want tests upstream. How hard is this to understand.
> 
> These tests even work on mlx5, AFAIU, just not if LRO is enabled.

Incorrect.

> 
> Please at least try to think about what's good for this community.
> At least try.

Blatantly disrespecting the community is not good, it is unprofessional.
Don't try to justify such actions.

