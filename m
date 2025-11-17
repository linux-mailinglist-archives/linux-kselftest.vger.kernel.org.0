Return-Path: <linux-kselftest+bounces-45805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A27BC664B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A193A362852
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD74324B32;
	Mon, 17 Nov 2025 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iTUVdvm5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72983246793;
	Mon, 17 Nov 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415475; cv=fail; b=Zd344fJmEJCjxr7rZ5s+ECH22w1SdFgaVXfqAq9ujtS7PaI6Cr21NrhmUnao2tVSS6bZkiycYiRjn/E4Fe0akUR1nx1+Cr9p8MKftiWnMk9QNX97Ze5JXXLLqHgHUa6ThKxwmqYPNejQJwzL3/xjdb2Zb/bEA7amdzV6igruTOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415475; c=relaxed/simple;
	bh=KnI2uI6M2S0kyeKj3XXpVZ/LHJdzLSxhvR+nc7No4S4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tkt5u1LmEGoGCm9sL2/vd+lv0AGdQbz1+Y/P8tWKMBNQI84JqfatyLJUJljtXbH+jrOl9NYrMvl5U1bx75nfj+hWDoBG+lAmAWKPxpBHV0j9xq42/8Uc2y3XO90C5YTuKdt/q0gS3w/t1szBi1LVEAZ/10mjjctm2BP2XhEZ6KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iTUVdvm5; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epST2VX0vwy9hi1x/bon97vjms0RPgFCGzg0J/mGXr+CvVJvbeQDuph4Wx198PzBBtaHMv6Vyrgc4pNGUAcpgozDntcCuFpuDE0SlJPXmT0c/WytvCW6fFahL6g7UNnfb86cJvQjWtQEx6ajmHuf79v/dTcyqVkmmF2QF0+UF+TSCmkjQIsvARXjl2ehqeG+34dkF8meu6VOAKu+1sTLgvgNs3NUg39AViInsvCdvkzYJVtr07xvdcFKLmQsWlgDzrG9VSClvHXxmx4A3Gq+dfsA/fTeO7Uk3vqODDb0nB0VzggVZMEgBP2EIGdal9Tu9v2a6qDh6SgOEEx4lBUkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4ijSYi/NVgrHUXF2u6Tq5okiHJiataWIjev0/x7LM8=;
 b=EqGygJD4HhSal/NaXw7Kn1VVMFnp7A6404aeAhYH5VpDON8EkVV7cfHzIUnSJYKHDoRjJBD9QFWqB2dySwpS3N+F6AdYD5rJ85EdfR4Jx+dP0dRa8QZTjBGCI+7Gak7pTJK/bp3BuBmZG26jwVgfmwLAi+pkHb0U4Nm1rskbEZ7ERLNxsYDzmb7lucEzU3Z1rF+76dPFkgjAwF3zfK55X5r7O1uIoYEfvxORycmGsvl8HM7hdpg8D0Nc8Ha5mxIuhpq0znHMu4b1w2dZ6sJH1b4FELNWDwqlSBtyDzowXXIUtt2oAOmiYsRituhIXGZ5ejuEo3Yc5xloNF6DXS/kUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4ijSYi/NVgrHUXF2u6Tq5okiHJiataWIjev0/x7LM8=;
 b=iTUVdvm5uw5XNS927toeqvRxscYBFqAQ7IrGErb8zCDGQWRiC1SIDv7NZBgBp5Ftgv1xwhhEaeQOydci2Abih2XSuQplECAeRhqAP8rDnq8+EsJ5nMCLLTuBYcJO9XeUWWFfhUICJ/WyIsu0KypVmpe4hIzBvMt1HmbRtlMj5pISRxEEaaMerYCI+wCJLcg97xbddGO3L+t8iOMDsV9YWpCRm8DUn8m/CSeiD66+UyXN7y2quZSNEfpJOSFx2353Sj+w7/HGFYadbki+fIT8bCBwdSCH6uz+OhA8Jj0FyNAS/xJRnYrUzqj9xYl11tYUtRG4L3j5bYjJAqqjbeUjtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.21; Mon, 17 Nov 2025 21:37:49 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::d622:b3e9:bfe1:26bb]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::d622:b3e9:bfe1:26bb%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 21:37:49 +0000
