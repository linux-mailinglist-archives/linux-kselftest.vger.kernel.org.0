Return-Path: <linux-kselftest+bounces-9823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC98C15D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964A11F23C97
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924C8061C;
	Thu,  9 May 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fs9V8TEb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA280022
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284845; cv=none; b=CY3xnqAM864kg0ROoVjKkK5TEEdZXwBD3MACyzbx+lMIPn3kONBFTOWahb9q1Rtfmmx+I0T+CRxdSqFc2VbBZKl/dEMlTUzKq5dPfH9v18xghoHX3yE5EN+U9GZEFVPLhBL7guZiITlkiMMhUk18xwgf2LrvFKatNOx6rdzWvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284845; c=relaxed/simple;
	bh=250B3OFFdrfwOHOTW6gbI5OwJ2n0bFOmxzJ4UbIdIuA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dv/IaXr9myvCxJ/ONPSjsFRguIWarZQJqz1ERj1FOKiOBeV1GiK3z7CORl5OA4mn9HCCXufmUCGVYZXnGW72ACcXjmsA26JlnJCFAQptNA3Cq0obaFGdr9WcMI6WRztgSlyyNTFvewB/RJxYGhttffcqIkFtE8Oud9kHFWiocRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fs9V8TEb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de8b6847956so3118116276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284841; x=1715889641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BiQaAHv48LNkLl6IKhKIG+TFd091T8JM9L1cZXvhgHc=;
        b=fs9V8TEbtnKOPt/8AFLLDZkcavdaVS5hHKgFlHOD6Ud+vfcJr++UwJ4dLqDaA3TnQ0
         9Z1s1ZUy5P1gDJJ+c5aqLcT47cPtPzDnnBF9CzRTEkv65VCoyj7eABpIFrAFvBi8ZVbp
         PHn8Yy9MFSMSi13X9Ysd3K3yULV7B+mUpoXlYtuZ1UQoVqn38Tr/dr4mMBzgLUgcm1wW
         kuS1Ux+V1F1wL9W8Y3NTHyHbDkLQ5RgJCkbuS2phpL+zDxEAyp3ii2fmwiMZXmnyggND
         wrSv1V/FDsW3lDLV+JWBWF69RCW3M5YuDwtRIVPbrpkEMqPTYIjrkS56miJHkbrim/0v
         hUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284841; x=1715889641;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BiQaAHv48LNkLl6IKhKIG+TFd091T8JM9L1cZXvhgHc=;
        b=J8bAfPMM3M0xOFnmmFPKdCdfvBK0CUvy/7YLuzwrVFovunxyqJwpShxxRgeboi1S5A
         nbk76q34B/Xc1FoCzI9piZNSkR0CzMdICBzWF7MDisdpY2Vi7N07ucAOdky1cZ4OWyak
         UWFu6DSj24gZFHWrQzYHBWR2ZFIuNRNRaTEz6VdFCwBxrhehQ00M0Xw0msxzScqdMddq
         6lsmxHWzijqQ2o9QAfhO+Cz/O0erS87EeFscrlkoLSoOiW+SsJmc3lCL54PGBzXjaR49
         TgAeLghDXm+H+W2iRuQxDHIQcsWPCFsD5REMsnt2OIf5pLppSPVzxVWyExv1oyRE6XaL
         ThMA==
X-Forwarded-Encrypted: i=1; AJvYcCVuvJSFksXuHoMqhpHUuWFQ3uFa0dd5Q5lQd7GuGuX7uRA7txTKNYERzFuyXR5K17pL5E3uMGL1pONa5ehxV4MdVDzMC77eHUKkTbhp8rEe
X-Gm-Message-State: AOJu0Yx8ou9dWsJQ70ntPbFNrsa99ta7Ku1epT6W6fbFqele3lDrPQNb
	DBDfMyhpC/oJQZx5S17zsA7YoGDEsBsQmFkpGFABhayorjplPQfmYIJlxQxQa4xrEtSUSY9m8zz
	qdQ==
