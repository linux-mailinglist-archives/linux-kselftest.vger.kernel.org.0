Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214A42A613B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 11:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgKDKKE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 05:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgKDKJz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 05:09:55 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F028BC061A4A;
        Wed,  4 Nov 2020 02:09:54 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CR2Sx0Fksz9sVK; Wed,  4 Nov 2020 21:09:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1604484593;
        bh=QdkZmMlvcp+swaCH7i/edBCL/QIGYMmP5xj/ytrnGyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mLeKP7vy1SjZ0eVFOsVU5Q3kG9DJLP7rOZNmdd5RnXXxiP52+/d/1J3rLxNWvawf8
         t69pl5Cwf7gndCJ7e2ch1UlbDWnhqyNHjmPAa8e0qIa7Ohn8+FYyD5i12RlEkqJoVM
         tDpifag+Y6Lecj/qorwY9ksbNDdNeQvsTF2a6RtfOYtpj6jW9TgQys239zwwRIkufH
         UQobA+RFGUZc1dK7d6VVc8RRUVil4c36ZMJSK/lIKCPvGZ29Cs92dsDQ8UB7spc6Mp
         pBmNXWii1hmB1qmMF3Mq7Fq+NlTesafHqP6IL92zn/e9SSUvAO0av8xDeSJ2RiBiOF
         8CQVGGzOxjI3Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 2/4] selftests/gpio: Move include of lib.mk up
Date:   Wed,  4 Nov 2020 21:08:41 +1100
Message-Id: <20201104100843.660407-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104100843.660407-1-mpe@ellerman.id.au>
References: <20201104100843.660407-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Move the include of lib.mk up so that in a subsequent patch we can use
OUTPUT, which is initialised by lib.mk, in the definition of the GPIO
variables.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/gpio/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index c85fb5acf5f4..615c8a953ade 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -13,6 +13,9 @@ TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
 TEST_GEN_PROGS_EXTENDED := gpio-mockup-chardev
 
+KSFT_KHDR_INSTALL := 1
+include ../lib.mk
+
 GPIODIR := $(realpath ../../../gpio)
 GPIOOBJ := gpio-utils.o
 
@@ -21,9 +24,6 @@ override define CLEAN
 	$(MAKE) -C $(GPIODIR) OUTPUT=$(GPIODIR)/ clean
 endef
 
-KSFT_KHDR_INSTALL := 1
-include ../lib.mk
-
 $(TEST_GEN_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
 
 $(GPIODIR)/$(GPIOOBJ):
-- 
2.25.1

