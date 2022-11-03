Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB638617FFC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiKCOvq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKCOvp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:51:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205A117AAA;
        Thu,  3 Nov 2022 07:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B464361EE5;
        Thu,  3 Nov 2022 14:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236F7C433D7;
        Thu,  3 Nov 2022 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667487103;
        bh=SZs0xzRAu/lUh7Ou+KjchMQxPSRyfWrY0vjw5o+g4yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpKxgCyL33L3sNUJHVl20aN3tHAcB4PT7LFh9WPwQ825+Mh1wn6j7Z/itVmsLysmd
         yGk1LCuWoqegvFew/7rHWwljdrQ0ArgGkTlgATCkbrQ4PdxvelR6onNZ959t6epyvG
         mvcZRlEiF7bMEGRUN7gitM7r6JD126nL/cy1miwXjGD4Ur1MlZmMCYDX8s7eSftYVO
         lR6rMO0/x4xhg67XtY1mvmNcRDk+boLrsOHBhLraEj6p57B6hYGRVBZ60yNF87zEsS
         wg+GhRyb0aI6GM2ZrGlJNNGFfBZXEM2PfOtm3lZcw/QAgh+nKkyQG2Cmuabvr2QnTb
         9MufaJxB8Kkcw==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1oqbZE-0076bA-0R;
        Thu, 03 Nov 2022 14:51:40 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Daniel Latypov" <dlatypov@google.com>,
        "Isabella Basso" <isabbasso@riseup.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH RFC v2 7/8] drm/i915: now that all functions are used, remove __maybe_unused
Date:   Thu,  3 Nov 2022 14:51:37 +0000
Message-Id: <499491f3b7307648fcf6c31c45713d26331d76d7.1667486144.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667486144.git.mchehab@kernel.org>
References: <cover.1667486144.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The PCI-specific KUnit tests that run in bare metal got added,
so we can remove the __maybe_unused from such functions.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RFC v2 0/8] at: https://lore.kernel.org/all/cover.1667486144.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/selftests/i915_kunit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_kunit.c b/drivers/gpu/drm/i915/selftests/i915_kunit.c
index 6de5d3fa8920..e6dbffe919e6 100644
--- a/drivers/gpu/drm/i915/selftests/i915_kunit.c
+++ b/drivers/gpu/drm/i915/selftests/i915_kunit.c
@@ -26,7 +26,7 @@
 
 static int n_boards;
 static struct pci_dev *dev_i915[MAX_PCI_BOARDS];
-static int __maybe_unused i915_pci_init_suite(struct kunit_suite *suite)
+static int i915_pci_init_suite(struct kunit_suite *suite)
 {
 	struct pci_dev *pdev = NULL;
 	int i;
@@ -64,7 +64,7 @@ static int __maybe_unused i915_pci_init_suite(struct kunit_suite *suite)
 	return 0;
 }
 
-static void __maybe_unused i915_pci_exit_suite(struct kunit_suite *suite)
+static void i915_pci_exit_suite(struct kunit_suite *suite)
 {
 	int i;
 
@@ -74,8 +74,8 @@ static void __maybe_unused i915_pci_exit_suite(struct kunit_suite *suite)
 	n_boards = 0;
 }
 
-static void __maybe_unused run_pci_test(struct kunit *test,
-					int (*f)(struct drm_i915_private *i915))
+static void run_pci_test(struct kunit *test,
+			 int (*f)(struct drm_i915_private *i915))
 {
 	struct drm_i915_private *i915;
 	int i, ret, disable_display;
-- 
2.38.1

