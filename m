Return-Path: <linux-kselftest+bounces-47568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F65ACBBD84
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 17:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93D1730161CA
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1152E0407;
	Sun, 14 Dec 2025 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGHYjmsv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B3C2DF136
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730155; cv=none; b=gHaKgCpWo8v/Q/1T9mrAgX8bvr6EvdIX/oomajhVfWhDWVG5/k9A1ORMxDCFHy2QN8oecf5+/Od+iGO2olFoJ1mFYwOioexSO0aS6kchoUAMI1J+cDJdnSavJj9oneEpDRQJEaUdzUQdpZpatdhSPia5VQkmcjxxoydU767r6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730155; c=relaxed/simple;
	bh=c2ITgKh/hX1hEC+RdjZYoXCbPi0eRRb5EFMAxzFiNZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRoaDv79vHUQ/Hkfk/dEf/iZ/iT2YDaubY+QL1GQAjD2/9coJ66wsdKzSKCMNcD39YUxnjeZ5hQHrqllZ2Ppj58msJIXeCF8wZOSjlFhOUGAxNR+TYPjcQX9gfDkDxzDKypUMHrsSM+hgLVSwytsN06XcEct83AjhcWcQJ0KTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGHYjmsv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59581e32163so3125485e87.1
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765730152; x=1766334952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ceN7tYN/gKBBlWayVud/16shc9bGATzOqOE1jrkBy4=;
        b=AGHYjmsv8k8gG5dSm5xBfCevbefCfZWl9V3Bhk2gGRoCcXm6MbfN9a7sU559Ph9kqb
         Uqtjj8wxRSwNokinW9YBeiN3s6yBNgJBEYLA1TTcQ2WNnYJfUC6kMCTupcc0+oEOmZkf
         MlEv4IeFnORLUiTIyskO6nb8920eBM+E0M/8y386abUWyTAuLWjALq4ShUv70ErMgw0H
         n59ehTIlsOInOHJXpSTfTgBKUaMY2VDE4txuPYRzE/+QN02KbPlL+ouAyCDG97Zr6Pea
         Svju8+9yzjPWFjtI2yYn2JzWp+ehwe2dYYeeXjDyzEXfb8oDCSFglyvA90kXDOzBE2im
         XUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765730152; x=1766334952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ceN7tYN/gKBBlWayVud/16shc9bGATzOqOE1jrkBy4=;
        b=pTUPcisaUw6/PBP6mrqBwqUVvNISU+RtKSFbf+SrxfqYAfsRkWBBxJWGOH4hSgCtcR
         FmrOXLVljbNmDBhC1z9+l8GSFuiPARAxXIwrJv5bPBcC3sloUJ8uKF4WnX6+ZhuL+E0o
         Z7h5TygY1Oa6cnzrRj+pZbsmeWfL+ms5K3phVd8yQ8+gH4EtCgjg8Rh3bb9YXanz6Cv7
         p3kU72TRe3lbdA+HhfAN7wPWuWAirHRKHTdOEQTAilVK7PbzHJ3Vch0hPIWfxNPKlae7
         r6JlaTXWydSrEum92DTKHhcarEMeSTuYnlgAb0asgLocDOSththf8fbsZSQGbwnDtVPv
         tceA==
X-Forwarded-Encrypted: i=1; AJvYcCUmQL0/F8vgPhw0eOdXCYPvQ1vn4J9NvQZ0dasxQFeqGK3XT3FXw2Dt4ugTKCWxF9F7QPWTrOGCb/Y1T33J5pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+HuX1vGrnuUrk7o91AjRea2GWCl1bts75gF+dijvN3JNtwvX
	4l/UnudZ/4rXk3aeXE56E67HJSanC/Cjpv3eVYHQHwFrDF8nirRuw1Pv
X-Gm-Gg: AY/fxX5Pi3jCqciIVXOEKufDst9jU4uV/m8MJVIZd/uUN78BtHE0p+pUXR/d1tzvKso
	sBKNXi8rJR46Hb+IfLllRrWlZr6UrmKj5Bs2a3V/LkmWXL2Ca11Abhu3v7gNo287xJGYnH2NIz0
	R/0ilvJLpTA/0rVimbmBICgyGIn1nrvAc5SlwAwYF/Bk4Dmde0IcbTLNx/F1en0N+xrvsOZs7XA
	rBQSEieuiE1i1NPdvb1wxyn2U+FwfEsR3rUuRIfmLJMF1ydP/uHLUnSGpaZcpwxYZ7HM2ladWV2
	AaRbCiLLyztZc6ZzaMPZ+vfejlR63AiLBlkcHhKidhO+YX+BqJLRn5CpdU0v+AFp04IoL3bowgO
	fJt00WUwtk5dsvkPqYWxTGxB4QZiGa0s8rd6ApLKj8mExv5kCf4TPr/VjadYqdBjZ0fypnc1ubo
	CuMA==
