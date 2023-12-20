Return-Path: <linux-kselftest+bounces-2289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D95081A87D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C71F1C2308A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69F4CB3A;
	Wed, 20 Dec 2023 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gatysvZV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0234D5B3;
	Wed, 20 Dec 2023 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a233bf14cafso11061466b.2;
        Wed, 20 Dec 2023 13:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108452; x=1703713252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PzRr5+eL+ixCBvU5r2avdkiY9zkp9dVii6UTme9xyo=;
        b=gatysvZV8XHQz5R5g5jkuXyYPZzTaHWlCA3Zi+5CQr6ACKnmJ83L6/nluUO6H/S3pH
         /hXjjPHkoyao0JwSebN5xhdnYxTjTeJd+0V3F66eNGjCY0ae44hilnKWKQwJK/V0yGIh
         RKCD8AySHNWXq9uyKmNtigzIH79wclPFzBfthrh7kY37P+c7z/rqgAmOYW6ybt7vAGg6
         50YRTcXlPTd8AbqrR/Zjonf1AcGitXd+mZ9M7IiVwBZN1+jXfjjyMptnfjEbl98MXmCt
         5ioG5m/Vkft4+jLk1rF0gEMEm64Z1A5BHbDCCS6h2Ux/SpHtvnTRuNN9duC+xXTe38CH
         EaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108452; x=1703713252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PzRr5+eL+ixCBvU5r2avdkiY9zkp9dVii6UTme9xyo=;
        b=g4H5kh595+4K3Noi/ARhqkpkkHWdB0zjSc2a8eHvPwFk+L66m6+eYzcazxHWrhm1W5
         rbDloVJyUyaKX/G+2n6GMb5v62BVvP0hltpdJswlyKfUZb9GSfx6TtQr+tOGU7FjOCc2
         9gcomQtWj/OWtSNtr4+PGJP8MhgApUbK2njPEHe8RglPUOdBxVXAT+jx4ptgEomztVfA
         448AJevf5ZcxzC5FwToiG0iBHjbYJT2pLXu/0QYu3X0R09v85hzsx6+ry0W5gGnLIR/t
         oqCpTdKTqpL768pVTH7QtfoKQ/e0d+VTsd1iCb/kpsDdgweCPI3k9vosrAn+FgUqzy+/
         SsHQ==
X-Gm-Message-State: AOJu0YxHdRw6GZzkxGTfUtxxA2bImwGae7sEiCwQKPvRPPmX876muR8p
	8frWhcoCUgPkKnzabpJJ7/A=
X-Google-Smtp-Source: AGHT+IFTdJ4NPn00O9ReZEd2e/rCXN0KDXDScRnfXD2z/V+jKY10sDsJNx6GQymHzvK3VWPv9Y5C7g==
X-Received: by 2002:a17:907:3c23:b0:a26:8556:e5a0 with SMTP id gh35-20020a1709073c2300b00a268556e5a0mr1337712ejc.66.1703108452438;
        Wed, 20 Dec 2023 13:40:52 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id fi3-20020a1709073ac300b00a269779ea32sm241139ejc.79.2023.12.20.13.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:52 -0800 (PST)
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
Subject: [PATCH bpf-next 12/15] bpf: Preserve boundaries and track scalars on narrowing fill
Date: Wed, 20 Dec 2023 23:40:10 +0200
Message-ID: <20231220214013.3327288-13-maxtram95@gmail.com>
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

When the width of a fill is smaller than the width of the preceding
spill, the information about scalar boundaries can still be preserved,
as long as it's coerced to the right width (done by coerce_reg_to_size).
Even further, if the actual value fits into the fill width, the ID can
be preserved as well for further tracking of equal scalars.

Implement the above improvements, which makes narrowing fills behave the
same as narrowing spills and MOVs between registers.

Two tests are adjusted to accommodate for endianness differences and to
take into account that it's now allowed to do a narrowing fill from the
least significant bits.

