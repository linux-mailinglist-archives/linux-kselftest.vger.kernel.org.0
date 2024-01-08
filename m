Return-Path: <linux-kselftest+bounces-2730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8BE827995
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086E4284F21
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C258655E7C;
	Mon,  8 Jan 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEAgeZwQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41914264;
	Mon,  8 Jan 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a271a28aeb4so225710266b.2;
        Mon, 08 Jan 2024 12:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747174; x=1705351974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/2ahyKl2REEzGAF9J7O+/7m1Ul3qlQ5KbFjuAOQvVM=;
        b=XEAgeZwQxXVF6iFQhqyvBW1PKyJPdudjDJmIpQu2CJ4MtMkBl/OVb98t5ZhjKuzhEQ
         FJ982BGkzoWlF/0+U1/VpFbzJwz3pMcs8pI/c/6nuvx3FXo1bKoORoRrvxZA8/ymBA/W
         JgHMXmCVcQdFWDmIrS3rOIms47jLoEqXrr1Qsm6E0d3+5VG4r0gpOTt4glIyvnDCC+Ey
         efDMeXH8LgjY50EZ7NwIXn8IW3MLyslX9gRznSV2HUIrcmCH0ztFruR0ol2NiBlpNMlX
         kqcSeLRJFlrwPvHfK4OL/E9UlYTSNaTuwuiSxxM7wdf9pbQnEvrcKL+kng99vSasgzuu
         wtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747174; x=1705351974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/2ahyKl2REEzGAF9J7O+/7m1Ul3qlQ5KbFjuAOQvVM=;
        b=WUsY206oOGLXW/TjvNaXFgJc7CqkJUxvUEwWCUOIwFHBP+/NbIVoP+OBelnBjAJXGs
         UfIh8DP2qc3tCmUbwQMLNzxDp7poUeFrqplpWfxfoIIs70GhXT4iMHaIWSq/63TVIO0U
         T1pJ9TN/93/wyh+F0OLEctSACT8AkuhsfHEAiOrDlh7JzfkjVS5RT6vhyPoF1AT/OE+4
         RqELkidcFVwffrcR/v+ym+W9IyGWkOqjwfzEsEpeVJc4oCfIZkcPsGdtsp9RY94HZt82
         JN0yPu1zYm3G72z0bvjbSeqf/PNZgQo3PxmVLXUzXbn73icuKcUSskd3tN+FwlEBFUgz
         gZnQ==
X-Gm-Message-State: AOJu0Ywt4EjH1kcPk5ZScQ4TeqdQnqs8TvYRWvOBZ8s6XcEtdthqK2kZ
	Xi15x40uHA5aPHtCFd8VSRQ=
X-Google-Smtp-Source: AGHT+IEW4Gmp1cib7z+Sn7CvDzf8ungGZE5RIbblg019aWmYE3hHr8Vogo/gFCKJbbxEhCJQTeOrOA==
X-Received: by 2002:a17:907:1b0d:b0:a28:d2d9:4e66 with SMTP id mp13-20020a1709071b0d00b00a28d2d94e66mr29058ejc.31.1704747174433;
        Mon, 08 Jan 2024 12:52:54 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id u22-20020a170906781600b00a26af6131e0sm246615ejm.7.2024.01.08.12.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:52:54 -0800 (PST)
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
Subject: [PATCH bpf-next v2 07/15] bpf: Add the get_reg_width function
Date: Mon,  8 Jan 2024 22:52:01 +0200
Message-ID: <20240108205209.838365-8-maxtram95@gmail.com>
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

Put calculation of the register value width into a dedicated function.
This function will also be used in a following commit.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3eff2becd64..4cd82a7c1318 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4450,6 +4450,11 @@ static bool is_bpf_st_mem(struct bpf_insn *insn)
 	return BPF_CLASS(insn->code) == BPF_ST && BPF_MODE(insn->code) == BPF_MEM;
 }
 
+static int get_reg_width(struct bpf_reg_state *reg)
+{
+	return fls64(reg->umax_value);
+}
+
 /* check_stack_{read,write}_fixed_off functions track spill/fill of registers,
  * stack boundary and alignment are checked in check_mem_access()
  */
@@ -4502,7 +4507,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && env->bpf_capable) {
 		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
-		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
+		if (get_reg_width(reg) > BITS_PER_BYTE * size)
 			state->stack[spi].spilled_ptr.id = 0;
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   insn->imm != 0 && env->bpf_capable) {
@@ -13955,7 +13960,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					return -EACCES;
 				} else if (src_reg->type == SCALAR_VALUE) {
 					if (insn->off == 0) {
-						bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;
+						bool is_src_reg_u32 = get_reg_width(src_reg) <= 32;
 
 						if (is_src_reg_u32)
 							assign_scalar_id_before_mov(env, src_reg);
-- 
2.43.0


