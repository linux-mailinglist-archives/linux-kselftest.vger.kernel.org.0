Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F162A6138
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 11:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgKDKJ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 05:09:58 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:58219 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgKDKJ5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 05:09:57 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CR2Sx6FHYz9sVN; Wed,  4 Nov 2020 21:09:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1604484593;
        bh=3kFSwF+mKTTL4Iah+YZCWoNxgZ901GzljCfDkfAwxW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSawxRlJDKo9uROKSB32k4Z/z3AOVHuT31P2LG+Q0cjSKQGpr2nSAG6pvPu7/gEP4
         0SM90Lhy9WtXeH8oOycfvYv2DW3zzD+r/t3A7xiMybhWJqzAbB+iju8EdTrqreDOt0
         97BAe99otfYwzOWIA+XXmDOlV0XV96p4ouMz2skY0iylXTuFuajisA6V5EGesfvN2S
         EnWIKPp5gbDjHjv8pbw5zMIdkaEOipWJDjbISEl1XoZDWp2Ygwg5zrDyDsVAUn9lbe
         RbBE9DjUCZ4sJ3xUIGrL2VBBtoIDzPsnA0PohN7BLvFPe7xFJoTQwXf9YDXHrZFwvd
         2ryOz6wRJb6ww==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 4/4] selftests/gpio: Add to CLEAN rule rather than overriding
Date:   Wed,  4 Nov 2020 21:08:43 +1100
Message-Id: <20201104100843.660407-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104100843.660407-1-mpe@ellerman.id.au>
References: <20201104100843.660407-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rather than overriding the CLEAN rule we can just append to it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/gpio/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index acf4088a9891..41582fe485ee 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -20,10 +20,7 @@ GPIODIR := $(realpath ../../../gpio)
 GPIOOUT := $(OUTPUT)/tools-gpio/
 GPIOOBJ := $(GPIOOUT)/gpio-utils.o
 
-override define CLEAN
-	$(RM) $(TEST_GEN_PROGS_EXTENDED)
-	$(RM) -rf $(GPIOOUT)
-endef
+CLEAN += ; $(RM) -rf $(GPIOOUT)
 
 $(TEST_GEN_PROGS_EXTENDED): $(GPIOOBJ)
 
-- 
2.25.1

