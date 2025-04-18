Return-Path: <linux-kselftest+bounces-31189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E43A93FDD
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 00:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 489427AD761
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 22:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3224C664;
	Fri, 18 Apr 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lQ4wrbfb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157D0245033;
	Fri, 18 Apr 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745015376; cv=fail; b=lNEYA6s0AQZaY/xMjQ3E/+Q/nvEBrexCRSlTcgJjgmw0kzUCZKyYrGOhGmaJBJb2rpxAr7Kb87Wgs9kn8kcIhamc2MnJYY6rwxdWuqTRjwlDWcdtE4xWmHjWwOvfgMdJrYmHbkZ0brYMd3ZD0fDnhRpoM60UdIRBkjU4W4LzKXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745015376; c=relaxed/simple;
	bh=hasNDgrTADl9v/TWMI5zSpCpZiD2DXhNSForHF2DZoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KrRXdGqhID2wcEGH8ZYs5bONUUBS7WYDNO1DfeqGzCtjKkFNJfr7CuawpreNQCaUOcTuZC7SnuqHB9wcCcw/dU1Nob4AYMh2TZDHgcrjbxn2smJzM8lD5Y49fqYo3XbUJhgE8DT51xyKSxx0eSfVJwmfb4sm+EeIkvz7ZMRGLE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lQ4wrbfb; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC7+b0PaJh0+aC3PY4VSgezBZ9u5sdJeJyBLtqQoqudutjrMHcqeLMf2cH2ew5bzV/dPI0RYKl8SVoYBADGI8LQF1qruvlZaO3UPiI3v81taCJlxDx0c5iQwA4S8VvLiOCGEIX96UZJgm0BWTtMrZ5T363EHq2LpBsGfQeZxRfHCAnfH74kfFVlZ0X3AWh09i3Pw5SRAfxB5gR2GOtT7HR47dk+GEfmiPti1jRcjlmDk9FkDUB7JHLE511G2f7gcKfeDcobFYTqCQNBGSl+BFnEjaa8iXhVSjAGObxuei8MANLca23N7lxxNgBSHgxkxBayehw8owT/h9Z3RNbY+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N+e6D+zMDPmbZ/gbgWivtsGdIDtDT2SHPgwABl2lQ8=;
 b=KAvOQAeNCNki1FvborXxjWNVqsD1COiS4qxzZmy+Z7lVqfzD6ET93l3QvuYErXRNNJzwI9W6K82LvTMUgtlleB4pL4lGxpf7bwxrYEinX1zGSCJNRA4zn4MZVGiEpslZ7eGhy7x/O7xJzn0geQxS+HSR8s+WpVCxmNilOKXROnvPPdZJUB4TQ7emQG1vuK9Jv97YdIgYa/PhEZoNeVKDkfb6LIkGtQkKTxpEXj6jX9dplxv1bGsmaA7NfBp9XV72/fyMBitIeMF+FSsj7E87mnsi/qw26quUhsOANyomjawrEQ3evZkldyQVysKs1dktoXmEZkCw0sTx29+ChPYbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N+e6D+zMDPmbZ/gbgWivtsGdIDtDT2SHPgwABl2lQ8=;
 b=lQ4wrbfb3uI+HKxLT6BpMYBT5yn7Qrr+P+18dbVmaPXeZGCRSYRG3VvsppjD8UMC/DskbmZ3gS6yPTaIyCseQrxqOz8PC0GVY/ixIzPxbxfV4IkWyCIALjSFop6EuP2YyyuIp2u/7VY14mfwO2wVoLBuUapMkJ/KrkUYs1NuAKhqwq+uSeXl9JZKntj0gvnRT7e5UUdkc5ySBYstHngFybM0lukZXN5Y1sSc+JGAeLnICdr07sGFvOwpVfxYJ3yjq6P0Cv3lIn2ZQRUifXGu8NjKTtI5uG0+phAxh1/WTYVUvJaiUHVjruS30Z+1tcZ7iGBWqafZUI7Kzjl1amBBRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 22:29:22 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 22:29:22 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?iso-8859-1?q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, rcu <rcu@vger.kernel.org>, linux-kselftest <linux-kselftest@vger.kernel.org>, rust-for-linux <rust-for-linux@vger.
 kernel.org>, llvm <llvm@lists.linux.dev>
