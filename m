Return-Path: <linux-kselftest+bounces-44808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D9C361A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 15:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234AC189F0C0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509A132E15C;
	Wed,  5 Nov 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3nzRNSV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC332E149;
	Wed,  5 Nov 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353584; cv=fail; b=ftdHSWU1p8YxA2wrSvF0mh5nghV3mDeLCYhXqhyrn6IRfI2Wfx72hYNEmbUOvt+Tdq9C9/DL4s7gvzqTquBVpCOcZl0BIb3o2hZSDHZLpocaX8CV9MON27XUu6lpd0sobQvik9rJS9pjbD4VfV0ytP5iPIYJLWGFZbd54xZqBQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353584; c=relaxed/simple;
	bh=P/i5YPoNamqmQnKy0hvjUn/KB2LfytB8FjzON1xqxnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H7H11JmOCMWeqmXpPMFnDovARsY11H+rWpk8AW19QFq1Ie07ZiOnq6pVaoWbfwxMfbn8Wqu1XGABy/C6VEv1EEP7YOTQaDf2qhAW7e4gPzEFtjj1BbScYrqtrdM9ITbLlZBsJE+YJ1t9knoMIlvcgCYe+JQvqdbhtO6i7UN0fBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3nzRNSV; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geBMsKrW1i3kJ5UMZWxfWZvoOzdrdExDRQsWP5lacaqC5iO0ZHgfF1Q4tQIsoO4kkGrnIVmts5H8wOLrZ5d6PBL9qNj6pZVQAfeGmrl7Nfi2WyYAw49MJa3cA9FLM0vv0vXv60dyaAr4xtuMwQ1dmF16K/5jCmDgl+akwOqUal0AdKe5TiJRLGy92/jhRWT3AMDTMLcZPl8n0sX+6aLRopRwuWa29XoAhAf+K2GZhkg32nvRbY0XZLbJajfvNZPKcIPx1YCI99FPT9IA0qBiAUbkhfW7vphjVElwKbajeUDf4O6NEmj+jUBFdL9JV2t+1UZvG0s5c3HoRpbBC462Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhiLMFZgXKANe6Xd8L3JgV7DOglzW/duRUNEzrSuaCs=;
 b=f1hR7IuGmeJl3hzXApPGvLR4LR7TcsZXepm8Ou7HVtODM0lYwVSDc+ZfPJ8gGTrQEmPyN0GHQSXnxyV1YMbld6GdYWf0SRjjAwxUIreP6FTjZjc0re4UHhZc0IbT/o+BAHV3LncTxUVfYXNu2zQyV93orGJRInWSrxSc7uLFezFej68ARvLH+E/savk7EORXQudRirozHffYByYyZHsKnblkUfF70lAkQhrXxExwltnBhMLkuyX4qaBvwT4wSvzXCX0UL1L+bcj5MYAvuRLNvlyTCDHtXpvCDdHfkwZL+n1dupy7Hw3KlvxvLz2ueWRG5nrrQl7uNIXmgDgJRoXEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhiLMFZgXKANe6Xd8L3JgV7DOglzW/duRUNEzrSuaCs=;
 b=q3nzRNSVARg6icV7o06O6ErgJr7u+3Zq0d1PLaNt1uLZ6hs1DTbRZiY4wzIq2r7ns2Cny79di2Q/bGIUabwYcplUcWSyiZt6XLbHySMJe6eOj1gq9Rx+Y/KMnJ8bQPRJFRFMPa1wjI/ZsFjuzmHRFI7jU9wr/DZjKrUMj96sg9o2vKr3ASNWyTyMYZnJwudKGVlKPz7Wb82E0sRY3/JplXefven4a0C6sAUsfUr+HKeR+EavNFOWs/gjKCMa16+4EzcopXy/QNwsF01AlrJ34aZRanIl2uuD2NGMw0qJZxy3zNNMbBhxvXSx6EZ/5uJsqOXTbc6zMkIh/2YCSaKDAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 14:39:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 14:39:37 +0000
