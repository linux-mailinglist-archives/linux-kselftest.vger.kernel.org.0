Return-Path: <linux-kselftest+bounces-17213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FDB96D6AB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EE21C231F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 11:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA4B1991D0;
	Thu,  5 Sep 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Lii7ks4N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2088.outbound.protection.outlook.com [40.107.255.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E3F195B37;
	Thu,  5 Sep 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534278; cv=fail; b=QNhAYssUe3aHOEF+uOQPglIfBi2brcPx/SiW3T/2K6d2trepKhG/OLfZKpALEgHbVxf13BRbPRfvgYRLU04q9HbqT9LxhETXL/QeriJGc/E+mkjtYDrM6aurJEW+dtdeoIs5anccSvj3Mum0OLXkyOqmc16MWhAhvpG5GZ4Ab4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534278; c=relaxed/simple;
	bh=Y8cbrZhKDiBbffZt/Sm9VRDP2YyDhSxiAUCxSwZFL7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=i35EPO48ESuDaGf/hIMhPyFPOS8ojGbvOYU8x9y0NFQrhQTtrrS6SnXXcmvrK3K3Srr3HBZsR76mJ1Z5nMzalUqtK3NCZEqSb8yWH4HUfPbeCkBWAJ7k4NQWKxkoXFzeRqdXYD0uXEMaRha15wdJUozlWpv7PbzCecPvGEMaQ7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Lii7ks4N; arc=fail smtp.client-ip=40.107.255.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7gymBM4Nz64/vuvmmWcqwXTgG6ujpVGkJQFygAqqt4Y7Ma8KDO5XxTHOK/iYzUDcYTrlpakxhS7lwyBmNF3zVESezsV6wyhTPKpmypo+xLeyGJY7doI6EF/dl95f5l5bzE60IsWluigrpD3rgmOOHcXVLDQiga5w9gxvgxmMeIci0bCj///NgMhx+X8eTJA6T0p9jbSIe+LqEvyq/6ugwDd46WoUkSaOMOnr+buU509SSQ6ACi3HX6T6kRn+7B+NhCEFcMP2OuvUllFu4EOpQnsoqYfy0lpAjWEFR9HidGim3wol7VNvRK/QrvSK9TEQSo2FU/aV7ZFMtQ4ImwFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qekFtgrulpb4pTETi1Bg7MPv7KaVvQTe45XPu1nP9QY=;
 b=GVYT/OI+zBZ33LFNjMIdYYPz3cHhoWWP0G66Dt6asWK+ptPdrKLMxF9yVO0HgEvP+o984adXGqfl/jcew8QWBD9aRA0gha3WoZsiIDI8C5a9gxTS+Ql667zjjHGdUZcDaEjSg7c1ljq2So52ugrL9YNQXoijLGQc+cOqDApzOFLPoJp+SpD+juVfrDkcBp9QL2/nCQsS2zN//sMBjQAWlAESSSQXyCnz1EfbPpCe0nvyuY2A+BuLLPw8/P1R+RLYH7wGWqPK1LKL6FLddRAiLPL9CI+w5axgP+1ztNRAqrEqKpqzukhwIy0nClsa5uaQbKKzfaZG4tdmecregqPMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qekFtgrulpb4pTETi1Bg7MPv7KaVvQTe45XPu1nP9QY=;
 b=Lii7ks4Ng+JbUR8RogCHVFHKz2hqAm0Ppd3a8fYLwsG+B7VM4pyPfJDeQMPjJsomScS7YOGoNuVHGZf0+yoPjuQ+6YW/rg5NdyXu1L1H9wpf4TNif37PdNrEEqES/Cm+j47L8Kk56Cs59tiDYuywAvs9PZxq7zAw/DxzQn3ipr7DPSdvfGrN86WjsGDuYm6lu0oYlEleOqjqmmSoB5MJHPZ68hu8N4OAR6Zuu0QxV46fvxr2yiF++VaR84s8pFNP+MeOWssfe/a6xmfusqhhLludXpPcWLHi/NI0RPCa+Fee7rWxdN0qpI7JjRr7keCJb0jffy/iXGGkn1i9SK/4Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by SEZPR06MB6138.apcprd06.prod.outlook.com (2603:1096:101:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 11:04:26 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%7]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 11:04:26 +0000
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
	Jordan Rome <linux@jordanrome.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Geliang Tang <geliang@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Hou Tao <houtao1@huawei.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v1 1/3] selftests/bpf: fix some typos in selftests
