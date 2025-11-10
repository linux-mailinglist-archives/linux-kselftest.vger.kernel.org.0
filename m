Return-Path: <linux-kselftest+bounces-45252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFF4C49262
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 20:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8D464E1572
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601A032E13A;
	Mon, 10 Nov 2025 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n7GHfRY4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50BB2D8DB1;
	Mon, 10 Nov 2025 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804538; cv=fail; b=DdoHkCkgLxgTv/MCUKeubCjc+a+/6pgpijl0nMUXFANdM92f3XlWXGxOM0htgw3CvOxvTOBbCO1rV+Xc3LW7L5835UqrDyMIUFSMsMBXg1i/CD+3Z1t9FnwPaZC7MqI9MwfqLmjjbbcgSuoEFVkeKZqcde20RNgzYLBuv0QhG4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804538; c=relaxed/simple;
	bh=aXcPa5J2Ebiol0Z651bmJzJQPCuFm00CEQwaNsev9aA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mIqeWIx1V9ResdkdYllMJV3xNtBbR0kuQzSwkiKUEXFMR/nLf9yV1hw6poWeG9PFy0gDc40+2uvuQdy24r73R3vbDgWIL9P9ZBTKE+NDo4dFWgqzHRZ3aANcdoDD3RGE4TFbx0kCuKwC61Uyky0d5X0yFTQw7NFdORHEG8Rq0UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n7GHfRY4; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJZhzE5iQzWzvgl79zOzJ0mB3gCh3gaqJlKG208NnpRSxsHE1aG0dl9ahoN//jzbdnLlziqq1FLmN6y5B2Lhxmvv1XIDY3dDtfrQ3fyVzzFIO6vR+cTWcH3WFGMJ4BwGUDC8iwB9RtsWnBa+DSLNBy52/jYHW3VYeyUe4J4VGwn1kEOD8Ja00VPdLbsO9fCU1/dUruhXggPVWxb+etEmteOTCAl9hO9peiyFc4l1w7VluEe9RtQO/LqyH0ypSa4L06lfRLX+KXAAqpTcbDXRR9OR2A4KihPJm/5ZXDjv0B/mwpYV4mX8VxIX0H2/ww1a7pZ8uwYmI0JcR5ZdTrCafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loE5dcmFrN4gtqQapf7OAsqqqEY07+efdywdZyFrPg4=;
 b=WCi6dgxI67/eNlJnYYVzWhHtnvljOzVsbvvMCVmLJW7kKk/xYgsO7A8Jtu7mRSyixc7NFWe8T4oyFhq281dr5tnSPkKDikvcd/6HBqsTCKSkVB90NtBLPFlHoZL1lUaNXaAYrND0IAIr78Cg+5BhC4bEtu0vR61GSUdspIVHGE59sAOmu5oLGLZiXqdEfrskAmY5L2xdKfROM7jq72os7qke0ydjsELmfki7nTHw/nRYRcaqKhCgsJmIepLUjWJep8O/LMLFdSil9eEWhbIreO7FJpOAb/WsQfs3swsktN5l0/9qF22jcTDezRpc78txYvhhMq+sa0Cbyp2FOZNdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loE5dcmFrN4gtqQapf7OAsqqqEY07+efdywdZyFrPg4=;
 b=n7GHfRY4xAslc43jzgkJ+bm8pf8Ao7947K+o48oWQ6AksLekeE0TEKH0kLueyF+vfHNtnyQPO6w9HGozdoW/uv9XKBC0Se3PFJ7Dtj2io90u//QwcGG6WmOiPcclMo3/ytxNuc69BQ0y/dhDKkBMGSVCbHtCMc0EMA5Dd/x/7xCKfsWyneJVkV19/HbVotXpehgBjsQahzJYwVt+s1mpz1Bh7z2LgfOgYzOLOPIzIiZgLwvvsenuQAhTnSYsaGUDfclouaaeQnKtyKt9EH9BqaXVhBvi11bLdM1VcmyZUpxisxwDXPP/Bk9RyyZUm6rsP0Ij6qYu4gGOFL2XPq52cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 19:55:33 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 19:55:33 +0000
