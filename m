Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4678689E34
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 16:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjBCP0T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 10:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjBCP0A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 10:26:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A93C79F30;
        Fri,  3 Feb 2023 07:25:31 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 53A076602F05;
        Fri,  3 Feb 2023 15:25:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675437930;
        bh=LJFhso2nOYttoMJgKwPgZoKqQrPyp5Qa3zt/8fIFdZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=fqjVdAP75KxK9vv+9nwdq6WcQuwVar1CX4fbwPzZuHljWxhNP5f/6XIqdPE1qCfwc
         z3qhbTxUKI812BAQIronE5hAXjUc7Z93VSOsKuh0/KVA93F6TVNv/gtyuezK7cHDKo
         BXDJdLoMc1A/XDkvnh5w2P44+LHCogt2H8HIzFmAMGG6jJAVxzYkBHTLpIgkkC+uLi
         HhFhgke3fesExQdDioyeKYvKajwRypfkcXjRSjXBVxTSbzr+9EB4wP4eJMmT9fTn36
         RoOi1wtp9m082A5oDIeC83uGHzNIlDD+NsLUFFHe9opdybO/Nx/awcmqx2zuv+aqiJ
         /cjeaz69H651w==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Guillaume Tucker <guillaume.tucker@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Gautam <gautammenghani201@gmail.com>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernelci@lists.linux.dev
Subject: [PATCH] selftests: find echo binary to use -ne options
Date:   Fri,  3 Feb 2023 16:26:03 +0100
Message-Id: <20230203152603.11450-1-guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Find the actual echo binary using $(which echo) and use it for
formatted output with -ne.  On some systems, the default echo command
doesn't handle the -e option and the output looks like this (arm64
build):

-ne Emit Tests for alsa

-ne Emit Tests for amd-pstate

-ne Emit Tests for arm64

This is for example the case with the KernelCI Docker images
e.g. kernelci/gcc-10:x86-kselftest-kernelci.  With the actual echo
binary (e.g. in /bin/echo), the output is formatted as expected (x86
build this time):

Emit Tests for alsa
Emit Tests for amd-pstate
Skipping non-existent dir: arm64

Only the install target is using "echo -ne" so keep the $ECHO variable
local to it.

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Fixes: 3297a4df805d ("kselftests: Enable the echo command to print newlines in Makefile")
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 tools/testing/selftests/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 41b649452560..9619d0f3b2ff 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -234,10 +234,11 @@ ifdef INSTALL_PATH
 	@# While building kselftest-list.text skip also non-existent TARGET dirs:
 	@# they could be the result of a build failure and should NOT be
 	@# included in the generated runlist.
+	ECHO=`which echo`; \
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
-		echo -ne "Emit Tests for $$TARGET\n"; \
+		[ ! -d $(INSTALL_PATH)/$$TARGET ] && $$ECHO "Skipping non-existent dir: $$TARGET" && continue; \
+		$$ECHO -ne "Emit Tests for $$TARGET\n"; \
 		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
 			-C $$TARGET emit_tests >> $(TEST_LIST); \
 	done;
-- 
2.30.2

