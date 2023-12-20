Return-Path: <linux-kselftest+bounces-2290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F781A881
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE7A1C22EEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6294E1B0;
	Wed, 20 Dec 2023 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY+18ipp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA444AF6B;
	Wed, 20 Dec 2023 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2358a75b69so23202566b.1;
        Wed, 20 Dec 2023 13:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108454; x=1703713254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAmo05RnOjTf6B7ADoC7uGraqPZAsfUxrzmafdm0UDs=;
        b=GY+18ipp1iLQ8raKR4tgkq9KteqMii6NDo8xWEfTxe4mmqO9miaHSqnCEKU2SP66hF
         GPGTu4ct8QlgZdOkJrbIVjY1kCol5adQvjQa5aI6eVM/rSXgwlqjtJjajRohLHpLsnt1
         h//bBoMAGX++a59jqe40LwMSy3WXyDLlOgCdlPjcl37nbrpd/jgiYuCFzAU9PZ496EvN
         385IVLT5CP089E7TwUr4H09VAYHlS2z/xpPwfDutLomSuVgamWYEwGlYCaNmZEmLk+IP
         nPDIJhQ1WCvlmfsVMRwaQR4d/SkkNjQD4z4HOB5VFnVpAlgxFxf3HRVOCvGg6qXb8Fxx
         AJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108454; x=1703713254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAmo05RnOjTf6B7ADoC7uGraqPZAsfUxrzmafdm0UDs=;
        b=maRWh5fvwSQQAZJdgDJvQ9HgPZHSuzJFDxc3WPJ5oKooM8AiJ4hZ7/vv+U8m0f4IrB
         NP3oIaNt5tpoZpwHgZR3jwKFECl8R0Z9AoNQsqm7xvCm7evmOlIFirhRTHsE1/hgYo83
         qB9tEmoQit/EWWcwj3wBMydjQD6ZG2Qpx5qDH94k2J9vKSJIgExE1IrnWWz7Uhp8W7YL
         yR/Z7ik3gxyCmJzr8y9EjxjZOfL9P0IM2LlEyC88oLvBgIb2jRY0ev8b0gQLR5ubUM5j
         uzkR8YsUqO+viK78Fcolx1bJC7Hgny79gG77t6Yu92YnN2i7wrq3HtiGSsgrHswdtwJW
         dbPw==
X-Gm-Message-State: AOJu0YxSPczFzZlkxJ7HWewfMSKmMfAfhW85iXm1Dj1r0n1PfQIpa1Ps
	ccmTsCUS2IT/MO1cHpigVzU=
X-Google-Smtp-Source: AGHT+IF+q5S2rEJ0JQi91pAua3JKvvrDe8tEuRGPT4sMkhb3YRVMJCg8JoEga3vqJ6rZLmt8JBeY+g==
X-Received: by 2002:a17:906:d0cd:b0:a23:690e:48bf with SMTP id bq13-20020a170906d0cd00b00a23690e48bfmr3236891ejb.12.1703108454392;
        Wed, 20 Dec 2023 13:40:54 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090648cd00b00a2350a75dc0sm233110ejt.207.2023.12.20.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:54 -0800 (PST)
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
Subject: [PATCH bpf-next 13/15] selftests/bpf: Add test cases for narrowing fill
Date: Wed, 20 Dec 2023 23:40:11 +0200
Message-ID: <20231220214013.3327288-14-maxtram95@gmail.com>
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

The previous commit allowed to preserve boundaries and track IDs of
scalars on narrowing fills. Add test cases for that pattern.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index de03e72e07a9..df195cf5c77b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -938,4 +938,112 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("xdp")
+__description("32-bit fill after 64-bit spill")
+__success __retval(0)
+__naked void fill_32bit_after_spill_64bit(void)
+{
+	asm volatile("					\
+	/* Randomize the upper 32 bits. */		\
+	call %[bpf_get_prandom_u32];			\
+	r0 <<= 32;					\
+	/* 64-bit spill r0 to stack. */			\
+	*(u64*)(r10 - 8) = r0;				\
+	/* 32-bit fill r0 from stack. */		\
+	r0 = *(u32*)(r10 - %[offset]);				\
+	/* Boundary check on r0 with predetermined result. */\
+	if r0 == 0 goto l0_%=;				\
+	/* Dead branch: the verifier should prune it. Do an invalid memory\
+	 * access if the verifier follows it.		\
+	 */						\
+	r0 = *(u64*)(r9 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	  __imm_const(offset, 8)
+#else
+	  __imm_const(offset, 4)
+#endif
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("32-bit fill after 64-bit spill of 32-bit value should preserve ID")
+__success __retval(0)
+__naked void fill_32bit_after_spill_64bit_preserve_id(void)
+{
+	asm volatile ("					\
+	/* Randomize the lower 32 bits. */		\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xffffffff;				\
+	/* 64-bit spill r0 to stack - should assign an ID. */\
+	*(u64*)(r10 - 8) = r0;				\
+	/* 32-bit fill r1 from stack - should preserve the ID. */\
+	r1 = *(u32*)(r10 - %[offset]);				\
+	/* Compare r1 with another register to trigger find_equal_scalars. */\
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
+	: __imm(bpf_get_prandom_u32),
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	  __imm_const(offset, 8)
+#else
+	  __imm_const(offset, 4)
+#endif
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("32-bit fill after 64-bit spill should clear ID")
+__failure __msg("math between ctx pointer and 4294967295 is not allowed")
+__naked void fill_32bit_after_spill_64bit_clear_id(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	/* Roll one bit to force the verifier to track both branches. */\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0x8;					\
+	/* Put a large number into r1. */		\
+	r1 = 0xffffffff;				\
+	r1 <<= 32;					\
+	r1 += r0;					\
+	/* 64-bit spill r1 to stack - should assign an ID. */\
+	*(u64*)(r10 - 8) = r1;				\
+	/* 32-bit fill r2 from stack - should clear the ID. */\
+	r2 = *(u32*)(r10 - %[offset]);			\
+	/* Compare r2 with another register to trigger find_equal_scalars.\
+	 * Having one random bit is important here, otherwise the verifier cuts\
+	 * the corners. If the ID was mistakenly preserved on fill, this would\
+	 * cause the verifier to think that r1 is also equal to zero in one of\
+	 * the branches, and equal to eight on the other branch.\
+	 */						\
+	r3 = 0;						\
+	if r2 != r3 goto l0_%=;				\
+l0_%=:	r1 >>= 32;					\
+	/* The verifier shouldn't propagate r2's range to r1, so it should\
+	 * still remember r1 = 0xffffffff and reject the below.\
+	 */						\
+	r6 += r1;					\
+	r0 = *(u32*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	  __imm_const(offset, 8)
+#else
+	  __imm_const(offset, 4)
+#endif
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.1


