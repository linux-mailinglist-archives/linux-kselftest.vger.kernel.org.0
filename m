Return-Path: <linux-kselftest+bounces-47565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A9CBBD81
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 17:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C5530046F1
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B572DAFDD;
	Sun, 14 Dec 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBn5j95L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B312DAFA2
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730150; cv=none; b=tbbkW9yg29VoNmJ5wPRtuoReR1/bAqnE4fNhVSq6dJ8dhSgqsmWWrPSvVI3yoCPtLJk5WL3ic3KOOP5oF4EH1O1eEbG2dvggU5XuiPdtuEkEcdLH31MTcVZLhVzc2vLMAA3TfYETO/nZWHpanBXup3uWL7W2i62H49+jUUtGa3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730150; c=relaxed/simple;
	bh=TBdUIziZzYn57JBzVZKpq91vrwab2KkoD2+h2KvN5+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPkI2k+/nQPuZy8pN2Q+w+r9/zEA1zA9SYdfO1uQJ03kXCW/4d/wxl7eJ2MiEEsWaU5ZLOTpSbPYzYKbZCfyqENOHfeEHasMxfG8+ve/51CmZWKMN+SnA6fwjsFlMsate/+LEAnvPyT06qC4Ims/lkOxdUVL1adEbBKQLHtBpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBn5j95L; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-597d712c0a7so3265058e87.0
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 08:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765730147; x=1766334947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYG0UzrVNvu+sJ+OoGaiC09VrdPSEEepGbXjW8i1wGU=;
        b=IBn5j95LsDo+QFYQJN3jy4CYt0d072oCw3Ofzv45OVR7OD7kEvp8O4ChEyul6UnXyx
         UDwHJPfGdoPBJjj5jYNdzKzKNLcaww++Otb0e9TZGRWQevlRilYVFYlqFCxpnpLZWJov
         IXv5AJT3PMQPMvo0//8uXP+/vADGSgilMLw27bMeS8aInByNqJ/DhzkLMcCRwDuCRj7g
         JomowR8T/rpAIcZpzqzcFiSHP7jJnthE2YsiCvrxKY0PV8kUY8TldGEVpMIfGHyMCnZl
         ggqlYzpBc7taJFAtdVJrK/VD0zp1o3GF5USobqyvv95MxmOtOd0s6NEHBJqU4U1K7Bke
         ymqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765730147; x=1766334947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iYG0UzrVNvu+sJ+OoGaiC09VrdPSEEepGbXjW8i1wGU=;
        b=MC59PPyUTnXXoKX4RBllVZ9zbXU17FQVb7qCnIsHMBvHmb3ZivypA3/BMt1OcIOGWF
         EejdxCeMMBxosW0MU072/ZbRDzAXYi2+LkBQgyuocbMc5R4FfSaXs0RFKZR0k7s5k5vy
         SDxCzxDUArg5zaR+T4J37aRCm9GS0VFKooNn17IEx+NAWtnQi+/zptU8eTKYLM9216kC
         EVEpW1cytq4sLZlpiWpMlmJXpsrkGQov1shgdU+0dRRNsa4NPufG1dpuLbGEUS53nBdL
         0QXWvuAQR6lcV94//QduS2tszI3SFghvrJeEfSHRpatXuD9V4APtowKN97+E3MHNnIEy
         +deA==
X-Forwarded-Encrypted: i=1; AJvYcCXNJtMMoTjAbajnoAH8bTFJhR5NrOoj1upo7lTgAeTn/m6rqJL1z2ULUZ+v6W0r2yf31mEKSh45UqxyXgYGtDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRv3KRf/aTJJxRFZcJ57eZkVw+CdSs4czIJtrkubh6Wi/rmpSo
	pSqKoK5Tx1tVmw0fSPZhzKMpGWw2ZPG2bxCZQJKpZq4rg8Cu7zNuuSW7
