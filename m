Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B35E618006
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiKCOwA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiKCOvt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:51:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A2F19291;
        Thu,  3 Nov 2022 07:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F4CDCE2784;
        Thu,  3 Nov 2022 14:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C1CC43141;
        Thu,  3 Nov 2022 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667487103;
        bh=uKx5CM4Wo7SGIbjuqLDYwkAKVGcbP3XPEVY3Uc4z03g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5RTy+HjAvar0v3LCPg/cTbvaP4h/XLMEVtpU8WzJDpdiaLMGFjXTs8OfKoX4Up+P
         iZkvpGfG/E7KYN9NdcloKydjq5kl9zLTOZoH74+e4AFoGN50cTUffTsg2OGfhqzBqH
         k6rUTxAZVPgeConXquQyjjobB71LqZSZiLQY7TiP0fmjZbywAWcLO7UNgrbW4Ezd/c
         odWRxPW5EZedodPgE9m9jr3gWuFBCfl1qFKGL67PK+X1Lpio50bnTp4ZdTikY5B401
         V4hmAL8XGkcR96YNO7tzu87SOf5MCoMohosXFCIwwxWxdN4FlUNBgFzI7oSNHFpfW9
         wNkzH4bFG8Y9Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1oqbZE-0076av-08;
        Thu, 03 Nov 2022 14:51:40 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Daniel Latypov" <dlatypov@google.com>,
        "Isabella Basso" <isabbasso@riseup.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH RFC v2 2/8] drm/i915: place selftest preparation on a separate function
Date:   Thu,  3 Nov 2022 14:51:32 +0000
Message-Id: <71391c51dc48300e4dac3b762abed9201d508302.1667486144.git.mchehab@kernel.org>
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

The selftest preparation logic should also be used by KUnit. So,
place it on a separate function and export it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RFC v2 0/8] at: https://lore.kernel.org/all/cover.1667486144.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/i915_selftest.h          |  2 ++
 .../gpu/drm/i915/selftests/i915_selftest.c    | 22 ++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_selftest.h b/drivers/gpu/drm/i915/i915_selftest.h
index f54de0499be7..7fab96a42a62 100644
--- a/drivers/gpu/drm/i915/i915_selftest.h
+++ b/drivers/gpu/drm/i915/i915_selftest.h
@@ -44,6 +44,7 @@ struct i915_selftest {
 
 extern struct i915_selftest i915_selftest;
 
+void i915_prepare_selftests(const char *name);
 int i915_mock_selftests(void);
 int i915_live_selftests(struct pci_dev *pdev);
 int i915_perf_selftests(struct pci_dev *pdev);
@@ -111,6 +112,7 @@ int __i915_subtests(const char *caller,
 
 #else /* !IS_ENABLED(CONFIG_DRM_I915_SELFTEST) */
 
+static inline void i915_prepare_selftests(const char *) {};
 static inline int i915_mock_selftests(void) { return 0; }
 static inline int i915_live_selftests(struct pci_dev *pdev) { return 0; }
 static inline int i915_perf_selftests(struct pci_dev *pdev) { return 0; }
diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index 571c9021bd2c..011f7b1f7ff5 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -129,13 +129,8 @@ static void set_default_test_all(struct selftest *st, unsigned int count)
 		st[i].enabled = true;
 }
 
-static int __run_selftests(const char *name,
-			   struct selftest *st,
-			   unsigned int count,
-			   void *data)
+void i915_prepare_selftests(const char *name)
 {
-	int err = 0;
-
 	while (!i915_selftest.random_seed)
 		i915_selftest.random_seed = get_random_u32();
 
@@ -144,10 +139,21 @@ static int __run_selftests(const char *name,
 		msecs_to_jiffies_timeout(i915_selftest.timeout_ms) :
 		MAX_SCHEDULE_TIMEOUT;
 
-	set_default_test_all(st, count);
-
 	pr_info(DRIVER_NAME ": Performing %s selftests with st_random_seed=0x%x st_timeout=%u\n",
 		name, i915_selftest.random_seed, i915_selftest.timeout_ms);
+}
+EXPORT_SYMBOL_NS_GPL(i915_prepare_selftests, I915_SELFTEST);
+
+static int __run_selftests(const char *name,
+			   struct selftest *st,
+			   unsigned int count,
+			   void *data)
+{
+	int err = 0;
+
+	i915_prepare_selftests(name);
+
+	set_default_test_all(st, count);
 
 	/* Tests are listed in order in i915_*_selftests.h */
 	for (; count--; st++) {
-- 
2.38.1

