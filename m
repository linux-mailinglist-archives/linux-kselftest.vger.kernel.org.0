Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE0617BC5
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 12:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiKCLlM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 07:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKCLlK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 07:41:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8652012745;
        Thu,  3 Nov 2022 04:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667475669; x=1699011669;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6eeapZWGVQKUdBkXtuCROwbCT3dd5H5Szsdjv3PlxbY=;
  b=Io0ma53tK7+AgSBx/yIuzqDLqZZc8y9r5D1UbVF+qk7+5Xs+i49Y+TEL
   lJKex3UVDp7u6susuxHAMfnd8KAXn4J/o0ewDwvsLuCUKfWQtS570xFCe
   +4HNgQRXrnEDMNWxdsutKltPM4fE3zIp+QWrE7Ja+/sa7HObb88BlTNmg
   PXApTqvQ/MOATV3T4Nx4LnUSsx3sLIv3aVZY6MCavbOtJ8NCTrn/D0ZsR
   +DPD9gZn2b0v5umzVAq078vo70/glLcNXuyisq2vwGQY1t/6a54FUUcfW
   H3NjPe/HKfjcgLUzzi5zhwX+6G0I20onayd7bVULyM/0rcCVRaz0IRxWa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="290046891"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="290046891"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 04:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="879851249"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="879851249"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 03 Nov 2022 04:41:07 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.30.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BE29A580C99;
        Thu,  3 Nov 2022 04:41:02 -0700 (PDT)
Date:   Thu, 3 Nov 2022 12:40:59 +0100
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
Message-ID: <20221103124059.682e7adf@maurocar-mobl2>
In-Reply-To: <20221103104840.7301df76@maurocar-mobl2>
References: <20220829000920.38185-1-isabbasso@riseup.net>
        <20220829000920.38185-4-isabbasso@riseup.net>
        <20221103104840.7301df76@maurocar-mobl2>
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

On Thu, 3 Nov 2022 10:48:40 +0100
Mauro Carvalho Chehab <mauro.chehab@linux.intel.com> wrote:

