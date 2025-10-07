Return-Path: <linux-kselftest+bounces-42826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BBBC14B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 13:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D6F19A051E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E92DF710;
	Tue,  7 Oct 2025 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDU9J0+H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C22DC355
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838338; cv=none; b=S2umHdyQiwv7cLIpYnuwxPXF9U99pvdVwQGOdxtf/QWWg3Qj2zVi5jRIOQtPMiVpUnoNT6AXtvd3UbhOvFRFWEq+dmSey7X8VqxsliwyMnibSFCJwygxn6xJDlQJ1m6NS51uqP3WCt1vMYNEFNLq5alGHZ1wurVEV2H9B5tk6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838338; c=relaxed/simple;
	bh=uXkrELMKCfsRaWYxU5mXegkCFCKgEu54miTT0hVrswo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXmzr9IE0dq2hlBQOWVs4xqH8xelqkYtIULqsbKZD3qeOaLiGRJand3CSCKJS7gOIrdCJ2yK1zZ6bRLnMhAF/iYUIJjbwf0XIt1lc4lj9D1ep6SX0JkSZWGRgdcAc7aIIpq8Sr1/1mXni5v7QpxVn36SngmsmSBrxSGDJtztlEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDU9J0+H; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57ea78e0618so7000667e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Oct 2025 04:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838334; x=1760443134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ut4udALSNwNlfbYZc3Tgg1u2DqNTE4rygUYw4A2JFg=;
        b=QDU9J0+HvLDTZFrUrxoR8FB1nkf/ZkGjPW44S+i3PaYQeb7HEW4FocjEy9Uv+tw8jF
         DhoqQ9qqdOc0/jOuxjG7uJmToTjCshsTS7P1KuSGmB/uW65kfBzdfMvlcT1T/o3tjB1S
         dST4XqHIh8hEB5pCMyAdv9cjDDubZpQMNOD4Vhh1e7FILBH4oPdwB3r7D8CtZpgxBeQX
         YconBVbJgmfJldBTWBhIj6gzTBG/zVu1/MGFc2x4iL8bm7kkiWRrq5JKAO0pDEoq40oL
         LRKjS/KemIyVqAUVNLt8TsVxh+9aP6aNMdWrNN2uwL4i5AjueDB3xA5iJ+PNMsCNi5nq
         /5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838334; x=1760443134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ut4udALSNwNlfbYZc3Tgg1u2DqNTE4rygUYw4A2JFg=;
        b=cJCYVUwY6DDZl9lnCHIjRCSCE6GFyABeTp2hxDXx0lmwoESPukLHUl9Bs9d4/0vGx6
         AMwCrZetjyxuhnqdjWkb6ljasj3WNxKnB3AwSRrtmyAe7AEELz8I4d17WZ4cDvDZrvEp
         WR58U4TuAHLIdJoH9lr78fdB+HA4r9ZM75E2lDJuKMfl8ntynhxBnDu6uyBo/rPP+4K8
         tL2431ogCVv7ZtuTWr5sTEDpZwhYsw/oJ6t2MfQMgo2eGmDnMio2cP4eeu5ey01nZv3X
         i/w6RtT8keVZjRoktAKlEB9OKypRcjXARiidKt0Qha4pCh5yeuxC4qUJkkqjyuhbrZq3
         ca6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT3J6+voq1aMyduDk0v9fzqRZwNbwcn3ESiPJGtImZTBBtxkrQhLh3S2R0fl6+lvssyVeeVsziD6/Jmyb8Uww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWKWJ4Ra/qCVSywqJNYzGYlVz/eWdh/QENRVLq+IboFzyJu8v
	HCc01G4zdoze80gKR7xW5nEwjQVYy4PHHpiU9P9+0CBovs+It4mVQbDolenWeJpG
X-Gm-Gg: ASbGncvPC63PRnsX+Oi5a4yOOXAOwY5086bCJIV0KQBIRXpHzGcI8PydGNsM2HDJlaA
	iJQGH7EyBEJspXxKhoYJWiJtc4dZ7mHjRIN1k/8b61h/cKEKkDGjx63Bfsv2MD7zLRKVYZAi3ze
	XKu2hiHiYtLRx0nKvq4nkfn+TrWOOe9LJAbGU67BblcMGO6WjVRhwL+JUmyN9zjmsT60CXMZowT
	iqTBaRelnDqOflZ4R32bWOO/iVIyT1XSU5S8Uz101KzH8D78JVF9Gfx/lMFfeFX8rVDytvD4y0N
	/D2n16nWiz1fUPw75X9njrTUCDlvIImqebBKdx7nYMamY2h/17g9AGtQFOo4Pw5dZuA+grLWkOl
	IVunL4vx1T2IjDlkWogVGJRjAx7JJbT7/u4/nIQ==
X-Google-Smtp-Source: AGHT+IF9hiTWhCe1Oqso+uN0BybHSEh0X/p2CShjwG4LdtO5K/sFgcxScdEgvNjZD6t+gVwSik5F2A==
X-Received: by 2002:a05:6512:3a92:b0:55c:d62b:d0fc with SMTP id 2adb3069b0e04-58cb96631fcmr4719071e87.10.1759838334241;
        Tue, 07 Oct 2025 04:58:54 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58b011a8941sm6043339e87.114.2025.10.07.04.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:58:53 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nam Cao <namcao@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 6/6] riscv: vector: initialize vlenb on the first context switch
Date: Tue,  7 Oct 2025 14:58:22 +0300
Message-ID: <20251007115840.2320557-7-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007115840.2320557-1-geomatsi@gmail.com>
References: <20251007115840.2320557-1-geomatsi@gmail.com>
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

Fix this by forcing the vector context save on the first context switch.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/kernel/vector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 901e67adf576..3dd22a71aa18 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -120,6 +120,7 @@ static int riscv_v_thread_zalloc(struct kmem_cache *cache,
 
 	ctx->datap = datap;
 	memset(ctx, 0, offsetof(struct __riscv_v_ext_state, datap));
+
 	return 0;
 }
 
@@ -216,8 +217,11 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
 		force_sig(SIGBUS);
 		return true;
 	}
+
 	riscv_v_vstate_on(regs);
 	riscv_v_vstate_set_restore(current, regs);
+	set_tsk_thread_flag(current, TIF_RISCV_V_FORCE_SAVE);
+
 	return true;
 }
 
-- 
2.51.0