Date: Wed, 5 Nov 2025 15:39:29 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v10 sched_ext/for-6.19] Add a deadline server for
 sched_ext tasks
Message-ID: <aQthoTGw0U4o1eHw@gpd4>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <aQtVe9LKuQ_W3qwY@gpd4>
 <20251105135911.GQ4067720@noisy.programming.kicks-ass.net>
 <aQtdQnLxnh7z7a0w@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQtdQnLxnh7z7a0w@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: ZR0P278CA0101.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: c0beb2df-8f82-4941-0a76-08de1c792509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3BmZWc3eXo4TUJKTC9JUkZkbUMzVURRY1REQTZvSENiaHlvYVB1dXc3SlRR?=
 =?utf-8?B?a1V0dGlvcmNlT2tBcllQclNQU1p3K0hEUTg5TUNhMWJTN21UbU5yOG9UYndM?=
 =?utf-8?B?bUNRelVaaEVscDBOcnBhZmM5a0dVaWlzZTZhSjlMV0JhTmNMRkRGbWdlaWxC?=
 =?utf-8?B?WmI0dDdLcXFEc2JjMyswL0RSQmVhVCtBVEFac0laQURZNXhaNTJMdndubjBp?=
 =?utf-8?B?ckJzcmFjLzNkYTY0VkZoa2dPaER2Ulk2c20yalZBa2dUbXdhY3ArVUFoNHhY?=
 =?utf-8?B?WnhUWjNrdzZNMGVmdCtZQWtwREVuMmk4SWZSdUk5Y3Rncm4va3lFMDZxNVNR?=
 =?utf-8?B?elIrSmM4MFY2UThxcS9oTW5DRVNJSTZhYkNiZGZ3UDdRSWx5VDFGV0tERWIy?=
 =?utf-8?B?a0ozNkcremNVOVp1U0xzZFNxRlZtRnZoYVY0RVdzL2JZL1pIN25uUzFIUHZm?=
 =?utf-8?B?aU15SWVhdE02d0xNcDB2dmJOVE9wZktscjhrSUVIQ1AyT2xkV0xxQi9jR0lQ?=
 =?utf-8?B?aUZ1czJRbzU0ZWUzZ0R1OEpBejhWNDdXYUlTOFRDcHNINVJVZjdVVUtjdzY2?=
 =?utf-8?B?cVhRZTkxbG1DUUo0Y3ZkUTJET1hDQ0ZJM3loS0FqL1dRbXZkVXlYaGJEVm5Q?=
 =?utf-8?B?eUpaUk9nVG5HdFVGT3JqQXMvc3dpL2RLOEU0MUUxZWIzUjl3T0lrMngvYzI3?=
 =?utf-8?B?M01LNExWL2lTU1JRS0M2dGY4dFdmN2F2N3hqQU4wSjQ2ZEVWL21ZeDQxVUdW?=
 =?utf-8?B?VitMY3VzbUV1QW93b044R0FPMldDb1ZGZ0ozdEdteEVlQkNBczRXbjNOYmh0?=
 =?utf-8?B?TFBmQmNoVS9wZU5jZmRQcTBZWk83OEpqNlVjVnB1eW5nckF6VHNlQVB5L2o5?=
 =?utf-8?B?SjREMDlYUFdmdytNVmRTcU5SQU81Y0d3RkxaZG9iclgrRDhsWVBGM1YzMHRn?=
 =?utf-8?B?YXEvMzNVQzkvS0lZVDlYem5xMHMrWlF5eis2OUs5dG0rNFZUZ0tEWlRXNlJI?=
 =?utf-8?B?clQ3TnZNVy80bjA3RE1CM0NPUlNLd2t5NU1ZNDJmUEt1dHZ4cUxTcVd4VEFU?=
 =?utf-8?B?aHlXZmtOc05RTnV6em1OQUVwZFhWemttelR5TVVudnlsNDQyNEE3QVI2Y0Ew?=
 =?utf-8?B?aThTdGJRZW0vdExVOXUxREprRkIwYjJ6T21nVUp3UHZqYUdld3ZUZlkxRzVJ?=
 =?utf-8?B?eENlWWJpVENERmszMmFNemVtL0xUZkhjOVhiVGpZeERFMWdINGNwUnY1bHF0?=
 =?utf-8?B?NkJWQnUzQlpZOXVGQUJnRXA4a1V4cUNOQ2xWcDNvOWRBSWg0cS8yOHU3a0tF?=
 =?utf-8?B?M3RqdXBadmx3UWdOczQ1N2Y1Yk5rdjFEM3ZURkJKN2FsN3dwOU1GMjMzUzNI?=
 =?utf-8?B?VFd3VVZxMFowcEtmajdMM2pDZXU5bG5abXJEYlJGZDZJWHJ2RHBjSVBjTWpY?=
 =?utf-8?B?VGdiT2YzQ1hibHBVZFVSSHhyQmdzdnJweFBtU2t5QW5jZ1MzUmRueGg0R1Ns?=
 =?utf-8?B?S05icGt2ZEkxZ2Rrc1pKUmp2WXYzOGpMbVJWRzFqZldkd2p4elJFblRnRENj?=
 =?utf-8?B?OHoxTGx6UEd2ZzkvZVFWTFFubW9odWdCMStVeUpKb2tvUlRkYVdNU0RSQnJ0?=
 =?utf-8?B?NFA5ZXBaVmxrQjgyODJTbEhRM2dGTEhmL3lnTFgrRmtKTHdvaFBTdmpscnhT?=
 =?utf-8?B?N096Vmk0VUVsRi9Eb3Q1VHdFbjViek9kbGhTcVBjajNabDNmTmpCc096d3g4?=
 =?utf-8?B?dmZFa0hRZmpIUWZQY0pVMmxiM1Frb0pzMzhVWW1yK3h0TzBKejdKUFIvU0h3?=
 =?utf-8?B?cDFIVjNUUTY1Z1FZcnl5b3BkMkFMRmYxR1lRZ3NLK2FyM24raklIMll6L25X?=
 =?utf-8?B?RHFaYTBTOXRrUFVJUmNlN0VvcHMwSFNOQmJSanFFa3BRclAvcW5NNUFrc1R3?=
 =?utf-8?Q?SZXhI6uKluIMo95ZZkbxZNaBXTqOC3Ks?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wi8xeGxHem1NcUJzcGRnbHdwTGxXT2dUYTFYaXdIbFRsKzFOdmtKd0kyRmhn?=
 =?utf-8?B?b3puU3NQM1lsNHI4YXBPZmFMcjFQOGx5SFZzT0ZoeG9WM1RYM1lOYVhYT0JB?=
 =?utf-8?B?OGhpeU5QM2svekk3SVIxYUNyS1VPWTJPZkZRWmt0a0x3bi8rTGthZjZZRG9E?=
 =?utf-8?B?MkFJTWRQYzM0c0ZsZ09HY0xwZWZucEdMNDRBSy9YNUl4ZFJVenJXYXRtWWo4?=
 =?utf-8?B?Z2lVaU9BT1NyRVBmOFR0SWFBNTRkeTNoUlFHbUFmb0pUUWxDZWhhSUxTVG1U?=
 =?utf-8?B?Nk5zdkpSUEw3VjJQYlN4bGpCbDB6MzN2YkJ4aDIrUkdFRU5TNENDS3EzMVRp?=
 =?utf-8?B?eFpoRUlXb1JkOWNSc3l5SnRhM3lOb25LQnpwOEkybkFqYVRKV3Rsdm9BbUV4?=
 =?utf-8?B?YkRZY0o5QTE3a1hESnFBS2I2bTZ3a0s2WWI1eGtmWk9IT0tCVmszVm9adDVn?=
 =?utf-8?B?WmNWOGpGc1BreEJyR0daVWZHNDRNSFQyVzhtNW9kY3dsYkUzM01xblplVUNy?=
 =?utf-8?B?VHFQaHRva1VqRmxHOGVXcms2SHpMTW85a29UMWhJZUE3L1ZIOTBVeUZuRDVQ?=
 =?utf-8?B?cFB5QVc5a3pFMnI3UGxVN29ZSlVzUUlEVC9RbDUySDRyY0tDdDBzNHZ0WnhD?=
 =?utf-8?B?NzZFR0RXZ0k2UEFzQ3ZpblZmLzlENWU0THdvbTR4RVFIdFMreG9ETy8raW4z?=
 =?utf-8?B?RG1oS1FBWlVESjF0UXZkK1lhdElES0xnZjZjME5ZZGZaKy9iTVE1Y0VDc0NZ?=
 =?utf-8?B?K2xoRjVtSDRSRy9ORVZjRkJ3UDVjU3lrcDg1eEswTTR0dmQ2OEhaK2lyQkVN?=
 =?utf-8?B?anA3R1dOWGs5cFJ5aDJYaWJBamRSc25mWjlsZmlwVVN5OGg0QUpLL0M0QzRI?=
 =?utf-8?B?aC9kZkdCUGkzNHJzOXdVQkxCamhweWZlWU0xWVF3OEJFYTk4dmJMUjhIUWkz?=
 =?utf-8?B?MWhYc1ZlOWs2dTMvNTdFUnVPQjlYaE5IZUUwekVNODFFdHJ4QTFHaGN2R0Rv?=
 =?utf-8?B?NVpJUjdCblU3ZjdnWi9oYmRNNFp6dUEwOTZnaEVvVlVDbEgybmh2eWFRVnZZ?=
 =?utf-8?B?TTVucldGaTljbGh5bnJwYUNVK3dRditlY2xuczlNcHJSZldTSjg2Slo4bkxz?=
 =?utf-8?B?akVnVzZSa1VCVzJnaGl1UHY0dzdFOU9LU0Qvejd6UE91d0FqQkh2VVJuVnNh?=
 =?utf-8?B?eWxPM1NQT1l5OXVaek1mc3ZyS0laSHNxUHJaYXlDa1YxVkxpRTAwNkNsTG5r?=
 =?utf-8?B?bUdpRVBrRG13YldPL0dGWlBzTmFmZUlBQkxUK2V0V0hPSTVybG5LbkJxajk4?=
 =?utf-8?B?MnVGSVlpRHFydVNHeUFxUDhFMEh1VUtFMDhrUWZieUNXaTVwNVJRK25BakN2?=
 =?utf-8?B?ZFdEWXJ3QUNXN0RKVHVxRHVvNnVibWFUSWZLS1FWNko4VUp2L1AvRVlRQkxj?=
 =?utf-8?B?OE81RW9XSUkwK0JzZkNrcXVqTWVJMVdwRUZReUFQRDdRYm9kTis2L0FRQzVq?=
 =?utf-8?B?Ulo5UE82dzZZTHowQlA5bis1U2tmZTdhVDdkUVZGSGRJc3pnRVBvOWQzSXdJ?=
 =?utf-8?B?ek9qSHh4MGxSeFhGdTR5MDIzRFhwU2xKRFZOTWxuVnVlWWZIdzJURlZwU2o5?=
 =?utf-8?B?UHZ6Slh1OHFVc2lWL1BSVmYwMmNTQnJnR3NHdTh6MFE1UHNTMnZPc04zSUY1?=
 =?utf-8?B?VmZWV1lOMDg4QU5sTnZMRTVRdmZ4Q1JLTk1CTFhZVWt5Y3VneS9ITzc4MUl4?=
 =?utf-8?B?bHdQOUFISjJucExaQ3haSW5UdjFjWUpIbW9MYXNsaWErS2xzaDhJbG1CQVNj?=
 =?utf-8?B?bEIxd2lMR3RTd1ptRktqenRNdDhuLzc4NTl5QVpuQSt1RnhZRXZMMjBmVm45?=
 =?utf-8?B?RUJxYjJDNVphQjB5NjhoR1NYY2Jnc2NaanBSUnRJUms1Y2p3SENaNGFuUnRl?=
 =?utf-8?B?eVhLM0dSZHhLckRzdWdIWVMxdXM2aTdPbzZPUzFkZ2Y4QmNNWUVzcjVCSFZZ?=
 =?utf-8?B?bEVZQ2ZVTTJBamd2Yk9XZUdUb3NTOHVRc01tdmFsSFpVSEdrUjhicHd1RXVk?=
 =?utf-8?B?dysyMFN4bGcySndoelhFL0h6ZHk3T21pVzBZNTJFblVIVUlxQ2w3T0Q5VG5H?=
 =?utf-8?Q?fNjxWbGu+MUmISGa5Jl5sOai0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0beb2df-8f82-4941-0a76-08de1c792509
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:39:37.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJCNB/Mzv27xhAZgrMaXwN67/nCf5KgZ9TyCr6TUeohfxKjzdWkJvdFj99+BhAxddCSAr14UKU4WeDD0FcGeEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314

