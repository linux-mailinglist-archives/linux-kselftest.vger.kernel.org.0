Return-Path: <linux-kselftest+bounces-32760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6AFAB1B29
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 19:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C4E3A962E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76977238D2B;
	Fri,  9 May 2025 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RRteydqS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A922D9E2;
	Fri,  9 May 2025 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810094; cv=fail; b=G0O14/WgZkCX9t7NPURYm11oS7ZvaB2e6n2FrxM5Js/dcTxg49bRRMs7jPwJVWnGsk+RusoXM4bueTEKafH4VqcUVT8iV42LLwnCGyAnT5MhxO87F0/Ib77qcPTIcg76nCltxBdz5WOrDaUBWZXebda8EXbDf4BIiSM6m/FMv1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810094; c=relaxed/simple;
	bh=WqbPEjctzqb11BvCZZsPn5K7WxsrR0dM8FJAPF3A33g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJ7EK5XcXO5O5BP1b2wRE3jVqk5Cy7Es6hMM1Jt7xS3WOQeW2BvKskyl5nCvNyUDzvubTrZbKj0So2G4SwhzpfYa+mYKvCunuvXuBg8p/zAui23qKF5Mvn2BKL10AXAerTChggcczT5D5XjhD/O11NUsTNtxUbpjplcRmq57or8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RRteydqS; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pT+ewHflCfUuVsetlKUFNzZw5XYRol8jHdgKfYCk4O8XNm/w/Q6SYdisp4WyWiKr6u3jf3hI4a0XYimu6Rn19Me83RUEB2bYk4vqovkRZRA0T374wdPfOoqF0xTT6aLgfGfjT0jMyhCv4d3IQTYfjZP+TZRVxhFLvTsSklul7IK+bHyyY3X2kuiqr+5QvV2nAI8m8pSJ3TcSU+iM8FTbDtNrR189WjBF5eGYs37mX9n679BXcwMP4QEpA6z2/fxqpOsRUNg3KN1cu/NGrEg690Ei9K83dCmyMaSQ5in4w07AWmZ5UohqSi/DycIfAwUEioOQ7cNl7QXqfHJ6XUoesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A/uvt1CHssKfCFNhzwWtJKJcOAtrkKO8mX20yfNc0I=;
 b=ppK5FjZlz+Pmd7ZmSPrnDLJU9o+sVC/ot1f6qm9x01LT2/6hXvZHm0lgAhs0Ghwuwh9TGFxSfFZmyr9tNzbdTXLaGvAqHNaaEfTqWsPtKDeF5A17etZHXDW4HTK4LBqxcjKGKFSnvKSiigo48FIT0DghmRwdAKEKbqmwTwuP9esqLiCZyPh0rnjPT+fKRWandflHgIbyRDkokLJkLQCbjDpwsAsf1+BCf41smq4VXeXhjcfu0veTGPOizUfIXIY1JmVsx7mJnCQxKvC2kblvxEibiw15Oo10idzdOAnFLdCV93GXthRe686sNmG+GHSCzkfzMcufdShQanbZYPodEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A/uvt1CHssKfCFNhzwWtJKJcOAtrkKO8mX20yfNc0I=;
 b=RRteydqSWG5zMD39zaW8uOQlSIObIlwHxPrnOUBI/eCjpppDgswAwbd6Rna0EE0qv1Hpa2FErlOcoBfUZpkQa+5X9CbBEN0G/gNfUmFXAIw2pvxV3SwLlo8HE9pm3yfOOMb+Fo0RDQnXiBoDN5foEWkkqqobxh8drfEW/B8Or7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 17:01:29 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 17:01:29 +0000
Message-ID: <03114e3d-ff0b-498f-8aec-00a26276785b@amd.com>
Date: Fri, 9 May 2025 12:01:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: Disable SEV-SNP support on initialization
 failure
To: Ashish Kalra <Ashish.Kalra@amd.com>, seanjc@google.com,
 pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, thomas.lendacky@amd.com, shuah@kernel.org,
 prsampat@amd.com
