Return-Path: <linux-kselftest+bounces-27409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8FCA433F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4323B604B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9C8245013;
	Tue, 25 Feb 2025 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoTurwJf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80161FAC52;
	Tue, 25 Feb 2025 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455728; cv=none; b=R8PagrY8lAvP+wzUmO6v79tjQsqZo+3smZNBhovxrNIJTI1ozxvdB+aSUloAxRrdHRvk6i1cBcEBGWoAp3sW3He2Pvfh7jmmFH2FzWCHkhG9UtpDzd8cW167hSJ35ydovYcXzpnoYSMcedpYy6KA+jRlap+If4xI1KOB9DRTu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455728; c=relaxed/simple;
	bh=ESQAHp4TWxX9hz7AnJ1W2Ktm+D0hgjSpWAQVAhkjhxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LK+yn60+xoqSni58fizn/zI6WSqaSlwC5Z3vby9TyGXmnMUTd/fnauKQleRNHSOoXdHwQNcdeWDttFHtvvP7h9KgKIuXx5a5fsVZe3wGJ4UonqXtGnpz0sAijEb42Ht/1LaQAHZCVSC49UsGijEdlhqCUr4Htsw+7+TxRoAX3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoTurwJf; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e67fad4671so44877396d6.1;
        Mon, 24 Feb 2025 19:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455726; x=1741060526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XsyEkD9rvPtl257B6PtlDCoSMiAXhw0HwIEgtCwXoUs=;
        b=SoTurwJfzHeYMFMqRTiR9IP4uVcRlOraPHyqBlNMFGNYwTZDadhzIa1UkiMtOTNZxV
         s/++qXvKFXB0CYFS8/zsJdXHjq8vJG64WFmSThYLvINkfPLqnBbNNwjSYFZRN9J3TfNN
         +EUpVHlzeihVobbsMoF/j55K1BvwOcGghPlHNng91x7OB/IkbUkvcbfadXb8ypEjTa7x
         BglGpt9MDVEESlA2Y5iI5uNgYZGPvCRO2ZT9s/1THZFVg/qaXhOxjzWqih58p+fXvdAA
         iwt0jHr1YcxhYLuCUNW2k7d91cbfbSdSURGXXiLCX+uPXP4rXLb1JKRK5wTWbHWZWVHo
         8UXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455726; x=1741060526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsyEkD9rvPtl257B6PtlDCoSMiAXhw0HwIEgtCwXoUs=;
        b=QpkJO825WQKcofWpivbAVedAZSCadr7Tg0bxZ9s73TbNnPC34ayCFKZEopwRJ4UeqJ
         JaeiG3X19FyFeE7gTMX3tKHv8Dd5rWhl8+nyBvwSkoMJLSDtGcI61j3e4mg1fZimiw2t
         0bRTcy9KtwSsiEXIFpHRUupIsgRMRHhWgpIYQlfcyi+MRJuw3tV/HQGWNKIXK0eHAAHQ
         k/Et6QwpVldgHkr7fesdsdkLMQ/6H6MAHph9ecLwHzXDQ46JwW30JCfz9sIudQx/reyx
         4bLfd074T2jfN12z9vj3vbW+CIZVKMxWXIwaLPjATlBrObUOnthTCv5GUeT0wMgR1d7u
         1LYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV82HXkPY+vKhiBAsbj4n6+7JZwtOo01obpvXdmEJecnd2+xkmFFgWYfpUaxTayFYPB86tAjANUt0VGtOA6HZSD@vger.kernel.org, AJvYcCWxLQ/pohsHGu480R5B85PVXVJs2+cHtfF8OL8gzd384mfdd8rx7oxxseFG4PDJvF8bDeOGOHWlPYfB1dK94+oWlw/n@vger.kernel.org, AJvYcCXqBc3fKBMwD/vVwur2g64HFaqUnUIendgEBOJUaUgm1UkXc8KYQGhuFBrS+LKacOP4f8OZSPgXUtihssM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlIQxw3YIOuTtgpAxWin8+KMRGCnp0mlGpB9IbJl8fy4chrEiv
	3IDd5S92iO/9khTcRgOA/X4H9YBczXiJvkj5gBbI4y8JIPEkUjJe
