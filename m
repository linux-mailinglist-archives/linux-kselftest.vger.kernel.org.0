Return-Path: <linux-kselftest+bounces-45184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D1C433E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 20:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3243ACAEA
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 19:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C20288C3F;
	Sat,  8 Nov 2025 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG/RK3gi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6B285CA2
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630953; cv=none; b=Q7BKMhAHdE3z8LpL9xfIZRLeEh64nPjxqhUwYJ8O57eL9iEddaIce2bVkavVxh6j55mrsvLArt4Rc04dOFS89ey91t+b1ziwHLsovrjeoYdVRhRvHK9S8Qv76yy7ZzPxS7cj/gLHp6wUehVy0IZL2nr/fWV9H5tBESZtPa20Vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630953; c=relaxed/simple;
	bh=6M9dbLxONjUxBoLDP2RqBwNW90OBNkAA0tpnRglr6DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqoRe0EY8xl4wzYgFaqaeAVc2NCYBywyn6NB2hmC672PNwyT3/WpXUI6OBwI9PQfRfVB87iHROodH3W5XhU4VE+k2+Uq9WgzGGvQqIgBiNKO5yAAYlAEUONySvFkB7L0mz8z7ATirp1qZ8yUpVzVwYg+MHvrkstSj5M7s7xG2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG/RK3gi; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-375eff817a3so17969331fa.1
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 11:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630950; x=1763235750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2IQTBuXBoLRQZMsUEB0GbuKpDZXigWMmDpUz8gyE1g=;
        b=OG/RK3giQINbAX1PH1yW022rwXk1SebbL6cnKfff44FGVQK+osDSDcalDyA4RAIdSM
         2yD1zpee5CAlFrWYH7YuG13kpZcpW6Kk4uJtkOzCZ0Zcn4+k8CSZGPCrMQxAkr1tvWF5
         L07KHpHx2JK/AjWYdoCv9+RPNvbY+g2knycCiv/Kh+LRg2smltKTWJl3kKJQTa0yF5rS
         KHRSA8kcUlLgAqWV9RB3516yC2NWrjnR/Dlr6J6J4ZxIunHmmV3PpLZwE/Nvgw7SAe3C
         3my97CEo/5QvwbuEvOIrJ/rZgKn0C4YkudDqEqCdkZAbE14wKycRzxu5soo4M2QqmAEW
         YaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630950; x=1763235750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J2IQTBuXBoLRQZMsUEB0GbuKpDZXigWMmDpUz8gyE1g=;
        b=ro/OVGX/Iymf2+UlALnLAq6lJ9VRKPZrxtwmqAKP8sNWoJG2kz2JMQ7KdbEf/NIkhC
         w4NqMKmFXOCtE5o+Js7KQLcb7hAMteW5bUP7dqHRqxLJtFBx2PIr7iS5h4KeteYGh2zf
         HUx2yksEmKqGsCq7GSraqSNuuVTvJ/+mvNGWwEw2cpYjawWkFwkZ6yjz5A26KcIt8LTq
         s5tCeMprZxGvU2DY1UiXxLP8CNtc8qOP8QFhEJhcwDMt88AZinnmeva0ijgKc8hHcApl
         /W787ywmjq2LLt62Ue2G4gfSUuIAPGViYgVU5PLScuLdle8DDlbuCPn5OLzMA9lzAkIU
         Vfqw==
X-Forwarded-Encrypted: i=1; AJvYcCVxo6mf5DqbytU0boYUI+1P2GJjBDp0gTTI0RCXAvn97og7Bfjz0ETEIHfLrBL0Pie6V9egFlXJ1mjH7dBXAaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiU1YwXAZIED34tJ7p+jo0x9YNy+JAt/DB3A3doTyfptyTk3LN
	ImMuRBgzQlJtd0dDe8jwV+TJDHmevG7M5wJndlO1f9LNKzmzKmyhtx8U
X-Gm-Gg: ASbGncsoIW2owpN6v3bZdGvz60xc7gpfdaFjFda2kw/Htlj5oA2pVA4h/mccOzNtr17
	krn/e9QLs5rDYgwTBhcOywOIbFhun67qKZnE0bFabNEhiY0C8nv44KQvlLaAtXT06V9oeqBkMBC
	vZH2wUxHeNVta/sRmuGkT1oOpFtwXvggAtpNs2zjfeTtlz2yrcIRQxjDtuyTOq2jiwZdkx0+kQm
	RzITJXJvJ28TK+grZM/R5iFV+1G+l50hS2ka2sYgk2EZEkNlSSkgkQq/tbV+HZ2oBjMwRgCKOTr
	5kWNjgZg3MUYKflsMToCb98dauDApO7iKVQ3Lm+40KGIIdp9bRNPLp7kuzJ8Yj3ZTO07rgE0lYv
	kXSa0VuGKxh2ECTR/T+9OrpyMFnxxmf4jVZW4v+AkR9pirLR/RyYTtUEHMJHIXM6Pe29HmaDSwd
	Oct5T8hzLnR6dw
X-Google-Smtp-Source: AGHT+IFf6dK7lptakI4133tJJcZvJ7D5ljXgoiEFcd+YznP8qQqw2s3Ui5u0H2YIH/FT8lwi1hx0Gw==
X-Received: by 2002:a2e:8a96:0:b0:37a:2dca:cfb6 with SMTP id 38308e7fff4ca-37a7b1bede2mr8423251fa.21.1762630950197;
        Sat, 08 Nov 2025 11:42:30 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:28 -0800 (PST)
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
Subject: [PATCH v4 4/9] riscv: vector: init vector context with proper vlenb
Date: Sat,  8 Nov 2025 22:41:43 +0300
Message-ID: <20251108194207.1257866-5-geomatsi@gmail.com>
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