> On Sun, 28 Aug 2022 21:09:19 -0300
> Isabella Basso <isabbasso@riseup.net> wrote:
> 
> > This adds functions for both executing the tests as well as parsing (K)TAP
> > kmsg output, as per the KTAP spec [1].
> > 
> > [1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
> > 
> > Signed-off-by: Isabella Basso <isabbasso@riseup.net>  
> 
> Hi Isabella,
> 
> I'm doing some tests here with my i915 KUnit patch series.
> 
> There's a problem with the way it is currently parsing the KTAP logs on
> IGT. It sounds that it is parsing the data only at the end, and not as
> they arrive. That's bad, as if something goes wrong, the previously
> reported data is still useful.
> 
> Also, when there's a crash, the IGT process is getting segmentation
> fault. So, the end result is that nothing is actually reported.
> 
> 	$ sudo ./build/tests/i915_selftest
> 	IGT-Version: 1.26-gbab20eb65 (x86_64) (Linux: 6.1.0-rc2-drm-990037e9984e+ x86_64)
> 	Segmentation fault (core dumped)

Another issue related to KTAP parsing: this is the output before
the KUnit patch, which is used by IGT CI to check the test results, for
i915 mock selftest:

<snip>
IGT-Version: 1.26-gbab20eb65 (x86_64) (Linux: 6.1.0-rc2-drm-8dacd9299fcc+ x86_64)
process 659 (alsactl) is using audio device. Should be terminated.
Starting subtest: mock
Starting dynamic subtest: sanitycheck
Dynamic subtest sanitycheck: SUCCESS (0.648s)
Starting dynamic subtest: shmem
Dynamic subtest shmem: SUCCESS (0.557s)
Starting dynamic subtest: fence
Dynamic subtest fence: SUCCESS (8.078s)
Starting dynamic subtest: scatterlist
Dynamic subtest scatterlist: SUCCESS (1.531s)
Starting dynamic subtest: syncmap
Dynamic subtest syncmap: SUCCESS (2.875s)
Starting dynamic subtest: uncore
Dynamic subtest uncore: SUCCESS (0.525s)
Starting dynamic subtest: ring
Dynamic subtest ring: SUCCESS (0.529s)
Starting dynamic subtest: engine
Dynamic subtest engine: SUCCESS (0.527s)
Starting dynamic subtest: timelines
Dynamic subtest timelines: SUCCESS (4.177s)
Starting dynamic subtest: requests
Dynamic subtest requests: SUCCESS (3.561s)
Starting dynamic subtest: objects
Dynamic subtest objects: SUCCESS (0.596s)
Starting dynamic subtest: phys
Dynamic subtest phys: SUCCESS (0.602s)
Starting dynamic subtest: dmabuf
Dynamic subtest dmabuf: SUCCESS (0.605s)
Starting dynamic subtest: vma
Dynamic subtest vma: SUCCESS (9.724s)
Starting dynamic subtest: evict
Dynamic subtest evict: SUCCESS (1.660s)
Starting dynamic subtest: gtt
Dynamic subtest gtt: SUCCESS (3.309s)
Starting dynamic subtest: hugepages
Dynamic subtest hugepages: SUCCESS (1.665s)
Starting dynamic subtest: memory_region
Dynamic subtest memory_region: SUCCESS (2.789s)
Subtest mock: SUCCESS (43.961s)
</snip>

This is the logs after your patch:

<snip>
Missing test version string
Executing 18 tests in: i915 mock selftests
kmsg> 1..18
kmsg> i915: i915_mock_sanitycheck() - ok!
kmsg> ok 1 - mock_sanitycheck
kmsg> i915: Running shmem_utils_mock_selftests/igt_shmem_basic
kmsg> ok 2 - mock_shmem
kmsg> i915: Running i915_sw_fence_mock_selftests/test_self
kmsg> i915: Running i915_sw_fence_mock_selftests/test_dag
kmsg> i915: Running i915_sw_fence_mock_selftests/test_AB
kmsg> i915: Running i915_sw_fence_mock_selftests/test_ABC
kmsg> i915: Running i915_sw_fence_mock_selftests/test_AB_C
kmsg> i915: Running i915_sw_fence_mock_selftests/test_C_AB
kmsg> i915: Running i915_sw_fence_mock_selftests/test_chain
kmsg> i915: Running i915_sw_fence_mock_selftests/test_ipc
kmsg> i915: Running i915_sw_fence_mock_selftests/test_timer
kmsg> i915: Running i915_sw_fence_mock_selftests/test_dma_fence
kmsg> Asynchronous wait on fence mock:mock:0 timed out (hint:fence_notify [i915])
kmsg> ok 3 - mock_fence
kmsg> i915: Running scatterlist_mock_selftests/igt_sg_alloc
kmsg> sg_alloc_table timed out
kmsg> i915: Running scatterlist_mock_selftests/igt_sg_trim
kmsg> i915_sg_trim timed out
kmsg> ok 4 - mock_scatterlist
kmsg> i915: Running i915_syncmap_mock_selftests/igt_syncmap_init
kmsg> i915: Running i915_syncmap_mock_selftests/igt_syncmap_one
kmsg> i915: Running i915_syncmap_mock_selftests/igt_syncmap_join_above
kmsg> i915: Running i915_syncmap_mock_selftests/igt_syncmap_join_below
kmsg> i915: Running i915_syncmap_mock_selftests/igt_syncmap_neighbours
kmsg> i915: Running i915_syncmap_mock_selftests/igt_syncmap_compact
kmsg> i915: Running i915_syncmap_mock_selftests/igt_syncmap_random
kmsg> ok 5 - mock_syncmap
kmsg> ok 6 - mock_uncore
kmsg> i915: Running intel_ring_mock_selftests/igt_ring_direction
kmsg> ok 7 - mock_ring
kmsg> i915: Running intel_engine_cs_mock_selftests/intel_mmio_bases_check
kmsg> ok 8 - mock_engine
kmsg> i915: Running intel_timeline_mock_selftests/mock_hwsp_freelist
kmsg> mock: [drm] Using Transparent Hugepages
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
kmsg> i915: Running intel_timeline_mock_selftests/igt_sync
kmsg> i915: Running intel_timeline_mock_selftests/bench_sync
kmsg> bench_sync: 44045 random insertions, 2288ns/insert
kmsg> bench_sync: 44045 random lookups, 80ns/lookup
kmsg> bench_sync: 877617 in-order insertions, 114ns/insert
kmsg> bench_sync: 877617 in-order lookups, 3ns/lookup
kmsg> bench_sync: 6357870 repeated insert/lookups, 10ns/op
kmsg> bench_sync: 19942183 cyclic/1 insert/lookups, 5ns/op
kmsg> bench_sync: 19353937 cyclic/2 insert/lookups, 5ns/op
kmsg> bench_sync: 16969941 cyclic/3 insert/lookups, 5ns/op
kmsg> bench_sync: 14438533 cyclic/5 insert/lookups, 6ns/op
kmsg> bench_sync: 13418112 cyclic/8 insert/lookups, 7ns/op
kmsg> bench_sync: 9257200 cyclic/13 insert/lookups, 10ns/op
kmsg> bench_sync: 53636 cyclic/21 insert/lookups, 1877ns/op
kmsg> ok 9 - mock_timelines
kmsg> mock: [drm] Using Transparent Hugepages
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
kmsg> i915: Running i915_request_mock_selftests/igt_add_request
kmsg> i915: Running i915_request_mock_selftests/igt_wait_request
kmsg> i915: Running i915_request_mock_selftests/igt_fence_wait
kmsg> i915: Running i915_request_mock_selftests/igt_request_rewind
kmsg> i915: Running i915_request_mock_selftests/mock_breadcrumbs_smoketest
kmsg> Completed 92 waits for 49042 fence across 8 cpus
kmsg> ok 10 - mock_requests
kmsg> mock: [drm] Using Transparent Hugepages
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
kmsg> i915: Running i915_gem_object_mock_selftests/igt_gem_object
kmsg> ok 11 - mock_objects
kmsg> mock: [drm] Using Transparent Hugepages
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
kmsg> i915: Running i915_gem_phys_mock_selftests/mock_phys_object
kmsg> ok 12 - mock_phys
kmsg> mock: [drm] Using Transparent Hugepages
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
kmsg> i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_export
kmsg> i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_import_self
kmsg> i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_import
kmsg> i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_import_ownership
kmsg> i915: Running i915_gem_dmabuf_mock_selftests/igt_dmabuf_export_vmap
kmsg> ok 13 - mock_dmabuf
kmsg> mock: [drm] Using Transparent Hugepages
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
kmsg> i915: Running i915_vma_mock_selftests/igt_vma_create
kmsg> igt_vma_create timed out: after 31 objects in 23 contexts
kmsg> i915: Running i915_vma_mock_selftests/igt_vma_pin1
kmsg> i915: Running i915_vma_mock_selftests/igt_vma_rotate_remap
kmsg> i915: Running i915_vma_mock_selftests/igt_vma_partial
kmsg> ok 14 - mock_vma
kmsg> mock: [drm] Using Transparent Hugepages
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
kmsg> i915: Running i915_gem_evict_mock_selftests/igt_evict_something
kmsg> i915: Running i915_gem_evict_mock_selftests/igt_evict_for_vma
kmsg> i915: Running i915_gem_evict_mock_selftests/igt_evict_for_cache_color
kmsg> i915: Running i915_gem_evict_mock_selftests/igt_evict_vm
kmsg> i915: Running i915_gem_evict_mock_selftests/igt_overcommit
kmsg> ok 15 - mock_evict
kmsg> mock: [drm] Using Transparent Hugepages
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
kmsg> i915: Running i915_gem_gtt_mock_selftests/igt_mock_drunk
kmsg> drunk_hole timed out after 31635/524288
kmsg> i915: Running i915_gem_gtt_mock_selftests/igt_mock_walk
kmsg> walk_hole timed out at 812f000
kmsg> i915: Running i915_gem_gtt_mock_selftests/igt_mock_pot
kmsg> pot_hole timed out after 19/33
kmsg> i915: Running i915_gem_gtt_mock_selftests/igt_mock_fill
kmsg> fill_hole timed out (npages=1, prime=199)
kmsg> i915: Running i915_gem_gtt_mock_selftests/igt_gtt_reserve
kmsg> i915: Running i915_gem_gtt_mock_selftests/igt_gtt_insert
kmsg> ok 16 - mock_gtt
kmsg> mock: [drm] Using Transparent Hugepages
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
kmsg> i915: Running i915_gem_huge_page_mock_selftests/igt_mock_exhaust_device_supported_pages
kmsg> i915: Running i915_gem_huge_page_mock_selftests/igt_mock_memory_region_huge_pages
kmsg> i915: Running i915_gem_huge_page_mock_selftests/igt_mock_ppgtt_misaligned_dma
kmsg> i915: Running i915_gem_huge_page_mock_selftests/igt_mock_ppgtt_huge_fill
kmsg> igt_mock_ppgtt_huge_fill timed out at size 43986944
kmsg> i915: Running i915_gem_huge_page_mock_selftests/igt_mock_ppgtt_64K
kmsg> ok 17 - mock_hugepages
kmsg> mock: [drm] Using Transparent Hugepages
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - HuC is not supported!
kmsg> mock: [drm] Incompatible option enable_guc=3 - GuC submission is N/A
kmsg> i915: Running intel_memory_region_mock_selftests/igt_mock_reserve
kmsg> i915: Running intel_memory_region_mock_selftests/igt_mock_fill
kmsg> i915: Running intel_memory_region_mock_selftests/igt_mock_contiguous
kmsg> i915: Running intel_memory_region_mock_selftests/igt_mock_splintered_region
kmsg> i915: Running intel_memory_region_mock_selftests/igt_mock_max_segment
kmsg> i915: Running intel_memory_region_mock_selftests/igt_mock_io_size
kmsg> igt_mock_io_size with ps=10000, io_size=10000000, total=cf110000
kmsg> igt_mock_io_size mappable theft=(0MiB/256MiB), total=3313MiB
kmsg> ok 18 - mock_memory_region
kmsg> # i915 mock selftests: pass:18 fail:0 skip:0 total:18
kmsg> # Totals: pass:18 fail:0 skip:0 total:18
kmsg> ok 1 - i915 mock selftests
SUCCESS (29.259s)
</snip>

Basically, the current output will break CI reports presented at:
	https://intel-gfx-ci.01.org/tree/drm-tip/bat-all.html?testfilter=selftest

The IGT output after your change should be similar to what we had
before, e. g. each test should output SUCCESS/FAIL/SKIP (plus the
final result of all tests at the suite).

any other non-KTAP messages from dmesg should be ignored, as, if
needed, those can be obtained later, as IGT runs on bare metal,
and not inside a VM.

Regards,
Mauro