Cc: pgonda@google.com, nikunj@amd.com, pankaj.gupta@amd.com,
 michael.roth@amd.com, sraithal@amd.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev,
 "Paluri, PavanKumar (Pavan Kumar)" <pavankumar.paluri@amd.com>
References: <20250508225257.9810-1-Ashish.Kalra@amd.com>
Content-Language: en-US
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <20250508225257.9810-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:5:177::14) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f041a91-3933-422f-f5f8-08dd8f1b242e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWRCMmJvdG5naEU0Z1hSQWFzVFB3b0Y5M1VDSUgzd1hmcVZRTXdRWFhaSUc4?=
 =?utf-8?B?Ly80bEVhaTZLUTJCNmNhSDZLSFRHdVJ0ZzBuTEd6alU1eUdoRzhiSE9VbmdC?=
 =?utf-8?B?UVlyelliOWVnWVY1WWVlSFhkOVA5QXMvTGdvck9MTWNHVGxMcW96a25Yc2h0?=
 =?utf-8?B?U2w2N2FMNDdKT3lGL1Z0K0ZIVlZNQXN3bzludnpXWHJ0ak1JUXZYQjhnWEJU?=
 =?utf-8?B?eThQM210bXc4ekswc3o3RlZiTFRTeS9tWHF0U0lTbkxYbHQzOUZBMG9SRVBh?=
 =?utf-8?B?dHRTWHhUNUwyLzR3citqWXdYRDdzK2owMC9mMjZSYmVONDZCbnNVaWxEbUFZ?=
 =?utf-8?B?Ti90aHZlOStrblZlRm02d3ZPdkZEQVFUdEFOWUdhQmxhOU1zeHplM1JyaEtP?=
 =?utf-8?B?STFnV2pIdzFoVE1sNHpuY3FxckZQNGg3WWh5NTFpbVNqWTNMOXRpTElvOWEy?=
 =?utf-8?B?bFkwMjFkTTIvVlNDS0xheHl0MFhEbTJqNXE2Q3kxdnI3SFBCbStueTIzWHhq?=
 =?utf-8?B?MVFWbncwR2twY1c2MGxud3gzLzBYNDZyME9mRVFod1JPWjh6ZWpIelFrZnJU?=
 =?utf-8?B?UGE5QU1BMmI0d1R2QzgvSmRCOFJhMFZIS1FDYjkxbGtiL25BaUUvbkxlY0dM?=
 =?utf-8?B?NTdCODB6Sko1VjQvQU5JYVIvMEhxQ3FvS3ZYZWFvSmJ5Ujc2OHpHcHFJeDIw?=
 =?utf-8?B?QW1uQkVia0w3Zjc0YWpLTHFBdXAxVXZqYjZzT1krdFY3SldzQm9EZUd4eThU?=
 =?utf-8?B?aktSbzhWOVlhc0pjbWsxbDdlY2w4MFFFV0taODJLOVRwMjNzSHBQZ2dOVWJH?=
 =?utf-8?B?T0dlcElPT2dEencyVy91RkVhUGQyNm5YdzRkVDRKZ2d2ZFp0aDZYYUs2U1lu?=
 =?utf-8?B?b0NkalRMaDdrRU9TNUpZRUZPVGhBVWJKdy9HYWdXMzh0My94YUtxMDNlZlN4?=
 =?utf-8?B?NXFPU3gvcXVwNW5wcldzOHJuZWwxTXd2c3Z5SVF2ZGhCRDU3M1VJQTN4KzNR?=
 =?utf-8?B?Q2tEUW1GR3U1WjI0NTc4TkJtQkRKQWgxNEI4dllWMmp3YTdBb1lKS3E5UG9X?=
 =?utf-8?B?VmoreGRQYXpTc1ZZTGJ5NHJyUEZTUkV6ZENhUXJWYTE3WW9oNTNoR2ltaFhP?=
 =?utf-8?B?bUpDek10ZjdxVllTUWFlNURvZnhaRVNVSmJuSTdnS0RoSlhiSWJHcjFycjNP?=
 =?utf-8?B?OUR0cG9kNUx1aStHMy9JT0VybklWQkd0TVdyNzAzdy9hRWNDQmRYMHhEVGEr?=
 =?utf-8?B?QS9oQ0lkdEVmZlpQOHBRUnEwRHl0QjlZTk84Y0ZObHdKUjBzUFNPamRxY2U5?=
 =?utf-8?B?b1hTeXVZSWJ2R2RUNWNnR2JSdXhkQlpYVGZuQmZUc2M3Y3VSQnNyQXlxWGh6?=
 =?utf-8?B?ZTdvM0N1RHc3NjRmWFdBY00wa2VodUhidWhzVDZFd3cxaTRaSWZrWVhmVGJu?=
 =?utf-8?B?WHBUa0x1YTl0MUZBQXp2czdnUU02Ull5R2h3dlFucXpvSWcwajBmYmVCTzRS?=
 =?utf-8?B?cEk3NGtMU1E1M2hTYUYwSjVCdzlSZ2pXQzRlaEtKRS8wNExXUXB4V2NQeU95?=
 =?utf-8?B?WWRKWExhVUdQQnY2Rnc4d2x0SnlxaVJxTnplRm0xWWZ6QzQ1TjRnWjVYeFF4?=
 =?utf-8?B?dkpkVUQrOVgyU0VmZ3ozbnd0aXdKM3ZmSmhTbld4QTdrS1ovbHE3bkdXTDlu?=
 =?utf-8?B?L3ljQ3A0ZDF4K01mTUwyZDZlQUJUU3pyRTlqVFA4bkd0NU0wL0UxL2lsMWR1?=
 =?utf-8?B?Ky90R2k5UXJVMHN2WTJ0Y1pCVlUycXdWdzZraWwySUw1aDIxUkVoL1Q5a1BT?=
 =?utf-8?B?Q05XRGpZaVdHaTdZckhjZzJzVkVJdG81Y1UzaU5SblQ2UzR3c0xVWEtRaTBu?=
 =?utf-8?B?RmkzZ3JMczF6OXRDQVV4bXcwTUExR21jcGI4QTZaK0NVYUkvcHpnbmd5TXEy?=
 =?utf-8?B?d2cxbDc2a3VBSFNVSTFqd0krMzhzRTVTaFRkaVdzY1lTVVVnR20rbStYLzdS?=
 =?utf-8?B?RG01U1BoemlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjk5M3Axc3JuQVQ0R0w3WUk2S0o5STlvM21ZbWtOQ3lBWk13Z0xlS3l3OFhP?=
 =?utf-8?B?SVFma2JOaWkrd3JHaXp5ZUo5RGZMa2l3Zis5VHkzSG9EZEViRHQ4ck8rUGNv?=
 =?utf-8?B?dm9KdnRzSUczTmE3ZEtHM1pjaVowQk1ST1BMVHhWQ3FuUEtTK3FQSkRFQ3NQ?=
 =?utf-8?B?ZmxGUzZUd0QwNzhIT1U2bUlrZ2Q2NWRzNmJwRFlhMjdZYXppejNLTkJuc0Zh?=
 =?utf-8?B?NUVjR3d3dTlha0tOdFFHQWtiSlV0dkc3QVFyZ01nTWppNjlSVDhQVTRBQnNV?=
 =?utf-8?B?QWpDeHRJRG4xa2RaWlNnaVlGYUFkRktldU5KNTNTbXBvaVVEV3lnSGJydTBh?=
 =?utf-8?B?MVpSYzFUa3FjR1FUSDFKYnlRVU11R0w1NlpBelQ0UEYvaSsxNUZOVUU2K1pS?=
 =?utf-8?B?cTdZMnJxS0xoTlYwSGRRK3VUQnQwT3BhQ3JneXBRaXpURmdVTGJIcEtoTGgr?=
 =?utf-8?B?QTMySEJwTkxRU2NxVk1laEN3RlhpS2pXeldhZkUwMUYwbDNndUF4L2E5TFhD?=
 =?utf-8?B?NVEydjZOamVoVzFrQ1BOMWN0WmY1a09WUm02YStuMThKanZDSkMxaDhRYith?=
 =?utf-8?B?TDhNSnU5b0JaN2o1Y2FjL1lXRVR3akN0SnZwZENIRmxBeWRNTUViUFV1WjQ1?=
 =?utf-8?B?ckxRRFpCa3hDT1dtU29SellKc3Q2aG1jUTdoTjM2SExIanlrcjVnYzRIV3lF?=
 =?utf-8?B?Z09Ub3FoZDF1d1QvcS9YRWQxN3pmV003dE9qc3VVa29LUVBJZU9nMjhtL09O?=
 =?utf-8?B?Mk51WFNINHpSMTNYTkpxVWhac2dWMmpLbWdiMHRPVC9CNE4veWRUVFFRRjVR?=
 =?utf-8?B?UzF3dU5vdE9HR1RZM1Y4dEZSNjNuaHY1cEQ5SGdHSGxkQ1prbCswa054SmMx?=
 =?utf-8?B?RkhEb3VKeVQvQnpETTh5bVFPeXFHcXR6SFR5UHR0emMrem1GY2YxV29PKzVV?=
 =?utf-8?B?Lzg4MTFIMjhYTGJhNzEvVkZrU3BrUmZ3Y2VWdEJPU2NBTHNkWkhLSXpPdjVJ?=
 =?utf-8?B?bVhYOFJ5dGJXUzV2QU90OXpCd0NpZVFUU2xnYk01dEExbmRsbTJ3Y0wxWEtj?=
 =?utf-8?B?UUZYVWRJNmI1aENMaWZzTGV0QnMvUjM0em1LMkgxTzljL1ZxOEtiRkhsQ2or?=
 =?utf-8?B?WGh3NExXMDJscjIwS1pSVkxBbk9NaHl2UlJqUVVCOXlZSE1CRXV1WHIwUCsr?=
 =?utf-8?B?bUlsSGxRRnBzdWFhbkZwN2R4a0RQRmxqK3ZaNHc5T2JkTzRjS3JLSWdjWnhz?=
 =?utf-8?B?U015YVZJWFJQQ3poSU9QUml2OVdEY1RNdlJoTElhdjdwdThZWDZGL1N0bU1V?=
 =?utf-8?B?SGQ4WTh2TGhSVDZsYk51R0tRUExwVzNwYlZIL3graTJ6bXF6WWp6VnVtSGc3?=
 =?utf-8?B?Z0lmZUd1ZUhFWStibTBIWkhqUjBIYVMzU2llejZOLzduTzFpREdBbnFldGs1?=
 =?utf-8?B?RDcxMTlkYUZFNXdHWXNUUTRsZjBvTEFNZTBKSGNsZkNkWlZHTnVicUVHR3Iz?=
 =?utf-8?B?eXJmMDBGZXFpNWZlM2xVNVd6ZnNoczlIcDJFbklTWU5Gc2tPRE02QU03SndX?=
 =?utf-8?B?bHBXUHpBbk81b0dhVisrUk5GS0JIdlk3UUlKbkxyd09pNUlCdHV3OG9EbExk?=
 =?utf-8?B?SHlNREQ2aU02T0FudFVPcHcwM3JxencrL0tXcjZVVmRZbkVFY2F6ZkdrNkVL?=
 =?utf-8?B?Qk9JWnUrZmNUNFR6RjNlQWppeGVqejdjWlBJdTZlUWpwQUM5VXY1eW5CMW9s?=
 =?utf-8?B?cnpuSGprbEdZNmtZMzEvbXZJeVJJaTF3NXFuWnJuUlNqZm8yK2x0YlI4cklC?=
 =?utf-8?B?azltYWl5Z2VYWEFySXh3dHEvWm5ac1YyM29hajFEdVlnNDU4M0xzaGRKUW1Z?=
 =?utf-8?B?RkxXZnoyeG1DWWxoaTExNEVtVDBVSFp0UTQ4RjdJaEwrWGRtUXR5YU44dGhl?=
 =?utf-8?B?TktiVFJHSGtDSUVpbWxBYjNRWGVsaWwxTEhaZzBGR2wzY2xYaVV1bko3T3Rq?=
 =?utf-8?B?SDRVYlFEZktZVjhDQVlkc1RJYkdNM2ZSU2Y4VkVIVEdEdHpaOE5OVTdWbDVK?=
 =?utf-8?B?eFBmbmdGV01LU2xiUFBkaUpaeXJkekVkQXM0d0VPek9DZ3RESkt3SDcxRGU4?=
 =?utf-8?Q?U3kRzEJm6/R+BdwpN7yOqCcVT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f041a91-3933-422f-f5f8-08dd8f1b242e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 17:01:29.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUrYWwV6rnICmlrVRH83Yh3a/vA2CYp7JENFq4aMZWF+yJfEKJfxxUrdRDhCRZwlDMXoNnThhQZGVQ7OXAarmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923



