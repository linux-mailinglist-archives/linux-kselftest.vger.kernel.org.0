Return-Path: <linux-kselftest+bounces-29251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431EA659DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B883C16AE1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C71C1EA7F3;
	Mon, 17 Mar 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RSSH4PMR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777191C8634
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231299; cv=none; b=ik0oYk+sAOQZ97O4mzeP/eI0MBNxKIZmZgF2+t96RmqGdfmUwi0sjIDapKsBgg7dhwgW79riACvBqVrEztzh4Tfm5DWfUZcr+3JDJoe6b6QZXsK07JR5nekTsxV5D/n1nPv4W23lFUOmD88Aejasph9jxsB6sA2uNUNlQzhGre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231299; c=relaxed/simple;
	bh=m22pBr3V6eaVlLVIX44rOw00wFDH5N5l1rGKB3m4pxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRz9XBh71nMWNF/Buu60o7OmUYIXUxFQuhVfxJ3HDD+NXyaQ7Epnl30oPp84Nr7Pmy4XOky9+b0gB5CbLxW0FWbqDavziPj+xMx46Io4as8hKyu6kZR7oPwvI3m1Kj21rFBi2MCN9OiXQ0C6OtU88/4OXwuLV0QK3dt8Am4Cc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RSSH4PMR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so24702445e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742231294; x=1742836094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjeBRUPbBkNgIlDeDsLglyk/HEJX/vNaDwxAgvCJumI=;
        b=RSSH4PMRsfeCZiWscD1JYj+yEnxbSVZ/bWe7EvT8f5S4lgd00i0g3osurYR7gu0lKS
         1KaI9sbd4XugSVanJWNMV7w1ZTkE3HkmR/Cj1JNB6CsZxXqm1z/y8YJjFF5kmGqCZd4m
         zI61GGTPhlXelbPiO9LekJhFT/0hmhG/LIf0azpeyKuYcEVF3z13ezHEP2QpkzWBbPpF
         76oCXswhS7q0OcxGmFW/Y9tKMbXqKFD+62dPAXNqt35ZODalW92kXYPZbHV4g5ZL6lx3
         5MjfXUMoercuOjOCWWf51HYIaVDvMK5b9kDCjhUd2DH0UBt57xd9vFsnXeE7r1fo/VAv
         ix7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231294; x=1742836094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjeBRUPbBkNgIlDeDsLglyk/HEJX/vNaDwxAgvCJumI=;
        b=kzJ0ChkfSqqVo8gNeQu4rwPx66p/9Sy1vXVnZyzFBKAvua/zkWrJoJn2kjYswQXV6t
         zzuAmB71EMpS3RyW7waLonVZ1DTW9Ibj86DMlWxzwjsH7SemHQHRD61oIy7mO4DZfT9E
         iWnWe0dlQzUTUteXUK9hsaY7PTOBF3YHRbfIJadxWgjld9Nz6wCjpo60B36rFl1kVH1V
         olORCTnxf+HtxeoQhd9jMM0s8hlxegxAZZAKrzXhahteYExLN7ccdhiS1jntNYWzhzbN
         rkCnMrbzf2ccFDTuPNPD+cukgGFfHWW+2W5huABFMwR9y2EelSZo5A54MxQ/eQw/QmkE
         lG+A==
X-Forwarded-Encrypted: i=1; AJvYcCW9lCc+kOeAASieRlA5+GqCECb6jXIpFnEbPIbOZmjoMlICS4iG7RzYUPMJ+QYpzASf5iR5dgfkfxEF1Ms8jm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ARkof+igNjnvNvPsqLusyOCc2g7AyrVFBqvN5w3pclluO9QE
	MqLy2LRtFOcPo78gDEz+T0Ksgg7Dl4ZhW7u8T0Z5mYwR0Ds+uEjbX72WbeihOfw=
X-Gm-Gg: ASbGncsv31UEO7szfDpf4E736Aw70aa+ILeRD/ttxoXMpMjC6XenpVulg18Ez5Mbqj2
	RfYdlTHNOezpC092QlTqPdU7k+LPMzWBPPlVMg5n1u1wlLB3oy9TNYRKogVWVHzhDuBKrNGKXx4
	BClWbGX2dUlOX3hUml6Q3+Oa5W9cTF5hNg7cysfT3XqyUB1DEJBVT97YhwFg1u2sIbtQLbJGEp1
	RCpo4fz+RV0yiN0RdJcWzx/UVGpsekIG2N7tcygOrod6aCkhdRBcGLR7fkZFuyMgMAYkaq9PJ3f
	rWqmbN2egqA3b1um1Wkb8dobAbww72iYhv6AuhX5N9D21drBD3YjEIqU
X-Google-Smtp-Source: AGHT+IEAV1SSYPsskoq8q0qrPU5Tio7ya8gNR4WNeMxWQDKOPXJ0cX+p31upeUPN82mA8abBVPNApw==
X-Received: by 2002:a05:600c:4ed3:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-43d1ec80917mr153430805e9.15.1742231293673;
        Mon, 17 Mar 2025 10:08:13 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d23cddb2asm96014505e9.39.2025.03.17.10.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:08:13 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 06/18] riscv: misaligned: use on_each_cpu() for scalar misaligned access probing
Date: Mon, 17 Mar 2025 18:06:12 +0100
Message-ID: <20250317170625.1142870-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317170625.1142870-1-cleger@rivosinc.com>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

schedule_on_each_cpu() was used without any good reason while documented
as very slow. This call was in the boot path, so better use
on_each_cpu() for scalar misaligned checking. Vector misaligned check
still needs to use schedule_on_each_cpu() since it requires irqs to be
enabled but that's less of a problem since this code is ran in a kthread.
Add a comment to explicit that.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/traps_misaligned.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index fa7f100b95bd..4584f2e1d39d 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -616,6 +616,10 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
 		return false;
 	}
 
+	/*
+	 * While being documented as very slow, schedule_on_each_cpu() is used since
+	 * kernel_vector_begin() expects irqs to be enabled or it will panic()
+	 */
 	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
 
 	for_each_online_cpu(cpu)
@@ -636,7 +640,7 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
 
 static bool unaligned_ctl __read_mostly;
 
-static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
+static void check_unaligned_access_emulated(void *arg __always_unused)
 {
 	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
@@ -677,7 +681,7 @@ bool check_unaligned_access_emulated_all_cpus(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
-	schedule_on_each_cpu(check_unaligned_access_emulated);
+	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
 
 	for_each_online_cpu(cpu)
 		if (per_cpu(misaligned_access_speed, cpu)
-- 
2.47.2


