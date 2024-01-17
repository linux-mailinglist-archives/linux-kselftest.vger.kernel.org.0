Return-Path: <linux-kselftest+bounces-3156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D576B830B2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 17:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE091C2198A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 16:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C09122611;
	Wed, 17 Jan 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EP2svvm2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71010225A4
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509377; cv=none; b=Ijjbr52fUDsTd99eG/Sg+PHsg7wVzfqD0Hc+9y3GAzSTyUHkekWyZZkVt8up1zSrDZqgVdcZEpzsuIFKarfvLzSxuZHM2ynmco6mGKXM6Pgv6hOsWEB/94+RyGaPI+8I2WWZwvp7qkgXgKQc0OJgO7TBEnoLV5xDx+0CcMvWi7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509377; c=relaxed/simple;
	bh=cqoNjlPc6YRXzLiB2bCt5YjvjoQjt75FOzIQ4Y3qvrA=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=VP4umrV9BiHo0yK2DBtAQ7US8vgAr02RsncOhYuxysAC7W1vlolP7Mr/bTwENWmgGihAfvPiRZ8U9MQq7ba/VEZqjeMM79ZDma9zA3IBw6eSQcwTRd63IQv2BgR/g1kVb01y208yUKUdjyCSixill3oPOO68ONZxuKIuYI6j+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EP2svvm2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705509375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6l2z5hmcKTog3XiOuPlPdWnGHwPaZmCTdkb04dCE+c=;
	b=EP2svvm2TpP9kwnXZhjSw+DOoBhzf/bxMVe+uq8uAE1ptz4zIfCMBRqtMsQCtBnIjPmaMP
	32fNp0OMB1gZyqDnwL/B8elPrCyCOpWyuMtEZ9UiCO2oloYUOmAYjRRbiCWoS2WtBME+ho
	OP2PHAm6AcHa+fl2BI0ntnCVSz6HiyY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-NamU-_HuOXOPyQsDLH2XPg-1; Wed,
 17 Jan 2024 11:36:12 -0500
X-MC-Unique: NamU-_HuOXOPyQsDLH2XPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0F6529AC003;
	Wed, 17 Jan 2024 16:36:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 22AAD1121306;
	Wed, 17 Jan 2024 16:36:08 +0000 (UTC)
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
Subject: [RFC PATCH 3/8] rcu/no_cb: Add rcu_nocb_enabled() to expose the rcu_nocb state
Date: Wed, 17 Jan 2024 11:35:06 -0500
Message-Id: <20240117163511.88173-4-longman@redhat.com>
In-Reply-To: <20240117163511.88173-1-longman@redhat.com>
References: <20240117163511.88173-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Add a new rcu_nocb_enabled() helper to expose the rcu_nocb state
to other kernel subsystems like cpuset.  That will allow cpuset to
determine if RCU no-callback can be enabled on isolated CPUs within
isolated partitions. If so, the corresponding RCU functions can be
called to enable it when full CPU isolation is requested.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rcupdate.h |  6 ++++++
 kernel/rcu/tree_nocb.h   | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b649344075d2..976d55a3e523 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -120,6 +120,12 @@ void rcu_init(void);
 extern int rcu_scheduler_active;
 void rcu_sched_clock_irq(int user);
 
+#ifdef CONFIG_RCU_NOCB_CPU
+int rcu_nocb_enabled(struct cpumask *out_mask);
+#else
+static inline int rcu_nocb_enabled(struct cpumask *out_mask) { return 0; }
+#endif
+
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void rcu_init_tasks_generic(void);
 #else
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index bbcf6f4152a3..020a347ccd52 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -81,6 +81,18 @@ static int __init parse_rcu_nocb_poll(char *arg)
 }
 __setup("rcu_nocb_poll", parse_rcu_nocb_poll);
 
+/*
+ * Return the rcu_nocb state & optionally copy out rcu_nocb_mask.
+ */
+int rcu_nocb_enabled(struct cpumask *out_mask)
+{
+	if (!rcu_state.nocb_is_setup)
+		return 0;
+	if (out_mask)
+		cpumask_copy(out_mask, rcu_nocb_mask);
+	return 1;
+}
+
 /*
  * Don't bother bypassing ->cblist if the call_rcu() rate is low.
  * After all, the main point of bypassing is to avoid lock contention
-- 
2.39.3


