Return-Path: <linux-kselftest+bounces-37864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93257B0EA7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 08:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9733B4B35
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CF826B2B0;
	Wed, 23 Jul 2025 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="loEaKWAj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C378F51;
	Wed, 23 Jul 2025 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251478; cv=fail; b=AwP2QY4N7bh/+2wOi2ULEHi7uCGv1oMy6ABXYm8avQwYmCd31aTH4p5hb37tZeMvSM0E+DbQFt68meQ0raVc7pXbbSi6SNC2W8Am1UWQQMn/zhqVX0ZkxFQ/FxUkGMvP41+fPPh40Cjx7tunLjIjHFVq9jto7dLrJ8E2jbUR4ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251478; c=relaxed/simple;
	bh=khwYtrY1MQIXmW8psiH3nFUsvKpWZRbrVKqnUwRvW/0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sE8GNTQbPQJwe0Do/y2qCdmdN8N3j2yu0KMCV9wp/rHj0pAWrgSCwNR++K80xrIbrTp4Mr8w4fSCLJrxrntTbNPVZxKFFzl2eoLl2VO2qlneePgA3fT5ntbgIHNDudglKEyzGK0i1amkFj+eTKUt/xd/qU8ium55JfT2kpzhdzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=loEaKWAj; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiGpJCwemK/wx5D5+MVALhdpFscy4RRZuzNYyDwuIrF76DD62purZOJ8sgKwpxdjn8M5LBhBzcV5FGcTARvq723CJhIuY0MMOmmjxYQxD32XQ+xeauttKIw/K/LFParwXLwHnJ9zIBTf+gagAMr6cESNvcf6TCXfU/VsYHKsDq/u5i5OPoDPLLqtYDOS4aZQxTF0O3TKyVU56RWR9PpxL/srZQCWjGRqjvQv4YD4ULABMONIN1l+zSBLORMBObw4EPttUf+eWHtIVODpoQ7M8AsKL96LfIgd9ttajUuqp8qBo5XxMOBCC90qlpPimXhUwVEeKC0hommlCWhi32TQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVkPWV42KZd8m/vH8t5uhFjB7T/lUD2yHfdnJZdWuhY=;
 b=HdhJeyILKr1RsFtXU3opW+DAyqvUpjGfy3gVAzmWMxclPPpRCAHG6Rwl+c4Q/tluybYxVUfBnwGaqaef/vFsOPlqNu3lde1okfr0vXrunK8PhtBVKgHh9xS2GoJaFx7Z5FEgUkzNLGV4ImtRebU6DvHT2Ui7QGBun9tX24nbQfwU8oExwJC6TdpX8WKRt5YWqa7BRQH6yPIUBDQdHL81Q+yTdj5upw6RAApbu28fKbrZLsq5GsskMtpxpF2y/v0/huUzr2F3eHQivpXgV3GcwFQfUBPl+c6IKBTS9dvUCQZhqNiM3WqkWkQhTUNWZDKSqvR4+WTkheRYnuPK7039dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVkPWV42KZd8m/vH8t5uhFjB7T/lUD2yHfdnJZdWuhY=;
 b=loEaKWAjpPEdyhfC0G6g0FA4OeuqfAZi+VHpLLpyT9US4Hj+XpVpv9e2bcvN7IN8Gh93KJG9Cx/amx32iUDgTP5URKz1M42GIGIakKJzdksE+ui3ArDchhzso3c97Q3a1M7VjcnI8FLk/t2Zpt8AYX/CfqvSGg5bxYpehmOC+8hC+m5XxWxnIsnwNDW80HxPQ1t7Jm7WPQnpiQIOHqt66tWVY9WeC6+6Z170PXX7BC9264bVGhFcJKaQS6ZPEBsZq7VRCwfbDN+OopZ2tAVYGSj+Mv3Y1hiTTyb3IXVUgrXfyZ4biqZb/s5WpVfrvEqcPqNQAdPiHs+5rsvbyLQGxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 23 Jul
 2025 06:17:53 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 06:17:53 +0000
