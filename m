Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D08E75ACC2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjGTLQj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjGTLQd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F142D270B;
        Thu, 20 Jul 2023 04:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 634F061A22;
        Thu, 20 Jul 2023 11:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B63C433C7;
        Thu, 20 Jul 2023 11:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689851766;
        bh=lolA781m2pvNRYndxxR6VFXpaiQRr55iVDwxTaDQ5Cg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dTYuZxfdBdBE4uVyYSw1okw02GNpd3y/cPPtAQH5kOZN05SRokADcJOknZmXVWvuE
         3GVK6YatJzb3/7INyVcGVPXS/K7Dv4YF9y0JAiCMiC6s+lAmTkW3QWPkf5f+qLLwo3
         DDt8ojhhGirvs63NQqLzBv7zKaejXoPaqoBI9JjYDt9uDw+L+wK9VxORVAbaoIHTNH
         Om+lfBGw7an1vRpNb25o5edTtjIBoSVcGWHwgIcnQ6OtO0O6ru1jvzbPCevP8MbYns
         fmEok7SZIrHuDAGCez4A0vfJ88CzhmlYm6nvGniEkV4p1Ix7MvuRdFcuLBJ/qgVFVd
         ASXMThOuUR2cA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 20 Jul 2023 13:15:49 +0200
Subject: [PATCH v2 04/11] drm/tests: probe-helper: Remove call to
 drm_kunit_helper_free_device()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-kms-kunit-actions-rework-v2-4-175017bd56ab@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lolA781m2pvNRYndxxR6VFXpaiQRr55iVDwxTaDQ5Cg=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7xTN+ed+ROjlv+d053PHpDT9F7Cy6r0czLD/5QeDR/
 uW2BzsEO0pZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjARbR+G/84z1p/Vt4iSEfVZ
 7qTu/UJT/Z1W4v1Uk3OO7Wv0sxL95zAyLGoMM+ap3J7fGjpDem/pO+Npf687vcze8HnmQTPrx+E
 neQE=
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
 drivers/gpu/drm/tests/drm_probe_helper_test.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_probe_helper_test.c b/drivers/gpu/drm/tests/drm_probe_helper_test.c
index 0ee65828623e..1a2044070a6c 100644
--- a/drivers/gpu/drm/tests/drm_probe_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_probe_helper_test.c
@@ -60,13 +60,6 @@ static int drm_probe_helper_test_init(struct kunit *test)
 	return 0;
 }
 
-static void drm_probe_helper_test_exit(struct kunit *test)
-{
-	struct drm_probe_helper_test_priv *priv = test->priv;
-
-	drm_kunit_helper_free_device(test, priv->dev);
-}
-
 typedef struct drm_display_mode *(*expected_mode_func_t)(struct drm_device *);
 
 struct drm_connector_helper_tv_get_modes_test {
@@ -208,7 +201,6 @@ static struct kunit_case drm_test_connector_helper_tv_get_modes_tests[] = {
 static struct kunit_suite drm_test_connector_helper_tv_get_modes_suite = {
 	.name = "drm_connector_helper_tv_get_modes",
 	.init = drm_probe_helper_test_init,
-	.exit = drm_probe_helper_test_exit,
 	.test_cases = drm_test_connector_helper_tv_get_modes_tests,
 };
 

-- 
2.41.0

