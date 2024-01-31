Return-Path: <linux-kselftest+bounces-3788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E6843343
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD611C211B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0C9D281;
	Wed, 31 Jan 2024 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="DoKYBbAv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96792568A;
	Wed, 31 Jan 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667366; cv=none; b=dClhaVl3E3h2nGjYKzuGK5ltbY7hWG3jltAsY2V7fUdbHJAmk1gO0asEfrwkDh5uAafkbH8Xn4Cp/m345RKRmlN96ArOeHhLlhh5Ll1vHTuAyEPVwE5wooQN1fbNAC+byjB1K6A005UEWJJjJqRa3mEb3R7ZZOtGVveqMXqKqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667366; c=relaxed/simple;
	bh=t7vZMrKJc5i9Akhfg9p8En8QGLB7oSMjW67u3vnWHGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R12gHBXsxTWt7/+tAJoxpxluc2IbptBGNwGeDMup6dU/WMfpcw3pKrIvuSgMsvRaeXBoGXiLvttI8MlwrXVyncnirO/9pS4CUbtq10rWG+lUSeiYML9OkhtMt9bU7qzPedfaM4t8c/sh9O92UxwDrqGTN7vdpv4CMtLU/SELjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=DoKYBbAv; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=WbrqPINoK7llKoi5r/HO7WFEHTQXHueWK4gKIrcFwXI=; b=DoKYBbAvrQGwQOU9D2Y+BVB0nE
	AiTSinRuEugYzsP57er4GSxxxD5jL8NrYI9E5ehyB+VbSZ6FF8g1SJnJAX3GpUSfeXVWsxw2TMYaL
	a6Eqk/NaUHhF98SZIZn1qJSqwQ64vG0+mluPrGJxYz+Mjm2KdNmoyFA5p1NbCwuEO2wADwHTqj2Gh
	CMpyaiW/BARygD3qj0YjcPKlJMqc+dg346fxBpow2eiHmEEjlDL6beCqHJve/LzvL+SdlKTCNj8MY
	qoUHlXYE5g/7jBlBVt/VhcocS9/85UUzDAvsG7pgjA8uOU7Z1GLIyiuqYptbDllzR3PI65pT+xbcW
	1aCtJrhA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08k-0038Kv-2S;
	Tue, 30 Jan 2024 20:15:51 -0600
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
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [RFC PATCH v2 00/29] NT synchronization primitive driver
Date: Tue, 30 Jan 2024 20:13:27 -0600
Message-ID: <20240131021356.10322-1-zfigura@codeweavers.com>
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
functions (or their undocumented behaviour), patch 29/29 provides a detailed
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
  NTSYNC_IOC_KILL_OWNER, which will mark mutexes owned by that thread (if any)
  as abandoned.

* This implementation uses a misc device mostly because it seemed like the
  simplest and least obtrusive option.

  Besides simplicitly of implementation, the only particularly interesting
  advantage is the ability to create an arbitrary number of "contexts"
  (corresponding to Windows virtual machines) which are self-contained and
  shareable across multiple processes; this maps nicely to file descriptions
  (i.e. struct file). This is not impossible with syscalls of course but would
  require an extra argument.

  On the other hand, there is no reason to forbid using ntsync by default from
  user-mode processes, and (as far as I understand) to do so with a char device
  requires explicit configuration by e.g. udev or init. Since this is done with
  e.g. fuse, I assume this is the model to follow, but I may have chosen
  something deprecated.

* ntsync is module-capable mostly because there was nothing preventing it, and
  because it aided development. It is not a hard requirement, though.


== Previous versions ==

Changes in v2:

* Send the whole series instead of just the first few patches.

* Try to add more description to each patch, as a short documentation of the
  functions to be implemented. A more complete documentation of all aspects of
  the driver is provided in the contents of the last patch.

* Objects are now files rather than indices into a table. This prevents a
  process from changing the state of an object which it should not have access
  to. Suggested by Andy Lutorminski.

* Because the device no longer inherently has a table of all objects, marking a
  thread's owned mutexes as abandoned is now done through an ioctl on the mutex.

* Change the names of a couple ioctls to be a bit less odd (PUT_SEM -> SEM_POST,
  PUT_MUTEX -> MUTEX_UNLOCK), and to reflect that they are ioctls on an object
  rather than on the device.

* Pass the timeout for wait functions as a bare u64 (in ns), per Arnd Bergmann,
  with U64_MAX used to indicate no timeout. I originally indicated that I would
  change the timeout to be relative, but on reflection ended up keeping it as
  absolute, as this results in the least number of calls to get the current time
  (i.e. one).

* Use compat_ptr_ioctl(), per Arnd Bergmann.

* Remove the fixed minor number and module alias, per Greg Kroah-Hartman.

* Allocate the fds array on stack in setup_wait(). This array takes up 260
  bytes.

* Link to v1: https://lore.kernel.org/lkml/20240124004028.16826-1-zfigura@codeweavers.com/

Elizabeth Figura (29):
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
  maintainers: Add an entry for ntsync.
  docs: ntsync: Add documentation for the ntsync uAPI.

 Documentation/userspace-api/index.rst         |    1 +
 .../userspace-api/ioctl/ioctl-number.rst      |    2 +
 Documentation/userspace-api/ntsync.rst        |  390 +++++
 MAINTAINERS                                   |    9 +
 drivers/misc/Kconfig                          |    9 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/ntsync.c                         | 1132 ++++++++++++++
 include/uapi/linux/ntsync.h                   |   58 +
 tools/testing/selftests/Makefile              |    1 +
 .../testing/selftests/drivers/ntsync/Makefile |    8 +
 tools/testing/selftests/drivers/ntsync/config |    1 +
 .../testing/selftests/drivers/ntsync/ntsync.c | 1300 +++++++++++++++++
 12 files changed, 2912 insertions(+)
 create mode 100644 Documentation/userspace-api/ntsync.rst
 create mode 100644 drivers/misc/ntsync.c
 create mode 100644 include/uapi/linux/ntsync.h
 create mode 100644 tools/testing/selftests/drivers/ntsync/Makefile
 create mode 100644 tools/testing/selftests/drivers/ntsync/config
 create mode 100644 tools/testing/selftests/drivers/ntsync/ntsync.c

-- 
2.43.0


