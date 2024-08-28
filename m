Return-Path: <linux-kselftest+bounces-16539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE089626BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 14:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB101F23DC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F6175D5A;
	Wed, 28 Aug 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CjhpIdbB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C4175548;
	Wed, 28 Aug 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847466; cv=fail; b=r4RYnC4k74uprZor7ZIgx89Xos1i+naFO8uyPhTLCVdgw48HUspHwuvaP0bACcXzljKzYm/koH0kP/PNBN8U69+kS17Vv89jMS8E31P0N43T5hFPw08H3MaiTBCaS5nR0i5Iom/D5E2j6WHl/dGX0tieVx8zHx6f+zR+50WgAKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847466; c=relaxed/simple;
	bh=rthb12yFXM2v7iL/Ys6Qd2nCTvG//CmLL1n584d0sGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JvnLWJQOhbQXNdbij4G2qEFSWOv8DcMo7mqFdXZEmN1MNEjj76xBVjbYoWLPRdwKOG5qzpTa6Gs9okNcQLo5BTACQQHw4Ucpx8g/oLDibnUDqIezToab02d19FOFE+zl9x6afPgZTkQEuLjigqHlT34DsHunQwLm6Tf+J2bYCBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CjhpIdbB; arc=fail smtp.client-ip=40.107.215.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNHAewkNV6uarUzP5VEBJyx5BC6eJNYO1mrBAkHJnW25Z+79obsYyMLEULYF8Hm1we/NhiL/c3/V7gk8qyuBlYjVKxrE159bF4V2VyJgJnTmvDKFj2PkZhiKME8hjMD2TxbUycTX+b1Uy9vzhR6klWkwUxUIGb03d0++5ayGAaSKycnr4fMejbXtpO08GtPpvbrC0iS9ijuHX+3As1utmcvurgsACRmulWEMSwcGcdg4lEg0x310wMJWAdlKGoKaSEk9eZz0Kzmj4Jy5Jd53uM4ER80VS7LcwuNapj5fARLHfCiCg/0iS0nXw/98xnNMZU+v+JdfiDzbRE7ZLWGQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kvz+0G8ygd1ni1yc4zoje01KS7SDsovLOoeqn67D3WY=;
 b=nK7cotM+Nx4ta7QaGD59kEWFv3CI72XbItLfNrQKuzGJ7h5MbeN42hPDg3gMUICoBBmXe6vedazHPw4WyvCne9d5vF5JRIM3OcEH1i84cchLA2N/geI9A/bPEoTA5akyODq5SB/qn47CQEX7uPPCccxh997Damig8hKv7OKsRH6+oNgWtcchtXNXNppe0B5t602ao1WFkh3Wd1LTdOpMuBMbswISBrE9fhhnhKsA0M2r0Gs4UVmyUqsRruODJ8Pc0OkuMOBTPz5KcQhYTZPkaqmebNEwppDaCrSb3cZSUiaZteHdhMssDwgEVZXL0mJ94wjxLz8n1NvOd7D6OUpbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kvz+0G8ygd1ni1yc4zoje01KS7SDsovLOoeqn67D3WY=;
 b=CjhpIdbBx2eXRps+Kt3lv4epFy9EOCcaXu0uKF4Ro+TfqqK5copQdwOBACAGsjEFEnP2C8r0yUnuZRMRZKp5XpagL67OmSe0rZB/0zByRWAMvq51WvmI8XsndJmj3REVz/iJ9Bcgxy73btuERhC7PsHAWXgPErhX2IWx6OuxKicCxzjWWI40YuZNEwltN35IEWpWgl3FvQslOBEwUJ6g16QzqPeBc1tOYpRQla4xOnhuniHo0bLSIbVolHesoWC/X9HpL5bLuQfuADEgLT4dMCR9jwZUKAeyF78fr6QR/rcQh7r9eGo+5T24p6NyAUexNy8I1UxoJWWXbmsdWh7fgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by KL1PR06MB5884.apcprd06.prod.outlook.com (2603:1096:820:dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 12:17:33 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 12:17:33 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	terrelln@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	yikai.lin@vivo.com
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Enable vmtest for cross-compile arm64 on x86_64 host, and fix some issues.
Date: Wed, 28 Aug 2024 20:17:05 +0800
Message-Id: <20240828121706.1721287-2-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828121706.1721287-1-yikai.lin@vivo.com>
References: <20240828121706.1721287-1-yikai.lin@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5913:EE_|KL1PR06MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: ddcda870-573d-47c1-6c2b-08dcc75b64c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fAgii6wTWC6U9HNtWS6aWaAq9EVT6074FstxQwGP6LEGUEfr7+W7jCl2ZOPD?=
 =?us-ascii?Q?nZeKDXa+sun+XojRZRTyPfO1ndn7gQrJjq2089r1YeHzRoPNEzOlQxf1mNBC?=
 =?us-ascii?Q?rOC9ycyjgwVD70I9w5SOpzznhMh971S1yiUuWdkQ+qHcPOyj8JP3qLVWuLgZ?=
 =?us-ascii?Q?/yjUfudp79qUlvFFs+XFUHuO6TF4s4D921OR74FiIPXgXkMnNoyWz/Pfgmtz?=
 =?us-ascii?Q?+VfX75lmOMt1SUZOVEStbBLi88WgaL+EJNYoOy+lGPlxSKNiKSj73EIZwwAE?=
 =?us-ascii?Q?5ZAGGnQNbVMwKzjw/99ljYrC+OkB0/743L59IzjIGe6Md3AokM2r/ovrQhuD?=
 =?us-ascii?Q?jPp4rIhgWiOWJaDQOMNLkznEZrZNhSUau8UHmPXLBguzS34gv4Vh7V6NpFvC?=
 =?us-ascii?Q?YkTYpwpFtoOPmXQZ3De0xGJJzG08MC65rLoPBF1kke5OBCTn7nRthefhEnTF?=
 =?us-ascii?Q?JsD26QmcqShaykLHY9zdzltmUiT23ZSzNiTKLmhuw8l0+8rbQwvErYDDuEpz?=
 =?us-ascii?Q?LedgqEcwGkwYWizGZ5kEqoZ+j/JihXYT7RZPkQ1f22xHFLqMosDE/XxWAqiS?=
 =?us-ascii?Q?GOVSVBq0swqdf97LAKYrtOirxGZC8DmeQBz6nONfgZBE/JJz5cyKmMtVUvr5?=
 =?us-ascii?Q?S8xGzxal/72hJxhP8hXCtZc1Ejzuq8aoj8PC7n5Pw6bMA9kccaIKg0yPlBbb?=
 =?us-ascii?Q?gojOnWr2gzEko9s0/z4D0pGAKCwtkHWNCw/uC6JboXk2PfjkDi3sK5Tu7UTr?=
 =?us-ascii?Q?4LWwjYaiM7/66cXhLUL7bqHxx5A8gmDFPocqKU190C6OyKReI3T/UAisqVVT?=
 =?us-ascii?Q?E/Ltr1A9wh1fByhg6QkNs6jxhqoG+3DQkBpY5PihKYwEZMvhMNb8UisDdskN?=
 =?us-ascii?Q?PDf4SMuSYdho6BL/GlFRsWjnmifUuiPFIuz0LZaTEOU3WWkNgbgGAJx3dcKd?=
 =?us-ascii?Q?SJH+Uu5PgNMLJdPd5Ww3tPEt0Q7lD41sgnpUEPQvPSbS1HTh3FVXL/NE5Iv4?=
 =?us-ascii?Q?pMClcmzohObjaHNRbW6Z2DqDyGyJ9H2fYp2uqVnWl6zYWulGhd8SeqaBAeZF?=
 =?us-ascii?Q?02qLwbW5OQxND+mFMX/euDzOigoZxZwIweh6/sUhGng5bQVeC89lOTgkF54o?=
 =?us-ascii?Q?Ccjb2s6HQ9Cdj7PB6xjWme4n9GIBdVLCy3Fc7w6+ctICdUcT6CviH7bsvk/r?=
 =?us-ascii?Q?boJLhxxWW2WWOk5YVUwxs/5ZiEPaIZDoTMpO+g/1HyJWDU5A+Dm0KQiSzvWl?=
 =?us-ascii?Q?TpbVES/3vJTE/f4UWx98fCsbPySvo7ILfZ3wOeqzU6l/TeSmRHVyzKYXjqBZ?=
 =?us-ascii?Q?1TM5bvELjUzfnh4tqt/oPRdOwxwq94v0I0EFvWIsbErqVh14vruSWBytG5GO?=
 =?us-ascii?Q?CdCeHio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kbrPEU7L6ECTXUQcwdDx/AKWOFvQeUa+yO4g1Jxq+HYWahd+zWeH2sAg74Em?=
 =?us-ascii?Q?OIgxRIItFEiDfnHyytzB/9XJYaFnL9TUVb56Bqw8yH+dKTYm1mpAWhsLP3dl?=
 =?us-ascii?Q?1UGIxZ3ZdBCev14opw1OuGPwbPVr/m6YhIB7CnV7Qw7gIgh/rUeHZw2CiICR?=
 =?us-ascii?Q?rv1FEdVHZuvQ0EtgpZLdq8bt0vLPjzlTa9PuQGnFJE1TpooI49if5FAKynPI?=
 =?us-ascii?Q?22zSuNrBvN3yEkN56+auq6xLlZWyhuz4hmrw21iw0Lz4m4ThJRb75+nmI/l8?=
 =?us-ascii?Q?Wb+mlV241fhmfycGpDI/P6JQuAw1pg9rIyOr28quqWxUsSZVDNx6D5VGgOtC?=
 =?us-ascii?Q?kpyrGw8uhmQc+v35ht+2Gv02Vn22iCenqJ17a5cg1yPnw3/RruEDq0pAhIk7?=
 =?us-ascii?Q?/GYWY0RS/f/2GZUrpIdv9rLT/KrXEmgvYELMiLbsSyNuSTHBL9qwELC7MAwC?=
 =?us-ascii?Q?kymDdtPwOUk/B9iTMiq/t22c7ecANTzmu4VJmGK1IJpls129x3f6N7gKLJDt?=
 =?us-ascii?Q?ufeS03PjrJ4ux1/VJa6Nf/X6OVs2cyo7/XizwyBwEgmynjaFD3AmCDSSV6/j?=
 =?us-ascii?Q?N0tIl/MG38u4d4k3slU8E8YXrZFUZjJiPWMPjKgnZuvgx//boEHsapiASXcP?=
 =?us-ascii?Q?ISdX34ghhWKmtmhr3OswzxP6Hjhwr+DxZ2h9GbqkimbZjw5cebIJt4B/Fhot?=
 =?us-ascii?Q?R5JOuvjvTX30uAkWDUg59q8uUzeJlQpN0bx0JXzeIqG+xAC3WVW6bpaKdLGS?=
 =?us-ascii?Q?8DJTD7ZmehMkKUdLJKqYpPgASDOr5GGS5bkCO2IFRHvbp3nUqBgBmK3aN0FJ?=
 =?us-ascii?Q?6dS+TjEJkySPTk3p2OVfTf2lwOjdb7ZTmRNYDsaeDvSZWxEkpXHLHf/trwH2?=
 =?us-ascii?Q?fE3S7xdZcKyT56cJg9jFZUwWc1LFB8F4Sezd/GUEZectyHPk3iq+B0N89uPa?=
 =?us-ascii?Q?YGbRudSV69JKZOOG6PWZwjo3Zsg2FCfUyuMPfwSrNrFZemV4WY3h+8MtUOJA?=
 =?us-ascii?Q?+HyJZ2vKyDxDTP5WGH5oZGKw6qRIKxprVb9Urj6lUK8n5uminEoedot5yetD?=
 =?us-ascii?Q?BQKxonhdF39L6Bvv/uCgY8eJRLXY376a7LudQja8B/8l/4BNpgKjdY8LxjrH?=
 =?us-ascii?Q?byW/sqrN6G6y+LYGXl17o6imLwsQB/MgZaL0a8Ih4uSbX1fdg+vucpm/0mS8?=
 =?us-ascii?Q?JUKuI5Nd8rC1aNFjvIhDuMB1saejomWatwsU4ZjpotFcW3odY4KkKaRTrhAw?=
 =?us-ascii?Q?GRbRsD9hdegUu2CqrNrXCKmhZezSTRwc+dZaJv3V3twWBrAP/H3cvSZ2vjTI?=
 =?us-ascii?Q?06Gr2B1KhhuZrktm5WTjYMuXlKBZDqV63zddThcnbTuZUqEayb/1Snc866VN?=
 =?us-ascii?Q?VdBnq60YuwAyMkPOuPF2vTK/5pRT1TuywaDczNbQdREkhRAZOiYTIPPL8Sty?=
 =?us-ascii?Q?ehhwJcdJmGzPifd05Di7vaDIGrHpuuxXevAw5ouTVBmNyh5NSRWYoVIx70aH?=
 =?us-ascii?Q?sUzJrBNMWqDCLAfr7XLoWZLugzJYK2sdSfCJvu0OcBGPDXyXXA73evUS7nYv?=
 =?us-ascii?Q?xS9hqae7wIjCTr4EzeG8iS1cUiUWL8cus3rBecGn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcda870-573d-47c1-6c2b-08dcc75b64c8
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 12:17:33.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCADVOD92z3HAq7lp0ZJ1x/DIuhmK0LnmNBKVyWeRArumXpU3evsuBLSrUMJAAw3j3Nmh5RKECktwhqqONK49w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5884

In Makefile, we use $(SRCARCH) to access target arch's uapi include.
This allow us to obtain the definition of 'struct user_pt_regs' for "ptrace.h" header file.

Thus, it is no longer necessary to execute "make headers_install".

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 tools/testing/selftests/bpf/Makefile   |  6 +++++
 tools/testing/selftests/bpf/README.rst | 11 +++++++-
 tools/testing/selftests/bpf/vmtest.sh  | 37 +++++++++++++++++++++-----
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c120617b64ad..3f0f9a171651 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -444,6 +444,7 @@ CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
+
 BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
 	     -I$(abspath $(OUTPUT)/../usr/include)			\
@@ -452,6 +453,11 @@ BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
 
+ifneq ($(CROSS_COMPILE),)
+src_uapi_dir := $(srctree)/arch/$(SRCARCH)/include/uapi
+BPF_CFLAGS += -I$(src_uapi_dir)
+endif
+
 $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
 $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
 
diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index 9b974e425af3..41ab23bd3277 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -79,13 +79,22 @@ In case of linker errors when running selftests, try using static linking:
 
   $ LDLIBS=-static PKG_CONFIG='pkg-config --static' vmtest.sh
 
+If you want to make corss-compile, such as compile arm64 on x86_64, you can try:
+
+.. code-block:: console
+
+  $ export PATH=$PATH:{The corss-compile's path}/bin
+  $ export ARCH=arm64
+  $ export CROSS_COMPILE=aarch64-linux-gnu-
+  $ LDLIBS=-static vmtest.sh
+
 .. note:: Some distros may not support static linking.
 
 .. note:: The script uses pahole and clang based on host environment setting.
           If you want to change pahole and llvm, you can change `PATH` environment
           variable in the beginning of script.
 
-.. note:: The script currently only supports x86_64 and s390x architectures.
+.. note:: The script currently only supports x86_64, s390x and arm64 architectures.
 
 Additional information about selftest failures are
 documented here.
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 65d14f3bbe30..c7461ed496ab 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -4,11 +4,11 @@
 set -u
 set -e
 
-# This script currently only works for x86_64 and s390x, as
+# This script currently only works for x86_64, s390x and arm64, as
 # it is based on the VM image used by the BPF CI, which is
 # available only for these architectures.
-ARCH="$(uname -m)"
-case "${ARCH}" in
+HOST_ARCH="$(uname -m)"
+case "${HOST_ARCH}" in
 s390x)
 	QEMU_BINARY=qemu-system-s390x
 	QEMU_CONSOLE="ttyS1"
@@ -32,13 +32,38 @@ aarch64)
 	exit 1
 	;;
 esac