X-Google-Smtp-Source: AGHT+IE7dE3l70YGYPB3y3zq32vN+TmUO6rInc0cqfa6GCb0iUkaJd/dRh0REzAP8I/RflxLSnRQhw==
X-Received: by 2002:a05:6512:1390:b0:598:e9f9:bdd with SMTP id 2adb3069b0e04-598faa805e5mr2916040e87.27.1765730151386;
        Sun, 14 Dec 2025 08:35:51 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-598f7717b79sm3789618e87.60.2025.12.14.08.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:35:50 -0800 (PST)
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
	Guo Ren <guoren@kernel.org>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v5 4/9] riscv: ptrace: validate input vector csr registers
Date: Sun, 14 Dec 2025 19:35:08 +0300
Message-ID: <20251214163537.1054292-5-geomatsi@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251214163537.1054292-1-geomatsi@gmail.com>
References: <20251214163537.1054292-1-geomatsi@gmail.com>
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

Vector specs 0.7.1 and 1.0 allow normal applications to set candidate
VL values and read back the hardware-adjusted results, see section 6
for details. Disallow such flexibility in vector ptrace operations
and strictly enforce valid VL input.

The traced process may not update its saved vector context if no vector
instructions execute between breakpoints. So the purpose of the strict
ptrace approach is to make sure that debuggers maintain an accurate view
of the tracee's vector context across multiple halt/resume debug cycles.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/kernel/ptrace.c | 88 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 9d203fb84f5e..5d18fe241697 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -124,6 +124,92 @@ static int riscv_vr_get(struct task_struct *target,
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
+	vlen = vstate->vlenb * 8;
+	if (vstate->vlenb != ptrace->vlenb)
+		return 1;
+
+	/* do not allow to set vcsr/vxrm/vxsat reserved bits */
+	reserved = ~(CSR_VXSAT_MASK | (CSR_VXRM_MASK << CSR_VXRM_SHIFT));
+	if (ptrace->vcsr & reserved)
+		return 1;
+
+	if (has_vector()) {
+		/* do not allow to set vtype reserved bits and vill bit */
+		reserved = ~(VTYPE_VSEW | VTYPE_VLMUL | VTYPE_VMA | VTYPE_VTA);
+		if (ptrace->vtype & reserved)
+			return 1;
+
+		elen = riscv_has_extension_unlikely(RISCV_ISA_EXT_ZVE64X) ? 64 : 32;
+		vsew = (ptrace->vtype & VTYPE_VSEW) >> VTYPE_VSEW_SHIFT;
+		sew = 8 << vsew;
+
+		if (sew > elen)
+			return 1;
+
+		vfrac = (ptrace->vtype & VTYPE_VLMUL_FRAC);
+		vlmul = (ptrace->vtype & VTYPE_VLMUL);
+
+		/* RVV 1.0 spec 3.4.2: VLMUL(0x4) reserved */
+		if (vlmul == 4)
+			return 1;
+
+		/* RVV 1.0 spec 3.4.2: (LMUL < SEW_min / ELEN) reserved */
+		if (vlmul == 5 && elen == 32)
+			return 1;
+
+		/* for zero vl verify that at least one element is possible */
+		vl = ptrace->vl ? ptrace->vl : 1;
+
+		if (vfrac) {
+			/* integer 1/LMUL: VL =< VLMAX = VLEN / SEW / LMUL */
+			lmul = 2 << (3 - (vlmul - vfrac));
+			if (vlen < vl * sew * lmul)
+				return 1;
+		} else {
+			/* integer LMUL: VL =< VLMAX = LMUL * VLEN / SEW */
+			lmul = 1 << vlmul;
+			if (vl * sew > lmul * vlen)
+				return 1;
+		}
+	}
+
+	if (has_xtheadvector()) {
+		/* do not allow to set vtype reserved bits and vill bit */
+		reserved = ~(VTYPE_VSEW_THEAD | VTYPE_VLMUL_THEAD | VTYPE_VEDIV_THEAD);
+		if (ptrace->vtype & reserved)
+			return 1;
+
+		/*
+		 * THead ISA Extension spec chapter 16:
+		 * divided element extension ('Zvediv') is not part of XTheadVector
+		 */
+		if (ptrace->vtype & VTYPE_VEDIV_THEAD)
+			return 1;
+
+		vsew = (ptrace->vtype & VTYPE_VSEW_THEAD) >> VTYPE_VSEW_THEAD_SHIFT;
+		sew = 8 << vsew;
+
+		vlmul = (ptrace->vtype & VTYPE_VLMUL_THEAD);
+		lmul = 1 << vlmul;
+
+		/* for zero vl verify that at least one element is possible */
+		vl = ptrace->vl ? ptrace->vl : 1;
+
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
@@ -145,7 +231,7 @@ static int riscv_vr_set(struct task_struct *target,
 	if (unlikely(ret))
 		return ret;
 
-	if (vstate->vlenb != ptrace_vstate.vlenb)
+	if (invalid_ptrace_v_csr(vstate, &ptrace_vstate))
 		return -EINVAL;
 
 	vstate->vstart = ptrace_vstate.vstart;
-- 
2.52.0


