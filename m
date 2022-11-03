Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43933617FFE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiKCOvr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiKCOvq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EA818B30;
        Thu,  3 Nov 2022 07:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51A1061F0E;
        Thu,  3 Nov 2022 14:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236CFC433C1;
        Thu,  3 Nov 2022 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667487103;
        bh=XOkzFOwDpIGT3U/Yeoh02Bf5BkVtlU79Or/rS7NV0Mc=;
        h=From:To:Cc:Subject:Date:From;
        b=ewxPo0oGwXbmZQQoPJy0f4XrtAKe6Ay1Rqo3Myhp8FexzMyc2nXHFLEvMPuH6ttoo
         zam2CAVdXbrZrK0cA+hEGjB6qdBxnyaGS0WPn7R8qbcn4cwS5IylTr4D3yA5csjoh3
         V4meGZwHMsBVtDWvH4quh45dqVr4HKEspePBXTlxZ7HH9Xjyf4k/sUmq5WIOM0kvxh
         PHG/SpzsQRwsdaByk+pqdpwcuxNN7zWuo0N8s5T/QEQcFJ8dK5/pCxohQeD+bDxBJ3
         s6tsYk4ogReKzWFA6fWWcn96F2VoFE7K3wZFh4Kp6TF0ApAuloRNL49odEdpYyUGrE
         iF5F50u6aI07w==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1oqbZD-0076ap-39;
        Thu, 03 Nov 2022 14:51:39 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        igt-dev@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 0/8] Add KUnit support for i915 driver
Date:   Thu,  3 Nov 2022 14:51:30 +0000
Message-Id: <cover.1667486144.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.38.1
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

This RFC patch series implement KUnit support for i915 driver,
using the already-existing tests inside i915 selftests.

On this version, mock selftest can now run in qemu with:

	$ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
		--kunitconfig=drivers/gpu/drm/i915/selftests

The tests which depends on having a real i915 hardware will be skipped.

All selftests will run on bare metal, by modprobing test-i915 module.

The output can be parsed (with a hack) using kunit.py:

$ (echo "[    0.000000] TAP version 14"; dmesg)>logs; ./tools/testing/kunit/kunit.py parse logs
[14:29:06] ============================================================
[14:29:06] ============ i915 mock selftests (18 subtests) =============
[14:29:06] [PASSED] mock_sanitycheck
[14:29:06] [PASSED] mock_shmem
[14:29:06] [PASSED] mock_fence
[14:29:06] [PASSED] mock_scatterlist
[14:29:06] [PASSED] mock_syncmap
[14:29:06] [PASSED] mock_uncore
[14:29:06] [PASSED] mock_ring
[14:29:06] [PASSED] mock_engine
[14:29:06] [PASSED] mock_timelines
[14:29:06] [PASSED] mock_requests
[14:29:06] [PASSED] mock_objects
[14:29:06] [PASSED] mock_phys
[14:29:06] [PASSED] mock_dmabuf
[14:29:06] [PASSED] mock_vma
[14:29:06] [PASSED] mock_evict
[14:29:06] [PASSED] mock_gtt
[14:29:06] [PASSED] mock_hugepages
[14:29:06] [PASSED] mock_memory_region
[14:29:06] =============== [PASSED] i915 mock selftests ===============
[14:29:06] ============ i915 live selftests (36 subtests) =============
[14:29:06] [PASSED] live_sanitycheck
[14:29:06] [PASSED] live_uncore
[14:29:06] [PASSED] live_workarounds
[14:29:06] [PASSED] live_gt_engines
[14:29:06] [PASSED] live_gt_timelines
[14:29:06] [PASSED] live_gt_contexts
[14:29:06] [PASSED] live_gt_lrc
[14:29:06] [PASSED] live_gt_mocs
[14:29:06] [PASSED] live_gt_pm
[14:29:06] [PASSED] live_gt_heartbeat
[14:29:06] [PASSED] live_requests
[14:29:06] [PASSED] live_migrate
[14:29:06] [PASSED] live_active
[14:29:06] [PASSED] live_objects
[14:29:06] i915: Performing live_mman selftests with st_random_seed=0x1e5d7be5 st_timeout=500
[14:29:06] test_i915: Setting dangerous option KUnit live_mman - tainting kernel
[14:29:06] test_i915: Running live_mman on 0000:00:02.0
[14:29:06] Test called without an user context!
[14:29:06] # live_mman: EXPECTATION FAILED at drivers/gpu/drm/i915/selftests/i915_kunit.c:110
[14:29:06] Expected ret == 0, but
[14:29:06] ret == -22
[14:29:06] not ok 15 - live_mman
[14:29:06] [FAILED] live_mman
[14:29:06] [PASSED] live_dmabuf
[14:29:06] [PASSED] live_vma
[14:29:06] [PASSED] live_coherency
[14:29:06] [PASSED] live_gtt
[14:29:06] [PASSED] live_gem
[14:29:06] [PASSED] live_evict
[14:29:06] [PASSED] live_hugepages
[14:29:06] [PASSED] live_gem_contexts
[14:29:06] [PASSED] live_client
[14:29:06] [PASSED] live_gem_migrate
[14:29:06] [PASSED] live_reset
[14:29:06] [PASSED] live_memory_region
[14:29:06] [PASSED] live_hangcheck
[14:29:06] [PASSED] live_execlists
[14:29:06] [PASSED] live_ring_submission
[14:29:06] [PASSED] live_perf
[14:29:06] [PASSED] live_slpc
[14:29:06] [PASSED] live_guc
[14:29:06] [PASSED] live_guc_multi_lrc
[14:29:06] [PASSED] live_guc_hang
[14:29:06] [PASSED] live_late_gt_pm
[14:29:06] test_i915: 0000:00:02.0: it is a i915 device.
[14:29:06] # Subtest: i915 live selftests
[14:29:06] 1..36
[14:29:06] # i915 live selftests: pass:35 fail:1 skip:0 total:36
[14:29:06] # Totals: pass:35 fail:1 skip:0 total:36
[14:29:06] not ok 2 - i915 live selftests
[14:29:06] =============== [FAILED] i915 live selftests ===============
[14:29:06] ============= i915 perf selftests (4 subtests) =============
[14:29:06] [PASSED] perf_engine_cs
[14:29:06] [PASSED] perf_request
[14:29:06] [PASSED] perf_migrate
[14:29:06] [PASSED] perf_region
[14:29:06] =============== [PASSED] i915 perf selftests ===============
[14:29:06] ============================================================
[14:29:06] Testing complete. Ran 58 tests: passed: 57, failed: 1

