Return-Path: <linux-kselftest+bounces-10387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B28C962B
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF88281235
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC0371743;
	Sun, 19 May 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="aBGtv+O5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1D6A8AD;
	Sun, 19 May 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150316; cv=none; b=lyyZ7JnjgvKbn6casFLGGBIqoOxPfDPwLdg1nASHdTD2vsx6I7PG0b8Sp/Ap+nG5gsnnWAV8BPYqhY12BiBbjUyxeLzBQ31Y5Bt7e6zUTJzKRqA9XEE2FagVy8zSjscmn+Y3g+Wqg7/fwGTmDCQWcOjTM9W6FGJRr9hOyYEls54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150316; c=relaxed/simple;
	bh=0qG+W0cq/ZIy+kBsaFjtlx7EMjYhAuV4tLmQBKC75Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RiVmVxfXMHPS/FoPtZsmtGtCB0eZvHfsdUna1wTQkgUpOiEGcXFoFZUBEmku1vJpXSjOLMZK5QCeWn4dbSBajmlKW5zBl3w4n5kttEl0jHgcwFP4JuZKivPDPef4tzTpp965mnbujlUrFRCZT3RJRtDB/qySUw9PZS/NyME4sY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=aBGtv+O5; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=NHVHZphp8+aqcquBnZjxKWHtr0MaxD49C8WRDtcnw94=; b=aBGtv+O5SD4JQ0NLvyJpgbxGZF
	5XayoFywpgZINiQpm3+e57Jf9hzqWI7Z5IWSkuGytgUUqiOeCcuHwD7HIfjbhaRXX0i4AjOTli4qP
	lAh+wF/rZwDUb1IjgSgBmgkJV5NyTHFv0ze12DCSlRWcJ9M5dGZ5dyA0nxw/98q3E9jR3TVSAFWv6
	FH/CbGFJ6YOGaEu8+kWMNXsYJPp+LO4XJ6efH4vN7vfdMhEyG3u93/xjlMzW3oZa10UuyYBKJlHDx
	8AIXnbrnFmIJgP7mHK25IV2mlccFcTQiAX0KGGE2UTS/NK+6ds3bepfXhH/NFQrC0kUVaGcc31DVN
	HEA5UnVw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5a-008wIn-0M;
	Sun, 19 May 2024 15:25:02 -0500
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
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v5 00/28] NT synchronization primitive driver
Date: Sun, 19 May 2024 15:24:26 -0500
Message-ID: <20240519202454.1192826-1-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This patch series implements a new char misc driver, /dev/ntsync, which is used
to implement Windows NT synchronization primitives.

NT synchronization primitives are unique in that the wait functions both are
vectored, operate on multiple types of object with different behaviour (mutex,
semaphore, event), and affect the state of the objects they wait on. This model
is not compatible with existing kernel synchronization objects or interfaces,
and therefore the ntsync driver implements its own wait queues and locking.

This patch series is rebased against the "char-misc-next" branch of
gregkh/char-misc.git.

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

The performance measurements described below are copied from earlier versions of
the patch set. While some of the code has changed, I do not currently anticipate
that it has changed drastically enough to affect those measurements.

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
functions (or their undocumented behaviour), patch 27/28 provides a detailed
specification, and individual patches also include a brief description of the
API they are implementing.

The patches making use of this driver in Wine can be retrieved or browsed here:

    https://repo.or.cz/wine/zf.git/shortlog/refs/heads/ntsync5

== Previous versions ==

Changes from v4:

* Rework wait-all locking code to avoid taking more than one spinlock at a time,
  and also to fix a race where the wait-all lock would not be not correctly
  taken. The new locking mechanism involves taking a simple spinlock for normal
  "any" waits, and taking a device-wide mutex for "all" waits or when locking
  any object that is involved in an "all" wait. The mechanism was written by
  Peter Zijlstra.

* Try to reword or clarify various parts of the documentation (patch 27), per
  Peter Zijlstra.

* I did not rename NTSYNC_IOC_SEM_POST to RELEASE (like NT) although this was
  suggested by Peter Zijlstra, mostly because it's not clear to me that renaming
  an already committed ioctl would be fine. The API committed isn't actually
  usable yet, though, so if altering it would be fine on those grounds, I can
  revise this series to rename the function accordingly.

* Similarly, I did not change the create ioctls to return the fd directly,
  although this was suggested and would be a bit simpler and cleaner, because
  NTSYNC_IOC_CREATE_SEM already exists upstream and returns the fd through a
  struct. I can make this change in the next revision if that'd be preferable. I
  also still would appreciate a clarification on the advice in [1].

  [1] https://docs.kernel.org/driver-api/ioctl.html#return-code

* Link to v4: https://lore.kernel.org/lkml/20240416010837.333694-1-zfigura@codeweavers.com/
* Link to v3: https://lore.kernel.org/lkml/20240329000621.148791-1-zfigura@codeweavers.com/
* Link to v2: https://lore.kernel.org/lkml/20240219223833.95710-1-zfigura@codeweavers.com/
* Link to v1: https://lore.kernel.org/lkml/20240214233645.9273-1-zfigura@codeweavers.com/
* Link to RFC v2: https://lore.kernel.org/lkml/20240131021356.10322-1-zfigura@codeweavers.com/
* Link to RFC v1: https://lore.kernel.org/lkml/20240124004028.16826-1-zfigura@codeweavers.com/

Elizabeth Figura (28):
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
  ntsync: No longer depend on BROKEN.

 Documentation/userspace-api/index.rst         |    1 +
 Documentation/userspace-api/ntsync.rst        |  398 +++++
 MAINTAINERS                                   |    9 +
 drivers/misc/Kconfig                          |    1 -
 drivers/misc/ntsync.c                         |  989 +++++++++++-
 include/uapi/linux/ntsync.h                   |   39 +
 tools/testing/selftests/Makefile              |    1 +
 .../selftests/drivers/ntsync/.gitignore       |    1 +
 .../testing/selftests/drivers/ntsync/Makefile |    7 +
 tools/testing/selftests/drivers/ntsync/config |    1 +
 .../testing/selftests/drivers/ntsync/ntsync.c | 1407 +++++++++++++++++
 11 files changed, 2850 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/userspace-api/ntsync.rst
 create mode 100644 tools/testing/selftests/drivers/ntsync/.gitignore
 create mode 100644 tools/testing/selftests/drivers/ntsync/Makefile
 create mode 100644 tools/testing/selftests/drivers/ntsync/config
 create mode 100644 tools/testing/selftests/drivers/ntsync/ntsync.c


base-commit: f5b335dc025cfee90957efa90dc72fada0d5abb4
-- 
2.43.0


