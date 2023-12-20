Return-Path: <linux-kselftest+bounces-2284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C481A86E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073D21C22ECB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1FB4C62D;
	Wed, 20 Dec 2023 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qorubc3e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661BD4A9BF;
	Wed, 20 Dec 2023 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso813381fa.0;
        Wed, 20 Dec 2023 13:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108439; x=1703713239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJR6xP9fGTUyWDBnp/BMSTW04Tr13zYTm4zsvuB63mw=;
        b=Qorubc3eal5/tHhSo6bDo+j+URwW40h2n5SZ1fb4Qnw5DTHJMqSFYO3FcZyX/hEOIe
         V4loLGusv4+Y00T95ajwxZsh7zJ3Fq9DTvMf0ThvYArHo4IUsfZuPWkIcmk9uSQ01o7D
         4L6A8g0OZTFdRDZbp+YrHr8Yr2DjaKhQVlmpmstL6kOd1KlGL9yOA4zoPfiGBMfhEhct
         o4qpL0jr0+MEDT3ooOVk44EEHs3L4WnuYalgciPlcIwbH7oGeS55ilOQgBpJIpQOAkXg
         WP1whg5g2BiE+72HuNwHxtoATFLf6ftduAQI+gJ3alphMls+kD+d0j29y39aIt7Ysfwy
         lA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108439; x=1703713239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJR6xP9fGTUyWDBnp/BMSTW04Tr13zYTm4zsvuB63mw=;
        b=UgoKuS9lL+XBwPAUbbT55ipqL1VWF1baLZ9qixDI6oMlYe0wiAhTpFj0wXnZ25GWu8
         a8sGL65Dgasr1tz2WO/dZ21iAt0Gb5u1t+9AyBwzYjRAR6oRwBksp6Vdvn8oJMQ92qQr
         gZkwg0495cnKgjf/YRpxyAfbJUBPERduApTabiMukWPYRZCiqM118TlGkis/kYwutvvg
         0T5PD3m8i5oiEThpWuAfGuhb4+XYzXE9uWyUXFO0FUNyxyO8Dklq1n5b4+4QeKqk8p+0
         +T0hUrw8OpfbljM+yyGZbnWd6Lg2Avi+piZ3iz5qugQmWDVrVVrtQJp3lABgQ4GDlnt9
         CxVg==
X-Gm-Message-State: AOJu0Yx+6rTBDM0lZWRIHWbeS9iZBxel2p3AUDclMIEtMZ2+grwTym9+
	euaGk6kCvAoqSItqG9t0qX0=
X-Google-Smtp-Source: AGHT+IFwA3XxyO50Jsk+/XI6kZhAZsUi9Lvn1rCcCr4tShqusjBWIF6jMDRldWwjLCMOJf+k33agzQ==
X-Received: by 2002:a2e:860b:0:b0:2cc:6e37:f0df with SMTP id a11-20020a2e860b000000b002cc6e37f0dfmr3097578lji.34.1703108439073;
        Wed, 20 Dec 2023 13:40:39 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id cn2-20020a0564020ca200b005529a6a185esm288467edb.84.2023.12.20.13.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:38 -0800 (PST)
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
Subject: [PATCH bpf-next 07/15] bpf: Add the get_reg_width function
Date: Wed, 20 Dec 2023 23:40:05 +0200
Message-ID: <20231220214013.3327288-8-maxtram95@gmail.com>
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

Put calculation of the register value width into a dedicated function.
This function will also be used in a following commit.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a703e3adedd3..b757fdbbbdd2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4448,6 +4448,11 @@ static bool is_bpf_st_mem(struct bpf_insn *insn)
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
@@ -4500,7 +4505,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && env->bpf_capable) {
 		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
-		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
+		if (get_reg_width(reg) > BITS_PER_BYTE * size)
 			state->stack[spi].spilled_ptr.id = 0;
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   insn->imm != 0 && env->bpf_capable) {
@@ -13940,7 +13945,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					return -EACCES;
 				} else if (src_reg->type == SCALAR_VALUE) {
 					if (insn->off == 0) {
-						bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;
+						bool is_src_reg_u32 = get_reg_width(src_reg) <= 32;
 
 						if (is_src_reg_u32)
 							assign_scalar_id_before_mov(env, src_reg);
-- 
2.42.1