Message-ID: <2126d9ee-ccbf-4c50-8e05-b02d186fb1a6@nvidia.com>
Date: Mon, 17 Nov 2025 13:37:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: allow `clippy::disallowed_names` for doctests
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
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
 <CANiq72mXN3U-oZDMfkCNTNLtvReZjROdgNmUDQ0H=kDP5FbopQ@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72mXN3U-oZDMfkCNTNLtvReZjROdgNmUDQ0H=kDP5FbopQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: d01394e0-aba3-4ec0-6b47-08de26218e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE9NUGZ2SzZBTUZjMEgwc2ovVXRuc0NXSzJHT3dQQ3RLcjlVNXNtWTdURnZF?=
 =?utf-8?B?RG0yNkZHTGRYRE95VGdPSHkwTFZjMjE2S281aENqK3JHM3pGT0R4VC9HcHda?=
 =?utf-8?B?VktGOFZDNE1OcHdVdWlmVkR0V0lVY2htZGI1QzR4M2JuczRQSWthK0htKzlj?=
 =?utf-8?B?ZFRkTlBFaGxtUm92ZUNJZGh5aDJEV1BRT1FGTjRHRXRETi9MRld1Z1M0VVpu?=
 =?utf-8?B?dlpJdWcveHN2MnlpYU1TaHR3WWRNQkNyejBTb0Fkd1hmZE9DZ2dKRkMzRXBi?=
 =?utf-8?B?bFZFNlhKa1pzcmQ4Kys4R1JiS0JoVm1GOFVHQlFMajE4OUsvcmRPUk1QTExr?=
 =?utf-8?B?eHAxcXJmVHlNWWhlZDZMMFMySjNZWFkwaWNUQ2I2UHI0TEY4UEtjaWR6aG1C?=
 =?utf-8?B?UFJPVG0wS0t3VU5pL0RNSWxGNnorcTE2UytJTUdRMjlJcVYvS3dxbU9NVlNM?=
 =?utf-8?B?ckxFTnM3bjhhUVRKcFEyT2VrbE1HSTArYUVSQVVzYTZvNGw1OEE4bVh3Y1Ex?=
 =?utf-8?B?Ry9wMHIybjRacXlTbWYzWGdUbXNKa0crZFRQYlUzVVNvYVFXeWdMZXNYZlE0?=
 =?utf-8?B?ZCtVTUZlSm9vbTdsNEZTdHMwUEFXazQyZFZlNDNjcWtCVUV3QVJrdHRSem5a?=
 =?utf-8?B?cjVQeHVQdExYdGE3NTJhTVhLOEo5dkVsMFZVZDhrNGVvMHJHR0VTQ2hpR0Vu?=
 =?utf-8?B?TXpDSmxBSEcvc21RNkNGT0lWaTJlaHJKVEdQRCszSG53L2ZMY29LTFAwZ1V1?=
 =?utf-8?B?OEhrQysxaGlBd3N0cERBcG5GTk5YbFEwaExTWS9GejJVQ2I2d01VUnRHT2M3?=
 =?utf-8?B?QzJVUnVkZENVT1RaL0VRMzVhQXQ1TjdiR25PR1ZsV09tcy96RGNJL2RFMTU5?=
 =?utf-8?B?MjdQeFNEVENiOEI4WnhpMWt3blB2cDRmYkNqdlZGQVcwNmpGREszYlR2bEwy?=
 =?utf-8?B?K2VObTAycDlCT01Obk9CdVh3KzltejYwL1FDV05zODRjdzJ1Q0s1NW9CWFBB?=
 =?utf-8?B?Y3pXVWt3cDg4dlpwdFlKcXVMSC9IMllST2N3OFZiYUZQeXFXZ0ZYOGVza3Vl?=
 =?utf-8?B?dEZxdHRSSUZJWEpYZEFDdWt3dC92YXpLK0h3UzJ0VkJZeEpFVHJiRUp3M1g0?=
 =?utf-8?B?ZXFFYm5aM1ozSWk2OUhzeEVDMlhpNnF0Rno3eGQ2NXgxWlNVaHNtaHg1bHZy?=
 =?utf-8?B?MWp5Rm05WkQ2OFlFSDJxQmljVTI2UUtuTEladHYrZGJoZVpqM1RPNEkySDlp?=
 =?utf-8?B?VllndmM0bTFuQ1l5UEVOWEtUYitMWUxHUmYyVHlCc2RLb1I1TDhqRGdNc1cr?=
 =?utf-8?B?ZjdMa3E3Uml4UlhzMjdDRW9jUVl5RzRoSWgxbDRCUExOV1lRUno1eWsreFA4?=
 =?utf-8?B?TWlFZUg1OWk1M2l5WFhKVkM3RzJ0TVcrZ0JsMlZQSER1UkxNbzdhR1Z3b2l4?=
 =?utf-8?B?aVB0KzF6enJBMWF5MFFhSHd0eEhjVkxIOW9HTGEvbUJHOGtOdnZMcVpKS2Mw?=
 =?utf-8?B?VkJiSitrY2V0elFqMnVCRGFISVJvTkgxNEh2TjBCU0V1OGdrY1dOUnlDRTlV?=
 =?utf-8?B?OTFjOHhIK2RTYk81S1lsNUxoWXpwUlRUbUdUM3dKKytYcmR3ckY2S1Z1dGFK?=
 =?utf-8?B?MDNaTmNXcVE5cEVkM2ROY1FvbVZocUYvaU9jdjhjRjlIVmZodUhUZDJPaU9H?=
 =?utf-8?B?SzArdCtBblhsaXQ5NUpSUEM2OW92NHlWWlVCMDg4UXl1UVRoQ1M5NG1hSytz?=
 =?utf-8?B?bWlERG9RN0J0c1h3QkM0S2dlTS9aajc4VEJ5enZKQXl1QXJ6R0Y2Q0lwRmdz?=
 =?utf-8?B?NDRMVUlLRWtLZEJKK2ZjU25jb1AybmFsYXA0TW1RVTk1MUhRTVdPSlBIWUwr?=
 =?utf-8?B?YWliWmpzNytaRzFqOWVVSGFpeEVhcDgwcURSMG5KYmZVZXZNZllOZEl3Z1Y0?=
 =?utf-8?Q?iB1iK7nt5mxC7tE+BAK/MxEakRwaT2K+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVNpNk82clh3a3hZc0pCa1BUUHdtcnBnOU90YTBITVdFbmwwMnpqRFRZdzUv?=
 =?utf-8?B?bWhTOE9FTzlSM0xzT1hXdDNLTkx4YVRDVy94MldwZGw4K3ovTTVpRnlXVEFC?=
 =?utf-8?B?TnZIRmJOelZTU0JsY0xRaWVIcDZDcHVLUVplMEhqL3R3RGFDRlROTUZoakp2?=
 =?utf-8?B?d2hHSXJQT0w2eGxjbm5KVUVZNm02cEJhYklIUlB5OVVIcjl5dmY2ejh4Tk5G?=
 =?utf-8?B?aXYwZlk5RFphTXVmUUUxVGNIVUg0YkhrZm5lelo3THk3NVRONVY0QUl2Sisr?=
 =?utf-8?B?VUthUEFKRkxacXlnZ3RRMHJ4RVRkb21EanljTUIyZjVMN1VSR0hBRUFROUZE?=
 =?utf-8?B?bE5rNVJUV2tTeTZtaHlUenErb3VmUXJweVVBcElvMkNqMHcyZW5vWjlJa3BH?=
 =?utf-8?B?YjErOE5Iem9QbUJVZm4wZ09ZaGpaazI1YVFDb25LTHBwamUxMFk4WElKak9H?=
 =?utf-8?B?YTdMREVjRHY4cEdoWFIyWGQrc1JVaEpUc2daTXlVam9ubEtvdDk2cXhmYWgy?=
 =?utf-8?B?TDYwc2FBd1hIeHYxOUNIR3NMRmJLOUFVeXBXcGVEc1YzMllScHVCUkxtbEdO?=
 =?utf-8?B?ZXBDS0Z4Q0NHaldzWGVIbm5nTjdwTmk2UUZKSCtCd3VPY3llMzFzQzR3SkYr?=
 =?utf-8?B?UUZqWTI0dWxuMTYzVlVMUjU1SWJoSFVXcTZMclJDdm5XL2ltMU9sYXQ3UEhQ?=
 =?utf-8?B?Ty9NUWdWRVAzNzRBTzFqdTNUOFlXNzh5TjFYbHh4NGtVSDFaUEI2YTZxTnFF?=
 =?utf-8?B?U2VqaEs4RWVXY3Flb09MWEVrVFAzTDFPTUdLNUp2bklHMGhVNWNKZFIvR2Nn?=
 =?utf-8?B?eFl4cWwweC9oWVNUMjNhekRVZVV3T0g3NnA1ekg3dExsWU50Y2RoR2p5Z1FI?=
 =?utf-8?B?TjljNXlNSS9EYjRZckJ5VTlhd1hORDNQK1U4TFM2b1RhU0pWSkRnUGdkc1h0?=
 =?utf-8?B?amZWWmZnMXhyZUNZbUhYUWROeFVHTjFqcFN3bUVNSHNJdklJZGcrQXNXemtT?=
 =?utf-8?B?V3JGK0NYZ3d5QUQvWWFMZHlqZE5VWWdMUEcxU0dLRGRyckN4L3NTNDVVcWp2?=
 =?utf-8?B?b3NyR0t3Vk9zd01XR0dHaWc0YXNvREFHOWxCbjBsWW9PWVlyTjY2MVhyYVlp?=
 =?utf-8?B?VEZSY2pTcnd0NHFjdDFBZlA2cVlaTjBCK0cvWFVEaFduVmtMbjVydlNEc0w4?=
 =?utf-8?B?eTNjSXJ4VEhsd05pbjJUYTJqTCtvR3dFMnY2c3FDQ1BBcllEZXUvTXA3RTM1?=
 =?utf-8?B?RmtCTW1Xa1FjOVdLdVJjRmpOYUpHOGVveDBnL1cwOVNLUTFFL2hqOWdUV2NF?=
 =?utf-8?B?S09jYWtiV1BieDgyTXMxSkh4Ykw0dlFKVFBQNlNiT2NmL0cyWC9WcURxZ0FS?=
 =?utf-8?B?UitMMFRSTThJNmJGY01peFZkSTZxMTJBVXNtZkZEODJDVlYzbkg5NllQS3NG?=
 =?utf-8?B?eTd0OW5IT2psUUt3eWNSeUU2K2pnMmhTelpHRys0UHE3Y2tHZWFQcS8xNG0y?=
 =?utf-8?B?VUgxRWVEK25zQ3lUYjVqbWJiY3oyUW93dVRFWHdrU1JwZy9TQW9hT2UrWGdI?=
 =?utf-8?B?cVlXemxvNWtBSkF3QVhtN0dQdXNLVDZUMngyTU9Fd1hIUHh3M09NcW1IK293?=
 =?utf-8?B?ZGlZT1ViTnVBZ0ZJdWV5cnp1S1VrYjRRVGkvQ25RbCtTQUJRTndZL2ZGb0Ju?=
 =?utf-8?B?VXBOdzZESnI1RWMrVTFsNlc1ellPazBnWkl2M09KQ0ZkTEVOaEV3bUlWakNM?=
 =?utf-8?B?eUNYMWNyRkNUSzAxaTRBaDJuV29NRlg1MzRoTU9BMnY2ekE5UENJTzlEQjRr?=
 =?utf-8?B?LzJKaXFMVlh6OHBDbXEzelM0WThISFl5WHBqbnhBTmVnck9OVGw2cUNTQnBH?=
 =?utf-8?B?eTZlWStjS0o3U09ENGpjWExUVXN1UXZla090eklwUklmRFByaUJnN1BBK2cr?=
 =?utf-8?B?N1hUam5ya1Foa1JlTUcwd1FsWDVhUVcyUkpRS3NMd1hIQXdwMUNhMnNnLzRy?=
 =?utf-8?B?SzNWK21Oa0pBTUxVRnRGVkNocDI2b0oxZ2V1cy9SQWxmSm1kN0N0Q3FPVi9Z?=
 =?utf-8?B?S3Z3TjM2MFhBODhTYWxRVGZVbU1JSit1eG5VeGJKWHAzT2lOQ3pFcnIwVTN4?=
 =?utf-8?Q?rLlbfBeKYNtvvhry0+Z5NUXvt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01394e0-aba3-4ec0-6b47-08de26218e20
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:37:49.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ijp/aimO9f+jEIkCk7sVnGWrnSoiOMtDeGkiuaAe9WJeKjMd8dghXFeFBVlRDMsmo2DwEBFq3yBegKm7D7LFCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702

On 11/17/25 1:26 PM, Miguel Ojeda wrote:
> On Mon, Nov 17, 2025 at 10:13 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> The current set of disallowed names is inherited from clippy's defaults [1],
>> which are "foo", "baz", and "quux". This may be extended via .clipy.toml,
>> which so far has no entries for disallowed names.
> 
> As for this paragraph, I am confused why we would want to add it.
> 
> This isn't about extending the disallowed names or about how the lint
> works in general. It is just about disabling the lint entirely for
> doctests.

Yes. But I still thought some context might help, because it wasn't
obvious at first to me (as a Rust learner).

> 
> So adding that paragraph would make it the commit more confusing.
> 

OK, I'll accept that judgment call. :)

thanks,
-- 
John Hubbard


