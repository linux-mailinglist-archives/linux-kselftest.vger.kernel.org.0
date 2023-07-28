Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB13C766839
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjG1JHF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjG1JGl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570143AA3;
        Fri, 28 Jul 2023 02:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6F246208A;
        Fri, 28 Jul 2023 09:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC51C433C9;
        Fri, 28 Jul 2023 09:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535193;
        bh=UK1jgKPZq760d+4leDr/t1IScaR42L2ZHmmPQI4t65A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PUkgS5MghRahlUNlrtvWxP6PfwcQZW+A1vejORtsU7U4yyfSUPCVJSx48HOMZB/bQ
         f2GRin3N74khCrphR1SNTjBJ+Zgh/VwPqLf9LS0YWloAnB9aSQybaoNqOjYiXLqcpa
         vL2HVeI9zevy7a++hAbxBLMoXUVd+H2SAWdYiwMgXFaqMCGYylgxUTkNaHrUItK6PJ
         7BHERs+3/Tq3TUJgcg9TXvI7MJ4CGxeD+c70EdlvaXIYGyxTuSAqLbPeGRncJ5lgkP
         YqSdXXWPUOajSItGVnMElmOMtpw+RRzGbCq/6dwkW+hzvDUJM1CiGXCrqP/pAvjWnr
         z+sUIpnFd98bg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Fri, 28 Jul 2023 11:06:17 +0200
Subject: [PATCH v3 04/11] drm/tests: probe-helper: Remove call to
 drm_kunit_helper_free_device()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230728-kms-kunit-actions-rework-v3-4-952565ccccfe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UK1jgKPZq760d+4leDr/t1IScaR42L2ZHmmPQI4t65A=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmHW7l4yuRvvegrvfhG93ducdA8Za7puy8KnZg3q/hxe
 oB/W9yLjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAExkex0jwxYGB463ltcd0g2T
 13n1/u0Inpcvr//A59UcX03BL/sv8zP8T5lUdz+Rn/Vb5auL/h/i22+vSP5Tcvz08++3O9fo5e/
 5zQ8A
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

