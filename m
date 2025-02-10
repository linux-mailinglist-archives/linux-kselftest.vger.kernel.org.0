Return-Path: <linux-kselftest+bounces-26254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D5A2FC49
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 22:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D397A20A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1368253F3F;
	Mon, 10 Feb 2025 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ITFlHvtE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CC253335
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739223378; cv=none; b=B05fZNVBCeBO+9UqKBtwunkjk6cJLUGahsDn/gIf2ptUhio5s/EDs9j0RZM4h8MdTHzh9bPNKuh+qkoj/THhD3fhHi6X6rZqCS3BWmKSGb9ZDVV1ynprt1xO+ydsSJKKgGqhkBhP+PJFzcTx5y5YKYZtvuZ1NiH6x+BseM7zHgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739223378; c=relaxed/simple;
	bh=o8LicozigsBJPUxfw0UjH/+haPfd2EDEodthfJ8bhLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jgd260PRAOK4hra+NqY0TcVncIUBGRZBBAFn6ownsnQ6WDZmaWnObDoTxhw89kPSPtSDJFFVr/vquw6eiPsVetO3dXdvJP0zNGRL3OEj3ndwI+FJEp0jevqGsDMzK0SHVz9CjxS9vf4CiD235KbqqWtRaxmx3U8unyil3nignvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ITFlHvtE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dcf8009f0so1647767f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 13:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739223374; x=1739828174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTEMNxwWUDdJDHTSWR5BaYosnBDapUg7Ev6g031TeV8=;
        b=ITFlHvtE9yI34d5cje450muBPt/uRI0f9R13H4R0RygM0vIL/8Xr2ysMO8unqgYTbL
         ilwAb+1ia1vprAdNB+fNCPkd5qonAVLvZVCX2Br8Fm4V+SoAaOpCsh54e72jSUdPHbes
         01iBiW6k0H/dIX1t0423EJjcZY8OqljAgf5P50pxRi+df2jBcTN5l55YapSlJ/eQfrld
         fpZsQO4LG/uT2O9nulvkbEDsd/2M9frh9SU3Zle1aI5iz4CEWzdSQMHonhxzL8z1n+SK
         pVAJHfF2Sc3cPaED4zc52foMO+cuFm7Jt9yDbI7D0QtcjgwQcWUtftPkuVEJ828wWWuh
         gHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739223374; x=1739828174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTEMNxwWUDdJDHTSWR5BaYosnBDapUg7Ev6g031TeV8=;
        b=S1URdnn6WK7rGQCmcKqAMs1cvfPY7WYQyDisrgIs0mXBaP4ei47UU+deHNTbHrNFcd
         x3GRQjVvZrlYqkX+pYwHhTvNGJ15UpG5BrhtAJX6AK5l5s4Su2KQQJ6d4UDnl7/jD+XP
         HIqgItYawF4Vvq2O+yFw5LtPcUHDXu6N29kTowYV6pc2E2EyZiFORa46YFcPZb4cVf4l
         wSfNgzhdMC9RT4t45EtQqTA8gIR7Hm1li1tz3cbwwqJGzdSWehHHKdGxXqwT1LaMgwV4
         fWUT/z6nDhW41cm3EWVY1HPLeqDxCjc/J9tBPGkn4zsdPU2xu1onMoSt96sJufWD9J4u
         C5MA==
X-Forwarded-Encrypted: i=1; AJvYcCWBZPo0gHGVl6KHT1fgO0CZJC/OVfmWsZ/+W3wQvQ4oqOf236AO4jYiOIHFM0mAPpnUOSxAKFHs9zR1EyFHag4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZJVUAZIvz8w+KVLsud9IwYe8zbyOinF72vdTeWqXp5m2K28/L
	usET8/kn4GESGqE/526tm9XnmMoSyIb3kTx2LTB20Z3THG/nMI84indd5huVW3U=
X-Gm-Gg: ASbGncsyg4lsnO68MDwLHTq7WEbEriq1a/wsl7N8cFCtUFW0jy4yCPdAjhrky0lh5pj
	49inmuZkuodEuqr7TmdxMTprnQgJ/m+JfVdrEQbLSCXUlnNaTveqH3J7fect9Wf9awjZPHXE4RN
	DtUb6p7Rmbpa+DjF6YD1fqi6FDyqYFHCqTtARHPp0X1Q3IxXk41JDqWui2qasi+tfQPk7F4vrNP
	jpiWKmUYoOnWzt8Ccy23VnJlMNy//ALb2FHoHLXd/WuicYFjY5TLPMBTX/3tG+Cky4VQbwoB4yn
	lQY3jvT4aJglQSzf
X-Google-Smtp-Source: AGHT+IFeyF81bBn0bup3UjkgQ031iOdpi9/jVXiALJpdAtVQDgUVud0mvsDq+oa8j9/bPhnXjupeow==
X-Received: by 2002:a5d:5552:0:b0:38d:c2d7:b5a1 with SMTP id ffacd0b85a97d-38dc8dddd9amr9308427f8f.19.1739223374260;
        Mon, 10 Feb 2025 13:36:14 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394376118esm47541515e9.40.2025.02.10.13.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 13:36:13 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 08/15] riscv: misaligned: enable IRQs while handling misaligned accesses
Date: Mon, 10 Feb 2025 22:35:41 +0100
Message-ID: <20250210213549.1867704-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250210213549.1867704-1-cleger@rivosinc.com>
References: <20250210213549.1867704-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We can safely reenable IRQs if they were enabled in the previous
context. This allows to access user memory that could potentially
trigger a page fault.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 55d9f3450398..3eecc2addc41 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -206,6 +206,11 @@ enum misaligned_access_type {
 static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
 {
 	irqentry_state_t state = irqentry_enter(regs);
+	bool enable_irqs = !regs_irqs_disabled(regs);
+
+	/* Enable interrupts if they were enabled in the interrupted context. */
+	if (enable_irqs)
+		local_irq_enable();
 
 	if (type ==  MISALIGNED_LOAD) {
 		if (handle_misaligned_load(regs))
@@ -217,6 +222,9 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 				      "Oops - store (or AMO) address misaligned");
 	}
 
+	if (enable_irqs)
+		local_irq_disable();
+
 	irqentry_exit(regs, state);
 }
 
-- 
2.47.2


