Return-Path: <linux-kselftest+bounces-40359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E36B3CD33
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 18:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF243AD064
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFF72459C8;
	Sat, 30 Aug 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiygzKf+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CD3D81;
	Sat, 30 Aug 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756572005; cv=none; b=u5olPE4ra/H3MxWxwipP9y5zOZenVjzOB+ZLgj+SygVIoHkP4QrX8cntT3oDfBG8yhJi07SPIfC+4KuXVGQ8niFrRAemqNu3V1hMu1LUXq0ZeNMI82zB7WTpIFJNCMlCMdmmsDNDANcyzLEZbsek/KDfPgYG9v+b/5u60W2YAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756572005; c=relaxed/simple;
	bh=VY5EGysWxYRXKaO4Uc9O5D9U1rkmcEVpcHP5BrHc9rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajMIN49PHNVGjQlyh83FuDFe3yyVf5O5E2o3K/tnM6SFqQGtozyAELxdpJ+rKWRsGmnPzM1I6hMc7N8E1mq+B9xZ09WEpCVm6YnZBVbZNDKA2AsAshVzn2ClbnTOLW1ObNq7dfk3xEgStFVHFqkAxcndj3kTHKnFNybJ20HetAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiygzKf+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-248c676a2eeso21125375ad.2;
        Sat, 30 Aug 2025 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756572002; x=1757176802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omIq/jRweSA2RXSesekY4OTDGwBK1jNfbMwnq5InzPE=;
        b=PiygzKf+bb+f2byy1/8urr1o73RqWkk/McE8/7hHR1AiEWkxTZFrfXRlS175sOEyK2
         dxpuYz3mgVl8Ot21GM7CQroAXDQ375H/SeW7aKvdctRymDCE7I4xSra6I53zr+O2lTDh
         uF6CCHNPnsqFdCkSiBnXIIdOfPz7Hf00N76OkJwSI+1WuKRk6XbYjtD025gGRzWXSK9w
         GZrQUng18HEWLHY6uDccmYDMW6Fcr9ck2fGdmwiW72qWmy0zNuExPyTgQP4iyjDskH/0
         Z0RFlb657j8skloGrFlxd3Ng83dYCgHV1qFOg+eS1yWGwVh2HPdMl2htM/c2yErtHdNQ
         Vsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756572002; x=1757176802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omIq/jRweSA2RXSesekY4OTDGwBK1jNfbMwnq5InzPE=;
        b=UtwBU6IG6Khk5CMmWxx3opDK+0AlAHmuMZFJQzRqFTnqrmc/a1cc5kasAJ7m2IbAOS
         B4A3xYLT2uOMZzS9uT4+KUV+OyEfWszKd9UW207ys4hRLJ7lUytvek6R8+R57k2joHwc
         9QEGEULYfDpF8EMumCLm+iRk3DcOgU7EnfoiQOGzf9ZUbkWHMOJZqYIlYUbNlvJ8/SmA
         madQRqPTYJeO0IFce8KBputyqDl1KeHYe/4TyxEFR1l/Y9l4YNiWQ8OuzNkjFWVJXDQM
         UpP0IRo0l3uRWtGChFZ82OtEj87hvwmwBVwqHM6DXzU+BTIq0y+WIzs6xs+O7NqvHMiL
         j3PA==
X-Forwarded-Encrypted: i=1; AJvYcCVMp2PcyO2HFzKoWgSh1BXP5iD6Ff9Lq2REbxhWjLKNaZg7y1hR7s4QtAYtktdHL7IqEJmpVmD73nUhB9YGLg2J@vger.kernel.org, AJvYcCVNZNvt8WVw1vf2MX02cgyqeFMAZyqrZakUBN7wTx2VwViMNaa4hocbknzcdvGRwMSlEuRWX4MXWc06zQHtQDg/ygNYbOZN@vger.kernel.org, AJvYcCXNqlCLN3u/dmgOV9J+wB8JTRbi7H/WQq5IPYvEMVtcM/lySXTINCNvUhMc1DQuBjLV7NN1+o4lVZWL5Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy45QxjYwNHlOPF5Z3CqqmFpWJcPfr/Opcg1VLcXxG0enTXKFLv
	XeLT38oAHo5bmjydkVKjB/x5njOtA7eBV9EsewTC5n/HMf1UHzpbLrHu
