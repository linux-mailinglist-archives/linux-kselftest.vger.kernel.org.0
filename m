Return-Path: <linux-kselftest+bounces-33629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C97AC20E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 12:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901BC16892D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278B228C92;
	Fri, 23 May 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VmV+f/gc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F4228CB0
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995698; cv=none; b=XZXZAMR08Gl00B//T3wY703XD7kwc5gpqWVhFF1+S3f1kI8i0HNO55uIJQavrzyjj8dPUkW2s4axeF8G3geOVEJgFF5zjXsYbWrMAvmn5yDerQNNXzvbM9PWTF32adIDEKGLaobRFEdD5FZvekm8C6HQpf3VRSsTl3A2grP5wF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995698; c=relaxed/simple;
	bh=c4f/odBe1fiDkTMfaR/fNuZlpsRWRZtD8/pJ3r41/Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oolJv7YwreWMrfO0OPuIBM79CJT8UNB9Q42AxyTR2JJJHaIILFyLRJlRxmlyMd0Jxc8/wwaCpLRHkCxftkFcmydWMShJlMyJTKLeAI6SGOC9slePF/cuMJSDQ4PwvAT7ZxDZTIHXVk7mLbBXfEbjqzIyLxiDcJDruAzvhOqfrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VmV+f/gc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7399838db7fso691903b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747995696; x=1748600496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKzeirrOKR4aa1/jaJ0+BQzqdgTSTiQsfjIovf/XYis=;
        b=VmV+f/gcr0gd6z9RdhhhLb+amoi8ErezXx+8V7P1etvRj1S24KpgaBSTn4aPElA65r
         CRy4yV/V+YrcjjT99heI6nFezomvWODF6kF0jOSZRAQbJ/YoUjkuRwOjVBtpBjQLwyiD
         QisaXaYj9MiZD0kZrqh+xbiLgu0suqamvM+VkpPJniIvcuvoTmfP0/tmOcvStDqW4QVu
         0sHkhehX5MHJ5tB0EK7gqVigdwRjJKTLYm8FaB0DE5pxU32nUhM+H3I/jbd7Q+I81cFX
         93Awhe8GafzBLg+jllYE7PkHu6KD4loc89qBEtSTr7zkms8H7iGa0zwEtJD5yIf5+v26
         8Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995696; x=1748600496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKzeirrOKR4aa1/jaJ0+BQzqdgTSTiQsfjIovf/XYis=;
        b=rgBq4pTsXecEZ39yZH3p8vcOhz6uPWwksKE+yEAWrV5SwXb0d2UwToxY1n66U4X8XQ
         yEM/S2zhf2MlHo0O129HxqBZRBwmTIc2duZdw0ldwXb2qf1nRPjK791Kfn1te5aBf19u
         Sb6XyimQlrnlfPO724nqYwew4uuBH+efHJigx1Mb5r0LaaQxCm59pIlYDwNzJDMkn0i9
         QVcdKopgx8e34qctUiQu3HzIkVeWjRt8AZO8z/OPD8blfNZAz09aZhJKNTqChJdzw/A8
         M09fjUx4tg7AzMrgxG1qjwtEjboP30BYbeR69fI2rgyxC9ceyrDV7Fut7+c8bCitgjWH
         wNdg==
X-Forwarded-Encrypted: i=1; AJvYcCUMfeHL3MkONA1eGIDPloen3xBrzuVrF5L2E7J/l0IZrioyYzkRBNjM0LOf+8yzYLGHRWW5fKZQRLPvca0nkME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwixJCO5pRp4qiZPnLeotYoovQWs5RY0pt9ptKkbjlCLzzbxWHn
	JrbO6HEJ0rxSknvgFSriFi756z9NwNengIwdO0JO11fbqcZR8cXmAzHuao7WZYLw1bQ=
X-Gm-Gg: ASbGnctIJiW3Jcy9sINRSCzVn5S0UGD+8Fuzy8Z6rRc4RxHPAZE54sSrcYo1NJw6sxE
	woCXrCoKb+i7loCHHBQIyzd1SkaXNZGodGJ2tss1uRxLnqxHem2ikrlXpmx0sYI6piVJPUaNidb
	ESHmtUKywIMuWA7DGqXOEMapsD+jx1TrpWSbYYKEaVEBdqGtqy8x9Aj9apdZx8Xps3Xc1TOAnAH
	1YFc/NO8qfK4fHxkE8hegMlk0XUigB+uWbRrWrPlOam7ZVXQjtfsXKEKPG+WouwW106jUg+H/wv
	IqRnuCV1qHKoa9p31perd1bbpYwuU95cDYBmZ7Wy081Qtcmrqp5d
X-Google-Smtp-Source: AGHT+IFz+/NIX8RZ4CpGdqDvwRIYbmRrE9EGaVbHiy5c0a/czfZB0pteCG9ARelWxW3OVz8OgvVZvw==
X-Received: by 2002:a05:6a00:39a2:b0:736:b400:b58f with SMTP id d2e1a72fcca58-745eccdec15mr4787201b3a.0.1747995696348;
        Fri, 23 May 2025 03:21:36 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ce8sm12466688b3a.118.2025.05.23.03.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:21:35 -0700 (PDT)
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
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v8 05/14] riscv: sbi: add SBI FWFT extension calls
Date: Fri, 23 May 2025 12:19:22 +0200
Message-ID: <20250523101932.1594077-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523101932.1594077-1-cleger@rivosinc.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
provided as a separate commit that can be left out if needed.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/sbi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 818efafdc8e9..53836a9235e3 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -299,6 +299,8 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 	return 0;
 }
 
+static bool sbi_fwft_supported;
+
 struct fwft_set_req {
 	u32 feature;
 	unsigned long value;
@@ -326,7 +328,15 @@ static void cpu_sbi_fwft_set(void *arg)
  */
 int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
 {
-	return -EOPNOTSUPP;
+	struct sbiret ret;
+
+	if (!sbi_fwft_supported)
+		return -EOPNOTSUPP;
+
+	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_SET,
+			feature, value, flags, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(ret.error);
 }
 
 /**
@@ -348,6 +358,9 @@ int sbi_fwft_set_cpumask(const cpumask_t *mask, u32 feature,
 		.error = ATOMIC_INIT(0),
 	};
 
+	if (!sbi_fwft_supported)
+		return -EOPNOTSUPP;
+
 	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
 		return -EINVAL;
 
@@ -679,6 +692,11 @@ void __init sbi_init(void)
 			pr_info("SBI DBCN extension detected\n");
 			sbi_debug_console_available = true;
 		}
+		if (sbi_spec_version >= sbi_mk_version(3, 0) &&
+		    sbi_probe_extension(SBI_EXT_FWFT)) {
+			pr_info("SBI FWFT extension detected\n");
+			sbi_fwft_supported = true;
+		}
 	} else {
 		__sbi_set_timer = __sbi_set_timer_v01;
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
-- 
2.49.0


