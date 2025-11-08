Return-Path: <linux-kselftest+bounces-45186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25710C433EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 20:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15ED0188D6FE
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 19:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E62B27D77D;
	Sat,  8 Nov 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMH6eU0/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A797287259
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630962; cv=none; b=pNEZqRP+Z5oz0r4XRmvBQZgVMBcyAnuP/f3tBpjw/2N8SkZj6RX5Jukhi1le5AMc7kj+upew+tLkmumzng3sgRqDQYYlKr0k5S0BQAYoawPH4e8FuZo5KCKtcGxd7f8ghjqdAib1hUCwVK59BXPSjEuJZuflquuciXBtgrT6UXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630962; c=relaxed/simple;
	bh=jnr4/IicmhQWUarmW2dk3Y2ffc/gcKbJW3iMq4WfPl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNBGJy8ryBFqBNk75PPqdunSv11HNJXNc5Imo7JFZwTilDOSLTECvti87frLHKSG7V2ZNgN/uTTnNojOJN5I/ZVRrdaoaTVYhrr9SMzBRsyC9JEgw4wo4kACt/pvPL2BWos0Y/0DtpNbIkkM+YEsWFJmaonizD2BRcBGn4cO2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMH6eU0/; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3737d0920e6so21427271fa.1
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630958; x=1763235758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYGbqwLXExmna8eBWQ52VSI73UhSuti8d9ZiNWksIVc=;
        b=kMH6eU0/iTjepgzoJ8NitP6u/FQv7uxZY3PJ8Z0EYffEWMDx1NWYtEYD9JchUh90QO
         ib5RT/0MNry/3eDh+6DYFbXQnoi92ye7fODYqWj7O8E01nKQXQ5s2E8xQN1waDCLxE2u
         BcCEBfm4V7+6mG7y+0YlHIka0O+/z5Cf1FEAK8hV62eUtjPQDXaDVpkx3HQGmjUtgiWJ
         hJv9VYuu2jB00TDI1p9Qhvhnbve8/egnangDU5kyptqrngUds1Vn1j4pjg3TpwvdVbB+
         PLRLe/xhtNVlAT5zHbZX5f5rMpAZ/6DpQw+WBQclEJS9CsLADiOpPYqTC7c2LG7JfItv
         b61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630958; x=1763235758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYGbqwLXExmna8eBWQ52VSI73UhSuti8d9ZiNWksIVc=;
        b=tqmqN8jhPb6BEAIQlEqXQVd8jbpCkfuhB4ECZ3MfvzUdeturAoiG4uFT7eO7IvH1I/
         Q8UgNcBtWu/Qj1rw/3m34Jw6Y/qUzAlDClQUUVmmO8d6Una2zVSPFt4JGhYzo5usmh1P
         GnfM5oeC5IpgJEYiw9tj+xngR3XIhj5dX9ycymrh5ceDj0QOea2IoeVs0S6g2Denkk9I
         ju5rBZJe5cc8B+vAA8qDIIHfu94cC5wxbhr8cQ1p17VzXAvIizRiqb6DNpsQbMAaWraU
         H/2lXopTo9aAiVMnSNk77INDQbC0G7r1ZvMgm7o7ntvBgKlL7SO1X+nErUl/xZ+HTSim
         yZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN62kR3chy5ZEubSNNnEJeD8Ht2v5R0zT7Sj36GHUPKlv22qJbZX8CHgQdGUJo4v6aUsq5VlrCV0vNNcoAEl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsjWX3UDybSM35/HONvYN0xM8gIaMB40zdhg0/OlJ36LStKqQQ
	jMmcYRKBreFYWhUBFxbWmExfV5fKa+/eMSn1nhYC2GA+SD700T/0Smw/
X-Gm-Gg: ASbGnctEN+bgFAFqKU9PrQpd0/URu0l+xLIdmpLDu25HE0ffTEaqdteg9svVwXHR+IT
	qzFxJqSK8kIepaREpfC1bs7F8P9Kucz8BBKhn0M2i6+npVIbTgPtkcaWFp7G3dEHKrgYj+KYn3I
	diVJbyCayS7jG/smEEt7ZBCcapTgM/Z2nQXN5vPv8zfLu+vKj6Q4r6zzkwy/p+/UZ5qePPuJRqD
	FWBK6dx+frog20TGQ76DrL+tXak6l5eOl+1Jt97sAhvxqDLGRve2QQ+r8wOqsyL2QEOibXTHZwG
	orQ4mhS6Rm6wI+gWMAxsGLP6K2v4bVx43aScTXetgK+pNfnb7ysrzEDzIfdrQNC01u3rNkzupJj
	0otQtzpIrN4lnUvTiKEr6X4ckZ2LhIarseNHZIybWeOkzmGCA57dS1ew3rw1RZwcCOPsM0vAkP4
	a/Kg==
