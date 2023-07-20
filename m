Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A777B75ACB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjGTLQ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGTLQ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:16:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4402D40;
        Thu, 20 Jul 2023 04:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2225561A35;
        Thu, 20 Jul 2023 11:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AAAC433C7;
        Thu, 20 Jul 2023 11:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689851755;
        bh=73gGluoq2h/z3lT1moMzLu5ggv2o12BR1rQu/YvuDqY=;
        h=From:Subject:Date:To:Cc:From;
        b=AADqVC6n/KiENfSQgakkG568Mj9vRtv0ERfGsfDctE6jDIVSEN6cMtCGWbrLGmqKR
         L3SIW0TdsOkVo+xu6/8erHdegTNEs8vpHC6lixIgddDkM/2gVvjXLPLswIUMjXTilO
         59DoFDb0Y68jl4akGEGNPTx1PNnCOz0kIl018edRfuLPycDuF+TR1dNXZCfuxBenel
         DCrO4z299FCeicz7yLBJWiir/vYXu7GTFs5c20jjoeQWtBfjngKr4ub92lIOiYfwdj
         /LW8f0v/Xb6enJJqo052utJOKgyA7owoyQ3s6kb+8If4e/akvHxp+Bj6fOUJAllSA1
         UsOxQOK7alz2Q==
From:   Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 00/11] drm: kunit: Switch to kunit actions
Date:   Thu, 20 Jul 2023 13:15:45 +0200
Message-Id: <20230720-kms-kunit-actions-rework-v2-0-175017bd56ab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGEXuWQC/42NQQ6CMBBFr0Jm7Zh2CFRdeQ/DAssITbUlU0QN4
 e5WTuDy/fz//gKJxXGCU7GA8OySiyED7QqwQxt6RtdlBlJUKqMV+kdC/wxuwtZOuZxQ+BXFY9X
 pujQ12WN5hTwfhW/uvakvTebBpSnKZ3ua9S/9QzprVGiIbHXoDFlDZ88S+L6P0kOzrusXP7+xq
 cEAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=mripard@kernel.org;
 h=from:subject:message-id; bh=73gGluoq2h/z3lT1moMzLu5ggv2o12BR1rQu/YvuDqY=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7xTNWPPmlmWOcu0Oi23rVl1XGqpOqOL5N+H3u4vnEy
 sWKaxUfdpSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAiL+YyMnSKrZ36OHzmhbBv
 dk/MJgpcFJT4N72hPY9Hfcsugctlx3IYfrMeqdK8sq500gHZ/W+nzDfx1P33Ja+mm0k4eKWus5X
 ZEW4A
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

Hi,

Since v6.5-rc1, kunit gained a devm/drmm-like mechanism that makes tests
resources much easier to cleanup.

This series converts the existing tests to use those new actions where
relevant.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v2:
- Fix some typos
- Use plaltform_device_del instead of removing the call to
  platform_device_put after calling platform_device_add
- Link to v1: https://lore.kernel.org/r/20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org

---
Maxime Ripard (11):
      drm/tests: helpers: Switch to kunit actions
      drm/tests: client-modeset: Remove call to drm_kunit_helper_free_device()
      drm/tests: modes: Remove call to drm_kunit_helper_free_device()
      drm/tests: probe-helper: Remove call to drm_kunit_helper_free_device()
      drm/tests: helpers: Create a helper to allocate a locking ctx
      drm/tests: helpers: Create a helper to allocate an atomic state
      drm/vc4: tests: pv-muxing: Remove call to drm_kunit_helper_free_device()
      drm/vc4: tests: mock: Use a kunit action to unregister DRM device
      drm/vc4: tests: pv-muxing: Switch to managed locking init
      drm/vc4: tests: Switch to atomic state allocation helper
      drm/vc4: tests: pv-muxing: Document test scenario

 drivers/gpu/drm/tests/drm_client_modeset_test.c |   8 --
 drivers/gpu/drm/tests/drm_kunit_helpers.c       | 108 +++++++++++++++++++++-
 drivers/gpu/drm/tests/drm_modes_test.c          |   8 --
 drivers/gpu/drm/tests/drm_probe_helper_test.c   |   8 --
 drivers/gpu/drm/vc4/tests/vc4_mock.c            |   5 ++
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c  | 115 +++++++++---------------
 include/drm/drm_kunit_helpers.h                 |   7 ++
 7 files changed, 158 insertions(+), 101 deletions(-)
---
base-commit: c58c49dd89324b18a812762a2bfa5a0458e4f252
change-id: 20230710-kms-kunit-actions-rework-5d163762c93b

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

