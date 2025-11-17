Return-Path: <linux-kselftest+bounces-45799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4224C663DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A61C14E29D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4A83203B6;
	Mon, 17 Nov 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cYpGfdID"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C0270569;
	Mon, 17 Nov 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414126; cv=fail; b=bE4tr52uSSUIdpDnLtfPtEPIR8r4JSTJ2uJvfSw0+2WRFUmnX2JXHRMzeETIzlFzp858Q+Ia6/hqXZTgXS+v1F+JaMnNRxzJhlJBkufhwbvHiAJjCjjppCRPP5f8b6SeEP5NL+V3A91+FYEhhRt3ayTEcibdMhXzehYb5bpPhDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414126; c=relaxed/simple;
	bh=z0qXfX5+JOB+XoGML7QjlcCb9roIXvHKjICWFQ0+ZSE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QkxrgfjL0iI1JHwZFvYF2EJ3SQUdN/ER4FoHPSHq1ihaoO4NSg4XLgVlFLKqiJ7TfsDOBTpweGzNJ5EYzlsF7ldvNZLxLUFzABQSjNMbqDIPFiG0hlBHSQI8uBYRLouSwFHI7yhZtpBAYYWVAPu7gvKiKoAq2pw1L/dWRmqrAvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cYpGfdID; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DK6hRvl4pzewoks3ZWceX8IjElYHl1L/e0w0A2uoiw18OOSG/N64Cu9aNeNFNGMwAdqs3UL0RbYjmnCA2f+GqsKXiVK431wLvneXQbRPKdBS5i54R0UP9b+xMRdib9sVpkHeWAwXpkR4aWreTHynIQA6cUZcYxXLbnUeMljdHLMtHcLmCkFx61Hx6PW9IxopASkJxgpTNvv8recMq9RVV0easm7u5jQFoaz/Kur0Okx16nEBVLNEJjCAVRPZgjW20uz0WaJdzTJ0s+AMNReJmjQdetU5+fnjC991ppvnE8pvLPf0oRJ4mIvDvy6sb9WVstwQKokjH7Yme+TFh+G15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+6ZqtSNy7rI3Tx7jtlAjdDDSm9tATD/a6GCcIzzgNk=;
 b=bzAa6m90ivV25I9pyVt8q/9snQGyx+qHBGsHqbuAQaGocXyXwctEMwdwI59Fvgc8kNjadQLF9Qvu7gEqbk+zSLRjV/GoFLGZ2is+P8vLFbkrYwiHk4mTj1rzqVEtxEuLxcJIYTzVJulsYMdLtDxUaH2GYWGmUcHDZZHLn+NvTEG3q67gzbhtbwZj89HpbqMX+K0B3HVFqWhmm5+iZnJuUvE2H0eduKXosuWX4d7aRxBVZm+cC7IV6fbaR5TA7E9zf+Suhfv/GkuXUC/k83NBAGHOX4GCRmje5gz35hkhmIfbEe/J55p215ypCdNPRSqgFYTGXTHbFV/HC7Hvz0XWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+6ZqtSNy7rI3Tx7jtlAjdDDSm9tATD/a6GCcIzzgNk=;
 b=cYpGfdID8AbZ6+0glOZ5bzqpZYy3xUQheqtfxLRJqlAfJhMaDUvlvyL/UMplDG88JH/ckq5Z65zhPvG95J3vsu2PDaKZ/cn9ieZCNoMKf/r86ydUr7x2eTmw9cOvrjG0bN5LRzTe3/xkkKSWNWu/wKNRd/TIefDHDfOz1ULESc96dWpefIEUgL0iIoacYj99BVg03g9M/vs+Ox0GLbGkEQmLgN/jMMPyNECDKACO3xVYlRzoZomjUvmw1dEzfEMnSE0Z+ns8VSAlmcSuCOP7heKv9uETMius64WE0ubBGQvsSU4KVnbryxKrIqMgaSe9VQ83ppei6jatQgde8jA4sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.21; Mon, 17 Nov 2025 21:15:21 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::d622:b3e9:bfe1:26bb]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::d622:b3e9:bfe1:26bb%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 21:15:21 +0000
Message-ID: <81c5e22f-2e6d-4bcd-b897-d91cd5763e8a@nvidia.com>
Date: Mon, 17 Nov 2025 13:15:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: allow `clippy::disallowed_names` for doctests
From: John Hubbard <jhubbard@nvidia.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, rust-for-linux@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20251117080714.876978-1-ojeda@kernel.org>
 <CANiq72=-w2p8sQgUKYgPG3Tx9GSUNgcVUp24k0ck2RqYgupCVg@mail.gmail.com>
 <da4877d2-65fd-4ad2-ac31-68d55bda7c07@nvidia.com>