X-Google-Smtp-Source: AGHT+IGCGTuLFvx1ywHQFavK6M7uVgMXiMcQh8hxSwydElhFvD3mPQcbttpE9Nqhi6nEDN0y6TVfhQ==
X-Received: by 2002:a05:6512:3da6:b0:591:c862:2b2e with SMTP id 2adb3069b0e04-5945f205993mr991066e87.45.1762630957976;
        Sat, 08 Nov 2025 11:42:37 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:36 -0800 (PST)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v4 6/9] riscv: ptrace: validate input vector csr registers
Date: Sat,  8 Nov 2025 22:41:45 +0300
Message-ID: <20251108194207.1257866-7-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108194207.1257866-1-geomatsi@gmail.com>
References: <20251108194207.1257866-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add strict validation for vector csr registers when setting them via
ptrace:
- reject attempts to set reserved bits or invalid field combinations
- enforce strict VL checks against calculated VLMAX values

Vector spec 1.0 allows normal applications to set candidate VL values
and read back the hardware-adjusted results, see section 6 for details.
Disallow such flexibility in vector ptrace operations and strictly
enforce valid VL input.

The traced process may not update its saved vector context if no vector
instructions execute between breakpoints. So the purpose of the strict
ptrace approach is to make sure that debuggers maintain an accurate view
of the tracee's vector context across multiple halt/resume debug cycles.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/kernel/ptrace.c | 62 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 906cf1197edc..a567e558e746 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -124,6 +124,66 @@ static int riscv_vr_get(struct task_struct *target,
 	return membuf_write(&to, vstate->datap, riscv_v_vsize);
 }
 
+static int invalid_ptrace_v_csr(struct __riscv_v_ext_state *vstate,
+				struct __riscv_v_regset_state *ptrace)
+{
+	unsigned long vsew, vlmul, vfrac, vl;
+	unsigned long elen, vlen;
+	unsigned long sew, lmul;
+	unsigned long reserved;
+
+	if (!has_vector())
+		return 1;
+
+	vlen = vstate->vlenb * 8;
+	if (vstate->vlenb != ptrace->vlenb)
+		return 1;
+
+	reserved = ~(CSR_VXSAT_MASK | (CSR_VXRM_MASK << CSR_VXRM_SHIFT));
+	if (ptrace->vcsr & reserved)
+		return 1;
+
+	/* do not allow to set vill */
+	reserved = ~(VTYPE_VSEW | VTYPE_VLMUL | VTYPE_VMA | VTYPE_VTA);
+	if (ptrace->vtype & reserved)
+		return 1;
+
+	elen = riscv_has_extension_unlikely(RISCV_ISA_EXT_ZVE64X) ? 64 : 32;
+	vsew = (ptrace->vtype & VTYPE_VSEW) >> VTYPE_VSEW_SHIFT;
+	sew = 8 << vsew;
+
+	if (sew > elen)
+		return 1;
+
+	vfrac = (ptrace->vtype & VTYPE_VLMUL_FRAC);
+	vlmul = (ptrace->vtype & VTYPE_VLMUL);
+
+	/* RVV 1.0 spec 3.4.2: VLMUL(0x4) reserved */
+	if (vlmul == 4)
+		return 1;
+
+	/* RVV 1.0 spec 3.4.2: (LMUL < SEW_min / ELEN) reserved */
+	if (vlmul == 5 && elen == 32)
+		return 1;
+
+	/* for zero vl verify that at least one element is possible */
+	vl = ptrace->vl ? ptrace->vl : 1;
+
+	if (vfrac) {
+		/* integer 1/LMUL: VL =< VLMAX = VLEN / SEW / LMUL */
+		lmul = 2 << (3 - (vlmul - vfrac));
+		if (vlen < vl * sew * lmul)
+			return 1;
+	} else {
+		/* integer LMUL: VL =< VLMAX = LMUL * VLEN / SEW */
+		lmul = 1 << vlmul;
+		if (vl * sew > lmul * vlen)
+			return 1;
+	}
+
+	return 0;
+}
+
 static int riscv_vr_set(struct task_struct *target,
 			const struct user_regset *regset,
 			unsigned int pos, unsigned int count,
@@ -145,7 +205,7 @@ static int riscv_vr_set(struct task_struct *target,
 	if (unlikely(ret))
 		return ret;
 
-	if (vstate->vlenb != ptrace_vstate.vlenb)
+	if (invalid_ptrace_v_csr(vstate, &ptrace_vstate))
 		return -EINVAL;
 
 	vstate->vstart = ptrace_vstate.vstart;
-- 
2.51.0


