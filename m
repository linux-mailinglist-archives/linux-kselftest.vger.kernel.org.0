Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678CF571492
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiGLI36 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 04:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiGLI3z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 04:29:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565FC3343E;
        Tue, 12 Jul 2022 01:29:54 -0700 (PDT)
Received: from tincan.cable.virginm.net (cpc108961-cmbg20-2-0-cust263.5-4.cable.virginm.net [80.5.129.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CFCF56601A26;
        Tue, 12 Jul 2022 09:29:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657614593;
        bh=W5Q1v87fyB0A366f2I2tzc5CLo3PwdH3SN2IW0yxyhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9Ga2esdxkz4imSvls++aKrvdD1wmv7+HfZXAMvRBnSngoZ4Hhsam5RQCgTuHLrJV
         /srv2T9lLFk0I+vTuzPzAgccnIdG3Gd6l9PlDCcaLcJTgSbNXkhNyF2u3VcKTnPnj2
         0rl2RQSdj/WR/PsHj9AOw8sAr7TRv6JNe2RKbbZzKriGsGtGRclbxJjNz3WqM78eLG
         nRZTSxivptW7RFa+Gce37yP8jd6PzZ4U2rZbt+dZAsWx+9eL1j1+dtXqLSbU4+YOzY
         +B3Qm2YPr3XInF2TYGoGyYcuSklVy8mdRjm1rMhzR4MHmZYWTp0gEmHURwdVZkLpX0
         BdJZQpe4LgMCQ==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/4] Makefile: add headers to kselftest targets
Date:   Tue, 12 Jul 2022 09:29:48 +0100
Message-Id: <745d1921a4d048ea25d262e33b40aad5ee470614.1657614127.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1657614127.git.guillaume.tucker@collabora.com>
References: <cover.1657614127.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add headers as a dependency to kselftest targets so that they can be
run directly from the top of the tree.  The kselftest Makefile used to
try to call headers_install "backwards" but failed due to the relative
path not being consistent.

Now we can either run this directly:

  $ make O=build kselftest-all

or this:

  $ make O=build headers
  $ make O=build -C tools/testing/selftests all

The same commands work as well when building directly in the source
tree (no O=) or any arbitrary path (relative or absolute).

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---

Notes:
    v2: replace headers_install with headers

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1a6678d817bd..02502cc4ced5 100644
--- a/Makefile
+++ b/Makefile
@@ -1347,10 +1347,10 @@ tools/%: FORCE
 # Kernel selftest
 
 PHONY += kselftest
-kselftest:
+kselftest: headers
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
 
-kselftest-%: FORCE
+kselftest-%: headers FORCE
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
 
 PHONY += kselftest-merge
-- 
2.30.2

