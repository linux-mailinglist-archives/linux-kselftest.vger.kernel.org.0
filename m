Return-Path: <linux-kselftest+bounces-6942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3360D893C6F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 16:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650381C20F13
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1804597F;
	Mon,  1 Apr 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pe9Yb4sL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66E28684
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Apr 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983566; cv=none; b=AEdtCnYqrngsOpc9iACcREOcXiT9wKhV2Kun/5N23YFIoU/h160+PSUXwFRnPNKfsC0i+/bMVTGYDdig3I7y+NawrkpWwkuUPEqz9A2asCYbxKJL4R6Ds7W4DHkPwmTYF+zSUEV2uGhPc1UmJxA4sWToBw7dfGQ+IvhPZLBRU0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983566; c=relaxed/simple;
	bh=+N7vB/l8eI+BsoWxlwCAb4p/o1JU7fDVp21tieM+N0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S5Dcp7x9Ok/QLfVWYzyzKcvHJ7om7ysO0MWwkvueCgLgNM0xionQ4AzJt+r7cAjoHKm7suUeA+uh7mP4/46Ut9/dZDqTJ5z53gEURXskFqxOUQwBtBgEKiS/tzOhzrvzI8a/yqt6vcn8EFHFqWfI4bcqg7j64u1WQ57wiLFJEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pe9Yb4sL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711983563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tTOZ+xVZLIL276KYyTbnm56/gg9lamrdIo8smfPcjkg=;
	b=Pe9Yb4sLD3mtlm9gcOXiXwPU8QVlk8DV37IZHXuCwi6mu9Rp4rk09A9yTEB79JqA17bmRF
	IHlnU+C5Vm8FJhFox2oApsFjxF1L/jPTdoHrLAKZNs4IV6rfYoTxR3d3eE9KwfcHzrSYdM
	9m4YMADUvX3srhuRb1kDzPrlpsQyIyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-Z94_VNTWNcOgc4Tmt2zvUw-1; Mon, 01 Apr 2024 10:59:18 -0400
X-MC-Unique: Z94_VNTWNcOgc4Tmt2zvUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42ABC88F2EB;
	Mon,  1 Apr 2024 14:59:17 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.160])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 40C1511310;
	Mon,  1 Apr 2024 14:59:15 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Alex Shi <alexs@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Barry Song <song.bao.hua@hisilicon.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] cgroup/cpuset: Make cpuset hotplug processing synchronous
Date: Mon,  1 Apr 2024 10:58:56 -0400
Message-Id: <20240401145858.2656598-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

As discussed in the LKML thread [1], the asynchronous nature of cpuset
hotplug handling code is causing problem with RCU testing. With recent
changes in the way locking is being handled in the cpuset code, it is
now possible to make the cpuset hotplug code synchronous again without
major changes.

This series enables the hotplug code to call directly into cpuset hotplug
core without indirection with the exception of the special case of v1
cpuset becoming empty still being handled indirectly with workqueue.

A new simple test case was also written to test this special v1 cpuset
case. The test_cpuset_prs.sh script was also run with LOCKDEP on to
verify that there is no regression.

[1] https://lore.kernel.org/lkml/ZgYikMb5kZ7rxPp6@slm.duckdns.org/

Waiman Long (2):
  cgroup/cpuset: Make cpuset hotplug processing synchronous
  cgroup/cpuset: Add test_cpuset_v1_hp.sh

 include/linux/cpuset.h                        |   3 -
 kernel/cgroup/cpuset.c                        | 131 +++++++-----------
 kernel/cpu.c                                  |  48 -------
 kernel/power/process.c                        |   2 -
 tools/testing/selftests/cgroup/Makefile       |   2 +-
 .../selftests/cgroup/test_cpuset_v1_hp.sh     |  40 ++++++
 6 files changed, 88 insertions(+), 138 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh

-- 
2.39.3


