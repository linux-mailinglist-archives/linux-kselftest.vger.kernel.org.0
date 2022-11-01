Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E4614F92
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 17:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKAQmk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 12:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiKAQmj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 12:42:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C12A63DB;
        Tue,  1 Nov 2022 09:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 963B1B81E92;
        Tue,  1 Nov 2022 16:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9912FC433C1;
        Tue,  1 Nov 2022 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667320954;
        bh=pq2kgxtUg2xBR/z96Dfai1mLLcDXe9THKBsplb3Dmnk=;
        h=From:To:Cc:Subject:Date:From;
        b=WjXuPQt7brGUrDRb0bh58npsrJ1TJyrpYp3ztmDP3h98qhrxYp8L6JKddUv2THIME
         91Vx+Z6wXf5NxXF4Hhav31lzYuH448v+0X7CmfY0VaD9WzjRySjFOw0HEFtZ/9OQg8
         X1PDMUmFak2IhNap69GwtTufyvozfhEdkYlMe8cyiLoyl7zzw5Bgr4691ZwWldfHHg
         NCB4qNIvSHU6FwwrokZ7rCxpFQcM0Ynd5EkSNv5+M4eF2oB5VlVgRJ6UH2AGsJ/Kxj
         EVYiZe4jd2aaYoiwEeigOWwuCWUR23sKbeNp6pMMXFZlD6LQkHcU0DdDF6niRzs3jJ
         ZD+DWyHXJXgoQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1opuLO-000Ml4-0t;
        Tue, 01 Nov 2022 16:42:30 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] drm/i915: allow running mock selftests via Kunit
Date:   Tue,  1 Nov 2022 16:42:26 +0000
Message-Id: <e7ace6f673b10898c8b5401aaca466e8105cbc1c.1667320524.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The mock selftests don't require any hardware to run. They can
easily run via kunit with qemu or bare metal.

Add support for it.

With this change, mock selftest can now run in qemu with:

	$ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
		--kunitconfig=drivers/gpu/drm/i915/selftests
	[16:50:24] Configuring KUnit Kernel ...
	[16:50:24] Building KUnit Kernel ...
	Populating config with:
	$ make ARCH=x86_64 O=.kunit olddefconfig
	Building with:
	$ make ARCH=x86_64 O=.kunit --jobs=8
	[16:50:32] Starting KUnit Kernel (1/1)...
	[16:50:32] ============================================================
	Running tests with:
	$ qemu-system-x86_64 -nodefaults -m 1024 -kernel .kunit/arch/x86/boot/bzImage -append 'kunit.enable=1 console=ttyS0 kunit_shutdown=reboot' -no-reboot -nographic -serial stdio
	[16:50:33] ============ i915 mock selftests (18 subtests) =============
	[16:50:33] [PASSED] mock_sanitycheck
	[16:50:33] [PASSED] mock_shmem
	[16:50:37] [PASSED] mock_fence
	[16:50:38] [PASSED] mock_scatterlist
	[16:50:39] [PASSED] mock_syncmap
	[16:50:39] [PASSED] mock_uncore
	[16:50:39] [PASSED] mock_ring
	[16:50:39] [PASSED] mock_engine
	[16:50:43] [PASSED] mock_timelines
	[16:50:45] [PASSED] mock_requests
	[16:50:45] [PASSED] mock_objects
	[16:50:45] [PASSED] mock_phys
	[16:50:45] [PASSED] mock_dmabuf
	[16:50:50] [PASSED] mock_vma
	[16:50:51] [PASSED] mock_evict
	[16:50:53] [PASSED] mock_gtt
	[16:50:54] [PASSED] mock_hugepages
	[16:50:55] [PASSED] mock_memory_region
	[16:50:55] =============== [PASSED] i915 mock selftests ===============
	[16:50:55] ============================================================
	[16:50:55] Testing complete. Ran 18 tests: passed: 18
	[16:50:55] Elapsed time: 31.530s total, 0.003s configuring, 8.512s building, 22.974s running

