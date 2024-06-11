Return-Path: <linux-kselftest+bounces-11656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A6F90340D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 09:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BE42899DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 07:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05AE172BCA;
	Tue, 11 Jun 2024 07:43:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94461E52F;
	Tue, 11 Jun 2024 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091814; cv=none; b=DtCoGW82VAnw93lpsQpkRdyFdUcOllVMeHUffQ9pklBgzWqQ/lIWKAPduHvf1AMy3ibZVRLJg3co9yozKTVWdwvqLKx3r4T0xEBd2V7hJ0ZRqR2nzGARqjQL0Wk20JLCD0KNntjCxWXoFOfFy/2mW6sRLAKoJHCv6YXJuoxWMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091814; c=relaxed/simple;
	bh=3pdZmKSI43FMtAQl2TMStYKg+YNTkPHMgLcGlH67v2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dM8iTmV8nmfLnausadIXZNVwo45Bgn1XIP9+dpvKAIX/T5aQhyHgubOk3Wzs2q2lq9oJhe5zbpBJ6bdW4HngxY8U9sRSdW8kKpNvauCH/G7tL+5ZDj3il6o4/Uq2VVB6pDtInc4etEVQ1xNLiQl80twPwRBdDooFXFJJiX1nISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C84F1476;
	Tue, 11 Jun 2024 00:43:56 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EC213F64C;
	Tue, 11 Jun 2024 00:43:27 -0700 (PDT)
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
Subject: [PATCH v2 1/2] selftests: Rename sigaltstack to generic signal
Date: Tue, 11 Jun 2024 13:13:06 +0530
Message-Id: <20240611074307.812939-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611074307.812939-1-dev.jain@arm.com>
References: <20240611074307.812939-1-dev.jain@arm.com>
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


