Return-Path: <linux-kselftest+bounces-17215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5AD96D6B2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F44F1F26DFF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AF41991CE;
	Thu,  5 Sep 2024 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SIKg8tjG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2079.outbound.protection.outlook.com [40.107.255.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C61991B0;
	Thu,  5 Sep 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534347; cv=fail; b=cQgWc0XGyehKSiFq9hIEsESSfAgPCz3XPwNQH7ylT4guHyQOp5UyNRdSlyl51lrdq9FK0z3pPOEPxTjdIh2AsYBQ6EcsuWiqd0NdI7smAlkI2K/9Qt8hjFMITF7VKeA3kB43836AEowog7ZX+XFFLt5tqHZLJS3kMSqqK+tqEVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534347; c=relaxed/simple;
	bh=UE0hOfGsiJ0HwmUYoGQneBeHFZdsY+xZselb7lCoa5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N/bvyXLZ3fogmSRg6CErN2YDGP65BX26Pp8rAYDkwr0GJ/ZJR0xPIEhQSQ4VnlwylQ4yKuTut5CeeNsRYED9crc5UDb9pDU4FZhm3H4/1qotzmXckMxdWwCd9y9UqmKBHXW7IRlrLIdPrGJ1RrrF4m3AS7NU1h8yYC3MQidngXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SIKg8tjG; arc=fail smtp.client-ip=40.107.255.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuVTTgxyyxluYe1BzQEEHx373b23Yq4k4WcyRhQoBpEi0/Ql/P4E0ulGjnbfYy13S+e/gtdgAItRFCkcYPjGKOjKCI41BwMQR+E1wgtjpk9McQjULUkY+aroqfYN6t6XpNxqtIIj636+I+Kqx8bkSTRG936cUPhzyquh8Wh3LQMbwfhYYSgOHJWPbArBji+jgtWx3Gpuq9lRfXfAAUGxEW4X3Xb6Hd5xJgsSuKrWYJ5KfnYnCsUcT2PBYzrOwPO59/y7W4ViIWqiosQqqbZXlu8bE22+fSotgLcoy8rHcANpOVEEXwWrk+lEIKTJia/d3B40QrtyuoGqBRhJ1dxfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWVBLqv9LI2cNNAZFZTVPo+c8CxN8doYLzH60UehTGA=;
 b=fzid1FpXDHkRIoxdPAk32Jv4azmI3yS/82idSgUjnYN8Nt7laDp3Ug6vRR4l0YnJ2fQmg95saXQwqP5wx66lG1JgPr79JRUg1Qq+jIEL6pOvvTZ6g0nnRP34j8m6/mP5pKoY1qil4ovoovRL8NfX5LyZrJQ/aakIzvbAqhhysk2bAqHlX9igaTAJcKTUs2VMjHMiPyCGu2c80kj+leGLnIjSbW+F/LO7Dfolnq+KctG0K5rpftd8y5lnFTtDm/c0FoHTLN3TGPTo6nwujmlzLpA95+h1AwuyrzDc/bQE4N80jgMn2W49f9pwuhq6BOyBkgtuVT8Ocmjj807FI+Vd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWVBLqv9LI2cNNAZFZTVPo+c8CxN8doYLzH60UehTGA=;
 b=SIKg8tjGw/0XtxqRHi3t76eKWU9M8E5BQpuLu+QMxElrFjFZefyOMnSoZ3tK6QQWkmkLovk1yBbjCiZ7E2oKCurWagMAadV19UgmFyOIP2Ja9MK0d6MWYQUKRSVtBIh+g/iDijsfXMH/8bYIR0JJF38EQQNL+Umn342XZGmNxmBlsEuB5ytGQuNwQlk/CLansPfbaTpHw18JM+HFVEAyDRcgorMkWgCGTRBM059xKlqqM1oQRjZHTgbVVPDrCV2ZLkjDLHGxhqt4dhd+bUt6d7q/Yi6uDpF0Atn7+7051qaM22utNylDbwSZhee956CQFKBrXum8938XY796tp87Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by SEYPR06MB6033.apcprd06.prod.outlook.com (2603:1096:101:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 11:05:39 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%7]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 11:05:39 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: bpf@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	yikai.lin@vivo.com,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Rameez Rehman <rameezrehman408@hotmail.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Jordan Rome <linux@jordanrome.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Geliang Tang <geliang@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v1 2/3] bpftool: fix some typos in bpftool
