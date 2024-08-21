Return-Path: <linux-kselftest+bounces-15815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C645E959471
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 08:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D641C2129E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 06:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E7D16EB41;
	Wed, 21 Aug 2024 06:16:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0D16DC29;
	Wed, 21 Aug 2024 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724220991; cv=none; b=uuiuipb6uP8tyGwcHVxUz/ivqXjcuGnIjF4c7Bynq1xZKGXhM5fMV1/ZHj6WuYGtIntYYMRKNqYRjHNVPjzCt9yrlbIM8n/ofeJ7gP7BeVtJDKBDdubBfaYCcuMyYLRhZY1I9N8xYCaPiveiDjr6+w+atZ+l0BzWf1QEpxiHm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724220991; c=relaxed/simple;
	bh=1Z71Cpi43ZzWABj1r7tRRZZCvPD8/8vnT0XHHW93trA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PBM6Nr6o0mKF5fHqr0+M/efxkBQRlaCBEj0KWmF1RrCi64dKZrZFStDxjVjs33wTycrD9UQFIrqSR0peElKsxiRbWYnbrLrFtSK3YrCJRc2ugcxQ2EOz83aXqtPw/GwYu1BsPcrSgCF4sOaDeHE5kBYO08ol7IjGkRPm3wNIIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6D9DFEC;
	Tue, 20 Aug 2024 23:16:48 -0700 (PDT)
Received: from e116581.arm.com (unknown [10.163.88.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF4B13F73B;
	Tue, 20 Aug 2024 23:16:17 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	oleg@redhat.com
Cc: mingo@kernel.org,
	tglx@linutronix.de,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com,
	aneesh.kumar@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v5 1/2] selftests: Rename sigaltstack to generic signal
Date: Wed, 21 Aug 2024 11:45:22 +0530
Message-Id: <20240821061523.2650568-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821061523.2650568-1-dev.jain@arm.com>
References: <20240821061523.2650568-1-dev.jain@arm.com>
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
Reviewed-by: Mark Brown <broonie@kernel.org>
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
index bc8fe9e8f7f2..edbe30fb3304 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -87,7 +87,7 @@ TARGETS += rtc
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
2.30.2


