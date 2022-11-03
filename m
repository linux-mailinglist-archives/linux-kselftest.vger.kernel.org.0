Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3565618003
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiKCOv6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiKCOvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06214178B6;
        Thu,  3 Nov 2022 07:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88BE261F12;
        Thu,  3 Nov 2022 14:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35592C43470;
        Thu,  3 Nov 2022 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667487103;
        bh=ohLWpaSXOlu4dCc/Wp9Ps5KyM6JoEy8FjBz8BTfpYGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPTHQb9srVytDkTbnedtZRNKSm0YebAtROcE/TX4sFfoxRdDxqMABdEE6dvsGdsje
         AaMh5dSjBojxj8DfH681VDEQ8t8H0LQg56d92U3eYQ5RcowrmduRMdoo4gZ53bYxAM
         Gp99U87DQK2wiVKhRDcl95DqevYmuRThHUx47bhRyj5Me7nXWAEqchTVp5I++9vByE
         K/U38y5mYL9dlHUC9zR5egAlmOtlOla2vXgyzVNfjpv2gPLsadCQNgiT0PI0LZoOs0
         QyV7Q1MAQ/sbgvP45soNepOfCJYPPzbnjqf9/cr8gQea172Wtw1LVOpVTo+Nr0JTju
         IoOVj0foE6W3Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1oqbZE-0076as-04;
        Thu, 03 Nov 2022 14:51:40 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Daniel Latypov" <dlatypov@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Isabella Basso" <isabbasso@riseup.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Arunpravin <Arunpravin.PaneerSelvam@amd.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Bommu Krishnaiah <krishnaiah.bommu@intel.com>,
        Bruce Chang <yu.bruce.chang@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Dan Carpenter <error27@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Harish Chegondi <harish.chegondi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        John Harrison <john.c.harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Atwood <matthew.s.atwood@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Rahul Kumar Singh <rahul.kumar.singh@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Riana Tauro <riana.tauro@intel.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sujaritha Sundaresan <sujaritha.sundaresan@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH RFC v2 1/8] drm/i915: export all selftest functions
Date:   Thu,  3 Nov 2022 14:51:31 +0000
Message-Id: <0b91456b1d3b1ef86d63222a4421e0d431b6605a.1667486144.git.mchehab@kernel.org>
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

