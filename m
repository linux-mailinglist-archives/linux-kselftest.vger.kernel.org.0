Return-Path: <linux-kselftest+bounces-7194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9E89891E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 15:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E25B265EA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6625D128804;
	Thu,  4 Apr 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLrMlvES"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3766128385
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238492; cv=none; b=G5vkgFdYCrkuy/tmu7N38nsmWENwh6HQwnCHOiSJKKjNroJIhKdoNtZ5+G22gmQLFyZvBy6mLqMmg99knVnajy12JI78oPJ95GDlq1Kcw7N9Cw9Euu4FcAUyNw0KHof/qeREHRIQg5N6cEaXfE+YBF8DY9a6paKTaBYuNX9eRAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238492; c=relaxed/simple;
	bh=4a0W+I+wPugroMr8YypZAJZzfe7982eYCpHy1dSeuTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X2BnhQyQs40GeNIywU0Pg7bCve5O7VBT3M7O553eDHrAr2u+5KlgusbF2xkG+uyrUE8lo5Dm5JFc/sqSqzs2PiKMPkAgxI2xXZRRzmBLP5lPNb6LApt6hK3fKWc8LiDYfo1JW4m+HQDO8Gb8VMY6fje0m84DgG3EKHHOIQ/2Udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLrMlvES; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712238489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tnsuyx7KcBv6XFJZWKQU2kMyMK1EfNz6Nm3ZEf6Chos=;
	b=JLrMlvESbgQ6C48Ir4VpSUZMDHRRMozwEj14q88yB8kCNXzu8WkCo69xlGtrJHN15oMA51
	5ubrvaD28TxcAE8/qBprWEZhx2op6e8XeIEIeKEiNkdikC6x52ts6BMpjVVEEEqwp4qKny
	mgV5oKWw9j0ZPuiymkUfYlbln1pemrY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-vX8sI94qMmSFL_xh7rpwBQ-1; Thu,
 04 Apr 2024 09:48:06 -0400
X-MC-Unique: vX8sI94qMmSFL_xh7rpwBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 296BA3C0F43E;
	Thu,  4 Apr 2024 13:48:05 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 42B783C54;
	Thu,  4 Apr 2024 13:48:03 +0000 (UTC)
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
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] cgroup/cpuset: Make cpuset hotplug processing synchronous
Date: Thu,  4 Apr 2024 09:47:47 -0400
Message-Id: <20240404134749.2857852-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

 v2:
  - Found that rebuild_sched_domains() has external callers, revert its
    change and introduce rebuild_sched_domains_cpuslocked() instead.

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
 kernel/cgroup/cpuset.c                        | 141 +++++++-----------
 kernel/cpu.c                                  |  48 ------
 kernel/power/process.c                        |   2 -
 tools/testing/selftests/cgroup/Makefile       |   2 +-
 .../selftests/cgroup/test_cpuset_v1_hp.sh     |  46 ++++++
 6 files changed, 103 insertions(+), 139 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh

-- 
2.39.3