X-Gm-Gg: AY/fxX58h8+FtPSZ35e+2f/a8kMEQ10cZkmmBEJydISEamJ4I132maIiKJQQDuv+UL5
	EINT5pHD0dmweHap0bFFwdD/9SPqeJNZJdK/RH8OAYF93G2FujCSTCjItXvgUBIyuRAdprU6FRN
	JBZ/glDtu4K5Mo/r6jZO0jEdmv8Z/MwqG7ONBePLBKaXk0KWLpsHMGS5pW7dWO0+aDWBaldxCA+
	fFeQcuNI36ZwviGBJ6UpFt07gT/q6LaffLSyJbvCJcL7Y/e9wTr1R8XivskC0WdkNjsDZr/WBps
	z6G7hC8k9MifFca9Q+EIOOBBEAhQVYrYsBIkBVNM5ttmeFc+W9P/ENRRbcAVuKwa1Yq56WENFxA
	NhuATf7KakW4WaUvWo4r0tfD2C/FfCXCZMLCUX7VD3a2gdv7a30wU3GiqBhIZ9qJRuBL7EHAHJz
	u1eQ==
X-Google-Smtp-Source: AGHT+IFa8YrKVxWZ8N5CZhPJ/l8DS6QHhWtXFyJ2Kk/ViapXJFN4nzGXTae+4TaN+8nHnP2k0U2DqA==
X-Received: by 2002:a05:6512:3d23:b0:577:318a:a1c6 with SMTP id 2adb3069b0e04-598faa448aemr2580474e87.23.1765730146784;
        Sun, 14 Dec 2025 08:35:46 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-598f7717b79sm3789618e87.60.2025.12.14.08.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:35:46 -0800 (PST)
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
	Sergey Matyukevich <geomatsi@gmail.com>,
	Ilya Mamay <mmamayka01@gmail.com>
Subject: [PATCH v5 1/9] riscv: ptrace: return ENODATA for inactive vector extension
Date: Sun, 14 Dec 2025 19:35:05 +0300
Message-ID: <20251214163537.1054292-2-geomatsi@gmail.com>
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

From: Ilya Mamay <mmamayka01@gmail.com>

Currently, ptrace returns EINVAL when the vector extension is supported
but not yet activated for the traced process. This error code is not
always appropriate since the ptrace arguments may be valid.

Debug tools like gdbserver expect ENODATA when the requested register
set is not active, e.g. see [1]. This expectation seems to be more
appropriate, so modify the vector ptrace implementation to return:
- EINVAL when V extension is not supported
- ENODATA when V extension is supported but not active

[1] https://github.com/bminor/binutils-gdb/blob/637f25e88675fa47e47f9cc5e2cf37384836b8a2/gdbserver/linux-low.cc#L5020

Signed-off-by: Ilya Mamay <mmamayka01@gmail.com>
Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/kernel/ptrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index e6272d74572f..9d203fb84f5e 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -95,9 +95,12 @@ static int riscv_vr_get(struct task_struct *target,
 	struct __riscv_v_ext_state *vstate = &target->thread.vstate;
 	struct __riscv_v_regset_state ptrace_vstate;
 
-	if (!riscv_v_vstate_query(task_pt_regs(target)))
+	if (!(has_vector() || has_xtheadvector()))
 		return -EINVAL;
 
+	if (!riscv_v_vstate_query(task_pt_regs(target)))
+		return -ENODATA;
+
 	/*
 	 * Ensure the vector registers have been saved to the memory before
 	 * copying them to membuf.
@@ -130,9 +133,12 @@ static int riscv_vr_set(struct task_struct *target,
 	struct __riscv_v_ext_state *vstate = &target->thread.vstate;
 	struct __riscv_v_regset_state ptrace_vstate;
 
-	if (!riscv_v_vstate_query(task_pt_regs(target)))
+	if (!(has_vector() || has_xtheadvector()))
 		return -EINVAL;
 
+	if (!riscv_v_vstate_query(task_pt_regs(target)))
+		return -ENODATA;
+
 	/* Copy rest of the vstate except datap */
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ptrace_vstate, 0,
 				 sizeof(struct __riscv_v_regset_state));
-- 
2.52.0


