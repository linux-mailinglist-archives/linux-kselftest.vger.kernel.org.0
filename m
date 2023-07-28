Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A658A766827
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjG1JG3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjG1JGY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A3930E1;
        Fri, 28 Jul 2023 02:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B8A462085;
        Fri, 28 Jul 2023 09:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1666FC433C8;
        Fri, 28 Jul 2023 09:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535181;
        bh=z71umijlxmTAL6fmeqF7sXIHYBkziN7MrblCPM0z1qU=;
        h=From:Subject:Date:To:Cc:From;
        b=L03GYaCqlbKhW+nIfq+i8DR2wabhrsTy4zMBGpLFcCZUGMjx61km5LmkcDQgjzQ21
         S6uRT8J12TQlt8GG4PtIEo0Bv1tfp5XskUIYVnI7VMLa8NhplyGWoTbMldT69FiM3H
         SnoQsE2WRuKtFpZCSNeM7CiC7j8fULtqmuXZX555nKm9a34cnqdizl7zW+GyZS+oem
         G8xv3uIggct0Dp+i4ZgTyGpcv2F68z3fSiXVC+nM1r+cf4KJECMfn5T+747Jl10NtV
         yEbPefhAvU4iHd94JrwjBZXNbJ+jw8vvVOwJ4g5lC5kEgXRPZRzFC0bHK2oEbqiysq
         EkQSM4X+wg5jQ==
From:   Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 00/11] drm: kunit: Switch to kunit actions
Date:   Fri, 28 Jul 2023 11:06:13 +0200
Message-Id: <20230728-kms-kunit-actions-rework-v3-0-952565ccccfe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWFw2QC/43NwQ7CIAyA4VcxnMVACUM9+R7GwwZ1IyiYMqdm2
 bvLdtKL8fg37deRZSSPme1XIyMcfPYpllDrFbNdHVvk3pVmIEAJIwUP18zDPfqe17Yvy5kTPhI
 Frp2slKnA7lTDyvmN8OyfC308le587hO9lk+DnKd/oIPkghsAq7fOgDVwCEgRL5tELZvVAT4k+
 CVBkaTRQprG6apuvqRpmt4wTD9qCwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=mripard@kernel.org;
 h=from:subject:message-id; bh=z71umijlxmTAL6fmeqF7sXIHYBkziN7MrblCPM0z1qU=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmHWzkXrdfJTwr95F2i8+Cv1DTxK8/NejVFbBTe7Y0tz
 d3J73+yo5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABPJ2cnI8GKBgLPzfDsnbtew
 80s2iL+odN63kWN+loHf7Ysq367IvGdk+PV4xXkz8UpG/qDfNc+t16at9v+U+MUkzWl2ud1nkx5
 9DgA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v3:
- Fixed the build cast warnings by switching to wrapper functions 
- Link to v2: https://lore.kernel.org/r/20230720-kms-kunit-actions-rework-v2-0-175017bd56ab@kernel.org

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
 drivers/gpu/drm/tests/drm_kunit_helpers.c       | 141 +++++++++++++++++++++++-
 drivers/gpu/drm/tests/drm_modes_test.c          |   8 --
 drivers/gpu/drm/tests/drm_probe_helper_test.c   |   8 --
 drivers/gpu/drm/vc4/tests/vc4_mock.c            |  12 ++
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c  | 115 +++++++------------
 include/drm/drm_kunit_helpers.h                 |   7 ++
 7 files changed, 198 insertions(+), 101 deletions(-)
---
base-commit: d7b3af5a77e8d8da28f435f313e069aea5bcf172
change-id: 20230710-kms-kunit-actions-rework-5d163762c93b

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

