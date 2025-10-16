Return-Path: <linux-kselftest+bounces-43320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AA5BE2EF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 12:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3BED548880
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE5339B3D;
	Thu, 16 Oct 2025 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO3WJM9q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1A335BD9
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611472; cv=none; b=Su2h7L2zCvLLol9eMjPBRxujuGERpjdwObEGw71VDdBewm4wUWUe99qsbGHHsuQp5OlKjKAeoRTQ41K6m6GV6iiSuv1En71IYD1RD6tUpOLCyEiZXkYZ6067XCNSqlIxPw6NSvdE5FpDJnLrGnXV1FgBRAhS05HJM9kfsXs0R50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611472; c=relaxed/simple;
	bh=b9Vn3UCr/boL+9IYP24wBftxldcHZeUdrnFnJ9AEAVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwfH+6/tAcqw+gC0p+nYqyPgwbNsR8CuHZIQCquz5PFrik5tG/kWTXbcWLKnSEzvJyqFJZ7xcgXb21KZgWR5edwyXFuPKvv8jJO8U4nowHXqNLAA07vk0p/SiJELRsXaTCqD+QOad87a5/328YqWxZfE83w6jNQZRC6+DnkrdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO3WJM9q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2698384978dso4270085ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 03:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760611464; x=1761216264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olJyyxtzbmL46WdjAK+t1+nUyfmw0CJpgAPIA8sLZg0=;
        b=jO3WJM9qQxh8YS7n3w3sA8DG6shSvmin5P+qQXw7zWg+StRn+kBEKJyNBD4VGmTSPK
         sHHVGz2TAXoYiypWGSdOFVKHG3WYLmcL6JemSuCSHW/QwTJ5IcbqzczjP2V2dHxAhtzG
         dyZzRIJWYluGCsfUpGkXnJWUa6aTWYMcZRFFP9O+197zZmmU5nd+C+UrRini3AlYqHmv
         LAeCDsvF9bJT+FhJ59VPJ/FMoGskc8MJf/mxdXWtyud1ughE76YBT0kSaPwEFoqI3AEM
         OlUPGABe5LvCthTSPmAOeSCIQf8dIfsoJ0Yrj3p9SEk1O910z1JKCXQ3m4TcNFIYehbd
         ndhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760611464; x=1761216264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olJyyxtzbmL46WdjAK+t1+nUyfmw0CJpgAPIA8sLZg0=;
        b=TVu2eXvRw8ZZChzqq/d6PKub6Mvsp/sv2w79ATxYUVfUua9NUVJXOcw36NLSdLpEhE
         vTS5howoyrKlgXLXsXVTwxdCWyg5QlfFRti0dcdHfFnNYa9jSu86mE5AcgBqtE8yDu4+
         4U7zkl61cja9r4agMO+s4fgCTx0ybJO5gYwKrY0LRA7ZxxLmBB2bbADkPUTqKrVBPtWH
         kIYgbNy7z9vgp315/AfnL6/eY7sYG3a4tRjtPioOdk71g2MAfg3uTHo+7z7961wIjs3y
         j6U+0HPLWCFpbiRSuWbbVokt1yOrRmvmPuoc804MSFuUHP7XT9vkq+HMaVvqHXJN/exy
         kODg==
X-Forwarded-Encrypted: i=1; AJvYcCVYHj4mHxns2oDTRDH2M/jYe2PFMtRpb5XZTSzOsniI8MrmkiP78NFeftLPRzd//1TUItgVcrd2jpKoG0VR4Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA+83D93dJPaz49ieQMNPXgX7z1cPzdwUUpNqhRFgg8H9HtZss
	hn3KoB4jdu6eFiRDhpnn5Y+XJ2gCwymKA01/s/ZaL0hp++Pu+mhFcIZD
X-Gm-Gg: ASbGnctQDL+y3CXkuiE4YsIiIIQXD0EPKvUBBGcq07csfo3qYncD06LpLkg3nffHtJA
	X5BMCTAB0hjKMlpneHRoFX/oZAlOM+MTEDsDMHv4tzRp3wD3DhxfHlbUL4DaPvPjnZjKAQ82wAc
	5tuozrUKYJMobQh+HlOZqAMSOMXj7CMzFMogH4o2N6ep/bgvMCgvV6meci/2L4qqAD8MnLM/FqV
	jI1XSk2BAutojGhppiB/OHPvO1T6vALTQJSZIHhLOp1AN34h9VBap9gOBjfNYVZR/rc9nNlLeOy
	V8XM1I9uoETxPIk0xDovdVdp7CfmAwZphXV6rKSe7RVViq6h2r9Vqp3S+Jv5cFLxsV1jrYQFiho
	ynmzZcChqDeoyhhEY0He4z0g+yG1xuPVE4A3tdgR01tMJr8OPoQ/fBhHE77MQ3+Dk7M/PuNQs5a
	wHNH7zvGSK7BxeBLWhfUVv
X-Google-Smtp-Source: AGHT+IEHPq//u/Euj+irEQg7DYwfX83gj8eAsfT9+SxQr4VTUZZDR31lgO6hcR+szEp2c/twWytoFg==
X-Received: by 2002:a17:903:1987:b0:24c:7b94:2f53 with SMTP id d9443c01a7336-29027215b7amr404284015ad.6.1760611463468;
        Thu, 16 Oct 2025 03:44:23 -0700 (PDT)
