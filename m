Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC6575ACBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjGTLQe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjGTLQb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78682D56;
        Thu, 20 Jul 2023 04:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1D3561A2A;
        Thu, 20 Jul 2023 11:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1C8C433C8;
        Thu, 20 Jul 2023 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689851764;
        bh=WCfLzKJ9sM8i+BLjxKY6Cmt+LRE3//pdjKIz70DXm0E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=UNaf6uTbWK2GPJonf5J7mfU2ptw6C7UGMCgxsyCSYwLHB3D636hw4r33zJpx9bYeZ
         VD6RTESqqz2fi3vosR8f3K4hw6Mnl5bWI5Hj9SBSYMQskpG+sDUVlPk8ZwQgfcsdFz
         43zNnRa6famQsILB7m+ijEZKIw0YZysU1unNJrtHfcK+sqUfzoCroZ+SLzG5MAesP+
         9a5HGw1UMS1MKys0T7NCe21aARXQrw1nM2jcHkM2b7tXuQL0po2RN6OeVrUHfyJ6cP
         uo054JNiLq9ulYxTGQnzcVTPcndy7HsUIus2nHsxaeRW8a1+DewnAMBQoe6RjYiOga
         GB+eELLrpjqcw==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 20 Jul 2023 13:15:48 +0200
Subject: [PATCH v2 03/11] drm/tests: modes: Remove call to
 drm_kunit_helper_free_device()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-kms-kunit-actions-rework-v2-3-175017bd56ab@kernel.org>
References: <20230720-kms-kunit-actions-rework-v2-0-175017bd56ab@kernel.org>
In-Reply-To: <20230720-kms-kunit-actions-rework-v2-0-175017bd56ab@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=mripard@kernel.org;
 h=from:subject:message-id; bh=WCfLzKJ9sM8i+BLjxKY6Cmt+LRE3//pdjKIz70DXm0E=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7xTNce5ez58hlbNrX8dW3Q625/pewoty87DUhp/96n
 nWv23q1o5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABNZY8Tw3+eTaXLC9wYzG7Eb
 e8OeXuayXSIW43jS58j8ct11PRGn0hgZPl2/fPBtQvY5L8tb9pPF89n+S3av9Ni/7IuaiPV3q/g
 7DAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