Message-ID: <5c0f7b5f-ae57-4a9e-9aa2-9628a7bc6a2c@nvidia.com>
Date: Mon, 10 Nov 2025 11:55:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: allow `unreachable_pub` for doctests
To: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20251110113528.1658238-1-ojeda@kernel.org>
 <aRHSLChi5HYXW4-9@google.com> <20251110133843.37ff0749@eugeo>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20251110133843.37ff0749@eugeo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8b0857-8390-43cf-3d73-08de20931bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUVDb0tVdW1BcGFmNGNpQ1RtV0Y0Y1RzL0Jla2tRSHhNSDM5dDdYcjAwWHJi?=
 =?utf-8?B?OER6bUQxQ1N3bGZnV2RMYmczQjB3ZEU2dUNDb2tWeW4vVlpuSlByVXVvWm10?=
 =?utf-8?B?WmRDQ0lVdDJrb093ZzczOTNxOEY5NVRoMk9wdFRGWm5LQmpSb0JCYVNhaTJZ?=
 =?utf-8?B?QnVPaVpMMUxtdm5YZm4yMnQ2S2VLN3doUEVlYzRWSWhvbm53ZHZ3UVg0RjhG?=
 =?utf-8?B?NjZBZEdVaVpZeEhKdHpaM2dNUUV6RVFLNEhuVEE2bDJCUTBqTHNKY0dDQkUw?=
 =?utf-8?B?TVF0WjExN2N6aFR1NUprbUV6TXB4VXNqZWpIT2lGc0x6TnBLZWlvMkpGdnVF?=
 =?utf-8?B?VlV2bURNd1J4bW1TdGJmN2FqRUFEcnMrSkNjd1kvd0tNbEYvR2dic24wb3pO?=
 =?utf-8?B?VENsTHJmeWRHbnBqb05YYU5rUnRaQWkxNlQvRVUyNStkL0czSURaRitwSUhG?=
 =?utf-8?B?WUlrK2VFMFFVcXArQzVYU1dMVGFDWTFYSDV4MWxXUW5YQ25aUURQdnhlYW12?=
 =?utf-8?B?QjZjQm1YdkFrdGo2SXZaZWFrQ0Y3QXlNMWpLb0o0S01NZXkzd21uYVJCUm9j?=
 =?utf-8?B?bEwzTllFa2l5VjF0OGl6elpZR2o2S1lCcWRxOUJXc0F5bDM1dElSSnc4ZnVX?=
 =?utf-8?B?SldhRjlpQS9od3VrV1F2QWJPSnJ1eC9aSEtqdTVCcVZrYm5HNFh2MjlpNnRO?=
 =?utf-8?B?YVYrVEVKQkFZUnJKbzl3RUpWdEZBdnZmTXdwcDFjcnZ4MWVmWEd2Y1Q0bVJm?=
 =?utf-8?B?ajBjTDR4VlI4d1F0M2FOV2VIUi9kVDdWRXpHMWJQNWEwMEZrK09tQm5sNGFD?=
 =?utf-8?B?akhCOFNMelZyL2ovLzMyeFJzNFg3RHpkU2E2RmIxTnZEaUZjMkdQLzVDNVlC?=
 =?utf-8?B?MzZ1OWRlbVNkVS9GNjYxMFErc3RhdkN4cHRxSm1VMGI1N1ZOTGVhWW1ETzdC?=
 =?utf-8?B?WlFSaE1wZHJaNTN3SVlqc0JwWFNZZm5tMXdWMThpZDJGbFhDeUdkWDFrMzBG?=
 =?utf-8?B?UWM0T3M1U1ZrMTRXU0RxLzlHditpQVl2UlhveE5UWU9SdmtFb2s4dCtVd3RU?=
 =?utf-8?B?TkpIdFU3TVpydzQ5NExHVFUzTCtSUE9LWTZTUG5iVDJWbkNWZnp0eTdxOEFW?=
 =?utf-8?B?ZW9YSlFyKzJYOERwa0ovditVeFVOV2E4bjFsTFpiZy9YTzVDWTRjOG5aNndY?=
 =?utf-8?B?VjlzV1JKVWxGVXhsWjNRbVRXeGZKOXBicTdtTFliTS9ERVJOUzRKNXFESUNT?=
 =?utf-8?B?cDdKcDhWK2VpRE9PSzFreE16VGVZTXowdGg1UWVDYjRrQmFGZW5ZQ0JQSCta?=
 =?utf-8?B?SnNiM0xhQ3lINnVvaktlT2RjTk5Gd210NmNGalR4T0h6NmZUNzVaaUZsTDM4?=
 =?utf-8?B?bk1NSzJKK2FEVzJsTjN0SS9aTEpJY1k5ZzZEM0hiM25SQm85d0wvcGs5MXdt?=
 =?utf-8?B?Unl2cVNWT3pjK0JoZDlab2dJaERrSG1PdTdEcUhNVVNxYXN3NzFkZ2d5QXdC?=
 =?utf-8?B?RlFTekh1YWVhekkrcGxhNlhSVE4zeEMwVjRBMkFmZHhpK0gvb2NMUW5LOXZr?=
 =?utf-8?B?dFpCNHZkQnFEMnFzWVYrMTFaQlovcVREalQrd216K2YxRW5SNkhOQXdYdEht?=
 =?utf-8?B?SHIvelcveFFvdEYxWVRzNStaeVBjWkdKc3ZvNG14NUIrUWRjY2xqaEhxbUh2?=
 =?utf-8?B?K2xKdFVKeExDeW9kTHo0STRzN000dlNVeThlSW92MmNBaEJ1WTZXeWhtZldT?=
 =?utf-8?B?ZzIzck4xOStzb2xqcHBZMU5wNXgwVWVmeFhvMW1YYlFQNktLa0xsODVpYVBT?=
 =?utf-8?B?WnZZQytqcWVUUVd3VDFhTGduWE9qNlhHdGNOYlVWNWprMGRFMGV3RVE1dzky?=
 =?utf-8?B?UTFzRjFpY0pHYUJjWlZkS1JXYkUzeEtFUTBRMlBvZWRBMUV3ZE9GMDZWREhB?=
 =?utf-8?Q?GxUt+95xX9WoGiUK9KYOHpgMXvR4ixzJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVdvZDdxZXV2QVpFWkhmNkxDS2cwRGtHTmdCcGNTR09FS2lXNE14WUVIaVBi?=
 =?utf-8?B?ZWJxSE9yL1E2VkQ2WWkreXJLZGRWVExkNG5zS2t6aGk5NllsZWdxOWIzVGV1?=
 =?utf-8?B?cFdvSjRvbEkzbjlvMjJ3RUorendkTGNKMHUvaVJ4WUkrYVZVVnptUEY5dnBV?=
 =?utf-8?B?MWlwNnJWaGtSdlByK2ZneC84YUZva0FwNjNBNlZVL0l4WEIzOVpvSW5QSHg0?=
 =?utf-8?B?aDdVbEw1K004eUVHdC9JV0lHV3Z4cjJGV21OcERnTFRLRDJwQldkUkJOM1Rv?=
 =?utf-8?B?MDllV2c5Z3g4QXdqVnB2VWo3MndEalRZQTlCcURLekV1VjRHME1CYUtkc1Zz?=
 =?utf-8?B?anM0bzNUTlc1RmcvQUdZSWplL0VDSjZmUWpNN01nZ09MWmt5VjBkOVZsVkRt?=
 =?utf-8?B?c0IxdFB5K1JCU2VadG9palhzZDM3NXp6ell2VjdSVFc2RG5aZEIvTzVhU2w0?=
 =?utf-8?B?QzVOcnhUS2lqQnNnYk02YndobERmSXJqc2grWE00Z3FzeDdyRlA5UVNteCtB?=
 =?utf-8?B?cHBrZkNDNGZJNVZKWkxnVXpQeXlDR1JGejJqYnQ4MlJGeVlUZFBlR0p2dldm?=
 =?utf-8?B?NjMwZE5YZFZ2T2JMRWJLWW9MVDJjZ2NwemJFVFc1cFFOajdyZFNKaDJaU2hF?=
 =?utf-8?B?bldJREtPQXBBMW9CTFVVZ0sxditlc2ZZcUJVZ3RVN2FNZ0ZYSG5RTDRWU0Fp?=
 =?utf-8?B?VHVpeTYrelc1Q2hpUXRsK3lTWnNKcVNkTURnUDE3L0FvTFJ2U2xIeU0wdUlu?=
 =?utf-8?B?S21VeUJ1RFI5TE1TcDJ1QlJISkNSL25tSHlPK3o1L3RQbksyOE4wc2J5RkNl?=
 =?utf-8?B?ZGdiN3ZsVnl3Z2tCSDY1M2FRcUFaRXliMTRXSGVMZWpxdGU3VzVIRHlsVFFC?=
 =?utf-8?B?bUVybFlpVzhxQWc5VnFmVmJOd1FyaFR0MkNHajRXQ216elI1UGc1VUd6L1ZE?=
 =?utf-8?B?SS9KMUo1QjhJaHpIZ0FvRytGOVY0YlRUMm9PM0VnYitjTW1RdW8xbkZOV1I1?=
 =?utf-8?B?Q1RoWXZtTHU2WWVrM2ptM0JVbGVibHhCWlkrQmVnQnl1cVpRZzVYVFAwNjN6?=
 =?utf-8?B?NEJEUDlLTi9FWlVKTVdSYlpNVHNaUk5JaHcySjVUdkZNQ2EvbW9ZVnBsRFo3?=
 =?utf-8?B?Qjh3akQ3SkdSeWtiU3g0ak5hZWdLVUNWTDNZemMzRXpMbHlpVGd6NERwTTV5?=
 =?utf-8?B?NFJJM1RYV0JzUE1PZkx2UVF3bmE1RzVJbzFBWFQxZ1FxelU3THRCUGhMQytk?=
 =?utf-8?B?MjNDVS8rTVF5dHNzeldvSVRrNUduVDJJR3l4WnRNaGRHNGw2L1FPbG9xdVNE?=
 =?utf-8?B?eHlHY1kxWmRaenBUeURha2lPRTNtTXVUSWZaUFE4YWRQMnptUlhPcE9kdDJi?=
 =?utf-8?B?MjlTSjQ3V0VhOGFGK3ByTjhYYW40R0huSFRmY1VVMEdJSlBuNGJTZmtRR3JP?=
 =?utf-8?B?OUpzOXhzZ2tjQUFPVVI0QmozU3JQUHMwTmhCakM5SXVVVkhYb05IWElZTDkz?=
 =?utf-8?B?Vm92ZXpMUUZFekczekI0a3VxdEhiZWNQMER3WGhoYXhxQXIxV2loQXVFSXZt?=
 =?utf-8?B?cXZjQWlJOU91eXZtVmorb3Q0VUFENWVVdkVjMWh0aktyTDF3TzFZazhRY0lM?=
 =?utf-8?B?YmdBU3ljbElkQ3FyZUtrM09lV3BkdEpQS1JHK25wNDllMEQxTFA5NFJ4aWpE?=
 =?utf-8?B?OHVDSTYzaVpLa2ZWaWpOKzd6TUMyZnJXTXFTQkJlTGRVYk56NlNsWTVobjU1?=
 =?utf-8?B?dldHZVhwUm1iZVV5azJGYzJzb2RzbzF4Q3ZEYVQxUFg5VnRVVkdOTGtENE94?=
 =?utf-8?B?QU0xc3JTNThNZ1ljU3JidUtyVm9zZHRGQ3V4cCtUd3lGK0ErUk5wQTFwMTE0?=
 =?utf-8?B?a2RpTjFIdzJKR1dVTUFiM3JxSy9ONzEvM1VjZ1NTaExYN0cvU2NVRUNJejhJ?=
 =?utf-8?B?ZVp5QnEzRm9mbVlvK0ZFd0dXVEtuc0dqdTRPWW1zdkNPTTdabGhWUzJ6NjJi?=
 =?utf-8?B?N3Z0WldpSTkwQ3JmNWpBUldNamJvUUdUVmJ2ZHNVc3J5Y09yalV3NGNQSUpo?=
 =?utf-8?B?c3IvQUxrQmVGWkdaN3RmSWRWVlBXcTJ5WEZoZno3cmljVGdDWGViK0YzN2xk?=
 =?utf-8?Q?f2KdRYvn97STxKDY+fAfeJFnN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8b0857-8390-43cf-3d73-08de20931bce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 19:55:33.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRVAsuUCpzVbeWE4qZ/lQbSaQOZ+CC6EF7EfVnAMI+AM0O/aOP3xz1QQsNHztFrax+0lhbNVtb9Llhmdge5fDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780

On 11/10/25 5:38 AM, Gary Guo wrote:
> On Mon, 10 Nov 2025 11:53:16 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
...
>>> -//! # #![expect(unreachable_pub, clippy::disallowed_names)]
>>> +//! # #![expect(clippy::disallowed_names)]  
>>
>> Maybe we should also allow disallowed_names in doc tests?
>>
>> Alice
> 
> +1 on allowing disallowed_names. I think for doc tests we should try
> to reduce false positives to make it easier to write them. We shouldn't
> try to enable all clippy lints on doc tests, especially that clippy
> doesn't run today on rustdocs at all.
> 
> Best,
> Gary
> 

After learning about disallowed_names ("foo", "bar" and others that are
in fact classical documentation favorites), I also think it would be
very nice to allow those in documentation.


thanks,
-- 
John Hubbard