reg_bounds_sync is added to coerce_reg_to_size to correctly adjust
umin/umax boundaries after the var_off truncation, for example, a 64-bit
value 0xXXXXXXXX00000000, when read as a 32-bit, gets umin = 0, umax =
0xFFFFFFFF, var_off = (0x0; 0xffffffff00000000), which needs to be
synced down to umax = 0, otherwise reg_bounds_sanity_check doesn't pass.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 kernel/bpf/verifier.c                         | 20 ++++++++++---
 .../selftests/bpf/progs/verifier_spill_fill.c | 28 +++++++++++++------
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b5053389739..b6e252539e52 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4772,7 +4772,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			if (dst_regno < 0)
 				return 0;
 
-			if (!(off % BPF_REG_SIZE) && size == spill_size) {
+			if (size <= spill_size &&
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+			    !(off % BPF_REG_SIZE)
+#else
+			    !((off + size - spill_size) % BPF_REG_SIZE)
+#endif
+			   ) {
 				/* The earlier check_reg_arg() has decided the
 				 * subreg_def for this insn.  Save it first.
 				 */
@@ -4780,6 +4786,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 				copy_register_state(&state->regs[dst_regno], reg);
 				state->regs[dst_regno].subreg_def = subreg_def;
+
+				/* Break the relation on a narrowing fill.
+				 * coerce_reg_to_size will adjust the boundaries.
+				 */
+				if (get_reg_width(reg) > size * BITS_PER_BYTE)
+					state->regs[dst_regno].id = 0;
 			} else {
 				int spill_cnt = 0, zero_cnt = 0;
 
@@ -6055,10 +6067,10 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 	 * values are also truncated so we push 64-bit bounds into
 	 * 32-bit bounds. Above were truncated < 32-bits already.
 	 */
-	if (size < 4) {
+	if (size < 4)
 		__mark_reg32_unbounded(reg);
-		reg_bounds_sync(reg);
-	}
+
+	reg_bounds_sync(reg);
 }
 
 static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 809a09732168..de03e72e07a9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -217,7 +217,7 @@ __naked void uninit_u32_from_the_stack(void)
 
 SEC("tc")
 __description("Spill a u32 const scalar.  Refill as u16.  Offset to skb->data")
-__failure __msg("invalid access to packet")
+__success __retval(0)
 __naked void u16_offset_to_skb_data(void)
 {
 	asm volatile ("					\
@@ -225,19 +225,24 @@ __naked void u16_offset_to_skb_data(void)
 	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
 	w4 = 20;					\
 	*(u32*)(r10 - 8) = r4;				\
-	r4 = *(u16*)(r10 - 8);				\
+	r4 = *(u16*)(r10 - %[offset]);			\
 	r0 = r2;					\
-	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=20 */\
 	r0 += r4;					\
-	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */\
+	/* if (r0 > r3) R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */\
 	if r0 > r3 goto l0_%=;				\
-	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */\
+	/* r0 = *(u32 *)r2 R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */\
 	r0 = *(u32*)(r2 + 0);				\
 l0_%=:	r0 = 0;						\
 	exit;						\
 "	:
 	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
-	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	  __imm_const(offset, 8)
+#else
+	  __imm_const(offset, 6)
+#endif
 	: __clobber_all);
 }
 
@@ -270,7 +275,7 @@ l0_%=:	r0 = 0;						\
 }
 
 SEC("tc")
-__description("Spill a u32 const scalar.  Refill as u16 from fp-6.  Offset to skb->data")
+__description("Spill a u32 const scalar.  Refill as u16 from MSB.  Offset to skb->data")
 __failure __msg("invalid access to packet")
 __naked void _6_offset_to_skb_data(void)
 {
@@ -279,7 +284,7 @@ __naked void _6_offset_to_skb_data(void)
 	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
 	w4 = 20;					\
 	*(u32*)(r10 - 8) = r4;				\
-	r4 = *(u16*)(r10 - 6);				\
+	r4 = *(u16*)(r10 - %[offset]);			\
 	r0 = r2;					\
 	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
 	r0 += r4;					\
@@ -291,7 +296,12 @@ l0_%=:	r0 = 0;						\
 	exit;						\
 "	:
 	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
-	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	  __imm_const(offset, 6)
+#else
+	  __imm_const(offset, 8)
+#endif
 	: __clobber_all);
 }
 
-- 
2.42.1