Message-ID: <4f350869-acd9-4e2b-a3e0-b3f29a7fbbfb@nvidia.com>
Date: Wed, 23 Jul 2025 09:17:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Nimrod Oren <noren@nvidia.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 shuah@kernel.org, horms@kernel.org, cratiu@nvidia.com, cjubran@nvidia.com,
 mbloch@nvidia.com, jdamato@fastly.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, tariqt@nvidia.com,
 thoiland@redhat.com
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
 <20250719083059.3209169-3-mohsin.bashr@gmail.com>
 <ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
 <20250721084046.5659971c@kernel.org>
 <eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
 <eea3a104-1cb9-4606-9664-a8beda93e018@redhat.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <eea3a104-1cb9-4606-9664-a8beda93e018@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: d71292ae-d6a7-4deb-6c87-08ddc9b0a86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elBVUEM1blh4MGtNUGRaRHR5ZjlNMjZaZ0U4Z205cTI1UjMzbW83cmhIbmFj?=
 =?utf-8?B?ckFScjBBK3QvVmp5T0ErNnJEUm9VVVlwNTFyTmJVbjRUQjdKcWhLYlRUVFJ6?=
 =?utf-8?B?L2szZnFEb2hqb3VXY2N0YkNneEZpMnVib1YxSVN3NWkxOExubEpnUW9hN0o5?=
 =?utf-8?B?QWpURmsxcHMxUnJEdGtGRERaanhqYzhlL29NaWtIQStFMUxOL1Fha01iOWMw?=
 =?utf-8?B?alFlaTJ3NWVlVkZCdVBPRnVQMThxTzZmY3NtbE9DbGc5cUhteVREVFpGWFdn?=
 =?utf-8?B?MURtVXp2dTdUYmN6WDlWRDRpWXFCbmREbURxU2kvWUMyV0RFZjBMY0YyQ3lw?=
 =?utf-8?B?dm9xa1ZlUStWYTlGb241cTIzSU9mb2doMWlvdXNpd3JPYWhFYVVFTG8zOHpD?=
 =?utf-8?B?cmErdktCQ0xCK2xpczFkelp5ZjY5QWJOUm93bkQ3OXN5Y0VqS1R5b2N3Q0sy?=
 =?utf-8?B?YmF1am9pSTlKVFMxNmlHZTlsR3VnZENXUW1zZ3g5REljN3g5Y3NHWGd5dlBY?=
 =?utf-8?B?T0NqZE5HbS9vUG1yUzYvdlNCcFgvVXZjclRmN2RiY3FqWUp6NzZ6dHplN3cz?=
 =?utf-8?B?dlJTc1dqdkxHNkRhckZoVXQ3VWpON09DT1l3NGZIcEZLclR6OWNNV3JvQUE0?=
 =?utf-8?B?clFvL1E1dWpJNFdxRlpOTlA2TW1BMjBXYXFDcnV6WGRyNmxXdFlSR0Q2NXFJ?=
 =?utf-8?B?UTNRcUNNNG5PZHRsRE02OE0ydmZDSUdpa2JVS0JEZkV4bkhKNjBLSzFKNSt3?=
 =?utf-8?B?Zm8xUlpwZkZEU0FWUzV3NkNxSUlJS0VTYnNIZFM2bGd1V09uUW4xQUNTNC9o?=
 =?utf-8?B?Zi9PYnZiZVdSSVFLYkN2R2JPVlU4TUNrMUNNK25lSGRNckE2N0xIV0EzaHFO?=
 =?utf-8?B?R3MvRjZWeTUxbVJlQ0ViZTFpS09sTEZ2aktxTTh5aEdYTUxZNEliOEJMS3NO?=
 =?utf-8?B?dlZveTFLbHpIUmgwUzludUtHTlJJM3FNUjJQZm9Qb1JrZkFZNnhaclZ6Rmg0?=
 =?utf-8?B?OGR3OFBDdTF6eEIxSFIyWitFZWZCTThURUtFNlFrb0dyMFNub2w4aFRRMjM5?=
 =?utf-8?B?M3NwcGZ6NWVFb0hoTEdqSEpVaFA4U3BXUU9RR0lOTGp3V0ZqeVFYV3RaUGJj?=
 =?utf-8?B?TjU5VTE4Mnd2ZHhHVG5ZckZZYzFKRXlJSmdsWkJ1V0E2em9NV2UwNk00U0Fy?=
 =?utf-8?B?T3BmdjlhWmVncTNWN1IxMkNJbnB3U3gxNGNNeDNJNy9rSTF0My80VU5oQjNV?=
 =?utf-8?B?NVpLUTZkVFp3NmQrOVRlS1M3MDFTSzA3ZXRaMmpOTzhrSFIxazRudWQ2Mi9O?=
 =?utf-8?B?QTY4ZnBUOHRUV3E0Z0lPcjdsVDFSWmZmbHVtRnR1ditMZ1V5b1hMVmpvR3J5?=
 =?utf-8?B?ODcrMERGYTlDK3dlUUszQ0Q5aXkrRUJ0ekY0MWVlQnZtS0JuUXIvcm1DUDdT?=
 =?utf-8?B?T3llQWZrMWFZN25nakFZQ3BMQXMrY01Qbk9TcVB4REZuNTJZUWxwNEphd21n?=
 =?utf-8?B?SFNla3o2L29XTmJnT3RZTW52MmVteE9uVEo0bGxJS2VpbHZzV0VvL0NOQzBG?=
 =?utf-8?B?N1h2QmVvanpsZ3RQTGUvSk1wNnd5WHBIS1p6N1VCT0s2U2xMYTZCQysxeUFY?=
 =?utf-8?B?eEZBdWNBb2pmNkN2ZmFwT0pOYVFLbjdZU3lSOENIS0o3SEQwd3NNcWVhUm43?=
 =?utf-8?B?bzc1U05Gems2YXNCVEs0TE9mRzdxMlNzNG5VQ21HUU5mNWRTbkJHNVZCWXlC?=
 =?utf-8?B?VnFqclBpOUl0OFp1Q0xjWFhza29FdXd1T3NPWXZoblY1MTdrMjk1RnlKNzlv?=
 =?utf-8?B?UzJUdE1uRlJVNXhUMGVGbGZCY1FrQjlqY1VxaEhPekdaUW42TmtoVmZObGpv?=
 =?utf-8?B?OU8rQXljVWxucVJRUFpZR2p2WER1ZlIzNGlvaW9xWE5qdUlrNXYzNlViMDRx?=
 =?utf-8?Q?9z1MYfnWBfI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXdlWnJWU1VBNWZFRVNIem91WUVjSVdrTHZXUUNzeEJrbmpZQW1qd2VhbUtT?=
 =?utf-8?B?VVpLR050cEg0NGplcjBLdTRadm1acHF0NjdVUFdEc3VaS3JoSXNkWWc4dzRx?=
 =?utf-8?B?dEtURHE1NnJDNC8rUUdBeDVIUk1iMFltbmtuRGcwZkFJQTIxaDRDTEVWTGdT?=
 =?utf-8?B?bi9oNkt0RkJYRGphNmIwNm5YWHJpR0g2TUIyaElFalJwdURrMTFVNGhwbUlm?=
 =?utf-8?B?b2cySDdmQjBEcnFkdVoxeEorQVRkWGJkWkdoa2RqMTZlUXRCY28vaUhyeWtW?=
 =?utf-8?B?ODJBa3grYnhYazlaVzNEQWZ1T0ZqNUZua0tYMFU4YlRiZVVMdFE0K2VLY3Yv?=
 =?utf-8?B?SUhka3VSM2w3cXBFRDJZN1cxdkF3eU43ajZqVWNSbVdqZnh4Z3hkd3hpbFMv?=
 =?utf-8?B?Z21CN3NsQm5MOW4xZGxIek9QMXI5aGlMQWMzQ1VnaTdsTXluL2RidWFsZEFm?=
 =?utf-8?B?R2YwUFlQU092NmJvYnpaRWlpdUV5RmxtUTJQbjcrNGltcC92djNnM0hMa0lo?=
 =?utf-8?B?aDczNjZHd0k1UGUva05xNGhhMUdSMm1NNXMwYlZLZi93NUNmenJWdEg5SVJk?=
 =?utf-8?B?dmJGUkROSzY3OTB6cGdKVUtIREU5bnNYUWpqQWRVMWx4ZllhVld4c0F1a0xE?=
 =?utf-8?B?MUJEcEdoTWtxUFVxSzgwZHQ5QTVWc0NkU0ZFajNDYXdaQWhMYXVGM2Y4Wndw?=
 =?utf-8?B?U1pDelVoOWtCUW5iTTlqOG44UUpLa3dGd3dIdjZBL3NDNEF1Wmp3V2pzejZk?=
 =?utf-8?B?bmxGM3VHaTJrVSt4NjdXMlNUTTJvZXZGV2gyUStUclJiMG9sRFhJR1cvV2FI?=
 =?utf-8?B?MnRTQ3M1UFlBM2x4ZFIremFOQ0N5K1RPSzRNSzN2ZGJEUmV2cjNaOW9FOUhF?=
 =?utf-8?B?R2V6Z20wR0ZrSmVQUWlRMmJYV0dnZ3FtMnlqVzZtWDJ6K01RNnpSMnNsd2Qw?=
 =?utf-8?B?RjE5Q2JUYUlwRUYzLzdLbHlJVnJSb2ZTeTBKSVFWUGx2UVFVZ0tSZkxRZTlU?=
 =?utf-8?B?RnF2MVVPQlg3UGdFNDlaSWRzZGZJdW4vU0U2N2VtckdGYkIrRjF3K2h2dzc0?=
 =?utf-8?B?U08xMWZDNFB2VXFCWVRWbG9TM1VEQkNBOXBoeG5oSiszWGw0VEd2bk85b1RH?=
 =?utf-8?B?bngzUEpQbXE5N3dSbzdTMjZuOFowNzNkcmxUUEw0ZmtJR2lFWkdkeS9MTnFi?=
 =?utf-8?B?MHAySzNtNnJqV0FiLzVWaU83OU5LUzFnb3RJNVR0WjR6SnVGZVVGaVE1UGNS?=
 =?utf-8?B?dE5TRzdoTDhvWDBCN2EwSVNwNThKRnpjVFdpaFl4TWJqQURnZXZ6VXFrM2s0?=
 =?utf-8?B?MEVnSXpmVnRlNUVYdXVNdVJ1VmsycERRaHRic3dGeVFDN2kreHRqSURIRms4?=
 =?utf-8?B?R2JXOEpoa3R4SmpKb3Q1S2k3UEN6VDI0QmVsdThVNnB2R0k4c0pZalN4Tlpt?=
 =?utf-8?B?RFg4RGxodXQ3UnZCMUJZQnFydUUvaE1DTXRxNzJ2dzlIeDVUNlY5SVcrdWZL?=
 =?utf-8?B?WlBLTzNKV3ZQNDBCUTBlTlBrSjQ4TWxqYWpoeGZibUxDZjJiRlVkbnNyMGF5?=
 =?utf-8?B?ZWI3MU1Oa2dtcjlLT2l4ZVdvS3RUSG4xRjk4ZUh3RGNhMWFlcFVjZ1VYMk5t?=
 =?utf-8?B?UnlTTWxYWmtUa0NZR1h6Z2t2Y1Z5RXN1eWZ0bnlTTkNEaUtWOWRiVmlIUTNX?=
 =?utf-8?B?eFVvdTRGLzVjeEdyaGpQVUNzbkhlUTlRNndObkdSbzNVWFkwcVZkT2IzQUhB?=
 =?utf-8?B?ZUtkTEFQSWljVWh6OWMyZmo3M0dMZittYm8xeFVTRmJ3aGRvZE9HQzNRbi9Q?=
 =?utf-8?B?VmtLaTJLY1NvU3NCT0ZpQm51M3JsNlAycEJFQUoycjBxL0RYcHNhRFJMYTcv?=
 =?utf-8?B?Vi9Eem1XY2RHdkhIRG53aitjNmF2aHhmaFVZaXhleXRaVkN4MHR4T1dlcjVG?=
 =?utf-8?B?NmNuZEQvSlRnVmxQZUlFYklBcnY0Z0FjdWREVFJFaG1Bb25JV3o0VlNBbEx2?=
 =?utf-8?B?WElsSjJsRkJTVVZjZnROU29xMW9tekozTTlHZTNhR1FzVW1sSHhxQjVNT2hI?=
 =?utf-8?B?U0xvd080VzZmR0U4NHZ3VDdEOEtMVmtSUEZqejI1c1ZKdW5PdGhOUW5VbC96?=
 =?utf-8?Q?/vESCiPoTj+lhd+bEQ/VsJiN9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71292ae-d6a7-4deb-6c87-08ddc9b0a86d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 06:17:53.7092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sau+h1OKBN+HFYpmlMi5aWOJwRccDQ6L/lxVc7KZCTjNs1kT3FK9sEttgudl8e+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130

