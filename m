Return-Path: <linux-kselftest+bounces-39119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E251CB28586
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 20:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656F77BA43D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 18:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA642225A35;
	Fri, 15 Aug 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxi4+IWe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8051F4CB7;
	Fri, 15 Aug 2025 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281258; cv=none; b=ufN1Msn0xEXbP7l/1iNJFGETZfGa4LU9hN7a7GJLttU8KfOv6uPgEObV/B6+NMAmiOMAk2IcuT5GEbSJiOZAEsWPl8cnEnQLjGqm2khnSs6mXlRvspj5bDfL68mRXffrzfKr9/iyUhqBubIovqHiVS8mLuVkqHgXH2yWMPpEroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281258; c=relaxed/simple;
	bh=OxzEES3Byrb7/dVvqVnSxXCGNY2+jcoSY0OZPGvO69k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CDSbj6Fv9C0Fh8w/tzmM5NEoMkluvNDnc7/C++2fmpKY5GCIWssIKW2VEOr6KoCfFE4kRXlgTIVovRnQ++3qc80Co0dpdi7zWUzej90qy5QqGOwhAxJsYb3dDbHv1wtDGqDVmuTE0RAInV5lJTjlLvex0+K0LpJ0c+vqSwliABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxi4+IWe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso2144817b3a.3;
        Fri, 15 Aug 2025 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755281257; x=1755886057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Txv0eigY94VABCpNSrT19lsKnOf+NvBhMBzz1EifcA4=;
        b=Fxi4+IWe3Np2NKbob+5JMHsWJqj3OcD1TW2lgBwZ/xqIwmQ0hBD9/+Tj53Lcr9BZOt
         mfk3W23At9Bq+E+1PvPK9FHKPlhNMM5hthH+ki9VEwQjcAEw5ibgpZPXC7cvivlKuMs1
         CCJHSRUnu8ixrx5uo9jn3d9H+bkEvFrANboWtn99LkKryzM65n+pr2iPosK8hTkND2hI
         jgCrsNGXIvcE8G0IPNaf7urXBuDA+vVPmLhvtRLZtiVVMWsi76mLMRfT3x8ORmXOahcP
         SCc3sVaWXJDwY9tn3T+G3zPVdfgyl4AhQ1/utT9jWjpeAU2b9TFNiytnlUx3gmmJG46a
         89fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755281257; x=1755886057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Txv0eigY94VABCpNSrT19lsKnOf+NvBhMBzz1EifcA4=;
        b=vbHANlXvwnlsxwOhI2xCFdYIDlwnysOyeZ6t6wHX7d3itbrpylJ1u+6bGrNu4J6lsf
         DYcujAqcXpk7klNYL8vmK11ztf1I81uLLQPL60myQjJMm4RuDIkXxQe13UnYHjKIhdIv
         9L5Mxz0GYi+lFoXdzPokmlC8Ihv5J604HX2f0sEkqxuTgSQbHifbifEqfGP9nsBkt6Tb
         DL4n0X4fEUBw4O5pAv4MBvzXvE0gpby7joUCiPv5r2SmDAb9azoCQ+GKPxyxxtRgV5RU
         fuielFCOpqe0iT9aGQPb7J/AsFsoxGS/CYawfFJH58LUyoyuwv9uZ5ECZW1PSKL9zph3
         qUMg==
X-Forwarded-Encrypted: i=1; AJvYcCXPhehCUhe8jsuv3+zPl6j4rhRdsqzp9dS8BaYxXoDmCcq6wXBtv+Pz5s8Fr6qmtYaIYVnAIBqbAXbog4YTW/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy40Qp/mSFVsirVm3FXnJ/y5IFLnra7IzTLqi/w22t8dE+6bia
	U0Hz8nSwpmRv/sVX+RbeFkU/SGFHVLwfcoH92qctgU42WQvz4XInbPHbH02c3TDkSNY=
X-Gm-Gg: ASbGncvHS5EGp4XHH+t3379ubWdPeF2WIRb3XTH1N1ubhPKunZjfYqVVawoBRESJr68
	9t9fwZrvNv3YaPjjp6td1d6njidk5RkKAuLIzTTFXKetDfs07v8prCAijeH1yx8vS94IK78jE0L
	awTmU4suBT9ciUwz7TtWzzPZvapCw5x0H+PMUcN+YHyE1h4zykoLqOYagzMMhsxbFHgPHD+gUIY
	0JAO1QweHpTIMcQiuxUTm7NtOjswOjozixIWCy6mqRYg8u5dF7ei3D9An/zZfHqgaD/R1PS/M/s
	Uum8EWpz3xYLRDQiradOrSZaoYoIaCGAM3EDBcv5BxjHIIKyN2czHTE22EZ6pZ1s38EzF4LT2RQ
	hc3xCfvaNbetzsYdZ1iM9zGKPdwX/ldNu
X-Google-Smtp-Source: AGHT+IHZQFs59X0pM7cQtgM5LxBWUBMt1KUqzQhiajgIm0frQf8o8tCXB8aEphaQJZsF5rVclsZJRw==
X-Received: by 2002:a17:902:da82:b0:242:e0f1:f4bf with SMTP id d9443c01a7336-24478f5143bmr940865ad.18.1755281256546;
        Fri, 15 Aug 2025 11:07:36 -0700 (PDT)
Received: from server.. ([103.251.57.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0d717sm18921065ad.67.2025.08.15.11.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 11:07:35 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: shuah@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Subject: [PATCH] selftests: riscv: Add README for RISC-V KSelfTest
Date: Fri, 15 Aug 2025 23:37:24 +0530
Message-ID: <20250815180724.14459-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a README file for RISC-V specific kernel selftests under
tools/testing/selftests/riscv/. This mirrors the existing README
for arm64, providing clear guidance on how the tests are architecture
specific and skipped on non-riscv systems. It also includes
standard make commands for building, running and installing the
tests, along with a reference to general kselftest documentation.

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 tools/testing/selftests/riscv/README | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 tools/testing/selftests/riscv/README

diff --git a/tools/testing/selftests/riscv/README b/tools/testing/selftests/riscv/README
new file mode 100644
index 000000000000..443da395da68
--- /dev/null
+++ b/tools/testing/selftests/riscv/README
@@ -0,0 +1,24 @@
+KSelfTest RISC-V
+================
+
+- These tests are riscv specific and so not built or run but just skipped
+  completely when env-variable ARCH is found to be different than 'riscv'.
+
+- Holding true the above, RISC-V KSFT tests can be run within the
+  KSelfTest framework using standard Linux top-level-makefile targets:
+
+      $ make TARGETS=riscv kselftest-clean
+      $ make TARGETS=riscv kselftest
+
+      or
+
+      $ make -C tools/testing/selftests TARGETS=riscv \
+		INSTALL_PATH=<your-installation-path> install
+
+      or, alternatively, only specific riscv/ subtargets can be picked:
+
+      $ make -C tools/testing/selftests TARGETS=riscv RISCV_SUBTARGETS="mm vector" \
+		INSTALL_PATH=<your-installation-path> install
+
+   Further details on building and running KSFT can be found in:
+     Documentation/dev-tools/kselftest.rst
-- 
2.43.0