Content-Language: en-US
In-Reply-To: <da4877d2-65fd-4ad2-ac31-68d55bda7c07@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1669fd-8417-4fc8-1c94-08de261e6abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUczdFdvbU9BMlMvRlc2U1RldDYrdW5UME9qdHJ2ZE5XTGdJTmFncmR3NFRT?=
 =?utf-8?B?c1hrVTJoTXVkYWEvVUduNEtiTkJpQlBqUzF4R0oranZmMEZtTDc0YjIybktw?=
 =?utf-8?B?cmRjU01PaHhQbENpckpGY2VpOUI0RzhWUDR5c0hRNGV2c0RYYmFmeTlBWW9E?=
 =?utf-8?B?ZytUSVF6MXlOdFVLc1cybFZrTVVLSEtSVS9EK3IvbVdVL1dTZkVPTHFELzA5?=
 =?utf-8?B?WWE5cWd0SzY1RDUzcXZIVFVFcFZoc253ZEpkZzQ5Y0IwVGlvUW05cFlTOWJB?=
 =?utf-8?B?cnJvNWhlSHZwZGloTkRET29YUDcxS2ZMVDJPbCswZTVCL1B1cUN1cFQ2UVZn?=
 =?utf-8?B?YTc1RFBvYUo3RUM1L0ZUOUdiZTRjMzQ3R0o0SEpTK0lhcitXWTRXVC9lK0Ry?=
 =?utf-8?B?VndHclVWSkUrT1c4VkF6SXdPWFdLTzVUUytLZHFEN05aVlJ6QkxTTHJCRGpk?=
 =?utf-8?B?d3E2R0tUYTJmRFhFOWsvdU1hbDB6NWdDZmRJOVE1TkhxUytxa3BXMzVnVjhI?=
 =?utf-8?B?MWsvaVk3K1FNTnI1eERJZjFrcjUrY2x4WXRVM2dLMUxYaUgzN3UzSmlOaUx4?=
 =?utf-8?B?NDE0TThNRGwwRloxbUhuR2YrYU1jYUhTTm8wQUFZSS9LeU1VS21NQXdRSVl0?=
 =?utf-8?B?ZUFaVlh4ZG9iSDV1R2VrWFdOeHVYamdCdGRsZVczUnN6K2RRZ3U2SCtuS09p?=
 =?utf-8?B?cVBNVDROck9pT2hlSXdISWlCWEZidENNeEN4Y1JVNTlZRFNSSTZGUzhoVFdK?=
 =?utf-8?B?L3BzbUMvUVZsVWlCaWpIamxCZ1lwcGRvanZxUEhXY1hRNHprWS9RbTg2TExs?=
 =?utf-8?B?NlBrRU5rRVo5aS9pMW1nY0RjU1p4Z2I3dVhoUUpwOWJYWHFRazhFQUp2TmVS?=
 =?utf-8?B?OGZQb04rYzg1TUhwRXlxV2MyQTRNc2pTa3YwdDZhb2JVOVFCU3Q5dHZtMHIv?=
 =?utf-8?B?alhDTkRISlR3MWJLb0NoWTBkZ0o5QmJIVnBtZHV4OTRQcGk1dnVaVlpXRTBx?=
 =?utf-8?B?YkFsMzE2OXM4NGVjM3RXV0NzVGlLZUVyYUNLRUdjNU1ycGZDVnAyYUZDclFr?=
 =?utf-8?B?R0Nvam1VSVl6a3FjRWNZaUIwamRENEcwMC9lMjFKV3dSemVUaXZrNThzUk9U?=
 =?utf-8?B?TkNqbXRCUUx4WWR5VVU2K3hPWnNOS1QyQ2lpL1RTMEZqVU5PMnhqSnJleUJM?=
 =?utf-8?B?akRPak93SnFhYlFwNDFMS2JpSzdrR2lLSUdFK0loUmZkSzRBak5Zby9LL1hr?=
 =?utf-8?B?MndlMzFNWWZqU1lJQzI1UkE4aHY1RTFoOEJIRVZRR080ejRhcHBKTStjNUZ2?=
 =?utf-8?B?b2ltZXgvT2duaEhjUERjY1Q5aFVjaGZqQ3ViUFZMMmtxb3lBTU0yMFM1MWlD?=
 =?utf-8?B?WmtUMzdlb2tkWC82cXhtZFZ2TzZZcnB0aDlKbFpXcVNna0RlcHJLN0srQVdw?=
 =?utf-8?B?aWtJSjBuQTByK1pCQUwrWTNxeHdkaFJVSmV2dERyVUdhYUN3eHg3UFE4Wkgz?=
 =?utf-8?B?Q0F2Wk9LbklxZk50UEpmUExjd21BRXVwUW1lMVdFUUVwdWhJcDlyaDZSSGsv?=
 =?utf-8?B?S3piL3p4cDNjQzVjYjJodGlkSTdBN3QydHByUEJHbzBQbXJIaXFMc3hPVUt6?=
 =?utf-8?B?OFdWT1VwRVNXRFlkVCszSFNjUlBTMnNaeUxZN0xDbG9seHZmNjNFdDdldFpE?=
 =?utf-8?B?VTFDbXVVZTFUQ0tlN0ZqeDFuYjZsTXZFV3dKQjBZSHZJamJiVUlXdWk3dEZj?=
 =?utf-8?B?WVgwMlBGVGFMUGtkZDhxeGVJdFROanpLTVJqamJZZ0Y0Q05Fb2d4WSswTGw2?=
 =?utf-8?B?UVJQcVZvMFdkM0hNaUs2Q3RWNG1NNE5kWnpETCszNWNKUTU3eE0zeFhrbG11?=
 =?utf-8?B?d0U1TVMxbFVEeUZjQkJvbmRzdGlCYjF2dUhsVUhXTjFkYWxCdmkwOVZyTjhQ?=
 =?utf-8?B?ZUhzU2xvQXc3am4vd3lxTlMwY1FGWEVydnJsd1RxdEJzL3ZlaUVQY3hOYU0w?=
 =?utf-8?B?WVBTRmNpdmp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zi9sYng1UmNrV1h0akxZM081TUJobWhoYjhaSUxHdnhTRzdNUTFQRitGUUd5?=
 =?utf-8?B?TXNNMXQ5b29YenZyVjhDU29uek1nbHJpRldlcUZCYjBiR3ZZZjNiMHRtRDBY?=
 =?utf-8?B?YXRaZlQ5ZFBTcG9CVXZERGtrcnZsVk5naTV3OVJOa3NJbmN3RTY0WjkvbGlM?=
 =?utf-8?B?cmR2U3IxWXl3R0VLNlowektDdmxuZlJqTnBIV0pObElMUVVSMVo1c1BRSFpX?=
 =?utf-8?B?aVVneEZ4MmJRMElCWlBiRzE1Z0taSURtRnBxRVR6SWFSSXZkV1hLWFlncHpK?=
 =?utf-8?B?Ymw3aXRmZ0RkSHQ2VDhoMjRmRm81THB6dzBNQkpBNjU5RDJPNkFsU3FMT0Rr?=
 =?utf-8?B?RGw4ZklUYnF1OEtha2plMHhCbUt6dlFLOFJCaUw0RjdIT1JTdnV5TUk1MTVV?=
 =?utf-8?B?THQwby9TOXlqb1FXam5RdDVWenliNEE5M2FQeWxXY3NwcUtPZ25LNlIrLzIy?=
 =?utf-8?B?ZkdqSEJ4Z3BvdGNDRUd3MC84RVE0RVBKRldpZzZRMHlvYXBaOUlzWkRJby9h?=
 =?utf-8?B?ZjFqZEtGbzBjbFM5bFVaSDNlMHpqWmJLSWlUbUFPWUM2VmNrOW1FV1oycDdo?=
 =?utf-8?B?UE84YnlncXlQWkxhN05zdUNFQS8xeUtvWSthdHJJWFlNMnJSbkdsZUM5VWhi?=
 =?utf-8?B?SW5lUktoWml3YU14S01rMyt4SlhTc3hzaDRHWTNkZTQ1TDAwQU5sbnY0eCtz?=
 =?utf-8?B?VlpiZmJVY0NRenlIMHpYQ1pXOWFzUG1ZYVFmZVBWZ1hrMld4bXNRMzI2bERr?=
 =?utf-8?B?MkN0aHIyOFp2bXFuWXJoYnpwZ0VXSUF6YkhiVHhCcUk0dStiUVdSMjkvNitI?=
 =?utf-8?B?TkFOUDhaNWNPaGJIMW9qQXpqUmlSTVZ2Vi95R0doenlYeHpxR2J1YWdibmdK?=
 =?utf-8?B?SjFtdVNHalhtYkZpZHA2eFpNK2JRd2pIVk1xLzdDWHZmK0hvUHlCaUtWdGh3?=
 =?utf-8?B?MWw3WmxacVY0RkJjU1UwcFdhdzRDdm9GM2Ywakc2VHdNZ3IzS1VaSk8zM2Fr?=
 =?utf-8?B?QXVjVGlMUVBub01DdksxbUpuZmUrYzZOenNJaVlVUnFDWDJEbllHdWNVeWVR?=
 =?utf-8?B?bGZKdTYzQ2YvTnN3WDliNEYxbGx1L3NRVWJZclZ2KzQ2THF3UTcwcUJQUUlS?=
 =?utf-8?B?eHdTekE1M2dmYVdtVFp2N28zcDBVVDg4TytFekRDOCtMdlBDZWVLNit0RW51?=
 =?utf-8?B?bndXM2plUk5KbUNwZ2VhUTJNWHhnK0FQeFRjTmhiUmZNTituM3kwZ0R1S2Np?=
 =?utf-8?B?eUUyRjZaRGxsaDVPK3dWNFh4eDRiZDBXbXBxdWRGSExMcVpFMVozak44MGha?=
 =?utf-8?B?ekxTRDJXTVRlZThCYzVOYTF6Z1BvN2ExTHRIUVhjRHJPQTZOams1MTE2ek5y?=
 =?utf-8?B?NjBzVWZUREh4cTBvZ1pxSGpJbEpaUU9ob25JOHFNWmtnc254aWk1Q2pDSklW?=
 =?utf-8?B?eHA5K1pPYnR0cFRrU0FxbGduY3k0cko1REFFTklhYXdRWVlYRis5QXZnQ0U2?=
 =?utf-8?B?bWpjNG1iYnhVaFVZblRkVmwwREt4T2pDTnE3S3JDMC9LTUIrQmlOMCs4Nnlv?=
 =?utf-8?B?TTZwMUZVYnpIam5pekF1OHp5WEdHdkM2UHRJMEt4Um5Va2I4dkZCMUlkL1pq?=
 =?utf-8?B?cU10NlhPdnR4TkRHS25ZU1c1ZVd0R1ZZRHNqcDRVSWgyNGhlQnBweWVEa2NN?=
 =?utf-8?B?R3kyMHY5K3hGUjk1S3pjMHU3U2VEUTM5QUlCdUxFYm1VSWpKdjRzT1ovWm1n?=
 =?utf-8?B?eU9KT1lkWENqTitYSEVISkJaSno5R2VjbVI0RHhJQTQzbjcyTExYMXRLd0tx?=
 =?utf-8?B?a0gwZWZOTWwzenI5UldqRGd4Y1lia1k1Tk16TGJwMC9Rck15SmFzWitRQ0dG?=
 =?utf-8?B?ZEQ5QThxOEcwYUVjNmcxZG5lZUtGeWU3cTQyUFR1WVh0Sk4zMWN0R3FITVFi?=
 =?utf-8?B?RDc4SWhoTDNSblJ6ZTd2VmkwZ3hpb2paVmhMaUU5MlNBNk4rWTVUSjZhdURP?=
 =?utf-8?B?Z2w3dld1YXZnaVpDa2EzR2dvMFFGR0tJUFg0SnlndGNVN0h3QXVPTFR0VUND?=
 =?utf-8?B?NE5qemtPUmVrRi95NjRSVTN6eTliWGRVNUM0NHc5dmZPejFuV2QrMkJCVHQr?=
 =?utf-8?Q?MPwHsmzEujgyVjNcKVjEdSIRy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1669fd-8417-4fc8-1c94-08de261e6abd
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:15:21.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XLEJZPi47+VZ7NQ8zjEwZ8PfpV9d5XUyoMDfGCDRRu0Yl8Feo0k3oHZpP17cVBNULJAGZxYBdRP6JcuPKwSmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718

On 11/17/25 1:13 PM, John Hubbard wrote:
> On 11/17/25 1:02 PM, Miguel Ojeda wrote:
>> On Mon, Nov 17, 2025 at 9:07 AM Miguel Ojeda <ojeda@kernel.org> wrote:
...
> Is rust-next a rebasing branch? I was going to request a non-empty commit
> body, in order to make it more immediately clear what this does. Something
> like:
> 
> The current set of disallowed names is inherited from clippy's defaults [1],
> which are "foo", "baz", and "quux". This may be extended via .clipy.toml,
> which so far has no entries for disallowed names.
> 

oops, left out the link. Here:

[1] https://rust-lang.github.io/rust-clippy/master/index.html#disallowed_names


thanks,
-- 
John Hubbard


