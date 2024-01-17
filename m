Return-Path: <linux-kselftest+bounces-3160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AA830B36
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 17:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596C91F2B383
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD1B22F05;
	Wed, 17 Jan 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYd+rijC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF32262F
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509380; cv=none; b=S9X3GWH435Jl6sATnps2m9gcFJGKyTvnW77ASGX3DGbLcpZtm6OIfJ2q+ZwSF8lrM4uwWVi8R6mkY6f/GSHVUhmUOl/IN700egzUMAKYDUScNyIWYY/SnqDxgrYPGFMTwlGqZr52yXSzW8nR/mxhIZs67Tx6tYqEx5UUcOPp348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509380; c=relaxed/simple;
	bh=zEdw6+4t3gWkhLRYybEMf2j+xLGxSJtwIdZKm2vmD5o=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:
	 X-Scanned-By; b=Vr0djNK/jftnqqsueu03wt85Ff0pACwxhS+VT5coGXG8dwrMpDddSj/LYBuaxepkmch081gM3wxnWqz6m/6wuAJVePUqyA/cWP+FXrSYgkjn8teNF21e62uBJBfsjH1Rv2Xqf35G/Xa4Et1gseWFmJhWH8Wq1qIJYJ+uXcUVFdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYd+rijC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705509377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rjFWU3VSZDE3kD8BQKWbnkhbf707TtYyOuJ5RUq9a7I=;
	b=dYd+rijCtLuhpHxqD2GM/s1eEji4x9ju/WUGUDIR4I1OySoLrqetavToRevo7Owzwv1cAr
	RcjzbUHVeroLbVjjkGYI1J6loG161bAaOgHRoA2NMGReP+bEoUa10/DMNgyOOLgFZYbxJC
	sFAMyVsW3aMZjDuGTy7F/V/d8Xvc/jY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-zLf2wzouOPWbYK-3U-_Ipw-1; Wed, 17 Jan 2024 11:36:06 -0500
X-MC-Unique: zLf2wzouOPWbYK-3U-_Ipw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A874982A6CF;
	Wed, 17 Jan 2024 16:36:04 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A0101121312;
	Wed, 17 Jan 2024 16:36:02 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Alex Gladkov <agladkov@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 0/8] cgroup/cpuset: Support RCU_NOCB on isolated partitions
Date: Wed, 17 Jan 2024 11:35:03 -0500
Message-Id: <20240117163511.88173-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This patch series is based on the RFC patch from Frederic [1]. Instead
of offering RCU_NOCB as a separate option, it is now lumped into a
root-only cpuset.cpus.isolation_full flag that will enable all the
additional CPU isolation capabilities available for isolated partitions
if set. RCU_NOCB is just the first one to this party. Additional dynamic
CPU isolation capabilities will be added in the future.

The first 2 patches are adopted from Federic with minor twists to fix
merge conflicts and compilation issue. The rests are for implementing
the new cpuset.cpus.isolation_full interface which is essentially a flag
to globally enable or disable full CPU isolation on isolated partitions.
On read, it also shows the CPU isolation capabilities that are currently
enabled. RCU_NOCB requires that the rcu_nocbs option be present in
the kernel boot command line. Without that, the rcu_nocb functionality
cannot be enabled even if the isolation_full flag is set. So we allow
users to check the isolation_full file to verify that if the desired
CPU isolation capability is enabled or not.

Only sanity checking has been done so far. More testing, especially on
the RCU side, will be needed.

[1] https://lore.kernel.org/lkml/20220525221055.1152307-1-frederic@kernel.org/

Frederic Weisbecker (2):
  rcu/nocb: Pass a cpumask instead of a single CPU to offload/deoffload
  rcu/nocb: Prepare to change nocb cpumask from CPU-hotplug protected
    cpuset caller

Waiman Long (6):
  rcu/no_cb: Add rcu_nocb_enabled() to expose the rcu_nocb state
  cgroup/cpuset: Better tracking of addition/deletion of isolated CPUs
  cgroup/cpuset: Add cpuset.cpus.isolation_full
  cgroup/cpuset: Enable dynamic rcu_nocb mode on isolated CPUs
  cgroup/cpuset: Document the new cpuset.cpus.isolation_full control
    file
  cgroup/cpuset: Update test_cpuset_prs.sh to handle
    cpuset.cpus.isolation_full

 Documentation/admin-guide/cgroup-v2.rst       |  24 ++
 include/linux/rcupdate.h                      |  15 +-
 kernel/cgroup/cpuset.c                        | 237 ++++++++++++++----
 kernel/rcu/rcutorture.c                       |   6 +-
 kernel/rcu/tree_nocb.h                        | 118 ++++++---
 .../selftests/cgroup/test_cpuset_prs.sh       |  23 +-
 6 files changed, 337 insertions(+), 86 deletions(-)

-- 
2.39.3