It is also possible to run the tests on a bare metal machine,
and even collect code coverage data with:

	$ sudo lcov -z && sudo modprobe test-i915 && sudo rmmod test-i915 &&
	  sudo IGT_KERNEL_TREE=~/linux ~/freedesktop-igt/scripts/code_cov_capture mock_selftest
	Auto-detecting gcov kernel support.
	Found upstream gcov kernel support at /sys/kernel/debug/gcov
	Resetting kernel execution counters
	Done.
	[627.14]     Code coverage wrote to mock_selftest.info

The KTAP and Kernel logs will be similar to:

	[  596.382685]     # Subtest: i915 mock selftests
	[  596.382688]     1..18
	[  596.387744] i915: i915_mock_sanitycheck() - ok!
	[  596.395423]     ok 1 - mock_sanitycheck
	[  596.395495] i915: Running shmem_utils_mock_selftests/igt_shmem_basic
	[  596.406650]     ok 2 - mock_shmem
	[  596.406737] i915: Running i915_sw_fence_mock_selftests/test_self
	[  596.416868] i915: Running i915_sw_fence_mock_selftests/test_dag
	[  596.423220] i915: Running i915_sw_fence_mock_selftests/test_AB
	[  596.429585] i915: Running i915_sw_fence_mock_selftests/test_ABC
	[  596.435921] i915: Running i915_sw_fence_mock_selftests/test_AB_C
	[  596.442293] i915: Running i915_sw_fence_mock_selftests/test_C_AB
	[  596.448671] i915: Running i915_sw_fence_mock_selftests/test_chain
	[  596.485336] i915: Running i915_sw_fence_mock_selftests/test_ipc
	[  596.492984] i915: Running i915_sw_fence_mock_selftests/test_timer
	[  602.484395] i915: Running i915_sw_fence_mock_selftests/test_dma_fence
	[  603.876315] Asynchronous wait on fence mock:mock:0 timed out (hint:fence_notify [i915])
	[  603.886148]     ok 3 - mock_fence
	[  603.886377] i915: Running scatterlist_mock_selftests/igt_sg_alloc
	[  604.398052] sg_alloc_table timed out
	[  604.401979] i915: Running scatterlist_mock_selftests/igt_sg_trim
	[  604.909003] i915_sg_trim timed out
	[  604.912850]     ok 4 - mock_scatterlist
	[  604.912987] i915: Running i915_syncmap_mock_selftests/igt_syncmap_init
	[  604.924092] i915: Running i915_syncmap_mock_selftests/igt_syncmap_one
	[  605.430961] i915: Running i915_syncmap_mock_selftests/igt_syncmap_join_above
	[  605.438458] i915: Running i915_syncmap_mock_selftests/igt_syncmap_join_below
	[  605.446670] i915: Running i915_syncmap_mock_selftests/igt_syncmap_neighbours
	[  606.736462] i915: Running i915_syncmap_mock_selftests/igt_syncmap_compact
	[  606.744342] i915: Running i915_syncmap_mock_selftests/igt_syncmap_random
	[  607.266569]     ok 5 - mock_syncmap
	[  607.266771]     ok 6 - mock_uncore
	[  607.271144] i915: Running intel_ring_mock_selftests/igt_ring_direction
	[  607.281872]     ok 7 - mock_ring
	[  607.282142] i915: Running intel_engine_cs_mock_selftests/intel_mmio_bases_check
	[  607.293531]     ok 8 - mock_engine
	[  607.293654] i915: Running intel_timeline_mock_selftests/mock_hwsp_freelist
	[  607.305034]  mock: [drm] Using Transparent Hugepages
	[  607.310389]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
	[  607.318223]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
	[  607.326040]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
	[  608.689291] i915: Running intel_timeline_mock_selftests/igt_sync
	[  608.698029] i915: Running intel_timeline_mock_selftests/bench_sync
	[  608.906628] bench_sync: 53196 random insertions, 1895ns/insert
	[  608.915839] bench_sync: 53196 random lookups, 53ns/lookup
	[  609.155603] bench_sync: 1048321 in-order insertions, 96ns/insert
	[  609.164592] bench_sync: 1048321 in-order lookups, 2ns/lookup
	[  609.387580] bench_sync: 7925741 repeated insert/lookups, 9ns/op
	[  609.494570] bench_sync: 22777779 cyclic/1 insert/lookups, 4ns/op
	[  609.601560] bench_sync: 22764130 cyclic/2 insert/lookups, 4ns/op
	[  609.708550] bench_sync: 20866721 cyclic/3 insert/lookups, 4ns/op
	[  609.815540] bench_sync: 18824730 cyclic/5 insert/lookups, 5ns/op
	[  609.922530] bench_sync: 18970181 cyclic/8 insert/lookups, 5ns/op
	[  610.029521] bench_sync: 6831382 cyclic/13 insert/lookups, 14ns/op
	[  610.151510] bench_sync: 64217 cyclic/21 insert/lookups, 1563ns/op
	[  610.282616]     ok 9 - mock_timelines
	[  610.283053]  mock: [drm] Using Transparent Hugepages
	[  610.292383]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
	[  610.300224]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
	[  610.308041]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
	[  610.316016] i915: Running i915_request_mock_selftests/igt_add_request
	[  610.322822] i915: Running i915_request_mock_selftests/igt_wait_request
	[  610.844362] i915: Running i915_request_mock_selftests/igt_fence_wait
	[  611.363857] i915: Running i915_request_mock_selftests/igt_request_rewind
	[  611.371805] i915: Running i915_request_mock_selftests/mock_breadcrumbs_smoketest
	[  612.250735] Completed 165 waits for 104816 fence across 16 cpus
	[  612.462006]     ok 10 - mock_requests
	[  612.462987]  mock: [drm] Using Transparent Hugepages
	[  612.472754]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
	[  612.480545]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
	[  612.488383]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
	[  612.496394] i915: Running i915_gem_object_mock_selftests/igt_gem_object
	[  612.539886]     ok 11 - mock_objects
	[  612.540722]  mock: [drm] Using Transparent Hugepages
	[  612.550497]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
	[  612.558586]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
	[  612.566459]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
	[  612.574445] i915: Running i915_gem_phys_mock_selftests/mock_phys_object
	[  612.619821]     ok 12 - mock_phys
	[  612.620708]  mock: [drm] Using Transparent Hugepages
	[  612.630193]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
	[  612.638335]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
	[  612.646137]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
	[  612.654080] i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_export
	[  612.661326] i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_import_self
	[  612.669021] i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_import
	[  612.676285] i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_import_ownership
	[  612.688485] i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_export_vmap
	[  612.696350]     ok 13 - mock_dmabuf
	[  612.696939]  mock: [drm] Using Transparent Hugepages
	[  612.706117]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
	[  612.714044]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
	[  612.721922]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
	[  612.729895] i915: Running i915_vma_mock_selftests/igt_vma_create
	[  613.237460] igt_vma_create timed out: after 41 objects in 43 contexts
	[  613.245661] i915: Running i915_vma_mock_selftests/igt_vma_pin1
	[  613.252146] i915: Running i915_vma_mock_selftests/igt_vma_rotate_remap
	[  615.995098] i915: Running i915_vma_mock_selftests/igt_vma_partial
	[  618.518421]     ok 14 - mock_vma
	[  618.519367]  mock: [drm] Using Transparent Hugepages
	[  618.528625]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
	[  618.536467]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
	[  618.544330]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
	[  618.552318] i915: Running i915_gem_evict_mock_selftests/igt_evict_something
	[  618.697340] i915: Running i915_gem_evict_mock_selftests/igt_evict_for_vma
	[  618.836366] i915: Running i915_gem_evict_mock_selftests/igt_evict_for_cache_color
	[  618.849926] i915: Running i915_gem_evict_mock_selftests/igt_evict_vm
	[  618.992647] i915: Running i915_gem_evict_mock_selftests/igt_overcommit
	[  619.170384]     ok 15 - mock_evict
	[  619.171566]  mock: [drm] Using Transparent Hugepages
	[  619.181351]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
	[  619.189520]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
	[  619.197366]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
	[  619.205322] i915: Running i915_gem_gtt_mock_selftests/igt_mock_drunk
	[  619.712643] drunk_hole timed out after 41097/524288
	[  619.717987] i915: Running i915_gem_gtt_mock_selftests/igt_mock_walk
	[  620.225588] walk_hole timed out at a692000
	[  620.230687] i915: Running i915_gem_gtt_mock_selftests/igt_mock_pot
	[  620.976730] pot_hole timed out after 19/33
	[  620.981596] i915: Running i915_gem_gtt_mock_selftests/igt_mock_fill
	[  621.491729] fill_hole timed out (npages=1, prime=257)
	[  621.497424] i915: Running i915_gem_gtt_mock_selftests/igt_gtt_reserve
	[  621.620470] i915: Running i915_gem_gtt_mock_selftests/igt_gtt_insert
	[  621.891015]     ok 16 - mock_gtt
	[  621.892018]  mock: [drm] Using Transparent Hugepages
	[  621.901620]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
	[  621.909449]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
	[  621.917347]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
	[  621.925497] i915: Running i915_gem_huge_page_mock_selftests/igt_mock_exhaust_device_supported_pages
	[  621.937541] i915: Running i915_gem_huge_page_mock_selftests/igt_mock_memory_region_huge_pages
	[  621.947479] i915: Running i915_gem_huge_page_mock_selftests/igt_mock_ppgtt_misaligned_dma
	[  622.032179] i915: Running i915_gem_huge_page_mock_selftests/igt_mock_ppgtt_huge_fill
	[  622.540726] igt_mock_ppgtt_huge_fill timed out at size 61313024
	[  622.547707] i915: Running i915_gem_huge_page_mock_selftests/igt_mock_ppgtt_64K
	[  622.944941]     ok 17 - mock_hugepages
	[  622.945866]  mock: [drm] Using Transparent Hugepages
	[  622.956054]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
	[  622.963891]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
	[  622.971705]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
	[  622.979664] i915: Running intel_memory_region_mock_selftests/igt_mock_reserve
	[  623.006381] i915: Running intel_memory_region_mock_selftests/igt_mock_fill
	[  623.057022] i915: Running intel_memory_region_mock_selftests/igt_mock_contiguous
	[  624.040905] i915: Running intel_memory_region_mock_selftests/igt_mock_splintered_region
	[  624.075553] i915: Running intel_memory_region_mock_selftests/igt_mock_max_segment
	[  624.108598] i915: Running intel_memory_region_mock_selftests/igt_mock_io_size
	[  624.116097] igt_mock_io_size with ps=1000, io_size=a7823000, total=1b5fee000
	[  624.133227] igt_mock_io_size mappable theft=(632MiB/2680MiB), total=7007MiB
	[  624.204955]     ok 18 - mock_memory_region
	[  624.204964] # i915 mock selftests: pass:18 fail:0 skip:0 total:18
	[  624.209921] # Totals: pass:18 fail:0 skip:0 total:18
	[  624.216762] ok 1 - i915 mock selftests.

