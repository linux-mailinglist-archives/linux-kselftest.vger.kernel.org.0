Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D5A68AA6E
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Feb 2023 14:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjBDN4y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Feb 2023 08:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjBDN4v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Feb 2023 08:56:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C05938673;
        Sat,  4 Feb 2023 05:56:10 -0800 (PST)
Received: from tincan.fosdem.net (unknown [IPv6:2001:67c:1810:f055:f11a:faf6:a821:9f0a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD3786602BD5;
        Sat,  4 Feb 2023 13:56:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675518967;
        bh=kSpeY1jQ+KHNtRVxlbyNW0dIhE+UqvA8UpG4A72vwC4=;
        h=From:To:Cc:Subject:Date:From;
        b=UT1hholwJV55eMI6vvLJpuCryw/51RcCoCFuRLtL7pih9Hs2N3PUkHBxV480KgwTa
         7SG9svy3XWc7SPRbRAlSfCfxNP1D6TXUlGEv56j+A4DmJ5r1rsoEwOXtuc7mos1nrA
         tmEuIO1Ve4QDgVP0xQfgoEU/V7VXiJZFr18cCwYDWRAOoWhrlW5KLWE/jaOAnlPpgF
         69QNcR1eTzTYP1EvaM1967A0YFCKnC/kVmeYWpgwBQUtVnADaVlnlv5A2BCg0PUozj
         7MMfESP1VJtFYpXNVC6NgASS06IJ9NBbc1ptpTsTSzF3FaWgjdD5Xbj0G4p04t1H0u
         s4aaYhsnGrfNw==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Gautam <gautammenghani201@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernelci@lists.linux.dev
Subject: [PATCH v2] selftests: use printf instead of echo -ne
Date:   Sat,  4 Feb 2023 14:56:52 +0100
Message-Id: <20230204135652.336495-1-guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On some systems, the default echo command doesn't handle the -e option
and the output looks like this (arm64 build):

-ne Emit Tests for alsa

-ne Emit Tests for amd-pstate

-ne Emit Tests for arm64

This is for example the case with the KernelCI Docker images
e.g. kernelci/gcc-10:x86-kselftest-kernelci.  To avoid this issue, use
printf which handles escape characters as a standard feature and is
more widespread among modern shells.

The output is now formatted as expected (x86 build this time):

Emit Tests for alsa
Emit Tests for amd-pstate
Skipping non-existent dir: arm64

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Fixes: 3297a4df805d ("kselftests: Enable the echo command to print newlines in Makefile")
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---

Notes:
    v2: use printf insead of $(which echo)

 tools/testing/selftests/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 41b649452560..06578963f4f1 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -236,8 +236,8 @@ ifdef INSTALL_PATH
 	@# included in the generated runlist.
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
-		echo -ne "Emit Tests for $$TARGET\n"; \
+		[ ! -d $(INSTALL_PATH)/$$TARGET ] && printf "Skipping non-existent dir: $$TARGET\n" && continue; \
+		printf "Emit Tests for $$TARGET\n"; \
 		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
 			-C $$TARGET emit_tests >> $(TEST_LIST); \
 	done;
-- 
2.30.2