X-Gm-Gg: ASbGncvZiRhXEzxKtytD2LDFPjCBvmCQ62tfteQVt1CHMOnr3b2/EfPOFArY1Ffevm+
	aV5df/WIAyIS5RrmHyi/n7RaAzIc9bGNrSJ+B3HiqWb7HF2zH4e19UMPt/LBVufI5lmnrYNBW2O
	h7ICcN5GBjTyLA8PPvf5ZGZ8OnLxKHRlp0Ni+VJmCZyOnYRxsaVju9W+uyDcOrIO/k3O8PX4V6M
	zineOT2AK+A23zVicyiO6UYXK69mH0DdZvOMXjpY0bEBi3MF4Vtz2zny6YcsF2HuukhKUwusOkH
	6J4i0fInD+TtDHY1xjLWxmJxkGIvgA+aP0jvf6PwjkCujd5meAoUoMvzO45aQlrNW/5WzNAKBQi
	a5h0h99pPT6jdVZM4
X-Google-Smtp-Source: AGHT+IEBeyRItTwAFtwXFvI+3fMU/jftvMugN1ITAqxt40ZuJAixUMZ90OXiQu7DyBZhCeUtaj/dew==
X-Received: by 2002:a05:6214:4009:b0:6d4:1bad:740c with SMTP id 6a1803df08f44-6e6ae7d0bdemr193820706d6.4.1740455725715;
        Mon, 24 Feb 2025 19:55:25 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b156266sm4971406d6.85.2025.02.24.19.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:25 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 832BF1200043;
	Mon, 24 Feb 2025 22:55:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 24 Feb 2025 22:55:24 -0500
X-ME-Sender: <xms:LD-9Z2UJ-MRDlJ-wCsFBUEkKG4QQgJK5_qaUMeqmquR5bRa8fAdjjA>
    <xme:LD-9ZynaHj15l04jZhWNKTlq-hnHHrt5ds_Ln_b6zPUxpW_hJRaigu4icYCMSB8Pj
    dK71GfriShDFt1UjA>
X-ME-Received: <xmr:LD-9Z6YRUGFfid-2EMTnQuYmzXFAiBjX5Xkf2lu0kXfUiJeHGVR12xbJeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeeftddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrd
    huphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgv
    lhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiph
    hlvghtthdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehroh
    hsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:LD-9Z9UT3twBgKFUprsUKAf5ab6QyAqPEh-HkmBdJZ7lb5kcxTM9aw>
    <xmx:LD-9ZwmU_8qpxz4Iygr_3IKvdKIJ0kMY9aHLF2NYBQVQMvDn5P5u5w>
    <xmx:LD-9Zye6BNXao0-s2KkUgKnPEBG-fMnyFZmaF3a-We7Ffn4nKn7j-A>
    <xmx:LD-9ZyHe09KOoJBTRQULZ4xNvpHyaA3bcbL82hx-tnTyyeBJHXqWXQ>
    <xmx:LD-9Z-kG5IqPC6TtiE1h0WNPAjXeTPG1GwDbJUZm0u5S1RaPMCEWmo0o>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:23 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,	Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH rcu 03/11] sched: update __cond_resched comment about RCU quiescent states
Date: Mon, 24 Feb 2025 19:55:08 -0800
Message-Id: <20250225035516.26443-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225035516.26443-1-boqun.feng@gmail.com>
References: <20250225035516.26443-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

Update comment in __cond_resched() clarifying how urgently needed
quiescent state are provided.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 165c90ba64ea..d328707626e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7289,7 +7289,7 @@ int __sched __cond_resched(void)
 		return 1;
 	}
 	/*
-	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
+	 * In PREEMPT_RCU kernels, ->rcu_read_lock_nesting tells the tick
 	 * whether the current CPU is in an RCU read-side critical section,
 	 * so the tick can report quiescent states even for CPUs looping
 	 * in kernel context.  In contrast, in non-preemptible kernels,
@@ -7298,6 +7298,8 @@ int __sched __cond_resched(void)
 	 * RCU quiescent state.  Therefore, the following code causes
 	 * cond_resched() to report a quiescent state, but only when RCU
 	 * is in urgent need of one.
+	 * A third case, preemptible, but non-PREEMPT_RCU provides for
+	 * urgently needed quiescent states via rcu_flavor_sched_clock_irq().
 	 */
 #ifndef CONFIG_PREEMPT_RCU
 	rcu_all_qs();
-- 
2.39.5 (Apple Git-154)


