Return-Path: <linux-kselftest+bounces-2732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA182799A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FB4285094
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84C555E62;
	Mon,  8 Jan 2024 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9Z69VMo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FF55E55;
	Mon,  8 Jan 2024 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5572a9b3420so5558951a12.1;
        Mon, 08 Jan 2024 12:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747189; x=1705351989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej8J9OhauosIFI++9G+ufXWjBdHGQphfaSW7XQcVXSA=;
        b=I9Z69VMoo/7fv9QbcNHFuJ6H+fQoNCm4Da7lm4lsqKQs2gjJMI6aEazo0KBomSRooE
         VTh6QoqwXcsicBPPP7RjC3b3ZQTQ/vksCWfc1XiiZpQ/6nRgQuDXC5Eca5wSrextqRFO
         O4grGFaUmuxSnL8trMm2ioJH08gBbif25PxlJrG2RBTBMKFfDiwyPOonBuM6pL2RnRvd
         Puh+JXTTwYhAFkmfrVhiE/YYWz0bLHRd069p+lAk6iDqRbImg4ADNEpVYBrgTOhhSQNU
         9lDi0iRs4DFJpMxe5j1HFOuxuI4gvIwbWNmE8u5jFg/lz2uztkXo12otZal1o578KZJB
         iU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747189; x=1705351989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ej8J9OhauosIFI++9G+ufXWjBdHGQphfaSW7XQcVXSA=;
        b=PwwdonZ+GgsUp6dxmA8DyYS7pv2wp5NV63zQ/ou0PUPcCjB1/UQ4zyNvNNEimw0OvI
         l39ifJjBwmXlbNqYLf766JjenxTLQZWcSkY/oePX7gUKuHq1iO/pIRo8BJEtVCI7DFoD
         3C3tMKMwcylwBGiMFXhQ7JjlzGYAgpPLMXEPNupUeGQTumFRueVsDbfZX/Z59CGA5FTx
         ekShKI1IBJRafS3lOK1S+UhI3vyC2z25yRG2XPgpPY8ifMg4ubKAwjiZEglSs+Xtrcwv
         1W0wh5FR9Q5kBPfuqUqQAqTWiTbDdc6J2z2YlzewYSqCOGQyj7FK0Ux2eJIeFTbKBy3O
         REIw==
X-Gm-Message-State: AOJu0YygvPoOYD1XVG1YOxT1JYqlJVDL1Ym6382PSz3tPssLlBWgLjd1
	Bj46zQnqM0Q22aolq1RzHFw=
X-Google-Smtp-Source: AGHT+IEOCULLeQPjmXdaQqQ5BarlL+HPYkS3juBbITgf8csPPO8Mqs5Dk7Moosu4E5GaqGVvGagZvQ==
X-Received: by 2002:a17:907:3209:b0:a2b:f7d:5b5d with SMTP id xg9-20020a170907320900b00a2b0f7d5b5dmr21043ejb.32.1704747189146;
        Mon, 08 Jan 2024 12:53:09 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id p11-20020a170906604b00b00a298d735a1bsm244153ejj.149.2024.01.08.12.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:53:08 -0800 (PST)
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
Subject: [PATCH bpf-next v2 09/15] selftests/bpf: Test assigning ID to scalars on spill
Date: Mon,  8 Jan 2024 22:52:03 +0200
Message-ID: <20240108205209.838365-10-maxtram95@gmail.com>
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

The previous commit implemented assigning IDs to registers holding
scalars before spill. Add the test cases to check the new functionality.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index f303ac19cf41..b05aab925ee5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -766,4 +766,137 @@ l0_%=:	r0 = 0;						\
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
2.43.0


