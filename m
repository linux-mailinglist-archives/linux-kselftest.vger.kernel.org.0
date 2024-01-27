Return-Path: <linux-kselftest+bounces-3667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA883EF3F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 18:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB541C21EDE
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE02D60C;
	Sat, 27 Jan 2024 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZVRHHgh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF02D604;
	Sat, 27 Jan 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706377992; cv=none; b=m/C6a8spubuDj2LNRt+9hJRfBm0JjMemNv1FMbsAjtlblAQbm3W8OUPLiq0IXaSp6krDwa5/riLzwp1AvZ7C4GwnVN7qpCb1qCpHg9SEZ5NZD75/B2xbnrEK8mvDISzshItpjW3aZd3YC6n0WQ30ALeInONPIHKqEeJ09jxJcjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706377992; c=relaxed/simple;
	bh=VfWPiZ1vRW6H3hWfF649onKg9BA90vIGQzyb70j3pPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phVKuevtv26Y6XaiF921MzfGtxz+AYcw0ZFqMNaLCLDEXvfYquIxJP8mxtjbq4948IzyDt9c42Jh4VuM81mmEM0FqJ1tAHwbVy5B6bFf12UPLRXNjd5JBvmZrwN628EEcK/2i8AQDTIUhQRjsqC8jnNaFESlg98vdXK+ECB5hFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZVRHHgh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so21055775e9.3;
        Sat, 27 Jan 2024 09:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706377989; x=1706982789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szKrLwGLdzZiKf2ZM55P0AxDZ1c6ft6AGkc0dEme8Fw=;
        b=dZVRHHghITzSYQfhGL7+df6GFZJJjM5PPs2QJyMH6kHCM2+i5YO6g5HvPS+8X2S7MI
         LCzhPkM334gzJlxNDwSG4kX3/ivyG+2T01NM6tef6tO/6Um5Tn0O8FMn10G0wqpMne0p
         MJ2U8GptRLwZFHbQvf7XYAmUQBVnOa1M7ut32csBjI/IIsRPWSqnvF8V7Lw/yV3jovVb
         6eGlyyxtbzEzvhEV0tdWWfgTZv7HUoloqSWuSazeH7qWmFjSNRc7sID6euzKVXwPVsQs
         a6pV3ccgBqLw35l9bxnwnfjfDhZ+1giO5eN03vO1I1sW74UUkZ9miihvAwl058DtKpK4
         nJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706377989; x=1706982789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szKrLwGLdzZiKf2ZM55P0AxDZ1c6ft6AGkc0dEme8Fw=;
        b=tQLAFVucO1K3LCwJEUcJbnu29ye72VAeKILBZN2SiV20GLiKdoxztUVtBK09RbQoTD
         tTAuCcLOiidKhFKkCeUyCQRu4wb+lwsLc7gcCcunk2MRYYCbbTQzDhnkvBqNQd6ScGlw
         RhIQYmrXuLflyUPZSKuP7JrH8wPSC2Xm8p2j8RtI8YsqnY+TSUeOpAKGBw4RVX2FwqeN
         GRFyKrUW+iFGUzAS6muQkf/nz+Pb2MBYNe+VJYMQndwpQQxF3D6ZnoK4Gv8Hgx9ykHOf
         EYjKQIfSFXGdCBeA21PRc8n4r5o1fF6UVkvQ8KMxg4nsJW49iTP2gMbzjAKuuZVougwO
         jLcg==
X-Gm-Message-State: AOJu0Yzp61yiVTNPkB9YQrrGU2MgksdqRDuN07jruR3HPGEqmVqQAxZL
	ndFxfZy8meRRXtBWegX7OCI+0zLnQqhmcpzKH7hmGNiyQiekeD7B
X-Google-Smtp-Source: AGHT+IFQkR6le9DuoGJyY0i1r5xR5M4gVp5kXBnw6HCIJujSrmh2WLnMm3dgc+giJwlriNU8Cv4WEg==
X-Received: by 2002:adf:d1c4:0:b0:33a:e6b3:a924 with SMTP id b4-20020adfd1c4000000b0033ae6b3a924mr733982wrd.130.1706377988851;
        Sat, 27 Jan 2024 09:53:08 -0800 (PST)
Received: from localhost ([185.220.101.170])
        by smtp.gmail.com with ESMTPSA id se27-20020a170906ce5b00b00a349318ea10sm1954018ejb.199.2024.01.27.09.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 09:53:08 -0800 (PST)
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
Subject: [PATCH bpf-next v3 4/6] selftests/bpf: Add test cases for narrowing fill
Date: Sat, 27 Jan 2024 19:52:35 +0200
Message-ID: <20240127175237.526726-5-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127175237.526726-1-maxtram95@gmail.com>
References: <20240127175237.526726-1-maxtram95@gmail.com>
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
 .../selftests/bpf/progs/verifier_spill_fill.c | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 3e5d063ea7e8..7f3b1319bd99 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -979,4 +979,115 @@ l0_%=:	r0 = 0;						\
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
+	"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r0 = *(u32*)(r10 - 8);"
+#else
+	"r0 = *(u32*)(r10 - 4);"
+#endif
+	"						\
+	/* Boundary check on r0 with predetermined result. */\
+	if r0 == 0 goto l0_%=;				\
+	/* Dead branch: the verifier should prune it. Do an invalid memory\
+	 * access if the verifier follows it.		\
+	 */						\
+	r0 = *(u64*)(r9 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
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
+	"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r1 = *(u32*)(r10 - 8);"
+#else
+	"r1 = *(u32*)(r10 - 4);"
+#endif
+	"						\
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
+	: __imm(bpf_get_prandom_u32)
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
+	"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r2 = *(u32*)(r10 - 8);"
+#else
+	"r2 = *(u32*)(r10 - 4);"
+#endif
+	"						\
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
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