X-Gm-Gg: ASbGncsY5dmPk7Veg6frvs7qW7F7Zo+W2nRt13M+tQE300tn5gsJm2j/+VRP0Zss8i7
	8FZSMXuvl+watsUs/moZFS/lUeDn9xaRjtkZqzFgKzDFkP0wkm3JpA5UbYaYxiL/tYFptNdjSTd
	iNzdZh9TupcJYYHnk+6UYgA626TKJvMR71NAUHgze4BTnf4lnqM1FMnJshrI3H019F+g3szx659
	WCj68vOmVLYKiHQIZoCmN/JWsL5BTkflkGWlVvOpGWKcxdkX+wWVpUHdAXy08eabUP3jf2U656R
	BIZYQiDFeaQ+QrKPGwxRGkEo925XEyR7mh75EYsDnIaYTcdglK/ZbkOApnewl0ckl053rrAWGKj
	7TfPcirdGyIHqSZoKgJ+l6q2vv5gLt3+F01KCvAjHwA6B3IQW2B/+AAs9u1m8jfQvoDgyqn3ba7
	bYD46pOMcxfsExyaUruA==
X-Google-Smtp-Source: AGHT+IF58PN49BVPicK4eXVJa8rOyB8Avo9KrMnatVloYSyi+rVeeyvzrog6JTu0UoAF3EqvJJSf5g==
X-Received: by 2002:a17:903:19e4:b0:248:db40:daed with SMTP id d9443c01a7336-24944871fc8mr43509805ad.1.1756572001992;
        Sat, 30 Aug 2025 09:40:01 -0700 (PDT)
Received: from server.. ([103.251.57.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702396sm56975555ad.14.2025.08.30.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 09:40:01 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: reddybalavignesh9979@gmail.com,
	akpm@linux-foundation.org,
	richard.weiyang@gmail.com
Cc: Liam.Howlett@oracle.com,
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
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@suse.cz
Subject: [PATCH v2 0/2] selftests: Centralize kselftest headers to avoid relative includes
Date: Sat, 30 Aug 2025 22:09:47 +0530
Message-ID: <20250830163949.20952-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
References: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series centralize the handling of kselftest.h and
kselftest_harness.h includes in selftests, replacing relative
paths with a non-relative approach using shared -I path.

Patch-1 updates the build files lib.mk and 
include CFLAGS in sync/Makefile to resolve not found error
Patch-2 applies bulk source changes

In v2, the include path for selftests headers is added once in
lib.mk via top_srcdir, by which top level selftests build and
direct subdirectory builds work.

Tested with gcc-13.3 and clang-18.1.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/lkml/20250820143954.33d95635e504e94df01930d0@linux-foundation.org/

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
Changes in v2:
Patch 1: Move include path into lib.mk using top_srcdir; drop Makefile change;
Patch 2 unchanged.
Suggested-by: Wei Yang <richard.weiyang@gmail.com>
---

Bala-Vignesh-Reddy (2):
  selftests: Centralize include path for kselftest.h and
    kselftest_harness.h
  selftests: Replace relative includes with non-relative for kselftest.h
    and kselftest_harness.h

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
 tools/testing/selftests/filesystems/file_stressor.c           | 2 +-
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
 tools/testing/selftests/lib.mk                                | 2 ++
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
 tools/testing/selftests/mm/process_madv.c                     | 2 +-
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
 tools/testing/selftests/net/netfilter/conntrack_dump_flush.c  | 2 +-
 tools/testing/selftests/net/netlink-dumps.c                   | 2 +-
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
 tools/testing/selftests/sync/Makefile                         | 2 +-
 tools/testing/selftests/sync/sync_test.c                      | 2 +-
 tools/testing/selftests/sync/synctest.h                       | 2 +-
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
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c         | 2 +-
 tools/testing/selftests/vDSO/vdso_test_correctness.c          | 2 +-
 tools/testing/selftests/vDSO/vdso_test_getcpu.c               | 2 +-
 tools/testing/selftests/vDSO/vdso_test_getrandom.c            | 2 +-
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c         | 2 +-
 tools/testing/selftests/x86/corrupt_xstate_header.c           | 2 +-
 tools/testing/selftests/x86/helpers.h                         | 2 +-
 tools/testing/selftests/x86/lam.c                             | 2 +-
 tools/testing/selftests/x86/syscall_numbering.c               | 2 +-
 tools/testing/selftests/x86/test_mremap_vdso.c                | 2 +-
 tools/testing/selftests/x86/test_vsyscall.c                   | 2 +-
 tools/testing/selftests/x86/xstate.h                          | 2 +-
 279 files changed, 282 insertions(+), 280 deletions(-)

-- 
2.43.0


