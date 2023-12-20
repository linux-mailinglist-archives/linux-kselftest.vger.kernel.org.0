Return-Path: <linux-kselftest+bounces-2286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469FF81A875
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF382289044
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24C4D592;
	Wed, 20 Dec 2023 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c40Gwhr0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04A4D138;
	Wed, 20 Dec 2023 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-553fe292cffso138781a12.3;
        Wed, 20 Dec 2023 13:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108443; x=1703713243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Cmahq1oN8skftCnwm4onZq6EwCNDIEX8Tio8RQhdao=;
        b=c40Gwhr06loa82rrib6ZQBuo6DNIAa0zeXy4KTIjIxnaK6ito/jcIu1txyFB/3XoIv
         5WK/WylHzxrQTtzy+w0Kg6zJINPOOmemFdlXl2aB7duA1a+XH1jUT0u7v2PsoYxlPGv5
         2f0SzrHn1E2g7iRgxfWqBoHAOmBUyvZL4Rl7nBFJXU6ZBdrqDPL0crkGZGxXLLwVlDbk
         7cJa0TF4NyDhWq24v7YmKeN/8WV4DkspzCkKIuzrOGkOVg1wRIwJPkwoP138qVnbkM8x
         AKXwR+2fpkxm8rnsk7RxTrgC7Y8xUbl+VpnOTTFoWqZ2aW/2jgJGidV6GsPOv07ru0fl
         uuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108443; x=1703713243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Cmahq1oN8skftCnwm4onZq6EwCNDIEX8Tio8RQhdao=;
        b=IKfKLqp0LAPYiAjzrSRK67k0VBLGlVtP1aejxwbd+I9AhRheFjXP7uKPMggYt7s8ME
         m9g+jlprztBDaiMkzs+2uyjOjYeFGSaY5o6CIjR7lfXqO1P3mD+uMQE9wEpSMa34XJ4R
         5Tz+N8/cRPWeVFf1Gt7a8F5LZWOeYEY956vvbFIj/mDJfZIydj2yX3FrRvGKuZ3GOrN9
         OOi/HPWANIU88Qlqg3u6ms958lB3k2JuvV/u12z0mQrORHa7WxXAD+lZq1GlAiF+oxDY
         V2j7rlxAN7xm4NyWRn3B5t0ZUSSMkJ0piNimkwnxC1LUUgOGvcx3UE6oa8essmDJCrXQ
         LXAA==
X-Gm-Message-State: AOJu0YxSoH+NxRyxZD7C6LeF9xp7rVfYE98BOTnX/JwGUZqx1KUQ9O1y
	ySc/gxTzGJE5Gy01b8APs+M=
X-Google-Smtp-Source: AGHT+IHnLwAlzsVAnk/ixCkuoYt0PYs2nhoogYEqVM+Q06urlmHE+saw2KWviIOXbdVGZcInu7xfIQ==
X-Received: by 2002:a50:8d8c:0:b0:54b:22a1:e6fe with SMTP id r12-20020a508d8c000000b0054b22a1e6femr5828623edh.7.1703108442750;
        Wed, 20 Dec 2023 13:40:42 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7cf8e000000b0055351aa7d64sm288745edx.81.2023.12.20.13.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:42 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH bpf-next 09/15] selftests/bpf: Test assigning ID to scalars on spill
Date: Wed, 20 Dec 2023 23:40:07 +0200
Message-ID: <20231220214013.3327288-10-maxtram95@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231220214013.3327288-1-maxtram95@gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

