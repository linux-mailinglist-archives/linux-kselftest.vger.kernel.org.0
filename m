Return-Path: <linux-kselftest+bounces-27411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD65A433F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB54176329
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E312512E4;
	Tue, 25 Feb 2025 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q92DnqcU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EA1624F8;
	Tue, 25 Feb 2025 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455731; cv=none; b=LlxtvM6UtpT/6gRryuLntVI7VUQv/qOZrCKseffegHvMQeJaMAuam2KxOHCdclwKIGiSj4v1y/6h4u9Adwn7aN7VKqZ4Ss7u2vHdk18uMMZ1N5ZPLToXSDBWW7W+s1X+GOIwdAh4/BycJrF6OtOETX3/rbbPMIuEAplZefNZuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455731; c=relaxed/simple;
	bh=+xWSr+nkJ64yuyk2bAtOMGffsUZkkwlgArf+svUx41k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y27l1Ff6E9de04PTY2UmpUV8TerX6voY5cuQrRO9yFYApWkWAAtVz98ssk2c0I/Xhvw9iQWEj9meHN16bA4EP7OAp2IyxLdAzMVrGws28lo7fbmBIHRvttq/9nhBaZres41Z0iA6Yo2G3J17QqJqRPdiKEY5FVAmNGAUtlKmKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q92DnqcU; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0892e4b19so618526585a.3;
        Mon, 24 Feb 2025 19:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455728; x=1741060528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jdozoCwQSzFwrrBbMNFpZ8ApNw9FrREQJIW7RONrtaw=;
        b=Q92DnqcUNMhWvJPA8wEbk6/EfjU29KXL8I0QfW5t/DtmCYvqghfIQoEER2OzElAbw0
         VXEymbwS9VcVkHkK7U0tiuvrcf5453N4bG4HXvHgMuwkWwLUtWySRTwxsGGj9Ut4ODKJ
         NKOY4rufoKRejCYqKpz0NN17KXwg8eyGnqGKih1SfLz8/gzQ/BULue9aFvGZdzfImFFp
         Nce4KABWQOMZpkVXJy38VPnvF/rFyD1f0NMTxanZKa6Xn1iePwRKCVc0scVKw5b5xv5Q
         1FSq2zFlcPnFu/ncRIh8ESPirHv0NNZx21PAqN7NJMy5l12R1+DcPc8duAyUq8NtE3u0
         Z7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455728; x=1741060528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdozoCwQSzFwrrBbMNFpZ8ApNw9FrREQJIW7RONrtaw=;
        b=GbkCuMk1oWQX0h0GbNROoa2QfXPW/aKKYVwy754o/a9RT1uPPOiiPHbWe0CnKZkXmQ
         ve8i36X+p6u4skyoEPdNYZ9Jm0gsbZkrurC7HbjaS9ZwqIXkr1QgNdNPk01PX4mnWzgT
         rPH2ADeiSOI/yRlBjvoM5Uwon9qjTRNmMfd5xy8g9rt2vx1+N5WNvW5e/SLTZNc0rHDw
         JUB2HHlR/4iFeR98o5UvC9hqgCU9FaLmJJnz0oU1cF3DWQws7MSmKbHZBG/8T9nt0nZG
         Mim4C1EnyVkILqubGYq3Ip4wpxeTdxyuJ11DOyzByrL290h0y1mfNYiCaA7UPIsYiefM
         OJhg==
X-Forwarded-Encrypted: i=1; AJvYcCV9eXusX3xL7t9mK4FEFq/admPDLGxvM4qQyfPDr/1qY4qgTZ7Q2sYycuYOsMMWVqU35Q9bcPLb8wDQsmf2eTN6xkyy@vger.kernel.org, AJvYcCVBKgcVCk0QqePrkLmK6nA7QFvwypRofOHxSDd2s3UpaLfmy7IiXDgjIlWox25Y0vJxNx18F9wxdYFb9N25e7FW@vger.kernel.org, AJvYcCX6j1C4UkCougBuYMQDcyEl7sx7YfgSTlpYPUX3WW50VrqETzZ7y22XrCPI4WLjeluFpizbKGGtuGmG55A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCiDoMJudwbYnRtEFwpPn70YjwmmoOXplAb/lf5UHah2nmM+cQ
	D78BcHiFU4hp3bemvmLdO3IjJ4oxVgYDAygVAP8VBA4k070mJDCE
