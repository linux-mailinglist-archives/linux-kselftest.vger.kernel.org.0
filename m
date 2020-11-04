Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1012A613F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 11:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgKDKKK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 05:10:10 -0500
Received: from ozlabs.org ([203.11.71.1]:50033 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgKDKJz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 05:09:55 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CR2Sx3CqYz9sVM; Wed,  4 Nov 2020 21:09:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1604484593;
        bh=a5WygqkHDCvwgU6p3aiWlaAFRr9MW05zMhpOiiyYDM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neaKBrQnwCB9rzlcas5HnhYy9tFLA98XSU3+J5icD6SfgCl+IvbLy8Cz3jKuNrkX/
         Nmw5MTRXBp9fwviHydCqFEvsxSSapEU+5VOt+kkcOHDp8tekBpsfjFw73eX5Y1gYiP
         bD1BZW8C+5SureaekOP4OzqPPs2Qh3/o4QjReNGQpVhlbDebzscNF016gDzZPgIzjv
         krDQhtcBQ6KPdEoJQ7XPyrd1Ri5GTAsBHeRh7s+UlMPRHOOjD4wVOb5Fy6EYQ6cBqW
         qxzD//co8O0TXn3xLpWXjyKILLLth8mRbZaNbB9fWvcHO40ZQufKrRY+QOfvcp8G9A
         yr1dfKtcUA6rw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 3/4] selftests/gpio: Fix build when source tree is read only
Date:   Wed,  4 Nov 2020 21:08:42 +1100
Message-Id: <20201104100843.660407-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104100843.660407-1-mpe@ellerman.id.au>
References: <20201104100843.660407-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the gpio selftests fail to build if the source tree is read
only:

  make -j 160 -C tools/testing/selftests TARGETS=gpio
  make[1]: Entering directory '/linux/tools/testing/selftests/gpio'
  make OUTPUT=/linux/tools/gpio/ -C /linux/tools/gpio
  make[2]: Entering directory '/linux/tools/gpio'
  mkdir -p /linux/tools/gpio/include/linux 2>&1 || true
  ln -sf /linux/tools/gpio/../../include/uapi/linux/gpio.h /linux/tools/gpio/include/linux/gpio.h
  ln: failed to create symbolic link '/linux/tools/gpio/include/linux/gpio.h': Read-only file system

This happens because we ask make to build ../../../gpio (tools/gpio)
without pointing OUTPUT away from the source directory.

To fix it we create a subdirectory of the existing OUTPUT directory,
called tools-gpio, and tell tools/gpio to build in there.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/gpio/Makefile | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 615c8a953ade..acf4088a9891 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -17,14 +17,18 @@ KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 GPIODIR := $(realpath ../../../gpio)
-GPIOOBJ := gpio-utils.o
+GPIOOUT := $(OUTPUT)/tools-gpio/
+GPIOOBJ := $(GPIOOUT)/gpio-utils.o
 
 override define CLEAN
 	$(RM) $(TEST_GEN_PROGS_EXTENDED)
-	$(MAKE) -C $(GPIODIR) OUTPUT=$(GPIODIR)/ clean
+	$(RM) -rf $(GPIOOUT)
 endef
 
-$(TEST_GEN_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
+$(TEST_GEN_PROGS_EXTENDED): $(GPIOOBJ)
 
-$(GPIODIR)/$(GPIOOBJ):
-	$(MAKE) OUTPUT=$(GPIODIR)/ -C $(GPIODIR)
+$(GPIOOUT):
+	mkdir -p $@
+
+$(GPIOOBJ): $(GPIOOUT)
+	$(MAKE) OUTPUT=$(GPIOOUT) -C $(GPIODIR)
-- 
2.25.1

