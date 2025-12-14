Return-Path: <linux-kselftest+bounces-47566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A32BECBBD90
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 17:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B51FB301338A
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5F62D9EC5;
	Sun, 14 Dec 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3DSRZMi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4C2DE718
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730153; cv=none; b=uIwnlRMHxlZx/E1AHMx1tj6VSpAtMAgYnGKwysvrfvVs0IqsyZjOR98iY6ea62lY/JUq+Xl1p6SuOf1elk6ejdk7P+Lw5B6e+lYQ9nGyiIZ+TkZqNfed3XiWMXsGweZyfDlbt+gYeZypK6rScL50lE290MX4m14gwfyIHLjHunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730153; c=relaxed/simple;
	bh=u4GRx7isGS6qqcvrlTr4xHwjuxkIkW+2PvgAhpYYI+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPefphUD0nL7ctK9578xpZqm5qEWiVZev6+MDO+XaQqEDSnZb65ytXqGuPeaDNOhHPDCurItvyJrBa5qz+8ERZ68jeaMvzu2Mx1Op9nh2W3OENN+yrujy1hY6ah3jTC79XpFPnZL1WadTZmO7RMe3DkCY9ZE3/X9A/6sEOeBsZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3DSRZMi; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-594270ec7f9so2975122e87.3
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 08:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765730148; x=1766334948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLn4MNRkDT1IUgV60n0qo0HeUjZmH78SLEbhEVR7tyI=;
        b=Y3DSRZMi9kujvscyef9hLqAd1IORKsLVIw7VXQcYdtdOPJiRJjKy5T4s4ec6J6UUv7
         iA2UdsEC2hBIkpWAESLSGn/0i7TkSP0vjvKhXiKJkGDzUF2raBiLVJt/NSu0dxxWbR9k
         ocH843SYesEHeyp8rXXrvgj1uSS3eBdva5Oz+n/McPn+mQR7Bd0ipjfURvA8saIgke8Y
         I9OhUjc32kKCT3gcZGEIUx1V0o5hiKtTCrofj/n6oGUZFvjBUZ+KITqYTBtC7zCStINQ
         1NwFtQcG49S0/hLyOFPuwlAE8g+mkOw1tsOE3yfCOiIsP+qCQnHW9zp5UGnaHiDaxajG
         JwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765730148; x=1766334948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLn4MNRkDT1IUgV60n0qo0HeUjZmH78SLEbhEVR7tyI=;
        b=HGbxrjCAISTz0SHWuXmB2ki81tbtBORszIK9A1XJmjJ0XSobn3sxCoPXyk+bedtuSz
         xmMzpL2i9L4O/4iR6ex1ZA6KqXfwDmnr2Ig23Sp3O9MkyXIaGkBhAW83Y7+I338H06QM
         EfFMbBkuMGLhZYOEBBb2gDrynk+ZSwXq7xwXhesxoLL8iwcfycs4k6LpuhkmZgluToJz
         K6u68XGSbNWU8l07jcQ9KCAHYoeycfEr1DGiaxzJAf4jPsmxhm3Bafs8t3Mc5anGDNmr
         b8qFb2HnF0aNS1BVtC86dD4IAKWevhDZ3ClBQ6IUjMnoiJdGpK5PVFFuKgYFwpBgz0FS
         STdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHKbzzRqhZuccFa48S1WBV5xetrN6EyF7DvLpK3a9b3axN+0ybcHYv1oYjmpdmhrZXjQdfB0nH5I0BaAVEw7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XFB/g95OSiQwCfQINRMOBmawZ1k//QwM3wQz27SAGCgdEX80
	d7u3vscyr1JpulP+uojwsN1ulHTWsYP/V2KUBme3wD9P6XUbyI56QtQ3