The previous commit implemented assigning IDs to registers holding
scalars before spill. Add the test cases to check the new functionality.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index f2c1fe5b1dba..86881eaab4e2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -768,4 +768,137 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("xdp")
+__description("64-bit spill of 64-bit reg should assign ID")
+__success __retval(0)
+__naked void spill_64bit_of_64bit_ok(void)
+{
+	asm volatile ("					\
+	/* Roll one bit to make the register inexact. */\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0x80000000;				\
+	r0 <<= 32;					\
+	/* 64-bit spill r0 to stack - should assign an ID. */\
+	*(u64*)(r10 - 8) = r0;				\
+	/* 64-bit fill r1 from stack - should preserve the ID. */\
+	r1 = *(u64*)(r10 - 8);				\
+	/* Compare r1 with another register to trigger find_equal_scalars.\
+	 * Having one random bit is important here, otherwise the verifier cuts\
+	 * the corners.					\
+	 */						\
+	r2 = 0;						\
+	if r1 != r2 goto l0_%=;				\
+	/* The result of this comparison is predefined. */\
+	if r0 == r2 goto l0_%=;				\
+	/* Dead branch: the verifier should prune it. Do an invalid memory\
+	 * access if the verifier follows it.		\
+	 */						\
+	r0 = *(u64*)(r9 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("32-bit spill of 32-bit reg should assign ID")
+__success __retval(0)
+__naked void spill_32bit_of_32bit_ok(void)
+{
+	asm volatile ("					\
+	/* Roll one bit to make the register inexact. */\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0x80000000;				\
+	/* 32-bit spill r0 to stack - should assign an ID. */\
+	*(u32*)(r10 - 8) = r0;				\
+	/* 32-bit fill r1 from stack - should preserve the ID. */\
+	r1 = *(u32*)(r10 - 8);				\
+	/* Compare r1 with another register to trigger find_equal_scalars.\
+	 * Having one random bit is important here, otherwise the verifier cuts\
+	 * the corners.					\
+	 */						\
+	r2 = 0;						\
+	if r1 != r2 goto l0_%=;				\
+	/* The result of this comparison is predefined. */\
+	if r0 == r2 goto l0_%=;				\
+	/* Dead branch: the verifier should prune it. Do an invalid memory\
+	 * access if the verifier follows it.		\
+	 */						\
+	r0 = *(u64*)(r9 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("16-bit spill of 16-bit reg should assign ID")
+__success __retval(0)
+__naked void spill_16bit_of_16bit_ok(void)
+{
+	asm volatile ("					\
+	/* Roll one bit to make the register inexact. */\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0x8000;					\
+	/* 16-bit spill r0 to stack - should assign an ID. */\
+	*(u16*)(r10 - 8) = r0;				\
+	/* 16-bit fill r1 from stack - should preserve the ID. */\
+	r1 = *(u16*)(r10 - 8);				\
+	/* Compare r1 with another register to trigger find_equal_scalars.\
+	 * Having one random bit is important here, otherwise the verifier cuts\
+	 * the corners.					\
+	 */						\
+	r2 = 0;						\
+	if r1 != r2 goto l0_%=;				\
+	/* The result of this comparison is predefined. */\
+	if r0 == r2 goto l0_%=;				\
+	/* Dead branch: the verifier should prune it. Do an invalid memory\
+	 * access if the verifier follows it.		\
+	 */						\
+	r0 = *(u64*)(r9 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("8-bit spill of 8-bit reg should assign ID")
+__success __retval(0)
+__naked void spill_8bit_of_8bit_ok(void)
+{
+	asm volatile ("					\
+	/* Roll one bit to make the register inexact. */\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0x80;					\
+	/* 8-bit spill r0 to stack - should assign an ID. */\
+	*(u8*)(r10 - 8) = r0;				\
+	/* 8-bit fill r1 from stack - should preserve the ID. */\
+	r1 = *(u8*)(r10 - 8);				\
+	/* Compare r1 with another register to trigger find_equal_scalars.\
+	 * Having one random bit is important here, otherwise the verifier cuts\
+	 * the corners.					\
+	 */						\
+	r2 = 0;						\
+	if r1 != r2 goto l0_%=;				\
+	/* The result of this comparison is predefined. */\
+	if r0 == r2 goto l0_%=;				\
+	/* Dead branch: the verifier should prune it. Do an invalid memory\
+	 * access if the verifier follows it.		\
+	 */						\
+	r0 = *(u64*)(r9 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.1