+
+# process CROSS_COMPILE setting to enable cross-compilation
+process_cross_compile() {
+	if [ -z "${CROSS_COMPILE+x}" ]; then
+		return
+	fi
+	case "$1" in
+		x86_64)
+			#Cross-compiling for arm64 on an x86_64 host
+			if [[ $CROSS_COMPILE == *aarch64* ]]; then
+				VM_ARCH=aarch64
+				QEMU_CONSOLE="ttyAMA0,115200"
+				QEMU_BINARY=qemu-system-aarch64
+				QEMU_FLAGS=(-M virt,gic-version=3 -cpu cortex-a57 -smp 8)
+				BZIMAGE="arch/arm64/boot/Image"
+				echo "Setting VM_ARCH from $HOST_ARCH to $VM_ARCH as specified by CROSS_COMPILE"
+			fi
+			;;
+	esac
+}
+
+VM_ARCH=${HOST_ARCH}
+process_cross_compile "$VM_ARCH"
+
+
 DEFAULT_COMMAND="./test_progs"
 MOUNT_DIR="mnt"
 ROOTFS_IMAGE="root.img"
 OUTPUT_DIR="$HOME/.bpf_selftests"
 KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config"
 	"tools/testing/selftests/bpf/config.vm"
-	"tools/testing/selftests/bpf/config.${ARCH}")
+	"tools/testing/selftests/bpf/config.${VM_ARCH}")
 INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
 NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
@@ -109,7 +134,7 @@ newest_rootfs_version()
 {
 	{
 	for file in "${!URLS[@]}"; do
-		if [[ $file =~ ^"${ARCH}"/libbpf-vmtest-rootfs-(.*)\.tar\.zst$ ]]; then
+		if [[ $file =~ ^"${VM_ARCH}"/libbpf-vmtest-rootfs-(.*)\.tar\.zst$ ]]; then
 			echo "${BASH_REMATCH[1]}"
 		fi
 	done
@@ -126,7 +151,7 @@ download_rootfs()
 		exit 1
 	fi
 
-	download "${ARCH}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
+	download "${VM_ARCH}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
 		zstd -d | sudo tar -C "$dir" -x
 }
 
-- 
2.34.1


