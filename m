Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4FC750AFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGLO3H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 10:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjGLO3D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 10:29:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D765B1BDF;
        Wed, 12 Jul 2023 07:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6764861805;
        Wed, 12 Jul 2023 14:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C456FC433C8;
        Wed, 12 Jul 2023 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689172140;
        bh=ymDSmyQE+1VjD+F72bagnnqt4nfj752WMEBt5dK+Lf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0R/RaIUJMVH5qRd3pz5jBpfJ9HajmRwajHprZjx4FJo8VuMyk11Gzoauc+8Oi1r5
         RQ2UbSV+xn9cGThw1Vao2W57lLkhyQA5D+CQOCbVK84AW8FxOjF2XPMX6RQ0DgjwZ/
         jKV5Jm9v78U1GUyTpweDIgXj88SVHlVaARwtMzRBsVrVADMtIDU84GljlX7E+QlKD/
         M8WW1BFb9+TmxctYDtMpsQodux4nSlCGfhhv0AErc+zZALvp5htxNuE03oT0aU6OeS
         PVEQdEhyiFBTAhYwcqHTsaMtAwz1NTuh8Jq+BpovEjAZnyOVOFAeo/LbbU5M+QGL+p
         e1LeC3DzwOAhA==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1qJapt-003beq-1r;
        Wed, 12 Jul 2023 16:28:57 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Brendan Higgins" <brendanhiggins@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "David Gow" <davidgow@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        "Nikolai Kondrashov" <spbnick@gmail.com>,
        "Rae Moar" <rmoar@google.com>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mauro.chehab@intel.com
Subject: [PATCH RFC 2/2] drm: add documentation for drm_buddy_test kUnit test
Date:   Wed, 12 Jul 2023 16:28:55 +0200
Message-Id: <0e5f68ab045965292fee1748254bf9b91db9039a.1689171160.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689171160.git.mchehab@kernel.org>
References: <cover.1689171160.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As an example for the new documentation tool, add a documentation
for drm_buddy_test.

I opted to place this on a completely different directory, in order
to make easier to test the feature with:

	$ make SPHINXDIRS="tests" htmldocs

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RFC 0/2] at: https://lore.kernel.org/all/cover.1689171160.git.mchehab@kernel.org/

 Documentation/index.rst                |  2 +-
 Documentation/tests/index.rst          |  6 ++++++
 Documentation/tests/kunit.rst          |  5 +++++
 drivers/gpu/drm/tests/drm_buddy_test.c | 12 ++++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/tests/index.rst
 create mode 100644 Documentation/tests/kunit.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9dfdc826618c..80a6ce14a61a 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -60,7 +60,7 @@ Various other manuals with useful information for all kernel developers.
    fault-injection/index
    livepatch/index
    rust/index
-
+   test/index
 
 User-oriented documentation
 ===========================
diff --git a/Documentation/tests/index.rst b/Documentation/tests/index.rst
new file mode 100644
index 000000000000..bfc39eb5c0aa
--- /dev/null
+++ b/Documentation/tests/index.rst
@@ -0,0 +1,6 @@
+========================
+Kunit documentation test
+========================
+
+.. toctree::
+   kunit
diff --git a/Documentation/tests/kunit.rst b/Documentation/tests/kunit.rst
new file mode 100644
index 000000000000..6ffc151988a0
--- /dev/null
+++ b/Documentation/tests/kunit.rst
@@ -0,0 +1,5 @@
+Kunit tests
+-----------
+
+.. include-test:: drivers/gpu/drm/tests/drm_buddy_test.c
+
diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index 09ee6f6af896..dd6c5afd6cd6 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -737,6 +737,18 @@ static int drm_buddy_suite_init(struct kunit_suite *suite)
 	return 0;
 }
 
+/**
+ * KTEST_SUITE: set of tests for drm buddy alloc
+ * Scope: drm subsystem
+ * Mega feature: drm
+ * Feature: buddy_alloc
+ *
+ * KTEST_TEST: drm_test_buddy_alloc_%s
+ * Description: Run DRM buddy allocation %arg[1] test
+ *
+ * arg[1].values: limit, range, optimistic, smoke, pathological
+ */
+
 static struct kunit_case drm_buddy_tests[] = {
 	KUNIT_CASE(drm_test_buddy_alloc_limit),
 	KUNIT_CASE(drm_test_buddy_alloc_range),
-- 
2.40.1

