Return-Path: <linux-kselftest+bounces-45182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E94C433D2
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 20:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E9304E05F0
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157528750F;
	Sat,  8 Nov 2025 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEQHrz6t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE628643C
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630946; cv=none; b=aECzwSkN8iUdje+Z0JeROT+2Eh7GhS9HGQnPnmSNT0NTiUzWNMvhcOr+W+iRBSk8kS4948mkoRy6Y+NMwtdCoeCb/r3wsB6C7kQijJN09PKsPC0DjGXSi5xv6KTPLYe9jji0Ae6lAaZ9KEQO3EFBkzvTm0miFMdW+D2tc4qOY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630946; c=relaxed/simple;
	bh=vKbmQPnxwBg289DjWSmS0b59pBATdSkR5Ho4WAMAT9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+yq5zsYD8rQP71WctUCDR9gl91Xer/IzqPbQUYKD/NoMDG7zoIA5bgnLUJT+PnwvXO6r3f5uQZSbldv5//+3NJ3M6RLvsZStFAyO6S8wJCzrkIwkHzoJmF3wKkkJo4lQ3dOWnYrPznuNZcfZnD0JFAW9y8/xYa7N0eYxzeSH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEQHrz6t; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a33f49018so16053501fa.2
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 11:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630943; x=1763235743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOKLEyEqhroRvoLq2wOrgCP0+QeKumxXjJG7yF7kNYg=;
        b=lEQHrz6tvWMBUWRQLtHY6I56SKigstBdIKavb7vLU61SliIgQGj6NwqBsbPjQSA2pY
         eupOJtU/XQt2sJOsfZDdptS+62pJMLOsNKIeFM55DW14CSpxOSMoMCXtSa3cHCLPn+Mz
         TDdp8cee19W2e7gwI8eEmpScatbNtEr34d8kPuyPql4o86uUP2S/uV2BGaTc4BGy7pqK
         C2iDAkQzsdMcmfBMPYP9L/e3sdAoKQI8wKkiqO1ErPQ3EEQWt6XdRQ7brqOrpjF+R+Ue
         gCXn0y6iBmoGCiT2Xu9y6zh5jcflRORS7u1fcW1iDCQ0dYQ3Np2e7f2nOdGcro8obcfc
         UpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630943; x=1763235743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KOKLEyEqhroRvoLq2wOrgCP0+QeKumxXjJG7yF7kNYg=;
        b=An5b+hUtSguO89M0akvgAehXMZ7kG2rqDn1kZ6EGk5y/rf3hOtlBIKpHmpgQs3bozb
         W/oi5+Ic4d4IwL0nKW/f/vLlago4D826DiP6DBt908EyhCnyikvLJrwmMmtsYJMKS1cI
         WDuwg9J6felujVue6t8Fi9hwwvrBY9XVAJgYdz8+0LCCPJONn4FU6VsV190iIyEyS+iL
         CcUf+6x2r6oxuUrjBCDegvxDEGiwSZW32Fi3MV8yiSrQxgBeRJfDp3sngSkLlR6Ru/G7
         uBcb03b3HQjn8qbnyNvEZ3yJ/mYLJDcDcds6Tz2H9lLrx43uiaDON3LrVYbAFO7mNXFh
         xFyw==
X-Forwarded-Encrypted: i=1; AJvYcCUq3uUb9HxhztARPKVzh0OTK2SJk8h2GWgPFb9nIyws1q3BncBSmkgrB/YkzqESaD+UH0qpHpCp42zb7fICOv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyL6l4ry6OjhDoV8J+TSzSMPBe3d5vGyzXtkmzDOBt4P7y6esB
	qK/7Xe8Rg1G4NkYc4BGFrkcPRt/vO3WjwbFog+Dr5zan2VfI45/DHvad
X-Gm-Gg: ASbGncvQJ5L3bgIUA1kgMl4EpBff/XEJyXEaWyCszGqqBNOPE2lf2cG7QqxVzmO7KdE
	zQORtB/NG+aevjQSnZVzLHr32kcxV6A9XU8QVfj5iUt0sJlEBb1+ioieq33OCiTgtnYneTKlupV
	smUpWEBtRYZCoSCsenRZu4fsk/opu9+a0VQNWeQqaUqPwfPBQ78QM0lRynwf6PeXahF6BwVQ3MW
	BIvUisrcv4Q7RLzjf8pKm7FWjC2ckKzWl2yNpQj7Vt1WtzLCfnHR+4zNO0+UnHgNP57mC3eGV1/
	dgIVeEGHNHaf4UHwAJHq1q/Y45rBAubALidzm9FdNDxxNw8wTPvuQ4vslnvmT+ajc8EevT1Cm/+
	qFG0pwMUNj2DtkacKALJpvC7lsRWss9cvpvf9AkFJLrTOxMJnWJpY7SLoLznkY08rjIDlTqPYvj
	G3b3MLZWjqOSyY
X-Google-Smtp-Source: AGHT+IFd11o+WjkQbExqrkTtQGyasr3kUPa8k31aekfobs7VZTRb3CSjym9MsMeXrgwdvuMv8vFsDg==
X-Received: by 2002:a05:651c:4413:10b0:37a:2be2:4cae with SMTP id 38308e7fff4ca-37a7b309ebdmr7296711fa.49.1762630942471;
        Sat, 08 Nov 2025 11:42:22 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:20 -0800 (PST)
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
	Sergey Matyukevich <geomatsi@gmail.com>,
	Ilya Mamay <mmamayka01@gmail.com>
Subject: [PATCH v4 2/9] riscv: ptrace: return ENODATA for inactive vector extension
Date: Sat,  8 Nov 2025 22:41:41 +0300
Message-ID: <20251108194207.1257866-3-geomatsi@gmail.com>
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
---
 arch/riscv/kernel/ptrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 8e86305831ea..906cf1197edc 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -95,9 +95,12 @@ static int riscv_vr_get(struct task_struct *target,
 	struct __riscv_v_ext_state *vstate = &target->thread.vstate;
 	struct __riscv_v_regset_state ptrace_vstate;
 
-	if (!riscv_v_vstate_query(task_pt_regs(target)))
+	if (!has_vector())
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
+	if (!has_vector())
 		return -EINVAL;
 
+	if (!riscv_v_vstate_query(task_pt_regs(target)))
+		return -ENODATA;
+
 	/* Copy rest of the vstate except datap */
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ptrace_vstate, 0,
 				 sizeof(struct __riscv_v_regset_state));
-- 
2.51.0


