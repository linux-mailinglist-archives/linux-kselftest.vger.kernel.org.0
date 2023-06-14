Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF57309B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 23:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFNVTK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 17:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFNVTJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 17:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15111BEC;
        Wed, 14 Jun 2023 14:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DBD364263;
        Wed, 14 Jun 2023 21:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268C5C433C8;
        Wed, 14 Jun 2023 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686777547;
        bh=UEhz/kpeox3MvxRfpolw9Y3cKpiMR3f1Bj+mCSrsu+w=;
        h=From:Date:Subject:To:Cc:From;
        b=GzJN/pOX0gp/xstmlig24vmyKpwxXIYsnKum50WEILylD4i6NTZFzKYVhffUDxW1Z
         XfP3kJEiqS+53Z56BzKvRJWl4cEsXDphkVNy+DQNzIwXOwcsHHjnpj3L1guuKBw/hK
         Nti/cS6HDhwvoFs/OnnPPv1R5aTlFX7llyepiWR9tdJTSxhyAmaw13FMj/V+4t+m12
         omVscywuF6a6xs8I2zCR2jW1FVzEqxEHt2YFQtmnSO2O0XYMsJR9ULTbp5It/FMSeI
         scbeCkf0FRyKN6q71Lilt9y90n4UZqGzYZzM5XUc8GNfEr8dGEUIBk9Ks9ZHFkdoQ8
         YTK3QY5/fgFzw==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 14 Jun 2023 22:18:58 +0100
Subject: [PATCH] selftests/mm: Fix cross compilation with LLVM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-kselftest-mm-llvm-v1-1-180523f277d3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMIuimQC/x2NQQqDQAwAvyI5N6Db1kK/UnqImtTg7loSsQXx7
 117nIFhNnA2ZYd7tYHxqq5zLtCcKuhHyi9GHQpDqMO5bpsLTs5RFvYFU8IY14QUrnQbSIRagdJ
 15IydUe7Ho/zMNh36bSz6/a8ez33/AdkJN7h6AAAA
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=3189; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UEhz/kpeox3MvxRfpolw9Y3cKpiMR3f1Bj+mCSrsu+w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkii7IGttHdFnUF0lmq6L7TPI3idmAEp2wD+7pMnu+
 wqAt+VyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIouyAAKCRAk1otyXVSH0OZoCA
 CB/4e2WEwUuvnxjdo+IKA2oPKHQrf9LrGE8Bum4qjdJu1TWsTJNE2T1qrdmYPXAQZFQYlmViy7AeDT
 l21o4NRfo4DZmLv6rx3O49Lq+orAst4ATm/P3+uFGOH08jBnhGTAULa/4edYKGQO/xVq3BKr8zSyBn
 2at4XPXbnZzWMqx/LUDYTS699PrfTxw3ZA1q78EnuQMxxhn+RYZdESgpPYMs7kd6wkGE+d5ZUJbJqL
 ku8wS2yMyX66n13s89P4L824wzcEDcenfJDGTyiQyh3xBP1kueox5NrVPUwAT63but7/Wz82WcRQGZ
 DGUl9W9QiMMHEckJYUrVY6fLz5cnkt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the MM selftests attempt to work out the target architecture by
using CROSS_COMPILE or otherwise querying the host machine, storing the
target architecture in a variable called MACHINE rather than the usual ARCH
though as far as I can tell (including for x86_64) the value is the same as
we would use for architecture.

When cross compiling with LLVM we don't need a CROSS_COMPILE as LLVM can
support many target architectures in a single build so this logic does not
work, CROSS_COMPILE is not set and we end up selecting tests for the host
rather than target architecture. Fix this by using the more standard ARCH
to describe the architecture, taking it from the environment if specified.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/Makefile | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 23af4633f0f4..4f0c50c33ba7 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -5,12 +5,15 @@ LOCAL_HDRS += $(selfdir)/mm/local_config.h $(top_srcdir)/mm/gup_test.h
 
 include local_config.mk
 
+ifeq ($(ARCH),)
+
 ifeq ($(CROSS_COMPILE),)
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 else
 uname_M := $(shell echo $(CROSS_COMPILE) | grep -o '^[a-z0-9]\+')
 endif
-MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/ppc64/')
+ARCH ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/ppc64/')
+endif
 
 # Without this, failed build products remain, with up-to-date timestamps,
 # thus tricking Make (and you!) into believing that All Is Well, in subsequent
@@ -65,7 +68,7 @@ TEST_GEN_PROGS += ksm_tests
 TEST_GEN_PROGS += ksm_functional_tests
 TEST_GEN_PROGS += mdwe_test
 
-ifeq ($(MACHINE),x86_64)
+ifeq ($(ARCH),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
 CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_program.c)
 CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_program.c -no-pie)
@@ -87,13 +90,13 @@ TEST_GEN_PROGS += $(BINARIES_64)
 endif
 else
 
-ifneq (,$(findstring $(MACHINE),ppc64))
+ifneq (,$(findstring $(ARCH),ppc64))
 TEST_GEN_PROGS += protection_keys
 endif
 
 endif
 
-ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sparc64 x86_64))
+ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sparc64 x86_64))
 TEST_GEN_PROGS += va_high_addr_switch
 TEST_GEN_PROGS += virtual_address_range
 TEST_GEN_PROGS += write_to_hugetlbfs
@@ -112,7 +115,7 @@ $(TEST_GEN_PROGS): vm_util.c
 $(OUTPUT)/uffd-stress: uffd-common.c
 $(OUTPUT)/uffd-unit-tests: uffd-common.c
 
-ifeq ($(MACHINE),x86_64)
+ifeq ($(ARCH),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 

---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230614-kselftest-mm-llvm-a25a7daffa6f

Best regards,
-- 
Mark Brown <broonie@kernel.org>