X-Gm-Gg: AY/fxX6jqKvqR/Hw2EkO2p5h89NaBP+RoPklJJNfQ2VhwPdClhVpv9sH4E5cX3vBMtn
	6h6F5AsT3V4eo7Yb+9MdgMJ/Q8zEX92An+Fi+rCdYVZGfFXHMOemctCkb74B7laAJpDz0q0Wx+E
	DwG1ibW3JuqkG3Bgzu9YidzOxqAk6hiD1ArPBosSY3DmLBMkiBdoZ6OT1fPCqXI0Dmsra4givIp
	N8Dox6uyTFLMNVxdCsXivBJb/LNoAXXBJYz6yG9CZlzEWDL9+fNMq+Aj2e7jkxjocVmp7bNjSEB
	4suyzQw5cPl3DdsENegLm/fgha/IphXjT+7EoM31Z5XfIxeVPWSpy54yH9HJqH4qQreGU7cCMEX
	QPGkV+0ao4KOf3kg6UPTHgPHJ9ms+Kgp1Cpn+N7mqCTfjIcevE80KnhTzqRdVCGDVIh7s2OUEfm
	fGcWn9px8npoRa
X-Google-Smtp-Source: AGHT+IFh1nTDiB6bfb+d32bUKdxI+dMGC8og7D8jELF0KQuXTZE0v1XUdZ2F7715E8gk3xNrCq+2AA==
X-Received: by 2002:ac2:4c47:0:b0:595:7f1c:29bb with SMTP id 2adb3069b0e04-598faa36a70mr2545740e87.22.1765730148316;
        Sun, 14 Dec 2025 08:35:48 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-598f7717b79sm3789618e87.60.2025.12.14.08.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:35:47 -0800 (PST)
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
Subject: [PATCH v5 2/9] riscv: vector: init vector context with proper vlenb
Date: Sun, 14 Dec 2025 19:35:06 +0300
Message-ID: <20251214163537.1054292-3-geomatsi@gmail.com>
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

The vstate in thread_struct is zeroed when the vector context is
initialized. That includes read-only register vlenb, which holds
the vector register length in bytes. Zeroed state persists until
mstatus.VS becomes 'dirty' and a context switch saves the actual
hardware values.

This can expose the zero vlenb value to the user-space in early
debug scenarios, e.g. when ptrace attaches to a traced process
early, before any vector instruction except the first one was
executed.

Fix this by specifying proper vlenb on vector context init.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/kernel/vector.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 3ed071dab9d8..b112166d51e9 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -111,8 +111,8 @@ bool insn_is_vector(u32 insn_buf)
 	return false;
 }
 
-static int riscv_v_thread_zalloc(struct kmem_cache *cache,
-				 struct __riscv_v_ext_state *ctx)
+static int riscv_v_thread_ctx_alloc(struct kmem_cache *cache,
+				    struct __riscv_v_ext_state *ctx)
 {
 	void *datap;
 
@@ -122,13 +122,15 @@ static int riscv_v_thread_zalloc(struct kmem_cache *cache,
 
 	ctx->datap = datap;
 	memset(ctx, 0, offsetof(struct __riscv_v_ext_state, datap));
+	ctx->vlenb = riscv_v_vsize / 32;
+
 	return 0;
 }
 
 void riscv_v_thread_alloc(struct task_struct *tsk)
 {
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
-	riscv_v_thread_zalloc(riscv_v_kernel_cachep, &tsk->thread.kernel_vstate);
+	riscv_v_thread_ctx_alloc(riscv_v_kernel_cachep, &tsk->thread.kernel_vstate);
 #endif
 }
 
@@ -214,12 +216,14 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
 	 * context where VS has been off. So, try to allocate the user's V
 	 * context and resume execution.
 	 */
-	if (riscv_v_thread_zalloc(riscv_v_user_cachep, &current->thread.vstate)) {
+	if (riscv_v_thread_ctx_alloc(riscv_v_user_cachep, &current->thread.vstate)) {
 		force_sig(SIGBUS);
 		return true;
 	}
+
 	riscv_v_vstate_on(regs);
 	riscv_v_vstate_set_restore(current, regs);
+
 	return true;
 }
 
-- 
2.52.0


