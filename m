Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483B0766832
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjG1JGs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjG1JGc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD3273D;
        Fri, 28 Jul 2023 02:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC6C162087;
        Fri, 28 Jul 2023 09:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A6FC433C7;
        Fri, 28 Jul 2023 09:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535187;
        bh=gTZ6pxd2ZYEYYmpnt5LVUEVpp6OYKOh/ECpVr3VoqbQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VWDLwNhMJ04fIVVxLW/N4tmkApHKYCVE96oGEGLjdGRm/c+f4LIjivkGvfrDNyqIY
         IFlE2hH97kWOhzVShr3kkiFwaHkV8NktgqbqwOYSGtQxUQ0GPrz95f3iT0KQ6rricM
         zLRalJujFIkDn6f+minwS9idapvgbsmK2d3e3rCCcjLZGkdXZZP6uZQxOuLaOKFcwD
         Ej8BgS5AMJzwkIEe9e7CLj0f0IhQRHgsjo9dOgF6k/l2iovCS+319YEJxWNC6PXUTJ
         w7HB93NUPtUtIzY3DY8YfAMmB4Ibb62XMP8BCeDnopD9xjQNAYnFLuTZrnY2anKGqg
         50iR+dM8eXClg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Fri, 28 Jul 2023 11:06:15 +0200
Subject: [PATCH v3 02/11] drm/tests: client-modeset: Remove call to
 drm_kunit_helper_free_device()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230728-kms-kunit-actions-rework-v3-2-952565ccccfe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=mripard@kernel.org;
 h=from:subject:message-id; bh=gTZ6pxd2ZYEYYmpnt5LVUEVpp6OYKOh/ECpVr3VoqbQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmHW7kmVGiskl7alxi8TaZY4ldHx/JHHxp5jU5s+b5Y+
 /mNGUelOkpZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjCRYnVGhl6WLeGn6q+FT3r8
 Pet90XOXBZuYjPSsph6onqO5w+ZiTSPDP8NJd1krfjq+3zy7rvey1cLDVk6qAdNzGzKc46uPGeU
 a8gMA
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
 drivers/gpu/drm/tests/drm_client_modeset_test.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
index 416a279b6dae..7516f6cb36e4 100644
--- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
+++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
@@ -82,13 +82,6 @@ static int drm_client_modeset_test_init(struct kunit *test)
 	return 0;
 }
 
-static void drm_client_modeset_test_exit(struct kunit *test)
-{
-	struct drm_client_modeset_test_priv *priv = test->priv;
-
-	drm_kunit_helper_free_device(test, priv->dev);
-}
-
 static void drm_test_pick_cmdline_res_1920_1080_60(struct kunit *test)
 {
 	struct drm_client_modeset_test_priv *priv = test->priv;
@@ -188,7 +181,6 @@ static struct kunit_case drm_test_pick_cmdline_tests[] = {
 static struct kunit_suite drm_test_pick_cmdline_test_suite = {
 	.name = "drm_test_pick_cmdline",
 	.init = drm_client_modeset_test_init,
-	.exit = drm_client_modeset_test_exit,
 	.test_cases = drm_test_pick_cmdline_tests
 };
 

-- 
2.41.0