X-Google-Smtp-Source: AGHT+IG32nWVWyDPupjVMEK6n3N1N+aMGl5P1P8w84uzKmBtJyMVqaNfyadCWNQkLoCFctCi7ZQ+FRrhQSk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:150d:b0:dc6:e884:2342 with SMTP id
 3f1490d57ef6-dee4e5a1043mr214884276.5.1715284840940; Thu, 09 May 2024
 13:00:40 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:52 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-1-edliaw@google.com>
Subject: [PATCH v3 00/68] Define _GNU_SOURCE for sources using
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
redefinitions of _GNU_SOURCE from source code.

809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
asprintf into kselftest_harness.h, which is a GNU extension and needs
_GNU_SOURCE to either be defined prior to including headers or with the
-D_GNU_SOURCE flag passed to the compiler.

v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-edliaw@google.com/
v2: https://lore.kernel.org/linux-kselftest/20240507214254.2787305-1-edliaw@google.com/
 - Add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
   location.
 - Remove #define _GNU_SOURCE from source code to resolve redefinition
   warnings.
v3:
 - Rebase onto linux-next.
 - Split patches by directory.
 - Add -D_GNU_SOURCE directly to CFLAGS in lib.mk.
 - Delete additional _GNU_SOURCE definitions from source code in
   linux-next.
 - Delete additional -D_GNU_SOURCE flags from Makefiles.

