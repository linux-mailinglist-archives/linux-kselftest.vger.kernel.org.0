Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0241B69028B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 09:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBIIy4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 03:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIIyu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 03:54:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BD853E5D;
        Thu,  9 Feb 2023 00:54:50 -0800 (PST)
Received: from tincan.lan (unknown [IPv6:2001:861:4a40:8620:46d9:3185:bc09:aecb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9349266020B9;
        Thu,  9 Feb 2023 08:54:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675932888;
        bh=vbnRXiU+r4c7lvYMbX38+Jok/UNcPnjR5Ne1oApjqZU=;
        h=From:To:Cc:Subject:Date:From;
        b=VB2WWYTp77n8ycy6ogtmSPtYStA4SHrxRDYimXiBgm2u3/9b2202H5BFiAkaYL5pv
         B3xXlmNMdE+v+VEAIWCfckf9tJAf1xHxt/90wU2OgfqTs08OxBKzRLtMDXjvIee6Hb
         airsB87vt3axe4qUe6k03OdamDha3R023xjKdpL/kMnfD39hZwwAT66WSwiTcMOBQM
         Wr8gwgCTxGwqsAiLm/bGyLc1wZN/q5HONco9swpH8+Cew5urZEn5Mtx4MXz/303UDy
         Shx87ijZ87Al8vXDIySHyDV4AByv38cC/YLTcS/VsEgR5Ct9PTmz+OF/7YN/lnoZuF
         tgkS7RkGUMyKg==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Gautam <gautammenghani201@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernelci@lists.linux.dev
Subject: [PATCH v3] selftests: use printf instead of echo -ne
Date:   Thu,  9 Feb 2023 09:55:36 +0100
Message-Id: <20230209085536.1076662-1-guillaume.tucker@collabora.com>
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

Rather than trying to guess which implementation of "echo" to run with
support for "-ne" options, use "printf" instead of "echo -ne".  It
handles escape characters as a standard feature and it is widespread
among modern shells.

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Fixes: 3297a4df805d ("kselftests: Enable the echo command to print newlines in Makefile")
Fixes: 79c16b1120fe ("selftests: find echo binary to use -ne options")
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---

Notes:
    v2: use printf insead of $(which echo)
    v3: rebase on top of fix with $(which echo)

 tools/testing/selftests/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9619d0f3b2ff..06578963f4f1 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -234,11 +234,10 @@ ifdef INSTALL_PATH
 	@# While building kselftest-list.text skip also non-existent TARGET dirs:
 	@# they could be the result of a build failure and should NOT be
 	@# included in the generated runlist.
-	ECHO=`which echo`; \
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		[ ! -d $(INSTALL_PATH)/$$TARGET ] && $$ECHO "Skipping non-existent dir: $$TARGET" && continue; \
-		$$ECHO -ne "Emit Tests for $$TARGET\n"; \
+		[ ! -d $(INSTALL_PATH)/$$TARGET ] && printf "Skipping non-existent dir: $$TARGET\n" && continue; \
+		printf "Emit Tests for $$TARGET\n"; \
 		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
 			-C $$TARGET emit_tests >> $(TEST_LIST); \
 	done;
-- 
2.30.2

