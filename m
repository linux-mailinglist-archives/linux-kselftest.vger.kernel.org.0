Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41779617A39
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 10:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKCJs4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 05:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCJsz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 05:48:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524D5D6A;
        Thu,  3 Nov 2022 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667468931; x=1699004931;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wfYnqtB895zrEWbIQw4F4VA/NXKUig98dz3TLA2YEBA=;
  b=GdZbcybCHRqYDUrUY2Eo77K8go81FpxpOIMBLJSWT3o/rYtATtZQlOcO
   umuezb/fJFxljbSMsWT8H5NTxv78ZnMwmN9A3I6ddMfDv4nsUwUtZy8ql
   AejsYCpk8iIQEz71qViqgZqUjHKfQvBfx131jJ+FODmbwxLmVO/r3ApXk
   q9an75n+y2u6N7t7qW7ZA5ZXf8ViIVH5UWq5TKOUTRulLQswu0kWsZXWn
   PoT5afFsV6rk9lwb6APJcBfReRiDWUEfh7N1jweD5E69DsYHcu4P6A30Q
   Gls+qgKVATkOamlqdwfxeB5nplN2Qwe19WYYRMq8fwFV4i3a/57y7eV90
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="395943598"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="395943598"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 02:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723881719"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723881719"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Nov 2022 02:48:50 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.30.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 155FA580BDB;
        Thu,  3 Nov 2022 02:48:42 -0700 (PDT)
Date:   Thu, 3 Nov 2022 10:48:40 +0100
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     igt-dev@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        daniel@ffwll.ch, kunit-dev@googlegroups.com,
        magalilemes00@gmail.com, maira.canal@usp.br, dlatypov@google.com,
        n@nfraprado.net, linux-kernel@vger.kernel.org,
        leandro.ribeiro@collabora.com, dri-devel@lists.freedesktop.org,
        davidgow@google.com, tales.aparecida@gmail.com,
        skhan@linuxfoundation.org, andrealmeid@riseup.net,
        brendanhiggins@google.com, twoerner@gmail.com