They could be parsed with kunit.py with:

	echo "[    0.000000] TAP version 14" >logs
	dmesg  >>logs
	./tools/testing/kunit/kunit.py parse logs

Note: kunit.py is currently broken with modules, not producing any
results if "TAP version xx" is not found. It also shows the results
duplicated.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/gpu/drm/i915/Kconfig                  | 15 ++++++
 drivers/gpu/drm/i915/Makefile                 |  5 ++
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  1 +
 .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |  1 +
 .../drm/i915/gem/selftests/i915_gem_object.c  |  1 +
 .../drm/i915/gem/selftests/i915_gem_phys.c    |  1 +
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |  1 +
 drivers/gpu/drm/i915/gt/selftest_ring.c       |  1 +
 drivers/gpu/drm/i915/gt/selftest_timeline.c   |  1 +
 drivers/gpu/drm/i915/gt/st_shmem_utils.c      |  1 +
 drivers/gpu/drm/i915/i915_selftest.h          |  2 +
 drivers/gpu/drm/i915/selftests/.kunitconfig   | 12 +++++
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  1 +
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |  1 +
 drivers/gpu/drm/i915/selftests/i915_kunit.c   | 49 +++++++++++++++++++
 drivers/gpu/drm/i915/selftests/i915_request.c |  1 +
 .../gpu/drm/i915/selftests/i915_selftest.c    | 19 ++++---
 .../gpu/drm/i915/selftests/i915_sw_fence.c    |  1 +
 drivers/gpu/drm/i915/selftests/i915_syncmap.c |  1 +
 drivers/gpu/drm/i915/selftests/i915_vma.c     |  1 +
 .../drm/i915/selftests/intel_memory_region.c  |  1 +
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  1 +
 drivers/gpu/drm/i915/selftests/scatterlist.c  |  1 +
 23 files changed, 113 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/selftests/.kunitconfig
 create mode 100644 drivers/gpu/drm/i915/selftests/i915_kunit.c

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 3efce05d7b57..323c63af72d8 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -53,6 +53,21 @@ config DRM_I915
 
 	  If "M" is selected, the module will be called i915.
 