On Wed, Nov 05, 2025 at 03:20:50PM +0100, Juri Lelli wrote:
> On 05/11/25 14:59, Peter Zijlstra wrote:
> > On Wed, Nov 05, 2025 at 02:47:39PM +0100, Andrea Righi wrote:
> > > On Wed, Oct 29, 2025 at 08:08:37PM +0100, Andrea Righi wrote:
> > > > sched_ext tasks can be starved by long-running RT tasks, especially since
> > > > RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
> > > > tasks.
> > > > 
> > > > Several users in the community have reported issues with RT stalling
> > > > sched_ext tasks. This is fairly common on distributions or environments
> > > > where applications like video compositors, audio services, etc. run as RT
> > > > tasks by default.
> > > > 
> > > > Example trace (showing a per-CPU kthread stalled due to the sway Wayland
> > > > compositor running as an RT task):
> > > > 
> > > >  runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
> > > >  ...
> > > >  CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
> > > >            curr=sway[994] class=rt_sched_class
> > > >    R kworker/0:0[106377] -5043ms
> > > >        scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
> > > >        sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
> > > >        cpus=01
> > > > 
> > > > This is often perceived as a bug in the BPF schedulers, but in reality
> > > > schedulers can't do much: RT tasks run outside their control and can
> > > > potentially consume 100% of the CPU bandwidth.
> > > > 
> > > > Fix this by adding a sched_ext deadline server, so that sched_ext tasks are
> > > > also boosted and do not suffer starvation.
> > > > 
> > > > Two kselftests are also provided to verify the starvation fixes and
> > > > bandwidth allocation is correct.
> > > 
> > > Peter, Juri, this has now been tested quite extensively on our side and
> > > we're considering applying these patches to Tejun's sched_ext branch.
> > > 
> > > Do you have any objections or concerns?
> > 
> > Yeah, I want to finish this first:
> > 
> >   https://lkml.kernel.org/r/20251101000057.GA2184199@noisy.programming.kicks-ass.net
> > 
> > Because as is, the whole dl_server stuff isn't quite right.
> > 
> 
> And I'm spending time on "[PATCH 04/11] sched/deadline: Add support to
> initialize and remove dl_server bandwidth" which I am still not 100%
> sure is correct (or that is correct how we handle setting runtime to 0
> for fair_server today). Apologies, had some travelling and pto, but
> should be able to write something more about it in the next few days.

No problem and no rush, I just wanted to follow up to make sure I didn't
miss anything. :)

Thank you both,
–Andrea

