Return-Path: <linux-kselftest+bounces-2736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F240F8279A8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125511C22975
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD25956468;
	Mon,  8 Jan 2024 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw6rD420"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0D56467;
	Mon,  8 Jan 2024 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28b1095064so246027266b.2;
        Mon, 08 Jan 2024 12:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747212; x=1705352012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C23Ia8KDgm3NZnmRi0kSKyscN+EmGw68vBX1pkziOPc=;
        b=Pw6rD420+lxdClsbnm4tRSbKJccMS62aagiqX21DZ5QBZRlS+REIeATuwNt+0rYuEc
         0Lk1dDxNkjT7t/Z7PYjhjvQGqZ3HAZkvpUKC4Xq5Z2L0nTecs3mvBZYeaB36m5d909c/
         LyrLjsvlNKStYGw2Rw5EC5N67FoW5tSoRY37JBLn6pEbxFM8e1Nja/QEETKVBXdBdyUG
         I4qtbi5ZRqqzUMhraIl1Nq59iKANxy/VbyN/sAMvo7HTyntlCSDRzZ6+2pDML3OES99g
         JV/h6SFjhQwW+dcKK7KsCbLdFuZgvEQpngyNEAvb70huGcGegHCYsS3J6qDl+X3YeHYI
         lx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747212; x=1705352012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C23Ia8KDgm3NZnmRi0kSKyscN+EmGw68vBX1pkziOPc=;
        b=iTzkty5DhXJlUuDl0ZI+shdZgGNywf5TfG047tTHA4K8cvpGB6nFprI/XkqEqI8qW0
         wjUeSv5jChcegi1lqQ+AammCPLv6e/UZ1zHGk/KiDKLaKpCnJ4xSVYPk/vru/BLGsYBm
         nc8Q7BcbbxAGwsV1aPfaaNnqGFQAvpGJuDyzV+pqL+mCoEUxvOrNTMYEmZtsSztDOZUP
         GLnLxD/2pIX+X/eFkpOW/+fCF+T33B+8CmwyJstlSeXSTRriX2U1VvH1tQj4awAZ63pA
         vwnPqiiwdIG1Ji0eB4qYfQsXm16Qy4/C746ce+sGf5PqU6awfxZOzv1YaBWex1khHSaP
         74VA==
X-Gm-Message-State: AOJu0YyxC4rveE0htBd+VCsZ2jmzqoC+yg+HfXZmSAvOivOiqCCd8H2N
	1vLbf+55vVZ3IHP5GwBVh7c=
X-Google-Smtp-Source: AGHT+IGtkVNw4QJzY82TEiJ+RyskmX1QkWRto9t63dOw/iXHNlxKb8ouG0vDQQZv1XmJUUBD9O1H4A==
X-Received: by 2002:a17:906:c2d7:b0:a2a:1f1c:a317 with SMTP id ch23-20020a170906c2d700b00a2a1f1ca317mr3525ejb.208.1704747212351;
        Mon, 08 Jan 2024 12:53:32 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090668d300b00a27a7fa8691sm244476ejr.137.2024.01.08.12.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:53:32 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
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
Subject: [PATCH bpf-next v2 13/15] selftests/bpf: Add test cases for narrowing fill
Date: Mon,  8 Jan 2024 22:52:07 +0200
Message-ID: <20240108205209.838365-14-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108205209.838365-1-maxtram95@gmail.com>
References: <20240108205209.838365-1-maxtram95@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index fab8ae9fe947..3764111d190d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -936,4 +936,112 @@ l0_%=:	r0 = 0;						\
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
2.43.0


