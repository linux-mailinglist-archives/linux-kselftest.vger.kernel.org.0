Return-Path: <linux-kselftest+bounces-29257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED57A659F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EA17A62D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6FB204592;
	Mon, 17 Mar 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ofsUQIZx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA141FECA7
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231305; cv=none; b=P/CnCWhQdhiK6byykX06exmA2AgrIVL/6a2XGI9Z8ODwGVKBrTKu9QcP9mUJOoNU7MS/L9q3TnvhPFVW1eaIcHcM7g5qhhfNuXsM1nKXQbVmr5NX164+Cp3DmwtJm2Ox2tdT/57Bvyo7SZ2EL8qCGqBUa8+FlV+LKtfv/mpXUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231305; c=relaxed/simple;
	bh=Nf3XuDar9gitRVwziVjGXEjo/ltPNzme/nCKwMDO140=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZuGUQADIsr0FoJ4dEu8i600gezI0L7inQ95Sk1KotQGwN7xoYXR0kHlFAe+HMuxfZDpgr6MKlmLVgPtL5ufDU59dFylqej3yjqEvr+EAQKjljA1Xn8WHpAbOZq3aSHQueWGjeWiESSNfTj7YIpiUCpnl3q0ci+rQGvpI7bKlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ofsUQIZx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912c09be7dso3126416f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742231301; x=1742836101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pNqCCOYMsZxxXyyqHIS5snuORKLAQN1trvRZ+awEuI=;
        b=ofsUQIZxvs8LTJ56g982crtRu6dTuFCOkCYZVrQCWEM9tNwWGc1A6HRz94CH1V87MH
         B4CtaDJ5EA8iRA8aj+Qw3axJREL5n9xqwSCj4nwn01RplBuROB7Lz67ZX7QT6akWUHah
         gopoaQKzRnZugbRPKYYYXR9uq1Hc0tC6QABH79m51W+4O9+a8g0LjEB6zxWDTjNyB/Fj
         8BcvwfOE83wsZKwYkLJpajNNfRWPrcq2hcAp7fU9fDhGmQfXVMFfgX1MmzlbctXI6MSL
         8XvmcW/VO12HZtFd+jtyTPhMJXyqBxV95XQk0bhtTKu5XLpIdVZmbhetpI9hvCzkqvpJ
         qfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231301; x=1742836101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pNqCCOYMsZxxXyyqHIS5snuORKLAQN1trvRZ+awEuI=;
        b=soMo6VWt8cthnjYa/SyarjJSS0ITLEzAR1Lb+dc51RRT73wA3Benqyv00PcrlbC73M
         YE47Fs0bU8jQn2I9EbhDyrIaQQQBnekwWT9n4zPXCYiTiYnrzPtH/MM9YAIRYW0qXCCQ
         TGWDDmEJ8auzM2pSg7UQZCzGyHjlBmUJtmgBn+SsCiwSyxMwA1AOQCrIfQ60WTtXQRPN
         XuAn0QyoYvgUMn+WQcXFfdcfTWX+4JGKib6hydg7l42bDWKJokpwfsidIyxDefS/ANnA
         GxdZMXI6eKOi0wHWBAXvRA9J2AK/x+b+A4kvZnHDIN+slNSMookifWyw9iMCP/cgA40K
         HKVA==
X-Forwarded-Encrypted: i=1; AJvYcCXzt7x69aZr+qgpKSa9tMUGl1y64fa4j05u5BOHD52l4BA2T0ODaqA3nA8ZcBo4deR9r832dM8bLNsQlBfplV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxFpmsw9KzTcNrxKQJLZRmfimjrjkfGa+ZsWfi4ed8uD3umWbG
	IXfOYJa313U4+8/ctWn+/kAQrmKxGLbw+Je3IsypBlIadpN/ohBlqYqOS4NRBlM=
X-Gm-Gg: ASbGncu7Hh2P7W5xWsxRz60FPRmvt0LGL+IPXrkWZ6TJ/Nyypz8gTQ8nHbwQf47YMaS
	A9W9+oQ6W+yL8MOm7VPG2spLH+8NFcx4hPvIT5VGVMgYxnBrf1fBnG8KGJZErmWkWgH4W9iMTGF
	Ue+aAf6VY/Qz5d8xHqRU1QnIjXhXpJKNfXCgHIG7vp9eQw6X58sBiMDjo7SvJFmayqsYkivyuzu
	CLbm0+Lm8NqG7+AUn4sI0cjAdh/ZxfK7VtTEdbLDqMg5eNsjZ+aL1/A2Sg+hcbZmInJZ4spTTbT
	xomFe5gc8XVybyg5xskMI8Yb++GjAVkLfa1sN7ovfOq5bQ==
X-Google-Smtp-Source: AGHT+IE6X4Zl2SvCnLBWCWxVkBGrawQ8DSM4qV1sZG6LsJ3FF5B07Zi+O2FlbpqV8a0E2j6PRS6VBQ==
X-Received: by 2002:adf:b183:0:b0:390:f88c:a6a2 with SMTP id ffacd0b85a97d-3971f12cd8emr13396928f8f.39.1742231301480;
        Mon, 17 Mar 2025 10:08:21 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d23cddb2asm96014505e9.39.2025.03.17.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:08:20 -0700 (PDT)
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
Subject: [PATCH v4 13/18] Documentation/sysctl: add riscv to unaligned-trap supported archs
Date: Mon, 17 Mar 2025 18:06:19 +0100
Message-ID: <20250317170625.1142870-14-cleger@rivosinc.com>
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

riscv supports the "unaligned-trap" sysctl variable, add it to the list
of supported architectures.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index dd49a89a62d3..a38e91c4d92c 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1595,8 +1595,8 @@ unaligned-trap
 
 On architectures where unaligned accesses cause traps, and where this
 feature is supported (``CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW``; currently,
-``arc``, ``parisc`` and ``loongarch``), controls whether unaligned traps
-are caught and emulated (instead of failing).
+``arc``, ``parisc``, ``loongarch`` and ``riscv``), controls whether unaligned
+traps are caught and emulated (instead of failing).
 
 = ========================================================
 0 Do not emulate unaligned accesses.
-- 
2.47.2


