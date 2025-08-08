Return-Path: <linux-kselftest+bounces-38581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28DDB1EB88
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B9C87B2C2F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469FD284670;
	Fri,  8 Aug 2025 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xvt5likd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B2283FEF
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666441; cv=none; b=MFQJIttGN5aaWKQ8aCtgJHfmz8bd7GYJ741ePLGfKyZ59pV2tGQhN3yKN1VUMJmeCM52LEi3VYyer4IGMNu6brYJ9FAO7sg69m12NaNZlL8vV8oWquG8QqG6e4xScEo0cbOGd3A7b8VUPPX9yttEcGc/1MK4Czpufu+ARcNcvF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666441; c=relaxed/simple;
	bh=XH0Af+hJDBkCAuw5puHAq55b47h+GZUhJtnbmXxuG6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJs/AstD1iVU0M+ZzIJgEELjQnA8DEfjmqP7bVWo/7dQW/uEl3cYRzcOfPD8EKZ2JfBoZOfRexk7kWMxIxvklChObidzEZyhgn78rbqXGXzFHeTTlHNbV4X85Xz09593QL2Sp7oZAtPUw8R5lUlDrvfyRBNL/2SRKAyRdv/X0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xvt5likd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754666438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WLvzJ5WiuMjAOAmYSD8iakpWVzO3E6xQqHPmy68LCM=;
	b=Xvt5likdeYIGPoo20BWQ50fxb/rNc1nUepkYApFPm3lmSsmz15ZJEbAAr5NhWasRvL6T0o
	Oom6xt28XIoUkTz0gvAW9kR77uXi1ny2OGu2uhu5KulYyI9mBUrk8/t8pi4x2Vr5/T9Gv4
	/10207P3KjM4qgmUkZ6so/x6V9P+oKg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-vUyb1KdwOIq-OmnUSqoLsA-1; Fri,
 08 Aug 2025 11:20:31 -0400
X-MC-Unique: vUyb1KdwOIq-OmnUSqoLsA-1
X-Mimecast-MFC-AGG-ID: vUyb1KdwOIq-OmnUSqoLsA_1754666421
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65E30180028C;
	Fri,  8 Aug 2025 15:20:21 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5657C1800294;
	Fri,  8 Aug 2025 15:20:14 +0000 (UTC)
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
Subject: [RFC PATCH 10/18] sched/core: Ignore DL BW deactivation error if in cpuhp_offline_cb_mode
Date: Fri,  8 Aug 2025 11:19:53 -0400
Message-ID: <20250808152001.20245-1-longman@redhat.com>
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

With the new strategy of using CPU hotplug to improve CPU isolation
and the optimization of delaying sched domain rebuild until the whole
process completes, we can run into a problem in shutting down the last
CPU of a partition and a -EBUSY error may be returned. This -EBUSY
error is caused by failing the DL BW check in dl_bw_deactivate().

As the CPU deactivation is only temporary and it will be brought back
up again in a short moment, there is no point in failing the operation
because of this DL BW error in this transitioning period. Fix this
problem by ignoring this error when in CPU hotplug offline callback mode
(cpuhp_offline_cb_mode is on).

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9f02c047e25b..78f4ba73a9f2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8469,7 +8469,11 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	ret = dl_bw_deactivate(cpu);
 
-	if (ret)
+	/*
+	 * Ignore DL BW error if in cpuhp offline callback mode as CPU
+	 * deactivation is only temporary.
+	 */
+	if (ret && !cpuhp_offline_cb_mode)
 		return ret;
 
 	/*
-- 
2.50.0


