Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8619175ACC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGTLQh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGTLQb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AA02D58;
        Thu, 20 Jul 2023 04:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E23FB61A28;
        Thu, 20 Jul 2023 11:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D216EC433C7;
        Thu, 20 Jul 2023 11:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689851761;
        bh=on1Ib/kmGdNbcufdxrj7WeqtPtfL4L5bH7r+5VawDuk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=llG11i4EVQXKrbvkGXtR1u46+LVcmwYBDERDalrk8JDZXiDyhHL8TGR/NwHOOMvNz
         1PWyswk6BwwW7bADHTdCleZ1q+vqrR3D3u3eaufT50uTXj60V1Su0aWH9Ba7sJbIF9
         C1lIZS6rDfVEXMfQ2RyGo3KTZUkp1v12raxzjCB7vJhIu1rE8VExCd3ofIP27V6UuG
         kswXF7cP+gbLMfATq2j2h+Agerjhq+i/iFBA8bWywwvLa84PCUTtHVsRaZXPcA4wrO
         XZiq9fsnDj4348m77XsPXkDF3ePIYbvnggXL5vqW7Ya+MGp5OB0kFEID0KZ1GyGlSQ
         lytxEZwckbsbg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 20 Jul 2023 13:15:47 +0200
Subject: [PATCH v2 02/11] drm/tests: client-modeset: Remove call to
 drm_kunit_helper_free_device()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-kms-kunit-actions-rework-v2-2-175017bd56ab@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=mripard@kernel.org;
 h=from:subject:message-id; bh=on1Ib/kmGdNbcufdxrj7WeqtPtfL4L5bH7r+5VawDuk=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7xTMutReF1l6zX6Prf8JdTimR747i00X/wr9cjlP+s
 PSsZL1wRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACbyl5vhf45OjvbEhkh2RtlL
 2yz0e+fl+WevT8w0X1sz22zH0st3JRn+6W68zv7FoE1pB59SzjMVVw+r+StS0v92ZK1zC3mx0qO
 WAwA=
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

