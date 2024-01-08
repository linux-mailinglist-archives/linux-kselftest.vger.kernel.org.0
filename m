Return-Path: <linux-kselftest+bounces-2729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8085C827990
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32EB1F23FD4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F4955E69;
	Mon,  8 Jan 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYcRyf2I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60155E5D;
	Mon,  8 Jan 2024 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55719cdc0e1so2546040a12.1;
        Mon, 08 Jan 2024 12:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747168; x=1705351968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql4Pqfjh0Jhi1BvTKprb/E446Img2B4kp0cwEWA8FYU=;
        b=jYcRyf2I3h5ZVaJWQjpnKMBsIhGyF1fSN5JYsiChFZwafghzLwoh4oHwHHbAFXfKnk
         Ahh8MVHuFYVdLc4gcg5uB+YISXKnLt8C5nmMLcUjKTm9nSpVBfWAbIJFlFRyktFKT1LQ
         I2e5H9XZ3Fd/msrwQdk1sGmXvoDWJ8VL+QZzCbZxRZKQaVD2v1N79RUcCIG5ZTXKciG2
         qEBgTCFUODe+GQmrONOwSGotqzsITc39zs15HsIRRtiMF9pu9hxJTYWuiRnKXcN98k07
         oMCx53ulbtlHywct56MxIoX6zvFKp9UGKbJN0mk3ZHruRBW1Cx3+mqfLAq5SYi+z627x
         T/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747168; x=1705351968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ql4Pqfjh0Jhi1BvTKprb/E446Img2B4kp0cwEWA8FYU=;
        b=V5+QaaWyRO94rgSNpUEGvbfGOXqP1QeBbzDTSO6MqNAur8qpeVDArV79d74lyo3Xze
         Gq2XMVo2qT7x7RHqr/quOOKbs5/ggOVxDyAAx9cQjCtpXBVVpeAMWVL75MADS3N7vSX6
         gtMcb1hKj2CRyqHU5BzPOeM09KUtwlbdZkgEaFRqsJeYDxcewuN5gsAoOuyH3QHZ7R1k
         WD8EFmw5mfwrahWY/qNrDxgyKjFRVfjkmrQ9O2kOTFZc81b7h/b5EukaAHHTl9749GBP
         vqJnkZoazm6dXkBHL98GgBhWBzLhh04ykX7QYwnwMmIMcVSPgA/RT7emIxIaiMM+ckV/
         R1Mw==
X-Gm-Message-State: AOJu0YxmSM/7mpbqbIvWXpGu3nG49dRt8KIOk6izcITKoTfNzrv+zGDv
	Nog+DoJmGsyvjV9x557zoUs=
X-Google-Smtp-Source: AGHT+IHm3reXS/cS+H3l5RG6G2jaSgJes2s3dXPKqT3uvgOrpu+uBPSL4cznoKTs86c9uLJ6AW11Sw==
X-Received: by 2002:a50:8e53:0:b0:552:7433:23ee with SMTP id 19-20020a508e53000000b00552743323eemr3023958edx.0.1704747168526;
        Mon, 08 Jan 2024 12:52:48 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id i4-20020a056402054400b00555e52fed52sm198492edx.91.2024.01.08.12.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:52:48 -0800 (PST)
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
Subject: [PATCH bpf-next v2 06/15] bpf: Add the assign_scalar_id_before_mov function
Date: Mon,  8 Jan 2024 22:52:00 +0200
Message-ID: <20240108205209.838365-7-maxtram95@gmail.com>
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

Extract the common code that generates a register ID for src_reg before
MOV if needed into a new function. This function will also be used in
a following commit.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bc565f445410..e3eff2becd64 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4403,6 +4403,18 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
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
@@ -13901,20 +13913,13 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -13929,8 +13934,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						bool no_sext;
 
 						no_sext = src_reg->umax_value < (1ULL << (insn->off - 1));
-						if (no_sext && need_id)
-							src_reg->id = ++env->id_gen;
+						if (no_sext)
+							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
 							dst_reg->id = 0;
@@ -13952,8 +13957,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					if (insn->off == 0) {
 						bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;
 
-						if (is_src_reg_u32 && need_id)
-							src_reg->id = ++env->id_gen;
+						if (is_src_reg_u32)
+							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						/* Make sure ID is cleared if src_reg is not in u32
 						 * range otherwise dst_reg min/max could be incorrectly
@@ -13967,8 +13972,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
2.43.0