On 5/8/2025 5:52 PM, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> During platform init, SNP initialization may fail for several reasons,
> such as firmware command failures and incompatible versions. However,
> the KVM capability may continue to advertise support for it.
> 
> The platform may have SNP enabled but if SNP_INIT fails then SNP is
> not supported by KVM.
> 
> During KVM module initialization query the SNP platform status to obtain
> the SNP initialization state and use it as an additional condition to
> determine support for SEV-SNP.
> 
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Pratik R. Sampat <prsampat@amd.com>
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 43 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index ada53f04158c..a6abdb26f877 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2934,6 +2934,32 @@ void __init sev_set_cpu_caps(void)
>  	}
>  }
>  
> +static bool sev_is_snp_initialized(void)

s/sev_is_snp_initialized/is_sev_snp_initalized looks better.

> +{
> +	struct sev_user_data_snp_status *status;
> +	struct sev_data_snp_addr buf;
> +	bool initialized = false;
> +	void *data;
> +	int error;
> +
> +	data = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +	if (!data)
> +		return initialized;
> +
> +	buf.address = __psp_pa(data);
> +	if (sev_do_cmd(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &error))
> +		goto out;
> +
> +	status = (struct sev_user_data_snp_status *)data;
> +	if (status->state)
> +		initialized = true;
> +
> +out:
> +	snp_free_firmware_page(data);
> +
> +	return initialized;
> +}
> +
>  void __init sev_hardware_setup(void)
>  {
>  	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
> @@ -3038,6 +3064,14 @@ void __init sev_hardware_setup(void)
>  	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>  
>  out:
> +	if (sev_enabled) {
> +		init_args.probe = true;
> +		if (sev_platform_init(&init_args))
> +			sev_supported = sev_es_supported = sev_snp_supported = false;
> +		else
> +			sev_snp_supported &= sev_is_snp_initialized();
> +	}
> +
>  	if (boot_cpu_has(X86_FEATURE_SEV))
>  		pr_info("SEV %s (ASIDs %u - %u)\n",
>  			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
> @@ -3064,15 +3098,6 @@ void __init sev_hardware_setup(void)
>  	sev_supported_vmsa_features = 0;
>  	if (sev_es_debug_swap_enabled)
>  		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;

On what kernel version is this patch based on? I do not see the below
diff in 6.15-rc5.

Thanks,
Pavan
> -
> -	if (!sev_enabled)
> -		return;
> -
> -	/*
> -	 * Do both SNP and SEV initialization at KVM module load.
> -	 */
> -	init_args.probe = true;
> -	sev_platform_init(&init_args);
>  }
>  
>  void sev_hardware_unsetup(void)


