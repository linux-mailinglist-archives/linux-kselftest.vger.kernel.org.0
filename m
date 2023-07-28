Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C88C766834
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjG1JGx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjG1JGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:06:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5279230E2;
        Fri, 28 Jul 2023 02:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D90B16208B;
        Fri, 28 Jul 2023 09:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CEFC433C9;
        Fri, 28 Jul 2023 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535190;
        bh=MvKIveuNi6K1WIrzaSAMwm4uJlnqwFoe8oWd0p7j5MA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=oBFsRyrwGGqH8ckpyDai+ft7frs+cAAFnRiTBP9/RrAwHvwInO0PUuFT4btUCqMYx
         8sLGxfWPyLo3+EYguyzLXFP/BdmiAzLZ/aIa5dEziHIPAFQeyJ7bQDtjqrbm0SHre3
         MqkKzHni6r8FBCoxtpmN3z6BUlhsHjLK2cHIRYwsafemDKFsGXvQRq/diJ7IVQwDdU
         lveTJ2F5PnUjvsXOTKBWDX2XL1Kbj7S+KJjtC6VJ9JVBdri+wVsnXQVB80vHWInjp8
         IOYJwOZwpd22oITR4lDD2t0IxqRd1Rwk/QmFJfWTFEKkLfa29aX/gDB3Kn9I9lVbXW
         pueAuAmJO/Y+g==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Fri, 28 Jul 2023 11:06:16 +0200
Subject: [PATCH v3 03/11] drm/tests: modes: Remove call to
 drm_kunit_helper_free_device()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230728-kms-kunit-actions-rework-v3-3-952565ccccfe@kernel.org>
References: <20230728-kms-kunit-actions-rework-v3-0-952565ccccfe@kernel.org>
In-Reply-To: <20230728-kms-kunit-actions-rework-v3-0-952565ccccfe@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=mripard@kernel.org;
 h=from:subject:message-id; bh=MvKIveuNi6K1WIrzaSAMwm4uJlnqwFoe8oWd0p7j5MA=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmHW7kkXYNmmTxuK4n7Its9i1eJ/efWWO+fLH8zFmSFv
 hHjrjvWUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgIkoODD8TyzyeFFxSf257B2X
 uNWfwiyLX3rwGyqnp5xtm+W4KdQii+EP5+W/OpEneXrWlmz+EJjkdCHE8g33+turXFiMHj+yWn6
 WCQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Calling drm_kunit_helper_free_device() to clean up the resources
allocated by drm_kunit_helper_alloc_device() is now optional and not
needed in most cases.

Remove it.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_modes_test.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_modes_test.c b/drivers/gpu/drm/tests/drm_modes_test.c
index bc4aa2ce78be..1e9f63fbfead 100644
--- a/drivers/gpu/drm/tests/drm_modes_test.c
+++ b/drivers/gpu/drm/tests/drm_modes_test.c
@@ -36,13 +36,6 @@ static int drm_test_modes_init(struct kunit *test)
 	return 0;
 }
 
-static void drm_test_modes_exit(struct kunit *test)
-{
-	struct drm_test_modes_priv *priv = test->priv;
-
-	drm_kunit_helper_free_device(test, priv->dev);
-}
-
 static void drm_test_modes_analog_tv_ntsc_480i(struct kunit *test)
 {
 	struct drm_test_modes_priv *priv = test->priv;
@@ -148,7 +141,6 @@ static struct kunit_case drm_modes_analog_tv_tests[] = {
 static struct kunit_suite drm_modes_analog_tv_test_suite = {
 	.name = "drm_modes_analog_tv",
 	.init = drm_test_modes_init,
-	.exit = drm_test_modes_exit,
 	.test_cases = drm_modes_analog_tv_tests,
 };
 

-- 
2.41.0

