Return-Path: <linux-kselftest+bounces-44049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80014C0A035
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 23:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998703B93ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8713081D0;
	Sat, 25 Oct 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBdp9wUJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F583081A0
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426441; cv=none; b=r59uG/Tp0tSbm57Q4rhEtQomP2kxEpD1SsvTGGAVEvewzNHq65vY0U6aOIH3ZG547Lm2ZhdQp+7rAlxlm8wC3CKcpHorujvuUpk5W1uM90WvUVCexBc6XcuH0Wuut5FsCnCdEMsPiBL3gseBSC+448Oqx9NV8DwPuGAUxrSRTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426441; c=relaxed/simple;
	bh=6M9dbLxONjUxBoLDP2RqBwNW90OBNkAA0tpnRglr6DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is30RWT6U74s98g4adgKAlWK5CrUtr1WM/XFcIQnyR3f97vaWnrmXZTg8jMVubs/2Ap0in7XboBDEhMLMXClIjLL/3DKSZVCgHEzH5Fnih7YYbN95/OPHQLPFSvLCc0lKFhwyfptMGXreczQowbCBTsgfIiGUnHU+LJ9V0t9Kto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBdp9wUJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-592f9400b04so2757682e87.3
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 14:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426437; x=1762031237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2IQTBuXBoLRQZMsUEB0GbuKpDZXigWMmDpUz8gyE1g=;
        b=nBdp9wUJ9Q8oK/e8UYOrop9xAt+pjHTMUvFHgozodHb3OBq+z+z8JPyTjuOTX3749c
         qt7G79OWgMYfQKZzmqQQdlyabD1Y2QdUXf/dzWjSFwtdWSRLkhRmwzExESmsYzeCvbci
         608fUIcbh/YYJ/+a/TTYeu1WSwLbF3oaiWpJ3QKqD2Y6yX4QfPFnaTxwj7Pc8TTaac8W
         gzV6PscDn/NDkMcnSOyZ52U42iGGk4fQECmTrisNDoyEXexypSZgX6pt/h7+5AlEmSLr
         wFLFYIA7wtrXRYTggcFDrLsJzayo3xVQ6ZofBPvMCK/pMm5hGszyj8vAdy279NcFHR7y
         vb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426437; x=1762031237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2IQTBuXBoLRQZMsUEB0GbuKpDZXigWMmDpUz8gyE1g=;
        b=TDH4pCYk8PFirp55cIJpNXKEd0K/L8UrdehtW2qHFYLPvsMjEWaOibeNgkANX1u1MC
         5MD+dNrQbpSJDtcsMq4wFZYJfILg/aNtzRTl9GAewHte+WyDbzwQViUyh6lfYTGnZgBk
         sn9Gn7A5EaQIBaJZ6ih5DPEJFpky3GhkqBH54lXQV0vHDHUYnwLZwRnsi1CW2JM8+t1/
         Ct/90rI3gNI8mujO1XbXZ0DCEBL9Qe1a1gT2FbokCZImo1cd2KkKV4OikLV+t0hYsM6m
         pldjMyZCNaLHq75d22uJFoe1RwIrefg9fouxOp9LGajVrt/Y24/A0i2AS8kkZ+RtDt1g
         28gg==
X-Forwarded-Encrypted: i=1; AJvYcCUd7yaTRkdL93ZAY/jw0V60AzdVLmOY9KFsDeooDrhhzPiIknfiLZBUbCKML6TrTeiSsyomi0gpPr+yVOF38h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLEL0aFikpoNbf0cPILlBC9TWFJh6OSFPOdj8V3vOilFxhE7H
	1le86gai4UlGRLBBt6PFMlFB+OpjR1VGsGd0SGKIUonVIIrzFYVgJVFg
X-Gm-Gg: ASbGncuDmyCuxbmOqZaRyke9O699u+gl0LsNZwciIKjmOCL0JwbuKMQN7NJOk3sYEgE
	gYUqFHX7pRV9qg6rPVr0DKavt0I+fkOGqPz6PEXfUtDxMnsSi3homFl70iZSr9q50Kbmpopuzha
	wAQhqJUYFI/dXe3sDOvewh7HuSxmJntBnmT0UxvfRKiyf5V9PZWBr9HNroANTMbKrA/Ei8Hough
	K/wOK8Mlr0qkcxepGYUinDIvZ7yL9vk8O7kpHTkZeafrqgfPoTQWclkULFUtWHrVWmBj+A44qXd
	5SxzHTBtyXG0XGcbSjLX7sL9ZLdyF+h+QJfwZYCYb7RMXLFoOp5MHmD0+SHGOCM9/QmBVhVbeuB
	X83Vw3QJQZwZG8egDoqjd6R+aatMWzQG/ow3ldtkPbbc+MuiUwso78i2HFiJztX3MlKU16JOhPp
	pRhg==
X-Google-Smtp-Source: AGHT+IEUMnm6G8NC9y9eteA74dxGa6AyRrosugAI0qpbfbFsUo0z/KPL8oVjRjeuVyceOpVmnGq0AA==
X-Received: by 2002:a05:6512:318b:b0:57d:6fca:f208 with SMTP id 2adb3069b0e04-591d856642dmr11260648e87.45.1761426437336;
        Sat, 25 Oct 2025 14:07:17 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:15 -0700 (PDT)
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
Subject: [PATCH v3 4/9] riscv: vector: init vector context with proper vlenb
Date: Sun, 26 Oct 2025 00:06:37 +0300
Message-ID: <20251025210655.43099-5-geomatsi@gmail.com>
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

The vstate in thread_struct is zeroed when the vector context is
initialized. That includes read-only register vlenb, which holds
the vector register length in bytes. This zeroed state persists
until mstatus.VS becomes 'dirty' and a context switch saves the
actual hardware values.

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
index 901e67adf576..34048c4c26dc 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -109,8 +109,8 @@ bool insn_is_vector(u32 insn_buf)
 	return false;
 }
 
-static int riscv_v_thread_zalloc(struct kmem_cache *cache,
-				 struct __riscv_v_ext_state *ctx)
+static int riscv_v_thread_ctx_alloc(struct kmem_cache *cache,
+				    struct __riscv_v_ext_state *ctx)
 {
 	void *datap;
 
@@ -120,13 +120,15 @@ static int riscv_v_thread_zalloc(struct kmem_cache *cache,
 
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
 
@@ -212,12 +214,14 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
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
2.51.0


