Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3187A67E736
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 14:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjA0N6J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 08:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjA0N6H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 08:58:07 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1034C12;
        Fri, 27 Jan 2023 05:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1674827881;
        bh=cU2pVEC6fRSE0DXnUl0FoTHYRuUPSBqRDsCp95cUq7I=;
        h=From:To:Cc:Subject:Date:From;
        b=hxaLSz8y5jCtXHf66be7gJUXruzbPzRAYfq/OEOrQoACy+u+5/94WavdC/XRYhBgx
         iMU5Oxg4m+7r59bQbHrTEPo7UkOMMRGLutCu8pR8nKV0WqPkcBw/s92wo0Qrfqt5mA
         tQx5Z92wHI9Ur/c+OngxLqbCzuiViuEdkoFos5qQ2ZZY7cmlp9CccE7D9zTTPephxG
         I3XLvMMivUhCmddQc/5+sYIJNAXxzk9sIidNce6m73zJ5yapCCUREvZ3PG/dQjYN1C
         oYru3Yurd3QPfkZ9V1DCHMU8X6wlS4tDe+gl5zUOFkFvEmuZox3bAAK5mXcXpkXSFT
         1BBSywbz+QJ4g==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P3K0T0zGVzhT5;
        Fri, 27 Jan 2023 08:58:01 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 00/34] selftests: Fix incorrect kernel headers search path
Date:   Fri, 27 Jan 2023 08:57:21 -0500
Message-Id: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This series fixes incorrect kernel header search path in kernel
selftests.

Near the end of the series, a few changes are not tagged as "Fixes"
because the current behavior is to rely on the kernel sources uapi files
rather than on the installed kernel header files. Nevertheless, those
are updated for consistency.

There are situations where "../../../../include/" was added to -I search
path, which is bogus for userspace tests and caused issues with types.h.
Those are removed. 

Thanks,

Mathieu

Mathieu Desnoyers (34):
  selftests: arm64: Fix incorrect kernel headers search path
  selftests: bpf: Fix incorrect kernel headers search path
  selftests: clone3: Fix incorrect kernel headers search path
  selftests: core: Fix incorrect kernel headers search path
  selftests: dma: Fix incorrect kernel headers search path
  selftests: dmabuf-heaps: Fix incorrect kernel headers search path
  selftests: drivers: Fix incorrect kernel headers search path
  selftests: filesystems: Fix incorrect kernel headers search path
  selftests: futex: Fix incorrect kernel headers search path
  selftests: gpio: Fix incorrect kernel headers search path
  selftests: ipc: Fix incorrect kernel headers search path
  selftests: kcmp: Fix incorrect kernel headers search path
  selftests: media_tests: Fix incorrect kernel headers search path
  selftests: membarrier: Fix incorrect kernel headers search path
  selftests: mount_setattr: Fix incorrect kernel headers search path
  selftests: move_mount_set_group: Fix incorrect kernel headers search
    path
  selftests: net: Fix incorrect kernel headers search path
  selftests: perf_events: Fix incorrect kernel headers search path
  selftests: pid_namespace: Fix incorrect kernel headers search path
  selftests: pidfd: Fix incorrect kernel headers search path
  selftests: powerpc: Fix incorrect kernel headers search path
  selftests: ptp: Fix incorrect kernel headers search path
  selftests: rseq: Fix incorrect kernel headers search path
  selftests: sched: Fix incorrect kernel headers search path
  selftests: seccomp: Fix incorrect kernel headers search path
  selftests: sync: Fix incorrect kernel headers search path
  selftests: user_events: Fix incorrect kernel headers search path
  selftests: vm: Fix incorrect kernel headers search path
  selftests: x86: Fix incorrect kernel headers search path
  selftests: bpf docs: Use installed kernel headers search path
  selftests: iommu: Use installed kernel headers search path
  selftests: memfd: Use installed kernel headers search path
  selftests: ptrace: Use installed kernel headers search path
  selftests: tdx: Use installed kernel headers search path

 tools/testing/selftests/arm64/fp/Makefile               | 2 +-
 tools/testing/selftests/arm64/tags/Makefile             | 2 +-
 tools/testing/selftests/bpf/Makefile                    | 2 +-
 tools/testing/selftests/bpf/Makefile.docs               | 2 +-
 tools/testing/selftests/clone3/Makefile                 | 2 +-
 tools/testing/selftests/core/Makefile                   | 2 +-
 tools/testing/selftests/dma/Makefile                    | 2 +-
 tools/testing/selftests/dmabuf-heaps/Makefile           | 2 +-
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c      | 3 +--
 tools/testing/selftests/drivers/dma-buf/Makefile        | 2 +-
 tools/testing/selftests/drivers/s390x/uvdevice/Makefile | 3 +--
 tools/testing/selftests/filesystems/Makefile            | 2 +-
 tools/testing/selftests/filesystems/binderfs/Makefile   | 2 +-
 tools/testing/selftests/filesystems/epoll/Makefile      | 2 +-
 tools/testing/selftests/futex/functional/Makefile       | 2 +-
 tools/testing/selftests/gpio/Makefile                   | 2 +-
 tools/testing/selftests/iommu/Makefile                  | 3 +--
 tools/testing/selftests/ipc/Makefile                    | 2 +-
 tools/testing/selftests/kcmp/Makefile                   | 2 +-
 tools/testing/selftests/media_tests/Makefile            | 2 +-
 tools/testing/selftests/membarrier/Makefile             | 2 +-
 tools/testing/selftests/memfd/Makefile                  | 4 +---
 tools/testing/selftests/mount_setattr/Makefile          | 2 +-
 tools/testing/selftests/move_mount_set_group/Makefile   | 2 +-
 tools/testing/selftests/net/Makefile                    | 2 +-
 tools/testing/selftests/net/bpf/Makefile                | 2 +-
 tools/testing/selftests/net/mptcp/Makefile              | 2 +-
 tools/testing/selftests/net/openvswitch/Makefile        | 2 +-
 tools/testing/selftests/perf_events/Makefile            | 2 +-
 tools/testing/selftests/pid_namespace/Makefile          | 2 +-
 tools/testing/selftests/pidfd/Makefile                  | 2 +-
 tools/testing/selftests/powerpc/ptrace/Makefile         | 2 +-
 tools/testing/selftests/powerpc/security/Makefile       | 2 +-
 tools/testing/selftests/powerpc/syscalls/Makefile       | 2 +-
 tools/testing/selftests/powerpc/tm/Makefile             | 2 +-
 tools/testing/selftests/ptp/Makefile                    | 2 +-
 tools/testing/selftests/ptrace/Makefile                 | 2 +-
 tools/testing/selftests/rseq/Makefile                   | 2 +-
 tools/testing/selftests/sched/Makefile                  | 2 +-
 tools/testing/selftests/seccomp/Makefile                | 2 +-
 tools/testing/selftests/sync/Makefile                   | 2 +-
 tools/testing/selftests/tdx/Makefile                    | 2 +-
 tools/testing/selftests/tdx/tdx_guest_test.c            | 2 +-
 tools/testing/selftests/user_events/Makefile            | 2 +-
 tools/testing/selftests/vm/Makefile                     | 2 +-
 tools/testing/selftests/x86/Makefile                    | 2 +-
 46 files changed, 46 insertions(+), 51 deletions(-)

-- 
2.25.1