Subject: Re: [igt-dev] [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility
 for KUnit
Message-ID: <20221103104840.7301df76@maurocar-mobl2>
In-Reply-To: <20220829000920.38185-4-isabbasso@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net>
        <20220829000920.38185-4-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 28 Aug 2022 21:09:19 -0300
Isabella Basso <isabbasso@riseup.net> wrote:

> This adds functions for both executing the tests as well as parsing (K)TAP
> kmsg output, as per the KTAP spec [1].
> 
> [1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
> 
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>

Hi Isabella,

I'm doing some tests here with my i915 KUnit patch series.

There's a problem with the way it is currently parsing the KTAP logs on
IGT. It sounds that it is parsing the data only at the end, and not as
they arrive. That's bad, as if something goes wrong, the previously
reported data is still useful.

Also, when there's a crash, the IGT process is getting segmentation
fault. So, the end result is that nothing is actually reported.

	$ sudo ./build/tests/i915_selftest
	IGT-Version: 1.26-gbab20eb65 (x86_64) (Linux: 6.1.0-rc2-drm-990037e9984e+ x86_64)
	Segmentation fault (core dumped)

However, the logs are there (see enclosed). In this specific case, there
was a GPU hang while running one of the tests on a real hardware, which
is something that it is actually expected at development time.

FYI, those are the logs (when using the patches I'm still developing
to run selftests via KUnit - currently broken):

[  360.446771] [IGT] i915_selftest: executing
[  360.465611]     # Subtest: i915 mock selftests
[  360.465614]     1..18
[  360.466163] i915: i915_mock_sanitycheck() - ok!
[  360.466273]     ok 1 - mock_sanitycheck
[  360.466428] i915: Running shmem_utils_mock_selftests/igt_shmem_basic
[  360.466500]     ok 2 - mock_shmem
[  360.466592] i915: Running i915_sw_fence_mock_selftests/test_self
[  360.466633] i915: Running i915_sw_fence_mock_selftests/test_dag
[  360.466645] i915: Running i915_sw_fence_mock_selftests/test_AB
[  360.466692] i915: Running i915_sw_fence_mock_selftests/test_ABC
[  360.466729] i915: Running i915_sw_fence_mock_selftests/test_AB_C
[  360.466764] i915: Running i915_sw_fence_mock_selftests/test_C_AB
[  360.466800] i915: Running i915_sw_fence_mock_selftests/test_chain
[  360.502903] i915: Running i915_sw_fence_mock_selftests/test_ipc
[  360.505338] i915: Running i915_sw_fence_mock_selftests/test_timer
[  366.490222] i915: Running i915_sw_fence_mock_selftests/test_dma_fence
[  367.146210] Asynchronous wait on fence mock:mock:0 timed out (hint:fence_notify [i915])
[  367.147793]     ok 3 - mock_fence
[  367.148388] i915: Running scatterlist_mock_selftests/igt_sg_alloc
[  367.648994] sg_alloc_table timed out
[  367.649003] i915: Running scatterlist_mock_selftests/igt_sg_trim
[  368.149994] i915_sg_trim timed out
[  368.150095]     ok 4 - mock_scatterlist
[  368.150423] i915: Running i915_syncmap_mock_selftests/igt_syncmap_init
[  368.150446] i915: Running i915_syncmap_mock_selftests/igt_syncmap_one
[  368.651091] i915: Running i915_syncmap_mock_selftests/igt_syncmap_join_above
[  368.651240] i915: Running i915_syncmap_mock_selftests/igt_syncmap_join_below
[  368.652311] i915: Running i915_syncmap_mock_selftests/igt_syncmap_neighbours
[  369.965095] i915: Running i915_syncmap_mock_selftests/igt_syncmap_compact
[  369.965989] i915: Running i915_syncmap_mock_selftests/igt_syncmap_random
[  370.482663]     ok 5 - mock_syncmap
[  370.482853]     ok 6 - mock_uncore
[  370.483119] i915: Running intel_ring_mock_selftests/igt_ring_direction
[  370.483171]     ok 7 - mock_ring
[  370.483328] i915: Running intel_engine_cs_mock_selftests/intel_mmio_bases_check
[  370.483399]     ok 8 - mock_engine
[  370.483456] i915: Running intel_timeline_mock_selftests/mock_hwsp_freelist
[  370.484028]  mock: [drm] Using Transparent Hugepages
[  370.484164]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
[  370.484195]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
[  370.484224]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
[  372.258731] i915: Running intel_timeline_mock_selftests/igt_sync
[  372.262110] i915: Running intel_timeline_mock_selftests/bench_sync
[  372.463995] bench_sync: 43371 random insertions, 2323ns/insert
[  372.467075] bench_sync: 43371 random lookups, 65ns/lookup
[  372.702995] bench_sync: 836833 in-order insertions, 119ns/insert
[  372.705534] bench_sync: 836833 in-order lookups, 3ns/lookup
[  372.914994] bench_sync: 6214645 repeated insert/lookups, 11ns/op
[  373.015994] bench_sync: 19605180 cyclic/1 insert/lookups, 5ns/op
[  373.116994] bench_sync: 18945372 cyclic/2 insert/lookups, 5ns/op
[  373.217994] bench_sync: 16210409 cyclic/3 insert/lookups, 6ns/op
[  373.318995] bench_sync: 14141870 cyclic/5 insert/lookups, 7ns/op
[  373.419994] bench_sync: 12728929 cyclic/8 insert/lookups, 7ns/op
[  373.520995] bench_sync: 9070286 cyclic/13 insert/lookups, 11ns/op
[  373.639995] bench_sync: 52516 cyclic/21 insert/lookups, 1921ns/op
[  373.762920]     ok 9 - mock_timelines
[  373.763522]  mock: [drm] Using Transparent Hugepages
[  373.763575]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
[  373.763590]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
[  373.763604]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
[  373.763793] i915: Running i915_request_mock_selftests/igt_add_request
[  373.764100] i915: Running i915_request_mock_selftests/igt_wait_request
[  374.274884] i915: Running i915_request_mock_selftests/igt_fence_wait
[  374.786370] i915: Running i915_request_mock_selftests/igt_request_rewind
[  374.789600] i915: Running i915_request_mock_selftests/mock_breadcrumbs_smoketest
[  375.516775] Completed 82 waits for 52186 fence across 8 cpus
[  375.703841]     ok 10 - mock_requests
[  375.705131]  mock: [drm] Using Transparent Hugepages
[  375.705270]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
[  375.705320]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
[  375.705367]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
[  375.705875] i915: Running i915_gem_object_mock_selftests/igt_gem_object
[  375.747736]     ok 11 - mock_objects
[  375.749088]  mock: [drm] Using Transparent Hugepages
[  375.749239]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
[  375.749292]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
[  375.749343]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
[  375.749843] i915: Running i915_gem_phys_mock_selftests/mock_phys_object
[  375.794834]     ok 12 - mock_phys
[  375.796067]  mock: [drm] Using Transparent Hugepages
[  375.796208]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
[  375.796258]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
[  375.796304]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
[  375.796775] i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_export
[  375.797036] i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_import_self
[  375.797192] i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_import
[  375.797541] i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_import_ownership
[  375.801328] i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_export_vmap
[  375.803245]     ok 13 - mock_dmabuf
[  375.804878]  mock: [drm] Using Transparent Hugepages
[  375.805124]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
[  375.805236]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
[  375.805343]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
[  375.806192] i915: Running i915_vma_mock_selftests/igt_vma_create
[  376.308125] igt_vma_create timed out: after 31 objects in 83 contexts
[  376.311056] i915: Running i915_vma_mock_selftests/igt_vma_pin1
[  376.311803] i915: Running i915_vma_mock_selftests/igt_vma_rotate_remap
[  379.883757] i915: Running i915_vma_mock_selftests/igt_vma_partial
[  383.085953]     ok 14 - mock_vma
[  383.087159]  mock: [drm] Using Transparent Hugepages
[  383.087295]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
[  383.087345]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
[  383.087391]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
[  383.087885] i915: Running i915_gem_evict_mock_selftests/igt_evict_something
[  383.259301] i915: Running i915_gem_evict_mock_selftests/igt_evict_for_vma
[  383.429083] i915: Running i915_gem_evict_mock_selftests/igt_evict_for_cache_color
[  383.439038] i915: Running i915_gem_evict_mock_selftests/igt_evict_vm
[  383.617849] i915: Running i915_gem_evict_mock_selftests/igt_overcommit
[  383.814683]     ok 15 - mock_evict
[  383.815450]  mock: [drm] Using Transparent Hugepages
[  383.815535]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
[  383.815565]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
[  383.815593]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
[  383.815893] i915: Running i915_gem_gtt_mock_selftests/igt_mock_drunk
[  384.316018] drunk_hole timed out after 30852/524288
[  384.316205] i915: Running i915_gem_gtt_mock_selftests/igt_mock_walk
[  384.817415] walk_hole timed out at 7d19000
[  384.817433] i915: Running i915_gem_gtt_mock_selftests/igt_mock_pot
[  385.793876] pot_hole timed out after 19/33
[  385.793895] i915: Running i915_gem_gtt_mock_selftests/igt_mock_fill
[  386.294465] fill_hole timed out (npages=1, prime=191)
[  386.294518] i915: Running i915_gem_gtt_mock_selftests/igt_gtt_reserve
[  386.451741] i915: Running i915_gem_gtt_mock_selftests/igt_gtt_insert
[  386.778843]     ok 16 - mock_gtt
[  386.780179]  mock: [drm] Using Transparent Hugepages
[  386.780313]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
[  386.780362]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
[  386.780409]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
[  386.781221] i915: Running i915_gem_huge_page_mock_selftests/igt_mock_exhaust_device_supported_pages
[  386.792539] i915: Running i915_gem_huge_page_mock_selftests/igt_mock_memory_region_huge_pages
[  386.796808] i915: Running i915_gem_huge_page_mock_selftests/igt_mock_ppgtt_misaligned_dma
[  386.895508] i915: Running i915_gem_huge_page_mock_selftests/igt_mock_ppgtt_huge_fill
[  387.396087] igt_mock_ppgtt_huge_fill timed out at size 51187712
[  387.397014] i915: Running i915_gem_huge_page_mock_selftests/igt_mock_ppgtt_64K
[  387.912504]     ok 17 - mock_hugepages
[  387.913155]  mock: [drm] Using Transparent Hugepages
[  387.913236]  mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
[  387.913263]  mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
[  387.913288]  mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
[  387.913584] i915: Running intel_memory_region_mock_selftests/igt_mock_reserve
[  387.949404] i915: Running intel_memory_region_mock_selftests/igt_mock_fill
[  388.002432] i915: Running intel_memory_region_mock_selftests/igt_mock_contiguous
[  389.352514] i915: Running intel_memory_region_mock_selftests/igt_mock_splintered_region
[  389.383240] i915: Running intel_memory_region_mock_selftests/igt_mock_max_segment
[  389.413338] i915: Running intel_memory_region_mock_selftests/igt_mock_io_size
[  389.413361] igt_mock_io_size with ps=10000, io_size=ae010000, total=fb760000
[  389.417103] igt_mock_io_size mappable theft=(0MiB/2784MiB), total=4023MiB
[  389.477896]     ok 18 - mock_memory_region
[  389.477907] # i915 mock selftests: pass:18 fail:0 skip:0 total:18
[  389.477943] # Totals: pass:18 fail:0 skip:0 total:18
[  389.477983] ok 1 - i915 mock selftests
[  389.478139] 0000:00:02.0: it is a i915 device.
[  389.478222]     # Subtest: i915 perf selftests
[  389.478226]     1..4
[  389.478550] i915: Running intel_engine_cs_perf_selftests/perf_mi_bb_start
[  389.482084] rcs0: MI_BB_START cycles: 1073741589
[  389.487351] bcs0: MI_BB_START cycles: 1073741587
[  389.488363] vcs0: MI_BB_START cycles: 1073741586
[  389.489321] vcs1: MI_BB_START cycles: 1073741586
[  389.490187] vecs0: MI_BB_START cycles: 30
[  389.503281] i915: Running intel_engine_cs_perf_selftests/perf_mi_noop
[  389.505789] rcs0: 16K MI_NOOP cycles: 856
[  389.506974] bcs0: 16K MI_NOOP cycles: 780
[  389.508335] vcs0: 16K MI_NOOP cycles: 783
[  389.509412] vcs1: 16K MI_NOOP cycles: 781
[  389.510599] vecs0: 16K MI_NOOP cycles: 782
[  389.527204]     ok 1 - perf_engine_cs
[  389.527350] i915: Running i915_request_perf_selftests/perf_request_latency
[  389.528341] rcs0: semaphore response 22 cycles, 1185ns
[  389.529044] rcs0: idle dispatch latency 719 cycles, 37474ns
[  389.529730] rcs0: busy dispatch latency 298 cycles, 15547ns
[  389.530396] rcs0: inter-request latency 276 cycles, 14401ns
[  389.531663] rcs0: context switch latency 806 cycles, 41992ns
[  389.532680] rcs0: preemption dispatch latency 1212 cycles, 63164ns
[  389.532707] rcs0: preemption switch latency 710 cycles, 36992ns
[  389.533422] rcs0: completion latency 871 cycles, 45365ns
[  389.534044] bcs0: semaphore response 16 cycles, 873ns
[  389.534834] bcs0: idle dispatch latency 433 cycles, 22578ns
[  389.535311] bcs0: busy dispatch latency 314 cycles, 16380ns
[  389.535678] bcs0: inter-request latency 44 cycles, 2292ns
[  389.536285] bcs0: context switch latency 199 cycles, 10391ns
[  389.536901] bcs0: preemption dispatch latency 730 cycles, 38060ns
[  389.536918] bcs0: preemption switch latency 761 cycles, 39662ns
[  389.537534] bcs0: completion latency 948 cycles, 49401ns
[  389.538087] vcs0: semaphore response 18 cycles, 977ns
[  389.538868] vcs0: idle dispatch latency 472 cycles, 24584ns
[  389.539400] vcs0: busy dispatch latency 331 cycles, 17279ns
[  389.539783] vcs0: inter-request latency 50 cycles, 2643ns
[  389.540422] vcs0: context switch latency 183 cycles, 9531ns
[  389.541071] vcs0: preemption dispatch latency 691 cycles, 36003ns
[  389.541089] vcs0: preemption switch latency 688 cycles, 35860ns
[  389.541615] vcs0: completion latency 655 cycles, 34128ns
[  389.542162] vcs1: semaphore response 17 cycles, 899ns
[  389.542811] vcs1: idle dispatch latency 424 cycles, 22097ns
[  389.543125] vcs1: busy dispatch latency 207 cycles, 10808ns
[  389.543449] vcs1: inter-request latency 52 cycles, 2709ns
[  389.543988] vcs1: context switch latency 190 cycles, 9909ns
[  389.544652] vcs1: preemption dispatch latency 701 cycles, 36511ns
[  389.544669] vcs1: preemption switch latency 492 cycles, 25625ns
[  389.545148] vcs1: completion latency 461 cycles, 24037ns
[  389.545692] vecs0: semaphore response 19 cycles, 990ns
[  389.546244] vecs0: idle dispatch latency 443 cycles, 23112ns
[  389.546691] vecs0: busy dispatch latency 261 cycles, 13633ns
[  389.547013] vecs0: inter-request latency 49 cycles, 2591ns
[  389.547594] vecs0: context switch latency 184 cycles, 9610ns
[  389.548187] vecs0: preemption dispatch latency 779 cycles, 40612ns
[  389.548205] vecs0: preemption switch latency 451 cycles, 23503ns
[  389.548688] vecs0: completion latency 484 cycles, 25248ns
[  389.549042] i915: Running i915_request_perf_selftests/perf_series_engines
[  390.051955] s_sync0 [i915]  rcs0: { seqno:1244, busy:42.80%, runtime:94ms, walltime:500ms }
[  390.052112] s_sync0 [i915]  bcs0: { seqno:1242, busy:9.30%, runtime:5ms, walltime:501ms }
[  390.052281] s_sync0 [i915]  vcs0: { seqno:1242, busy:15.19%, runtime:0ms, walltime:501ms }
[  390.052449] s_sync0 [i915]  vcs1: { seqno:1242, busy:12.92%, runtime:0ms, walltime:501ms }
[  390.052578] s_sync0 [i915] vecs0: { seqno:1242, busy:13.50%, runtime:0ms, walltime:502ms }
[  390.553986] s_sync1 [i915]  rcs0: { seqno:3072, busy:65.88%, runtime:142ms, walltime:500ms }
[  390.554133] s_sync1 [i915]  bcs0: { seqno:3068, busy:13.78%, runtime:0ms, walltime:501ms }
[  390.554301] s_sync1 [i915]  vcs0: { seqno:3068, busy:20.48%, runtime:18ms, walltime:501ms }
[  390.554489] s_sync1 [i915]  vcs1: { seqno:3068, busy:28.32%, runtime:21ms, walltime:501ms }
[  390.554622] s_sync1 [i915] vecs0: { seqno:3068, busy:16.87%, runtime:19ms, walltime:501ms }
[  391.055401] s_many [i915]  rcs0: { seqno:11728, busy:75.43%, runtime:148ms, walltime:500ms }
[  391.055525] s_many [i915]  bcs0: { seqno:11724, busy:67.28%, runtime:24ms, walltime:500ms }
[  391.055654] s_many [i915]  vcs0: { seqno:11724, busy:72.88%, runtime:21ms, walltime:500ms }
[  391.055782] s_many [i915]  vcs1: { seqno:11724, busy:74.87%, runtime:18ms, walltime:500ms }
[  391.055880] s_many [i915] vecs0: { seqno:11724, busy:73.76%, runtime:17ms, walltime:500ms }
[  391.055938] i915: Running i915_request_perf_selftests/perf_parallel_engines
[  391.559973] p_sync0 [i915]  rcs0: { count:4423, busy:92.58%, runtime:129ms, walltime:500ms }
[  391.560023] p_sync0 [i915]  bcs0: { count:5712, busy:88.20%, runtime:18ms, walltime:500ms }
[  391.560050] p_sync0 [i915]  vcs0: { count:5825, busy:90.94%, runtime:25ms, walltime:500ms }
[  391.560076] p_sync0 [i915]  vcs1: { count:5875, busy:91.26%, runtime:24ms, walltime:500ms }
[  391.560103] p_sync0 [i915] vecs0: { count:5929, busy:90.34%, runtime:23ms, walltime:500ms }
[  392.063758] p_sync1 [i915]  rcs0: { count:5727, busy:95.73%, runtime:171ms, walltime:500ms }
[  392.063794] p_sync1 [i915]  bcs0: { count:10548, busy:86.66%, runtime:30ms, walltime:500ms }
[  392.063823] p_sync1 [i915]  vcs0: { count:9614, busy:88.67%, runtime:35ms, walltime:500ms }
[  392.063851] p_sync1 [i915]  vcs1: { count:8445, busy:90.05%, runtime:30ms, walltime:500ms }
[  392.063879] p_sync1 [i915] vecs0: { count:9894, busy:88.79%, runtime:33ms, walltime:500ms }
[  392.567890] p_many [i915]  rcs0: { count:16814, busy:99.99%, runtime:303ms, walltime:500ms }
[  392.567923] p_many [i915]  bcs0: { count:20754, busy:99.98%, runtime:49ms, walltime:500ms }
[  392.567949] p_many [i915]  vcs0: { count:15965, busy:99.39%, runtime:48ms, walltime:500ms }
[  392.567976] p_many [i915]  vcs1: { count:20270, busy:99.36%, runtime:61ms, walltime:500ms }
[  392.568017] p_many [i915] vecs0: { count:16736, busy:99.99%, runtime:48ms, walltime:500ms }
[  392.568082]     ok 2 - perf_request
[  392.568155] i915: Running intel_migrate_perf_selftests/perf_clear_blt
[  392.569089] bcs0: 4 KiB fill: 40 MiB/s
[  392.570259] bcs0: 64 KiB fill: 419 MiB/s
[  392.573495] bcs0: 2048 KiB fill: 3143 MiB/s
[  392.656686] bcs0: 65536 KiB fill: 3856 MiB/s
[  392.674288] i915: Running intel_migrate_perf_selftests/perf_copy_blt
[  392.677148] bcs0: 4 KiB copy: 18 MiB/s
[  392.678227] bcs0: 64 KiB copy: 394 MiB/s
[  392.680686] bcs0: 2048 KiB copy: 4774 MiB/s
[  392.709356] bcs0: 65536 KiB copy: 11604 MiB/s
[  392.738410]     ok 3 - perf_migrate
[  392.738853] i915: Running intel_memory_region_perf_selftests/perf_memcpy
[  392.739161] _perf_memcpy src(system, WB) -> dst(system, WB)         memcpy    4 KiB copy:  8159 MiB/s
[  392.739223] _perf_memcpy src(system, WB) -> dst(system, WB)    memcpy_long    4 KiB copy:  3547 MiB/s
[  392.739279] _perf_memcpy src(system, WB) -> dst(system, WB) memcpy_from_wc    4 KiB copy:  5086 MiB/s
[  392.749402] _perf_memcpy src(system, WB) -> dst(system, WC)         memcpy    4 KiB copy:  5101 MiB/s
[  392.749482] _perf_memcpy src(system, WB) -> dst(system, WC)    memcpy_long    4 KiB copy:  1317 MiB/s
[  392.749540] _perf_memcpy src(system, WB) -> dst(system, WC) memcpy_from_wc    4 KiB copy:  5056 MiB/s
[  392.757570] _perf_memcpy src(system, WC) -> dst(system, WB)         memcpy    4 KiB copy:   375 MiB/s
[  392.758079] _perf_memcpy src(system, WC) -> dst(system, WB)    memcpy_long    4 KiB copy:    49 MiB/s
[  392.758146] _perf_memcpy src(system, WC) -> dst(system, WB) memcpy_from_wc    4 KiB copy:  2390 MiB/s
[  392.769568] _perf_memcpy src(system, WC) -> dst(system, WC)         memcpy    4 KiB copy:   207 MiB/s
[  392.770434] _perf_memcpy src(system, WC) -> dst(system, WC)    memcpy_long    4 KiB copy:    26 MiB/s
[  392.770507] _perf_memcpy src(system, WC) -> dst(system, WC) memcpy_from_wc    4 KiB copy:  2203 MiB/s
[  392.779083] _perf_memcpy src(system, WB) -> dst(system, WB)         memcpy   64 KiB copy: 14154 MiB/s
[  392.779308] _perf_memcpy src(system, WB) -> dst(system, WB)    memcpy_long   64 KiB copy:  2052 MiB/s
[  392.779442] _perf_memcpy src(system, WB) -> dst(system, WB) memcpy_from_wc   64 KiB copy:  4238 MiB/s
[  392.787666] _perf_memcpy src(system, WB) -> dst(system, WC)         memcpy   64 KiB copy:  8516 MiB/s
[  392.788092] _perf_memcpy src(system, WB) -> dst(system, WC)    memcpy_long   64 KiB copy:  1064 MiB/s
[  392.788196] _perf_memcpy src(system, WB) -> dst(system, WC) memcpy_from_wc   64 KiB copy:  7800 MiB/s
[  392.797953] _perf_memcpy src(system, WC) -> dst(system, WB)         memcpy   64 KiB copy:   233 MiB/s
[  392.805504] _perf_memcpy src(system, WC) -> dst(system, WB)    memcpy_long   64 KiB copy:    44 MiB/s
[  392.805649] _perf_memcpy src(system, WC) -> dst(system, WB) memcpy_from_wc   64 KiB copy:  3604 MiB/s
[  392.813866] _perf_memcpy src(system, WC) -> dst(system, WC)         memcpy   64 KiB copy:   236 MiB/s
[  392.825378] _perf_memcpy src(system, WC) -> dst(system, WC)    memcpy_long   64 KiB copy:    29 MiB/s
[  392.825484] _perf_memcpy src(system, WC) -> dst(system, WC) memcpy_from_wc   64 KiB copy:  4544 MiB/s
[  392.835450] _perf_memcpy src(system, WB) -> dst(system, WB)         memcpy 4096 KiB copy: 14838 MiB/s
[  392.839633] _perf_memcpy src(system, WB) -> dst(system, WB)    memcpy_long 4096 KiB copy:  4779 MiB/s
[  392.841384] _perf_memcpy src(system, WB) -> dst(system, WB) memcpy_from_wc 4096 KiB copy: 11442 MiB/s
[  392.853446] _perf_memcpy src(system, WB) -> dst(system, WC)         memcpy 4096 KiB copy: 23125 MiB/s
[  392.858952] _perf_memcpy src(system, WB) -> dst(system, WC)    memcpy_long 4096 KiB copy:  3847 MiB/s
[  392.859638] _perf_memcpy src(system, WB) -> dst(system, WC) memcpy_from_wc 4096 KiB copy: 31140 MiB/s
[  392.904274] _perf_memcpy src(system, WC) -> dst(system, WB)         memcpy 4096 KiB copy:   488 MiB/s
[  393.154071] _perf_memcpy src(system, WC) -> dst(system, WB)    memcpy_long 4096 KiB copy:    80 MiB/s
[  393.157632] _perf_memcpy src(system, WC) -> dst(system, WB) memcpy_from_wc 4096 KiB copy:  5844 MiB/s
[  393.217217] _perf_memcpy src(system, WC) -> dst(system, WC)         memcpy 4096 KiB copy:   390 MiB/s
[  393.632277] _perf_memcpy src(system, WC) -> dst(system, WC)    memcpy_long 4096 KiB copy:    48 MiB/s
[  393.636491] _perf_memcpy src(system, WC) -> dst(system, WC) memcpy_from_wc 4096 KiB copy:  4770 MiB/s
[  393.815263]     ok 4 - perf_region
[  393.815273] # i915 perf selftests: pass:4 fail:0 skip:0 total:4
[  393.815302] # Totals: pass:4 fail:0 skip:0 total:4
[  393.815336] ok 2 - i915 perf selftests
[  393.815391] 0000:00:02.0: it is a i915 device.
[  393.815462]     # Subtest: i915 live selftests
[  393.815465]     1..36
[  393.815954] i915: i915_live_sanitycheck() - ok!
[  393.816064]     ok 1 - live_sanitycheck
[  393.816362] i915: Running intel_uncore_live_selftests/live_fw_table
[  393.816437] i915: Running intel_uncore_live_selftests/live_forcewake_ops
[  393.816481] i915: Running intel_uncore_live_selftests/live_forcewake_domains
[  393.816539]     ok 2 - live_uncore
[  393.816858] i915: Running intel_workarounds_live_selftests/live_dirty_whitelist
[  393.841295] i915: Running intel_workarounds_live_selftests/live_reset_whitelist
[  393.841352] Checking 3 whitelisted registers on rcs0 (RING_NONPRIV) [engine]
[  393.845858] i915 0000:00:02.0: [drm] Resetting rcs0 for live_workarounds
[  393.847548] Checking 3 whitelisted registers on rcs0 (RING_NONPRIV) [device]
[  393.850443] i915 0000:00:02.0: [drm] Resetting chip for live_workarounds
[  393.853525] Checking 1 whitelisted registers on bcs0 (RING_NONPRIV) [engine]
[  393.855767] i915 0000:00:02.0: [drm] Resetting bcs0 for live_workarounds
[  393.856868] Checking 1 whitelisted registers on bcs0 (RING_NONPRIV) [device]
[  393.858487] i915 0000:00:02.0: [drm] Resetting chip for live_workarounds
[  393.859723] Checking 1 whitelisted registers on vcs0 (RING_NONPRIV) [engine]
[  393.861129] i915 0000:00:02.0: [drm] Resetting vcs0 for live_workarounds
[  393.861651] Checking 1 whitelisted registers on vcs0 (RING_NONPRIV) [device]
[  393.862615] i915 0000:00:02.0: [drm] Resetting chip for live_workarounds
[  393.863976] Checking 1 whitelisted registers on vcs1 (RING_NONPRIV) [engine]
[  393.864833] i915 0000:00:02.0: [drm] Resetting vcs1 for live_workarounds
[  393.865291] Checking 1 whitelisted registers on vcs1 (RING_NONPRIV) [device]
[  393.866205] i915 0000:00:02.0: [drm] Resetting chip for live_workarounds
[  393.867434] Checking 1 whitelisted registers on vecs0 (RING_NONPRIV) [engine]
[  393.868320] i915 0000:00:02.0: [drm] Resetting vecs0 for live_workarounds
[  393.868854] Checking 1 whitelisted registers on vecs0 (RING_NONPRIV) [device]
[  393.869720] i915 0000:00:02.0: [drm] Resetting chip for live_workarounds
[  393.889458] i915: Running intel_workarounds_live_selftests/live_isolated_whitelist
[  393.912185] i915: Running intel_workarounds_live_selftests/live_gpu_reset_workarounds
[  393.912262] Verifying after GPU reset...
[  393.917792] i915 0000:00:02.0: [drm] Resetting chip for live_workarounds
[  393.944251] i915: Running intel_workarounds_live_selftests/live_engine_reset_workarounds
[  393.944505] Verifying after rcs0 reset...
[  393.950041] i915 0000:00:02.0: [drm] Resetting rcs0 for live_workarounds:idle
[  393.957254] i915 0000:00:02.0: [drm] Resetting rcs0 for live_workarounds:active
[  393.961244] Verifying after bcs0 reset...
[  393.967352] i915 0000:00:02.0: [drm] Resetting bcs0 for live_workarounds:active
[  393.969645] Verifying after vcs0 reset...
[  393.971661] i915 0000:00:02.0: [drm] Resetting vcs0 for live_workarounds:idle
[  393.974734] i915 0000:00:02.0: [drm] Resetting vcs0 for live_workarounds:active
[  393.976954] Verifying after vcs1 reset...
[  393.979056] i915 0000:00:02.0: [drm] Resetting vcs1 for live_workarounds:idle
[  393.981775] i915 0000:00:02.0: [drm] Resetting vcs1 for live_workarounds:active
[  393.983983] Verifying after vecs0 reset...
[  393.986115] i915 0000:00:02.0: [drm] Resetting vecs0 for live_workarounds:idle
[  393.989148] i915 0000:00:02.0: [drm] Resetting vecs0 for live_workarounds:active
[  394.025622]     ok 3 - live_workarounds
[  394.025961] i915: Running live_engine_pm_selftests/live_engine_timestamps
[  394.030557] rcs0 elapsed:100263ns, CTX_TIMESTAMP:105730ns, RING_TIMESTAMP:105730ns
[  394.032965] bcs0 elapsed:100761ns, CTX_TIMESTAMP:104428ns, RING_TIMESTAMP:104428ns
[  394.034534] vcs0 elapsed:100558ns, CTX_TIMESTAMP:104688ns, RING_TIMESTAMP:104688ns
[  394.036012] vcs1 elapsed:100622ns, CTX_TIMESTAMP:104740ns, RING_TIMESTAMP:104740ns
[  394.037484] vecs0 elapsed:100303ns, CTX_TIMESTAMP:104688ns, RING_TIMESTAMP:104688ns
[  394.052331] i915: Running live_engine_pm_selftests/live_engine_busy_stats
[  394.113232] i915: Running live_engine_pm_selftests/live_engine_pm
[  394.116052]     ok 4 - live_gt_engines
[  394.116477] i915: Running intel_timeline_live_selftests/live_hwsp_recycle
[  396.644419] i915: Running intel_timeline_live_selftests/live_hwsp_engine
[  398.097352] i915: Running intel_timeline_live_selftests/live_hwsp_alternate
[  400.477486] i915: Running intel_timeline_live_selftests/live_hwsp_wrap

[  400.477647] ======================================================
[  400.477650] WARNING: possible circular locking dependency detected
[  400.477652] 6.1.0-rc2-drm-990037e9984e+ #11 Tainted: G                 N
[  400.477655] ------------------------------------------------------
[  400.477657] kunit_try_catch/2002 is trying to acquire lock:
[  400.477659] ffff888118627078 (&timeline->mutex/1){+.+.}-{3:3}, at: live_hwsp_wrap+0x291/0x690 [i915]
[  400.477833] 
               but task is already holding lock:
[  400.477835] ffff888116cd9078 (kernel_context){+.+.}-{3:3}, at: i915_request_create+0x168/0x230 [i915]
[  400.477983] 
               which lock already depends on the new lock.

[  400.477986] 
               the existing dependency chain (in reverse order) is:
[  400.477988] 
               -> #2 (kernel_context){+.+.}-{3:3}:
[  400.477992]        __mutex_lock+0xca/0x8c0
[  400.477997]        i915_request_create+0x168/0x230 [i915]
[  400.478155]        engine_wa_list_verify+0x368/0xa20 [i915]
[  400.478304]        intel_engine_verify_workarounds+0x23/0x30 [i915]
[  400.478443]        intel_gt_init+0x592/0x700 [i915]
[  400.478576]        i915_gem_init+0x1e9/0x330 [i915]
[  400.478727]        i915_driver_probe+0xee9/0x1770 [i915]
[  400.478856]        i915_pci_probe+0x89/0x3b0 [i915]
[  400.478985]        pci_device_probe+0x97/0x110
[  400.478989]        really_probe+0xdb/0x380
[  400.478993]        __driver_probe_device+0x78/0x170
[  400.478996]        driver_probe_device+0x1f/0x90
[  400.478998]        __driver_attach+0xd5/0x1d0
[  400.479001]        bus_for_each_dev+0x87/0xd0
[  400.479003]        bus_add_driver+0x1b1/0x200
[  400.479006]        driver_register+0x89/0xe0
[  400.479009]        i915_pci_register_driver+0x27/0x40 [i915]
[  400.479138]        mei_cancel_work+0x26/0x30 [mei]
[  400.479145]        do_one_initcall+0x6b/0x310
[  400.479149]        do_init_module+0x76/0x210
[  400.479153]        __do_sys_finit_module+0xac/0x120
[  400.479156]        do_syscall_64+0x37/0x90
[  400.479159]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  400.479163] 
               -> #1 (reservation_ww_class_mutex){+.+.}-{3:3}:
[  400.479167]        __ww_mutex_lock.constprop.0+0xf1/0x1060
[  400.479170]        ww_mutex_lock+0x38/0xa0
[  400.479173]        check_whitelist+0x188/0x5c3 [i915]
[  400.479348]        check_whitelist_across_reset+0xba/0x3bc [i915]
[  400.479524]        live_reset_whitelist.cold+0x7c/0xd1 [i915]
[  400.479694]        __i915_subtests.cold+0x53/0xd5 [i915]
[  400.479877]        intel_workarounds_live_selftests+0x65/0x80 [i915]
[  400.480028]        run_pci_test+0x68/0x150 [test_i915]
[  400.480034]        live_workarounds+0x19/0x30 [test_i915]
[  400.480039]        kunit_try_run_case+0x4e/0x80
[  400.480043]        kunit_generic_run_threadfn_adapter+0x13/0x30
[  400.480046]        kthread+0xf2/0x120
[  400.480049]        ret_from_fork+0x1f/0x30
[  400.480052] 
               -> #0 (&timeline->mutex/1){+.+.}-{3:3}:
[  400.480056]        __lock_acquire+0x16b7/0x28e0
[  400.480060]        lock_acquire+0xd1/0x2f0
[  400.480062]        __mutex_lock+0xca/0x8c0
[  400.480065]        live_hwsp_wrap+0x291/0x690 [i915]
[  400.480212]        __i915_subtests.cold+0x53/0xd5 [i915]
[  400.480396]        intel_timeline_live_selftests+0xbb/0xd0 [i915]
[  400.480545]        run_pci_test+0x68/0x150 [test_i915]
[  400.480550]        live_gt_timelines+0x19/0x30 [test_i915]
[  400.480555]        kunit_try_run_case+0x4e/0x80
[  400.480558]        kunit_generic_run_threadfn_adapter+0x13/0x30
[  400.480561]        kthread+0xf2/0x120
[  400.480564]        ret_from_fork+0x1f/0x30
[  400.480566] 
               other info that might help us debug this:

[  400.480569] Chain exists of:
                 &timeline->mutex/1 --> reservation_ww_class_mutex --> kernel_context

[  400.480576]  Possible unsafe locking scenario:

[  400.480578]        CPU0                    CPU1
[  400.480580]        ----                    ----
[  400.480582]   lock(kernel_context);
[  400.480584]                                lock(reservation_ww_class_mutex);
[  400.480587]                                lock(kernel_context);
[  400.480590]   lock(&timeline->mutex/1);
[  400.480593] 
                *** DEADLOCK ***

[  400.480595] 1 lock held by kunit_try_catch/2002:
[  400.480597]  #0: ffff888116cd9078 (kernel_context){+.+.}-{3:3}, at: i915_request_create+0x168/0x230 [i915]
[  400.480759] 
               stack backtrace:
[  400.480762] CPU: 0 PID: 2002 Comm: kunit_try_catch Tainted: G                 N 6.1.0-rc2-drm-990037e9984e+ #11
[  400.480766] Hardware name: Intel Corporation Tiger Lake Client Platform/TigerLake U DDR4 SODIMM RVP, BIOS TGLSFWI1.R00.4073.A01.2102110036 02/11/2021
[  400.480771] Call Trace:
[  400.480773]  <TASK>
[  400.480775]  dump_stack_lvl+0x6a/0x9f
[  400.480779]  check_noncircular+0x14c/0x170
[  400.480783]  __lock_acquire+0x16b7/0x28e0
[  400.480787]  lock_acquire+0xd1/0x2f0
[  400.480789]  ? live_hwsp_wrap+0x291/0x690 [i915]
[  400.480938]  __mutex_lock+0xca/0x8c0
[  400.480941]  ? live_hwsp_wrap+0x291/0x690 [i915]
[  400.481086]  ? live_hwsp_wrap+0x291/0x690 [i915]
[  400.481230]  ? live_hwsp_wrap+0x291/0x690 [i915]
[  400.481374]  live_hwsp_wrap+0x291/0x690 [i915]
[  400.481517]  ? kunit_try_catch_throw+0x20/0x20
[  400.481520]  __i915_subtests.cold+0x53/0xd5 [i915]
[  400.481713]  ? __i915_live_teardown+0x50/0x50 [i915]
[  400.481898]  ? __intel_gt_live_setup+0x60/0x60 [i915]
[  400.482095]  ? __intel_timeline_free+0x60/0x60 [i915]
[  400.482274]  ? kunit_try_catch_throw+0x20/0x20
[  400.482277]  intel_timeline_live_selftests+0xbb/0xd0 [i915]
[  400.482452]  run_pci_test+0x68/0x150 [test_i915]
[  400.482460]  live_gt_timelines+0x19/0x30 [test_i915]
[  400.482466]  kunit_try_run_case+0x4e/0x80
[  400.482470]  kunit_generic_run_threadfn_adapter+0x13/0x30
[  400.482474]  kthread+0xf2/0x120
[  400.482477]  ? kthread_complete_and_exit+0x20/0x20
[  400.482482]  ret_from_fork+0x1f/0x30
[  400.482487]  </TASK>
[  400.483565] i915: Running intel_timeline_live_selftests/live_hwsp_read
[  400.759423] rcs0: simulated 255 wraps
[  400.860561] bcs0: simulated 255 wraps
[  400.977662] vcs0: simulated 255 wraps
[  401.094340] vcs1: simulated 255 wraps
[  401.211137] vecs0: simulated 255 wraps
[  401.247212] i915: Running intel_timeline_live_selftests/live_hwsp_rollover_kernel
[  401.249829] i915: Running intel_timeline_live_selftests/live_hwsp_rollover_user
[  401.271366]     ok 5 - live_gt_timelines
[  401.271738] i915: Running intel_context_live_selftests/live_context_size
[  401.293251] i915: Running intel_context_live_selftests/live_active_context
[  401.318254] i915: Running intel_context_live_selftests/live_remote_context
[  401.344408]     ok 6 - live_gt_contexts
[  401.344798] i915: Running intel_lrc_live_selftests/live_lrc_layout
[  401.345024] i915: Running intel_lrc_live_selftests/live_lrc_fixed
[  401.345164] i915: Running intel_lrc_live_selftests/live_lrc_state
[  401.362216] i915: Running intel_lrc_live_selftests/live_lrc_gpr
[  401.392157] i915: Running intel_lrc_live_selftests/live_lrc_isolation
[  401.495275] i915: Running intel_lrc_live_selftests/live_lrc_timestamp
[  401.522173] i915: Running intel_lrc_live_selftests/live_lrc_garbage
[  401.522194] i915: Running intel_lrc_live_selftests/live_pphwsp_runtime
[  402.028730] rcs0: pphwsp runtime 479364012ns, average 58622293ns
[  402.534520] bcs0: pphwsp runtime 195714584ns, average 76214ns
[  403.037024] vcs0: pphwsp runtime 267333484ns, average 31694ns
[  403.542426] vcs1: pphwsp runtime 248148756ns, average 46269ns
[  404.048096] vecs0: pphwsp runtime 236339296ns, average 222600ns
[  404.062233] i915: Running intel_lrc_live_selftests/live_lrc_indirect_ctx_bb
[  404.084401]     ok 7 - live_gt_lrc
[  404.084710] i915: Running intel_mocs_live_selftests/live_mocs_kernel
[  404.099257] i915: Running intel_mocs_live_selftests/live_mocs_clean
[  404.123277] i915: Running intel_mocs_live_selftests/live_mocs_reset
[  404.123631] i915 0000:00:02.0: [drm] Resetting rcs0 for mocs
[  404.125376] i915 0000:00:02.0: [drm] Resetting rcs0 for mocs
[  404.125882] i915 0000:00:02.0: [drm] Resetting chip for mocs
[  404.126659] i915 0000:00:02.0: [drm] Resetting bcs0 for mocs
[  404.127767] i915 0000:00:02.0: [drm] Resetting bcs0 for mocs
[  404.127963] i915 0000:00:02.0: [drm] Resetting chip for mocs
[  404.128735] i915 0000:00:02.0: [drm] Resetting vcs0 for mocs
[  404.129807] i915 0000:00:02.0: [drm] Resetting vcs0 for mocs
[  404.130028] i915 0000:00:02.0: [drm] Resetting chip for mocs
[  404.130901] i915 0000:00:02.0: [drm] Resetting vcs1 for mocs
[  404.132171] i915 0000:00:02.0: [drm] Resetting vcs1 for mocs
[  404.132655] i915 0000:00:02.0: [drm] Resetting chip for mocs
[  404.133745] i915 0000:00:02.0: [drm] Resetting vecs0 for mocs
[  404.135328] i915 0000:00:02.0: [drm] Resetting vecs0 for mocs
[  404.135918] i915 0000:00:02.0: [drm] Resetting chip for mocs
[  404.158371]     ok 8 - live_gt_mocs
[  404.158708] i915: Running intel_gt_pm_live_selftests/live_gt_clocks
[  404.164024] rcs0: TIMESTAMP 19249 cycles [1002553ns] in 1000425ns [19209 cycles], using CS clock frequency of 19200KHz
[  404.169068] bcs0: TIMESTAMP 19229 cycles [1001511ns] in 1000129ns [19203 cycles], using CS clock frequency of 19200KHz
[  404.174104] vcs0: TIMESTAMP 19237 cycles [1001928ns] in 1000328ns [19207 cycles], using CS clock frequency of 19200KHz
[  404.179134] vcs1: TIMESTAMP 19234 cycles [1001771ns] in 1000100ns [19202 cycles], using CS clock frequency of 19200KHz
[  404.184163] vecs0: TIMESTAMP 19234 cycles [1001771ns] in 1000126ns [19203 cycles], using CS clock frequency of 19200KHz
[  404.184200] i915: Running intel_gt_pm_live_selftests/live_rc6_manual
[  404.546138] GPU consumed 816180uW in RC0 and 203609uW in RC6
[  404.546166] i915: Running intel_gt_pm_live_selftests/live_rps_clock_interval
[  404.558110] rcs0: rps evaluation interval not ticking
[  404.568099] i915: Running intel_gt_pm_live_selftests/live_rps_control
[  405.296237] rcs0: range:[6:100MHz, 51:1350MHz] limit:[18:400MHz], 6:18 response 48876ns:49302ns
[  406.023247] bcs0: range:[6:100MHz, 51:1350MHz] limit:[18:400MHz], 6:18 response 49111ns:49176ns
[  406.750255] vcs0: range:[6:100MHz, 51:1350MHz] limit:[18:400MHz], 6:18 response 49391ns:49674ns
[  407.477246] vcs1: range:[6:100MHz, 51:1350MHz] limit:[18:400MHz], 6:18 response 48930ns:49404ns
[  408.200265] vecs0: range:[6:100MHz, 51:1350MHz] limit:[18:400MHz], 6:18 response 49045ns:50394ns
[  408.207146] i915: Running intel_gt_pm_live_selftests/live_rps_frequency_cs
[  408.299000] rcs0: min:10858KHz @ 100MHz, max:41423KHz @ 400MHz [95%]
[  408.391000] bcs0: min:10864KHz @ 100MHz, max:42440KHz @ 400MHz [98%]
[  408.483000] vcs0: min:10792KHz @ 100MHz, max:41926KHz @ 400MHz [97%]
[  408.575000] vcs1: min:10810KHz @ 100MHz, max:42150KHz @ 400MHz [97%]
[  408.667000] vecs0: min:10842KHz @ 100MHz, max:42055KHz @ 400MHz [97%]
[  408.673253] i915: Running intel_gt_pm_live_selftests/live_rps_frequency_srm
[  408.765000] rcs0: min:1975KHz @ 100MHz, max:5310KHz @ 400MHz [67%]
[  408.856999] bcs0: min:1968KHz @ 100MHz, max:5301KHz @ 400MHz [67%]
[  408.948999] vcs0: min:2007KHz @ 100MHz, max:5644KHz @ 400MHz [70%]
[  409.040999] vcs1: min:1979KHz @ 100MHz, max:5534KHz @ 400MHz [70%]
[  409.132998] vecs0: min:1971KHz @ 100MHz, max:5329KHz @ 400MHz [68%]
[  409.140135] i915: Running intel_gt_pm_live_selftests/live_rps_power
[  409.289056] rcs0: min:826mW @ 883MHz, max:1370mW @ 3533MHz
[  409.438123] bcs0: min:857mW @ 883MHz, max:1103mW @ 3533MHz
[  409.587115] vcs0: min:861mW @ 883MHz, max:1227mW @ 3533MHz
[  409.736055] vcs1: min:824mW @ 883MHz, max:1213mW @ 3533MHz
[  409.885060] vecs0: min:860mW @ 883MHz, max:1180mW @ 3533MHz
[  409.891263] i915: Running intel_gt_pm_live_selftests/live_rps_interrupt
[  409.891285] i915: Running intel_gt_pm_live_selftests/live_rps_dynamic
[  409.891324] RPS has timer support
[  410.427125] rcs0: dynamically reclocked to 24:400MHz while busy in 502129727ns, and 6:100MHz while idle in 32786357ns
[  410.973124] bcs0: dynamically reclocked to 24:400MHz while busy in 507202384ns, and 6:100MHz while idle in 38207310ns
[  411.499402] vcs0: dynamically reclocked to 24:400MHz while busy in 506289149ns, and 6:100MHz while idle in 19553670ns
[  412.035126] vcs1: dynamically reclocked to 24:400MHz while busy in 504211376ns, and 6:100MHz while idle in 30994325ns
[  412.565103] vecs0: dynamically reclocked to 24:400MHz while busy in 509906099ns, and 6:100MHz while idle in 19575224ns
[  412.576269] i915: Running intel_gt_pm_live_selftests/live_gt_resume
[  413.077831]     ok 9 - live_gt_pm
[  413.078173] i915: Running intel_heartbeat_live_selftests/live_idle_flush
[  413.079302] i915: Running intel_heartbeat_live_selftests/live_idle_pulse
[  413.080530] i915: Running intel_heartbeat_live_selftests/live_heartbeat_fast
[  413.080547] i915 0000:00:02.0: [drm] rcs0 heartbeat interval adjusted to a non-default value which may cause engine resets to target innocent contexts!
[  413.100996] rcs0: Heartbeat delay: 3989us [3981, 4425]
[  413.101014] i915 0000:00:02.0: [drm] bcs0 heartbeat interval adjusted to a non-default value which may cause engine resets to target innocent contexts!
[  413.120995] bcs0: Heartbeat delay: 3989us [3961, 3990]
[  413.121011] i915 0000:00:02.0: [drm] vcs0 heartbeat interval adjusted to a non-default value which may cause engine resets to target innocent contexts!
[  413.140997] vcs0: Heartbeat delay: 3989us [3965, 3991]
[  413.141013] i915 0000:00:02.0: [drm] vcs1 heartbeat interval adjusted to a non-default value which may cause engine resets to target innocent contexts!
[  413.160995] vcs1: Heartbeat delay: 3988us [3962, 3990]
[  413.161011] i915 0000:00:02.0: [drm] vecs0 heartbeat interval adjusted to a non-default value which may cause engine resets to target innocent contexts!
[  413.180995] vecs0: Heartbeat delay: 3988us [3965, 3989]
[  413.181186] i915: Running intel_heartbeat_live_selftests/live_heartbeat_off
[  413.181206] i915 0000:00:02.0: [drm] rcs0 heartbeat interval adjusted to a non-default value which may cause engine resets to target innocent contexts!
[  413.181231] i915 0000:00:02.0: [drm] bcs0 heartbeat interval adjusted to a non-default value which may cause engine resets to target innocent contexts!
[  413.181258] i915 0000:00:02.0: [drm] vcs0 heartbeat interval adjusted to a non-default value which may cause engine resets to target innocent contexts!
[  413.181282] i915 0000:00:02.0: [drm] vcs1 heartbeat interval adjusted to a non-default value which may cause engine resets to target innocent contexts!
[  413.181306] i915 0000:00:02.0: [drm] vecs0 heartbeat interval adjusted to a non-default value which may cause engine resets to target innocent contexts!
[  413.182041]     ok 10 - live_gt_heartbeat
[  413.182263] i915: Running i915_request_live_selftests/live_nop_request
[  413.684506] Request latencies on rcs0: 1 = 193278ns, 631 = 14517ns
[  414.187056] Request latencies on bcs0: 1 = 58198ns, 1103 = 5363ns
[  414.691635] Request latencies on vcs0: 1 = 208875ns, 1103 = 5284ns
[  415.193970] Request latencies on vcs1: 1 = 100363ns, 1091 = 5276ns
[  415.694286] Request latencies on vecs0: 1 = 100734ns, 1093 = 5386ns
[  415.694296] i915: Running i915_request_live_selftests/live_all_engines
[  415.704108] i915: Running i915_request_live_selftests/live_sequential_engines
[  415.724264] i915: Running i915_request_live_selftests/live_parallel_engines
[  416.225005] vecs0: 9164 request + sync
[  416.225017] vcs0: 9272 request + sync
[  416.225018] bcs0: 10629 request + sync
[  416.225019] rcs0: 4249 request + sync
[  416.225086] vcs1: 8231 request + sync
[  416.725993] vcs1: 42724 requests
[  416.725993] vecs0: 49770 requests
[  416.725993] bcs0: 43715 requests
[  416.725999] rcs0: 34664 requests
[  416.726005] vcs0: 30252 requests
[  416.740332] i915: Running i915_request_live_selftests/live_empty_request
[  417.249170] Batch latencies on rcs0: 1 = 100180ns, 601 = 16439ns
[  417.751340] Batch latencies on bcs0: 1 = 52030ns, 1051 = 5869ns
[  418.254066] Batch latencies on vcs0: 1 = 50862ns, 1051 = 5842ns
[  418.757832] Batch latencies on vcs1: 1 = 83003ns, 1051 = 5873ns
[  419.260333] Batch latencies on vecs0: 1 = 88003ns, 1051 = 5793ns
[  419.266226] i915: Running i915_request_live_selftests/live_cancel_request
[  419.271266] i915 0000:00:02.0: [drm] Resetting rcs0 for preemption time out
[  419.271373] i915 0000:00:02.0: [drm] GPU HANG: ecode 12:1:e75ffefe
[  419.378400] i915 0000:00:02.0: [drm] Resetting bcs0 for preemption time out
[  419.378519] i915 0000:00:02.0: [drm] GPU HANG: ecode 12:2:10000001
[  419.385222] i915 0000:00:02.0: [drm] Resetting vcs0 for preemption time out
[  419.385313] i915 0000:00:02.0: [drm] GPU HANG: ecode 12:4:277ffefe
[  419.391308] i915 0000:00:02.0: [drm] Resetting vcs1 for preemption time out
[  419.391405] i915 0000:00:02.0: [drm] GPU HANG: ecode 12:4:277ffefe
[  419.397223] i915 0000:00:02.0: [drm] Resetting vecs0 for preemption time out
[  419.397276] i915 0000:00:02.0: [drm] GPU HANG: ecode 12:8:277ffefe
[  419.423272] i915: Running i915_request_live_selftests/live_breadcrumbs_smoketest
[  420.105820] Completed 1282 waits for 44096 fences across 5 engines and 8 cpus
[  420.115171]     ok 11 - live_requests
[  420.115246] i915: Running intel_migrate_live_selftests/live_migrate_copy
[  420.531252] i915: Running intel_migrate_live_selftests/live_migrate_clear
[  420.829122] i915: Running intel_migrate_live_selftests/thread_migrate_copy
[  420.922498] i915: Running intel_migrate_live_selftests/thread_migrate_clear
[  421.020675] i915: Running intel_migrate_live_selftests/thread_global_copy
[  421.110435] i915: Running intel_migrate_live_selftests/thread_global_clear
[  421.184091]     ok 12 - live_migrate
[  421.184170] i915: Running i915_active_live_selftests/live_active_wait
[  421.185033] i915: Running i915_active_live_selftests/live_active_retire
[  421.185610] i915: Running i915_active_live_selftests/live_active_barrier
[  421.185976]     ok 13 - live_active
[  421.186102] i915: Running i915_gem_object_live_selftests/igt_gem_huge
[  421.388389]     ok 14 - live_objects
[  421.388633] i915: Running i915_gem_mman_live_selftests/igt_partial_tiling
[  421.906998] check_partial_mappings: timed out after tiling=0 stride=0
[  422.408024] check_partial_mappings: timed out after tiling=1 stride=262144
[  422.909049] check_partial_mappings: timed out after tiling=2 stride=262144
[  422.928131] i915: Running i915_gem_mman_live_selftests/igt_smoke_tiling
[  423.429058] igt_smoke_tiling: Completed 4952 trials
[  423.503189] i915: Running i915_gem_mman_live_selftests/igt_mmap_offset_exhaustion
[  423.523154] i915: Running i915_gem_mman_live_selftests/igt_mmap
[  423.523363] BUG: kernel NULL pointer dereference, address: 00000000000000e8
[  423.523367] #PF: supervisor write access in kernel mode
[  423.523370] #PF: error_code(0x0002) - not-present page
[  423.523373] PGD 0 P4D 0 
[  423.523375] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  423.523379] CPU: 5 PID: 2157 Comm: kunit_try_catch Tainted: G                 N 6.1.0-rc2-drm-990037e9984e+ #11
[  423.523384] Hardware name: Intel Corporation Tiger Lake Client Platform/TigerLake U DDR4 SODIMM RVP, BIOS TGLSFWI1.R00.4073.A01.2102110036 02/11/2021
[  423.523388] RIP: 0010:down_write_killable+0x50/0x110
[  423.523394] Code: 24 10 45 31 c9 31 c9 41 b8 01 00 00 00 31 d2 31 f6 48 89 ef e8 e1 74 4a ff bf 01 00 00 00 e8 87 d6 46 ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 13 0f 94 c0 5a 84 c0 74 62 8b 05 49 12 e4 00 85 c0 74
[  423.523401] RSP: 0018:ffffc90000823c68 EFLAGS: 00010246
[  423.523404] RAX: 0000000000000000 RBX: 00000000000000e8 RCX: 0000000000000000
[  423.523407] RDX: 0000000000000001 RSI: ffffffff81c94fc9 RDI: ffffffff81c94fc9
[  423.523410] RBP: 0000000000000158 R08: 0000000000000001 R09: 0000000000000000
[  423.523413] R10: 0000000000000000 R11: ffff88849d52e348 R12: 0000000000000002
[  423.523416] R13: 0000000000000001 R14: 0000000000100000 R15: 00000000000000e8
[  423.523419] FS:  0000000000000000(0000) GS:ffff88849fa80000(0000) knlGS:0000000000000000
[  423.523422] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  423.523425] CR2: 00000000000000e8 CR3: 0000000002812005 CR4: 0000000000770ee0
[  423.523428] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  423.523431] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  423.523433] PKRU: 55555554
[  423.523435] Call Trace:
[  423.523437]  <TASK>
[  423.523439]  ? vm_mmap_pgoff+0x78/0x150
[  423.523445]  vm_mmap_pgoff+0x78/0x150
[  423.523449]  igt_mmap_offset+0x133/0x1e0 [i915]
[  423.523672]  __igt_mmap+0xfe/0x680 [i915]
[  423.523826]  ? __i915_gem_object_create_user_ext+0x49c/0x550 [i915]
[  423.523969]  igt_mmap+0xd8/0x290 [i915]
[  423.524135]  ? __trace_bprintk+0x8c/0xa0
[  423.524141]  ? kunit_try_catch_throw+0x20/0x20
[  423.524146]  __i915_subtests.cold+0x53/0xd5 [i915]
[  423.524357]  ? __i915_nop_teardown+0x20/0x20 [i915]
[  423.524533]  ? __i915_live_setup+0x60/0x60 [i915]
[  423.524725]  ? singleton_release+0x40/0x40 [i915]
[  423.524933]  ? kunit_try_catch_throw+0x20/0x20
[  423.524938]  i915_gem_mman_live_selftests+0x37/0x50 [i915]
[  423.525145]  run_pci_test+0x68/0x150 [test_i915]
[  423.525153]  ? lock_release+0x22d/0x2f0
[  423.525158]  ? _raw_spin_unlock_irqrestore+0x53/0x80
[  423.525164]  live_mman+0x19/0x30 [test_i915]
[  423.525171]  kunit_try_run_case+0x4e/0x80
[  423.525175]  kunit_generic_run_threadfn_adapter+0x13/0x30
[  423.525180]  kthread+0xf2/0x120
[  423.525184]  ? kthread_complete_and_exit+0x20/0x20
[  423.525189]  ret_from_fork+0x1f/0x30
[  423.525196]  </TASK>
[  423.525198] Modules linked in: test_i915 mei_hdcp snd_hda_codec_hdmi x86_pkg_temp_thermal coretemp snd_hda_intel snd_intel_dspcfg snd_hda_codec kvm_intel snd_hwdep snd_hda_core mei_me kvm irqbypass wmi_bmof snd_pcm i2c_i801 mei i2c_smbus intel_lpss_pci crct10dif_pclmul crc32_pclmul ghash_clmulni_intel i915 prime_numbers drm_buddy e1000e drm_display_helper ptp pps_core drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm video wmi fuse
[  423.525240] CR2: 00000000000000e8
[  423.525243] ---[ end trace 0000000000000000 ]---
[  423.759155] RIP: 0010:down_write_killable+0x50/0x110
[  423.759205] Code: 24 10 45 31 c9 31 c9 41 b8 01 00 00 00 31 d2 31 f6 48 89 ef e8 e1 74 4a ff bf 01 00 00 00 e8 87 d6 46 ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 13 0f 94 c0 5a 84 c0 74 62 8b 05 49 12 e4 00 85 c0 74
[  423.759213] RSP: 0018:ffffc90000823c68 EFLAGS: 00010246
[  423.759216] RAX: 0000000000000000 RBX: 00000000000000e8 RCX: 0000000000000000
[  423.759220] RDX: 0000000000000001 RSI: ffffffff81c94fc9 RDI: ffffffff81c94fc9
[  423.759222] RBP: 0000000000000158 R08: 0000000000000001 R09: 0000000000000000
[  423.759225] R10: 0000000000000000 R11: ffff88849d52e348 R12: 0000000000000002
[  423.759228] R13: 0000000000000001 R14: 0000000000100000 R15: 00000000000000e8
[  423.759231] FS:  0000000000000000(0000) GS:ffff88849fa80000(0000) knlGS:0000000000000000
[  423.759235] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  423.759237] CR2: 00000000000000e8 CR3: 0000000121d76004 CR4: 0000000000770ee0
[  423.759240] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  423.759243] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  423.759246] PKRU: 55555554
[  423.759248] note: kunit_try_catch[2157] exited with preempt_count 1
[  726.442175]     # live_mman: try timed out
[  726.442202] stack segment: 0000 [#2] PREEMPT SMP NOPTI
[  726.442216] CPU: 0 PID: 1854 Comm: i915_selftest Tainted: G      D          N 6.1.0-rc2-drm-990037e9984e+ #11
[  726.442232] Hardware name: Intel Corporation Tiger Lake Client Platform/TigerLake U DDR4 SODIMM RVP, BIOS TGLSFWI1.R00.4073.A01.2102110036 02/11/2021
[  726.442248] RIP: 0010:kthread_stop+0x5a/0x270
[  726.442264] Code: 00 f0 0f c1 43 28 85 c0 0f 84 19 02 00 00 8d 50 01 09 c2 0f 88 de 01 00 00 f6 43 2e 20 0f 84 eb 01 00 00 48 8b ab 58 06 00 00 <f0> 80 4d 00 02 48 89 df e8 e9 f1 ff ff f0 80 4b 02 02 48 89 df e8
[  726.442286] RSP: 0018:ffffc90004493a00 EFLAGS: 00010202
[  726.442298] RAX: 000000006b6b6b6b RBX: ffff88810db30040 RCX: 0000000000000000
[  726.442309] RDX: 000000006b6b6b6f RSI: ffffffff8253fb3d RDI: ffff88810db30040
[  726.442319] RBP: 6b6b6b6b6b6b6b6b R08: 00000000fffeffff R09: 00000000fffeffff
[  726.442329] R10: ffff88849f080000 R11: ffff88849f080000 R12: ffff88810db30068
[  726.442338] R13: ffffffffa0320680 R14: ffffffffa0320680 R15: ffffffffa0320af0
[  726.442348] FS:  00007faa5d14ba80(0000) GS:ffff88849f800000(0000) knlGS:0000000000000000
[  726.442361] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  726.442370] CR2: 00007f0d3c010c58 CR3: 000000011570c005 CR4: 0000000000770ef0
[  726.442380] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  726.442390] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  726.442400] PKRU: 55555554
[  726.442405] Call Trace:
[  726.442411]  <TASK>
[  726.442419]  kunit_try_catch_run.cold+0x67/0x97
[  726.442439]  kunit_run_case_catch_errors+0x73/0xba
[  726.442451]  kunit_run_tests.cold+0x1b1/0x555
[  726.442465]  ? kunit_catch_run_case+0x40/0x40
[  726.442477]  ? kunit_module_notify+0x50/0x50
[  726.442508]  __kunit_test_suites_init+0x48/0x60
[  726.442519]  kunit_module_notify+0x3d/0x50
[  726.442528]  notifier_call_chain+0x43/0xb0
[  726.442543]  blocking_notifier_call_chain+0x41/0x60
[  726.442557]  do_init_module+0x9d/0x210
[  726.442569]  __do_sys_finit_module+0xac/0x120
[  726.442586]  do_syscall_64+0x37/0x90
[  726.442598]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  726.442612] RIP: 0033:0x7faa5f10af3d
[  726.442622] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 ce 0e 00 f7 d8 64 89 01 48
[  726.442643] RSP: 002b:00007ffd26206128 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  726.442656] RAX: ffffffffffffffda RBX: 0000000001356880 RCX: 00007faa5f10af3d
[  726.442666] RDX: 0000000000000000 RSI: 00007faa5f21843c RDI: 0000000000000004
[  726.442675] RBP: 00007faa5f21843c R08: 0000000000000000 R09: 00007ffd26206250
[  726.442685] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
[  726.442694] R13: 0000000001357410 R14: 0000000000000000 R15: 000000000135a760
[  726.442710]  </TASK>
[  726.442715] Modules linked in: test_i915 mei_hdcp snd_hda_codec_hdmi x86_pkg_temp_thermal coretemp snd_hda_intel snd_intel_dspcfg snd_hda_codec kvm_intel snd_hwdep snd_hda_core mei_me kvm irqbypass wmi_bmof snd_pcm i2c_i801 mei i2c_smbus intel_lpss_pci crct10dif_pclmul crc32_pclmul ghash_clmulni_intel i915 prime_numbers drm_buddy e1000e drm_display_helper ptp pps_core drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm video wmi fuse
[  726.442811] ---[ end trace 0000000000000000 ]---
[  726.651075] RIP: 0010:down_write_killable+0x50/0x110
[  726.651097] Code: 24 10 45 31 c9 31 c9 41 b8 01 00 00 00 31 d2 31 f6 48 89 ef e8 e1 74 4a ff bf 01 00 00 00 e8 87 d6 46 ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 13 0f 94 c0 5a 84 c0 74 62 8b 05 49 12 e4 00 85 c0 74
[  726.651104] RSP: 0018:ffffc90000823c68 EFLAGS: 00010246
[  726.651107] RAX: 0000000000000000 RBX: 00000000000000e8 RCX: 0000000000000000
[  726.651110] RDX: 0000000000000001 RSI: ffffffff81c94fc9 RDI: ffffffff81c94fc9
[  726.651113] RBP: 0000000000000158 R08: 0000000000000001 R09: 0000000000000000
[  726.651115] R10: 0000000000000000 R11: ffff88849d52e348 R12: 0000000000000002
[  726.651118] R13: 0000000000000001 R14: 0000000000100000 R15: 00000000000000e8
[  726.651121] FS:  00007faa5d14ba80(0000) GS:ffff88849f800000(0000) knlGS:0000000000000000
[  726.651124] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  726.651127] CR2: 00007f0d3c010c58 CR3: 000000011570c005 CR4: 0000000000770ef0
[  726.651129] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  726.651132] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  726.651134] PKRU: 55555554