Date: Thu,  5 Sep 2024 19:03:06 +0800
Message-Id: <20240905110354.3274546-2-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905110354.3274546-1-yikai.lin@vivo.com>
References: <20240905110354.3274546-1-yikai.lin@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To KL1PR0601MB4324.apcprd06.prod.outlook.com
 (2603:1096:820:73::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|SEYPR06MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c68ff6f-a347-4c93-e849-08dccd9aacd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qno4N0JtNVVoL0NXOW02L25qQlQyNStBbUZIRnNIakF5ZVpEZ3MyVGxQRFJM?=
 =?utf-8?B?aUtZZy8xOFcxQlRaMTJiM2dUUWxIZUtwNXlIVTF5N0lKZlpURitTWUFGMnB2?=
 =?utf-8?B?Q0txRnUwODNrYVM4ZitWNmZicXdTS2VnY0cvekVXbmxTdHp3Nm9lUWpCbWJD?=
 =?utf-8?B?d2NVMkV6V0dzYkVZVEVwbERtVXNETjVhQXErNkIwM2dMckE2eStPVnBJaXAr?=
 =?utf-8?B?eC9jY2k3V21PMnRuWFZzeitWNFYvM0NmNXpZTjQrRWNDQlh1WVV5Y0I1NTk2?=
 =?utf-8?B?ZzVJNlBjVmRuSmYwUUpoVklZajc5VVZjN2htbGczcXlrUWVTUnV4SytCV055?=
 =?utf-8?B?QjJYM1Z3blpRSm12Ymh6T2VJU1dtd1luVXpLYkUyRDU2eHBuSXRwZkFYYXVs?=
 =?utf-8?B?VGVXV3FYcDhBd2lza1RSZXUrdjdjc1JhM1FlVno5YlEyRi9TVkNCclpHSkxp?=
 =?utf-8?B?dHF4aGhDazZoZHVqajRkcVNpajdoWkw0djFnMjlwQ0tMbnJzNi9QUktlQU9Q?=
 =?utf-8?B?Q2lob0ZieDU0cVNaTFZ5aGZZOVp4Y0FZV09mSGQxa1hUdDNKUjZ1SlVwMGpF?=
 =?utf-8?B?QlBtelRmbFMzSGE0SXNENExoV2FzWnVjTkw3MUtCRmQ3NFNQSUdKSFhuREFG?=
 =?utf-8?B?SkdjZ1R5SmQ3R3U3RHlRaGxaMytLajRZWndtRzRidi85c1Ewa2VlbnNNdVND?=
 =?utf-8?B?YmhjOUUzQjRWYm01QktNYVhMcEVTVXlkZzF6NjRVWmZIalhuV0tWREx4WTNF?=
 =?utf-8?B?RDgzRmhpM2t2S0g0Q3BxODdZangwcU9Ib2QyWVg3Y01iSWRYVmtmMENZOUpB?=
 =?utf-8?B?ZmpXblRWc2NTVFkrbWV6Z040UE9NamVkZmNLeVp0Zno0RjhxUTN0c2IyYitJ?=
 =?utf-8?B?Um0xcTNpc3JQUEhuT0U5WDhmaXlBd0tkaVJCZlgzVVRxM1hRdHpTSmVaRU0y?=
 =?utf-8?B?aC9IRk1hWDg5bjBNcVg4ZWw2OXBMVk1IdUtEMXZvTk1oazRZNFBwMkt0d2VE?=
 =?utf-8?B?WEpkNEV5RDhpSHI5OFZrN3ZqWjhxWVZXb1RuVXlGVkF2aHlxcUoxTVRXTTcr?=
 =?utf-8?B?K1h4eWwvcWhielJmUmN4TEl3UmVMajVlbTJud0VRSmdzaVRUaTVuaDZOT3BD?=
 =?utf-8?B?SnlaT0NETUppQkVWQ3Y4K2lOWGNQYUJBZ2N0OUMzY1lJUmZWNnM3RWJRemFo?=
 =?utf-8?B?UmJNaVhSR1BKNzhMZ1NPNHJGNGpvaTk0emJJMVd2YXEwcWtwZnhjbXo5a2Zt?=
 =?utf-8?B?c0E2NlZJSFJkNFczTXp4MTVQWTBpZ2V5em9nSVZjUnRlWnBvRG1PSlYxRFdr?=
 =?utf-8?B?UFFHbXFYbHZQNWNtaVRrem4rK1NNRWpMNnhYV3NvQUZJM3JieXBYUFQxNHh1?=
 =?utf-8?B?U3laNHJUbW5HeWttV2twQlhybEFlK3VwVjZ6cERJRVU2NDN0YnRQTHFWSEkv?=
 =?utf-8?B?bi9LOXk2WXNWVlBmTjNPQ0FibmtVWVhBMmtqQm11OUZaSXF5Nzh2a0JhdTdV?=
 =?utf-8?B?eE1ock1LY2NqbGJGWTRYQ3JuRHJwSDRwNUJnV0Mzbk00UWJ6K043dDkyMkwv?=
 =?utf-8?B?d2c3K1ZXalNKMDEyV0RvZ0ZpTWUvK3FJV1pFQWloeTdOZkN6Sk1MSllRZFVE?=
 =?utf-8?B?TnR6WitnZ0dlVWEzMkdTZlYyUkJIVUhPT3FLSHlGNWY3dkUyaDRIbXNkYmFJ?=
 =?utf-8?B?eGJhK1kzczhxMHhYd1Q5UXQvR01OMkJaUzhDMlViOXhzSU40SVV3K2tYU0x4?=
 =?utf-8?B?T1djQlJzL2EwQitCQzdSQzd5TmZxRWptNDcveHJlT1Z5SlFMdmxjNVhaTXkv?=
 =?utf-8?B?Mk5PdmU5YndEbDVTQmRwTERjNEtpejEyaW82RmpsL241N2pkbGYzZjRSZ0pP?=
 =?utf-8?B?M1ZOa3QvbTJURHdtci9NV3prQWwxYlB6TW5FeWZxdmVRK1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emRaaDd6dXE5aEJhcnZ1M3hURFRzTm1xU2FrMU5lSytLQUdhd2pBSTRiRnhE?=
 =?utf-8?B?UDBIOG83cXRkOEVKanhmU2c1em9iTUFydWJjS1RaOTcyOTE0ZGUvVTlxUjNF?=
 =?utf-8?B?ODZrU1dNbXF3c2NPS1RTZGVjaEtPK0FQSkErVEdtVjZXT0tDWCs1dVEwY0pl?=
 =?utf-8?B?U0lKSTVISDFuQmROK0dTMEFzb09KcXVGdFVTTWNlRjZDS095cEExbUFKU2Y2?=
 =?utf-8?B?NGZhd0x3T2luM3UzS1NqSWllcXVic0oyU1RIYngwNVJudXFLWjhZeTZuNlBG?=
 =?utf-8?B?N2NIdjJHSlVYSE9iOXhvMk0wWjZCODFCNHdwdXpXa3paQjROWlR2V2tVaGtm?=
 =?utf-8?B?aEpMYVNsbzBHNERxRDdMQ3l1ZHEwSmJIYm9aTzBnZ3pDNnIxMDZYcEpaTnRS?=
 =?utf-8?B?ckFXWmg0WThMajdWZ0NpNGNLNWF6Um05cnNndnM4V3BaamtQYm5DTVpHVHlz?=
 =?utf-8?B?RGNVQU13ZkcxbFNsU1REL21UbmNvU1l2cDlPQm0wVVhYYk5WVk1ndWw1OEkr?=
 =?utf-8?B?dURJU3QxSWxjcnRYaXJMU0toVHVudkI3VFpCSlVoNFZZbi9qR0N1dTJXSSt1?=
 =?utf-8?B?cCs1Uk9EcStmckxtclh6b2ZyQjhMbFVaT21JNlM1cHFkZVVzWEJFVHhMVml6?=
 =?utf-8?B?T3h4NTExOWRRRzFlYWJvT1VFZkZzc1F4c0dKbk55b2x6Z29ZSkc2OXlVczNN?=
 =?utf-8?B?VWcvTTJXWFg2djRLb2FqaW55TCtZb2MwMFBrQ0FEM2JZemUwZjlHNXdMdWpu?=
 =?utf-8?B?SFRvd2lHU2tFenVtWTB6Zjh0dEp1K29XVzZ5dzhrbE9EQ1BiZEJRUUtRREJt?=
 =?utf-8?B?TVFha3dVeFlnSHNXYUZURHZkSzNDUWwrZi9VUkNFYzY5L1JJRmxxeGVlaFQ5?=
 =?utf-8?B?QWx6ZGZ5azdBdlVKUUFVYjNtVlY2cWZiNzNHclZzN2pjbVFXMHNBVzRUd25J?=
 =?utf-8?B?WGdjVEx3NTJyY2xVUXpoREIwbzlYQjB3cmlmMkd0MlloRllwL0EvYkhlUnZy?=
 =?utf-8?B?c1ZocEpNSHRMa0Vwd29qUFduam8yQXFRa2xIMXRITWJ6bFRwZkw4a0F2SUMv?=
 =?utf-8?B?dzhWUC9MV1A4SHVCZ1ZtTmRKRmZsUzBwaUVEb1pMam04a2phZWsxdVFxTmZl?=
 =?utf-8?B?OWdBSDRBL1dSMDlhbDg1Y280b3hNK29pbTV6MTNYV1hVTVZVaXpsOFJ2SGJi?=
 =?utf-8?B?TGd3dkZYSjF0MnlhQitEcHpmUG5sR3J2djN5OE1zNlJaVDdaWWdXUFNROW0w?=
 =?utf-8?B?Nk1oa0k0Z3pNVlZnaTk3YWFyeWdhdzlvRGVpUVN5ZnoyZzZLV0pGWFRMZjg1?=
 =?utf-8?B?QnJramcyMDRYTjhtTkg4NEY3S1RuRzhzZHVqUFk2WXhydGgrdFZDdW9BZ0pE?=
 =?utf-8?B?UU9kVC9oRGM5UGtxWTBKcVJXRHVDVTF5TzRrc1I2bGNSZ05FbmF4OGpNaG1G?=
 =?utf-8?B?ano3NFRxYW1LQVlKMkFLQ2Z3Z2pZaGo0RDBBWkJmd1Y3V2V0YVJERUhzWWFn?=
 =?utf-8?B?eHZUSXdvQ0tBU2FZVmtVcVg2c3Zwb2Fnc1JFNXVwR3lFbWROa3ZUeTZNRFd1?=
 =?utf-8?B?d0pvL3VYNnhhVUtyZ21vNjBQVFk5RExsbjJoWjdydnVSeFBydFV0c1ArZEVX?=
 =?utf-8?B?Zi93REs4UkVEelNsLzRra0MxZDR3VU9HTndtOXhrR2MrTzNsNWViZkN2dGlQ?=
 =?utf-8?B?UnU1NUZjQXgvdDd6R2pkOGpJUC9sQWh2OXVjajRDTnh2WFdncVJ3bnNBVDVV?=
 =?utf-8?B?cStOQjNtQ1hSRm9IL0FSUnJvWk9zRmtSaVBBUnpxSk5yN1dIblVGVHo4RHRC?=
 =?utf-8?B?d2N0WmlkMWVtY0UxRENvN2h5eERJYzVpNDBOY20rcGR4R0R5WURuWkZvOWlo?=
 =?utf-8?B?OVN6c090eFZqUlFrRmRncGh5U1NoR21xK2dBYmZhQ0FsUXhwMXQ5SjRMQlZV?=
 =?utf-8?B?Q3pka3UxYUhEc1RDb0toeHlWb2dzaVlzaFRaOXJNdzJuVFY3Tnh1dHk2SlhI?=
 =?utf-8?B?S3oyNFRaa2lNeHFxaWFPL0NBRHA2NFJuV3RDMUdiWklaeWJ4NWowOVFDN3Ru?=
 =?utf-8?B?ck8zTGV4VkdRTGYyNTZ1ZWRtTkZpWU04U0ZyZU9pSGYxYVhyQi9GR3N1enph?=
 =?utf-8?Q?NXHeRxuCQBFpmshjU4ro8md7X?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c68ff6f-a347-4c93-e849-08dccd9aacd6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 11:05:39.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWV03yr2V/RxYmGt88kd/PVxtapqZi2q09EnSoXEMWPGtzbrurKvxVyQHGLKDMzsMxDF8kXS6e6MgHLsBnM0Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6033

Hi, fix some spelling errors in bpftool, the details are as follows:

-in file "bpftool-gen.rst"
	libppf->libbpf
-in the code comments:
	ouptut->output

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 tools/bpf/bpftool/Documentation/bpftool-gen.rst |  2 +-
 tools/bpf/bpftool/feature.c                     | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index c768e6d4ae09..1b426e58a7cd 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -104,7 +104,7 @@ bpftool gen skeleton *FILE*
 
     - **example__load**.
       This function creates maps, loads and verifies BPF programs, initializes
-      global data maps. It corresponds to libppf's **bpf_object__load**\ ()
+      global data maps. It corresponds to libbpf's **bpf_object__load**\ ()
       API.
 
     - **example__open_and_load** combines **example__open** and
diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index c754a428c8c6..4dbc4fcdf473 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -196,7 +196,7 @@ static void probe_unprivileged_disabled(void)
 {
 	long res;
 
-	/* No support for C-style ouptut */
+	/* No support for C-style output */
 
 	res = read_procfs("/proc/sys/kernel/unprivileged_bpf_disabled");
 	if (json_output) {
@@ -225,7 +225,7 @@ static void probe_jit_enable(void)
 {
 	long res;
 
-	/* No support for C-style ouptut */
+	/* No support for C-style output */
 
 	res = read_procfs("/proc/sys/net/core/bpf_jit_enable");
 	if (json_output) {
@@ -255,7 +255,7 @@ static void probe_jit_harden(void)
 {
 	long res;
 
-	/* No support for C-style ouptut */
+	/* No support for C-style output */
 
 	res = read_procfs("/proc/sys/net/core/bpf_jit_harden");
 	if (json_output) {
@@ -285,7 +285,7 @@ static void probe_jit_kallsyms(void)
 {
 	long res;
 
-	/* No support for C-style ouptut */
+	/* No support for C-style output */
 
 	res = read_procfs("/proc/sys/net/core/bpf_jit_kallsyms");
 	if (json_output) {
@@ -311,7 +311,7 @@ static void probe_jit_limit(void)
 {
 	long res;
 
-	/* No support for C-style ouptut */
+	/* No support for C-style output */
 
 	res = read_procfs("/proc/sys/net/core/bpf_jit_limit");
 	if (json_output) {
-- 
2.34.1


