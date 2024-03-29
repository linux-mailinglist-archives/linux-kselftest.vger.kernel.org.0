Return-Path: <linux-kselftest+bounces-6819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046E1890F95
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CAB1F25883
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5711802E;
	Fri, 29 Mar 2024 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="jQlnrsvs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2645BEA;
	Fri, 29 Mar 2024 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671874; cv=none; b=pYrNVCx60NUpcc3qpLTTWDt7ntBUeZky4ctVzk/enMKb/Rk6LABhRM7dFQSz6LV0Rqa2LMlExA07gW8jmWSXo9C0N5vSYAaeV2KUzxLkSsN1tDUZkG8SToAzM8ibHA2AUIkDGzOxPTnGtHRMRpgy/exjF/iW6GueCjQG8l1YQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671874; c=relaxed/simple;
	bh=9ihBRMpiHQhkPYAPhP6leKAoNlUNK9bdUrh4kk8Ix68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+cJbCQVsG1AFrTE8eCc607OfYziMNZ272rA7fd7mxxQdoq2oWvP9v0GRh2SpNMR+509Mox6fijoIGtO5vZy0KVckW+LFq0fS/0wPVQnMQyJ9zJYwYwobbVhFeMpxy0dUAfchM3VpbGyztWpXxU9rAWJfhBbwVBqX5pQHi+jn0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=jQlnrsvs; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=KRZHO1gJof8/b+BzEpcQJP2YApEy9WwqoBIjH+ybMhM=; b=jQlnrsvstC4B3PpHgv5wPhWEry
	No5Arg6dh9c+UC0zOSUCRRfiejpUKkuORXSeTef2bSNSVe2M68ARIU9tFwIxy7oekwZS0UnTZL2ZA
	b6wLJdmr6rwhUd15aIXYKJBgMFdOXPfrggprNeGsxC2957yVHqIq6Tn3wBawbt7asXag+IFAybitP
	l1GT3hXjh9Q8K3wegSODmaWnZZZ4FOnsrwjjyF2YqlRLikPPJl4K5NW7T3nDybl8YI11tfDlArVNT
	g0LltODv7SUl7smvrpS3zZyB/dp102fYWeP5J0cPpoZx2y8WN63+tU5SghGCeZkPgThRmbg7vDWe8
	ldNC6ryw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlL-000iik-2H;
	Thu, 28 Mar 2024 19:06:27 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v3 00/30] NT synchronization primitive driver
Date: Thu, 28 Mar 2024 19:05:51 -0500
Message-ID: <20240329000621.148791-1-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a new char misc driver, /dev/ntsync, which is used
to implement Windows NT synchronization primitives.

== Background ==

The Wine project emulates the Windows API in user space. One particular part of
that API, namely the NT synchronization primitives, have historically been
implemented via RPC to a dedicated "kernel" process. However, more recent
applications use these APIs more strenuously, and the overhead of RPC has become
a bottleneck.

The NT synchronization APIs are too complex to implement on top of existing
primitives without sacrificing correctness. Certain operations, such as
NtPulseEvent() or the "wait-for-all" mode of NtWaitForMultipleObjects(), require
direct control over the underlying wait queue, and implementing a wait queue
sufficiently robust for Wine in user space is not possible. This proposed
driver, therefore, implements the problematic interfaces directly in the Linux
kernel.

This driver was presented at Linux Plumbers Conference 2023. For those further
interested in the history of synchronization in Wine and past attempts to solve
this problem in user space, a recording of the presentation can be viewed here:

    https://www.youtube.com/watch?v=NjU4nyWyhU8


== Performance ==

The gain in performance varies wildly depending on the application in question
and the user's hardware. For some games NT synchronization is not a bottleneck
and no change can be observed, but for others frame rate improvements of 50 to
150 percent are not atypical. The following table lists frame rate measurements
from a variety of games on a variety of hardware, taken by users Dmitry
Skvortsov, FuzzyQuils, OnMars, and myself:

Game                            Upstream        ntsync          improvement
===========================================================================
Anger Foot                       69              99              43%
Call of Juarez                   99.8           224.1           125%
Dirt 3                          110.6           860.7           678%
Forza Horizon 5                 108             160              48%
Lara Croft: Temple of Osiris    141             326             131%
Metro 2033                      164.4           199.2            21%
Resident Evil 2                  26              77             196%
The Crew                         26              51              96%
Tiny Tina's Wonderlands         130             360             177%
Total War Saga: Troy            109             146              34%
===========================================================================


== Patches ==

The intended semantics of the patches are broadly intended to match those of the
corresponding Windows functions. For those not already familiar with the Windows
functions (or their undocumented behaviour), patch 31/31 provides a detailed
specification, and individual patches also include a brief description of the
API they are implementing.

The patches making use of this driver in Wine can be retrieved or browsed here:

    https://repo.or.cz/wine/zf.git/shortlog/refs/heads/ntsync5


== Implementation ==

Some aspects of the implementation may deserve particular comment:

* In the interest of performance, each object is governed only by a single
  spinlock. However, NTSYNC_IOC_WAIT_ALL requires that the state of multiple
  objects be changed as a single atomic operation. In order to achieve this, we
  first take a device-wide lock ("wait_all_lock") any time we are going to lock
  more than one object at a time.

  The maximum number of objects that can be used in a vectored wait, and
  therefore the maximum that can be locked simultaneously, is 64. This number is
  NT's own limit.

  The acquisition of multiple spinlocks will degrade performance. This is a
  conscious choice, however. Wait-for-all is known to be a very rare operation
  in practice, especially with counts that approach the maximum, and it is the
  intent of the ntsync driver to optimize wait-for-any at the expense of
  wait-for-all as much as possible.

* NT mutexes are tied to their threads on an OS level, and the kernel includes
  builtin support for "robust" mutexes. In order to keep the ntsync driver
  self-contained and avoid touching more code than necessary, it does not hook
  into task exit nor use pids.

  Instead, the user space emulator is expected to manage thread IDs and pass
  them as an argument to any relevant functions; this is the "owner" field of
  ntsync_wait_args and ntsync_mutex_args.

  When the emulator detects that a thread dies, it should therefore call
  NTSYNC_IOC_MUTEX_KILL on any open mutexes.

* ntsync is module-capable mostly because there was nothing preventing it, and
  because it aided development. It is not a hard requirement, though.


== Previous versions ==

Changes from v2:

* Check the result of fget() for NULL.

* Squash patch 31 (introducing the NTSYNC_WAIT_REALTIME flag) into patch 4, per
  Arnd Bergmann.

* Use atomic_try_cmpxchg() instead of atomic_cmpxchg(), per off-list review from
  Uros Bizjak.

* Link to v2: https://lore.kernel.org/lkml/20240219223833.95710-1-zfigura@codeweavers.com/
* Link to v1: https://lore.kernel.org/lkml/20240214233645.9273-1-zfigura@codeweavers.com/
* Link to RFC v2: https://lore.kernel.org/lkml/20240131021356.10322-1-zfigura@codeweavers.com/
* Link to RFC v1: https://lore.kernel.org/lkml/20240124004028.16826-1-zfigura@codeweavers.com/

Elizabeth Figura (30):
  ntsync: Introduce the ntsync driver and character device.
  ntsync: Introduce NTSYNC_IOC_CREATE_SEM.
  ntsync: Introduce NTSYNC_IOC_SEM_POST.
  ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
  ntsync: Introduce NTSYNC_IOC_WAIT_ALL.
  ntsync: Introduce NTSYNC_IOC_CREATE_MUTEX.
  ntsync: Introduce NTSYNC_IOC_MUTEX_UNLOCK.
  ntsync: Introduce NTSYNC_IOC_MUTEX_KILL.
  ntsync: Introduce NTSYNC_IOC_CREATE_EVENT.
  ntsync: Introduce NTSYNC_IOC_EVENT_SET.
  ntsync: Introduce NTSYNC_IOC_EVENT_RESET.
  ntsync: Introduce NTSYNC_IOC_EVENT_PULSE.
  ntsync: Introduce NTSYNC_IOC_SEM_READ.
  ntsync: Introduce NTSYNC_IOC_MUTEX_READ.
  ntsync: Introduce NTSYNC_IOC_EVENT_READ.
  ntsync: Introduce alertable waits.
  selftests: ntsync: Add some tests for semaphore state.
  selftests: ntsync: Add some tests for mutex state.
  selftests: ntsync: Add some tests for NTSYNC_IOC_WAIT_ANY.
  selftests: ntsync: Add some tests for NTSYNC_IOC_WAIT_ALL.
  selftests: ntsync: Add some tests for wakeup signaling with
    WINESYNC_IOC_WAIT_ANY.
  selftests: ntsync: Add some tests for wakeup signaling with
    WINESYNC_IOC_WAIT_ALL.
  selftests: ntsync: Add some tests for manual-reset event state.
  selftests: ntsync: Add some tests for auto-reset event state.
  selftests: ntsync: Add some tests for wakeup signaling with events.
  selftests: ntsync: Add tests for alertable waits.
  selftests: ntsync: Add some tests for wakeup signaling via alerts.
  selftests: ntsync: Add a stress test for contended waits.
  maintainers: Add an entry for ntsync.
  docs: ntsync: Add documentation for the ntsync uAPI.

 Documentation/userspace-api/index.rst         |    1 +
 .../userspace-api/ioctl/ioctl-number.rst      |    2 +
 Documentation/userspace-api/ntsync.rst        |  399 +++++
 MAINTAINERS                                   |    9 +
 drivers/misc/Kconfig                          |   11 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/ntsync.c                         | 1166 ++++++++++++++
 include/uapi/linux/ntsync.h                   |   62 +
 tools/testing/selftests/Makefile              |    1 +
 .../testing/selftests/drivers/ntsync/Makefile |    8 +
 tools/testing/selftests/drivers/ntsync/config |    1 +
 .../testing/selftests/drivers/ntsync/ntsync.c | 1407 +++++++++++++++++
 12 files changed, 3068 insertions(+)
 create mode 100644 Documentation/userspace-api/ntsync.rst
 create mode 100644 drivers/misc/ntsync.c
 create mode 100644 include/uapi/linux/ntsync.h
 create mode 100644 tools/testing/selftests/drivers/ntsync/Makefile
 create mode 100644 tools/testing/selftests/drivers/ntsync/config
 create mode 100644 tools/testing/selftests/drivers/ntsync/ntsync.c


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.43.0