Date: Thu,  5 Sep 2024 19:03:05 +0800
Message-Id: <20240905110354.3274546-1-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|SEZPR06MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: f4111582-3870-412a-9436-08dccd9a817c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTh4ck9wWnBuVFFyc0ZjL2Z5YzMzNVZxbURhZExDQ0pRb0htWTlVaVRNbnRU?=
 =?utf-8?B?SkRpSyttZkpjaTlyb2hiOFVldmk0REhUVW1TNElyRUlQS1R2Rm82OWlUU1Av?=
 =?utf-8?B?enhyVDNWdmozTWlzWCttTjE1UHVzRlZQR1krOXJGMklteEp3L2JUOWwyaGtM?=
 =?utf-8?B?bVBxSWx3aHY5V2s1cm5SRzM5Wjh1K0NqZHlNeDlDaEdTcGV3dWd3Z1dpcElx?=
 =?utf-8?B?KzVUYm83N292S1VaQ0Z3dStlbUR6cnREeFZYZFkrRmFpSkhDV2Jlb1drUU9O?=
 =?utf-8?B?cVIvc3E1SlRGNnR3RkZwYjEvdFhnYkFJcXpqb1JWUHVCN1RsZEN4ODdZNWFv?=
 =?utf-8?B?S21oMVdrQnNQakVEaG5yM0FFQnh4dUxKaEV5YWp2ZmlPTEtDdmw0c2d1dkJp?=
 =?utf-8?B?cEd5bjNJMjRzVE9zVm16Z2x4WTVMa2ppOXYvQjh4cHBTMk95YWN6SjJlejZq?=
 =?utf-8?B?VFhxUldUdXdnYlFGWmlGNXV1U3o1bWlPaUtmc3FKZi9SL0w2Vk0vRE15SXJx?=
 =?utf-8?B?OUZHVWtnbCtRRUc1am5EZFlzNXRpLy9xdkFrU1dMSTZLRlEyYmErZjFUY0lR?=
 =?utf-8?B?TEkxUnk3R2huMG0ySktIaUovRmRoQ1NpbXVORWxGZUhnTGROZXRxOHcyNXhW?=
 =?utf-8?B?Z0ozdEZrNnAwb1Mza0w2bWV4UWFWa2F2RnAxenFQUnk3K0MyTmw2N0Z5c2k1?=
 =?utf-8?B?bTBjRmVjSVBLV0R3RTVPVlhBZGNucnR6dThERVczQ2E3d1NuSE1tYUFldlBT?=
 =?utf-8?B?bk4vSXdzTlBTYzlXNXZvamdCR0RBT0haNERnelBzRHpGL2NGUzRwa0dSa3Rr?=
 =?utf-8?B?VmxPcnJvNThyTWZFeVFnaVVrOWZESXBFUkNLVmpWMlpMVHFwN3BWSDdxYVcz?=
 =?utf-8?B?OHhwdG96U2FFRUQ0UnBaQnpxRE1JcDZaUU9senFiQjB1QUxPMUxvQndOcjRy?=
 =?utf-8?B?UHpJTE1uZXFpa0t6aHhEZkVabnI4Zk1ZR3k0b1FHMzcySmYvc3VlYTdBVXMr?=
 =?utf-8?B?Z1UzSFh0TGhsYnZwbEhqalR0T0gzeWtHcmxPMlpOWlo5VWZ3WWdESGlwSEdX?=
 =?utf-8?B?VHZpVXNBajg0ME01SmRKb0VENStjZ1lsRkNkTk9kUTROU0x2a3dsZ015bmRu?=
 =?utf-8?B?cEFtdjF4czkxTk9IWGltUXFzZmFTSVRsYWZJT3hhVnBvMzNVSHhoV2hjVzU4?=
 =?utf-8?B?ZE5UTy9oSFhkRTNBSVJocWZGdldHalNyMUY2Wmo4YnZqQlk4Y2M3enlHTlpT?=
 =?utf-8?B?VTI2NS94NnM2akdNQ09RK1hFTFd5M2U5TUs4bmZsUUZJcDlvM2dDcTVScnpz?=
 =?utf-8?B?RlBPdmtXWjFLNXI0ai9zb3hVM1JQcExCUXpZQWpvMjB3NlR3b2lqUjF0ck1L?=
 =?utf-8?B?enFTRUtiRi9XU1dGZDFKNkkyckszV2tvR01aeDVEWGJkTkZxUGEvdFV6b3pB?=
 =?utf-8?B?QkY4YzcrcnhHM0lQZzJPRGUvOERuWERaQTk0d09CMS9nN21oOEtkby8vZDJ6?=
 =?utf-8?B?dW1zWjR5eUpNWTIwRmNNY0RmQWhxajlTMnROMjZ3U0lMT2ZXd3h3NmprazJ1?=
 =?utf-8?B?WU54Vk9XbXpGR0dsdC9Nc2NiYzB0Z0w4cU9JdlVVU1hsZUVtd3ZsUS9RQWRu?=
 =?utf-8?B?Sk1WRlB1R0pWcjAvSW8yZGdNaU0rK25BNWFyT2dMSkdkOVhPa1N4ZE5WVDRJ?=
 =?utf-8?B?V3ByVGZHREpiNVFZSHhMMjVRRDFYamZmNzVXWjJubmpPWmRtS0ZzOVVCL0J2?=
 =?utf-8?B?a2ZIL0w2K1dyVUhqczU0eFBIY3pjQzRVZUZBYXR2ak1VSkpwYjY5R25mV2VF?=
 =?utf-8?B?THdJZnJpd2lhdGlLZEROSXBLY3NUZXJ6Umo4UVRhYVdtNmpvbzdBTUN3Nlds?=
 =?utf-8?B?bUVlRE9pQWdnc2V0V3diVFZGWjgwLzRUZXlmTjJXZm95bWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZytUTHpRSHJFOTFybjIwZDZOTjB3Rks5Y0M3QmMvSlpQY3VoS21PcWlLajd0?=
 =?utf-8?B?N21ZVlk4WG5uRDg1SU01Z1d4NGFuT2UxQ2loUjhtOEc5ejdPSTRQQi92Qm1z?=
 =?utf-8?B?eTh3b1RtZWpGQjlBU1hFSjJTL01UQkJ4ZDVaT3d5ekxSc3pXZzFkcUhyRGEz?=
 =?utf-8?B?ckZxNzZGNlBsWmw0Qk1ZcER3eVFTaXZMY2FnMjBMSUp2L083MzRLVHN0a2w2?=
 =?utf-8?B?b0QvdllURkxxMUNDY0ZaMGs2QUI3NzhBdDA1b1dncjFaZFlWd2V0VEMwQ090?=
 =?utf-8?B?WUZzai9keFErSjhnSUR2cXR5QWpZaHRKYUY0WWpsM09nS2lYRG1CM01VS1lF?=
 =?utf-8?B?Rk02QjhhaTJKeHEzd2NEakgrOXlEYmtGN1NtNUxPT2tHYXQ0QVNLNGJmLzB4?=
 =?utf-8?B?RHVxQXV4YUkvd3d0emFGcTVBazRWZmREd295Q2w5bHJiRnQ5dXJYY1JOWXpN?=
 =?utf-8?B?RStubUYxQnlhMVlSa0cxQjBVenJyaG9vT2V3UVFxdnd3NkdDbWw3d3IvRkxE?=
 =?utf-8?B?NW9sUjZ2M1A3cnRxSEN6WjFsWTkrYmE5SlBEVHBwK2JNbTYrMGUwVFYwdDZX?=
 =?utf-8?B?OUh5TkpteFZaNTBVSDNFeUthdFdCc0FYbWJiVTZKak53aCtMU3VKcllMRWZu?=
 =?utf-8?B?R3FJTFVJOGRma2UzUVJNUkxuZCtYZ1M2SnFBVlAwT3JHRWpidzdBcmxVQXZ1?=
 =?utf-8?B?YzBhSUhaQTlPdFBXK0FjOFlDRGlMY2FCSTUrYmwvcFJIQ1N6YUdVVW9yWHdD?=
 =?utf-8?B?dDZDVzlPSHI1VGpFeWtpUThqTTM1aUlRUHcyTkZDd2FFVUZJeXYrS25teWxj?=
 =?utf-8?B?RzltcW1Zb3QrYU52U1dtRzhpdzAxaXhOZkdNTEdlYm1IS2lGVUZJc2xNQyto?=
 =?utf-8?B?V1ZheVBidW9kYm5pR2FBc3FwNEdwTjUvZWtTaVNMMmk2SFdaOFYxejVFd3N5?=
 =?utf-8?B?UTZwOFo4TUxWaktPYVB4MGRVcVkvM2tOYnBjUFJ5T3E4TGxrR0lWM3cxWUZs?=
 =?utf-8?B?R0pNUHN1RlNabFRGbGhHYzk1c2ZXWHl0TUV6bFdza2M5RDdGNzhPdkhVYlF0?=
 =?utf-8?B?cEhvRngrZFNrNXBWRFB3RW03V1l2b0JDY1hrTUdqV2t5WlBBRmNoSkRsNzE5?=
 =?utf-8?B?NlI4ZjdFVFUrRXlycGQ1S1ZXaFNCSWh1clRsLzN2MENpOGxLaStDNzY2YlA4?=
 =?utf-8?B?WjF0cjNUbnB0M0QrYklBNjlVQ0pIY093Z0FkcjFzVnBMK1dPK1l2WXBHZ1Vh?=
 =?utf-8?B?Rmd0cHQ5Y3hRYjBJdHR3SEhNNzJLYWJjU3FLMkt4RVMrMGNBZnNOekpwbEdh?=
 =?utf-8?B?TzNDMTdBU1FtYUQyZStaWlFiRkNGeCsvZFNLWnZ0MERUeE82eWJESUVINDhy?=
 =?utf-8?B?TFMrZEhGSGVnRjA1ak15aEJaVGp6UkFLTjVRQ2NmNHljNm8rS1JYK2QwTFY1?=
 =?utf-8?B?L0VzNEJPM0NRdGNJcGc1N1ZKNHVZTWJ1S0daMzU4S1d0MW5RRjhIYWJ6Smts?=
 =?utf-8?B?N1MzUWVNWkNUZ0NMWkcxU3B1N012NVo1bXh3UTd0RlIxU1hDTWNrelFJUzlt?=
 =?utf-8?B?amtoWGpHQVU0UjJRUFBVaC9XQzBVWmx0SUdrSXNLY0hLUFRFZWpvWmp4alVt?=
 =?utf-8?B?YzNWUTArSlVVS204SmRCb3ZoMng3cFlTWTdVdG9ZeU03Q096aHJrT2hyc0F3?=
 =?utf-8?B?YkE3NUE4TWR0TEt5K0NFVGVuL2ZwdzRjd2ZMOXJEakxOZDEvL29vTHBZU3Ji?=
 =?utf-8?B?d3MwS0ZLNHYrTFkzdi85V0llYXNWekRXdEVSblo1dHl4d0d5OC9yS2k0K1gv?=
 =?utf-8?B?Q2J3NDl3R2ZvYXRXUCtLYW1BS0dpVTFHYkI0V2tmUnVsREhHM0NxViszM2RF?=
 =?utf-8?B?bzFQM3ppV3lKdStOL3gyckFXcTRnZTdZajQ4eURHM1RwWHFNemw2ako3UFdG?=
 =?utf-8?B?bWd1L2JtWGxYWmFzOExqR2Q2YjcrOFB5OTFVYkdxMCswR1U0NVV1OG5wZGVM?=
 =?utf-8?B?dFU1bEpidThwRjZERXpOVy83V0R3VFk1MUE2c3BGVDJYbTJKMmtZam8zeEFt?=
 =?utf-8?B?b1hCN3FQRXpDV0VSeUROZjlRTWFXdEJIcEdhbFJzdEUwaGQ5WERXSzlrKzZ3?=
 =?utf-8?Q?u6dkUZzUb0JIaCyD1Ee6VpH7W?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4111582-3870-412a-9436-08dccd9a817c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 11:04:26.2628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awf34xJx8xEBZ4TPEpFUOYr+iijc6Cl5sjXxTg0VaI52V4R8QsJ8+G89/ArFsta703sJlqU5RG0UBXRwCWFnvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6138

