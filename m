Return-Path: <linux-kselftest+bounces-48077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F300CEF103
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 18:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC5F3012DCE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 17:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0393E2C15B4;
	Fri,  2 Jan 2026 17:28:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32845273D6F;
	Fri,  2 Jan 2026 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767374886; cv=none; b=cqGUCrlu14aY9SqyToPrcY/TgzKuNz/igt0k2lV1QsE2S1x53shg/Nog5Zij6iFC4NV0MtC3B5PMzGAji58CAEOEJIImaxwqK0T8SmDl8oLNi9V5ifD/6XBIjg4o1WZ6AXvlWGvO3xztCZVtTfr7WL+WLUm254m6EKP8VGTjqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767374886; c=relaxed/simple;
	bh=HDEklz74cJKP0YY9u1fWzB2J8PLNmG1ItYrspOZ6ZxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByERN3E7o29Meh4S/wAhwGCldv1YeT9d5LzU2mMSIeNsP0yp6r/652cqXfsgrKpyiaLcGXn6HMiKIKqiOIA4Fc7RSgl3OrydzcQpc8vkKpitSjJ8adULKOVqY0tf8772ajSpangj5QoKdE706cDZjsLgdrsvVElOc/yKIIkrCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 252D01A9BFD;
	Fri,  2 Jan 2026 17:27:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id EF31720028;
	Fri,  2 Jan 2026 17:27:52 +0000 (UTC)
Date: Fri, 2 Jan 2026 12:28:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, rcu@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Yao Kai <yaokai34@huawei.com>, Tengda Wu
 <wutengda2@huawei.com>
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
Message-ID: <20260102122807.7025fc87@gandalf.local.home>
In-Reply-To: <20260101163417.1065705-2-joelagnelf@nvidia.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
	<20260101163417.1065705-2-joelagnelf@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3z3xpmc55fu1sjw9ux1rkbxsqr71aou4
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: EF31720028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19/w2ihao5rEYRKvtDq4SdcUQAszhtzHoM=
X-HE-Tag: 1767374872-670284
X-HE-Meta: U2FsdGVkX1/KNvOP6mOPw13hEiOdLPG5nsP9wrAUotaqvMB5tyOkUGnYnQ1y+LtArulRKlCvXkSIOgFHO3MqIk5WhrRXnFubNYIKZjmYx+SDb7NKAJS77xzlOfyJivDO/z8Gf7+PeIMOtOFiHqPvjwEbAFgo0/GBw+T01WU8SKuG3YQgqPJEGvQ0qqgnT7xZzewy3TAcQE2GDM6TC6grWERV3f2VQoFmEdHUqZr6m/Zg+dUjwaqic15BmleWnUxrZBnu9Yx+LnbhHyBXDqWQzZDJ0pbpplg3NgYP1p1ULQnd/PnaAoh7I/jw8mycnOaqJPTW3eoKXNgWxnCT1BAjntglY5x6OhBG

On Thu,  1 Jan 2026 11:34:10 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  unwind_next_frame+0x203/0x9b0
>  __unwind_start+0x15d/0x1c0
>  arch_stack_walk+0x62/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  unwind_next_frame+0x203/0x9b0
>  __unwind_start+0x15d/0x1c0
>  arch_stack_walk+0x62/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180

Stacktrace should have recursion protection too.

Can you try this patch to see if it would have fixed the problem too?

-- Steve

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index ae04054a1be3..e6ca052b2a85 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -34,6 +34,13 @@ enum {
 	TRACE_INTERNAL_SIRQ_BIT,
 	TRACE_INTERNAL_TRANSITION_BIT,
 
+	/* Internal event use recursion bits */
+	TRACE_INTERNAL_EVENT_BIT,
+	TRACE_INTERNAL_EVENT_NMI_BIT,
+	TRACE_INTERNAL_EVENT_IRQ_BIT,
+	TRACE_INTERNAL_EVENT_SIRQ_BIT,
+	TRACE_INTERNAL_EVENT_TRANSITION_BIT,
+
 	TRACE_BRANCH_BIT,
 /*
  * Abuse of the trace_recursion.
@@ -58,6 +65,8 @@ enum {
 
 #define TRACE_LIST_START	TRACE_INTERNAL_BIT
 
+#define TRACE_EVENT_START	TRACE_INTERNAL_EVENT_BIT
+
 #define TRACE_CONTEXT_MASK	((1 << (TRACE_LIST_START + TRACE_CONTEXT_BITS)) - 1)
 
 /*
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2d387d56dcd4..e145d1c7f604 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3013,6 +3013,11 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	int stackidx;
+	int bit;
+
+	bit = trace_test_and_set_recursion(_THIS_IP_, _RET_IP_, TRACE_EVENT_START);
+	if (bit < 0)
+		return;
 
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
@@ -3081,6 +3086,7 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 	/* Again, don't let gcc optimize things here */
 	barrier();
 	__this_cpu_dec(ftrace_stack_reserve);
+	trace_clear_recursion(bit);
 }
 
 static inline void ftrace_trace_stack(struct trace_array *tr,

