Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBCF56C0B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 20:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiGHQYg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiGHQYL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 12:24:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D187478E;
        Fri,  8 Jul 2022 09:23:49 -0700 (PDT)
Received: from tincan.cable.virginm.net (cpc108961-cmbg20-2-0-cust263.5-4.cable.virginm.net [80.5.129.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 574C766019F6;
        Fri,  8 Jul 2022 17:23:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657297427;
        bh=RtHf1/AU2+6S1ap2rXy/J91zOx/U7sO3/mkFTHGpcc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDbEVsqBLi2BgozARkMGt2PGJia0ar+RHeN0n0Q9j4oKPiMz4KOzZg4s610rBNrdM
         JSRKoe02MF83PFiBLJuGdr9fftG6rSilHaVy6rG2Ys3QwU3lCcHxkiLaRqLq0Y5nE5
         zms//DuEiu+XYNSfjY1iU4D9yYFdI8TPvsdgTLYV22VOE2LnOtLkNLTxjqf4iaHfmO
         rcuSroC//B/mOnRKxR0XGKacVjQCRJkG/vNsdV5A2SHSFscRvwtFoO6GPjqhQSCAcm
         fQBcq153aE0v5L+i7k4orHgVmq/6TpTKuT4XLXKVnua/WLdHhLKeT1rkG5K7AqsZ4Y
         C4yCoahLCd3CQ==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 4/4] Makefile: add headers_install to kselftest targets
Date:   Fri,  8 Jul 2022 17:23:30 +0100
Message-Id: <4d34d06baf945dc31c78f873771cef3a75b60067.1657296695.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1657296695.git.guillaume.tucker@collabora.com>
References: <cover.1657296695.git.guillaume.tucker@collabora.com>
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

Add headers_install as a dependency to kselftest targets so that they
can be run directly from the top of the tree.  The kselftest Makefile
used to try to call headers_install "backwards" but failed due to the
relative path not being consistent.

Now we can either run this directly:

  $ make O=build kselftest-all

or this:

  $ make O=build headers_install
  $ make O=build -C tools/testing/selftest all

The same commands work as well when building directly in the source
tree (no O=) or any arbitrary path (relative or absolute).

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1a6678d817bd..afc9d739ba44 100644
--- a/Makefile
+++ b/Makefile
@@ -1347,10 +1347,10 @@ tools/%: FORCE
 # Kernel selftest
 
 PHONY += kselftest
-kselftest:
+kselftest: headers_install
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
 
-kselftest-%: FORCE
+kselftest-%: headers_install FORCE
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
 
 PHONY += kselftest-merge
-- 
2.30.2