+config DRM_I915_KUNIT_TESTS
+	tristate "KUnit tests for Intel 8xx/9xx/G3x/G4x/HD Graphics" if !KUNIT_ALL_TESTS
+	depends on DRM_I915 && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds unit tests for i915 driver. This option is not useful for
+	  distributions or general kernels, but only for kernel
+	  developers working on i915 DRM driver.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
+
+	  If in doubt, say "N".
+
 config DRM_I915_FORCE_PROBE
 	string "Force probe driver for selected new Intel hardware"
 	depends on DRM_I915
diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 2535593ab379..4ce1e8113db6 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -341,6 +341,11 @@ i915-$(CONFIG_DRM_I915_SELFTEST) += \
 	selftests/igt_spinner.o \
 	selftests/librapl.o
 
+test-i915-y += selftests/i915_kunit.o
+ifneq ($(CONFIG_DRM_I915_SELFTEST),)
+	obj-$(CONFIG_DRM_I915_KUNIT_TESTS) += test-i915.o
+endif
+
 # virtual gpu code
 i915-y += i915_vgpu.o
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index 0cb99e75b0bc..9cf103b08cf8 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -1948,6 +1948,7 @@ int i915_gem_huge_page_mock_selftests(void)
 	mock_destroy_device(dev_priv);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_huge_page_mock_selftests, I915_SELFTEST);
 
 int i915_gem_huge_page_live_selftests(struct drm_i915_private *i915)
 {
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
index f2f3cfad807b..ac8ef76673dd 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
@@ -466,6 +466,7 @@ int i915_gem_dmabuf_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_dmabuf_mock_selftests, I915_SELFTEST);
 
 int i915_gem_dmabuf_live_selftests(struct drm_i915_private *i915)
 {
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
index bdf5bb40ccf1..4c50be935462 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_object.c
@@ -88,6 +88,7 @@ int i915_gem_object_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_object_mock_selftests, I915_SELFTEST);
 
 int i915_gem_object_live_selftests(struct drm_i915_private *i915)
 {
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
index d43d8dae0f69..03cd27066153 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
@@ -85,3 +85,4 @@ int i915_gem_phys_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_phys_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
index 1b75f478d1b8..1cfe2477f23a 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
@@ -421,3 +421,4 @@ int intel_engine_cs_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(intel_engine_cs_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_ring.c b/drivers/gpu/drm/i915/gt/selftest_ring.c
index 2a8c534dc125..6590c9c504b9 100644
--- a/drivers/gpu/drm/i915/gt/selftest_ring.c
+++ b/drivers/gpu/drm/i915/gt/selftest_ring.c
@@ -108,3 +108,4 @@ int intel_ring_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(intel_ring_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/gt/selftest_timeline.c b/drivers/gpu/drm/i915/gt/selftest_timeline.c
index 522d0190509c..fcf044c9feea 100644
--- a/drivers/gpu/drm/i915/gt/selftest_timeline.c
+++ b/drivers/gpu/drm/i915/gt/selftest_timeline.c
@@ -450,6 +450,7 @@ int intel_timeline_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(intel_timeline_mock_selftests, I915_SELFTEST);
 
 static int emit_ggtt_store_dw(struct i915_request *rq, u32 addr, u32 value)
 {
diff --git a/drivers/gpu/drm/i915/gt/st_shmem_utils.c b/drivers/gpu/drm/i915/gt/st_shmem_utils.c
index b279fe88b70e..46c9d4fca1f8 100644
--- a/drivers/gpu/drm/i915/gt/st_shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/st_shmem_utils.c
@@ -61,3 +61,4 @@ int shmem_utils_mock_selftests(void)
 
 	return i915_subtests(tests, NULL);
 }
+EXPORT_SYMBOL_NS_GPL(shmem_utils_mock_selftests, I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/i915_selftest.h b/drivers/gpu/drm/i915/i915_selftest.h
index f54de0499be7..3d95c4c98828 100644
--- a/drivers/gpu/drm/i915/i915_selftest.h
+++ b/drivers/gpu/drm/i915/i915_selftest.h
@@ -44,6 +44,7 @@ struct i915_selftest {
 
 extern struct i915_selftest i915_selftest;
 
+void i915_prepare_selftests(void);
 int i915_mock_selftests(void);
 int i915_live_selftests(struct pci_dev *pdev);
 int i915_perf_selftests(struct pci_dev *pdev);
@@ -111,6 +112,7 @@ int __i915_subtests(const char *caller,
 
 #else /* !IS_ENABLED(CONFIG_DRM_I915_SELFTEST) */
 
+static inline void i915_prepare_selftests(void) {};
 static inline int i915_mock_selftests(void) { return 0; }
 static inline int i915_live_selftests(struct pci_dev *pdev) { return 0; }
 static inline int i915_perf_selftests(struct pci_dev *pdev) { return 0; }
diff --git a/drivers/gpu/drm/i915/selftests/.kunitconfig b/drivers/gpu/drm/i915/selftests/.kunitconfig
new file mode 100644
index 000000000000..98600bbde6b3
--- /dev/null
+++ b/drivers/gpu/drm/i915/selftests/.kunitconfig
@@ -0,0 +1,12 @@
+# i915 dependencies
+CONFIG_KUNIT=y
+CONFIG_PCI=y
+CONFIG_DRM=y
+CONFIG_DRM_I915=y
+
+# Needed by selftest
+CONFIG_EXPERT=y
+# PREEMPT_RT is not set
+
+CONFIG_DRM_I915_SELFTEST=y
+CONFIG_DRM_I915_KUNIT_TESTS=y
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
index 8c6517d29b8e..5461ecc9b6a2 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
@@ -555,6 +555,7 @@ int i915_gem_evict_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_evict_mock_selftests, I915_SELFTEST);
 
 int i915_gem_evict_live_selftests(struct drm_i915_private *i915)
 {
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index 27c733b00976..5666dd927d0a 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -1938,6 +1938,7 @@ int i915_gem_gtt_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_gem_gtt_mock_selftests, I915_SELFTEST);
 
 static int context_sync(struct intel_context *ce)
 {
diff --git a/drivers/gpu/drm/i915/selftests/i915_kunit.c b/drivers/gpu/drm/i915/selftests/i915_kunit.c
new file mode 100644
index 000000000000..6b03947a2cfa
--- /dev/null
+++ b/drivers/gpu/drm/i915/selftests/i915_kunit.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Unit tests for i915
+ *
+ * Copyright © 2022 Intel Corporation
+ * Author: Mauro Carvalho Chehab <mchehab@kernel.org>
+ */
+
+#include <kunit/test.h>
+#include "i915_selftest.h"
+
+/* Declare selftest functions */
+#define selftest(x, __y) int __y(void);
+#include "i915_mock_selftests.h"
+#undef selftest
+
+/* Create selftest functions */
+#define selftest(__x, __y)				\
+	static void mock_##__x(struct kunit *test) {		\
+	    KUNIT_EXPECT_EQ(test, __y(), 0);		\
+	}
+#include "i915_mock_selftests.h"
+#undef selftest
+
+#define selftest(__x, __y) KUNIT_CASE(mock_##__x),
+
+static struct kunit_case i915_test_cases[] = {
+#include "i915_mock_selftests.h"
+	{}
+};
+
+static int i915_test_init_suite(struct kunit *test)
+{
+	i915_prepare_selftests();
+	return 0;
+}
+
+static struct kunit_suite i915_test_suites[] = {
+	{
+		.name = "i915 mock selftests",
+		.test_cases = i915_test_cases,
+		.init = i915_test_init_suite,
+	},
+};
+
+kunit_test_suites(i915_test_suites);
+
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(I915_SELFTEST);
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index a46350c37e9d..be2430615942 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -563,6 +563,7 @@ int i915_request_mock_selftests(void)
 
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_request_mock_selftests, I915_SELFTEST);
 
 static int live_nop_request(void *arg)
 {
diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index 39da0fb0d6d2..1b5c7bbe009e 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -39,6 +39,7 @@ int i915_mock_sanitycheck(void)
 	pr_info(DRIVER_NAME ": %s() - ok!\n", __func__);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(i915_mock_sanitycheck, I915_SELFTEST);
 
 int i915_live_sanitycheck(struct drm_i915_private *i915)
 {
@@ -127,13 +128,8 @@ static void set_default_test_all(struct selftest *st, unsigned int count)
 		st[i].enabled = true;
 }
 
-static int __run_selftests(const char *name,
-			   struct selftest *st,
-			   unsigned int count,
-			   void *data)
+void i915_prepare_selftests(void)
 {
-	int err = 0;
-
 	while (!i915_selftest.random_seed)
 		i915_selftest.random_seed = get_random_u32();
 
@@ -141,6 +137,17 @@ static int __run_selftests(const char *name,
 		i915_selftest.timeout_ms ?
 		msecs_to_jiffies_timeout(i915_selftest.timeout_ms) :
 		MAX_SCHEDULE_TIMEOUT;
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
+	i915_prepare_selftests();
 
 	set_default_test_all(st, count);
 
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
index 71b52d5efef4..ae25bd6c58cd 100644
--- a/drivers/gpu/drm/i915/selftests/i915_vma.c
+++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
@@ -949,6 +949,7 @@ int i915_vma_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(i915_vma_mock_selftests, I915_SELFTEST);
 
 static int igt_vma_remapped_gtt(void *arg)
 {
diff --git a/drivers/gpu/drm/i915/selftests/intel_memory_region.c b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
index 3b18e5905c86..91cfd5d5cad2 100644
--- a/drivers/gpu/drm/i915/selftests/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
@@ -1376,6 +1376,7 @@ int intel_memory_region_mock_selftests(void)
 	mock_destroy_device(i915);
 	return err;
 }
+EXPORT_SYMBOL_NS_GPL(intel_memory_region_mock_selftests, I915_SELFTEST);
 
 int intel_memory_region_live_selftests(struct drm_i915_private *i915)
 {
diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gpu/drm/i915/selftests/intel_uncore.c
index e4281508d580..2b61377d4b60 100644
--- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
+++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
@@ -138,6 +138,7 @@ int intel_uncore_mock_selftests(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(intel_uncore_mock_selftests, I915_SELFTEST);
 
 static int live_forcewake_ops(void *arg)
 {
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


