Return-Path: <linux-kselftest+bounces-16401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 413B6960C70
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5DAB29257
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A81C4603;
	Tue, 27 Aug 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="c7lZYjKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1091C2DBB;
	Tue, 27 Aug 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766035; cv=fail; b=fjVXDoL24Qv9mOfVUWlyiEZLFddU0dZItyVZyGdcbezsSW7JudIzjk45SWgxs6Orp8b/oJEP/yEH7x9uxnHM7ZF+AGJGYtCkcPdGfz644y9CIZvuI8bUcLCl04RavLCLNKVKrwaKmtA+LLw6hJOPgr34bY4/wtDeEKWCREJWnxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766035; c=relaxed/simple;
	bh=EonApa4sGNEO0js95RLioa48C6VTlbIq67fUhOD3Obo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rh4bfXj5mH2tKQHdhR1uG1SKTFk4QCzars3mhMG8nrr7EtPC3chByIU1ha26aaW1YCuN4n/UeU6iekXed2YcXina5IqtmP3HcfZiv4XEfmOPyWdLqQdJIAJmPghB4eJLGIV87PDoe3vDIeZVufqD+3BCgnklTATjs91k3mrRhdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=c7lZYjKC; arc=fail smtp.client-ip=40.107.255.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJc1ECqmL4WA9Sqg9/uGmewWpTAD3RQ3nbwEMUBYp4PnRgeIZdMjz7/XYhjIgpihLtrTEY5lGFjSxOC9pl5LtvmamcL5rkyBOXwWXAFbFTbmASyiXI4yt2QUKdak8+lBck+Yiq9z8Kno0m1zQJ0Ok2Vfs8DGkvGAqsZ4ysxGQgem1cB3P89hjujkVgCcquvzyeGFp/pqCRUcZCjxj4crg9VFULf5EZD6V5m2Blb3rjS18cbBNjRHmgRaZq+mCaQjxuZlNxwxCGtOqIAA6BiUi40J/3Qf9OIKZSUDcVpvTGeMWSDz/xu++ArBhuyq1jWYqqhLJOXrUUKchKYWZKW8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb5oHwtqeqmk8i0rRE0WhrUdnOtYaSMsDmqTS3V7ES4=;
 b=AfMSZ4wFmhl1ED7qOB2GRsj+lvQ7ooXa0XpMMFLDHCGWQK0Tcqs+pfeylrvK5y+RQuFY5ye57JQV0oCz9KAh0vTY1i2Sp6vP8hMXXkh6mt/OvS039JeoRzSGpWwelB/7b3tEr8D5seQwsimR1LN1/b/Cg+rATkpYteJH5B38JLY5O+ojb2Y1lW8URleMua4eDhq/btGGI+eQMRkxShBPMNopFBukKnuEpugcjwArjSH/YlmeBC0DRmShwMVeYjhJ3rCe/MMsSAbRn/tNOP77c3wrV8G+GetcUfJ+sIZjKJPfoNIqS/jKLFwHyN/l3cRFCBzZj+Skmj91jx8+4tQNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb5oHwtqeqmk8i0rRE0WhrUdnOtYaSMsDmqTS3V7ES4=;
 b=c7lZYjKCXGf3/lyCGT0jM3L93x81j4VpLxvtkyN7J6GQSGZEzSLDT1Qp8uxYW640QWxZ0uZgvbpjr6WYGX6AUbZFmR9/xIDDP5oWTcjGjeej055TgEOprydjs5cN7c4g7U0rN2eba6kuOryn0mEg/5yUeMHx8mfCMLbhTQdvV8PIujgZB1a9Tu0XIcYXFxptC+9YCw8bObprn/SEHhr2MpMO2SSAhuAeibKVd+jhX1nkBfaNeujQSCzE8oFJ7ZGduahZubYKjsdvcEvLtZfJozfZXSkO5hgs9YjCUDuJKq7SmC93JTbDF+O2XMX/rhlDEMVAJORieGBDdMVnRwwfEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by OSQPR06MB7153.apcprd06.prod.outlook.com (2603:1096:604:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 13:40:30 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:40:30 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: Alexei Starovoitov <ast@kernel.org>,
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
	Nick Terrell <terrelln@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	yikai.lin@vivo.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Fix cross-compile issue for some files and a static compile issue for "-lzstd"
Date: Tue, 27 Aug 2024 21:39:59 +0800
Message-Id: <20240827133959.1269178-3-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827133959.1269178-1-yikai.lin@vivo.com>
References: <20240827133959.1269178-1-yikai.lin@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To SEYPR06MB5913.apcprd06.prod.outlook.com
 (2603:1096:101:da::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5913:EE_|OSQPR06MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f006ffe-830f-40cb-200d-08dcc69dd17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PUqyOdGJxHy0kGwyy+3SKfjQiTnp+2z7GrXgzXR5hRYrqj2InEnRpXENAhD8?=
 =?us-ascii?Q?hLTcjiMA6t7EAwq7BG6d1i0cG53sAoO3clpOV5yuUBmYV4mYoAODUz2ZfrcN?=
 =?us-ascii?Q?YRosMO8HsImYLJ2H8WtNo0qJYNLKlGX8uRyZcuqo9aR+1+XUuwjyl0xZlYMM?=
 =?us-ascii?Q?l4BsGuoVLhvj2xT2uChdZq76uWLlrWEvQw+EtZyXDoBE6Ekqmc9PIKIOu5w3?=
 =?us-ascii?Q?APogRkIGqJKQHhIkBxgptMg+kmhK1SWJCuctPHqR7pgtjTeG7TXlqrm6tokU?=
 =?us-ascii?Q?o7t0h3FwNX5BRJu44DRvugPlsQW1PgGi/wIS0zRv6Hb9OvF+ckSI8GPRK2vu?=
 =?us-ascii?Q?ceag5iXMrgspweTeMtuYY0r0ytkqMwgUPQobbj3Qyk9Vcy7ImZRyRjdBde2C?=
 =?us-ascii?Q?0TotJ8Y+hDmk/9Dykjna7yvhVf3l2uRZo8DbLmqeF5AgltpqSYhAYga3Jy/j?=
 =?us-ascii?Q?kV5o+8ruWhLeILWm2Y+5JvgNR27o71xLwbMM4Tqb6uSGjobEdVA/Lk3A771G?=
 =?us-ascii?Q?91ZIxI3UBZLd7kAX/BtV/rQ8W1+dCP1tBslrXlOEIY7uhxc55ca38E8cFyLH?=
 =?us-ascii?Q?TlvwA73yWnvHGSiYeaBAIP1YDZmEzUDLUEgVf9EUQFstWI/fOGwoleHprB7z?=
 =?us-ascii?Q?sgLm5x8Xq+rgv9sd6Eb+qtKd3I16gLfR1CQsdEUa6ajmv9Y9TBwXtbxc5YDx?=
 =?us-ascii?Q?5B5uOdrU7rOGafIgLA4yfdM2/BTO3KklmQxJ7w/QW4Q44YXChw+d2mrIU+96?=
 =?us-ascii?Q?kZSceuc2oMdihz5345sYvdK/je7EZB0mv07KQAdFc7Xa/ShalM6cdYqCZe2j?=
 =?us-ascii?Q?zfSktsaBxuQDPzmTgEatq75g16w70PjXkP6VQYN1LTNibGhSkwQZadyqsOIF?=
 =?us-ascii?Q?HjX3ZySy+4CCkmBnWEq6n4JbcMBNVrzk9mrpRWYmgNO9WbCytk+ajfoPSBYN?=
 =?us-ascii?Q?IDvW6JQyxzF2Me3zsf3U1F50UtR7AyKUGVsnwigqFvCD14du18L0a6gmkZzr?=
 =?us-ascii?Q?2SuL8u8SyUottOniLE+xzAtriR4D5rwVmd8FSLTwMynEkDNtFCdhlUZIrqYF?=
 =?us-ascii?Q?PbCXElHrSKmv6uT9mXoRaMP0Qhs5Z9kBvuUw03k66GszVwDpHQxKMdX39JgX?=
 =?us-ascii?Q?xk2mld+aP6KnWeD0A2afCaFfRMSajCQqwvtaSvIK0UrCF0oHjyR0yA6d22mL?=
 =?us-ascii?Q?GAW7pK+TI13xy05Mod7uYK+qKPAlhA023eaBtal+aeubkxL8nh+mXsJvbWPR?=
 =?us-ascii?Q?gfKyO03nilRFYCmrjgSE91LpCMCrBUVH5E2GS0PuFM7EBOu4HwxrwJ6HV0bo?=
 =?us-ascii?Q?GvpK5GLCHGOqkK7jBw29LuniO0HEBx2crVM2RReizdOQoz3sLmfJegQTSc5N?=
 =?us-ascii?Q?DN6ApdLu8qHwhdb6INUko/lYZhO9PVa/6u5QtNOYDpJSFTXW23ewf6GON/4p?=
 =?us-ascii?Q?yzv+oY1hxV0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tBMMR0+1gIA5QlWCcUR4Qya1QwjZRszzGNq/ggsFk7qC804BdqwgfZkJ6bnz?=
 =?us-ascii?Q?uyqsLqQ5AOHPeb/rpvukHoumL/kLp7sZUqYgv/gO9wpznQYcEND4gRSPoW2J?=
 =?us-ascii?Q?BTmcxxKrTvlF9UzyFIRZxZXeZTjqxtaP5YaSQOn+5qgKVbTttpgh0Fy1Ozb9?=
 =?us-ascii?Q?YlD80QX1rmyengDBQUIXK+l7iRGelVOcrOl98g16+pyLhFDGHm5TlydwskWW?=
 =?us-ascii?Q?vihis95XDPdOdMMPAfhJ027D7CZ2cKDfwMWWgu/PpTlx+AR4LmvHafslsnUl?=
 =?us-ascii?Q?TPNzjuKf+btK1f6Ug7GIOXFSkrrehtMks/xk8VrCSP5/BusREyKwFSeOLUNZ?=
 =?us-ascii?Q?OpUvUN5Z1pDNBNs5kcj/9HQCNyNK0VGWURAJhq8xAlmTruPwprMXSTN/0rdz?=
 =?us-ascii?Q?JybtVAEr+w/WEaJoPwM7wJkv13TjRDvqX+x1zMHmXBNdSZJUxR+wfgHoRTXk?=
 =?us-ascii?Q?ZzKIfqNZOtWFP9tBn4yCnZ/pjYXT1kOGfMUY7VTg0HffsBbanwSkCSfWAoMe?=
 =?us-ascii?Q?faBhisND2Ixf3J/TPiNlwWd0wiIFZTNuxWsRg4aqDB2ooOU2mMfRsDEt52n5?=
 =?us-ascii?Q?rkiuE8/AlU/NoqPV3YoK65pnLJbqp7Z/t8NK5vFQJIaaSx/5epfgVavhklUc?=
 =?us-ascii?Q?+uUO6+L2PE7HPfOK/F3d4wJ4RHv+VFPn1GE/bt8hVq9evdrrSTmWSLZ3BrES?=
 =?us-ascii?Q?i9zLqsyiLNI9C0FMScpkD64vgh+JggEmdNpGPowMnVtztr4ylKSySzUqjfEW?=
 =?us-ascii?Q?vmjyapUCzhoLSvMgRLi5Eu5E2hoYzHbKhTRrZT+b+q97g1knz+XfwAlFpyaJ?=
 =?us-ascii?Q?pIOZY4KVmwSdGCpSJ/Gsp304E+5MFqO8GwuuihugjIAm2PUzYCEKMnG7qvZ/?=
 =?us-ascii?Q?fe3s3opIXMnqh0GYLv7sPWew8OpceIIj7Ssyg3NLtsxcsG34HeGdXkbJkI1L?=
 =?us-ascii?Q?LZykoK+bAOj0YDM3LzloLyBnK4mCk44xU0hAXXBvAgqVn+NML+ZJFTAa0HFC?=
 =?us-ascii?Q?ccpVhy/5iitijS1VfacswM0P4xYNpiyYnhmb67Sx0dciEWXbQP4x0nd/QGLa?=
 =?us-ascii?Q?65aLT/W1YbiDN9QN7rDQ4mdDNW+Fn9pyX4mJTdems5nc9azf0X2NYaYs06KG?=
 =?us-ascii?Q?RRMCEVajKUvD99NGy0VUu5UtvP3JYbWbsHJ23rSpap8uOy7kG3IINLubHNCA?=
 =?us-ascii?Q?S95fc8rKp0mdb/IaAhfAoMWZgUkSZQRwVWwxMauGMr5gTYVOBIgGnQjcuUGh?=
 =?us-ascii?Q?BSjyCE2G6JaQYQUx8vOYuupaeO3JP0SncmfVosDhmSFd/lOUxlndHZU5VUUz?=
 =?us-ascii?Q?QLID5aK80WasW1YL1IPiO1+qBEXk/r6jF1vh8+oku9B3RXc5F9KcSPs1ZNiy?=
 =?us-ascii?Q?BvAPT1HNO+lYqCqnFL+xBx9WtWbAVsTonrVhP9vdeR5DCkk5oq1j97oQ2b7S?=
 =?us-ascii?Q?VhI8wp7zrDNw8C4DIgCAO3gqdEdS3EiqIHhgN6600lnvrCtEQK/ASd5GMyGJ?=
 =?us-ascii?Q?wX1YIIuc/ag7ZrO1UKMgLoDxhVhgPOuOT3IqTy/XBd+24kGqBQgq8FJwjskQ?=
 =?us-ascii?Q?A0AexZTMsyqWliz1ChchbJpFy7aHts4kDw+LJ4o9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f006ffe-830f-40cb-200d-08dcc69dd17c
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:40:30.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObUW2Yq6G4qcm7l72kIJWjWXgHMkY1dClDlFAI8e15IESfdxtQIuCDgGxjTuwmzwcdtm8WnXjNnWct3JyJfprg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7153

1. Fix cross-compile issue for some files:
[Issue]
When cross-compiling bpf selftests for arm64 on x86_64 host, the following error occurs:
progs/loop2.c:20:7: error: incomplete definition of type 'struct user_pt_regs'
   20 |                 if (PT_REGS_RC(ctx) & 1)
      |                     ^~~~~~~~~~~~~~~

There are same error in files: loop1.c, loop2.c, loop3.c, loop6.c ???

[Reason]
On arm64, in file bpf_tracing.h, we use userspace's user_pt_regs,
which is defined in "linux/ptrace.h".
We include the header file by adding "-idirafter /usr/include" for "CLANG_CFLAGS".

However, during cross-compiling, "linux/ptrace.h" is based on x86_64
and has no definition of "struct user_pt_regs".

[Fix]
Thus, to fix this issue, we include the Linux source tree's header file directory.

2. Fix static compile issue for "-lzstd":
[Issue]
By running the command "LDLIBS=-static LDFLAGS=--sysroot=/aarch64-linux-gnu/libc ./vmtest.sh -s -- ./test_progs",
during static cross-compiling, an error occurs:
/aarch64-linux-gnu/bin/ld: aarch64-linux-gnu/libc/usr/lib/libelf.a(elf_compress.o): in function `__libelf_compress':
(.text+0xec): undefined reference to `ZSTD_createCCtx'
/aarch64-linux-gnu/bin/ld: (.text+0xf0): undefined reference to `ZSTD_createCCtx'
...

[Fix]
For static compile, add "LDLIBS += -lzstd".

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 tools/testing/selftests/bpf/Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ec7d425c4022..5b725bc890d2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -48,6 +48,10 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
+ifneq (,$(findstring -static,$(LDLIBS)))
+LDLIBS += -lzstd
+endif
+
 LDLIBS += $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
 CFLAGS += $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null)
 CFLAGS += $(shell $(PKG_CONFIG) --exists libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
@@ -443,13 +447,19 @@ CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
+CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
+
 BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
 	     -I$(abspath $(OUTPUT)/../usr/include)			\
 	     -Wno-compare-distinct-pointer-types
 # TODO: enable me -Wsign-compare
 
-CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
+#"make headers_install" at first
+ifneq ($(CROSS_COMPILE),)
+src_uapi_dir := $(srctree)/usr/include
+BPF_CFLAGS += -I$(src_uapi_dir)
+endif
 
 $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
 $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
-- 
2.34.1