Hi, fix some spelling errors in selftest, the details are as follows:

-in the codes:
	test_bpf_sk_stoarge_map_iter_fd(void)
		->test_bpf_sk_storage_map_iter_fd(void)
	load BTF from btf_data.o->load BTF from btf_data.bpf.o

-in the code comments:
	preample->preamble
	multi-contollers->multi-controllers
	errono->errno
	unsighed/unsinged->unsigned
	egree->egress
	shoud->should
	regsiter->register
	assummed->assumed
	conditiona->conditional
	rougly->roughly
	timetamp->timestamp
	ingores->ignores
	null-termainted->null-terminated
	slepable->sleepable
	implemenation->implementation
	veriables->variables
	timetamps->timestamps
	substitue a costant->substitute a constant
	secton->section
	unreferened->unreferenced
	verifer->verifier
	libppf->libbpf
...

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 tools/testing/selftests/bpf/benchs/bench_trigger.c |  2 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       |  2 +-
 .../selftests/bpf/map_tests/htab_map_batch_ops.c   |  2 +-
 .../bpf/map_tests/lpm_trie_map_batch_ops.c         |  2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |  4 ++--
 tools/testing/selftests/bpf/prog_tests/btf.c       |  6 +++---
 .../selftests/bpf/prog_tests/cg_storage_multi.c    |  2 +-
 tools/testing/selftests/bpf/prog_tests/log_buf.c   |  4 ++--
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 14 +++++++-------
 .../selftests/bpf/prog_tests/resolve_btfids.c      |  2 +-
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |  2 +-
 .../selftests/bpf/prog_tests/test_bprm_opts.c      |  2 +-
 .../selftests/bpf/prog_tests/test_strncmp.c        |  2 +-
 tools/testing/selftests/bpf/prog_tests/token.c     |  4 ++--
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   |  2 +-
 .../selftests/bpf/prog_tests/user_ringbuf.c        |  2 +-
 tools/testing/selftests/bpf/progs/bpf_cubic.c      |  6 +++---
 tools/testing/selftests/bpf/progs/strobemeta.h     |  4 ++--
 .../selftests/bpf/progs/test_cls_redirect_dynptr.c |  2 +-
 .../selftests/bpf/progs/test_core_read_macros.c    |  2 +-
 .../selftests/bpf/progs/test_global_func15.c       |  2 +-
 .../selftests/bpf/progs/test_global_map_resize.c   |  2 +-
 tools/testing/selftests/bpf/test_maps.c            |  2 +-
 tools/testing/selftests/bpf/test_progs.c           |  2 +-
 tools/testing/selftests/bpf/verifier/map_kptr.c    |  2 +-
 25 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index a220545a3238..2ed0ef6f21ee 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -276,7 +276,7 @@ static void trigger_rawtp_setup(void)
  * instructions. So use two different targets, one of which starts with nop
  * and another doesn't.
  *