Subject: Re: [12/14] torture: Add testing of RCU's Rust bindings to torture.sh
Date: Fri, 18 Apr 2025 22:29:19 -0000
Message-ID: <174501535978.2294.1456464669618929038@patchwork.local>
In-Reply-To: <cbf1a147-0a24-4146-98a0-a9666bb60433@paulmck-laptop>
References: <cbf1a147-0a24-4146-98a0-a9666bb60433@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BL0PR01CA0007.prod.exchangelabs.com (2603:10b6:208:71::20)
 To SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0d201b-2920-428b-ebdd-08dd7ec877a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1pMUkJKQ01McmFpcWkxUU5vUmdvek5HNVZIR0lzR0lxazYxQnZrWnlVOExi?=
 =?utf-8?B?YmZGanluZUo3clFWditMYklGTVl2cXpiV1Flb2QrZFBlVkhqUFViRWx6ZE8z?=
 =?utf-8?B?eXU2ZEg0UHpiamsvcWI0M0FRaG8xcVRyNVJFTzhqeUoycUxOdTByTHlNdGZY?=
 =?utf-8?B?a25wRXJTcHg5STNkclB1RHd6VkNybzBockQvQ01oRTB4b1Z3RndVWXM2bm1H?=
 =?utf-8?B?MU8zbGt4YkVxYXYrUjhIdDNrRFdFUnhZcGt3VU5hT2RBcElMSWN4MjI2eGRN?=
 =?utf-8?B?dUtLT09CZU90SUFlcnc2dW5LdGV3Ukd3Mm9lTGNWM1pQNVkzMmtzMVZsOGlo?=
 =?utf-8?B?WTBQZ2p2ZFh1NldqVEg4MzNncGs3d3ZPbmZqMkM4VXMwdlJKUmROdlp0QkJV?=
 =?utf-8?B?cWhVd0tod0VvVmNmdit1eWJBT3JhM0xkYkFIZGFPZ0RyN0N6V1hNQ2ZodGND?=
 =?utf-8?B?QTd4RjJwRzNGakNnVDY3R3hVclY4OUlrZ3AvT1JhRk1BSUVYM2x0a3hoblR4?=
 =?utf-8?B?QndPazJBeG11dzBZQjFTODVzRUMzc1B1WFBrSnJzOXc0K2EreXE2U1g5dmJa?=
 =?utf-8?B?SzJUTEhrUS84b21ueEU0b3VpTXh3OC9uTTN2MnVxMTJLejFOWFBzc0pkelVU?=
 =?utf-8?B?d01qYisxU09nL0tHRlZLR1UvRDdhMkVEYTNiQ25ZK2pmWExmLzhMc0RlQTEw?=
 =?utf-8?B?KytFUit6QXQwUW1CVzhNeXpKYW5tdzV2ZnhVaUhlcmxzS3g2L0tXaXVmM0Y1?=
 =?utf-8?B?dEFMNld0MDAxYzJ4VEtIYlJpNkpWNXNjUHp3SS9CRERwUzJ0RlFNTVNqQVNr?=
 =?utf-8?B?aG9WLzVpRDNEWUNjYlNDTHZXb1k2NW5rTERna0dUWW5LNklNK0VEeU83d1NQ?=
 =?utf-8?B?cGg1VXJIM1pxOFNnL0JDTXJXUm1ISkswQk5iZHpDYUNMaHl4eFppaTZFcXNG?=
 =?utf-8?B?ZXV6aHcvQWJqakpZMld4a2RINTUwZGlBZUQvcGF4SGFjZDNsaGpzM25sZVFk?=
 =?utf-8?B?eE1NL0UzVUtETm8xVFVRTWc5eFRqbjdOVmRXWEtSK3pUS1gzL0ZlWVVOd2l1?=
 =?utf-8?B?bE5pRkMxTmtHNDJ2VWR5VmYveFJCNXY4Mncxa3dkTzc1WkVxY0oyVUU5QTg1?=
 =?utf-8?B?WVR1U0ZXVUhKbXVlbUIvd0c2cWVOSDl4MG0remIyY1JhZ2hKNE5NMm1FdXM0?=
 =?utf-8?B?VWpSVytua0l3cXdOSTArNkYxLzhtQ1NGK1RxaUVkaCt3aEV2cHRUam1UWWRm?=
 =?utf-8?B?N1hZb0FaK0JEUTFYdGtYRDdxTU1meFNOQWxJbnJQOUxxdUNwSE52dU1iMkV6?=
 =?utf-8?B?THFMN1N3enZrbnhTYzhPRittZjFaQjVVd0NQNDF0RVhycXhEYXBMVW4zUFRD?=
 =?utf-8?B?Nk80TGZ1Q2IrMm5aWWV5L2FGV1c1bkY2c3lodEROZWU0aXpFdTdYUWc1UXlM?=
 =?utf-8?B?V3BUaUVyOTcrcTBKZnh5TFpxakFITEF6c1lvSndVd3BSMW1wdk1oeDNiNHor?=
 =?utf-8?B?bkxvemNzL2trOEEyTmpxYktmaUZzaGRzNEdVdDREMlQvYUdqdkNZY3lHOGh0?=
 =?utf-8?B?VHg2ZjVlYmdBWkZOWk43bzUvVzFEYlJ3N1EvSjZFenlsQjdZMFdxcE5VNnF1?=
 =?utf-8?B?d3VPQ3YrTWllWGFvOXEwUEkzTVVIY3QzSGtzTFBmek5zY2tjdFNBK0s4R1ZU?=
 =?utf-8?B?WlJlRG16U0MzMmpZdFhjZGJzRk1CVGJ0dkdwZUxFNDJmQ2xJZ2VEaTM2RUll?=
 =?utf-8?B?em9USjBiL3BVRUdIWWZqNWxsRTBLdE9rYUdBN2M0N2VjSm5oMkl4SkwzKytI?=
 =?utf-8?B?YTZCemU0T2Ezd0dxYXdQUW9nV2pMajJMQWlqeURCc0NWd3NBMGNFOW5oQVVD?=
 =?utf-8?B?QnpQQXVhSWhaOXBMT2FvekNhZThoeVVTU1pYMm8wRFRCTmJ3Q284dFRnTzQy?=
 =?utf-8?Q?9Dj+nYFU2v0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1RJQnZNN1ZvQlJNZUFtYi85UllsSmltY3oxaHJIUm5tajBDZFp0eG5Tdmxi?=
 =?utf-8?B?ZmFoZ2RZU0xDTjRvallwS0syUnVqTkxnaDhpZzNqeXRkNjEvNnRTSTJRaXlv?=
 =?utf-8?B?a2Z4UExHS3lydVNqdk40UmxON3dydVBTRzhxNEZqRXpKdXVUbXVZQVprbi9E?=
 =?utf-8?B?UTh2SzdycmU1VldxSWs2UzJxRmZXTk42S0xPQUI2Z1JRcEtEdzZ4eWsvUHRz?=
 =?utf-8?B?R2RISG5wRVU2QTRocUs2SGxCWXpwVDlPZlg2ZGpEcG10eFRCNkRpWVVUay9h?=
 =?utf-8?B?QjAreHBZMHNsM1hEWUdTRzNNUzRPaTY0U3lCNElIN0xCUG9HelgxQWVWSXI2?=
 =?utf-8?B?YnIrSXJsVENVdEJkQ2Uzb3QwVlhFMVNURG1rT3BhT0VYOHRmMUtma2ZseTJ4?=
 =?utf-8?B?UWsyYkZIZ2orUmNPS1FOSUtkeXBIbytPUXZqekc4ZnVDSHZqY08ya295R2NR?=
 =?utf-8?B?SlNyUEh2dFFJblNvcFozUXUwTm1TTXYyaEEzTmJ2ZS8vRTd3eVBXMnM3Slkv?=
 =?utf-8?B?cXhCV0JHL0krbjVHbGRPVGhLZUx5V1dFd0l1blVxbHg5c0NJUHpWeEdZZG5k?=
 =?utf-8?B?MTlHVXIwSzhHT1kzS3VFYTlJajVNSnFRbXlocHVHRXdxWmZTL3ZmVHlDeDlw?=
 =?utf-8?B?UFc4L2NYZi8zb2ZvRy8wdGIrbWxsWXdMUHV5OWZyYmo1ZkNpN2ZFWXo5QjND?=
 =?utf-8?B?NVkzOHFHZG5JbE9OSnpPYmRVOEZHMHJ0dlRjS21iVTZDMXdMSHFMS0tPZ0lP?=
 =?utf-8?B?clMvZURKUFM0bjBQUDdrVGc3N0VOdkZDWHF6QURyY1lUaWw4Q1NlOGd3YjVo?=
 =?utf-8?B?OHVjQXFTY3RiditTRVUrMHdiUkx0SUtQNnFlZ0x6NTZtc1F2c2ZMdGtLSFJV?=
 =?utf-8?B?MEJmOERNQVplbEVsclpMZU9RS3Y4N1NOUW0xaTRvdjBHazVtMkxGWGxzQkE2?=
 =?utf-8?B?ZUZiSjdqK1JmUzdZVUNzRDlPNmttU1dBSDgrU2FqTU5JWnVta0pRV0hmMnRs?=
 =?utf-8?B?MWZtZ1VsMTllNmptRzh4QUZGUHAxQ2VoQk1HREZueWMwK0RSWUUvV3BFNlNh?=
 =?utf-8?B?RUd6RWlKcy8vbEgvaU1GK1ZENHRrLzZ3VTliN3hDcVJkemhFbHErYnU2eDA5?=
 =?utf-8?B?T0dldzJXZDZhdU81c3h2UkRKQVJJZDVJYTdnc3N2VTlkL2FxMXV5YlVhdDM1?=
 =?utf-8?B?SXJFdHJwYUNnOWNPYXNMWHIvY3lXYkF5M21KektiWGVWQUJLVmJpQk5WSzhO?=
 =?utf-8?B?N1VlQmJ3NWpMamZCRHNyQ3ZWSW8wUU9xb2tzekZreW5nOUN6TW9WUy9rd0po?=
 =?utf-8?B?MU5jRWQxQ2FnSXkxMGNKejJaZ2FFdXNZamJmMWhya0hvMXc3VU9ZcHRDcCth?=
 =?utf-8?B?bWR5Y3ZyOVg1bFl6bTVuLzJxWVV2ZGVPK3Zhd1RIV2JUVXRkbVVOQnpMQWZn?=
 =?utf-8?B?YnhjbjBwWXZFcDRoT1JqSllpWkMwMldsb3F4U2hhODUxNnNTbmU3Q2RzOGdM?=
 =?utf-8?B?WTJYV1VRL215aEVEbFJsZnB6Y2h6N2srUUlGSDFIL1J6ck16a1lySDRDN1lh?=
 =?utf-8?B?alpJOUdVWFFsRjgvTWlyUDFIdXZnaWJQcFNUNjFFNEcwSDFCQXIzeEEvSmFH?=
 =?utf-8?B?alkrVWxjRm9TaWNUb0JKZ24zMEtIUGUxN0EyWnU2NnAvbW9QTVhWNVpHY1ND?=
 =?utf-8?B?ellaT0xWdmRhZEU0ZFp1UjBGNjhsNFgyZ1Q0dGhscmc2MkRWcHlqakM1WXdD?=
 =?utf-8?B?TDlmWTNTZnY2a3ZsdEM0NGMzd3E1QmQwWVZ0V0ZEVFIveWgyUFZ4TW5YbHpq?=
 =?utf-8?B?dGJ4TkNtaTM5NG11Q1lSbTNqWVY0S2NHbzF0WTd2elRkMFpVK1I0eVlPOUxU?=
 =?utf-8?B?VnZXYUtmMlR5dHlTcEJydmJyNndPNnF0YkY1L0FXTHBiZ0NNSVNacGhKUVI2?=
 =?utf-8?B?Qko3OUdkY2RCb2hXZjJNd2xlR25yREhYbGpzdXI0Qi81WEh4cStMbUZFVTNo?=
 =?utf-8?B?eWhyS0hEWjBOODhtV0ZyRC9WV1k2OW1vcDNsZFhPUEdtZmpnSFJpOTBIbFJG?=
 =?utf-8?B?M3piUHpSMkRLTHo2bWNHeENiemJmTHRxK01oR0VXdEpiaHI0cm9US01ESk9q?=
 =?utf-8?Q?AQuk7ETrtVYDgTej9XOWzVb7D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0d201b-2920-428b-ebdd-08dd7ec877a6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 22:29:22.4593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HS/Xq95Lw0NceJUKySe00KI/p/IW4uDxmIcPvMJRP1CEW6NNbo3bhzVk+HNwFCKkduhj2dA4bioNVB2QGUUy+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839