In order to prepare for a new KUnit module that will run
selftests, export all selftest functions to I915_SELFTEST
namespace.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RFC v2 0/8] at: https://lore.kernel.org/all/cover.1667486144.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/selftests/huge_pages.c          | 2 ++
 drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c | 1 +
 drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c  | 1 +
 drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c    | 1 +
 drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c     | 2 ++
 drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c    | 1 +
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c       | 1 +
 drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c     | 2 ++
 drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c       | 1 +
 drivers/gpu/drm/i915/gt/selftest_context.c               | 1 +
 drivers/gpu/drm/i915/gt/selftest_engine.c                | 1 +
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c             | 2 ++
 drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c      | 1 +
 drivers/gpu/drm/i915/gt/selftest_execlists.c             | 1 +
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c                 | 2 ++
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c             | 1 +
 drivers/gpu/drm/i915/gt/selftest_lrc.c                   | 1 +
 drivers/gpu/drm/i915/gt/selftest_migrate.c               | 2 ++
 drivers/gpu/drm/i915/gt/selftest_mocs.c                  | 1 +
 drivers/gpu/drm/i915/gt/selftest_reset.c                 | 1 +
 drivers/gpu/drm/i915/gt/selftest_ring.c                  | 1 +
 drivers/gpu/drm/i915/gt/selftest_ring_submission.c       | 1 +
 drivers/gpu/drm/i915/gt/selftest_slpc.c                  | 1 +
 drivers/gpu/drm/i915/gt/selftest_timeline.c              | 2 ++
 drivers/gpu/drm/i915/gt/selftest_workarounds.c           | 1 +
 drivers/gpu/drm/i915/gt/st_shmem_utils.c                 | 1 +
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c                | 1 +
 drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c      | 1 +
 drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c      | 1 +
 drivers/gpu/drm/i915/selftests/i915_active.c             | 1 +
 drivers/gpu/drm/i915/selftests/i915_gem.c                | 1 +
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c          | 2 ++
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c            | 2 ++
 drivers/gpu/drm/i915/selftests/i915_perf.c               | 1 +
 drivers/gpu/drm/i915/selftests/i915_request.c            | 3 +++
 drivers/gpu/drm/i915/selftests/i915_selftest.c           | 2 ++
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c           | 1 +
 drivers/gpu/drm/i915/selftests/i915_syncmap.c            | 1 +
 drivers/gpu/drm/i915/selftests/i915_vma.c                | 2 ++
 drivers/gpu/drm/i915/selftests/intel_memory_region.c     | 3 +++
 drivers/gpu/drm/i915/selftests/intel_uncore.c            | 2 ++
 drivers/gpu/drm/i915/selftests/scatterlist.c             | 1 +
 42 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index 0cb99e75b0bc..7cbd01dbff4c 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -1948,6 +1948,7 @@ int i915_gem_huge_page_mock_selftests(void)
 	mock_destroy_device(dev_priv);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_huge_page_mock_selftests, I915_SELFTEST);
 
 int i915_gem_huge_page_live_selftests(struct drm_i915_private *i915)
 {
@@ -1970,3 +1971,4 @@ int i915_gem_huge_page_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_huge_page_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c
index 9a6a6b5b722b..9f1ff1e783f6 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c
@@ -763,3 +763,4 @@ int i915_gem_client_blt_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_client_blt_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
index a666d7e610f5..1fcbc68c9c0f 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
@@ -436,3 +436,4 @@ int i915_gem_coherency_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_coherency_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index d8864444432b..ea41eff234d4 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -1912,3 +1912,4 @@ int i915_gem_context_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_context_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
index f2f3cfad807b..d786e1ea99ec 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
@@ -466,6 +466,7 @@ int i915_gem_dmabuf_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_dmabuf_mock_selftests, I915_SELFTEST);
 
 int i915_gem_dmabuf_live_selftests(struct drm_i915_private *i915)
 {
@@ -478,3 +479,4 @@ int i915_gem_dmabuf_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_dmabuf_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
index fe6c37fd7859..eaab89f46f34 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
@@ -526,3 +526,4 @@ int i915_gem_migrate_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_migrate_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index 1cae24349a96..add5ae56cd89 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -1847,3 +1847,4 @@ int i915_gem_mman_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_mman_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
index bdf5bb40ccf1..3e1442119fdb 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
@@ -88,6 +88,7 @@ int i915_gem_object_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_object_mock_selftests, I915_SELFTEST);
 
 int i915_gem_object_live_selftests(struct drm_i915_private *i915)
 {
@@ -97,3 +98,4 @@ int i915_gem_object_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_object_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
index d43d8dae0f69..03cd27066153 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
@@ -85,3 +85,4 @@ int i915_gem_phys_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_phys_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_context.c b/drivers/gpu/drm/i915/gt/selftest_context.c
index 76fbae358072..e9ef4c5d43f3 100644
--- a/drivers/gpu/drm/i915/gt/selftest_context.c
+++ b/drivers/gpu/drm/i915/gt/selftest_context.c
@@ -449,3 +449,4 @@ int intel_context_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, gt);
 }
