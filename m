Return-Path: <linux-kselftest+bounces-26249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21679A2FC35
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 22:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9655B166DE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0034D2505D3;
	Mon, 10 Feb 2025 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OXhvIdIh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0C24CEE7
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739223371; cv=none; b=leII57hfyDKonHbUYwocM9iuw7dsdyOoBFsQFispyqGqfG5c/6X0YYZjnYrTssYUosODVvBy5F2pcgLPcXCOTbT3IIUUmh1R1HA7BI7P17tdlteurFAR2F6UBcGerh3AeAZCeDBfkHLoZveqAXLYeaLapo1gZI1rLJvBUc8p3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739223371; c=relaxed/simple;
	bh=nmg/tRsGZgOQ5im6SIQejK2wLO9bN5gz88yBNRwTF48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PH7fj3lSFR5KiWCzs5Ii36FeXB921KvkioiTiFHLGWqqxm57xI2+8xNBfuDxLzLnSMb7coOhd1B5hJu85W/aevyuinVS/kyCN/wpAg+ECCopYopIpcV1eE7FBGx7vg5552QF8HO0jMqRWqT4gtPrNiyfQ006MCpSZQzTinN4Y4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OXhvIdIh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a823036so8302635e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 13:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739223367; x=1739828167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqCqeIVEP5nChfGSMKDAeePbRakW6SMa+hWr1pO6tWY=;
        b=OXhvIdIhIvM60e5fhqb4MpRxqD3XA22dRPmfUJqqQtiLTzCfQsWpVL6JJaMNGd7Flh
         h/pFPnXoILzdkAb4IWiptkkJIseZOb0zL5vCxzcHknjffB8eRywHHvIERTZd4RGV2Y7C
         K9gEqqp+wfrV3raFmoR3fvMab9hMBE3Bz7GiIjv5j11Wz4wMOWe1KCVlwWbtN+HhIoyr
         kzXrcdA/Hn+bWQffXA1b3KBuI3V4qwkx9nWSRUkKLxJWej9pO6fa7pvcfTHH4xLreMxD
         IXrjSAOp6elqPzNTabw+mtSWjx4AxnzMh++08bXUd0W02rVDJ4WpS2UdO7iLp1R/ZLq+
         6q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739223367; x=1739828167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqCqeIVEP5nChfGSMKDAeePbRakW6SMa+hWr1pO6tWY=;
        b=O05+m24q7YMufE3BH9wJe0eY8yD9Lg0DW7zFI15eMGbHqKIbgIOBF60vR6j39KBSUA
         Y2LSHv3TIhiZoGS111zKhHqQSPtrnpRoO/l4mSQE4tU2HS0elMaR34w+CvTKHzVEjosk
         1CtZEPb6CqOGclxy81d8a7M4GstImY5nYPARk7GXoexDSGKKq9s5Tm7M847H4er3cqgm
         XJ1VsbfbT6dRJkWXJWhmbIUK4+lGhtIyMomnByQlakMFweZ4kprcD1XFLWZjSOjifM9g
         3sBTK8vfXH7nPJQ8wd7oDeMevI39BL+ho7f6RJ+Yq9U547e3395n0fa99T4tma3xhQJR
         czFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRvEjeKbX8TR211UJE8PGDZSIaLVvujNIbUv24qZHFvggn7BSN8NEBzV80XzBrjLJxJrxYjDFQ8h0mYGCHsdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBq2hGZpbUFmPYYjbrteo5V6xLJ5z87TCfIeSxD4n2GxFwyeQ7
	lGTZO+GpW5BuxI6aqBaAx/ysr4pE5mczE+covSfDvxxmOviWyQoZYtItyIVsjiFVRRDNSCg3MG0
	QtUo=
X-Gm-Gg: ASbGncvB+EBtAOvSnfAdVxBk8REKlbT1ANtkOhTo/FknQnJkliBrCvVK4aPey0TyOiY
	7hk+g5l4aVl/3DGlV+lqlCt/PkPeISUWcpBnbhln64QmvnPXTYWcXvhMuuw3fPp4eyiz5fRKzXy
	pf+5aD/QNmwnRCWrI24OsRYTovGhBV1WfZvRLig1lg//exohiLcmHP1kORoo6VSZES4JOyTuFHc
	0Ka+thTw3z+AGquWKfWiAeDWq28osUevXdVmgwehJ/Mpf2Bl9SVaSCPsAS/En/09cNt3/UmA1ee
	H3cva5OtlrnTqvFk
X-Google-Smtp-Source: AGHT+IEkB0P3P4E3SAwU66eF3MpeeDcKXRF+Ogw0CMtI0RkNe8VhwZ7hlSjtF2j0kGvBWRjmPkWfgw==
X-Received: by 2002:a05:600c:4f05:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-4392498b6c2mr130517545e9.7.1739223367421;
        Mon, 10 Feb 2025 13:36:07 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394376118esm47541515e9.40.2025.02.10.13.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 13:36:06 -0800 (PST)
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
Subject: [PATCH v2 03/15] riscv: misaligned: use on_each_cpu() for scalar misaligned access probing
Date: Mon, 10 Feb 2025 22:35:36 +0100
Message-ID: <20250210213549.1867704-4-cleger@rivosinc.com>
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

schedule_on_each_cpu() was used without any good reason while documented
as very slow. This call was in the boot path, so better use
on_each_cpu() for scalar misaligned checking. Vector misaligned check
still needs to use schedule_on_each_cpu() since it requires irqs to be
enabled but that's less of a problem since this code is ran in a kthread.
Add a comment to explicit that.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 66eef398bad4..eb9157e3af73 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -616,6 +616,11 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
 		return false;
 	}
 
+	/*
+	 * While being documented as very slow, schedule_on_each_cpu() is used
+	 * since kernel_vector_begin() that is called inside the vector code
+	 * expects irqs to be enabled or it will panic().
+	 */
 	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
 
 	for_each_online_cpu(cpu)
@@ -636,7 +641,7 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
 
 static bool unaligned_ctl __read_mostly;
 
-static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
+static void check_unaligned_access_emulated(void *arg __always_unused)
 {
 	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
@@ -677,7 +682,7 @@ bool check_unaligned_access_emulated_all_cpus(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
-	schedule_on_each_cpu(check_unaligned_access_emulated);
+	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
 
 	for_each_online_cpu(cpu)
 		if (per_cpu(misaligned_access_speed, cpu)
-- 
2.47.2


