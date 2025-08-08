Return-Path: <linux-kselftest+bounces-38586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DAAB1EBB9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64906189476E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB26285078;
	Fri,  8 Aug 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOsDR9IR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15428506B
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666489; cv=none; b=MBnxh7yJJ0jRlUvD6kGT/ou7xpwKszy3CUvCbpHB0OqEhYoH+eH2fmyKJZwqknF/YI7Y9vaBB0GhVsSyAkai/ofBHgYuey/B2LhF4eDA+KRtzsP89EgTdBu5CxxRLyekxchfFz9qQZDN5xCO/S8GyHinWs2zClA1vaeXAAY8mOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666489; c=relaxed/simple;
	bh=1eqN4fGhzGayU80/Ck4ie8EzmZzXnviR7/KkMsLuG4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1sPQAl0mqJ88dzqPNn7932rF0mMXmfnmsGO31zvSKNALwRWcFBmcUouiF4p/KaSOw6mEEt4TJaPemnUS1TygOIrjKfLAN9PoJM0SYFh+TQViuHHBIHP4jbvliWQmfC6LdeHe7Pbz1W9T9anuVoRwjqc0QCKkOcdvdYcMLDBTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOsDR9IR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754666485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Trb4QHyh4VHqbF76osaAgQ0EsfsRdUKQSiAhsHdLVCE=;
	b=dOsDR9IR1flHPLpENIFx5ypC3bwzEVLgOHd7Rlgu+bEQfdxvZxsyasw6Okkj+JLy3LobFC
	kqEg7s2g4CR5NsqZQHYlM1Rm/y+DPF9ECYLqNdL6HnH3LV6NjviXLFEIAOeDH23x7BqHmN
	XMiV+EHO7VUPdLWwvmaH7c0KmJR0/yU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-kb5xsjiRPEqGouRI64KuyQ-1; Fri,
 08 Aug 2025 11:21:19 -0400
X-MC-Unique: kb5xsjiRPEqGouRI64KuyQ-1
X-Mimecast-MFC-AGG-ID: kb5xsjiRPEqGouRI64KuyQ_1754666462
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBC5C1800286;
	Fri,  8 Aug 2025 15:21:01 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26001180029B;
	Fri,  8 Aug 2025 15:20:55 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 16/18] cgroup/cpuset: Don't set have_boot_nohz_full without any boot time nohz_full CPU
Date: Fri,  8 Aug 2025 11:19:59 -0400
Message-ID: <20250808152001.20245-7-longman@redhat.com>
In-Reply-To: <20250808151053.19777-1-longman@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

As HK_TYPE_KERNEL_NOISE bit can now be set without any nohz_full CPU
specified at boot time, don't set have_boot_nohz_full in this case.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index de9cb92a0fc7..489708f4e096 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3871,7 +3871,12 @@ int __init cpuset_init(void)
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
-	have_boot_nohz_full = housekeeping_enabled(HK_TYPE_KERNEL_NOISE);
+	/*
+	 * HK_TYPE_KERNEL_NOISE bit can be set without any nohz_full CPU
+	 */
+	have_boot_nohz_full = housekeeping_enabled(HK_TYPE_KERNEL_NOISE) &&
+			      !cpumask_equal(cpu_possible_mask,
+					     housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
 	have_boot_isolcpus  = housekeeping_enabled(HK_TYPE_DOMAIN);
 	if (have_boot_nohz_full) {
 		BUG_ON(!alloc_cpumask_var(&boot_nohz_full_hk_cpus, GFP_KERNEL));
-- 
2.50.0