On 22/07/2025 18:03, Paolo Abeni wrote:
> On 7/21/25 8:34 PM, Gal Pressman wrote:
>> On 21/07/2025 18:40, Jakub Kicinski wrote:
>>> On Mon, 21 Jul 2025 14:43:15 +0300 Nimrod Oren wrote:
>>>>> +static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port)
>>>>> +{
>>>>> +	void *data_end = (void *)(long)ctx->data_end;
>>>>> +	void *data = (void *)(long)ctx->data;
>>>>> +	struct udphdr *udph = NULL;
>>>>> +	struct ethhdr *eth = data;
>>>>> +
>>>>> +	if (data + sizeof(*eth) > data_end)
>>>>> +		return NULL;
>>>>> +  
>>>>
>>>> This check assumes that the packet headers reside in the linear part of
>>>> the xdp_buff. However, this assumption does not hold across all drivers.
>>>> For example, in mlx5, the linear part is empty when using multi-buffer
>>>> mode with striding rq configuration. This causes all multi-buffer test
>>>> cases to fail over mlx5.
>>>>
>>>> To ensure correctness across all drivers, all direct accesses to packet
>>>> data should use these safer helper functions instead:
>>>> bpf_xdp_load_bytes() and bpf_xdp_store_bytes().
>>>>
>>>> Related discussion and context can be found here:
>>>> https://github.com/xdp-project/xdp-tools/pull/409
>>>
>>> That's a reasonable way to modify the test. But I'm not sure it's
>>> something that should be blocking merging the patches.
>>> Or for that matter whether it's Mohsin's responsibility to make the
>>> test cater to quirks of mlx5, 
>>
>> Definitely not a quirk, you cannot assume the headers are in the linear
>> part, especially if you're going to put this program as reference in the
>> kernel tree.
>>
>> This issue has nothing to do with mlx5, but a buggy XDP program.
> 
> Note that with the self-tests we have a slightly different premise WRT
> the actual kernel code. We prefer on-boarding tests cases that work for
> some/most of the possible setup vs perfect ones, and eventually improve
> incrementally as needed: the goal is to increase the code coverage _and_
> encourage people to contribute new tests upstream.

The changes required to fix the test are trivial, and Nimrod provided a
reference for the conversion.

