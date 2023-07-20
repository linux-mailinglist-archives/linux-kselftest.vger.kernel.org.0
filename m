Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7499375ACC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGTLQz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGTLQg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FEB26B5;
        Thu, 20 Jul 2023 04:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51E1661A04;
        Thu, 20 Jul 2023 11:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297AFC433C7;
        Thu, 20 Jul 2023 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689851775;
        bh=aEbBH90Q7xkJQdnrDQMeL1MCCt2R23BBm7z0R3SziVE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Wo0cwtVmdDvOk9uIrmrFk6ErNrzUBBnsC1KZRI0wB6MqBpUTTifHbXi+Q4ti9Pbko
         12mq6XNT8eOBWCdWlbwzOBlhe9KVggkqh+EKhyEeZyG/iP6X3PnsoZBPvzHkk648Wq
         rtqP2cp9ScuibEqlH3GCvC3OWvhXwDm2HEPBy0CZXlQz681b01VoBnYsviO78MC5cf
         1WWoOK9D0delsBrtpsrRg7t9/zFEu7AazZ+aTLKEmDJ849xEvcL65lzDsra6FZGHSI
         IDWrl+5h+vsFQsI70F8zz6UHV3d2dCpT6fHEoTNgwhgVCsKAEt6Mm2T7Bdg6xy0ZHg
         zSehdjDP93cuw==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 20 Jul 2023 13:15:52 +0200
Subject: [PATCH v2 07/11] drm/vc4: tests: pv-muxing: Remove call to
 drm_kunit_helper_free_device()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-kms-kunit-actions-rework-v2-7-175017bd56ab@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aEbBH90Q7xkJQdnrDQMeL1MCCt2R23BBm7z0R3SziVE=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7xTM439+7/nvW7ivPzsaz771auWPBlMt35ySmWTOye
 NgGxRbHd5SyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAi/9YwMnyOn6ax4phyFusi
 94dmrS7bJut2Otc9vHfP/RjDe8dZbosY/ln5yfjZvcm+9W3/+Ul1wk1K8iz6wp65WSzuOX6+jRp
 RjAA=
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
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
index ae0bd0f81698..6c982e72cae8 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
@@ -762,7 +762,6 @@ static void vc4_pv_muxing_test_exit(struct kunit *test)
 	drm_modeset_drop_locks(&priv->ctx);
 	drm_modeset_acquire_fini(&priv->ctx);
 	drm_dev_unregister(drm);
-	drm_kunit_helper_free_device(test, vc4->dev);
 }
 
 static struct kunit_case vc4_pv_muxing_tests[] = {
@@ -873,7 +872,6 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 	drm_dev_unregister(drm);
-	drm_kunit_helper_free_device(test, vc4->dev);
 }
 
 static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
@@ -963,7 +961,6 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 	drm_dev_unregister(drm);
-	drm_kunit_helper_free_device(test, vc4->dev);
 }
 
 static void
@@ -1017,7 +1014,6 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 	drm_dev_unregister(drm);
-	drm_kunit_helper_free_device(test, vc4->dev);
 }
 
 static struct kunit_case vc5_pv_muxing_bugs_tests[] = {

-- 
2.41.0