Received: from server.. ([103.251.57.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934943fsm25878525ad.32.2025.10.16.03.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:44:22 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	richard.weiyang@gmail.com
Cc: david.shane.hunter@gmail.com,
	khalid@kernel.org,
	Liam.Howlett@oracle.com,
	davem@davemloft.net,
	david@redhat.com,
	edumazet@google.com,
	gnoack@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	mic@digikod.net,
	ming.lei@redhat.com,
	pabeni@redhat.com,
	surenb@google.com,
	vbabka@suse.cz,
	linux-kernel-mentees@lists.linux.dev,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Subject: [PATCH v3] selftests: complete kselftest include centralization
Date: Thu, 16 Oct 2025 16:14:09 +0530
Message-ID: <20251016104409.68985-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830163949.20952-1-reddybalavignesh9979@gmail.com>
References: <20250830163949.20952-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This follow-up patch completes centralization of kselftest.h and
ksefltest_harness.h includes in remaining seltests files, replacing all
relative paths with a non-relative paths using shared -I include path
in lib.mk

Tested with gcc-13.3 and clang-18.1, and cross-compiled successfully
on riscv, arm64, x86_64 and powerpc arch.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/lkml/20250820143954.33d95635e504e94df01930d0@linux-foundation.org/

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
Changes in v3:
single patch that moves include path in lib.mk using top_srcdir,
and all remaining source conversions
---
 tools/testing/selftests/acct/acct_syscall.c                   | 2 +-
 tools/testing/selftests/alsa/conf.c                           | 2 +-
 tools/testing/selftests/alsa/mixer-test.c                     | 2 +-
 tools/testing/selftests/alsa/pcm-test.c                       | 2 +-
 tools/testing/selftests/alsa/test-pcmtest-driver.c            | 2 +-
 tools/testing/selftests/alsa/utimer-test.c                    | 2 +-
 tools/testing/selftests/arm64/abi/hwcap.c                     | 2 +-
 tools/testing/selftests/arm64/abi/ptrace.c                    | 2 +-
 tools/testing/selftests/arm64/abi/syscall-abi.c               | 2 +-
 tools/testing/selftests/arm64/fp/fp-ptrace.c                  | 2 +-
 tools/testing/selftests/arm64/fp/fp-stress.c                  | 2 +-
 tools/testing/selftests/arm64/fp/sve-probe-vls.c              | 2 +-
 tools/testing/selftests/arm64/fp/sve-ptrace.c                 | 2 +-
 tools/testing/selftests/arm64/fp/vec-syscfg.c                 | 2 +-
 tools/testing/selftests/arm64/fp/za-ptrace.c                  | 2 +-
 tools/testing/selftests/arm64/fp/zt-ptrace.c                  | 2 +-
 tools/testing/selftests/arm64/gcs/gcs-stress.c                | 2 +-
 tools/testing/selftests/arm64/pauth/pac.c                     | 2 +-
 tools/testing/selftests/arm64/tags/tags_test.c                | 2 +-
 tools/testing/selftests/bpf/xskxceiver.c                      | 2 +-
 tools/testing/selftests/breakpoints/breakpoint_test.c         | 2 +-
 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c   | 2 +-
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 2 +-
 tools/testing/selftests/cachestat/test_cachestat.c            | 2 +-
 tools/testing/selftests/capabilities/test_execve.c            | 2 +-
 tools/testing/selftests/capabilities/validate_cap.c           | 2 +-
 tools/testing/selftests/cgroup/test_core.c                    | 2 +-
 tools/testing/selftests/cgroup/test_cpu.c                     | 2 +-
 tools/testing/selftests/cgroup/test_cpuset.c                  | 2 +-
 tools/testing/selftests/cgroup/test_freezer.c                 | 2 +-
 tools/testing/selftests/cgroup/test_hugetlb_memcg.c           | 2 +-
 tools/testing/selftests/cgroup/test_kill.c                    | 2 +-
 tools/testing/selftests/cgroup/test_kmem.c                    | 2 +-
 tools/testing/selftests/cgroup/test_memcontrol.c              | 2 +-
 tools/testing/selftests/cgroup/test_pids.c                    | 2 +-
 tools/testing/selftests/cgroup/test_zswap.c                   | 2 +-
 tools/testing/selftests/clone3/clone3.c                       | 2 +-
 .../testing/selftests/clone3/clone3_cap_checkpoint_restore.c  | 2 +-
 tools/testing/selftests/clone3/clone3_clear_sighand.c         | 2 +-
 tools/testing/selftests/clone3/clone3_selftests.h             | 2 +-
 tools/testing/selftests/clone3/clone3_set_tid.c               | 2 +-
 tools/testing/selftests/connector/proc_filter.c               | 2 +-
 tools/testing/selftests/core/close_range_test.c               | 2 +-
 tools/testing/selftests/core/unshare_test.c                   | 2 +-
 tools/testing/selftests/coredump/stackdump_test.c             | 2 +-
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c            | 2 +-
 tools/testing/selftests/drivers/dma-buf/udmabuf.c             | 2 +-
 tools/testing/selftests/drivers/ntsync/ntsync.c               | 2 +-
 .../testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c  | 2 +-
 tools/testing/selftests/exec/check-exec.c                     | 2 +-
 tools/testing/selftests/exec/execveat.c                       | 2 +-
 tools/testing/selftests/exec/load_address.c                   | 2 +-
 tools/testing/selftests/exec/non-regular.c                    | 2 +-
 tools/testing/selftests/exec/null-argv.c                      | 2 +-
 tools/testing/selftests/exec/recursion-depth.c                | 2 +-
 tools/testing/selftests/fchmodat2/fchmodat2_test.c            | 2 +-
 tools/testing/selftests/filelock/ofdlocks.c                   | 2 +-
 tools/testing/selftests/filesystems/anon_inode_test.c         | 2 +-
 tools/testing/selftests/filesystems/binderfs/binderfs_test.c  | 2 +-
 tools/testing/selftests/filesystems/devpts_pts.c              | 2 +-
 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c | 2 +-
 tools/testing/selftests/filesystems/eventfd/eventfd_test.c    | 2 +-
 tools/testing/selftests/filesystems/fclog.c                   | 2 +-
 tools/testing/selftests/filesystems/file_stressor.c           | 2 +-
 tools/testing/selftests/filesystems/fuse/fusectl_test.c       | 2 +-
 tools/testing/selftests/filesystems/kernfs_test.c             | 2 +-
 .../selftests/filesystems/mount-notify/mount-notify_test.c    | 2 +-
 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c | 2 +-
 tools/testing/selftests/filesystems/nsfs/iterate_mntns.c      | 2 +-
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c   | 2 +-
 .../selftests/filesystems/overlayfs/set_layers_via_fds.c      | 2 +-
 .../testing/selftests/filesystems/statmount/listmount_test.c  | 2 +-
 .../testing/selftests/filesystems/statmount/statmount_test.c  | 2 +-
 .../selftests/filesystems/statmount/statmount_test_ns.c       | 2 +-
 tools/testing/selftests/filesystems/utils.c                   | 2 +-
 tools/testing/selftests/futex/functional/futex_numa_mpol.c    | 2 +-
 tools/testing/selftests/futex/functional/futex_priv_hash.c    | 2 +-
 tools/testing/selftests/futex/functional/futex_requeue.c      | 2 +-
 tools/testing/selftests/futex/functional/futex_requeue_pi.c   | 2 +-
 .../futex/functional/futex_requeue_pi_mismatched_ops.c        | 2 +-
 .../futex/functional/futex_requeue_pi_signal_restart.c        | 2 +-
 tools/testing/selftests/futex/functional/futex_wait.c         | 2 +-
 .../futex/functional/futex_wait_private_mapped_file.c         | 2 +-
 tools/testing/selftests/futex/functional/futex_wait_timeout.c | 2 +-
 .../futex/functional/futex_wait_uninitialized_heap.c          | 2 +-
 .../selftests/futex/functional/futex_wait_wouldblock.c        | 2 +-
 tools/testing/selftests/futex/functional/futex_waitv.c        | 2 +-
 tools/testing/selftests/hid/hid_common.h                      | 2 +-
 tools/testing/selftests/intel_pstate/aperf.c                  | 2 +-
 tools/testing/selftests/iommu/iommufd_utils.h                 | 2 +-
 tools/testing/selftests/ipc/msgque.c                          | 2 +-
 tools/testing/selftests/ir/ir_loopback.c                      | 2 +-
 tools/testing/selftests/kcmp/kcmp_test.c                      | 2 +-
 tools/testing/selftests/kselftest_harness.h                   | 2 +-
 tools/testing/selftests/kselftest_harness/harness-selftest.c  | 2 +-
 tools/testing/selftests/landlock/audit.h                      | 2 +-
 tools/testing/selftests/landlock/common.h                     | 2 +-
 tools/testing/selftests/lib.mk                                | 3 +++
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c          | 2 +-
 tools/testing/selftests/lsm/lsm_list_modules_test.c           | 2 +-
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c          | 2 +-
 tools/testing/selftests/media_tests/media_device_open.c       | 2 +-
 tools/testing/selftests/media_tests/media_device_test.c       | 2 +-
 tools/testing/selftests/membarrier/membarrier_test_impl.h     | 2 +-
 tools/testing/selftests/mincore/mincore_selftest.c            | 4 ++--
 tools/testing/selftests/mm/compaction_test.c                  | 2 +-
 tools/testing/selftests/mm/cow.c                              | 2 +-
 tools/testing/selftests/mm/droppable.c                        | 2 +-
 tools/testing/selftests/mm/guard-regions.c                    | 2 +-
 tools/testing/selftests/mm/gup_longterm.c                     | 2 +-
 tools/testing/selftests/mm/gup_test.c                         | 2 +-
 tools/testing/selftests/mm/hmm-tests.c                        | 2 +-
 tools/testing/selftests/mm/hugepage-mmap.c                    | 2 +-
 tools/testing/selftests/mm/hugepage-mremap.c                  | 2 +-
 tools/testing/selftests/mm/hugetlb-madvise.c                  | 2 +-
 tools/testing/selftests/mm/hugetlb-read-hwpoison.c            | 2 +-
 tools/testing/selftests/mm/hugetlb-soft-offline.c             | 2 +-
 tools/testing/selftests/mm/hugetlb_dio.c                      | 2 +-
 tools/testing/selftests/mm/hugetlb_fault_after_madv.c         | 2 +-
 tools/testing/selftests/mm/hugetlb_madv_vs_map.c              | 2 +-
 tools/testing/selftests/mm/ksm_functional_tests.c             | 2 +-
 tools/testing/selftests/mm/ksm_tests.c                        | 2 +-
 tools/testing/selftests/mm/madv_populate.c                    | 2 +-
 tools/testing/selftests/mm/map_fixed_noreplace.c              | 2 +-
 tools/testing/selftests/mm/map_hugetlb.c                      | 2 +-
 tools/testing/selftests/mm/map_populate.c                     | 2 +-
 tools/testing/selftests/mm/mdwe_test.c                        | 2 +-
 tools/testing/selftests/mm/memfd_secret.c                     | 2 +-
 tools/testing/selftests/mm/merge.c                            | 2 +-
 tools/testing/selftests/mm/migration.c                        | 2 +-
 tools/testing/selftests/mm/mkdirty.c                          | 2 +-
 tools/testing/selftests/mm/mlock-random-test.c                | 2 +-
 tools/testing/selftests/mm/mlock2-tests.c                     | 2 +-
 tools/testing/selftests/mm/mrelease_test.c                    | 2 +-
 tools/testing/selftests/mm/mremap_dontunmap.c                 | 2 +-
 tools/testing/selftests/mm/mremap_test.c                      | 2 +-
 tools/testing/selftests/mm/mseal_test.c                       | 2 +-
 tools/testing/selftests/mm/on-fault-limit.c                   | 2 +-
 tools/testing/selftests/mm/pagemap_ioctl.c                    | 2 +-
 tools/testing/selftests/mm/pfnmap.c                           | 2 +-
 tools/testing/selftests/mm/pkey-helpers.h                     | 2 +-
 tools/testing/selftests/mm/prctl_thp_disable.c                | 2 +-
 tools/testing/selftests/mm/process_madv.c                     | 2 +-
 tools/testing/selftests/mm/rmap.c                             | 2 +-
 tools/testing/selftests/mm/soft-dirty.c                       | 2 +-
 tools/testing/selftests/mm/split_huge_page_test.c             | 2 +-
 tools/testing/selftests/mm/thuge-gen.c                        | 2 +-
 tools/testing/selftests/mm/transhuge-stress.c                 | 2 +-
 tools/testing/selftests/mm/uffd-common.h                      | 2 +-
 tools/testing/selftests/mm/uffd-wp-mremap.c                   | 2 +-
 tools/testing/selftests/mm/va_high_addr_switch.c              | 2 +-
 tools/testing/selftests/mm/virtual_address_range.c            | 2 +-
 tools/testing/selftests/mm/vm_util.c                          | 2 +-
 tools/testing/selftests/mm/vm_util.h                          | 2 +-
 tools/testing/selftests/mount_setattr/mount_setattr_test.c    | 2 +-
 .../move_mount_set_group/move_mount_set_group_test.c          | 2 +-
 tools/testing/selftests/mqueue/mq_open_tests.c                | 2 +-
 tools/testing/selftests/mqueue/mq_perf_tests.c                | 2 +-
 .../selftests/mseal_system_mappings/sysmap_is_sealed.c        | 4 ++--
 tools/testing/selftests/namespaces/file_handle_test.c         | 2 +-
 tools/testing/selftests/namespaces/init_ino_test.c            | 2 +-
 tools/testing/selftests/namespaces/nsid_test.c                | 2 +-
 tools/testing/selftests/nci/nci_dev.c                         | 2 +-
 tools/testing/selftests/net/af_unix/diag_uid.c                | 2 +-
 tools/testing/selftests/net/af_unix/msg_oob.c                 | 2 +-
 tools/testing/selftests/net/af_unix/scm_inq.c                 | 2 +-
 tools/testing/selftests/net/af_unix/scm_pidfd.c               | 2 +-
 tools/testing/selftests/net/af_unix/scm_rights.c              | 2 +-
 tools/testing/selftests/net/af_unix/unix_connect.c            | 2 +-
 tools/testing/selftests/net/bind_timewait.c                   | 2 +-
 tools/testing/selftests/net/bind_wildcard.c                   | 2 +-
 tools/testing/selftests/net/can/test_raw_filter.c             | 2 +-
 tools/testing/selftests/net/cmsg_sender.c                     | 2 +-
 tools/testing/selftests/net/epoll_busy_poll.c                 | 2 +-
 tools/testing/selftests/net/gro.c                             | 2 +-
 tools/testing/selftests/net/ip_local_port_range.c             | 2 +-
 tools/testing/selftests/net/ipsec.c                           | 2 +-
 tools/testing/selftests/net/ipv6_fragmentation.c              | 2 +-
 tools/testing/selftests/net/netfilter/conntrack_dump_flush.c  | 2 +-
 tools/testing/selftests/net/netlink-dumps.c                   | 2 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c                   | 2 +-
 tools/testing/selftests/net/proc_net_pktgen.c                 | 2 +-
 tools/testing/selftests/net/psock_fanout.c                    | 2 +-
 tools/testing/selftests/net/psock_tpacket.c                   | 2 +-
 tools/testing/selftests/net/reuseaddr_ports_exhausted.c       | 2 +-
 tools/testing/selftests/net/reuseport_bpf.c                   | 2 +-
 tools/testing/selftests/net/reuseport_bpf_numa.c              | 2 +-
 tools/testing/selftests/net/rxtimestamp.c                     | 2 +-
 tools/testing/selftests/net/sk_so_peek_off.c                  | 2 +-
 tools/testing/selftests/net/so_incoming_cpu.c                 | 2 +-
 tools/testing/selftests/net/socket.c                          | 2 +-
 tools/testing/selftests/net/tap.c                             | 2 +-
 tools/testing/selftests/net/tcp_ao/lib/setup.c                | 2 +-
 tools/testing/selftests/net/tcp_fastopen_backup_key.c         | 2 +-
 tools/testing/selftests/net/tcp_port_share.c                  | 2 +-
 tools/testing/selftests/net/tls.c                             | 2 +-
 tools/testing/selftests/net/toeplitz.c                        | 2 +-
 tools/testing/selftests/net/tun.c                             | 2 +-
 tools/testing/selftests/net/udpgso_bench_tx.c                 | 2 +-
 tools/testing/selftests/openat2/helpers.h                     | 2 +-
 tools/testing/selftests/openat2/openat2_test.c                | 2 +-
 tools/testing/selftests/openat2/rename_attack_test.c          | 2 +-
 tools/testing/selftests/openat2/resolve_test.c                | 2 +-
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c      | 2 +-
 tools/testing/selftests/perf_events/mmap.c                    | 2 +-
 tools/testing/selftests/perf_events/remove_on_exec.c          | 2 +-
 tools/testing/selftests/perf_events/sigtrap_threads.c         | 2 +-
 tools/testing/selftests/perf_events/watermark_signal.c        | 2 +-
 tools/testing/selftests/pid_namespace/pid_max.c               | 2 +-
 tools/testing/selftests/pid_namespace/regression_enomem.c     | 2 +-
 tools/testing/selftests/pidfd/pidfd.h                         | 2 +-
 tools/testing/selftests/pidfd/pidfd_bind_mount.c              | 2 +-
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c             | 2 +-
 tools/testing/selftests/pidfd/pidfd_file_handle_test.c        | 2 +-
 tools/testing/selftests/pidfd/pidfd_getfd_test.c              | 2 +-
 tools/testing/selftests/pidfd/pidfd_info_test.c               | 2 +-
 tools/testing/selftests/pidfd/pidfd_open_test.c               | 2 +-
 tools/testing/selftests/pidfd/pidfd_poll_test.c               | 2 +-
 tools/testing/selftests/pidfd/pidfd_setattr_test.c            | 2 +-
 tools/testing/selftests/pidfd/pidfd_setns_test.c              | 2 +-
 tools/testing/selftests/pidfd/pidfd_test.c                    | 2 +-
 tools/testing/selftests/pidfd/pidfd_wait.c                    | 2 +-
 tools/testing/selftests/pidfd/pidfd_xattr_test.c              | 2 +-
 tools/testing/selftests/prctl/set-anon-vma-name-test.c        | 2 +-
 tools/testing/selftests/prctl/set-process-name.c              | 2 +-
 tools/testing/selftests/proc/proc-maps-race.c                 | 2 +-
 tools/testing/selftests/proc/proc-pid-vm.c                    | 2 +-
 tools/testing/selftests/proc/proc-pidns.c                     | 2 +-
 tools/testing/selftests/ptrace/get_set_sud.c                  | 2 +-
 tools/testing/selftests/ptrace/get_syscall_info.c             | 2 +-
 tools/testing/selftests/ptrace/set_syscall_info.c             | 2 +-
 tools/testing/selftests/ptrace/vmaccess.c                     | 2 +-
 tools/testing/selftests/resctrl/resctrl.h                     | 2 +-
 tools/testing/selftests/ring-buffer/map_test.c                | 2 +-
 tools/testing/selftests/riscv/abi/pointer_masking.c           | 2 +-
 tools/testing/selftests/riscv/hwprobe/cbo.c                   | 2 +-
 tools/testing/selftests/riscv/hwprobe/hwprobe.c               | 2 +-
 tools/testing/selftests/riscv/hwprobe/which-cpus.c            | 2 +-
 tools/testing/selftests/riscv/mm/mmap_bottomup.c              | 2 +-
 tools/testing/selftests/riscv/mm/mmap_default.c               | 2 +-
 tools/testing/selftests/riscv/mm/mmap_test.h                  | 2 +-
 tools/testing/selftests/riscv/sigreturn/sigreturn.c           | 2 +-
 tools/testing/selftests/riscv/vector/v_initval.c              | 2 +-
 tools/testing/selftests/riscv/vector/vstate_prctl.c           | 2 +-
 tools/testing/selftests/rseq/basic_percpu_ops_test.c          | 2 +-
 tools/testing/selftests/rseq/rseq.c                           | 2 +-
 tools/testing/selftests/rtc/rtctest.c                         | 2 +-
 tools/testing/selftests/seccomp/seccomp_benchmark.c           | 2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c                 | 2 +-
 tools/testing/selftests/sgx/main.c                            | 2 +-
 tools/testing/selftests/signal/mangle_uc_sigmask.c            | 2 +-
 tools/testing/selftests/signal/sas.c                          | 2 +-
 tools/testing/selftests/sparc64/drivers/adi-test.c            | 2 +-
 tools/testing/selftests/sync/sync_test.c                      | 2 +-
 tools/testing/selftests/syscall_user_dispatch/sud_test.c      | 2 +-
 tools/testing/selftests/tdx/tdx_guest_test.c                  | 2 +-
 tools/testing/selftests/timens/timens.h                       | 2 +-
 tools/testing/selftests/timers/adjtick.c                      | 2 +-
 tools/testing/selftests/timers/alarmtimer-suspend.c           | 2 +-
 tools/testing/selftests/timers/change_skew.c                  | 2 +-
 tools/testing/selftests/timers/clocksource-switch.c           | 2 +-
 tools/testing/selftests/timers/freq-step.c                    | 2 +-
 tools/testing/selftests/timers/inconsistency-check.c          | 2 +-
 tools/testing/selftests/timers/leap-a-day.c                   | 2 +-
 tools/testing/selftests/timers/leapcrash.c                    | 2 +-
 tools/testing/selftests/timers/mqueue-lat.c                   | 2 +-
 tools/testing/selftests/timers/nanosleep.c                    | 2 +-
 tools/testing/selftests/timers/nsleep-lat.c                   | 2 +-
 tools/testing/selftests/timers/posix_timers.c                 | 2 +-
 tools/testing/selftests/timers/raw_skew.c                     | 2 +-
 tools/testing/selftests/timers/rtcpie.c                       | 2 +-
 tools/testing/selftests/timers/set-2038.c                     | 2 +-
 tools/testing/selftests/timers/set-tai.c                      | 2 +-
 tools/testing/selftests/timers/set-timer-lat.c                | 2 +-
 tools/testing/selftests/timers/set-tz.c                       | 2 +-
 tools/testing/selftests/timers/skew_consistency.c             | 2 +-
 tools/testing/selftests/timers/threadtest.c                   | 2 +-
 tools/testing/selftests/timers/valid-adjtimex.c               | 2 +-
 tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c            | 2 +-
 tools/testing/selftests/tty/tty_tstamp_update.c               | 2 +-
 tools/testing/selftests/uevent/uevent_filtering.c             | 2 +-
 tools/testing/selftests/user_events/abi_test.c                | 2 +-
 tools/testing/selftests/user_events/dyn_test.c                | 2 +-
 tools/testing/selftests/user_events/ftrace_test.c             | 2 +-
 tools/testing/selftests/user_events/perf_test.c               | 2 +-
 tools/testing/selftests/user_events/user_events_selftests.h   | 2 +-
 tools/testing/selftests/vDSO/vdso_test_abi.c                  | 2 +-
 tools/testing/selftests/vDSO/vdso_test_chacha.c               | 2 +-
 tools/testing/selftests/vDSO/vdso_test_correctness.c          | 2 +-
 tools/testing/selftests/vDSO/vdso_test_getcpu.c               | 2 +-
 tools/testing/selftests/vDSO/vdso_test_getrandom.c            | 2 +-
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c         | 2 +-
 tools/testing/selftests/vfio/lib/include/vfio_util.h          | 2 +-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c            | 2 +-
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c            | 2 +-
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c          | 2 +-
 tools/testing/selftests/vfio/vfio_iommufd_setup_test.c        | 2 +-
 tools/testing/selftests/vfio/vfio_pci_device_test.c           | 2 +-
 tools/testing/selftests/vfio/vfio_pci_driver_test.c           | 2 +-
 tools/testing/selftests/x86/corrupt_xstate_header.c           | 2 +-
 tools/testing/selftests/x86/helpers.h                         | 2 +-
 tools/testing/selftests/x86/lam.c                             | 2 +-
 tools/testing/selftests/x86/syscall_numbering.c               | 2 +-
 tools/testing/selftests/x86/test_mremap_vdso.c                | 2 +-
 tools/testing/selftests/x86/test_vsyscall.c                   | 2 +-
 tools/testing/selftests/x86/xstate.h                          | 2 +-
 306 files changed, 310 insertions(+), 307 deletions(-)

diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
index 87c044fb9293..421adbdc299d 100644
--- a/tools/testing/selftests/acct/acct_syscall.c
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <sys/wait.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int main(void)
 {
diff --git a/tools/testing/selftests/alsa/conf.c b/tools/testing/selftests/alsa/conf.c
index e2b3a5810f47..5b7c83fe87b3 100644
--- a/tools/testing/selftests/alsa/conf.c
+++ b/tools/testing/selftests/alsa/conf.c
@@ -14,7 +14,7 @@
 #include <regex.h>
 #include <sys/stat.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "alsa-local.h"
 
 #define SYSFS_ROOT "/sys"
diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index e113dafa5c24..d4f845c32804 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -25,7 +25,7 @@
 #include <poll.h>
 #include <stdint.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "alsa-local.h"
 
 #define TESTS_PER_CONTROL 7
diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index ce92548670c8..ee04ccef7d7c 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -17,7 +17,7 @@
 #include <assert.h>
 #include <pthread.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "alsa-local.h"
 
 typedef struct timespec timestamp_t;
diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
index ca81afa4ee90..95065ef3b441 100644
--- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
+++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
@@ -7,7 +7,7 @@
  */
 #include <string.h>
 #include <alsa/asoundlib.h>
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define CH_NUM 4
 
diff --git a/tools/testing/selftests/alsa/utimer-test.c b/tools/testing/selftests/alsa/utimer-test.c
index 37964f311a33..c45cb226bd8f 100644
--- a/tools/testing/selftests/alsa/utimer-test.c
+++ b/tools/testing/selftests/alsa/utimer-test.c
@@ -6,7 +6,7 @@
  *
  * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
  */
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include <sound/asound.h>
 #include <unistd.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 3b96d090c5eb..c41640f18e4e 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -19,7 +19,7 @@
 
 #include <linux/auxvec.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 #define TESTS_PER_HWCAP 3
 
diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
index b51d21f78cf9..0e46ac21c81d 100644
--- a/tools/testing/selftests/arm64/abi/ptrace.c
+++ b/tools/testing/selftests/arm64/abi/ptrace.c
@@ -18,7 +18,7 @@
 #include <asm/sigcontext.h>
 #include <asm/ptrace.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 #define EXPECTED_TESTS 11
 
diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index 5ec9a18ec802..b67e3e26fa6d 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -16,7 +16,7 @@
 #include <asm/sigcontext.h>
 #include <asm/unistd.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 #include "syscall-abi.h"
 
diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index a85c19e9524e..d366934e3d5f 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -27,7 +27,7 @@
 #include <asm/sve_context.h>
 #include <asm/ptrace.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 #include "fp-ptrace.h"
 
diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 9349aa630c84..65e01aba96ff 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -24,7 +24,7 @@
 #include <sys/wait.h>
 #include <asm/hwcap.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 #define MAX_VLS 16
 
diff --git a/tools/testing/selftests/arm64/fp/sve-probe-vls.c b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
index a24eca7a4ecb..df0c1b6eb114 100644
--- a/tools/testing/selftests/arm64/fp/sve-probe-vls.c
+++ b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
@@ -12,7 +12,7 @@
 #include <sys/prctl.h>
 #include <asm/sigcontext.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 #include "rdvl.h"
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index e0fc3a001e28..645c62de0f90 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -19,7 +19,7 @@
 #include <asm/sigcontext.h>
 #include <asm/ptrace.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
 #ifndef NT_ARM_SVE
diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index 2d75d342eeb9..8dd932fdcdc4 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -19,7 +19,7 @@
 #include <asm/sigcontext.h>
 #include <asm/hwcap.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 #include "rdvl.h"
 
 #define ARCH_MIN_VL SVE_VL_MIN
diff --git a/tools/testing/selftests/arm64/fp/za-ptrace.c b/tools/testing/selftests/arm64/fp/za-ptrace.c
index 08c777f87ea2..787eed22d059 100644
--- a/tools/testing/selftests/arm64/fp/za-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/za-ptrace.c
@@ -18,7 +18,7 @@
 #include <asm/sigcontext.h>
 #include <asm/ptrace.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
 #ifndef NT_ARM_ZA
diff --git a/tools/testing/selftests/arm64/fp/zt-ptrace.c b/tools/testing/selftests/arm64/fp/zt-ptrace.c
index a7f34040fbf1..f3fa49fd0fbd 100644
--- a/tools/testing/selftests/arm64/fp/zt-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/zt-ptrace.c
@@ -18,7 +18,7 @@
 #include <asm/sigcontext.h>
 #include <asm/ptrace.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
 #ifndef NT_ARM_ZA
diff --git a/tools/testing/selftests/arm64/gcs/gcs-stress.c b/tools/testing/selftests/arm64/gcs/gcs-stress.c
index cf316d78ea97..86d8cd42aee7 100644
--- a/tools/testing/selftests/arm64/gcs/gcs-stress.c
+++ b/tools/testing/selftests/arm64/gcs/gcs-stress.c
@@ -24,7 +24,7 @@
 #include <sys/wait.h>
 #include <asm/hwcap.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 struct child_data {
 	char *name, *output;
diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
index 6d21b2fc758d..67d138057707 100644
--- a/tools/testing/selftests/arm64/pauth/pac.c
+++ b/tools/testing/selftests/arm64/pauth/pac.c
@@ -10,7 +10,7 @@
 #include <setjmp.h>
 #include <sched.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "helper.h"
 
 #define PAC_COLLISION_ATTEMPTS 1000
diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
index 8ae26e496c89..375ab47f0edb 100644
--- a/tools/testing/selftests/arm64/tags/tags_test.c
+++ b/tools/testing/selftests/arm64/tags/tags_test.c
@@ -6,7 +6,7 @@
 #include <stdint.h>
 #include <sys/prctl.h>
 #include <sys/utsname.h>
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 #define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
 #define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 352adc8df2d1..03ce85870035 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -104,7 +104,7 @@
 #include "xskxceiver.h"
 #include <bpf/bpf.h>
 #include <linux/filter.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "xsk_xdp_common.h"
 
 #include <network_helpers.h>
diff --git a/tools/testing/selftests/breakpoints/breakpoint_test.c b/tools/testing/selftests/breakpoints/breakpoint_test.c
index d46962a24724..1159d81890c2 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 #include <string.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define COUNT_ISN_BPS	4
 #define COUNT_WPS	4
diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index e7041816085a..5fc0f37f3fd4 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -26,7 +26,7 @@
 #include <errno.h>
 #include <signal.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static volatile uint8_t var[96] __attribute__((__aligned__(32)));
 
diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index 8d233ac95696..ca2aaab9e4ca 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -19,7 +19,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 void child(int cpu)
 {
diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index c952640f163b..0258afa6b6a5 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -16,7 +16,7 @@
 #include <fcntl.h>
 #include <errno.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define NR_TESTS	9
 
diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 47bad7ddc5bc..46fc8d46b6e6 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -18,7 +18,7 @@
 #include <sys/prctl.h>
 #include <sys/stat.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static int nerrs;
 static pid_t mpid;	/*  main() pid is used to avoid duplicate test counts */
diff --git a/tools/testing/selftests/capabilities/validate_cap.c b/tools/testing/selftests/capabilities/validate_cap.c
index 65f2a1c89239..cef1d9937b9f 100644
--- a/tools/testing/selftests/capabilities/validate_cap.c
+++ b/tools/testing/selftests/capabilities/validate_cap.c
@@ -7,7 +7,7 @@
 #include <sys/prctl.h>
 #include <sys/auxv.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #if __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 19)
 # define HAVE_GETAUXVAL
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index a360e2eb2eef..5e5b8c4b8c0e 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -17,7 +17,7 @@
 #include <string.h>
 #include <pthread.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "cgroup_util.h"
 
 static bool nsdelegate;
diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 2a60e6c41940..8fe65ccb39c8 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -11,7 +11,7 @@
 #include <time.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "cgroup_util.h"
 
 enum hog_clock_type {
diff --git a/tools/testing/selftests/cgroup/test_cpuset.c b/tools/testing/selftests/cgroup/test_cpuset.c
index 4034d14ba69a..8094091a5857 100644
--- a/tools/testing/selftests/cgroup/test_cpuset.c
+++ b/tools/testing/selftests/cgroup/test_cpuset.c
@@ -3,7 +3,7 @@
 #include <linux/limits.h>
 #include <signal.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "cgroup_util.h"
 
 static int idle_process_fn(const char *cgroup, void *arg)
diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index dfb763819581..714c963aa3f5 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -11,7 +11,7 @@
 #include <string.h>
 #include <sys/wait.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "cgroup_util.h"
 
 #define DEBUG
diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
index 856f9508ea56..f451aa449be6 100644
--- a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
+++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
@@ -7,7 +7,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <fcntl.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "cgroup_util.h"
 
 #define ADDR ((void *)(0x0UL))
diff --git a/tools/testing/selftests/cgroup/test_kill.c b/tools/testing/selftests/cgroup/test_kill.c
index 0e5bb6c7307a..a4dd326ced79 100644
--- a/tools/testing/selftests/cgroup/test_kill.c
+++ b/tools/testing/selftests/cgroup/test_kill.c
@@ -9,7 +9,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "../pidfd/pidfd.h"
 #include "cgroup_util.h"
 
diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 63b3c9aad399..005a142f3492 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -14,7 +14,7 @@
 #include <sys/sysinfo.h>
 #include <pthread.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "cgroup_util.h"
 
 
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index a680f773f2d5..2e9d78ab641c 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 #include <sys/mman.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "cgroup_util.h"
 
 static bool has_localevents;
diff --git a/tools/testing/selftests/cgroup/test_pids.c b/tools/testing/selftests/cgroup/test_pids.c
index d8a1d1cd5007..9a387c815d2c 100644
--- a/tools/testing/selftests/cgroup/test_pids.c
+++ b/tools/testing/selftests/cgroup/test_pids.c
@@ -9,7 +9,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "cgroup_util.h"
 
 static int run_success(const char *cgroup, void *arg)
diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index e1f578ca2841..ab865d900791 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -10,7 +10,7 @@
 #include <sys/wait.h>
 #include <sys/mman.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "cgroup_util.h"
 
 static int read_int(const char *path, size_t *value)
diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e61f07973ce5..289e0c7c1f09 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include <sched.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "clone3_selftests.h"
 
 enum test_mode {
diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 3c196fa86c99..e82281efa273 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -24,7 +24,7 @@
 #include <unistd.h>
 #include <sched.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "clone3_selftests.h"
 
 static void child_exit(int ret)
diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
index ce0426786828..de0c9d62015d 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -13,7 +13,7 @@
 #include <sys/syscall.h>
 #include <sys/wait.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "clone3_selftests.h"
 
 static void nop_handler(int signo)
diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index eeca8005723f..a0593e8950f0 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -11,7 +11,7 @@
 #include <syscall.h>
 #include <sys/wait.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
 
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index bfb0da2b4fdd..5c944aee6b41 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -20,7 +20,7 @@
 #include <unistd.h>
 #include <sched.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "clone3_selftests.h"
 
 #define MAX_PID_NS_LEVEL 32
diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
index 4a825b997666..36c11467a8f1 100644
--- a/tools/testing/selftests/connector/proc_filter.c
+++ b/tools/testing/selftests/connector/proc_filter.c
@@ -16,7 +16,7 @@
 #include <signal.h>
 #include <string.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define NL_MESSAGE_SIZE (sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + \
 			 sizeof(struct proc_input))
diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index e0d9851fe1c9..f14eca63f20c 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -14,7 +14,7 @@
 #include <sys/resource.h>
 #include <linux/close_range.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "../clone3/clone3_selftests.h"
 
 
diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
index 7fec9dfb1b0e..ffce75a6c228 100644
--- a/tools/testing/selftests/core/unshare_test.c
+++ b/tools/testing/selftests/core/unshare_test.c
@@ -14,7 +14,7 @@
 #include <sys/resource.h>
 #include <linux/close_range.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "../clone3/clone3_selftests.h"
 
 TEST(unshare_EMFILE)
diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index a4ac80bb1003..68339f7e6b56 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -19,7 +19,7 @@
 #include <sys/un.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "../filesystems/wrappers.h"
 #include "../pidfd/pidfd.h"
 
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 5d0a809dc2df..fc9694fc4e89 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -15,7 +15,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
 #include <drm/drm.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define DEVPATH "/dev/dma_heap"
 
diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index 77aa2897e79f..d78aec662586 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -16,7 +16,7 @@
 #include <sys/mman.h>
 #include <linux/memfd.h>
 #include <linux/udmabuf.h>
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 #define TEST_PREFIX	"drivers/dma-buf/udmabuf"
 #define NUM_PAGES       4
diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 3aad311574c4..e6a37214aa46 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -12,7 +12,7 @@
 #include <time.h>
 #include <pthread.h>
 #include <linux/ntsync.h>
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static int read_sem_state(int sem, __u32 *count, __u32 *max)
 {
diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
index 7ee7492138c6..14df9aa07308 100644
--- a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
+++ b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
@@ -14,7 +14,7 @@
 
 #include <asm/uvdevice.h>
 
-#include "../../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define UV_PATH  "/dev/uv"
 #define BUFFER_SIZE 0x200
diff --git a/tools/testing/selftests/exec/check-exec.c b/tools/testing/selftests/exec/check-exec.c
index 55bce47e56b7..f2397e75aa7c 100644
--- a/tools/testing/selftests/exec/check-exec.c
+++ b/tools/testing/selftests/exec/check-exec.c
@@ -30,7 +30,7 @@
 #define _ASM_GENERIC_FCNTL_H
 #include <linux/fcntl.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static int sys_execveat(int dirfd, const char *pathname, char *const argv[],
 			char *const envp[], int flags)
diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index 8fb7395fd35b..d37c068ed5fe 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -21,7 +21,7 @@
 #include <string.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define TESTS_EXPECTED 54
 #define TEST_NAME_LEN (PATH_MAX * 4)
diff --git a/tools/testing/selftests/exec/load_address.c b/tools/testing/selftests/exec/load_address.c
index 8257fddba8c8..55fd3732f029 100644
--- a/tools/testing/selftests/exec/load_address.c
+++ b/tools/testing/selftests/exec/load_address.c
@@ -6,7 +6,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdbool.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 struct Statistics {
 	unsigned long long load_address;
diff --git a/tools/testing/selftests/exec/non-regular.c b/tools/testing/selftests/exec/non-regular.c
index cd3a34aca93e..14ac36487df5 100644
--- a/tools/testing/selftests/exec/non-regular.c
+++ b/tools/testing/selftests/exec/non-regular.c
@@ -9,7 +9,7 @@
 #include <sys/sysmacros.h>
 #include <sys/types.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 /* Remove a file, ignoring the result if it didn't exist. */
 void rm(struct __test_metadata *_metadata, const char *pathname,
diff --git a/tools/testing/selftests/exec/null-argv.c b/tools/testing/selftests/exec/null-argv.c
index c19726e710d1..4940aee5bb38 100644
--- a/tools/testing/selftests/exec/null-argv.c
+++ b/tools/testing/selftests/exec/null-argv.c
@@ -5,7 +5,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define FORK(exec)				\
 do {						\
diff --git a/tools/testing/selftests/exec/recursion-depth.c b/tools/testing/selftests/exec/recursion-depth.c
index 438c8ff2fd26..7b5c4f6d1928 100644
--- a/tools/testing/selftests/exec/recursion-depth.c
+++ b/tools/testing/selftests/exec/recursion-depth.c
@@ -23,7 +23,7 @@
 #include <fcntl.h>
 #include <sys/mount.h>
 #include <unistd.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int main(void)
 {
diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
index e0319417124d..e397339495f6 100644
--- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -7,7 +7,7 @@
 #include <syscall.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int sys_fchmodat2(int dfd, const char *filename, mode_t mode, int flags)
 {
diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..ff8d47fc373a 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -6,7 +6,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <string.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static int lock_set(int fd, struct flock *fl)
 {
diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index 73e0a4d4fb2f..94c6c81c2301 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -6,7 +6,7 @@
 #include <stdio.h>
 #include <sys/stat.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "wrappers.h"
 
 TEST(anon_inode_no_chown)
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 39a68078a79b..a1a79a6fef17 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -21,7 +21,7 @@
 #include <linux/android/binder.h>
 #include <linux/android/binderfs.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define DEFAULT_THREADS 4
 
diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index b1fc9b916ace..54fea349204e 100644
--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -11,7 +11,7 @@
 #include <asm/ioctls.h>
 #include <sys/mount.h>
 #include <sys/wait.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static bool terminal_dup2(int duplicate, int original)
 {
diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index 65ede506305c..8bc57a2ef966 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -11,7 +11,7 @@
 #include <sys/epoll.h>
 #include <sys/socket.h>
 #include <sys/eventfd.h>
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 struct epoll_mtcontext
 {
diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
index 72d51ad0ee0e..1b48f267157d 100644
--- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
+++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
@@ -11,7 +11,7 @@
 #include <pthread.h>
 #include <sys/epoll.h>
 #include <sys/eventfd.h>
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define EVENTFD_TEST_ITERATIONS 100000UL
 
diff --git a/tools/testing/selftests/filesystems/fclog.c b/tools/testing/selftests/filesystems/fclog.c
index 912a8b755c3b..551c4a0f395a 100644
--- a/tools/testing/selftests/filesystems/fclog.c
+++ b/tools/testing/selftests/filesystems/fclog.c
@@ -13,7 +13,7 @@
 #include <unistd.h>
 #include <sys/mount.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define ASSERT_ERRNO(expected, _t, seen)				\
 	__EXPECT(expected, #expected,					\
diff --git a/tools/testing/selftests/filesystems/file_stressor.c b/tools/testing/selftests/filesystems/file_stressor.c
index 01dd89f8e52f..141badd671a9 100644
--- a/tools/testing/selftests/filesystems/file_stressor.c
+++ b/tools/testing/selftests/filesystems/file_stressor.c
@@ -12,7 +12,7 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #include <linux/types.h>
 #include <linux/mount.h>
diff --git a/tools/testing/selftests/filesystems/fuse/fusectl_test.c b/tools/testing/selftests/filesystems/fuse/fusectl_test.c
index 8d124d1cacb2..0d1d012c35ed 100644
--- a/tools/testing/selftests/filesystems/fuse/fusectl_test.c
+++ b/tools/testing/selftests/filesystems/fuse/fusectl_test.c
@@ -17,7 +17,7 @@
 #include <sched.h>
 #include <linux/limits.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define FUSECTL_MOUNTPOINT "/sys/fs/fuse/connections"
 #define FUSE_MOUNTPOINT "/tmp/fuse_mnt_XXXXXX"
diff --git a/tools/testing/selftests/filesystems/kernfs_test.c b/tools/testing/selftests/filesystems/kernfs_test.c
index 16538b3b318e..84c2b910a60d 100644
--- a/tools/testing/selftests/filesystems/kernfs_test.c
+++ b/tools/testing/selftests/filesystems/kernfs_test.c
@@ -7,7 +7,7 @@
 #include <sys/stat.h>
 #include <sys/xattr.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "wrappers.h"
 
 TEST(kernfs_listxattr)
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index e4b7c2b457ee..6381af6a40e3 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -19,7 +19,7 @@ typedef struct {
 #include <sys/syscall.h>
 #include <sys/fanotify.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "../statmount/statmount.h"
 #include "../utils.h"
 
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 9f57ca46e3af..320ee25dc8a5 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -19,7 +19,7 @@ typedef struct {
 #include <sys/syscall.h>
 #include <sys/fanotify.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "../statmount/statmount.h"
 #include "../utils.h"
 
diff --git a/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c b/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
index a3d8015897e9..61e55dfbf121 100644
--- a/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
+++ b/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
@@ -12,7 +12,7 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define MNT_NS_COUNT 11
 #define MNT_NS_LAST_INDEX 10
diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index 31db54b00e64..8924cea6aa4b 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -15,7 +15,7 @@
 #include <sched.h>
 #include <fcntl.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 #include "log.h"
 #include "../wrappers.h"
 
diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index dc0449fa628f..3c0b93183348 100644
--- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -12,7 +12,7 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "../../pidfd/pidfd.h"
 #include "log.h"
 #include "../utils.h"
diff --git a/tools/testing/selftests/filesystems/statmount/listmount_test.c b/tools/testing/selftests/filesystems/statmount/listmount_test.c
index 15f0834f7557..8bc82f38c42f 100644
--- a/tools/testing/selftests/filesystems/statmount/listmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/listmount_test.c
@@ -11,7 +11,7 @@
 #include <unistd.h>
 
 #include "statmount.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #ifndef LISTMOUNT_REVERSE
 #define LISTMOUNT_REVERSE    (1 << 0) /* List later mounts first */
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index f048042e53e9..6e53430423d2 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -13,7 +13,7 @@
 #include <linux/stat.h>
 
 #include "statmount.h"
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 static const char *const known_fs[] = {
 	"9p", "adfs", "affs", "afs", "aio", "anon_inodefs", "apparmorfs",
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
index 605a3fa16bf7..d56d4103182f 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
@@ -15,7 +15,7 @@
 
 #include "statmount.h"
 #include "../utils.h"
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 #define NSID_PASS 0
 #define NSID_FAIL 1
diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index c43a69dffd83..b61b7288ed42 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -20,7 +20,7 @@
 #include <sys/xattr.h>
 #include <sys/mount.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "wrappers.h"
 #include "utils.h"
 
diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index d037a3f10ee8..ab8555752137 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -18,7 +18,7 @@
 
 #include "futextest.h"
 #include "futex2test.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define MAX_THREADS	64
 
diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index 3b7b5851f290..e8079d7c65e8 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -14,7 +14,7 @@
 #include <linux/prctl.h>
 #include <sys/prctl.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define MAX_THREADS	64
 
diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
index 69e2555b6039..35d4be23db5d 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -9,7 +9,7 @@
 #include <limits.h>
 
 #include "futextest.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define timeout_ns  30000000
 #define WAKE_WAIT_US 10000
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index f299d75848cd..46d2858e15a8 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -29,7 +29,7 @@
 
 #include "atomic.h"
 #include "futextest.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define MAX_WAKE_ITERS 1000
 #define THREAD_MAX 10
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
index 77135a22a583..f686e605359c 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
@@ -25,7 +25,7 @@
 #include <time.h>
 
 #include "futextest.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 futex_t f1 = FUTEX_INITIALIZER;
 futex_t f2 = FUTEX_INITIALIZER;
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
index e34ee0f9ebcc..a18ccae73eb1 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
@@ -27,7 +27,7 @@
 
 #include "atomic.h"
 #include "futextest.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define DELAY_US 100
 
diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/testing/selftests/futex/functional/futex_wait.c
index 152ca4612886..0e69c53524c1 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -11,7 +11,7 @@
 #include <fcntl.h>
 
 #include "futextest.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define timeout_ns  30000000
 #define WAKE_WAIT_US 10000
diff --git a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
index 8952ebda14ab..2a749f9b14eb 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
@@ -28,7 +28,7 @@
 #include <signal.h>
 
 #include "futextest.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define PAGE_SZ 4096
 
diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index 0c8766aced2e..674dd13af421 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -19,7 +19,7 @@
 
 #include "futextest.h"
 #include "futex2test.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static long timeout_ns = 100000;	/* 100us default timeout */
 static futex_t futex_pi;
diff --git a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
index ce2301500d83..b07d68a67f31 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
@@ -30,7 +30,7 @@
 #include <libgen.h>
 
 #include "futextest.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define WAIT_US 5000000
 
diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 36b7a54a4085..9ff936ecf164 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -24,7 +24,7 @@
 
 #include "futextest.h"
 #include "futex2test.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define timeout_ns 100000
 
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index c684b10eb76e..d60876164d4b 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -18,7 +18,7 @@
 
 #include "futextest.h"
 #include "futex2test.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define WAKE_WAIT_US 10000
 #define NR_FUTEXES 30
diff --git a/tools/testing/selftests/hid/hid_common.h b/tools/testing/selftests/hid/hid_common.h
index 8085519c47cb..e3b267446fa0 100644
--- a/tools/testing/selftests/hid/hid_common.h
+++ b/tools/testing/selftests/hid/hid_common.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2022-2024 Red Hat */
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #include <fcntl.h>
 #include <fnmatch.h>
diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
index a8acf3996973..953b63e5aa6a 100644
--- a/tools/testing/selftests/intel_pstate/aperf.c
+++ b/tools/testing/selftests/intel_pstate/aperf.c
@@ -11,7 +11,7 @@
 #include <errno.h>
 #include <string.h>
 #include <time.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define MSEC_PER_SEC	1000L
 #define NSEC_PER_MSEC	1000000L
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 772ca1db6e59..932c587341e9 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -11,7 +11,7 @@
 #include <assert.h>
 #include <poll.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "../../../../drivers/iommu/iommufd/iommufd_test.h"
 
 /* Hack to make assertions more readable */
diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index 5e36aeeb9901..e107379d185c 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -7,7 +7,7 @@
 #include <sys/msg.h>
 #include <fcntl.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define MAX_MSG_SIZE		32
 
diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index f4a15cbdd5ea..adfcf50b1264 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -23,7 +23,7 @@
 #include <dirent.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define TEST_SCANCODES	10
 #define SYSFS_PATH_MAX 256
diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index d7a8e321bb16..79aa438b7479 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -18,7 +18,7 @@
 #include <sys/wait.h>
 #include <sys/epoll.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static long sys_kcmp(int pid1, int pid2, int type, unsigned long fd1, unsigned long fd2)
 {
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 3f66e862e83e..baae6b7ded41 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -14,7 +14,7 @@
  *
  * .. code-block:: c
  *
- *    #include "../kselftest_harness.h"
+ *    #include "kselftest_harness.h"
  *
  *    TEST(standalone_test) {
  *      do_some_stuff;
diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.c b/tools/testing/selftests/kselftest_harness/harness-selftest.c
index b555493bdb4d..7820bb5d0e6d 100644
--- a/tools/testing/selftests/kselftest_harness/harness-selftest.c
+++ b/tools/testing/selftests/kselftest_harness/harness-selftest.c
@@ -8,7 +8,7 @@
 /* Avoid any inconsistencies */
 #define TH_LOG_STREAM stdout
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static void test_helper(struct __test_metadata *_metadata)
 {
diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 02fd1393947a..44eb433e9666 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -20,7 +20,7 @@
 #include <sys/time.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 9acecae36f51..230b75f6015b 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -17,7 +17,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "wrappers.h"
 
 #define TMP_DIR "tmp"
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index a448fae57831..f02cc8a2e4ae 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -199,6 +199,9 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 # Build with _GNU_SOURCE by default
 CFLAGS += -D_GNU_SOURCE=
 
+# Additional include paths needed by kselftest.h and local headers
+CFLAGS += -I${top_srcdir}/tools/testing/selftests
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
index df215e4aa63f..60caf8528f81 100644
--- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -13,7 +13,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/types.h>
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "common.h"
 
 static struct lsm_ctx *next_ctx(struct lsm_ctx *ctxp)
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
index 1cc8a977c711..54d59044ace1 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -12,7 +12,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/types.h>
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "common.h"
 
 TEST(size_null_lsm_list_modules)
diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
index 732e89fe99c0..dcb6f8aa772e 100644
--- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -12,7 +12,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/types.h>
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "common.h"
 
 TEST(ctx_null_lsm_set_self_attr)
diff --git a/tools/testing/selftests/media_tests/media_device_open.c b/tools/testing/selftests/media_tests/media_device_open.c
index 93183a37b133..4396bf2273a4 100644
--- a/tools/testing/selftests/media_tests/media_device_open.c
+++ b/tools/testing/selftests/media_tests/media_device_open.c
@@ -34,7 +34,7 @@
 #include <sys/stat.h>
 #include <linux/media.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int main(int argc, char **argv)
 {
diff --git a/tools/testing/selftests/media_tests/media_device_test.c b/tools/testing/selftests/media_tests/media_device_test.c
index 4b9953359e40..6e4a8090a0eb 100644
--- a/tools/testing/selftests/media_tests/media_device_test.c
+++ b/tools/testing/selftests/media_tests/media_device_test.c
@@ -39,7 +39,7 @@
 #include <time.h>
 #include <linux/media.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int main(int argc, char **argv)
 {
diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index af89855adb7b..f6d7c44b2288 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -7,7 +7,7 @@
 #include <string.h>
 #include <pthread.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static int registrations;
 
diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 17ed3e9917ca..cdd022c1c497 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -15,8 +15,8 @@
 #include <string.h>
 #include <fcntl.h>
 
-#include "../kselftest.h"
-#include "../kselftest_harness.h"
+#include "kselftest.h"
+#include "kselftest_harness.h"
 
 /* Default test file size: 4MB */
 #define MB (1UL << 20)
diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 9bc4591c7b16..30209c40b697 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -16,7 +16,7 @@
 #include <unistd.h>
 #include <string.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define MAP_SIZE_MB	100
 #define MAP_SIZE	(MAP_SIZE_MB * 1024 * 1024)
diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 6560c26f47d1..accfd198dbda 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -27,7 +27,7 @@
 #endif /* LOCAL_CONFIG_HAVE_LIBURING */
 
 #include "../../../../mm/gup_test.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "vm_util.h"
 #include "thp_settings.h"
 
diff --git a/tools/testing/selftests/mm/droppable.c b/tools/testing/selftests/mm/droppable.c
index f3d9ecf96890..44940f75c461 100644
--- a/tools/testing/selftests/mm/droppable.c
+++ b/tools/testing/selftests/mm/droppable.c
@@ -13,7 +13,7 @@
 #include <sys/mman.h>
 #include <linux/mman.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int main(int argc, char *argv[])
 {
diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 8dd81c0a4a5a..5d65ef054d4e 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #define _GNU_SOURCE
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include <asm-generic/mman.h> /* Force the import of the tools version. */
 #include <assert.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 268dadb8ce43..6279893a0adc 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -27,7 +27,7 @@
 #endif /* LOCAL_CONFIG_HAVE_LIBURING */
 
 #include "../../../../mm/gup_test.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "vm_util.h"
 
 static size_t pagesize;
diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index 8900b840c17a..68eba95b23ff 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -12,7 +12,7 @@
 #include <pthread.h>
 #include <assert.h>
 #include <mm/gup_test.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "vm_util.h"
 
 #define MB (1UL << 20)
diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 15aadaf24a66..ae5a58ff0888 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -10,7 +10,7 @@
  * bugs.
  */
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/mm/hugepage-mmap.c b/tools/testing/selftests/mm/hugepage-mmap.c
index 3b1b532f1cbb..d543419de040 100644
--- a/tools/testing/selftests/mm/hugepage-mmap.c
+++ b/tools/testing/selftests/mm/hugepage-mmap.c
@@ -15,7 +15,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index 2bd1dac75c3f..b8f7d92e5a35 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -24,7 +24,7 @@
 #include <sys/ioctl.h>
 #include <string.h>
 #include <stdbool.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "vm_util.h"
 
 #define DEFAULT_LENGTH_MB 10UL
diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index c5940c0595be..05d9d2805ae4 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -19,7 +19,7 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define MIN_FREE_PAGES	20
 #define NR_HUGE_PAGES	10	/* common number of pages to map/allocate */
diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
index ba6cc6f9cabc..46230462ad48 100644
--- a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
+++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
@@ -11,7 +11,7 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define PREFIX " ... "
 #define ERROR_PREFIX " !!! "
diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/testing/selftests/mm/hugetlb-soft-offline.c
index f086f0e04756..a8bc02688085 100644
--- a/tools/testing/selftests/mm/hugetlb-soft-offline.c
+++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
@@ -24,7 +24,7 @@
 #include <sys/statfs.h>
 #include <sys/types.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #ifndef MADV_SOFT_OFFLINE
 #define MADV_SOFT_OFFLINE 101
diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
index db63abe5ee5e..9ac62eb4c97d 100644
--- a/tools/testing/selftests/mm/hugetlb_dio.c
+++ b/tools/testing/selftests/mm/hugetlb_dio.c
@@ -18,7 +18,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 {
diff --git a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
index e2640529dbb2..b4b257775b74 100644
--- a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
+++ b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
@@ -9,7 +9,7 @@
 #include <signal.h>
 
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define INLOOP_ITER 100
 
diff --git a/tools/testing/selftests/mm/hugetlb_madv_vs_map.c b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
index 8f122a0f0828..efd774b41389 100644
--- a/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
+++ b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
@@ -25,7 +25,7 @@
 #include <unistd.h>
 
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define INLOOP_ITER 100
 
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index ac136f04b8d6..f1fcd9e2e91d 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -21,7 +21,7 @@
 #include <sys/wait.h>
 #include <linux/userfaultfd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "vm_util.h"
 
 #define KiB 1024u
diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index b77462b5c240..a0b48b839d54 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -12,7 +12,7 @@
 #include <stdint.h>
 #include <err.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include <include/vdso/time64.h>
 #include "vm_util.h"
 #include "thp_settings.h"
diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index d8d11bc67ddc..88050e0f829a 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -17,7 +17,7 @@
 #include <linux/mman.h>
 #include <sys/mman.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "vm_util.h"
 
 /*
diff --git a/tools/testing/selftests/mm/map_fixed_noreplace.c b/tools/testing/selftests/mm/map_fixed_noreplace.c
index 1e9980b8993c..11241edde7fe 100644
--- a/tools/testing/selftests/mm/map_fixed_noreplace.c
+++ b/tools/testing/selftests/mm/map_fixed_noreplace.c
@@ -12,7 +12,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static void dump_maps(void)
 {
diff --git a/tools/testing/selftests/mm/map_hugetlb.c b/tools/testing/selftests/mm/map_hugetlb.c
index b47399feab53..aa409107611b 100644
--- a/tools/testing/selftests/mm/map_hugetlb.c
+++ b/tools/testing/selftests/mm/map_hugetlb.c
@@ -11,7 +11,7 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 9df2636c829b..712327f4e932 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -16,7 +16,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #include "vm_util.h"
 
diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index 200bedcdc32e..647779653da0 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -14,7 +14,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #ifndef __aarch64__
 # define PROT_BTI	0
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 9a0597310a76..aac4f795c327 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -22,7 +22,7 @@
 #include <stdio.h>
 #include <fcntl.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define fail(fmt, ...) ksft_test_result_fail(fmt, ##__VA_ARGS__)
 #define pass(fmt, ...) ksft_test_result_pass(fmt, ##__VA_ARGS__)
diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
index cc4253f47f10..363c1033cc7d 100644
--- a/tools/testing/selftests/mm/merge.c
+++ b/tools/testing/selftests/mm/merge.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #define _GNU_SOURCE
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include <linux/prctl.h>
 #include <fcntl.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index ea945eebec2f..ee24b88c2b24 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -4,7 +4,7 @@
  * paths in the kernel.
  */
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "thp_settings.h"
 
 #include <strings.h>
diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
index 09feeb453646..68dd447a5454 100644
--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -22,7 +22,7 @@
 #include <linux/userfaultfd.h>
 #include <linux/mempolicy.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "vm_util.h"
 
 static size_t pagesize;
diff --git a/tools/testing/selftests/mm/mlock-random-test.c b/tools/testing/selftests/mm/mlock-random-test.c
index b8d7e966f44c..9d349c151360 100644
--- a/tools/testing/selftests/mm/mlock-random-test.c
+++ b/tools/testing/selftests/mm/mlock-random-test.c
@@ -13,7 +13,7 @@
 #include <sys/ipc.h>
 #include <sys/shm.h>
 #include <time.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "mlock2.h"
 
 #define CHUNK_UNIT (128 * 1024)
diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
index 3e90ff37e336..b474f2b20def 100644
--- a/tools/testing/selftests/mm/mlock2-tests.c
+++ b/tools/testing/selftests/mm/mlock2-tests.c
@@ -7,7 +7,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <stdbool.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "mlock2.h"
 
 struct vm_boundaries {
diff --git a/tools/testing/selftests/mm/mrelease_test.c b/tools/testing/selftests/mm/mrelease_test.c
index 100370a7111d..64e8d00ae944 100644
--- a/tools/testing/selftests/mm/mrelease_test.c
+++ b/tools/testing/selftests/mm/mrelease_test.c
@@ -12,7 +12,7 @@
 #include <unistd.h>
 #include <asm-generic/unistd.h>
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define MB(x) (x << 20)
 #define MAX_SIZE_MB 1024
diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
index 1d75084b9ca5..a4f75d836733 100644
--- a/tools/testing/selftests/mm/mremap_dontunmap.c
+++ b/tools/testing/selftests/mm/mremap_dontunmap.c
@@ -14,7 +14,7 @@
 #include <string.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 unsigned long page_size;
 char *page_buffer;
diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index bf2863b102e3..a95c0663a011 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -16,7 +16,7 @@
 #include <time.h>
 #include <stdbool.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define EXPECT_SUCCESS 0
 #define EXPECT_FAILURE 1
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 005f29c86484..faad4833366a 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -8,7 +8,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <stdbool.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 #include <syscall.h>
 #include <errno.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/mm/on-fault-limit.c b/tools/testing/selftests/mm/on-fault-limit.c
index 431c1277d83a..fc4117453c84 100644
--- a/tools/testing/selftests/mm/on-fault-limit.c
+++ b/tools/testing/selftests/mm/on-fault-limit.c
@@ -5,7 +5,7 @@
 #include <string.h>
 #include <sys/time.h>
 #include <sys/resource.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static void test_limit(void)
 {
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 4fc8e578ec7c..2cb5441f29c7 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -8,7 +8,7 @@
 #include <errno.h>
 #include <malloc.h>
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 #include <linux/types.h>
 #include <linux/memfd.h>
 #include <linux/userfaultfd.h>
diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
index 88659f0a90ea..f546dfb10cae 100644
--- a/tools/testing/selftests/mm/pfnmap.c
+++ b/tools/testing/selftests/mm/pfnmap.c
@@ -22,7 +22,7 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "vm_util.h"
 
 static sigjmp_buf sigjmp_buf_env;
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index fa15f006fa68..7c29f075e40b 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -16,7 +16,7 @@
 #include <linux/mman.h>
 #include <linux/types.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 /* Define some kernel-like types */
 typedef __u8	u8;
diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index 84b4a4b345af..ca27200596a4 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -13,7 +13,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "thp_settings.h"
 #include "vm_util.h"
 
diff --git a/tools/testing/selftests/mm/process_madv.c b/tools/testing/selftests/mm/process_madv.c
index 471cae8427f1..cd4610baf5d7 100644
--- a/tools/testing/selftests/mm/process_madv.c
+++ b/tools/testing/selftests/mm/process_madv.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #define _GNU_SOURCE
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include <errno.h>
 #include <setjmp.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/mm/rmap.c b/tools/testing/selftests/mm/rmap.c
index 13f7bccfd0a9..53f2058b0ef2 100644
--- a/tools/testing/selftests/mm/rmap.c
+++ b/tools/testing/selftests/mm/rmap.c
@@ -5,7 +5,7 @@
  * Author(s): Wei Yang <richard.weiyang@gmail.com>
  */
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include <strings.h>
 #include <pthread.h>
 #include <numa.h>
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 4ee4db3750c1..cca857219162 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -7,7 +7,7 @@
 #include <malloc.h>
 #include <sys/mman.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "vm_util.h"
 #include "thp_settings.h"
 
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 743af3c05190..40799f3f0213 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -20,7 +20,7 @@
 #include <stdbool.h>
 #include <time.h>
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 uint64_t pagesize;
 unsigned int pageshift;
diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index 4f5e290ff1a6..77813d34dcc2 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -27,7 +27,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #if !defined(MAP_HUGETLB)
 #define MAP_HUGETLB	0x40000
diff --git a/tools/testing/selftests/mm/transhuge-stress.c b/tools/testing/selftests/mm/transhuge-stress.c
index 68201192e37c..bcad47c09518 100644
--- a/tools/testing/selftests/mm/transhuge-stress.c
+++ b/tools/testing/selftests/mm/transhuge-stress.c
@@ -16,7 +16,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int backing_fd = -1;
 int mmap_flags = MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE;
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 37d3ca55905f..844a85ab31eb 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -35,7 +35,7 @@
 #include <sys/random.h>
 #include <stdatomic.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "vm_util.h"
 
 #define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index 4e4a591cf527..17186d4a4147 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -7,7 +7,7 @@
 #include <assert.h>
 #include <linux/mman.h>
 #include <sys/mman.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "thp_settings.h"
 #include "uffd-common.h"
 
diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
index 306eba825107..02f290a69132 100644
--- a/tools/testing/selftests/mm/va_high_addr_switch.c
+++ b/tools/testing/selftests/mm/va_high_addr_switch.c
@@ -10,7 +10,7 @@
 #include <string.h>
 
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 /*
  * The hint addr value is used to allocate addresses
diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 81b33d8f78f4..4f0923825ed7 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -16,7 +16,7 @@
 #include <fcntl.h>
 
 #include "vm_util.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 /*
  * Maximum address range mapped with a single mmap()
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index e33cda301dad..3869e68bb8b5 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -9,7 +9,7 @@
 #include <linux/fs.h>
 #include <sys/syscall.h>
 #include <unistd.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "vm_util.h"
 
 #define PMD_SIZE_FILE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 26c30fdc0241..c787db419fda 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -6,7 +6,7 @@
 #include <stdarg.h>
 #include <strings.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
-#include "../kselftest.h"
+#include "kselftest.h"
 #include <linux/fs.h>
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index a688871a98eb..7aec3ae82a44 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -21,7 +21,7 @@
 #include <linux/mount.h>
 
 #include "../filesystems/wrappers.h"
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #ifndef CLONE_NEWNS
 #define CLONE_NEWNS 0x00020000
diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index bcf51d785a37..12434415ec36 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -15,7 +15,7 @@
 #include <stdarg.h>
 #include <sys/syscall.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #ifndef CLONE_NEWNS
 #define CLONE_NEWNS 0x00020000
diff --git a/tools/testing/selftests/mqueue/mq_open_tests.c b/tools/testing/selftests/mqueue/mq_open_tests.c
index 9403ac01ba11..b16029c40c0f 100644
--- a/tools/testing/selftests/mqueue/mq_open_tests.c
+++ b/tools/testing/selftests/mqueue/mq_open_tests.c
@@ -33,7 +33,7 @@
 #include <mqueue.h>
 #include <error.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static char *usage =
 "Usage:\n"
diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index fb898850867c..303c46eebd94 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -40,7 +40,7 @@
 #include <popt.h>
 #include <error.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static char *usage =
 "Usage:\n"
diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
index 0d2af30c3bf5..cb0ca6ed7ebe 100644
--- a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
+++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
@@ -11,8 +11,8 @@
 #include <string.h>
 #include <stdbool.h>
 
-#include "../kselftest.h"
-#include "../kselftest_harness.h"
+#include "kselftest.h"
+#include "kselftest_harness.h"
 
 #define VMFLAGS "VmFlags:"
 #define MSEAL_FLAGS "sl"
diff --git a/tools/testing/selftests/namespaces/file_handle_test.c b/tools/testing/selftests/namespaces/file_handle_test.c
index f1bc5773f552..064b41ad96b2 100644
--- a/tools/testing/selftests/namespaces/file_handle_test.c
+++ b/tools/testing/selftests/namespaces/file_handle_test.c
@@ -14,7 +14,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <linux/unistd.h>
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #ifndef FD_NSFS_ROOT
 #define FD_NSFS_ROOT -10003 /* Root of the nsfs filesystem */
diff --git a/tools/testing/selftests/namespaces/init_ino_test.c b/tools/testing/selftests/namespaces/init_ino_test.c
index 5b6993c3740b..e4394a2fa0a9 100644
--- a/tools/testing/selftests/namespaces/init_ino_test.c
+++ b/tools/testing/selftests/namespaces/init_ino_test.c
@@ -11,7 +11,7 @@
 #include <string.h>
 #include <linux/nsfs.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 struct ns_info {
 	const char *name;
diff --git a/tools/testing/selftests/namespaces/nsid_test.c b/tools/testing/selftests/namespaces/nsid_test.c
index e28accd74a57..bf02e68e4600 100644
--- a/tools/testing/selftests/namespaces/nsid_test.c
+++ b/tools/testing/selftests/namespaces/nsid_test.c
@@ -18,7 +18,7 @@
 #include <linux/fs.h>
 #include <linux/limits.h>
 #include <linux/nsfs.h>
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 TEST(nsid_mntns_basic)
 {
diff --git a/tools/testing/selftests/nci/nci_dev.c b/tools/testing/selftests/nci/nci_dev.c
index 6dec59d64083..312f84ee0444 100644
--- a/tools/testing/selftests/nci/nci_dev.c
+++ b/tools/testing/selftests/nci/nci_dev.c
@@ -16,7 +16,7 @@
 #include <sys/socket.h>
 #include <linux/nfc.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define GENLMSG_DATA(glh)	((void *)(NLMSG_DATA(glh) + GENL_HDRLEN))
 #define GENLMSG_PAYLOAD(glh)	(NLMSG_PAYLOAD(glh, 0) - GENL_HDRLEN)
diff --git a/tools/testing/selftests/net/af_unix/diag_uid.c b/tools/testing/selftests/net/af_unix/diag_uid.c
index 79a3dd75590e..da7d50cedee6 100644
--- a/tools/testing/selftests/net/af_unix/diag_uid.c
+++ b/tools/testing/selftests/net/af_unix/diag_uid.c
@@ -14,7 +14,7 @@
 #include <sys/types.h>
 #include <sys/un.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 FIXTURE(diag_uid)
 {
diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index b5f474969917..1b499d56656c 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -11,7 +11,7 @@
 #include <sys/signalfd.h>
 #include <sys/socket.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define BUF_SZ	32
 
diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/testing/selftests/net/af_unix/scm_inq.c
index fc467714387e..3a86be9bda17 100644
--- a/tools/testing/selftests/net/af_unix/scm_inq.c
+++ b/tools/testing/selftests/net/af_unix/scm_inq.c
@@ -6,7 +6,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define NR_CHUNKS	100
 #define MSG_LEN		256
diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index ef2921988e5f..2c18b92a2603 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -16,7 +16,7 @@
 #include <sys/wait.h>
 
 #include "../../pidfd/pidfd.h"
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define clean_errno() (errno == 0 ? "None" : strerror(errno))
 #define log_err(MSG, ...)                                                   \
diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index 914f99d153ce..d82a79c21c17 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -10,7 +10,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 FIXTURE(scm_rights)
 {
diff --git a/tools/testing/selftests/net/af_unix/unix_connect.c b/tools/testing/selftests/net/af_unix/unix_connect.c
index d799fd8f5c7c..870ca96fa8ea 100644
--- a/tools/testing/selftests/net/af_unix/unix_connect.c
+++ b/tools/testing/selftests/net/af_unix/unix_connect.c
@@ -10,7 +10,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 FIXTURE(unix_connect)
 {
diff --git a/tools/testing/selftests/net/bind_timewait.c b/tools/testing/selftests/net/bind_timewait.c
index cb9fdf51ea59..40126f9b901e 100644
--- a/tools/testing/selftests/net/bind_timewait.c
+++ b/tools/testing/selftests/net/bind_timewait.c
@@ -4,7 +4,7 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 FIXTURE(bind_timewait)
 {
diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index b7b54d646b93..7d11548b2c61 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -4,7 +4,7 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static const __u32 in4addr_any = INADDR_ANY;
 static const __u32 in4addr_loopback = INADDR_LOOPBACK;
diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
index 4101c36390fd..bb8ae8854273 100644
--- a/tools/testing/selftests/net/can/test_raw_filter.c
+++ b/tools/testing/selftests/net/can/test_raw_filter.c
@@ -19,7 +19,7 @@
 #include <linux/can.h>
 #include <linux/can/raw.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define ID 0x123
 
diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index ded9b925865e..67a72b1a2f3d 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -16,7 +16,7 @@
 #include <linux/udp.h>
 #include <sys/socket.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 enum {
 	ERN_SUCCESS = 0,
diff --git a/tools/testing/selftests/net/epoll_busy_poll.c b/tools/testing/selftests/net/epoll_busy_poll.c
index 16e457c2f877..adf8dd0b5e0b 100644
--- a/tools/testing/selftests/net/epoll_busy_poll.c
+++ b/tools/testing/selftests/net/epoll_busy_poll.c
@@ -23,7 +23,7 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 /* if the headers haven't been updated, we need to define some things */
 #if !defined(EPOLL_IOC_TYPE)
diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 2b1d9f2b3e9e..e87c8b7bdec5 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -57,7 +57,7 @@
 #include <string.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define DPORT 8000
 #define SPORT 1500
diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 29451d2244b7..e6834a6cfc8f 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -10,7 +10,7 @@
 #include <fcntl.h>
 #include <netinet/ip.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #ifndef IP_LOCAL_PORT_RANGE
 #define IP_LOCAL_PORT_RANGE 51
diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 9b44a091802c..0ccf484b1d9d 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -34,7 +34,7 @@
 #include <time.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define printk(fmt, ...)						\
 	ksft_print_msg("%d[%u] " fmt "\n", getpid(), __LINE__, ##__VA_ARGS__)
diff --git a/tools/testing/selftests/net/ipv6_fragmentation.c b/tools/testing/selftests/net/ipv6_fragmentation.c
index 267ef62b5c72..672c9fe086a7 100644
--- a/tools/testing/selftests/net/ipv6_fragmentation.c
+++ b/tools/testing/selftests/net/ipv6_fragmentation.c
@@ -34,7 +34,7 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <unistd.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define MTU 1500
 #define LARGER_THAN_MTU 8192
diff --git a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
index 5f827e10717d..5cecb8a1bc94 100644
--- a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
@@ -10,7 +10,7 @@
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_conntrack.h>
 #include <linux/netfilter/nf_conntrack_tcp.h>
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define TEST_ZONE_ID 123
 #define NF_CT_DEFAULT_ZONE_ID 0
diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 7618ebe528a4..faa4455815f8 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -18,7 +18,7 @@
 #include <linux/mqueue.h>
 #include <linux/rtnetlink.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #include <ynl.h>
 
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 0a5226196a2e..0f3babf19fd0 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -32,7 +32,7 @@
 
 #include <sys/socket.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 /* defines to make checkpatch happy */
 #define strscpy strncpy
diff --git a/tools/testing/selftests/net/proc_net_pktgen.c b/tools/testing/selftests/net/proc_net_pktgen.c
index 69444fb29577..fab3b5c2e25d 100644
--- a/tools/testing/selftests/net/proc_net_pktgen.c
+++ b/tools/testing/selftests/net/proc_net_pktgen.c
@@ -10,7 +10,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static const char ctrl_cmd_stop[] = "stop";
 static const char ctrl_cmd_start[] = "start";
diff --git a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
index 84c524357075..ab8d8b7e6cb0 100644
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -54,7 +54,7 @@
 #include <unistd.h>
 
 #include "psock_lib.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define RING_NUM_FRAMES			20
 
diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 2938045c5cf9..7caf3135448d 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -46,7 +46,7 @@
 
 #include "psock_lib.h"
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #ifndef bug_on
 # define bug_on(cond)		assert(!(cond))
diff --git a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
index 7b9bf8a7bbe1..5aad27a0d13a 100644
--- a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
+++ b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
@@ -22,7 +22,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 struct reuse_opts {
 	int reuseaddr[2];
diff --git a/tools/testing/selftests/net/reuseport_bpf.c b/tools/testing/selftests/net/reuseport_bpf.c
index 65aea27d761c..b6634d6da3d6 100644
--- a/tools/testing/selftests/net/reuseport_bpf.c
+++ b/tools/testing/selftests/net/reuseport_bpf.c
@@ -24,7 +24,7 @@
 #include <sys/resource.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 struct test_params {
 	int recv_family;
diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
index c9ba36aa688e..2ffd957ffb15 100644
--- a/tools/testing/selftests/net/reuseport_bpf_numa.c
+++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
@@ -23,7 +23,7 @@
 #include <unistd.h>
 #include <numa.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static const int PORT = 8888;
 
diff --git a/tools/testing/selftests/net/rxtimestamp.c b/tools/testing/selftests/net/rxtimestamp.c
index 16ac4df55fdb..b81ed0352d6c 100644
--- a/tools/testing/selftests/net/rxtimestamp.c
+++ b/tools/testing/selftests/net/rxtimestamp.c
@@ -18,7 +18,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/errqueue.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 struct options {
 	int so_timestamp;
diff --git a/tools/testing/selftests/net/sk_so_peek_off.c b/tools/testing/selftests/net/sk_so_peek_off.c
index d87dd8d8d491..2a3f5c604f52 100644
--- a/tools/testing/selftests/net/sk_so_peek_off.c
+++ b/tools/testing/selftests/net/sk_so_peek_off.c
@@ -8,7 +8,7 @@
 #include <sys/types.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static char *afstr(int af, int proto)
 {
diff --git a/tools/testing/selftests/net/so_incoming_cpu.c b/tools/testing/selftests/net/so_incoming_cpu.c
index e9fa14e10732..4740701f1a9a 100644
--- a/tools/testing/selftests/net/so_incoming_cpu.c
+++ b/tools/testing/selftests/net/so_incoming_cpu.c
@@ -9,7 +9,7 @@
 #include <sys/socket.h>
 #include <sys/sysinfo.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 FIXTURE(so_incoming_cpu)
 {
diff --git a/tools/testing/selftests/net/socket.c b/tools/testing/selftests/net/socket.c
index be1080003c61..9e270548dad8 100644
--- a/tools/testing/selftests/net/socket.c
+++ b/tools/testing/selftests/net/socket.c
@@ -7,7 +7,7 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 struct socket_testcase {
 	int	domain;
diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index 247c3b3ac1c9..9ec1c9b50e77 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -17,7 +17,7 @@
 #include <linux/virtio_net.h>
 #include <netinet/ip.h>
 #include <netinet/udp.h>
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static const char param_dev_tap_name[] = "xmacvtap0";
 static const char param_dev_dummy_name[] = "xdummy0";
diff --git a/tools/testing/selftests/net/tcp_ao/lib/setup.c b/tools/testing/selftests/net/tcp_ao/lib/setup.c
index a27cc03c9fbd..49aec2922a31 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/setup.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/setup.c
@@ -9,7 +9,7 @@
  * Can't be included in the header: it defines static variables which
  * will be unique to every object. Let's include it only once here.
  */
-#include "../../../kselftest.h"
+#include "kselftest.h"
 
 /* Prevent overriding of one thread's output by another */
 static pthread_mutex_t ksft_print_lock = PTHREAD_MUTEX_INITIALIZER;
diff --git a/tools/testing/selftests/net/tcp_fastopen_backup_key.c b/tools/testing/selftests/net/tcp_fastopen_backup_key.c
index c1cb0c75156a..4b3f9b5e50fe 100644
--- a/tools/testing/selftests/net/tcp_fastopen_backup_key.c
+++ b/tools/testing/selftests/net/tcp_fastopen_backup_key.c
@@ -26,7 +26,7 @@
 #include <fcntl.h>
 #include <time.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #ifndef TCP_FASTOPEN_KEY
 #define TCP_FASTOPEN_KEY 33
diff --git a/tools/testing/selftests/net/tcp_port_share.c b/tools/testing/selftests/net/tcp_port_share.c
index 4c39d599dfce..6146b62610df 100644
--- a/tools/testing/selftests/net/tcp_port_share.c
+++ b/tools/testing/selftests/net/tcp_port_share.c
@@ -10,7 +10,7 @@
 #include <sched.h>
 #include <stdlib.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define DST_PORT 30000
 #define SRC_PORT 40000
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index e788b84551ca..ac2c47da9f7b 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -21,7 +21,7 @@
 #include <sys/socket.h>
 #include <sys/stat.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define TLS_PAYLOAD_MAX_LEN 16384
 #define SOL_TLS 282
diff --git a/tools/testing/selftests/net/toeplitz.c b/tools/testing/selftests/net/toeplitz.c
index 9ba03164d73a..4b58152d5a49 100644
--- a/tools/testing/selftests/net/toeplitz.c
+++ b/tools/testing/selftests/net/toeplitz.c
@@ -52,7 +52,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define TOEPLITZ_KEY_MIN_LEN	40
 #define TOEPLITZ_KEY_MAX_LEN	60
diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..0efc67b0357a 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -15,7 +15,7 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static int tun_attach(int fd, char *dev)
 {
diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index 477392715a9a..86d80cce55b4 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -25,7 +25,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #ifndef ETH_MAX_MTU
 #define ETH_MAX_MTU 0xFFFFU
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index 7056340b9339..510e60602511 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -12,7 +12,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <linux/types.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define ARRAY_LEN(X) (sizeof (X) / sizeof (*(X)))
 #define BUILD_BUG_ON(e) ((void)(sizeof(struct { int:(-!!(e)); })))
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 5790ab446527..0e161ef9e9e4 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -15,7 +15,7 @@
 #include <stdbool.h>
 #include <string.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "helpers.h"
 
 /*
diff --git a/tools/testing/selftests/openat2/rename_attack_test.c b/tools/testing/selftests/openat2/rename_attack_test.c
index 0a770728b436..aa5699e45729 100644
--- a/tools/testing/selftests/openat2/rename_attack_test.c
+++ b/tools/testing/selftests/openat2/rename_attack_test.c
@@ -22,7 +22,7 @@
 #include <limits.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "helpers.h"
 
 /* Construct a test directory with the following structure:
diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
index bbafad440893..a76ef15ceb90 100644
--- a/tools/testing/selftests/openat2/resolve_test.c
+++ b/tools/testing/selftests/openat2/resolve_test.c
@@ -14,7 +14,7 @@
 #include <stdbool.h>
 #include <string.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "helpers.h"
 
 /*
diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index cd9075444c32..23aac6f97061 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -20,7 +20,7 @@
 
 #include "../../../../include/uapi/linux/pcitest.h"
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define pci_ep_ioctl(cmd, arg)			\
 ({						\
diff --git a/tools/testing/selftests/perf_events/mmap.c b/tools/testing/selftests/perf_events/mmap.c
index ea0427aac1f9..d1fa8ec58987 100644
--- a/tools/testing/selftests/perf_events/mmap.c
+++ b/tools/testing/selftests/perf_events/mmap.c
@@ -14,7 +14,7 @@
 
 #include <linux/perf_event.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define RB_SIZE		0x3000
 #define AUX_SIZE	0x10000
diff --git a/tools/testing/selftests/perf_events/remove_on_exec.c b/tools/testing/selftests/perf_events/remove_on_exec.c
index 5814611a1dc7..89e7b06835df 100644
--- a/tools/testing/selftests/perf_events/remove_on_exec.c
+++ b/tools/testing/selftests/perf_events/remove_on_exec.c
@@ -30,7 +30,7 @@
 #include <sys/syscall.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static volatile int signal_count;
 
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index d1d8483ac628..b5cf8355345d 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -31,7 +31,7 @@
 #include <sys/syscall.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define NUM_THREADS 5
 
diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
index b3a72f0ac522..0f64b9b17081 100644
--- a/tools/testing/selftests/perf_events/watermark_signal.c
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -15,7 +15,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static int sigio_count;
 
diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 96f274f0582b..c9519e7385b6 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -13,7 +13,7 @@
 #include <sys/mount.h>
 #include <sys/wait.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "../pidfd/pidfd.h"
 
 #define __STACK_SIZE (8 * 1024 * 1024)
diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 7d84097ad45c..059e7ec5b4fd 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -11,7 +11,7 @@
 #include <syscall.h>
 #include <sys/wait.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "../pidfd/pidfd.h"
 
 /*
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index f87993def738..db80015ab00b 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -25,7 +25,7 @@
 #undef SCHED_FLAG_KEEP_ALL
 #undef SCHED_FLAG_UTIL_CLAMP
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "../clone3/clone3_selftests.h"
 
 #ifndef FD_PIDFS_ROOT
diff --git a/tools/testing/selftests/pidfd/pidfd_bind_mount.c b/tools/testing/selftests/pidfd/pidfd_bind_mount.c
index c094aeb1c620..1fdf49939524 100644
--- a/tools/testing/selftests/pidfd/pidfd_bind_mount.c
+++ b/tools/testing/selftests/pidfd/pidfd_bind_mount.c
@@ -14,7 +14,7 @@
 #include <unistd.h>
 
 #include "pidfd.h"
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "../filesystems/wrappers.h"
 
 FIXTURE(pidfd_bind_mount) {
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f718aac75068..9935e9471c77 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -16,7 +16,7 @@
 #include <sys/mount.h>
 
 #include "pidfd.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 struct error {
 	int  code;
diff --git a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
index 6bd2e9c9565b..68918734dcf3 100644
--- a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
@@ -20,7 +20,7 @@
 #include <sys/stat.h>
 
 #include "pidfd.h"
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 FIXTURE(file_handle)
 {
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..ea45b37001b0 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -19,7 +19,7 @@
 #include <linux/kcmp.h>
 
 #include "pidfd.h"
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 /*
  * UNKNOWN_FD is an fd number that should never exist in the child, as it is
diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index a0eb6e81eaa2..91b216baff07 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -21,7 +21,7 @@
 #include <sys/stat.h>
 
 #include "pidfd.h"
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 FIXTURE(pidfd_info)
 {
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index cd3de40e4977..318e6f09c8e0 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -20,7 +20,7 @@
 #include <unistd.h>
 
 #include "pidfd.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static int safe_int(const char *numstr, int *converted)
 {
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
index 55d74a50358f..232304f818c7 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -14,7 +14,7 @@
 #include <unistd.h>
 
 #include "pidfd.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static bool timeout;
 
diff --git a/tools/testing/selftests/pidfd/pidfd_setattr_test.c b/tools/testing/selftests/pidfd/pidfd_setattr_test.c
index d7de05edc4b3..e8562a2992f3 100644
--- a/tools/testing/selftests/pidfd/pidfd_setattr_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setattr_test.c
@@ -22,7 +22,7 @@
 #include <sys/xattr.h>
 
 #include "pidfd.h"
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 FIXTURE(pidfs_setattr)
 {
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index e6a079b3d5e2..107edecff224 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -18,7 +18,7 @@
 #include <sys/stat.h>
 
 #include "pidfd.h"
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 enum {
 	PIDFD_NS_USER,
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index fcd85cad9f18..932cbd8caa77 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -20,7 +20,7 @@
 #include <unistd.h>
 
 #include "pidfd.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define str(s) _str(s)
 #define _str(s) #s
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 1e2d49751cde..4bf702d62c1c 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -17,7 +17,7 @@
 #include <unistd.h>
 
 #include "pidfd.h"
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
 
diff --git a/tools/testing/selftests/pidfd/pidfd_xattr_test.c b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
index 5cf7bb0e4bf2..fd57511af7e4 100644
--- a/tools/testing/selftests/pidfd/pidfd_xattr_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
@@ -22,7 +22,7 @@
 #include <sys/xattr.h>
 
 #include "pidfd.h"
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 FIXTURE(pidfs_xattr)
 {
diff --git a/tools/testing/selftests/prctl/set-anon-vma-name-test.c b/tools/testing/selftests/prctl/set-anon-vma-name-test.c
index 4275cb256dce..ac6721b184a6 100644
--- a/tools/testing/selftests/prctl/set-anon-vma-name-test.c
+++ b/tools/testing/selftests/prctl/set-anon-vma-name-test.c
@@ -10,7 +10,7 @@
 #include <sys/mman.h>
 #include <string.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define AREA_SIZE 1024
 
diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
index 562f707ba771..3f7b146d36df 100644
--- a/tools/testing/selftests/prctl/set-process-name.c
+++ b/tools/testing/selftests/prctl/set-process-name.c
@@ -7,7 +7,7 @@
 #include <sys/prctl.h>
 #include <string.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define CHANGE_NAME "changename"
 #define EMPTY_NAME ""
diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index a546475db550..a734553718da 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -23,7 +23,7 @@
  *
  */
 #define _GNU_SOURCE
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include <errno.h>
 #include <fcntl.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 978cbcb3eb11..4e6a3e53f975 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -51,7 +51,7 @@
 #define __maybe_unused __attribute__((__unused__))
 #endif
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static inline long sys_execveat(int dirfd, const char *pathname, char **argv, char **envp, int flags)
 {
diff --git a/tools/testing/selftests/proc/proc-pidns.c b/tools/testing/selftests/proc/proc-pidns.c
index 52500597f951..25b9a2933c45 100644
--- a/tools/testing/selftests/proc/proc-pidns.c
+++ b/tools/testing/selftests/proc/proc-pidns.c
@@ -16,7 +16,7 @@
 #include <sys/stat.h>
 #include <sys/prctl.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define ASSERT_ERRNO(expected, _t, seen)				\
 	__EXPECT(expected, #expected,					\
diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
index 5297b10d25c3..2e619c7599bb 100644
--- a/tools/testing/selftests/ptrace/get_set_sud.c
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/ptrace/get_syscall_info.c b/tools/testing/selftests/ptrace/get_syscall_info.c
index 5bcd1c7b5be6..3f5c3a9fdaba 100644
--- a/tools/testing/selftests/ptrace/get_syscall_info.c
+++ b/tools/testing/selftests/ptrace/get_syscall_info.c
@@ -7,7 +7,7 @@
  * matches userspace expectations.
  */
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include <err.h>
 #include <signal.h>
 #include <asm/unistd.h>
diff --git a/tools/testing/selftests/ptrace/set_syscall_info.c b/tools/testing/selftests/ptrace/set_syscall_info.c
index 4198248ef874..1cc411a41cd6 100644
--- a/tools/testing/selftests/ptrace/set_syscall_info.c
+++ b/tools/testing/selftests/ptrace/set_syscall_info.c
@@ -7,7 +7,7 @@
  * matches userspace expectations.
  */
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include <err.h>
 #include <fcntl.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
index 4db327b44586..3801b5831527 100644
--- a/tools/testing/selftests/ptrace/vmaccess.c
+++ b/tools/testing/selftests/ptrace/vmaccess.c
@@ -7,7 +7,7 @@
  * when de_thread is blocked with ->cred_guard_mutex held.
  */
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include <stdio.h>
 #include <fcntl.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index cd3adfc14969..3c51bdac2dfa 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -23,7 +23,7 @@
 #include <asm/unistd.h>
 #include <linux/perf_event.h>
 #include <linux/compiler.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define MB			(1024 * 1024)
 #define RESCTRL_PATH		"/sys/fs/resctrl"
diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index a58f520f2f41..f24677737066 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -17,7 +17,7 @@
 #include <sys/ioctl.h>
 
 #include "../user_events/user_events_selftests.h" /* share tracefs setup */
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define TRACEFS_ROOT "/sys/kernel/tracing"
 
diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
index 059d2e87eb1f..2d540af7b558 100644
--- a/tools/testing/selftests/riscv/abi/pointer_masking.c
+++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
@@ -9,7 +9,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 #ifndef PR_PMLEN_SHIFT
 #define PR_PMLEN_SHIFT			24
diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index 5e96ef785d0d..f5208ca80905 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -17,7 +17,7 @@
 #include <asm/ucontext.h>
 
 #include "hwprobe.h"
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 #define MK_CBO(fn) le32_bswap((uint32_t)(fn) << 20 | 10 << 15 | 2 << 12 | 0 << 7 | 15)
 
diff --git a/tools/testing/selftests/riscv/hwprobe/hwprobe.c b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
index fd73c87804f3..54c435af9923 100644
--- a/tools/testing/selftests/riscv/hwprobe/hwprobe.c
+++ b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "hwprobe.h"
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 int main(int argc, char **argv)
 {
diff --git a/tools/testing/selftests/riscv/hwprobe/which-cpus.c b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
index 82c121412dfc..3ab53067e8dd 100644
--- a/tools/testing/selftests/riscv/hwprobe/which-cpus.c
+++ b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
@@ -14,7 +14,7 @@
 #include <assert.h>
 
 #include "hwprobe.h"
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 static void help(void)
 {
diff --git a/tools/testing/selftests/riscv/mm/mmap_bottomup.c b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
index f9ccae50349b..461a65c9be00 100644
--- a/tools/testing/selftests/riscv/mm/mmap_bottomup.c
+++ b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
@@ -2,7 +2,7 @@
 #include <sys/mman.h>
 #include <mmap_test.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 TEST(infinite_rlimit)
 {
diff --git a/tools/testing/selftests/riscv/mm/mmap_default.c b/tools/testing/selftests/riscv/mm/mmap_default.c
index 3f53b6ecc326..58db7d172af2 100644
--- a/tools/testing/selftests/riscv/mm/mmap_default.c
+++ b/tools/testing/selftests/riscv/mm/mmap_default.c
@@ -2,7 +2,7 @@
 #include <sys/mman.h>
 #include <mmap_test.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 TEST(default_rlimit)
 {
diff --git a/tools/testing/selftests/riscv/mm/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
index 75918d15919f..266a6becdeba 100644
--- a/tools/testing/selftests/riscv/mm/mmap_test.h
+++ b/tools/testing/selftests/riscv/mm/mmap_test.h
@@ -5,7 +5,7 @@
 #include <sys/resource.h>
 #include <stddef.h>
 #include <strings.h>
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define TOP_DOWN 0
 #define BOTTOM_UP 1
diff --git a/tools/testing/selftests/riscv/sigreturn/sigreturn.c b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
index ed351a1cb917..e10873d95fed 100644
--- a/tools/testing/selftests/riscv/sigreturn/sigreturn.c
+++ b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
@@ -4,7 +4,7 @@
 #include <stdlib.h>
 #include <ucontext.h>
 #include <linux/ptrace.h>
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define RISCV_V_MAGIC		0x53465457
 #define DEFAULT_VALUE		2
diff --git a/tools/testing/selftests/riscv/vector/v_initval.c b/tools/testing/selftests/riscv/vector/v_initval.c
index be9e1d18ad29..5fd2382e15a2 100644
--- a/tools/testing/selftests/riscv/vector/v_initval.c
+++ b/tools/testing/selftests/riscv/vector/v_initval.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "v_helpers.h"
 
 #define NEXT_PROGRAM "./v_exec_initval_nolibc"
diff --git a/tools/testing/selftests/riscv/vector/vstate_prctl.c b/tools/testing/selftests/riscv/vector/vstate_prctl.c
index 62fbb17a0556..d607af3900c1 100644
--- a/tools/testing/selftests/riscv/vector/vstate_prctl.c
+++ b/tools/testing/selftests/riscv/vector/vstate_prctl.c
@@ -6,7 +6,7 @@
 #include <sys/types.h>
 #include <stdlib.h>
 
-#include "../../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "v_helpers.h"
 
 #define NEXT_PROGRAM "./vstate_exec_nolibc"
diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index 2348d2c20d0a..1193612bf327 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <stddef.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "rseq.h"
 
 #ifdef BUILDOPT_RSEQ_PERCPU_MM_CID
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index dcac5cbe7933..a736727b83c1 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -33,7 +33,7 @@
 
 #include <linux/compiler.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "rseq.h"
 
 /*
diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index be175c0e6ae3..8047d9879039 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -16,7 +16,7 @@
 #include <time.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define NUM_UIE 3
 #define ALARM_DELTA 3
diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 5822e25e0217..ea4068cdefd6 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -20,7 +20,7 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 unsigned long long timing(clockid_t clk_id, unsigned long long samples)
 {
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..32e2d4df397b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -54,7 +54,7 @@
 #include <sys/syscall.h>
 #include <poll.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "../clone3/clone3_selftests.h"
 
 /* Attempt to de-conflict with the selftests tree. */
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 9820b3809c69..13b84e54ce38 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -18,7 +18,7 @@
 #include <sys/types.h>
 #include <sys/auxv.h>
 #include "defines.h"
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "main.h"
 
 static const uint64_t MAGIC = 0x1122334455667788ULL;
diff --git a/tools/testing/selftests/signal/mangle_uc_sigmask.c b/tools/testing/selftests/signal/mangle_uc_sigmask.c
index b79ab92178a8..11dbc14bbc8e 100644
--- a/tools/testing/selftests/signal/mangle_uc_sigmask.c
+++ b/tools/testing/selftests/signal/mangle_uc_sigmask.c
@@ -39,7 +39,7 @@
 #include <signal.h>
 #include <ucontext.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 void handler_verify_ucontext(int signo, siginfo_t *info, void *uc)
 {
diff --git a/tools/testing/selftests/signal/sas.c b/tools/testing/selftests/signal/sas.c
index 07227fab1cc9..306b996ab365 100644
--- a/tools/testing/selftests/signal/sas.c
+++ b/tools/testing/selftests/signal/sas.c
@@ -19,7 +19,7 @@
 #include <errno.h>
 #include <sys/auxv.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "current_stack_pointer.h"
 
 #ifndef SS_AUTODISARM
diff --git a/tools/testing/selftests/sparc64/drivers/adi-test.c b/tools/testing/selftests/sparc64/drivers/adi-test.c
index 84e5d9fd20b0..b986714e7a52 100644
--- a/tools/testing/selftests/sparc64/drivers/adi-test.c
+++ b/tools/testing/selftests/sparc64/drivers/adi-test.c
@@ -16,7 +16,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 
-#include "../../kselftest.h"
+#include "kselftest.h"
 
 #define DEBUG_LEVEL_1_BIT	(0x0001)
 #define DEBUG_LEVEL_2_BIT	(0x0002)
diff --git a/tools/testing/selftests/sync/sync_test.c b/tools/testing/selftests/sync/sync_test.c
index 93db5aa246a3..2b44e5d88b63 100644
--- a/tools/testing/selftests/sync/sync_test.c
+++ b/tools/testing/selftests/sync/sync_test.c
@@ -34,7 +34,7 @@
 #include <errno.h>
 #include <string.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "synctest.h"
 
 static int run_test(int (*test)(void), char *name)
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index 2eb2c06303f2..b855c6000287 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -14,7 +14,7 @@
 #include <stdlib.h>
 
 #include <asm/unistd.h>
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #ifndef PR_SET_SYSCALL_USER_DISPATCH
 # define PR_SET_SYSCALL_USER_DISPATCH	59
diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing/selftests/tdx/tdx_guest_test.c
index 81d8cb88ea1a..dfaefa685519 100644
--- a/tools/testing/selftests/tdx/tdx_guest_test.c
+++ b/tools/testing/selftests/tdx/tdx_guest_test.c
@@ -13,7 +13,7 @@
 #include <fcntl.h>
 
 #include <linux/tdx-guest.h>
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define TDX_GUEST_DEVNAME "/dev/tdx_guest"
 #define HEX_DUMP_SIZE 8
diff --git a/tools/testing/selftests/timens/timens.h b/tools/testing/selftests/timens/timens.h
index d4fc52d47146..7ca4b46ca61d 100644
--- a/tools/testing/selftests/timens/timens.h
+++ b/tools/testing/selftests/timens/timens.h
@@ -7,7 +7,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #ifndef CLONE_NEWTIME
 # define CLONE_NEWTIME	0x00000080
diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index 777d9494b683..5b3ef708d6e9 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -24,7 +24,7 @@
 #include <time.h>
 #include <include/vdso/time64.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define MILLION			1000000
 
diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index a9ef76ea6051..aa66c805f6a4 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -30,7 +30,7 @@
 #include <pthread.h>
 #include <include/vdso/time64.h>
 #include <errno.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define UNREASONABLE_LAT (NSEC_PER_SEC * 5) /* hopefully we resume in 5 secs */
 
diff --git a/tools/testing/selftests/timers/change_skew.c b/tools/testing/selftests/timers/change_skew.c
index 18e794a46c23..387fda10fcd8 100644
--- a/tools/testing/selftests/timers/change_skew.c
+++ b/tools/testing/selftests/timers/change_skew.c
@@ -28,7 +28,7 @@
 #include <sys/time.h>
 #include <sys/timex.h>
 #include <time.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int change_skew_test(int ppm)
 {
diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index 83faa4e354e3..db62a764c29e 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -34,7 +34,7 @@
 #include <sys/wait.h>
 #include <time.h>
 #include <unistd.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 
 int get_clocksources(char list[][30])
diff --git a/tools/testing/selftests/timers/freq-step.c b/tools/testing/selftests/timers/freq-step.c
index 73b636f89fdc..cfa46dafe3e8 100644
--- a/tools/testing/selftests/timers/freq-step.c
+++ b/tools/testing/selftests/timers/freq-step.c
@@ -15,7 +15,7 @@
 #include <time.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define SAMPLES 100
 #define SAMPLE_READINGS 10
diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/testing/selftests/timers/inconsistency-check.c
index 9d1573769d55..e53e63e18683 100644
--- a/tools/testing/selftests/timers/inconsistency-check.c
+++ b/tools/testing/selftests/timers/inconsistency-check.c
@@ -29,7 +29,7 @@
 #include <string.h>
 #include <signal.h>
 #include <include/vdso/time64.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 /* CLOCK_HWSPECIFIC == CLOCK_SGI_CYCLE (Deprecated) */
 #define CLOCK_HWSPECIFIC		10
diff --git a/tools/testing/selftests/timers/leap-a-day.c b/tools/testing/selftests/timers/leap-a-day.c
index 04004a7c0934..3568cfb3e815 100644
--- a/tools/testing/selftests/timers/leap-a-day.c
+++ b/tools/testing/selftests/timers/leap-a-day.c
@@ -49,7 +49,7 @@
 #include <signal.h>
 #include <unistd.h>
 #include <include/vdso/time64.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define CLOCK_TAI 11
 
diff --git a/tools/testing/selftests/timers/leapcrash.c b/tools/testing/selftests/timers/leapcrash.c
index 8fd065eec904..c2d3bccb52f2 100644
--- a/tools/testing/selftests/timers/leapcrash.c
+++ b/tools/testing/selftests/timers/leapcrash.c
@@ -22,7 +22,7 @@
 #include <sys/timex.h>
 #include <string.h>
 #include <signal.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 /* clear NTP time_status & time_state */
 int clear_time_state(void)
diff --git a/tools/testing/selftests/timers/mqueue-lat.c b/tools/testing/selftests/timers/mqueue-lat.c
index 63de2334a291..c0d9368e4fca 100644
--- a/tools/testing/selftests/timers/mqueue-lat.c
+++ b/tools/testing/selftests/timers/mqueue-lat.c
@@ -30,7 +30,7 @@
 #include <errno.h>
 #include <mqueue.h>
 #include <include/vdso/time64.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 
 #define TARGET_TIMEOUT		100000000	/* 100ms in nanoseconds */
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 252c6308c569..7a29913aaf03 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -28,7 +28,7 @@
 #include <string.h>
 #include <signal.h>
 #include <include/vdso/time64.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 /* CLOCK_HWSPECIFIC == CLOCK_SGI_CYCLE (Deprecated) */
 #define CLOCK_HWSPECIFIC		10
diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index de23dc0c9f97..a7ba1eb1e21b 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -25,7 +25,7 @@
 #include <string.h>
 #include <signal.h>
 #include <include/vdso/time64.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define UNRESONABLE_LATENCY 40000000 /* 40ms in nanosecs */
 
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index f0eceb0faf34..5cbb3e81f35d 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -19,7 +19,7 @@
 #include <include/vdso/time64.h>
 #include <pthread.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define DELAY 2
 
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index 957f7cd29cb1..a7bae7d80916 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -26,7 +26,7 @@
 #include <sys/timex.h>
 #include <time.h>
 #include <include/vdso/time64.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define shift_right(x, s) ({		\
 	__typeof__(x) __x = (x);	\
diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
index 7c07edd0d450..4ba42d198b7e 100644
--- a/tools/testing/selftests/timers/rtcpie.c
+++ b/tools/testing/selftests/timers/rtcpie.c
@@ -18,7 +18,7 @@
 #include <stdlib.h>
 #include <errno.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 /*
  * This expects the new RTC class driver framework, working with
diff --git a/tools/testing/selftests/timers/set-2038.c b/tools/testing/selftests/timers/set-2038.c
index ed244315e11c..ecc171de4728 100644
--- a/tools/testing/selftests/timers/set-2038.c
+++ b/tools/testing/selftests/timers/set-2038.c
@@ -28,7 +28,7 @@
 #include <time.h>
 #include <sys/time.h>
 #include <include/vdso/time64.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define KTIME_MAX	((long long)~((unsigned long long)1 << 63))
 #define KTIME_SEC_MAX	(KTIME_MAX / NSEC_PER_SEC)
diff --git a/tools/testing/selftests/timers/set-tai.c b/tools/testing/selftests/timers/set-tai.c
index 5b67462efcd6..e283c04284af 100644
--- a/tools/testing/selftests/timers/set-tai.c
+++ b/tools/testing/selftests/timers/set-tai.c
@@ -23,7 +23,7 @@
 #include <string.h>
 #include <signal.h>
 #include <unistd.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int set_tai(int offset)
 {
diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 9d8437c13929..44d2e3614fa5 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -29,7 +29,7 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <include/vdso/time64.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 /* CLOCK_HWSPECIFIC == CLOCK_SGI_CYCLE (Deprecated) */
 #define CLOCK_HWSPECIFIC		10
diff --git a/tools/testing/selftests/timers/set-tz.c b/tools/testing/selftests/timers/set-tz.c
index 20daaf1782b7..334f36c0eda6 100644
--- a/tools/testing/selftests/timers/set-tz.c
+++ b/tools/testing/selftests/timers/set-tz.c
@@ -23,7 +23,7 @@
 #include <string.h>
 #include <signal.h>
 #include <unistd.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int set_tz(int min, int dst)
 {
diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 46c391d7f45d..53ee5d710ff4 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -34,7 +34,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include <sys/wait.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int main(int argc, char **argv)
 {
diff --git a/tools/testing/selftests/timers/threadtest.c b/tools/testing/selftests/timers/threadtest.c
index d5564bbf0e50..60b8b21bf782 100644
--- a/tools/testing/selftests/timers/threadtest.c
+++ b/tools/testing/selftests/timers/threadtest.c
@@ -21,7 +21,7 @@
 #include <stdlib.h>
 #include <sys/time.h>
 #include <pthread.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 /* serializes shared list access */
 pthread_mutex_t list_lock = PTHREAD_MUTEX_INITIALIZER;
diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 6b7801055ad1..e1e56d3097d6 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -30,7 +30,7 @@
 #include <signal.h>
 #include <unistd.h>
 #include <include/vdso/time64.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define ADJ_SETOFFSET 0x0100
 
diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index 02ecfe687dc2..5cb4e404a2bd 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -23,7 +23,7 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 int main(void)
 {
diff --git a/tools/testing/selftests/tty/tty_tstamp_update.c b/tools/testing/selftests/tty/tty_tstamp_update.c
index 9e1a40f5db17..bc3291dcd18b 100644
--- a/tools/testing/selftests/tty/tty_tstamp_update.c
+++ b/tools/testing/selftests/tty/tty_tstamp_update.c
@@ -9,7 +9,7 @@
 #include <unistd.h>
 #include <linux/limits.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define MIN_TTY_PATH_LEN 8
 
diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index dbe55f3a66f4..974b076f9235 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -19,7 +19,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 #define __DEV_FULL "/sys/devices/virtual/mem/full/uevent"
 #define __UEVENT_BUFFER_SIZE (2048 * 2)
diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 7288a05136ba..85892b3b719c 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -20,7 +20,7 @@
 #include <string.h>
 #include <asm/unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "user_events_selftests.h"
 
 const char *data_file = "/sys/kernel/tracing/user_events_data";
diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index 54c9412f8dee..78e3c33f4015 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -14,7 +14,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "user_events_selftests.h"
 
 const char *dyn_file = "/sys/kernel/tracing/dynamic_events";
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 0bb46793dcd4..decce06b9ba8 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -15,7 +15,7 @@
 #include <sys/uio.h>
 #include <unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "user_events_selftests.h"
 
 const char *data_file = "/sys/kernel/tracing/user_events_data";
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 5288e768b207..201459d8094d 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -16,7 +16,7 @@
 #include <unistd.h>
 #include <asm/unistd.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 #include "user_events_selftests.h"
 
 const char *data_file = "/sys/kernel/tracing/user_events_data";
diff --git a/tools/testing/selftests/user_events/user_events_selftests.h b/tools/testing/selftests/user_events/user_events_selftests.h
index e1c3c063c031..3b5d37e46f8a 100644
--- a/tools/testing/selftests/user_events/user_events_selftests.h
+++ b/tools/testing/selftests/user_events/user_events_selftests.h
@@ -9,7 +9,7 @@
 #include <unistd.h>
 #include <errno.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static inline void tracefs_unmount(void)
 {
diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 238d609a457a..c620317eaeea 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "vdso_config.h"
 #include "vdso_call.h"
 #include "parse_vdso.h"
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index 0aad682b12c8..9a5c9c05e09c 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -10,7 +10,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <stdbool.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #if defined(__aarch64__)
 static bool cpu_has_capabilities(void)
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index da651cf53c6c..055af95aa552 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -21,7 +21,7 @@
 
 #include "vdso_config.h"
 #include "vdso_call.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static const char **name;
 
diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
index cdeaed45fb26..bea8ad54da11 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -11,7 +11,7 @@
 #include <sys/auxv.h>
 #include <sys/time.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "parse_vdso.h"
 #include "vdso_config.h"
 #include "vdso_call.h"
diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index dd1132508a0d..ef402001e898 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -23,7 +23,7 @@
 #include <linux/random.h>
 #include <linux/ptrace.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "parse_vdso.h"
 #include "vdso_config.h"
 #include "vdso_call.h"
diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index 9ce795b806f0..912edadad92c 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -16,7 +16,7 @@
 #include <sys/time.h>
 #endif
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "parse_vdso.h"
 #include "vdso_config.h"
 #include "vdso_call.h"
diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index ed31606e01b7..665c8ed5725d 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -8,7 +8,7 @@
 #include <linux/list.h>
 #include <linux/pci_regs.h>
 
-#include "../../../kselftest.h"
+#include "kselftest.h"
 
 #define VFIO_LOG_AND_EXIT(...) do {		\
 	fprintf(stderr, "  " __VA_ARGS__);	\
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 0921b2451ba5..c15cc743f179 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -17,7 +17,7 @@
 #include <linux/vfio.h>
 #include <linux/iommufd.h>
 
-#include "../../../kselftest.h"
+#include "kselftest.h"
 #include <vfio_util.h>
 
 #define PCI_SYSFS_PATH	"/sys/bus/pci/devices"
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index e5e8723ecb41..fb958d895c17 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <stdio.h>
 
-#include "../../../kselftest.h"
+#include "kselftest.h"
 #include <vfio_util.h>
 
 #ifdef __x86_64__
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index ab19c54a774d..1740321f5e4d 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -10,7 +10,7 @@
 
 #include <vfio_util.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static const char *device_bdf;
 
diff --git a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
index 3655106b912d..6854a9dedff3 100644
--- a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
+++ b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
@@ -11,7 +11,7 @@
 #include <unistd.h>
 
 #include <vfio_util.h>
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static const char iommu_dev_path[] = "/dev/iommu";
 static const char *cdev_path;
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 7a270698e4d2..164c5f4b3903 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -12,7 +12,7 @@
 
 #include <vfio_util.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static const char *device_bdf;
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 2dbd70b7db62..d962fd77987a 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -7,7 +7,7 @@
 
 #include <vfio_util.h>
 
-#include "../kselftest_harness.h"
+#include "kselftest_harness.h"
 
 static const char *device_bdf;
 
diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
index 93a89a5997ca..f4d67b050275 100644
--- a/tools/testing/selftests/x86/corrupt_xstate_header.c
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -17,7 +17,7 @@
 #include <stdint.h>
 #include <sys/wait.h>
 
-#include "../kselftest.h" /* For __cpuid_count() */
+#include "kselftest.h" /* For __cpuid_count() */
 #include "helpers.h"
 
 static inline int xsave_enabled(void)
diff --git a/tools/testing/selftests/x86/helpers.h b/tools/testing/selftests/x86/helpers.h
index 6deaad035161..4c747a1278d9 100644
--- a/tools/testing/selftests/x86/helpers.h
+++ b/tools/testing/selftests/x86/helpers.h
@@ -7,7 +7,7 @@
 
 #include <asm/processor-flags.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 static inline unsigned long get_eflags(void)
 {
diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0873b0e5f48b..1919fa6daec0 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -18,7 +18,7 @@
 
 #include <sys/uio.h>
 #include <linux/io_uring.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #ifndef __x86_64__
 # error This test is 64-bit only
diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
index 41c42b7b54a6..ca0eca7b9dce 100644
--- a/tools/testing/selftests/x86/syscall_numbering.c
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -25,7 +25,7 @@
 #include <sys/mman.h>
 
 #include <linux/ptrace.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 /* Common system call numbers */
 #define SYS_READ	  0
diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
index 94bee6e0c813..a5edf6c5f17e 100644
--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -20,7 +20,7 @@
 #include <sys/auxv.h>
 #include <sys/syscall.h>
 #include <sys/wait.h>
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define PAGE_SIZE	4096
 
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 05e1e6774fba..de55bb0992b2 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -21,7 +21,7 @@
 #include <sys/uio.h>
 
 #include "helpers.h"
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #ifdef __x86_64__
 #define TOTAL_TESTS 13
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index e91e3092b5d2..6ee816e7625a 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -4,7 +4,7 @@
 
 #include <stdint.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #define XSAVE_HDR_OFFSET	512
 #define XSAVE_HDR_SIZE		64
-- 
2.43.0