It is worth noticing that the mmap tests will fail while running via
KUnit. The reason is that such tests depend on having an user
context allocated at current->mm. While modprobing i915 with
selftests enabled allocates it - this is done by Kernel fork() logic),
modprobing test-i915 doesn't. So, such tests won't run.

We probably need to modify kunit core in order for it to call
mm_alloc() internally before starting the tests.

Comments? 

PS.: the current approach is getting only the final results of the
selftests. I opted for this strategy as we need to support i915 selftests,
as those are used by Intel DRM CI bot. A more intrusive change could
be done in the future, in order to export all tests called via SUBTESTS()
macro.

It also makes sense to add filtering capabilities to the module, as this ends
being needed during development phase, where some tests might fail
on newer hardware.

---
v2:
  - changes outside KUnit module moved to separate patches;
  - added support for running live and perf selftests on bare metal;
  - made the KUnit test logic identical to i915 selftest.

Mauro Carvalho Chehab (8):
  drm/i915: export all selftest functions
  drm/i915: place selftest preparation on a separate function
  drm/i915: allow running mock selftests via Kunit
  drm/i915: add support to run KUnit tests on bare metal
  drm/i915: add live selftests to KUnit
  drm/i915: add perf selftests to KUnit
  drm/i915: now that all functions are used, remove __maybe_unused
  drm/i915: check if current->mm is not NULL

 drivers/gpu/drm/i915/Kconfig                  |  15 +
 drivers/gpu/drm/i915/Makefile                 |   5 +
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |   2 +
 .../i915/gem/selftests/i915_gem_client_blt.c  |   1 +
 .../i915/gem/selftests/i915_gem_coherency.c   |   1 +
 .../drm/i915/gem/selftests/i915_gem_context.c |   1 +
 .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |   2 +
 .../drm/i915/gem/selftests/i915_gem_migrate.c |   1 +
 .../drm/i915/gem/selftests/i915_gem_mman.c    |   6 +
 .../drm/i915/gem/selftests/i915_gem_object.c  |   2 +
 .../drm/i915/gem/selftests/i915_gem_phys.c    |   1 +
 drivers/gpu/drm/i915/gt/selftest_context.c    |   1 +
 drivers/gpu/drm/i915/gt/selftest_engine.c     |   1 +
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |   2 +
 .../drm/i915/gt/selftest_engine_heartbeat.c   |   1 +
 drivers/gpu/drm/i915/gt/selftest_execlists.c  |   1 +
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c      |   2 +
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c  |   1 +
 drivers/gpu/drm/i915/gt/selftest_lrc.c        |   1 +
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |   2 +
 drivers/gpu/drm/i915/gt/selftest_mocs.c       |   1 +
 drivers/gpu/drm/i915/gt/selftest_reset.c      |   1 +
 drivers/gpu/drm/i915/gt/selftest_ring.c       |   1 +
 .../drm/i915/gt/selftest_ring_submission.c    |   1 +
 drivers/gpu/drm/i915/gt/selftest_slpc.c       |   1 +
 drivers/gpu/drm/i915/gt/selftest_timeline.c   |   2 +
 .../gpu/drm/i915/gt/selftest_workarounds.c    |   1 +
 drivers/gpu/drm/i915/gt/st_shmem_utils.c      |   1 +
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c     |   1 +
 .../drm/i915/gt/uc/selftest_guc_hangcheck.c   |   1 +
 .../drm/i915/gt/uc/selftest_guc_multi_lrc.c   |   1 +
 drivers/gpu/drm/i915/i915_selftest.h          |   2 +
 drivers/gpu/drm/i915/selftests/.kunitconfig   |  12 +
 drivers/gpu/drm/i915/selftests/i915_active.c  |   1 +
 drivers/gpu/drm/i915/selftests/i915_gem.c     |   1 +
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |   2 +
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |   2 +
 drivers/gpu/drm/i915/selftests/i915_kunit.c   | 260 ++++++++++++++++++
 drivers/gpu/drm/i915/selftests/i915_perf.c    |   1 +
 drivers/gpu/drm/i915/selftests/i915_request.c |   3 +
 .../gpu/drm/i915/selftests/i915_selftest.c    |  24 +-
 .../gpu/drm/i915/selftests/i915_sw_fence.c    |   1 +
 drivers/gpu/drm/i915/selftests/i915_syncmap.c |   1 +
 drivers/gpu/drm/i915/selftests/i915_vma.c     |   2 +
 .../drm/i915/selftests/intel_memory_region.c  |   3 +
 drivers/gpu/drm/i915/selftests/intel_uncore.c |   2 +
 drivers/gpu/drm/i915/selftests/scatterlist.c  |   1 +
 47 files changed, 371 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/selftests/.kunitconfig
 create mode 100644 drivers/gpu/drm/i915/selftests/i915_kunit.c

-- 
2.38.1


