Return-Path: <linux-kselftest+bounces-8617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169BC8ACE57
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C625F280CC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 13:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DDF14F9C6;
	Mon, 22 Apr 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SEbA+mag"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C5746E
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792905; cv=none; b=YeFRgg0JIMvtIWuqz4f1uHO3lCkTpJgNd5YbhuntELcmLxFc/AN0zz0QfgnREwZMjhPfUNQNin34sbglyNhU0QYhY4GweyzvZlMFhr1J+h4HHx38Omq0XqD7Saofv1Rw5WxfRVGO9MQ8sWgiQqFH4knoKhBQbQrfki0s8treczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792905; c=relaxed/simple;
	bh=EYwJW3pnXgt4/u7Seybxsaep8LZndnyUdkTiuK1YgXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ti+G5OxGCGjbRXcQFlhYZQmhDRM98p2UetIyNabpcDe/dvzzNOXn/WAt5mDHfzCjU5a2FB+pnNe1GcFcedAS9Q4RHXM31gHwxmITDMoZUPzf8MUYTPyTiY0KVNYPVJu0k5uNn/Acv5bU5eXqRZyXFlmI0A50h4/6DqJ5mirPchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=SEbA+mag; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713792901;
	bh=I1zTLridn3MpRPNHPrFiL4i0EYaFFg6luEW2Ul9teu8=;
	h=From:To:Cc:Subject:Date:From;
	b=SEbA+magKolkwPrdQv3Gx6W+5WqSYPglBuj8K0d9dbF23oWo7sEmcHPiVtWWFHX97
	 JMZ0Mf53kovsXBiwMqHtPVriFpqU7xZe5bUHLBswuXQQx1BBNM5sMy5ZHpC98PwYqf
	 1ithabMsxrWjY3pX0r/cfDJK5jhTs/GGCoFaSeKKNQ9Pot6VosS7mN558S1OSns8Z3
	 KK2DOB6yvpdLMokLsX1lCyk3YSQuUNfTzAc40nDoSANhER9+JOicvDL++FD2KhZQV1
	 EkmA4BFOTG61CCIytPexOjAGXlUfS+LiovFCLl5wUaaAgWTG1nSnoucx7BR05FQDHO
	 9hqBXhmRrcakw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNR7m6Qnfz4wc5;
	Mon, 22 Apr 2024 23:35:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <maddy@linux.ibm.com>,
	spoorthy@linux.ibm.com,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 1/2] selftests/powerpc: Convert pmu Makefile to for loop style
Date: Mon, 22 Apr 2024 23:34:52 +1000
Message-ID: <20240422133453.1793988-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pmu Makefile has grown more sub directories over the years. Rather
than open coding the rules for each subdir, use for loops.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/Makefile | 43 ++++++++++----------
 1 file changed, 22 insertions(+), 21 deletions(-)

v2: Actually send both patches.

diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index 1fcacae1b188..773933e5180e 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -9,7 +9,9 @@ top_srcdir = ../../../../..
 include ../../lib.mk
 include ../flags.mk
 
-all: $(TEST_GEN_PROGS) ebb sampling_tests event_code_tests
+SUB_DIRS := ebb sampling_tests event_code_tests
+
+all: $(TEST_GEN_PROGS) $(SUB_DIRS)
 
 $(TEST_GEN_PROGS): $(EXTRA_SOURCES)
 
@@ -23,12 +25,16 @@ $(OUTPUT)/count_stcx_fail: loop.S $(EXTRA_SOURCES)
 
 $(OUTPUT)/per_event_excludes: ../utils.c
 
+$(SUB_DIRS):
+	BUILD_TARGET=$(OUTPUT)/$@; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $@ all
+
 DEFAULT_RUN_TESTS := $(RUN_TESTS)
 override define RUN_TESTS
 	$(DEFAULT_RUN_TESTS)
-	+TARGET=ebb; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests
-	+TARGET=sampling_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests
-	+TARGET=event_code_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests
+	+@for TARGET in $(SUB_DIRS); do \
+		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests; \
+	done;
 endef
 
 emit_tests:
@@ -36,34 +42,29 @@ emit_tests:
 		BASENAME_TEST=`basename $$TEST`;	\
 		echo "$(COLLECTION):$$BASENAME_TEST";	\
 	done
-	+TARGET=ebb; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests
-	+TARGET=sampling_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests
-	+TARGET=event_code_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests
+	+@for TARGET in $(SUB_DIRS); do \
+		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests; \
+	done;
 
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)
-	+TARGET=ebb; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install
-	+TARGET=sampling_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install
-	+TARGET=event_code_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install
+	+@for TARGET in $(SUB_DIRS); do \
+		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install; \
+	done;
 endef
 
 DEFAULT_CLEAN := $(CLEAN)
 override define CLEAN
 	$(DEFAULT_CLEAN)
 	$(RM) $(TEST_GEN_PROGS) $(OUTPUT)/loop.o
-	+TARGET=ebb; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean
-	+TARGET=sampling_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean
-	+TARGET=event_code_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean
+	+@for TARGET in $(SUB_DIRS); do \
+		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean; \
+	done;
 endef
 
-ebb:
-	TARGET=$@; BUILD_TARGET=$$OUTPUT/$$TARGET; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $$TARGET all
-
-sampling_tests:
-	TARGET=$@; BUILD_TARGET=$$OUTPUT/$$TARGET; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $$TARGET all
-
-event_code_tests:
-	TARGET=$@; BUILD_TARGET=$$OUTPUT/$$TARGET; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $$TARGET all
 
 .PHONY: all run_tests ebb sampling_tests event_code_tests emit_tests
-- 
2.44.0


