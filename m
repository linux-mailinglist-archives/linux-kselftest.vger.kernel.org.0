Return-Path: <linux-kselftest+bounces-3664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1238183EF36
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 18:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EE81C21FEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 17:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9972D61A;
	Sat, 27 Jan 2024 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUgCB3to"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312312D600;
	Sat, 27 Jan 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706377978; cv=none; b=uOs5zZ+dJxCGPKj6jmS6LibNmeUZguL2czKT7/S9TE+UPIZ5yvt9dXlb+m+tm6qXhW0jAu19T9Zd1UzrvWr7g6CuU+Y3IzVYd2ueWpLu6oNafzVcyrXvZgODfCisS2XLYh7FlmSZhbw7Pvmt33C5r+cgYmhih1uh6/4WeChyToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706377978; c=relaxed/simple;
	bh=VAiI/hRTYsl5Wq3jPFieFFhFWOTUmvZ8ipOqR5Ko1Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvUWxVCkTbQlQZlj5/HTIdMJBGMP0ARzUUAtOQ7jmsjsZ8JYX91aqLtMyOO8dvun61A7VU78HmPNYRFr7DwHiaMK6cJqizP38p3bEO3+mSdZISoNG7oUGMre1Xw8eveoHbw8T1wNN/vYE9Eid+hEMwb/S6HDBZr3hW/SpA7Nu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUgCB3to; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ef0643722so3485635e9.3;
        Sat, 27 Jan 2024 09:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706377975; x=1706982775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=140WdK2PKIttOzK0HYik4RpplzTQ3zPqG6HYXa/6NHA=;
        b=MUgCB3to8TTtMTqdvNPsW7gOlgBRCmBYcNn8YdvI2Cv9oEHFiBT7HKF63pC5SvUuzA
         7fvYz9SXwNbmhzTldJtp014Vs8+Oz4hF0bPiPq7ZDSX8Qn0+cXbVdZGALONgEklCdyOS
         qttLpMRIMT1waWjy7KZ/f13toL1x10NQwVcRBQPfPDFoSpa7t/x9KRvBnNSSRV2COZhr
         yDBJr/mBVZXQ8PtSFe8X0HxQuL18NlzMs5LLxvhXCegP1TUFOtgygbY2yL3IaIDYUxFh
         SjsaRfDAjWwmmofDu5N2204VoiWM5gj2ddiXyj9XEZNebbGz4gVPjcrZLEo0riW4UKBq
         2qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706377975; x=1706982775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=140WdK2PKIttOzK0HYik4RpplzTQ3zPqG6HYXa/6NHA=;
        b=BBZifjBS65gstCElx2df2YFsG8YNgolAm4IjPcEJDu3TsEle297S1p2S0sdYhUzSiH
         lkiIzFFyhSdEJ7Br1eBYZ0PdCqEM+XZZEWneRgmZqmVUGVB6jexzmkgwl9Pcpcx17ABm
         mZxD4itBcCfo5Fkqbpgl2AMXVqmi6H8tuAl5edAjODQrdFOSnk0KWmzJtN02fycJg/7f
         9cvKukeoxO2/rxhLPuAz7SHu+FbTdnqOikV7BEm/Ng0h6f4kqGyGaob/m+sYx1k1ZDTd
         wWfk1Ztg6QcRt7HyI3J59nWWfRQdbtXo78vxZ/w05B1Kd3zSMQSzNzq1ipQLLsYYb6ZG
         /0OA==
X-Gm-Message-State: AOJu0YzvAvs/DwALFx4CmCc44h0DR828J2h2zkVznBR8BpUdwyz+2hIO
	3Dnpr40jYiAiiCiVJ7qHg2B/L5CKLJY8xfTN77PCtA3HOI0DVMWy
X-Google-Smtp-Source: AGHT+IGIROIv3bVw5y84GVGgIcSolBbb5CdoA23ygrQqxfrk56y86APtbiL1QNuKZjDtgk4FbvbgFw==
X-Received: by 2002:adf:e511:0:b0:33a:e75a:6aea with SMTP id j17-20020adfe511000000b0033ae75a6aeamr274965wrm.73.1706377975132;
        Sat, 27 Jan 2024 09:52:55 -0800 (PST)
Received: from localhost ([185.220.101.170])
        by smtp.gmail.com with ESMTPSA id l1-20020a50cbc1000000b00557aa8d72c9sm1801444edi.25.2024.01.27.09.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 09:52:54 -0800 (PST)
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
Subject: [PATCH bpf-next v3 1/6] bpf: Track spilled unbounded scalars
Date: Sat, 27 Jan 2024 19:52:32 +0200
Message-ID: <20240127175237.526726-2-maxtram95@gmail.com>
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

One test is adjusted to reflect that now unbounded scalars are tracked.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                            | 16 +---------------
 .../selftests/bpf/progs/verifier_spill_fill.c    |  6 +++---
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c5d68a9d8acc..f4b9fd0006d1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4380,20 +4380,6 @@ static u64 reg_const_value(struct bpf_reg_state *reg, bool subreg32)
 	return subreg32 ? tnum_subreg(reg->var_off).value : reg->var_off.value;
 }
 
-static bool __is_scalar_unbounded(struct bpf_reg_state *reg)
-{
-	return tnum_is_unknown(reg->var_off) &&
-	       reg->smin_value == S64_MIN && reg->smax_value == S64_MAX &&
-	       reg->umin_value == 0 && reg->umax_value == U64_MAX &&
-	       reg->s32_min_value == S32_MIN && reg->s32_max_value == S32_MAX &&
-	       reg->u32_min_value == 0 && reg->u32_max_value == U32_MAX;
-}
-
-static bool register_is_bounded(struct bpf_reg_state *reg)
-{
-	return reg->type == SCALAR_VALUE && !__is_scalar_unbounded(reg);
-}
-
 static bool __is_pointer_value(bool allow_ptr_leaks,
 			       const struct bpf_reg_state *reg)
 {
@@ -4504,7 +4490,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		return err;
 
 	mark_stack_slot_scratched(env, spi);
-	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && env->bpf_capable) {
+	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
 		bool reg_value_fits;
 
 		reg_value_fits = get_reg_width(reg) <= BITS_PER_BYTE * size;
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 7013a9694163..317806451762 100644
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
-- 
2.43.0


