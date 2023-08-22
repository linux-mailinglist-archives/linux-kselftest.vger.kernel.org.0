Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A687842A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 15:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjHVN6q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjHVN6q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 09:58:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4B61B2;
        Tue, 22 Aug 2023 06:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2AF06574E;
        Tue, 22 Aug 2023 13:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BBAC433C7;
        Tue, 22 Aug 2023 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692712723;
        bh=B6tuRrgtGwA0ObKW3bBPsxHlaa4WJhLQYNJCAXb4G3k=;
        h=From:To:Cc:Subject:Date:From;
        b=Z4WPe1gs3kGTXUTXQ4c9FhqAO4seP+gWMKw+YudQbTTBGuoZwETQW08UOZujk+RK/
         015adPhyv8KqlQjMYKqpSuFWuuruCdZ29147L+bKClPO+mwzggp8L2JvwcbvuE8XF6
         Ky/+hvZkmiP38BdaF1amER7CsXpBF2llMzOHTxQNFGCTI21e/872FBm5iYseH4zlOy
         Z6+leGWyDEJkPJiA3F+re6psBrYq24dfZ8fWKh+7p8785Pi2LXzWLZvMl9yADuiEKo
         CevnzOCDenypavD851IeA2oP/M6Mb+UHvCPxlUvFcwML0Ejtn7O7bb5xVGk5DvZSym
         3eDSALKyS+E5w==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Benjamin Poirier <bpoirier@nvidia.com>,
        Jonathan Toppins <jtoppins@redhat.com>
Subject: [PATCH] selftests: Keep symlinks, when possible
Date:   Tue, 22 Aug 2023 15:58:37 +0200
Message-Id: <20230822135837.280967-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

When kselftest is built/installed with the 'gen_tar' target, rsync is
used for the installation step to copy files. Extra care is needed for
tests that have symlinks. Commit ae108c48b5d2 ("selftests: net: Fix
cross-tree inclusion of scripts") added '-L' (transform symlink into
referent file/dir) to rsync, to fix dangling links. However, that
broke some tests where the symlink (being a symlink) is part of the
test (e.g. exec:execveat).

Use rsync's '--copy-unsafe-links' that does right thing.

Fixes: ae108c48b5d2 ("selftests: net: Fix cross-tree inclusion of scripts")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/lib.mk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d17854285f2b..118e0964bda9 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -106,7 +106,7 @@ endef
 run_tests: all
 ifdef building_out_of_srctree
 	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
-		rsync -aLq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
+		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
 	@if [ "X$(TEST_PROGS)" != "X" ]; then \
 		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
@@ -120,7 +120,7 @@ endif
 
 define INSTALL_SINGLE_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
-	$(if $(INSTALL_LIST),rsync -aL $(INSTALL_LIST) $(INSTALL_PATH)/)
+	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST) $(INSTALL_PATH)/)
 endef
 
 define INSTALL_RULE

base-commit: f7757129e3dea336c407551c98f50057c22bb266
-- 
2.39.2

