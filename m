Return-Path: <linux-kselftest+bounces-2283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09181A86B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD1B288B5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396524C616;
	Wed, 20 Dec 2023 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/YzQOxp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739F84C3B7;
	Wed, 20 Dec 2023 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so189886e87.3;
        Wed, 20 Dec 2023 13:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108437; x=1703713237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCR2AWe8CH/pwYf56t8XoxHbIux/alGXqT7pZRazkTo=;
        b=c/YzQOxpL/doambL6DwaXcXxI9aO1o8/huMsixmKRUpeQeKzxFmN8RiIqTnN60QDzV
         k3jN7+frQ376L6fmVST3NaBw2twAlScKvuKtickI/MZz1IB+j2IlIVvoK0EbB/NnJPnA
         udEwrfK74j6BA4JXGLdM3HfuQbeQ7HGNjUuYpJt9/snJctu0e38KC3HyOlTgGHJkyoOk
         R/4vPuwakaZMuiVzoRwv4emsTXEy9DY1okn1cP10pN+gqajS/RzRjXDtoZtG0ba+ALNi
         hDDl0iDdIv7PhCcBqNQJDuViM8FZHvUwMCy+WuMS01V91vG5Bf99ugeSRNHS2mRTYPhJ
         3Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108437; x=1703713237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCR2AWe8CH/pwYf56t8XoxHbIux/alGXqT7pZRazkTo=;
        b=BdZ3mxEIUCXMfZ4nXYDh6ioP3MapDqoqd/zXeKA6NdEze58WRinyIAiF+KDZHTLICD
         EYlWpV3Dw2F6T5Ip3MRX0xZADSbZKlUbWlOBWQmdFuLIeHk3vjpq/HPvOyOzP4/lQp0j
         yBk/d9WL0udq9b3x0wJ3p/1FYrQ9HQDZRTEUhYwqe+Yosa+UalcnEFTY6nCzCuXo/fy1
         w9ReSSmOpksYcJe1y+7yTCXy4/gszGchLZ8zEOTK7Dt9NehS+S06koSNlX9BndIpinfs
         TFkwnBFnIYvEA5gISXqM1e8mhNRUmQ14TKYk6d+3PIm5g6OQ4WIkDnCQmctajyBN0IFZ
         fOQA==
X-Gm-Message-State: AOJu0Yy2zeZgJrMCku1u9oe2BUOkL1pG/ycgOmOYb4wQS6b8CsqO+H82
	Ekd+15y0vDMOEaDbcu0VmZU=
X-Google-Smtp-Source: AGHT+IEsQljel7SOO/Bsutvovti6Jf3zmzicRNLYYglxCWca3X4elleb8WRQOdJXiqmYXDr/tTy2qA==
X-Received: by 2002:a19:9146:0:b0:50e:5ac7:2f83 with SMTP id y6-20020a199146000000b0050e5ac72f83mr84530lfj.55.1703108437086;
        Wed, 20 Dec 2023 13:40:37 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id wb1-20020a170907d50100b00a2300127f26sm233133ejc.185.2023.12.20.13.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:36 -0800 (PST)
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
Subject: [PATCH bpf-next 06/15] bpf: Add the assign_scalar_id_before_mov function
Date: Wed, 20 Dec 2023 23:40:04 +0200
Message-ID: <20231220214013.3327288-7-maxtram95@gmail.com>
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

Extract the common code that generates a register ID for src_reg before
MOV if needed into a new function. This function will also be used in
a following commit.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 kernel/bpf/verifier.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 89f8c527ed3c..a703e3adedd3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4401,6 +4401,18 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	return reg->type != SCALAR_VALUE;
 }
 
+static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
+					struct bpf_reg_state *src_reg)
+{
+	if (src_reg->type == SCALAR_VALUE && !src_reg->id &&
+	    !tnum_is_const(src_reg->var_off))
+		/* Ensure that src_reg has a valid ID that will be copied to
+		 * dst_reg and then will be used by find_equal_scalars() to
+		 * propagate min/max range.
+		 */
+		src_reg->id = ++env->id_gen;
+}
+
 /* Copy src state preserving dst->parent and dst->live fields */
 static void copy_register_state(struct bpf_reg_state *dst, const struct bpf_reg_state *src)
 {
@@ -13886,20 +13898,13 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		if (BPF_SRC(insn->code) == BPF_X) {
 			struct bpf_reg_state *src_reg = regs + insn->src_reg;
 			struct bpf_reg_state *dst_reg = regs + insn->dst_reg;
-			bool need_id = src_reg->type == SCALAR_VALUE && !src_reg->id &&
-				       !tnum_is_const(src_reg->var_off);
 
 			if (BPF_CLASS(insn->code) == BPF_ALU64) {
 				if (insn->off == 0) {
 					/* case: R1 = R2
 					 * copy register state to dest reg
 					 */
-					if (need_id)
-						/* Assign src and dst registers the same ID
-						 * that will be used by find_equal_scalars()
-						 * to propagate min/max range.
-						 */
-						src_reg->id = ++env->id_gen;
+					assign_scalar_id_before_mov(env, src_reg);
 					copy_register_state(dst_reg, src_reg);
 					dst_reg->live |= REG_LIVE_WRITTEN;
 					dst_reg->subreg_def = DEF_NOT_SUBREG;
@@ -13914,8 +13919,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						bool no_sext;
 
 						no_sext = src_reg->umax_value < (1ULL << (insn->off - 1));
-						if (no_sext && need_id)
-							src_reg->id = ++env->id_gen;
+						if (no_sext)
+							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
 							dst_reg->id = 0;
@@ -13937,8 +13942,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					if (insn->off == 0) {
 						bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;
 
-						if (is_src_reg_u32 && need_id)
-							src_reg->id = ++env->id_gen;
+						if (is_src_reg_u32)
+							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						/* Make sure ID is cleared if src_reg is not in u32
 						 * range otherwise dst_reg min/max could be incorrectly
@@ -13952,8 +13957,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						/* case: W1 = (s8, s16)W2 */
 						bool no_sext = src_reg->umax_value < (1ULL << (insn->off - 1));
 
-						if (no_sext && need_id)
-							src_reg->id = ++env->id_gen;
+						if (no_sext)
+							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
 							dst_reg->id = 0;
-- 
2.42.1