Hello, Paul,

On Fri, 18 Apr 2025 22:26:17 GMT, "Paul E. McKenney" wrote:
> On Fri, Apr 18, 2025 at 08:32:46PM +0200, Miguel Ojeda wrote:
> > On Fri, Apr 18, 2025 at 8:04 PM Paul E. McKenney <paulmck@kernel.org> wrot
> e:
> > >
> > > Suppose we fired up a guest OS and captured the console output.  Is ther
> e
> > > a way to make that guest OS shut down automatically at the end of the
> > > test and to extract the test results?
> > 
> > Ah, sorry, I thought you were already doing something like that, i.e.
> > that perhaps you could reuse some kernel build you already had and
> > avoiding a full rebuild/mrproper. The KUnit Python script uses QEMU
> > and parses the results; e.g. you could look for the results lines
> > like:
> > 
> >     # Totals: pass:133 fail:0 skip:0 total:133
> >     ok 2 rust_doctests_kernel
> 
> Alternatively, I could clone a copy of the current archive into a
> temporary directory, "make mrproper" there, run kunit normally, then
> clean up the temporary directory.  Extra storage, but quite a bit
> more robust and user-friendly.
> 

Just to be on the same page, is the concern about the
slowness of mrproper or that it kills the kernel build
artifacts requiring a clean build?

What kind of improvement are we looking for and why would
this patch in its current form not work?

thanks,

- Joel


> Other thoughts?
> 
> 							Thanx, Paul