+EXPORT_SYMBOL_NS_GPL(intel_context_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine.c b/drivers/gpu/drm/i915/gt/selftest_engine.c
index 57fea9ea1705..77358026c97c 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine.c
@@ -25,3 +25,4 @@ int intel_engine_live_selftests(struct drm_i915_private *i915)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(intel_engine_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
index 1b75f478d1b8..f9e5e5ce8d24 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
@@ -366,6 +366,7 @@ int intel_engine_cs_perf_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(intel_engine_cs_perf_selftests, I915_SELFTEST);
 
 static int intel_mmio_bases_check(void *arg)
 {
@@ -421,3 +422,4 @@ int intel_engine_cs_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(intel_engine_cs_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
index 273d440a53e3..eaa66d8d4181 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
@@ -389,6 +389,7 @@ int intel_heartbeat_live_selftests(struct drm_i915_private *i915)
 	i915->params.enable_hangcheck = saved_hangcheck;
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(intel_heartbeat_live_selftests, I915_SELFTEST);
 
 void st_engine_heartbeat_disable(struct intel_engine_cs *engine)
 {
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 2c7c053a8808..a16724cc226f 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -4513,3 +4513,4 @@ int intel_execlists_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(intel_execlists_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
index be94f863bdef..fffcda1ac631 100644
--- a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
+++ b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
@@ -199,6 +199,7 @@ int intel_gt_pm_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(intel_gt_pm_live_selftests, I915_SELFTEST);
 
 int intel_gt_pm_late_selftests(struct drm_i915_private *i915)
 {
@@ -216,3 +217,4 @@ int intel_gt_pm_late_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(intel_gt_pm_late_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
index 71263058a7b0..4c42052dc1fe 100644
--- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
@@ -2058,3 +2058,4 @@ int intel_hangcheck_live_selftests(struct drm_i915_private *i915)
 
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(intel_hangcheck_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_lrc.c b/drivers/gpu/drm/i915/gt/selftest_lrc.c
index 82d3f8058995..a1efc184c428 100644
--- a/drivers/gpu/drm/i915/gt/selftest_lrc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_lrc.c
@@ -1975,3 +1975,4 @@ int intel_lrc_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(intel_lrc_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
index 0dc5309c90a4..84551e0499b6 100644
--- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
+++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
@@ -649,6 +649,7 @@ int intel_migrate_live_selftests(struct drm_i915_private *i915)
 
 	return i915_subtests(tests, &gt->migrate);
 }
+EXPORT_SYMBOL_NS_GPL(intel_migrate_live_selftests, I915_SELFTEST);
 
 static struct drm_i915_gem_object *
 create_init_lmem_internal(struct intel_gt *gt, size_t sz, bool try_lmem)
@@ -870,3 +871,4 @@ int intel_migrate_perf_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, gt);
 }
+EXPORT_SYMBOL_NS_GPL(intel_migrate_perf_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_mocs.c b/drivers/gpu/drm/i915/gt/selftest_mocs.c
index c1d861333c44..9917c39eaab2 100644
--- a/drivers/gpu/drm/i915/gt/selftest_mocs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_mocs.c
@@ -453,3 +453,4 @@ int intel_mocs_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(intel_mocs_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_reset.c b/drivers/gpu/drm/i915/gt/selftest_reset.c
index 37c38bdd5f47..a7e8c182e77d 100644
--- a/drivers/gpu/drm/i915/gt/selftest_reset.c
+++ b/drivers/gpu/drm/i915/gt/selftest_reset.c
@@ -386,3 +386,4 @@ int intel_reset_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, gt);
 }
+EXPORT_SYMBOL_NS_GPL(intel_reset_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_ring.c b/drivers/gpu/drm/i915/gt/selftest_ring.c
index 2a8c534dc125..6590c9c504b9 100644
--- a/drivers/gpu/drm/i915/gt/selftest_ring.c
+++ b/drivers/gpu/drm/i915/gt/selftest_ring.c
@@ -108,3 +108,4 @@ int intel_ring_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(intel_ring_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
index 70f9ac1ec2c7..5343fb71ecfe 100644
--- a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
@@ -296,3 +296,4 @@ int intel_ring_submission_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(intel_ring_submission_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_slpc.c b/drivers/gpu/drm/i915/gt/selftest_slpc.c
index 4c6e9257e593..011c8a8548e0 100644
--- a/drivers/gpu/drm/i915/gt/selftest_slpc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_slpc.c
@@ -443,3 +443,4 @@ int intel_slpc_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(intel_slpc_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_timeline.c b/drivers/gpu/drm/i915/gt/selftest_timeline.c
index 522d0190509c..bb2ff7172b32 100644
--- a/drivers/gpu/drm/i915/gt/selftest_timeline.c
+++ b/drivers/gpu/drm/i915/gt/selftest_timeline.c
@@ -450,6 +450,7 @@ int intel_timeline_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(intel_timeline_mock_selftests, I915_SELFTEST);
 
 static int emit_ggtt_store_dw(struct i915_request *rq, u32 addr, u32 value)
 {
@@ -1423,3 +1424,4 @@ int intel_timeline_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(intel_timeline_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_workarounds.c b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
index 21b1edc052f8..948716ca9ae0 100644
--- a/drivers/gpu/drm/i915/gt/selftest_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
@@ -1393,3 +1393,4 @@ int intel_workarounds_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(intel_workarounds_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/st_shmem_utils.c b/drivers/gpu/drm/i915/gt/st_shmem_utils.c
index b279fe88b70e..46c9d4fca1f8 100644
--- a/drivers/gpu/drm/i915/gt/st_shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/st_shmem_utils.c
@@ -61,3 +61,4 @@ int shmem_utils_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(shmem_utils_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
index e28518fe8b90..06a098cdf84c 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
@@ -300,3 +300,4 @@ int intel_guc_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, gt);
 }
+EXPORT_SYMBOL_NS_GPL(intel_guc_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
index 01f8cd3c3134..7be9107465e5 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
@@ -157,3 +157,4 @@ int intel_guc_hang_check(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, gt);
 }
+EXPORT_SYMBOL_NS_GPL(intel_guc_hang_check, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
index d17982c36d25..88611140c204 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
@@ -181,3 +181,4 @@ int intel_guc_multi_lrc_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, gt);
 }
+EXPORT_SYMBOL_NS_GPL(intel_guc_multi_lrc_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
index b61fe850e924..718af653c49b 100644
--- a/drivers/gpu/drm/i915/selftests/i915_active.c
+++ b/drivers/gpu/drm/i915/selftests/i915_active.c
@@ -260,6 +260,7 @@ int i915_active_live_selftests(struct drm_i915_private *i915)
 
 	return i915_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_active_live_selftests, I915_SELFTEST);
 
 static struct intel_engine_cs *node_to_barrier(struct active_node *it)
 {
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem.c b/drivers/gpu/drm/i915/selftests/i915_gem.c
index e5dd82e7e480..e465f8162d1a 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem.c
@@ -254,3 +254,4 @@ int i915_gem_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
index 8c6517d29b8e..2e2fb6f78ee8 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
@@ -555,6 +555,7 @@ int i915_gem_evict_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_evict_mock_selftests, I915_SELFTEST);
 
 int i915_gem_evict_live_selftests(struct drm_i915_private *i915)
 {
@@ -567,3 +568,4 @@ int i915_gem_evict_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_evict_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index 27c733b00976..c81f03e8183b 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -1938,6 +1938,7 @@ int i915_gem_gtt_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_gtt_mock_selftests, I915_SELFTEST);
 
 static int context_sync(struct intel_context *ce)
 {
@@ -2320,3 +2321,4 @@ int i915_gem_gtt_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_gtt_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
index 429c6d73b159..4499ccafbce7 100644
--- a/drivers/gpu/drm/i915/selftests/i915_perf.c
+++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
@@ -437,3 +437,4 @@ int i915_perf_live_selftests(struct drm_i915_private *i915)
 
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_perf_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index a46350c37e9d..81b1faba55a9 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -563,6 +563,7 @@ int i915_request_mock_selftests(void)
 
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_request_mock_selftests, I915_SELFTEST);
 
 static int live_nop_request(void *arg)
 {
@@ -1869,6 +1870,7 @@ int i915_request_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_request_live_selftests, I915_SELFTEST);
 
 static int switch_to_kernel_sync(struct intel_context *ce, int err)
 {
@@ -3286,3 +3288,4 @@ int i915_request_perf_selftests(struct drm_i915_private *i915)
 
 	return i915_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_request_perf_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index 39da0fb0d6d2..571c9021bd2c 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -39,12 +39,14 @@ int i915_mock_sanitycheck(void)
 	pr_info(DRIVER_NAME ": %s() - ok!\n", __func__);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(i915_mock_sanitycheck, I915_SELFTEST);
 
 int i915_live_sanitycheck(struct drm_i915_private *i915)
 {
 	pr_info("%s: %s() - ok!\n", i915->drm.driver->name, __func__);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(i915_live_sanitycheck, I915_SELFTEST);
 
 enum {
 #define selftest(name, func) mock_##name,
diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
index daa985e5a19b..deccd30fed12 100644
--- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
@@ -755,3 +755,4 @@ int i915_sw_fence_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(i915_sw_fence_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_syncmap.c b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
index 47f4ae18a1ef..09b04f280e73 100644
--- a/drivers/gpu/drm/i915/selftests/i915_syncmap.c
+++ b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
@@ -614,3 +614,4 @@ int i915_syncmap_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(i915_syncmap_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
index 71b52d5efef4..78903e5b034d 100644
--- a/drivers/gpu/drm/i915/selftests/i915_vma.c
+++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
@@ -949,6 +949,7 @@ int i915_vma_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_vma_mock_selftests, I915_SELFTEST);
 
 static int igt_vma_remapped_gtt(void *arg)
 {
@@ -1105,3 +1106,4 @@ int i915_vma_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(i915_vma_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/intel_memory_region.c b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
index 3b18e5905c86..9114f26da77c 100644
--- a/drivers/gpu/drm/i915/selftests/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
@@ -1376,6 +1376,7 @@ int intel_memory_region_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(intel_memory_region_mock_selftests, I915_SELFTEST);
 
 int intel_memory_region_live_selftests(struct drm_i915_private *i915)
 {
@@ -1397,6 +1398,7 @@ int intel_memory_region_live_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(intel_memory_region_live_selftests, I915_SELFTEST);
 
 int intel_memory_region_perf_selftests(struct drm_i915_private *i915)
 {
@@ -1409,3 +1411,4 @@ int intel_memory_region_perf_selftests(struct drm_i915_private *i915)
 
 	return i915_live_subtests(tests, i915);
 }
+EXPORT_SYMBOL_NS_GPL(intel_memory_region_perf_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gpu/drm/i915/selftests/intel_uncore.c
index e4281508d580..7abc037d79de 100644
--- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
+++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
@@ -138,6 +138,7 @@ int intel_uncore_mock_selftests(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(intel_uncore_mock_selftests, I915_SELFTEST);
 
 static int live_forcewake_ops(void *arg)
 {
@@ -352,3 +353,4 @@ int intel_uncore_live_selftests(struct drm_i915_private *i915)
 
 	return intel_gt_live_subtests(tests, to_gt(i915));
 }
+EXPORT_SYMBOL_NS_GPL(intel_uncore_live_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/drm/i915/selftests/scatterlist.c
index d599186d5b71..d29aa7303b16 100644
--- a/drivers/gpu/drm/i915/selftests/scatterlist.c
+++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
@@ -378,3 +378,4 @@ int scatterlist_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(scatterlist_mock_selftests, I915_SELFTEST);
-- 
2.38.1

