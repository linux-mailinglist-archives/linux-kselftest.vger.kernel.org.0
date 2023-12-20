Return-Path: <linux-kselftest+bounces-2287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70681A878
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F82B21539
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49B4D595;
	Wed, 20 Dec 2023 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiblco8s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7224CB2D;
	Wed, 20 Dec 2023 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d12b56a38so1550965e9.2;
        Wed, 20 Dec 2023 13:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108445; x=1703713245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Sevdi2KqnyBVsR9S+9QQjRPndF9K+CdOHtNwLCmtLQ=;
        b=hiblco8sYEvM0mO73LwJ21xf4S604JwzHfmRlUPcnWXYuU3yHjh9pzmUYKWddMJYqO
         ae7h6kGcaF+d1v5s4VSuDJNXLZqkD+wGNUuYBUOoNZ4ZLiI48LBxvXt0fBxyiwyzOvx0
         YZE4R3fogocUa9eDokk92Q5Ru5X+H7EuYsTWzzxVGFboy9VKxj+is3r0PKlqag91Ejdz
         wx9lafaYJzDswBo3OpDdz+0NScwigyVaTOgWIw+YW8U2p+KdNbOdNLwNyWTebtt9BgAD
         3mAGlbMnCcunk9y9Fray3gCOkVi6l/ArpBJL5XtF3ZoWkC7Z945Se8WSHhZezmO8mCue
         SWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108445; x=1703713245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Sevdi2KqnyBVsR9S+9QQjRPndF9K+CdOHtNwLCmtLQ=;
        b=w4rW21fJkW9RiyWNaH3LtJ/8BbIF30CGC+eIyqfI9/KK7PvLOpaT2LYVFlXDY72prL
         IXjk1kSwl5c1P1OZ3XwCoWPcfsoWlnwspoZztDO4Ueb2hhoGfmIkNXleZ453PCZKOgx/
         eOKHmmTkMfogtCUb0hmYRF8oXDQ8+IDO/6HrlstF3SL3riwXPCJ1Fy+InsWan24cpIf6
         zRjEOi6zQhpCd6eFOj6U2QL17vAlwwacZSWFKOYH7Id19en7mw5tlp1hPXQ0aHmn8ixc
         yTFze7A8tqU8IfQ0AhAguvaHqBXFmPAMqL/3RP2WRAaP5y+7dY0reguja4Y4+JfS0K3a
         9Qpg==
X-Gm-Message-State: AOJu0Yx0SXOwQmklzFLYebw9/9aSLPWvW1cEgSWLx2+g+yU8ug40X+GW
	usDjHM9nQIIjr4mnbeeLAvYiHD1ZWrtqAA2I
X-Google-Smtp-Source: AGHT+IH1DHeAOG1n5JfvRzma1Cua678Jcbiy5bho+PhVg0om00YFJOG0hMYvEkXWgS1yIZqHd6C+/Q==
X-Received: by 2002:a05:600c:6d3:b0:40d:38c6:7cec with SMTP id b19-20020a05600c06d300b0040d38c67cecmr88851wmn.299.1703108445118;
        Wed, 20 Dec 2023 13:40:45 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id zs8-20020a170907714800b00a2686db1e81sm243266ejb.26.2023.12.20.13.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:44 -0800 (PST)
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
Subject: [PATCH bpf-next 10/15] bpf: Track spilled unbounded scalars
Date: Wed, 20 Dec 2023 23:40:08 +0200
Message-ID: <20231220214013.3327288-11-maxtram95@gmail.com>
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
---
 kernel/bpf/verifier.c                                   | 7 +------
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 6 +++---
 tools/testing/selftests/bpf/verifier/precise.c          | 6 +++---
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index caa768f1e369..9b5053389739 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4387,11 +4387,6 @@ static bool __is_scalar_unbounded(struct bpf_reg_state *reg)
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
@@ -4502,7 +4497,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		return err;
 
 	mark_stack_slot_scratched(env, spi);
-	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && env->bpf_capable) {
+	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
 		bool reg_value_fits;
 
 		reg_value_fits = get_reg_width(reg) <= BITS_PER_BYTE * size;
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 86881eaab4e2..92e446b18e10 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -454,9 +454,9 @@ l0_%=:	r1 >>= 16;					\
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
2.42.1