- * GCC doesn't generate stack setup preample for these functions due to them
+ * GCC doesn't generate stack setup preamble for these functions due to them
  * having no input arguments and doing nothing in the body.
  */
 __nocf_check __weak void uprobe_target_nop(void)
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 23bb9a9e6a7d..e4535451322e 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -644,7 +644,7 @@ unsigned long long get_classid_cgroup_id(void)
 /**
  * get_cgroup1_hierarchy_id - Retrieves the ID of a cgroup1 hierarchy from the cgroup1 subsys name.
  * @subsys_name: The cgroup1 subsys name, which can be retrieved from /proc/self/cgroup. It can be
- * a named cgroup like "name=systemd", a controller name like "net_cls", or multi-contollers like
+ * a named cgroup like "name=systemd", a controller name like "net_cls", or multi-controllers like
  * "net_cls,net_prio".
  */
 int get_cgroup1_hierarchy_id(const char *subsys_name)
diff --git a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
index 1230ccf90128..5da493b94ae2 100644
--- a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
@@ -197,7 +197,7 @@ void __test_map_lookup_and_delete_batch(bool is_pcpu)
 		CHECK(total != max_entries, "delete with steps",
 		      "total = %u, max_entries = %u\n", total, max_entries);
 
-		/* check map is empty, errono == ENOENT */
+		/* check map is empty, errno == ENOENT */
 		err = bpf_map_get_next_key(map_fd, NULL, &key);
 		CHECK(!err || errno != ENOENT, "bpf_map_get_next_key()",
 		      "error: %s\n", strerror(errno));
diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
index b66d56ddb7ef..fe3e19f96244 100644
--- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
@@ -135,7 +135,7 @@ void test_lpm_trie_map_batch_ops(void)
 		CHECK(total != max_entries, "delete with steps",
 		      "total = %u, max_entries = %u\n", total, max_entries);
 
-		/* check map is empty, errono == ENOENT */
+		/* check map is empty, errno == ENOENT */
 		err = bpf_map_get_next_key(map_fd, NULL, &key);
 		CHECK(!err || errno != ENOENT, "bpf_map_get_next_key()",
 		      "error: %s\n", strerror(errno));
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 618af9dfae9b..52e6f7570475 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1218,7 +1218,7 @@ static void test_bpf_sk_storage_get(void)
 	bpf_iter_bpf_sk_storage_helpers__destroy(skel);
 }
 
-static void test_bpf_sk_stoarge_map_iter_fd(void)
+static void test_bpf_sk_storage_map_iter_fd(void)
 {
 	struct bpf_iter_bpf_sk_storage_map *skel;
 
@@ -1693,7 +1693,7 @@ void test_bpf_iter(void)
 	if (test__start_subtest("bpf_sk_storage_map"))
 		test_bpf_sk_storage_map();
 	if (test__start_subtest("bpf_sk_storage_map_iter_fd"))
-		test_bpf_sk_stoarge_map_iter_fd();
+		test_bpf_sk_storage_map_iter_fd();
 	if (test__start_subtest("bpf_sk_storage_delete"))
 		test_bpf_sk_storage_delete();
 	if (test__start_subtest("bpf_sk_storage_get"))
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 00965a6e83bb..7eafcf91b02e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4986,7 +4986,7 @@ struct pprint_mapv_int128 {
 static struct btf_raw_test pprint_test_template[] = {
 {
 	.raw_types = {
-		/* unsighed char */			/* [1] */
+		/* unsigned char */			/* [1] */
 		BTF_TYPE_INT_ENC(NAME_TBD, 0, 0, 8, 1),
 		/* unsigned short */			/* [2] */
 		BTF_TYPE_INT_ENC(NAME_TBD, 0, 0, 16, 2),
@@ -5053,7 +5053,7 @@ static struct btf_raw_test pprint_test_template[] = {
 	 * be encoded with kind_flag set.
 	 */
 	.raw_types = {
-		/* unsighed char */			/* [1] */
+		/* unsigned char */			/* [1] */
 		BTF_TYPE_INT_ENC(NAME_TBD, 0, 0, 8, 1),
 		/* unsigned short */			/* [2] */
 		BTF_TYPE_INT_ENC(NAME_TBD, 0, 0, 16, 2),
@@ -5120,7 +5120,7 @@ static struct btf_raw_test pprint_test_template[] = {
 	 * will have both int and enum types.
 	 */
 	.raw_types = {
-		/* unsighed char */			/* [1] */
+		/* unsigned char */			/* [1] */
 		BTF_TYPE_INT_ENC(NAME_TBD, 0, 0, 8, 1),
 		/* unsigned short */			/* [2] */
 		BTF_TYPE_INT_ENC(NAME_TBD, 0, 0, 16, 2),
diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 63ee892bc757..10224f845568 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -214,7 +214,7 @@ static void test_isolated(int parent_cgroup_fd, int child_cgroup_fd)
 	/* Attach to parent and child cgroup, trigger packet from child.
 	 * Assert that there is six additional runs, parent cgroup egresses and
 	 * ingress, child cgroup egresses and ingress.
-	 * Assert that egree and ingress storages are separate.
+	 * Assert that egress and ingress storages are separate.
 	 */
 	child_egress1_link = bpf_program__attach_cgroup(obj->progs.egress1,
 							child_cgroup_fd);
diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
index 0f7ea4d7d9f6..6c1f3c73ae6a 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -159,7 +159,7 @@ static void bpf_prog_load_log_buf(void)
 	opts.log_buf = log_buf;
 	opts.log_size = log_buf_sz;
 
-	/* with log_level == 0 log_buf shoud stay empty for good prog */
+	/* with log_level == 0 log_buf should stay empty for good prog */
 	log_buf[0] = '\0';
 	opts.log_level = 0;
 	fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "good_prog", "GPL",
@@ -221,7 +221,7 @@ static void bpf_btf_load_log_buf(void)
 	opts.log_buf = log_buf;
 	opts.log_size = log_buf_sz;
 
-	/* with log_level == 0 log_buf shoud stay empty for good BTF */
+	/* with log_level == 0 log_buf should stay empty for good BTF */
 	log_buf[0] = '\0';
 	opts.log_level = 0;
 	fd = bpf_btf_load(raw_btf_data, raw_btf_size, &opts);
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 467027236d30..39d42271cc46 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -503,7 +503,7 @@ static const char *op_str(enum op op)
 
 /* Can register with range [x.a, x.b] *EVER* satisfy
  * OP (<, <=, >, >=, ==, !=) relation to
- * a regsiter with range [y.a, y.b]
+ * a register with range [y.a, y.b]
  * _in *num_t* domain_
  */
 static bool range_canbe_op(enum num_t t, struct range x, struct range y, enum op op)
@@ -532,7 +532,7 @@ static bool range_canbe_op(enum num_t t, struct range x, struct range y, enum op
 
 /* Does register with range [x.a, x.b] *ALWAYS* satisfy
  * OP (<, <=, >, >=, ==, !=) relation to
- * a regsiter with range [y.a, y.b]
+ * a register with range [y.a, y.b]
  * _in *num_t* domain_
  */
 static bool range_always_op(enum num_t t, struct range x, struct range y, enum op op)
@@ -543,7 +543,7 @@ static bool range_always_op(enum num_t t, struct range x, struct range y, enum o
 
 /* Does register with range [x.a, x.b] *NEVER* satisfy
  * OP (<, <=, >, >=, ==, !=) relation to
- * a regsiter with range [y.a, y.b]
+ * a register with range [y.a, y.b]
  * _in *num_t* domain_
  */
 static bool range_never_op(enum num_t t, struct range x, struct range y, enum op op)
@@ -1018,11 +1018,11 @@ static int parse_reg_state(const char *s, struct reg_state *reg)
 	 *     - umin=%llu, if missing, assumed 0;
 	 *     - umax=%llu, if missing, assumed U64_MAX;
 	 *     - smin=%lld, if missing, assumed S64_MIN;
-	 *     - smax=%lld, if missing, assummed S64_MAX;
+	 *     - smax=%lld, if missing, assumed S64_MAX;
 	 *     - umin32=%d, if missing, assumed 0;
 	 *     - umax32=%d, if missing, assumed U32_MAX;
 	 *     - smin32=%d, if missing, assumed S32_MIN;
-	 *     - smax32=%d, if missing, assummed S32_MAX;
+	 *     - smax32=%d, if missing, assumed S32_MAX;
 	 *     - var_off=(%#llx; %#llx), tnum part, we don't care about it.
 	 *
 	 * If some of the values are equal, they will be grouped (but min/max
@@ -1884,7 +1884,7 @@ static void validate_gen_range_vs_range(enum num_t init_t, enum num_t cond_t)
  * envvar is not set, this test is skipped during test_progs testing.
  *
  * We split this up into smaller subsets based on initialization and
- * conditiona numeric domains to get an easy parallelization with test_progs'
+ * conditional numeric domains to get an easy parallelization with test_progs'
  * -j argument.
  */
 
@@ -1938,7 +1938,7 @@ static u64 rand_u64()
 {
 	/* RAND_MAX is guaranteed to be at least 1<<15, but in practice it
 	 * seems to be 1<<31, so we need to call it thrice to get full u64;
-	 * we'll use rougly equal split: 22 + 21 + 21 bits
+	 * we'll use roughly equal split: 22 + 21 + 21 bits
 	 */
 	return ((u64)random() << 42) |
 	       (((u64)random() & RAND_21BIT_MASK) << 21) |
diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index f81d08d429a2..51544372f52e 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -103,7 +103,7 @@ static int resolve_symbols(void)
 
 	btf = btf__parse_elf("btf_data.bpf.o", NULL);
 	if (CHECK(libbpf_get_error(btf), "resolve",
-		  "Failed to load BTF from btf_data.o\n"))
+		  "Failed to load BTF from btf_data.bpf.o\n"))
 		return -1;
 
 	nr = btf__type_cnt(btf);
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 974f9d6269c9..c85798966aec 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -872,7 +872,7 @@ static void test_tcp_dtime(struct test_tc_dtime *skel, int family, bool bpf_fwd)
 	test_inet_dtime(family, SOCK_STREAM, addr, 50000 + t);
 
 	/* fwdns_prio100 prog does not read delivery_time_type, so
-	 * kernel puts the (rcv) timetamp in __sk_buff->tstamp
+	 * kernel puts the (rcv) timestamp in __sk_buff->tstamp
 	 */
 	ASSERT_EQ(dtimes[INGRESS_FWDNS_P100], 0,
 		  dtime_cnt_str(t, INGRESS_FWDNS_P100));
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
index a0054019e677..9c0200c132d9 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
@@ -51,7 +51,7 @@ static int run_set_secureexec(int map_fd, int secureexec)
 			exit(ret);
 
 		/* If the binary is executed with securexec=1, the dynamic
-		 * loader ingores and unsets certain variables like LD_PRELOAD,
+		 * loader ignores and unsets certain variables like LD_PRELOAD,
 		 * TMPDIR etc. TMPDIR is used here to simplify the example, as
 		 * LD_PRELOAD requires a real .so file.
 		 *
diff --git a/tools/testing/selftests/bpf/prog_tests/test_strncmp.c b/tools/testing/selftests/bpf/prog_tests/test_strncmp.c
index 7ddd6615b7e7..baceb0de9d49 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_strncmp.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_strncmp.c
@@ -72,7 +72,7 @@ static void test_strncmp_ret(void)
 	got = trigger_strncmp(skel);
 	ASSERT_EQ(got, 0, "strncmp: same str");
 
-	/* Not-null-termainted string  */
+	/* Not-null-terminated string  */
 	memcpy(skel->bss->str, skel->rodata->target, sizeof(skel->bss->str));
 	skel->bss->str[sizeof(skel->bss->str) - 1] = 'A';
 	got = trigger_strncmp(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index fc4a175d8d76..fe86e4fdb89c 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -867,7 +867,7 @@ static int userns_obj_priv_implicit_token(int mnt_fd, struct token_lsm *lsm_skel
 	}
 	unsetenv(TOKEN_ENVVAR);
 
-	/* now the same struct_ops skeleton should succeed thanks to libppf
+	/* now the same struct_ops skeleton should succeed thanks to libbpf
 	 * creating BPF token from /sys/fs/bpf mount point
 	 */
 	skel = dummy_st_ops_success__open_and_load();
@@ -929,7 +929,7 @@ static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *l
 	if (!ASSERT_OK(err, "setenv_token_path"))
 		goto err_out;
 
-	/* now the same struct_ops skeleton should succeed thanks to libppf
+	/* now the same struct_ops skeleton should succeed thanks to libbpf
 	 * creating BPF token from custom mount point
 	 */
 	skel = dummy_st_ops_success__open_and_load();
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index acb62675ff65..dad9e3736e04 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -199,7 +199,7 @@ static void uprobe_multi_test_run(struct uprobe_multi *skel, struct child *child
 
 	/*
 	 * There are 2 entry and 2 exit probe called for each uprobe_multi_func_[123]
-	 * function and each slepable probe (6) increments uprobe_multi_sleep_result.
+	 * function and each sleepable probe (6) increments uprobe_multi_sleep_result.
 	 */
 	ASSERT_EQ(skel->bss->uprobe_multi_func_1_result, 2, "uprobe_multi_func_1_result");
 	ASSERT_EQ(skel->bss->uprobe_multi_func_2_result, 2, "uprobe_multi_func_2_result");
diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index dfff6feac12c..d424e7ecbd12 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -643,7 +643,7 @@ static void test_user_ringbuf_blocking_reserve(void)
 	if (!ASSERT_EQ(err, 0, "deferred_kick_thread\n"))
 		goto cleanup;
 
-	/* After spawning another thread that asychronously kicks the kernel to
+	/* After spawning another thread that asynchronously kicks the kernel to
 	 * drain the messages, we're able to block and successfully get a
 	 * sample once we receive an event notification.
 	 */
diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cubic.c
index d665b8a15cc4..f089faa97ae6 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-/* WARNING: This implemenation is not necessarily the same
+/* WARNING: This implementation is not necessarily the same
  * as the tcp_cubic.c.  The purpose is mainly for testing
  * the kernel BPF logic.
  *
@@ -314,7 +314,7 @@ static void bictcp_update(struct bpf_bictcp *ca, __u32 cwnd, __u32 acked)
 	 * (so time^3 is done by using 64 bit)
 	 * and without the support of division of 64bit numbers
 	 * (so all divisions are done by using 32 bit)
-	 *  also NOTE the unit of those veriables
+	 *  also NOTE the unit of those variables
 	 *	  time  = (t - K) / 2^bictcp_HZ
 	 *	  c = bic_scale >> 10
 	 * rtt  = (srtt >> 3) / HZ
@@ -507,7 +507,7 @@ void BPF_PROG(bpf_cubic_acked, struct sock *sk, const struct ack_sample *sample)
 	__u32 delay;
 
 	bpf_cubic_acked_called = 1;
-	/* Some calls are for duplicates without timetamps */
+	/* Some calls are for duplicates without timestamps */
 	if (sample->rtt_us < 0)
 		return;
 
diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index f74459eead26..a5c74d31a244 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -373,7 +373,7 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
 	len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN, value->ptr);
 	/*
 	 * if bpf_probe_read_user_str returns error (<0), due to casting to
-	 * unsinged int, it will become big number, so next check is
+	 * unsigned int, it will become big number, so next check is
 	 * sufficient to check for errors AND prove to BPF verifier, that
 	 * bpf_probe_read_user_str won't return anything bigger than
 	 * STROBE_MAX_STR_LEN
@@ -557,7 +557,7 @@ static void *read_strobe_meta(struct task_struct *task,
 		return NULL;
 
 	payload_off = ctx.payload_off;
-	/* this should not really happen, here only to satisfy verifer */
+	/* this should not really happen, here only to satisfy verifier */
 	if (payload_off > sizeof(data->payload))
 		payload_off = sizeof(data->payload);
 #else
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
index da54c09e9a15..464515b824b9 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
@@ -503,7 +503,7 @@ static ret_t get_next_hop(struct bpf_dynptr *dynptr, __u64 *offset, encap_header
  *
  *    fill_tuple(&t, foo, sizeof(struct iphdr), 123, 321)
  *
- * clang will substitue a costant for sizeof, which allows the verifier
+ * clang will substitute a constant for sizeof, which allows the verifier
  * to track it's value. Based on this, it can figure out the constant
  * return value, and calling code works while still being "generic" to
  * IPv4 and IPv6.
diff --git a/tools/testing/selftests/bpf/progs/test_core_read_macros.c b/tools/testing/selftests/bpf/progs/test_core_read_macros.c
index fd54caa17319..873d85a4739b 100644
--- a/tools/testing/selftests/bpf/progs/test_core_read_macros.c
+++ b/tools/testing/selftests/bpf/progs/test_core_read_macros.c
@@ -36,7 +36,7 @@ int handler(void *ctx)
 		return 0;
 
 	/* next pointers for kernel address space have to be initialized from
-	 * BPF side, user-space mmaped addresses are stil user-space addresses
+	 * BPF side, user-space mmaped addresses are still user-space addresses
 	 */
 	k_probe_in.next = &k_probe_in;
 	__builtin_preserve_access_index(({k_core_in.next = &k_core_in;}));
diff --git a/tools/testing/selftests/bpf/progs/test_global_func15.c b/tools/testing/selftests/bpf/progs/test_global_func15.c
index b4e089d6981d..201cc000b3f4 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func15.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
@@ -44,7 +44,7 @@ __naked int global_func15_tricky_pruning(void)
 		 * case we have a valid 1 stored in R0 register, but in
 		 * a branch case we assign some random value to R0.  So if
 		 * there is something wrong with precision tracking for R0 at
-		 * program exit, we might erronenously prune branch case,
+		 * program exit, we might erroneously prune branch case,
 		 * because R0 in fallthrough case is imprecise (and thus any
 		 * value is valid from POV of verifier is_state_equal() logic)
 		 */
diff --git a/tools/testing/selftests/bpf/progs/test_global_map_resize.c b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
index 714b29c7f8b2..a3f220ba7025 100644
--- a/tools/testing/selftests/bpf/progs/test_global_map_resize.c
+++ b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
@@ -16,7 +16,7 @@ const volatile size_t data_array_len;
 int sum = 0;
 int array[1];
 
-/* custom data secton */
+/* custom data section */
 int my_array[1] SEC(".data.custom");
 
 /* custom data section which should NOT be resizable,
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index dfbab214f4d1..905d5981ace1 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1515,7 +1515,7 @@ static void test_map_parallel(void)
 		       value == key);
 	}
 
-	/* Now let's delete all elemenets in parallel. */
+	/* Now let's delete all elements in parallel. */
 	data[1] = DO_DELETE;
 	run_parallel(TASKS, test_update_delete, data);
 
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 83f390a31681..c7a70e1a1085 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1500,7 +1500,7 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 
 	/*
 	 * We only print error logs summary when there are failed tests and
-	 * verbose mode is not enabled. Otherwise, results may be incosistent.
+	 * verbose mode is not enabled. Otherwise, results may be inconsistent.
 	 *
 	 */
 	if (!verbose() && fail_cnt) {
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index d25c3e9605f1..f420c0312aa0 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -153,7 +153,7 @@
 	.result = REJECT,
 	.errstr = "variable untrusted_ptr_ access var_off=(0x0; 0x7) disallowed",
 },
-/* Tests for unreferened PTR_TO_BTF_ID */
+/* Tests for unreferenced PTR_TO_BTF_ID */
 {
 	"map_kptr: unref: reject btf_struct_ids_match == false",
 	.insns = {
-- 
2.34.1


