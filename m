Return-Path: <linux-kselftest+bounces-24318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65777A0B145
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEEE1648AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 08:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC0233D8D;
	Mon, 13 Jan 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cHOO9q23"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D3233157
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757458; cv=none; b=NnqKqXMd5uWOh1+j+Wlpy23DMSbEy6zVvQWvpkvWNMQrOLMQTgnTeDJkfdaBNuJuG8R0TODsr+QPnrqWxh+Z1uyRISt/iXU/HX5IJzPDOb8+3o4AK6VzFG+7VG54up1I4+wbnQBEw+d2x+3RvUbGqaKMu/qKRFZ/iQ8Rt70aXzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757458; c=relaxed/simple;
	bh=G+K9MvSpAIpwDwMmunI0YSdJnqQJGTJZcC3ONEVxX60=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Ei4iKFGfXhgYyK55n8gjmSV/5B2ZJ61e3f63DU3OpxBCEfqybEuXFOJMjn3S7Zjdfvt4OdaXPs7X99DT4Mm/0sukJjWGGVjaOpY+msyzvhLWAJU9effeFfGa+RkZHNXV4xQzKqSVFA8tBFiFVwjxTTc8ob/z9uVeXZLLOlsappc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cHOO9q23; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21675fd60feso91510025ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 00:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736757456; x=1737362256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n+lHU8O3OzxopxeMRFW7AZqN84liiT6mDTuuIRoGMNs=;
        b=cHOO9q23GP2O7KP6uZaMhyM/GU2r/yvcPeB3+CvTGbQFRR9H0zYS+AGKm///ggF7pV
         trFSg7/URSm/Sb3gDsJQGprxO3BkFEbTeExnuuW4XDgnp6SEtM75xFo7rrTf0plvVLD0
         HT0mSJ+BCtdPELci9mNId69V7jAhlvyZWitAHivBy4jo5E9D8sXVK1jpbUQxKcyitIFG
         BELszUcV1Dl0lzPS9MLgZvYBkBIBpMqACkikICkbWAq05YI1SJUZm2PSEdRo9OWZWKPv
         y95h9JmgAacTW2St0q/jh9rgKKsTsfwYalNyWQ5126lkf77LJ338t8Q8dcmjZruc61tl
         MurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736757456; x=1737362256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+lHU8O3OzxopxeMRFW7AZqN84liiT6mDTuuIRoGMNs=;
        b=ifqo43V3xONKHgNtforoUWBJZnqWWmhbj+MfTDwopVCY2I+xFm2MdDaScjVSO7+JvD
         l8vfsBAaPKklCJ+bGQ8yRSI0e3pyrE7kN6jX6ONf6LtadGAqfJliFEBg16onJjrS4LAz
         RWtVBDKUXAyHB14OcpYzAVDx/C1hTkfr7muogcvXm0HhiDEdZMGsmLR/K3pC3aOTJ1vY
         vEo0dPOt0VJju2gfnaunvUXKRNMe5MsoZNEQPRsITAZ7fjPsSMkKu6ZaTb2TKEkyzaKb
         +xzTjcvkOmlR1Q7J+iwGbOxTzOyptO9u0BFOvBYUY0BFiC/Ks0hHhrjLmbGK9/+D85/K
         4zGw==
X-Forwarded-Encrypted: i=1; AJvYcCX7IfHmbkqmp762QysYwspoH73YSNyJJzLTZMEbjc2/G15K7/b6cfW1Lh3dyLnST7l/bfgPQfUXJozcBG7fZ/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHsOWu6qmOjJmrLmkY1Esy5bQIdwAPsFzzZU0xi/1fd7wgVR1g
	yYPRpV/qpKt9HWMSXuuM54oxJBkCj/HNCUrmCVcqfTqOFsxg/K3IJz2cUmgmEd8=
X-Gm-Gg: ASbGncsJGBEiy2G3tROQSJrATuJfTCzQL1L93CaET9wRX2JcI50W9sydI2TW0i6Yv4y
	ebOb3StzNe8nYHLqsSUEd35XjhUXMISu0aPH/tXyMlWlZs3J6fILaQePQZ1jIuf4Eu9wqxDAxQL
	iCe3VtioRiGEGHxFtEo9yJES06VwHK4VteBPmMBWpldflHZRNiciBlw86ZzZ6UfV588sV5oe+M+
	rjK5NByPG3vJQxr5TgSah7Fq2594tIu8ocJPFqiWOHjRNm2rQJ/hqudN9LkxxtyeyBOPGvUppA2
	09+zEQP8vXrLft0=
X-Google-Smtp-Source: AGHT+IE2vpLLAbTwFgumER+hiNZPVCtR/vb8/ZvSUV9VI3AIzL53lbAShlejX+qABV5VNq93sKjw+w==
X-Received: by 2002:a05:6a21:33aa:b0:1e1:afa9:d397 with SMTP id adf61e73a8af0-1e88d18ea9dmr30431962637.15.1736757456055;
        Mon, 13 Jan 2025 00:37:36 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07ceedsm6427433a12.6.2025.01.13.00.37.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 00:37:35 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v3 1/3] RISC-V: Enable cbo.clean/flush in usermode
Date: Mon, 13 Jan 2025 16:36:33 +0800
Message-Id: <20250113083635.73826-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling cbo.clean and cbo.flush in user mode makes it more
convenient to manage the cache state and achieve better performance.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cpufeature.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c0916ed318c2..60d180b98f52 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -30,6 +30,7 @@
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
 static bool any_cpu_has_zicboz;
+static bool any_cpu_has_zicbom;
 
 unsigned long elf_hwcap __read_mostly;
 
@@ -87,6 +88,8 @@ static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
 		pr_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
 		return -EINVAL;
 	}
+
+	any_cpu_has_zicbom = true;
 	return 0;
 }
 
@@ -944,6 +947,11 @@ void __init riscv_user_isa_enable(void)
 		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
 		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
+
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOM))
+		current->thread.envcfg |= ENVCFG_CBCFE;
+	else if (any_cpu_has_zicbom)
+		pr_warn("Zicbom disabled as it is unavailable on some harts\n");
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.39.2