Edward Liaw (68):
  selftests: Compile kselftest headers with -D_GNU_SOURCE
  selftests/sgx: Include KHDR_INCLUDES in Makefile
  selftests: Compile with -D_GNU_SOURCE when including lib.mk
  selftests/arm64: Drop define _GNU_SOURCE
  selftests/arm64: Drop duplicate -D_GNU_SOURCE
  selftests/bpf: Drop define _GNU_SOURCE
  selftests/breakpoints: Drop define _GNU_SOURCE
  selftests/cachestat: Drop define _GNU_SOURCE
  selftests/capabilities: Drop define _GNU_SOURCE
  selftests/cgroup: Drop define _GNU_SOURCE
  selftests/clone3: Drop define _GNU_SOURCE
  selftests/core: Drop define _GNU_SOURCE
  selftests/damon: Drop define _GNU_SOURCE
  selftests/drivers: Drop define _GNU_SOURCE
  selftests/exec: Drop duplicate -D_GNU_SOURCE
  selftests/fchmodat2: Drop define _GNU_SOURCE
  selftests/filelock: Drop define _GNU_SOURCE
  selftests/filesystems: Drop define _GNU_SOURCE
  selftests/firmware: Drop define _GNU_SOURCE
  selftests/fpu: Drop define _GNU_SOURCE
  selftests/futex: Drop define _GNU_SOURCE
  selftests/futex: Drop duplicate -D_GNU_SOURCE
  selftests/intel_pstate: Drop duplicate -D_GNU_SOURCE
  selftests/iommu: Drop duplicate -D_GNU_SOURCE
  selftests/ipc: Drop define _GNU_SOURCE
  selftests/kcmp: Drop define _GNU_SOURCE
  selftests/landlock: Drop define _GNU_SOURCE
  selftests/lsm: Drop define _GNU_SOURCE
  selftests/membarrier: Drop define _GNU_SOURCE
  selftests/memfd: Drop define _GNU_SOURCE
  selftests/mincore: Drop define _GNU_SOURCE
  selftests/mm: Drop define _GNU_SOURCE
  selftests/mount: Drop define _GNU_SOURCE
  selftests/mount_setattr: Drop define _GNU_SOURCE
  selftests/move_mount_set_group: Drop define _GNU_SOURCE
  selftests/mqueue: Drop define _GNU_SOURCE
  selftests/net: Drop define _GNU_SOURCE
  selftests/net: Drop duplicate -D_GNU_SOURCE
  selftests/nolibc: Drop define _GNU_SOURCE
  selftests/nsfs: Drop define _GNU_SOURCE
  selftests/openat2: Drop define _GNU_SOURCE
  selftests/perf_events: Drop define _GNU_SOURCE
  selftests/pid_namespace: Drop define _GNU_SOURCE
  selftests/pidfd: Drop define _GNU_SOURCE
  selftests/ptrace: Drop define _GNU_SOURCE
  selftests/powerpc: Drop define _GNU_SOURCE
  selftests/proc: Drop define _GNU_SOURCE
  selftests/proc: Drop duplicate -D_GNU_SOURCE
  selftests/ptp: Drop define _GNU_SOURCE
  selftests/resctrl: Drop duplicate -D_GNU_SOURCE
  selftests/riscv: Drop define _GNU_SOURCE
  selftests/riscv: Drop duplicate -D_GNU_SOURCE
  selftests/rlimits: Drop define _GNU_SOURCE
  selftests/rseq: Drop define _GNU_SOURCE
  selftests/safesetid: Drop define _GNU_SOURCE
  selftests/sched: Drop define _GNU_SOURCE
  selftests/seccomp: Drop define _GNU_SOURCE
  selftests/sigaltstack: Drop define _GNU_SOURCE
  selftests/splice: Drop define _GNU_SOURCE
  selftests/syscall_user_dispatch: Drop define _GNU_SOURCE
  selftests/thermal: Drop define _GNU_SOURCE
  selftests/timens: Drop define _GNU_SOURCE
  selftests/tmpfs: Drop duplicate -D_GNU_SOURCE
  selftests/uevent: Drop define _GNU_SOURCE
  selftests/user_events: Drop define _GNU_SOURCE
  selftests/vDSO: Drop define _GNU_SOURCE
  selftests/wireguard: Drop define _GNU_SOURCE
  selftests/x86: Drop define _GNU_SOURCE

 tools/testing/selftests/arm64/fp/fp-ptrace.c                  | 3 ---
 tools/testing/selftests/arm64/fp/fp-stress.c                  | 2 --
 tools/testing/selftests/arm64/fp/vlset.c                      | 1 -
 tools/testing/selftests/arm64/mte/check_buffer_fill.c         | 3 ---
 tools/testing/selftests/arm64/mte/check_child_memory.c        | 3 ---
 tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c     | 3 ---
 tools/testing/selftests/arm64/mte/check_ksm_options.c         | 3 ---
 tools/testing/selftests/arm64/mte/check_mmap_options.c        | 3 ---
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c      | 3 ---
 tools/testing/selftests/arm64/mte/check_user_mem.c            | 3 ---
 tools/testing/selftests/arm64/pauth/pac.c                     | 3 ---
 tools/testing/selftests/arm64/signal/Makefile                 | 2 +-
 tools/testing/selftests/bpf/bench.c                           | 1 -
 tools/testing/selftests/bpf/benchs/bench_trigger.c            | 1 -
 tools/testing/selftests/bpf/cgroup_helpers.c                  | 1 -
 tools/testing/selftests/bpf/map_tests/task_storage_map.c      | 1 -
 tools/testing/selftests/bpf/network_helpers.c                 | 2 --
 tools/testing/selftests/bpf/prog_tests/bind_perm.c            | 1 -
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c           | 1 -
 tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c  | 1 -
 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c      | 1 -
 tools/testing/selftests/bpf/prog_tests/btf_endian.c           | 1 -
 tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c  | 2 --
 tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c           | 2 --
 tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c   | 2 --
 tools/testing/selftests/bpf/prog_tests/cls_redirect.c         | 3 ---
 tools/testing/selftests/bpf/prog_tests/connect_ping.c         | 2 --
 tools/testing/selftests/bpf/prog_tests/core_retro.c           | 1 -
 tools/testing/selftests/bpf/prog_tests/d_path.c               | 1 -
 tools/testing/selftests/bpf/prog_tests/deny_namespace.c       | 1 -
 tools/testing/selftests/bpf/prog_tests/fexit_sleep.c          | 1 -
 .../selftests/bpf/prog_tests/flow_dissector_reattach.c        | 2 --
 tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c     | 1 -
 tools/testing/selftests/bpf/prog_tests/htab_reuse.c           | 1 -
 tools/testing/selftests/bpf/prog_tests/htab_update.c          | 1 -
 tools/testing/selftests/bpf/prog_tests/map_in_map.c           | 1 -
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c  | 2 --
 tools/testing/selftests/bpf/prog_tests/perf_branches.c        | 1 -
 tools/testing/selftests/bpf/prog_tests/perf_buffer.c          | 1 -
 tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c  | 1 -
 tools/testing/selftests/bpf/prog_tests/perf_link.c            | 1 -
 tools/testing/selftests/bpf/prog_tests/perf_skip.c            | 2 --
 tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c  | 1 -
 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c        | 2 --
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c           | 2 --
 tools/testing/selftests/bpf/prog_tests/ringbuf.c              | 1 -
 tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c        | 1 -
 tools/testing/selftests/bpf/prog_tests/setget_sockopt.c       | 2 --
 tools/testing/selftests/bpf/prog_tests/sk_assign.c            | 2 --
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c            | 2 --
 tools/testing/selftests/bpf/prog_tests/sock_fields.c          | 2 --
 tools/testing/selftests/bpf/prog_tests/task_kfunc.c           | 2 --
 tools/testing/selftests/bpf/prog_tests/task_local_storage.c   | 2 --
 tools/testing/selftests/bpf/prog_tests/task_pt_regs.c         | 1 -
 tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c | 2 --
 tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c      | 2 --
 tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c          | 1 -
 .../testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c | 1 -
 tools/testing/selftests/bpf/prog_tests/test_bpffs.c           | 1 -
 tools/testing/selftests/bpf/prog_tests/test_overhead.c        | 1 -
 tools/testing/selftests/bpf/prog_tests/token.c                | 1 -
 tools/testing/selftests/bpf/prog_tests/trace_ext.c            | 2 --
 tools/testing/selftests/bpf/prog_tests/trampoline_count.c     | 1 -
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c         | 2 --
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c          | 2 --
 tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c         | 2 --
 tools/testing/selftests/bpf/test_flow_dissector.c             | 3 ---
 tools/testing/selftests/bpf/test_lru_map.c                    | 1 -
 tools/testing/selftests/bpf/test_progs.c                      | 1 -
 tools/testing/selftests/bpf/test_sock_addr.c                  | 3 ---
 tools/testing/selftests/bpf/test_tcpnotify_user.c             | 1 -
 tools/testing/selftests/bpf/veristat.c                        | 1 -
 tools/testing/selftests/bpf/xskxceiver.c                      | 2 --
 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c   | 3 ---
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 3 ---
 tools/testing/selftests/cachestat/test_cachestat.c            | 2 --
 tools/testing/selftests/capabilities/test_execve.c            | 2 --
 tools/testing/selftests/cgroup/cgroup_util.c                  | 3 ---
 tools/testing/selftests/cgroup/test_core.c                    | 2 --
 tools/testing/selftests/cgroup/test_cpu.c                     | 2 --
 tools/testing/selftests/cgroup/test_hugetlb_memcg.c           | 2 --
 tools/testing/selftests/cgroup/test_kmem.c                    | 2 --
 tools/testing/selftests/cgroup/test_memcontrol.c              | 2 --
 tools/testing/selftests/cgroup/test_zswap.c                   | 2 --
 tools/testing/selftests/clone3/clone3.c                       | 2 --
 .../testing/selftests/clone3/clone3_cap_checkpoint_restore.c  | 2 --
 tools/testing/selftests/clone3/clone3_clear_sighand.c         | 2 --
 tools/testing/selftests/clone3/clone3_selftests.h             | 1 -
 tools/testing/selftests/clone3/clone3_set_tid.c               | 2 --
 tools/testing/selftests/core/close_range_test.c               | 2 --
 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c   | 3 ---
 .../damon/debugfs_target_ids_read_before_terminate_race.c     | 2 --
 tools/testing/selftests/drivers/dma-buf/udmabuf.c             | 1 -
 tools/testing/selftests/exec/Makefile                         | 1 -
 tools/testing/selftests/fchmodat2/fchmodat2_test.c            | 2 --
 tools/testing/selftests/filelock/ofdlocks.c                   | 2 --
 tools/testing/selftests/filesystems/binderfs/binderfs_test.c  | 2 --
 tools/testing/selftests/filesystems/devpts_pts.c              | 1 -
 tools/testing/selftests/filesystems/dnotify_test.c            | 1 -
 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c | 2 --
 tools/testing/selftests/filesystems/eventfd/eventfd_test.c    | 2 --
 tools/testing/selftests/filesystems/fat/rename_exchange.c     | 2 --
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c   | 2 --
 .../testing/selftests/filesystems/statmount/statmount_test.c  | 3 ---
 tools/testing/selftests/firmware/fw_namespace.c               | 1 -
 tools/testing/selftests/fpu/test_fpu.c                        | 2 --
 tools/testing/selftests/futex/functional/Makefile             | 2 +-
 tools/testing/selftests/futex/functional/futex_requeue_pi.c   | 3 ---
 tools/testing/selftests/intel_pstate/Makefile                 | 2 +-
 tools/testing/selftests/iommu/Makefile                        | 2 --
 tools/testing/selftests/ipc/msgque.c                          | 1 -
 tools/testing/selftests/kcmp/kcmp_test.c                      | 2 --
 tools/testing/selftests/kselftest_harness.h                   | 2 +-
 tools/testing/selftests/landlock/base_test.c                  | 2 --
 tools/testing/selftests/landlock/fs_test.c                    | 2 --
 tools/testing/selftests/landlock/net_test.c                   | 2 --
 tools/testing/selftests/landlock/ptrace_test.c                | 2 --
 tools/testing/selftests/lib.mk                                | 3 +++
 tools/testing/selftests/lsm/common.c                          | 2 --
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c          | 2 --
 tools/testing/selftests/lsm/lsm_list_modules_test.c           | 2 --
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c          | 2 --
 tools/testing/selftests/membarrier/membarrier_test_impl.h     | 1 -
 .../selftests/membarrier/membarrier_test_multi_thread.c       | 1 -
 .../selftests/membarrier/membarrier_test_single_thread.c      | 1 -
 tools/testing/selftests/memfd/common.c                        | 1 -
 tools/testing/selftests/memfd/fuse_test.c                     | 2 --
 tools/testing/selftests/memfd/memfd_test.c                    | 1 -
 tools/testing/selftests/mincore/mincore_selftest.c            | 3 ---
 tools/testing/selftests/mm/cow.c                              | 1 -
 tools/testing/selftests/mm/gup_longterm.c                     | 1 -
 tools/testing/selftests/mm/hugepage-mmap.c                    | 1 -
 tools/testing/selftests/mm/hugepage-mremap.c                  | 2 --
 tools/testing/selftests/mm/hugetlb-madvise.c                  | 2 --
 tools/testing/selftests/mm/hugetlb-read-hwpoison.c            | 2 --
 tools/testing/selftests/mm/khugepaged.c                       | 1 -
 tools/testing/selftests/mm/ksm_functional_tests.c             | 1 -
 tools/testing/selftests/mm/madv_populate.c                    | 1 -
 tools/testing/selftests/mm/map_populate.c                     | 2 --
 tools/testing/selftests/mm/mdwe_test.c                        | 1 -
 tools/testing/selftests/mm/memfd_secret.c                     | 2 --
 tools/testing/selftests/mm/mlock2-tests.c                     | 1 -
 tools/testing/selftests/mm/mrelease_test.c                    | 1 -
 tools/testing/selftests/mm/mremap_dontunmap.c                 | 1 -
 tools/testing/selftests/mm/mremap_test.c                      | 2 --
 tools/testing/selftests/mm/mseal_test.c                       | 1 -
 tools/testing/selftests/mm/pagemap_ioctl.c                    | 1 -
 tools/testing/selftests/mm/pkey-helpers.h                     | 1 -
 tools/testing/selftests/mm/protection_keys.c                  | 1 -
 tools/testing/selftests/mm/seal_elf.c                         | 1 -
 tools/testing/selftests/mm/split_huge_page_test.c             | 2 --
 tools/testing/selftests/mm/thuge-gen.c                        | 2 --
 tools/testing/selftests/mm/uffd-common.h                      | 1 -
 tools/testing/selftests/mount/nosymfollow-test.c              | 1 -
 tools/testing/selftests/mount/unprivileged-remount-test.c     | 1 -
 tools/testing/selftests/mount_setattr/mount_setattr_test.c    | 1 -
 .../move_mount_set_group/move_mount_set_group_test.c          | 1 -
 tools/testing/selftests/mqueue/mq_perf_tests.c                | 1 -
 tools/testing/selftests/net/af_unix/diag_uid.c                | 2 --
 tools/testing/selftests/net/af_unix/scm_pidfd.c               | 1 -
 tools/testing/selftests/net/af_unix/scm_rights.c              | 1 -
 tools/testing/selftests/net/af_unix/unix_connect.c            | 2 --
 tools/testing/selftests/net/csum.c                            | 3 ---
 tools/testing/selftests/net/gro.c                             | 3 ---
 tools/testing/selftests/net/ip_defrag.c                       | 3 ---
 tools/testing/selftests/net/ipsec.c                           | 3 ---
 tools/testing/selftests/net/ipv6_flowlabel.c                  | 3 ---
 tools/testing/selftests/net/ipv6_flowlabel_mgr.c              | 3 ---
 tools/testing/selftests/net/mptcp/mptcp_connect.c             | 3 ---
 tools/testing/selftests/net/mptcp/mptcp_inq.c                 | 3 ---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c             | 3 ---
 tools/testing/selftests/net/msg_zerocopy.c                    | 3 ---
 tools/testing/selftests/net/netfilter/audit_logread.c         | 2 --
 tools/testing/selftests/net/netfilter/conntrack_dump_flush.c  | 3 ---
 tools/testing/selftests/net/nettest.c                         | 2 --
 tools/testing/selftests/net/psock_fanout.c                    | 3 ---
 tools/testing/selftests/net/psock_snd.c                       | 3 ---
 tools/testing/selftests/net/reuseport_addr_any.c              | 3 ---
 tools/testing/selftests/net/reuseport_bpf_cpu.c               | 3 ---
 tools/testing/selftests/net/reuseport_bpf_numa.c              | 3 ---
 tools/testing/selftests/net/reuseport_dualstack.c             | 3 ---
 tools/testing/selftests/net/so_incoming_cpu.c                 | 1 -
 tools/testing/selftests/net/so_netns_cookie.c                 | 1 -
 tools/testing/selftests/net/so_txtime.c                       | 3 ---
 tools/testing/selftests/net/tap.c                             | 3 ---
 tools/testing/selftests/net/tcp_ao/Makefile                   | 2 +-
 tools/testing/selftests/net/tcp_fastopen_backup_key.c         | 1 -
 tools/testing/selftests/net/tcp_inq.c                         | 2 --
 tools/testing/selftests/net/tcp_mmap.c                        | 1 -
 tools/testing/selftests/net/tls.c                             | 3 ---
 tools/testing/selftests/net/toeplitz.c                        | 3 ---
 tools/testing/selftests/net/tun.c                             | 3 ---
 tools/testing/selftests/net/txring_overwrite.c                | 3 ---
 tools/testing/selftests/net/txtimestamp.c                     | 3 ---
 tools/testing/selftests/net/udpgso.c                          | 3 ---
 tools/testing/selftests/net/udpgso_bench_rx.c                 | 3 ---
 tools/testing/selftests/net/udpgso_bench_tx.c                 | 3 ---
 tools/testing/selftests/nolibc/nolibc-test.c                  | 2 --
 tools/testing/selftests/nsfs/owner.c                          | 1 -
 tools/testing/selftests/nsfs/pidns.c                          | 1 -
 tools/testing/selftests/openat2/helpers.c                     | 2 --
 tools/testing/selftests/openat2/helpers.h                     | 1 -
 tools/testing/selftests/openat2/openat2_test.c                | 2 --
 tools/testing/selftests/openat2/rename_attack_test.c          | 2 --
 tools/testing/selftests/openat2/resolve_test.c                | 2 --
 tools/testing/selftests/perf_events/remove_on_exec.c          | 2 --
 tools/testing/selftests/perf_events/sigtrap_threads.c         | 2 --
 tools/testing/selftests/perf_events/watermark_signal.c        | 2 --
 tools/testing/selftests/pid_namespace/regression_enomem.c     | 1 -
 tools/testing/selftests/pidfd/pidfd.h                         | 1 -
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c             | 2 --
 tools/testing/selftests/pidfd/pidfd_getfd_test.c              | 2 --
 tools/testing/selftests/pidfd/pidfd_open_test.c               | 2 --
 tools/testing/selftests/pidfd/pidfd_poll_test.c               | 2 --
 tools/testing/selftests/pidfd/pidfd_setns_test.c              | 2 --
 tools/testing/selftests/pidfd/pidfd_test.c                    | 2 --
 tools/testing/selftests/pidfd/pidfd_wait.c                    | 2 --
 tools/testing/selftests/powerpc/benchmarks/context_switch.c   | 2 --
 tools/testing/selftests/powerpc/benchmarks/exec_target.c      | 2 --
 tools/testing/selftests/powerpc/benchmarks/fork.c             | 2 --
 tools/testing/selftests/powerpc/benchmarks/futex_bench.c      | 3 ---
 tools/testing/selftests/powerpc/dexcr/hashchk_test.c          | 3 ---
 tools/testing/selftests/powerpc/dscr/dscr_default_test.c      | 3 ---
 tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c     | 3 ---
 tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c | 1 -
 tools/testing/selftests/powerpc/mm/exec_prot.c                | 2 --
 tools/testing/selftests/powerpc/mm/pkey_exec_prot.c           | 2 --
 tools/testing/selftests/powerpc/mm/pkey_siginfo.c             | 2 --
 tools/testing/selftests/powerpc/mm/tlbie_test.c               | 2 --
 tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c           | 1 -
 tools/testing/selftests/powerpc/pmu/count_instructions.c      | 3 ---
 tools/testing/selftests/powerpc/pmu/count_stcx_fail.c         | 3 ---
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c                 | 3 ---
 .../selftests/powerpc/pmu/ebb/instruction_count_test.c        | 3 ---
 tools/testing/selftests/powerpc/pmu/event.c                   | 2 --
 tools/testing/selftests/powerpc/pmu/lib.c                     | 3 ---
 tools/testing/selftests/powerpc/pmu/per_event_excludes.c      | 3 ---
 tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c         | 3 ---
 tools/testing/selftests/powerpc/ptrace/ptrace-syscall.c       | 2 --
 .../testing/selftests/powerpc/signal/sig_sc_double_restart.c  | 1 -
 tools/testing/selftests/powerpc/signal/sigreturn_kernel.c     | 3 ---
 tools/testing/selftests/powerpc/signal/sigreturn_vdso.c       | 3 ---
 tools/testing/selftests/powerpc/syscalls/ipc_unmuxed.c        | 2 --
 tools/testing/selftests/powerpc/tm/tm-exec.c                  | 2 --
 tools/testing/selftests/powerpc/tm/tm-poison.c                | 2 --
 .../testing/selftests/powerpc/tm/tm-signal-context-force-tm.c | 2 --
 tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c   | 2 --
 tools/testing/selftests/powerpc/tm/tm-tmspr.c                 | 2 --
 tools/testing/selftests/powerpc/tm/tm-trap.c                  | 2 --
 tools/testing/selftests/powerpc/tm/tm-unavailable.c           | 2 --
 tools/testing/selftests/powerpc/utils.c                       | 3 ---
 tools/testing/selftests/proc/Makefile                         | 1 -
 tools/testing/selftests/proc/proc-empty-vm.c                  | 3 ---
 tools/testing/selftests/ptp/testptp.c                         | 1 -
 tools/testing/selftests/ptrace/get_set_sud.c                  | 1 -
 tools/testing/selftests/ptrace/peeksiginfo.c                  | 1 -
 tools/testing/selftests/resctrl/Makefile                      | 2 +-
 tools/testing/selftests/riscv/hwprobe/cbo.c                   | 1 -
 tools/testing/selftests/riscv/hwprobe/which-cpus.c            | 1 -
 tools/testing/selftests/riscv/mm/Makefile                     | 2 +-
 tools/testing/selftests/rlimits/rlimits-per-userns.c          | 1 -
 tools/testing/selftests/rseq/basic_percpu_ops_test.c          | 1 -
 tools/testing/selftests/rseq/basic_test.c                     | 2 --
 tools/testing/selftests/rseq/param_test.c                     | 1 -
 tools/testing/selftests/rseq/rseq.c                           | 2 --
 tools/testing/selftests/safesetid/safesetid-test.c            | 1 -
 tools/testing/selftests/sched/cs_prctl_test.c                 | 2 --
 tools/testing/selftests/seccomp/seccomp_benchmark.c           | 1 -
 tools/testing/selftests/seccomp/seccomp_bpf.c                 | 2 --
 tools/testing/selftests/sgx/Makefile                          | 2 +-
 tools/testing/selftests/sgx/sigstruct.c                       | 1 -
 tools/testing/selftests/sigaltstack/sas.c                     | 2 --
 tools/testing/selftests/splice/default_file_splice_read.c     | 1 -
 tools/testing/selftests/splice/splice_read.c                  | 1 -
 tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c | 2 --
 tools/testing/selftests/syscall_user_dispatch/sud_test.c      | 2 --
 .../selftests/thermal/intel/power_floor/power_floor_test.c    | 3 ---
 .../thermal/intel/workload_hint/workload_hint_test.c          | 3 ---
 tools/testing/selftests/timens/clock_nanosleep.c              | 1 -
 tools/testing/selftests/timens/exec.c                         | 1 -
 tools/testing/selftests/timens/futex.c                        | 1 -
 tools/testing/selftests/timens/gettime_perf.c                 | 1 -
 tools/testing/selftests/timens/procfs.c                       | 1 -
 tools/testing/selftests/timens/timens.c                       | 1 -
 tools/testing/selftests/timens/timer.c                        | 1 -
 tools/testing/selftests/timens/timerfd.c                      | 1 -
 tools/testing/selftests/timens/vfork_exec.c                   | 1 -
 tools/testing/selftests/tmpfs/Makefile                        | 1 -
 tools/testing/selftests/uevent/uevent_filtering.c             | 2 --
 tools/testing/selftests/user_events/abi_test.c                | 2 --
 tools/testing/selftests/vDSO/vdso_test_abi.c                  | 1 -
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c         | 2 --
 tools/testing/selftests/vDSO/vdso_test_correctness.c          | 3 ---
 tools/testing/selftests/wireguard/qemu/init.c                 | 2 --
 tools/testing/selftests/x86/amx.c                             | 2 --
 tools/testing/selftests/x86/check_initial_reg_state.c         | 3 ---
 tools/testing/selftests/x86/corrupt_xstate_header.c           | 3 ---
 tools/testing/selftests/x86/entry_from_vm86.c                 | 3 ---
 tools/testing/selftests/x86/fsgsbase.c                        | 2 --
 tools/testing/selftests/x86/fsgsbase_restore.c                | 2 --
 tools/testing/selftests/x86/ioperm.c                          | 2 --
 tools/testing/selftests/x86/iopl.c                            | 2 --
 tools/testing/selftests/x86/lam.c                             | 1 -
 tools/testing/selftests/x86/ldt_gdt.c                         | 2 --
 tools/testing/selftests/x86/mov_ss_trap.c                     | 2 --
 tools/testing/selftests/x86/nx_stack.c                        | 2 --
 tools/testing/selftests/x86/ptrace_syscall.c                  | 2 --
 tools/testing/selftests/x86/sigaltstack.c                     | 2 --
 tools/testing/selftests/x86/sigreturn.c                       | 3 ---
 tools/testing/selftests/x86/single_step_syscall.c             | 3 ---
 tools/testing/selftests/x86/syscall_arg_fault.c               | 3 ---
 tools/testing/selftests/x86/syscall_numbering.c               | 3 ---
 tools/testing/selftests/x86/sysret_rip.c                      | 3 ---
 tools/testing/selftests/x86/sysret_ss_attrs.c                 | 3 ---
 tools/testing/selftests/x86/test_FCMOV.c                      | 4 ----
 tools/testing/selftests/x86/test_FCOMI.c                      | 4 ----
 tools/testing/selftests/x86/test_FISTTP.c                     | 4 ----
 tools/testing/selftests/x86/test_mremap_vdso.c                | 1 -
 tools/testing/selftests/x86/test_shadow_stack.c               | 3 ---
 tools/testing/selftests/x86/test_syscall_vdso.c               | 4 ----
 tools/testing/selftests/x86/test_vsyscall.c                   | 3 ---
 tools/testing/selftests/x86/unwind_vdso.c                     | 3 ---
 tools/testing/selftests/x86/vdso_restorer.c                   | 3 ---
 323 files changed, 11 insertions(+), 611 deletions(-)

--
2.45.0.118.g7fe29c98d7-goog


