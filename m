Return-Path: <linux-kselftest+bounces-40057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0D8B38557
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 16:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD9016ED4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76021770A;
	Wed, 27 Aug 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdQ7wVBI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6498617A2E3;
	Wed, 27 Aug 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306067; cv=none; b=uK6twDKLMpDNiPuCA5GSKupYwmQB1y6TMIyZ69aqNUZBwPPworCHggm8p9Zug4BhCeDMucGLwIee07sHBncff5DcOY/caktCiwWQ10Gb5bOkx/hRZJcaV+kq8MKNGsUMZuxkisBgkbzSZl8bBZEzlIpI89KVz/biRcOgwA4wdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306067; c=relaxed/simple;
	bh=0ccv3o2TpX/UDhVSHJt84n0arKaHsQ7KMTGAGJU8CWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdGcAzXnjlzSXsMuhLTT7he734nYgeSeQTr1MZXg0g6baXKzTVXxlzWNTYioYMnuTlVAcd24Vaxd0aEbdYx4UXAQEMtTYJz9x45+pIxMRY17cp1qhiu9UMrS852XglCv4EgyF1oZQ3+SxM6rCGUNRgbv+23aJqYvONRdGcadvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdQ7wVBI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771e987b4e6so2739595b3a.2;
        Wed, 27 Aug 2025 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756306065; x=1756910865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0FgqW720I5SXNq/vZsEEY5bvOXRlyavftPZs+kaaEug=;
        b=cdQ7wVBIOAhqA83XOI0U6u+EJvtmI1O5BuvJ/rqVW7UvlWHlH/6fxljkIIk4oKDLw1
         sjozRNyHIDKrMbb0yq21lI3uAUcNJDrCe2C3n+1pe1fxB2qaQdjF2c/J1nK6Honz7vLV
         lvSqsQIufYxU/SjltjRj5E++UVnR53DHautuHGJDSc7JideJ5Vzkc2L2+CAAOd3A0Znr
         kc51rv9lnlfAeiQLgpxqw9VfCuxt/4i1HPmKuxTPcXlsOdSw/JWSh/NBAHT1NqDV1IfO
         A/Pqyo3Qj9xRd9vKiy6cYSkn/Deg2pyL94OqQU3nunNLVtfwUDR7Gv/6a/vcAxIfrhVL
         R7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756306065; x=1756910865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FgqW720I5SXNq/vZsEEY5bvOXRlyavftPZs+kaaEug=;
        b=VoW1tQVfbKT23UiLQjsIjHu1cqgA5g8vx5UuGGNJ5vuJiaW9CcJ3fb5sYIq5FJ97tw
         g1LxNg0wsmo3wkWg7q5FRDyEDcrErUuz8KzqUpkn+r9RZPS3rcoR8uDkDOWnCqCydER0
         1g9bNCXydf6pUDnbKu85D6Sm4AArj3DVwHspr/2ycvLcElfVQvGfbc9nNuTibS8I5CMi
         603xm+aL1YAVIhyfI7N7oOj2LI2J88giI+uvnEYT+GYBHkJlAqT3H1PuVrvtB03ZBgcI
         gmUKQ7AJqcD/9LWQVULiRS1wIee2Wytbeq5GyijCAEdEB8NpUtJBO0kAbFYbxUq0/0sH
         vf/A==
X-Forwarded-Encrypted: i=1; AJvYcCVMnnC+XRDWeIryam16iGfpAvKUG/WTIYX6qOfocxuTEQ50sJWU78IjfAm0UtFUmfv41at2mSVnj4RzTbgU2OwkEM7eGBHZ@vger.kernel.org, AJvYcCVw5KDAWgcql9DbHu+AIuipLO6Zn4gnRYCNxHxsTBT4FQ2NrNYUDaDoFnFB3IR1/KzmlzTEtLBnhpOJxAoE8Ew0@vger.kernel.org, AJvYcCXzB5yweD6K/mV4AzrzL6l9qV5RQB81B6LtG4OQ7V4aEqPPp3H9fctmTEq9JrBxIBqIJG6ShcS46Zf8uY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAfoVT+qXvDBGWa1Por2r1qH4MDG9ToObuc4ApFiGBVXExsbUi
	EdvzxEd+6t4q25q90S4v4v/idm+JMPwBiXY9qh2Q+GIzHVjOTYndPmbe
X-Gm-Gg: ASbGncuxRG9E4TveKjcvXF25rP5ZUQMTzodBfGhjofjjMmC7ohojArN1XL2wHRdtT5a
	Ap0q58lPWggfd4d2jvuwgqz4vit4lkktGrwdaP3+7OQxYe2z+0tTfmCdriSKC58AbdAtZfzhhqb
	Qr0MtFHMQsudbC4z2mRfYWKdYotFkD+ZS1Z+Yu7192T4r1GCJYeZro25EpLsCA3JlIRidKm3akx
	sWx5ExYPsE/wgo69KPk3lh1UiaZ3gRnnUaj7xiwplVyjj4ZOepdadGw/dEWtX6zZ973g4SbFpmU
	kdyWEOM9RT8MqL8p7MH1NU0jasvI5q7BvnLjjW/k8wmhZwPjCZNTCr9w8mZjkixTgalk38lhrWq
	1WifGEDoVtYr9s2AN54ns6/eVOrT7aKcy+eecNAJijMEWWE3H+XyUh+psN2PQCeXafR5EZB/de8
	5+64TmR+dorCValeoLZw==
X-Google-Smtp-Source: AGHT+IF5Avd6p59BU/BAJOi8O1dZAdmfMeE5Q27yXhOQK2XeYVusnCsmM+AG7yX/IWHsSo44MDHSfw==
X-Received: by 2002:a05:6a20:7001:b0:243:6f4e:fba0 with SMTP id adf61e73a8af0-2436f4efc69mr12155406637.4.1756306064486;
        Wed, 27 Aug 2025 07:47:44 -0700 (PDT)
Received: from server.. ([103.251.57.213])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7c09fsm11626826a12.26.2025.08.27.07.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:47:43 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: mic@digikod.net,
	gnoack@google.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ming.lei@redhat.com,
	skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Subject: [PATCH 0/2] selftests: Centralize kselftest headers to avoid relative includes
Date: Wed, 27 Aug 2025 20:17:31 +0530
Message-ID: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Patch-1 updates the build files (Makefile and lib.mk) and 
include CFLAGS in sync/Makefile to resolve not found error
Patch-2 applies bulk source change
(Patch 2 is large but it is replaced automatically)

Checked the changes with gcc-13.32 and clang 18.1 

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/lkml/20250820143954.33d95635e504e94df01930d0@linux-foundation.org/


Bala-Vignesh-Reddy (2):
  selftests: Centralize include path for kselftest.h and
    kselftest_harness.h
  selftests: Replace relative includes with non-relative for kselftest.h
    and kselftest_harness.h

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>

 tools/testing/selftests/Makefile                              | 4 ++++
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
 280 files changed, 286 insertions(+), 280 deletions(-)

-- 
2.43.0


