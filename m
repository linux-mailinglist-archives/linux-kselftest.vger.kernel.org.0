Return-Path: <linux-kselftest+bounces-11354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C1900378
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9B6B21227
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC1519750B;
	Fri,  7 Jun 2024 12:24:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E5196C9E;
	Fri,  7 Jun 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763060; cv=none; b=KUObfDYr++BdJoV8l3sBh5eMa9Vo/G6JR9VvweLDcYNW1uBKwr9ojM02BGneARBPIypiyDw0O18kOQcL/rO0L2pE6p6phhhYTfpLv70JTZkFx7UBAVADk9XeYOQrb445QR0wCUwURV/5ABWlYZWwxpbS212HOgA8sPdmbJfra2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763060; c=relaxed/simple;
	bh=3pdZmKSI43FMtAQl2TMStYKg+YNTkPHMgLcGlH67v2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rZnybnV8TqEWXzcxlwWONLNDgZYU90OGsNTx/H5WjrHEjCo3TKBUfjQvuIWzunSDJd/TmHY0hTn/0o7kgbWrJPZjC9qzsU6lOg3j31M4aOGCUD68UQIEc6IxFRWN9jvPV6bsB+Z068LOVVYGGr16qQ38nko4SiPSuza46PX+rYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BD87339;
	Fri,  7 Jun 2024 05:24:42 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCCE33F64C;
	Fri,  7 Jun 2024 05:24:12 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	oleg@redhat.com,
	stsp2@yandex.ru
Cc: mingo@kernel.org,
	tglx@linutronix.de,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com,
	AneeshKumar.KizhakeVeetil@arm.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 1/2] selftests: Rename sigaltstack to generic signal
Date: Fri,  7 Jun 2024 17:53:18 +0530
Message-Id: <20240607122319.768640-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607122319.768640-1-dev.jain@arm.com>
References: <20240607122319.768640-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename sigaltstack to signal, and rename the existing test to
sigaltstack.c.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/Makefile                                | 2 +-
 tools/testing/selftests/{sigaltstack => signal}/.gitignore      | 2 +-
 tools/testing/selftests/{sigaltstack => signal}/Makefile        | 2 +-
 .../selftests/{sigaltstack => signal}/current_stack_pointer.h   | 0
 .../selftests/{sigaltstack/sas.c => signal/sigaltstack.c}       | 0
 5 files changed, 3 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/{sigaltstack => signal}/.gitignore (76%)
 rename tools/testing/selftests/{sigaltstack => signal}/Makefile (72%)
 rename tools/testing/selftests/{sigaltstack => signal}/current_stack_pointer.h (100%)
 rename tools/testing/selftests/{sigaltstack/sas.c => signal/sigaltstack.c} (100%)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9039f3709aff..eee1031dc18f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -85,7 +85,7 @@ TARGETS += rtc
 TARGETS += rust
 TARGETS += seccomp
 TARGETS += sgx
-TARGETS += sigaltstack
+TARGETS += signal
 TARGETS += size
 TARGETS += sparc64
 TARGETS += splice
diff --git a/tools/testing/selftests/sigaltstack/.gitignore b/tools/testing/selftests/signal/.gitignore
similarity index 76%
rename from tools/testing/selftests/sigaltstack/.gitignore
rename to tools/testing/selftests/signal/.gitignore
index 50a19a8888ce..98a7bbc4f325 100644
--- a/tools/testing/selftests/sigaltstack/.gitignore
+++ b/tools/testing/selftests/signal/.gitignore
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-sas
+sigaltstack
diff --git a/tools/testing/selftests/sigaltstack/Makefile b/tools/testing/selftests/signal/Makefile
similarity index 72%
rename from tools/testing/selftests/sigaltstack/Makefile
rename to tools/testing/selftests/signal/Makefile
index 3e96d5d47036..dd6be992fd81 100644
--- a/tools/testing/selftests/sigaltstack/Makefile
+++ b/tools/testing/selftests/signal/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS = -Wall
-TEST_GEN_PROGS = sas
+TEST_GEN_PROGS = sigaltstack
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/sigaltstack/current_stack_pointer.h b/tools/testing/selftests/signal/current_stack_pointer.h
similarity index 100%
rename from tools/testing/selftests/sigaltstack/current_stack_pointer.h
rename to tools/testing/selftests/signal/current_stack_pointer.h
diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/signal/sigaltstack.c
similarity index 100%
rename from tools/testing/selftests/sigaltstack/sas.c
rename to tools/testing/selftests/signal/sigaltstack.c
-- 
2.34.1


