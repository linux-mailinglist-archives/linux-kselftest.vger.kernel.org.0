Return-Path: <linux-kselftest+bounces-44051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D47BC0A041
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 23:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474193B9F49
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE15309DCB;
	Sat, 25 Oct 2025 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnVj9OPP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BF3090D7
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426445; cv=none; b=P0yQVMhlVnKH1L7u555ivPUqLCU+0z12qP8UWxQst3HT2s016EJFFMgvjMtNGTEDeNQi6efbyNIPQAMgpTyw7HJq6wGuWGkmNhLRmT6ccEqTgrjEW7HZJLWNQAvfkyecx6tG5sVb2EaPuevZ4WS1IYiwVov4Q9Ro/d5rhwX5Ars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426445; c=relaxed/simple;
	bh=jnr4/IicmhQWUarmW2dk3Y2ffc/gcKbJW3iMq4WfPl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gw6hUxquKObxBIYIPg81ysXJxKdKmvwEV1ErjOC7UNXC9M10Y/NbOUNFCn9ssBod4b8PvbkpF5NFev6dn5sUfxZSG+Z7xk0i3PUU69zyJ7gbpSMFupp+KkOM3hch1voTCp/IjfzwcKgTolnecBn1GNXuiaeELn8HGbQLIvqgVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnVj9OPP; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-592f098f7adso3998199e87.0
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426442; x=1762031242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYGbqwLXExmna8eBWQ52VSI73UhSuti8d9ZiNWksIVc=;
        b=nnVj9OPPGDMIOG7EwFJkrZ6+wtb0SvqVUcp+e6BIMrapD2u/J627g8KAKKPFxTa1hp
         CDUp7vn2feCTTzqr/o1ZBO4UiHAQPmHa+c5WsesM0geVfOVrU1DTpH/J1NLSyOKqLxb4
         +MH3BofX6gUS4Vtc+lxEnU9m6l46bl7+YiZrpKscxHqw5LPeB/rBlaXGu+oLXgd9eMlk
         UgN5y9QpXDiUQQWftO+xTwnxrrXwPNjdXRG4i0bez1Tm52ZYENXzwpVTyhI7jAombOiy
         hOOKXWeuMwjAV5tdbpT4NWQXCbxR40cpiEq0/vmWFxDXGN8VEJsMra64bzJoUA4b56O4
         uQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426442; x=1762031242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYGbqwLXExmna8eBWQ52VSI73UhSuti8d9ZiNWksIVc=;
        b=FR8Yi0K2G5oGcQVe4tkiBYumQVzSMaOTF8cpJdya7cISUl9h2bFFhasyQQVes1qD5Q
         v9rK93y4V0sxBVefrUQZFFpxiT8Dgae81xFWYeQe4kNdRdkKytmNH+rruBqKp2rhY1ug
         49C560HKnc9oqtDkLuz2SaioBO9hfcRgclxBtHxezriN7a5bteok5/Zkdx2d3UoHoT3q
         LmvzZxoFaG6m+ROs2oRfGEy0ZOKf2A4+1XXjh7jVF44gv6rPrxl+tVw8cjHDGU4Bw3Z8
         MDWyZN3Nn/TmptAIYaqvfywzsuU4QPENkiifQuBzVjI0v9vJ7q3tsXluK1vnSOcFYO5g
         ya5A==
X-Forwarded-Encrypted: i=1; AJvYcCUuFLXUXaVaOW0tikiDQ9RxOjhpYKa+jSabEls3q2slYI2ZyeRWPZjPy369bfDojOtIXt3WK3IHGJeLoIlgHHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRuaGWnYCekAw3XT/pp0PBCjYEYQjyDR4qPdPOaexU9T2Glisn
	1zBmtO3pZ18iKwngfPZ+wZOooF5VAe/3KKfRcVC0slqMXqsOWu3X35d3
X-Gm-Gg: ASbGncu/2HMgddagIev55+rpttR2NU46qiprPqj5cyRty7t2H7PqcIHzfYRZnvx+Y7Q
	AJN4fFqnFgRIx1ipOoCR4/k3290Z85KlgDgRzVseBhB24qMzCyxo5ykurf80wCYSir7g2rfEIip
	mPySpGr/YvZ3MwvR2yY4/AmwFYsWtrDGiNlzv+bgqoVKMX++1tOtemBfywkIXYvYPGqW1X2Lcti
	U6fR4WrzHrqZzF1EhzgMtELbdLQbEjL2/UmsaQbq09CEfe2aaxC9RHIDFY9CQmYmt2j2neT1dkG
	rIhKaNk6rnmTjrL2v1Jxiw/vCxdgtxOTDts9kTr1gZMfNeA7WEHGGpzdywB9yrOTj1LTyqtzoGU
	z+h8DpFHusKandYW85KoLNcy2QIMySPxlt6MxOblksoRSzKH4pgZNsbS1BP2LdGIAoXc=
X-Google-Smtp-Source: AGHT+IFE4AmOR394Md1/lG1S5vAU0ggYSm1xV3a69YcH+wAy86ZduiNSo403ld9BIeKBsd0fBst2dQ==
X-Received: by 2002:a05:6512:234c:b0:57a:f38a:397b with SMTP id 2adb3069b0e04-592fc9d6ee3mr2113775e87.3.1761426441425;
        Sat, 25 Oct 2025 14:07:21 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:20 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
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
Subject: [PATCH v3 6/9] riscv: ptrace: validate input vector csr registers
Date: Sun, 26 Oct 2025 00:06:39 +0300
Message-ID: <20251025210655.43099-7-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025210655.43099-1-geomatsi@gmail.com>
References: <20251025210655.43099-1-geomatsi@gmail.com>
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


