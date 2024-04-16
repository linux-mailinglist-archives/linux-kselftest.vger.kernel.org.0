Return-Path: <linux-kselftest+bounces-8066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E01268A5FEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 03:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45273B21FD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 01:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72EA3A1AC;
	Tue, 16 Apr 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Y3Uki57o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274B7489;
	Tue, 16 Apr 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229833; cv=none; b=lkddO63/r+NWHMskuxO/76KLeJywUcEBubhSmxEzIo+hdfVDBag1/MhYcB3dBc5WSLfW//7zWAe74azVXIYAni3SxNenej3467wcq+KcXVCSEqZ+8m6uTkAiad5sm8o757j//Oaeu30+wmDNB1ThQGgRDcyE22ifFDZoFVphqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229833; c=relaxed/simple;
	bh=CfGfgdOAAKKMC5wFm2zy4hEYCNA54sn4dKMYMos0ND8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2/mSoo/gNnoh3SSI/wTTMZTIB/z0a93qSGliALLmWO8V1Hb4LoH/4RyqmQmEk8pIGwvurbruL6Wr8rX3fPOkflwIivQZZyCgO8dCy2+aKbRLrxTFQ6SY5aIvQiatGTAMK1pBAne+RxEqL8zHkxy5HOLy+6MiM/JAL6hf8DiTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Y3Uki57o; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=k/J/xiqsIy5k1U4w1kZGUWaht5CJpXBMInaaIcC0oiY=; b=Y3Uki57orxWhxbiyUq9z3KxXuT
	dibRcItgLRG9rebmojAQ857nUCBwnvGMet1tTm7Opv/M+5XJLSlqpg++1CbcoNRtmEtSX0z/yztdW
	DS9RSvijD4I4/SbZNrzgxLV0x41jmESeh0grMHXpQPxSX7+aBF1tPySIvMqkx8UwPCHhWKZRuZGhO
	XTaVv+sCNclYioj0J9r6NoELBXzmy8c51bJtSBXvU02udDSPkqRziBUUM293H8WsBn/N36N/uwDoZ
	yREBT+4J7yjSKqUUbAPuU45la3olin1e5A6H04osWXKSleJxI2MkJ/uwy19TJ2T08v009ncFleMl+
	YFEAIVWw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwXKy-00FbQv-0Y;
	Mon, 15 Apr 2024 20:10:16 -0500
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
Subject: [PATCH v4 00/30] NT synchronization primitive driver
Date: Mon, 15 Apr 2024 20:08:10 -0500
Message-ID: <20240416010837.333694-1-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements a new char misc driver, /dev/ntsync, which is used
to implement Windows NT synchronization primitives.

NT synchronization primitives are unique in that the wait functions both are
vectored, operate on multiple types of object with different behaviour (mutex,
semaphore, event), and affect the state of the objects they wait on. This model
is not compatible with existing kernel synchronization objects or interfaces,
and therefore the ntsync driver implements its own wait queues and locking.

Hence I would like to request review from someone familiar with locking to make
sure that the usage of low-level kernel primitives is correct and that the wait
queues work as intended, and to that end I've CC'd the locking maintainers.

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
functions (or their undocumented behaviour), patch 27/27 provides a detailed
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

Changes from v3:

* Add .gitignore and use KHDR_INCLUDES in selftest build files, per Muhammad
  Usama Anjum.

* Try to explain why we are rolling our own primitives a little better, per Greg
  Kroah-Hartman.

* Link to v3: https://lore.kernel.org/lkml/20240329000621.148791-1-zfigura@codeweavers.com/
* Link to v2: https://lore.kernel.org/lkml/20240219223833.95710-1-zfigura@codeweavers.com/
* Link to v1: https://lore.kernel.org/lkml/20240214233645.9273-1-zfigura@codeweavers.com/
* Link to RFC v2: https://lore.kernel.org/lkml/20240131021356.10322-1-zfigura@codeweavers.com/
* Link to RFC v1: https://lore.kernel.org/lkml/20240124004028.16826-1-zfigura@codeweavers.com/

Elizabeth Figura (27):
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
 Documentation/userspace-api/ntsync.rst        |  399 +++++
 MAINTAINERS                                   |    9 +
 drivers/misc/ntsync.c                         |  925 ++++++++++-
 include/uapi/linux/ntsync.h                   |   39 +
 tools/testing/selftests/Makefile              |    1 +
 .../selftests/drivers/ntsync/.gitignore       |    1 +
 .../testing/selftests/drivers/ntsync/Makefile |    7 +
 tools/testing/selftests/drivers/ntsync/config |    1 +
 .../testing/selftests/drivers/ntsync/ntsync.c | 1407 +++++++++++++++++
 10 files changed, 2786 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/userspace-api/ntsync.rst
 create mode 100644 tools/testing/selftests/drivers/ntsync/.gitignore
 create mode 100644 tools/testing/selftests/drivers/ntsync/Makefile
 create mode 100644 tools/testing/selftests/drivers/ntsync/config
 create mode 100644 tools/testing/selftests/drivers/ntsync/ntsync.c


base-commit: ebbc1a4789c666846b9854ef845a37a64879e5f9
-- 
2.43.0


