Return-Path: <linux-kselftest+bounces-2733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C7182799D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAFA28504A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5CB56452;
	Mon,  8 Jan 2024 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne7ZUI9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E755E58;
	Mon,  8 Jan 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e43fb2659so17099185e9.1;
        Mon, 08 Jan 2024 12:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747194; x=1705351994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heZMwtmY4JQoXU68UC8Q7sB/5mey2edhuFmP1UH7hEQ=;
        b=Ne7ZUI9aOYfvbH8/NRLJEY6yMXM0E/vavKY3YCoQaqY8yZ8nG7FBCTfUdNRgwaxfLZ
         Jln7h9XqFBFr09s5XVEr4rhepXdP646+EcmfsX51V35ybhH/YoKQnF2d2+QHPWncdXog
         sciAk0Joij9iL6LOqvr1HQqYhPsjaz8q2TjI64Oa2zzI48GsZTJIiTvIeRGE7oEgnplZ
         xUAjhjWjEDgdPM4SxpiIkunyue8co6HI3HmjV/9EmbnZ4ti49o22S8joLrmftoUBwim5
         YZwlMaamfVAuEAyOW12DdloSboOAezRsuYnNJvoB8TZqtajUnFs0HGAa3B4QnpATR6SW
         ZBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747194; x=1705351994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heZMwtmY4JQoXU68UC8Q7sB/5mey2edhuFmP1UH7hEQ=;
        b=f/ZE7gQu2gUSt0jirZ6LHKq0+sYX9hXWse6Z/zZ1kRSnVxrzWYQFYmOFuV0SlCb7++
         O2qlTrdqCk00PZrxTiEwKeTJwnQS0T2pP054A9pbZOkpti5VTCJam8rOwDlvynm3XeTI
         V30fCBdpBulXWriqSSZ+UOQuMdhIwxLqRwdFcMBT/HGCPt4+TZhiIZj3AcJwASx8AG9l
         IcbIF21EZOZVqcQ/qf48Ml1t4HlHuAhsarBAsCBxeg1zJ54UpTbYv4kUMQoDFTd/dkoj
         Iqzbl8rfi5WQxCzYCHETzn2hE2f44pVQSV/BuTvKHbTkm67kyeeR4DGlchOXK1HI4LHu
         AlOg==
X-Gm-Message-State: AOJu0YzCZlPNaYJ2zVn69Oeccj8wbOp8L6qHzWvFL9dcg2fT73479viD
	zBzFcoXFBgJwHKN5h9dacM0=
X-Google-Smtp-Source: AGHT+IF1UHK/6Tr91X6sTrsrkmnOQc1uwSdiOyFRMEiR0l5MkTUc8gJkpYQINKnda0ulk2n6dig0yA==
X-Received: by 2002:a7b:ce10:0:b0:40e:4572:57ea with SMTP id m16-20020a7bce10000000b0040e457257eamr1222047wmc.65.1704747194367;
        Mon, 08 Jan 2024 12:53:14 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906384e00b00a279fa8b3f0sm241537ejc.124.2024.01.08.12.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:53:14 -0800 (PST)
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
Subject: [PATCH bpf-next v2 10/15] bpf: Track spilled unbounded scalars
Date: Mon,  8 Jan 2024 22:52:04 +0200
Message-ID: <20240108205209.838365-11-maxtram95@gmail.com>
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

Support the pattern where an unbounded scalar is spilled to the stack,
then boundary checks are performed on the src register, after which the
stack frame slot is refilled into a register.

Before this commit, the verifier didn't treat the src register and the
stack slot as related if the src register was an unbounded scalar. The
register state wasn't copied, the id wasn't preserved, and the stack
slot was marked as STACK_MISC. Subsequent boundary checks on the src
register wouldn't result in updating the boundaries of the spilled
variable on the stack.

After this commit, the verifier will preserve the bond between src and
dst even if src is unbounded, which permits to do boundary checks on src
and refill dst later, still remembering its boundaries. Such a pattern
is sometimes generated by clang when compiling complex long functions.

One test is adjusted to reflect the fact that an untracked register is
marked as precise at an earlier stage, and one more test is adjusted to
reflect that now unbounded scalars are tracked.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                                   | 7 +------
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 6 +++---
 tools/testing/selftests/bpf/verifier/precise.c          | 6 +++---
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 055fa8096a08..e7fff5f5aa1d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4389,11 +4389,6 @@ static bool __is_scalar_unbounded(struct bpf_reg_state *reg)
 	       reg->u32_min_value == 0 && reg->u32_max_value == U32_MAX;
 }
 
-static bool register_is_bounded(struct bpf_reg_state *reg)
-{
-	return reg->type == SCALAR_VALUE && !__is_scalar_unbounded(reg);
-}
-
 static bool __is_pointer_value(bool allow_ptr_leaks,
 			       const struct bpf_reg_state *reg)
 {
@@ -4504,7 +4499,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		return err;
 
 	mark_stack_slot_scratched(env, spi);
-	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && env->bpf_capable) {
+	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
 		bool reg_value_fits;
 
 		reg_value_fits = get_reg_width(reg) <= BITS_PER_BYTE * size;
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index b05aab925ee5..57eb70e100a3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -452,9 +452,9 @@ l0_%=:	r1 >>= 16;					\
 SEC("raw_tp")
 __log_level(2)
 __success
-__msg("fp-8=0m??mmmm")
-__msg("fp-16=00mm??mm")
-__msg("fp-24=00mm???m")
+__msg("fp-8=0m??scalar()")
+__msg("fp-16=00mm??scalar()")
+__msg("fp-24=00mm???scalar()")
 __naked void spill_subregs_preserve_stack_zero(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 8a2ff81d8350..0a9293a57211 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -183,10 +183,10 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
 	.errstr = "mark_precise: frame0: last_idx 7 first_idx 7\
-	mark_precise: frame0: parent state regs=r4 stack=:\
+	mark_precise: frame0: parent state regs=r4 stack=-8:\
 	mark_precise: frame0: last_idx 6 first_idx 4\
-	mark_precise: frame0: regs=r4 stack= before 6: (b7) r0 = -1\
-	mark_precise: frame0: regs=r4 stack= before 5: (79) r4 = *(u64 *)(r10 -8)\
+	mark_precise: frame0: regs=r4 stack=-8 before 6: (b7) r0 = -1\
+	mark_precise: frame0: regs=r4 stack=-8 before 5: (79) r4 = *(u64 *)(r10 -8)\
 	mark_precise: frame0: regs= stack=-8 before 4: (7b) *(u64 *)(r3 -8) = r0\
 	mark_precise: frame0: parent state regs=r0 stack=:\
 	mark_precise: frame0: last_idx 3 first_idx 3\
-- 
2.43.0