X-Gm-Gg: ASbGncsZwuqZNs1LJN1dZDt5155vg6CyWBdNQft5xELC5MZUYLMZo2OrOwYpFFBF/Sr
	WSSMTDX2v3IA/ZDSHffqB0mSlyWQkZkaZaKi7TeLy/FtjqDiUPSdGxkjTtXcN8A2GmAog5eCE9l
	ff+AuEsiK8F7CkNwLUmVQYllWSt54+YEZxltY6vOn3C92cENVB4YNNLLt7locHLAfSlK5rHUELV
	Jbja+gfN0hGxECEsZQnce6EHfDsusCFOQtg1jB/Ayzbujwhw+KFLdScFRUkL+6zdm/n3cRLPRvs
	KCEfObi/gCb7YkuX0BoaXNboX2pi1CO5QdKMLEApkR7tXkOlQpVBrm3UiK7/m96Xmgz1vBgndO7
	Ds5n8ZvROF2h0z16o
X-Google-Smtp-Source: AGHT+IFTwNMKfPJKSVdkAd2wzvyYLeX43jvuaeqy4yYDCxwRmbSxY2gEiMA5fWXJHX7/6sVrC3Ghhw==
X-Received: by 2002:a05:620a:4606:b0:7c0:7d34:6a7b with SMTP id af79cd13be357-7c0ceefe59cmr2223508885a.19.1740455728549;
        Mon, 24 Feb 2025 19:55:28 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c2c241dsm60007785a.58.2025.02.24.19.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:28 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6B68B1200043;
	Mon, 24 Feb 2025 22:55:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 24 Feb 2025 22:55:27 -0500
X-ME-Sender: <xms:Lz-9Z1ntkdjB-ig_XPh83pP8VtIJZhM_mp8c0GTmZf2It08_6g-6sA>
    <xme:Lz-9Zw0hYpVlIsjQxPH3BZYQlvWB_1kiTLBxD0_SX_g_ZmfsORfZm1C9VTiUGfB0F
    jbFKUIE2EFWId7elQ>
X-ME-Received: <xmr:Lz-9Z7oY1nnwz51wobKv6Et71hWNkyMzylWcCfs3Y4KLc9hAYCuncQ0RZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
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
X-ME-Proxy: <xmx:Lz-9Z1kPu5YaqLrnWSfvXJIvMKwBFrnwnsTWZI4XCBXDTZNcY-u_VA>
    <xmx:Lz-9Zz1Dv81tx_ttsaFyq1QJe-8B6AzkGJ8g3EqsAvS-JcfA2F-Vcw>
    <xmx:Lz-9Z0sL-9OBc9_Ac-vlNfMkOYHmC4t3lcyi5OQR0_6sXuDkYzPATA>
    <xmx:Lz-9Z3XCyrPSaYPqtSpnQnKeGfxCMWMowDC1ynszNxCKmNkUo_7McA>
    <xmx:Lz-9Z622lnr25oL4SH-gxvSuf-mFwlA67Gi8WGXBtmfpqKpSiEWRqwHg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:26 -0500 (EST)
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
Subject: [PATCH rcu 05/11] rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Mon, 24 Feb 2025 19:55:10 -0800
Message-Id: <20250225035516.26443-6-boqun.feng@gmail.com>
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

With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
states for read-side critical sections via rcu_all_qs().
One reason why this was needed: lacking preempt-count, the tick
handler has no way of knowing whether it is executing in a
read-side critical section or not.

With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), we get (PREEMPT_COUNT=y,
PREEMPT_RCU=n). In this configuration cond_resched() is a stub and
does not provide quiescent states via rcu_all_qs().
(PREEMPT_RCU=y provides this information via rcu_read_unlock() and
its nesting counter.)

So, use the availability of preempt_count() to report quiescent states
in rcu_flavor_sched_clock_irq().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_plugin.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9573408a9800..3c0bbbbb686f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -984,13 +984,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
+	      (preempt_count() == HARDIRQ_OFFSET))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
+		 * mode, from the idle loop without this being a nested
+		 * interrupt, or while not holding the task preempt count
+		 * (with PREEMPT_COUNT=y). In this case, the CPU is in a
+		 * quiescent state, so note it.
 		 *
 		 * No memory barrier is required here because rcu_qs()
 		 * references only CPU-local variables that other CPUs
-- 
2.39.5 (Apple Git-154)


