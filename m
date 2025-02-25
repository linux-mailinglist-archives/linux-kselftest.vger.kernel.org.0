Return-Path: <linux-kselftest+bounces-27410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDBEA433F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E053B5FCC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F5B24EF96;
	Tue, 25 Feb 2025 03:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6TgZHoQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1D1F5EA;
	Tue, 25 Feb 2025 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455729; cv=none; b=AQ4wahre8KU154QyS1PxEUxRGQA1o2QaMqFmxfLYfyUW9EstvFCTncCb5+D35h0WNB0g7k7i+dejodIY0ULriCRp8Bp2d1Ja6Qp3cjbk3egBMMS/JlAw2v0wgZmKt/9acF1aQyYds+ilOZUVPRsGzQIFU+jf/0lKRRbxWtawfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455729; c=relaxed/simple;
	bh=N77KqbFVCj3RUrUBBHfg6qA4TgoamCkJ9sF4ME/N0iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRZ8yES9/04CGU6x5WgNfBRvDNXEeLgnPSPUIUJ23b1qyxE1f1SUzXiJmuV3XMnFZqV458RUwGKdh4GT1LVD4L3Yo/dcA4cQLLo+Yld8yojv+4kyjlo205EBmkxKKNbF1RB8KWs1rPXbmGTVx7Iued9fXTTTaYgDyqx09r9k6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6TgZHoQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0848d475cso733078185a.2;
        Mon, 24 Feb 2025 19:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455727; x=1741060527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6bZjSIhc7HiilOm6x/1wfoYX7rNiE79eoPzAm1Y0WKw=;
        b=i6TgZHoQ/RMyvw98bRrOwmlHNpPi0IDP+aTHHsjQ5QuR3CzktNAQRR3UNypekzwTKP
         YPo/5d1PJlh6xAuu2jnWgMSYhrCTDjpX+23ZL8XinXHSiKimS6ESyBMhtXM9dmadmgXX
         Fyehhg+yEDtnyNdmBIMJBCnn7VEQLkOqhcm9bn+dTtplZgW0N2D2MvksQqJphb0WjX/j
         YYjdu5vKx/Tx8zoQko8klrM1iKx+nDz2VbgKU/uLwl0npU8S3o75KkuTwbD6Nn9vtoRK
         qJmma7qZ+tM84vlxj/2KaQXoXUVw8mvIYd7UUGuY9GxSoqibJUzM8lM+D79tuI9leF0f
         HDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455727; x=1741060527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bZjSIhc7HiilOm6x/1wfoYX7rNiE79eoPzAm1Y0WKw=;
        b=n6ahyp8YuFUWX+yZXvYLvGOpsB8TfldbMa+CRVgCySfZ/7p67wxYhECdVbP7nLaDfS
         zHeQs7Damug36D9FBh+lu3ehCyKYbBhWdAbqUFFYeA14lb7ncjRx9F7IyNQWueymxRuc
         o81N4FlCuDkmPEfZRZbch3Yidw+xu7QnFC5z/1I92KIW/67vuq6BM7dtnarYCaFrJdMt
         2oO08wOyzPRRbP89IpguvP382/QdN5XVYfzU7NzRUPsDOxvpcpqnr+QHh6vQQRoTLdkW
         7dFooUJqf6i3tHw44nRTDjSINoWIfPUKM7w69EtmjSHDvSXFxesMSr3xnFiuVHIeWFFO
         ZzNg==
X-Forwarded-Encrypted: i=1; AJvYcCWbqXTDrD24Ze69B6TR4nuDt/H2d0GYMkU/m/ubEX9ifRp2lhDfAZofgZJJDuZM2AFgu85chW5ZmCyOIllMvfHL@vger.kernel.org, AJvYcCX8KaJXuxPgB2OO90UCXd9Y8tme/jZa3YSWxRUMe8hlb1/y7va+Au7jK3H/ZBdT+RFcprmjWszh6Czx1tGT7t45rK3H@vger.kernel.org, AJvYcCXtoaya/sGccy5hpMLwSW5Cm5v6uew6kux+2qtJ451Fet7BMhZiLQ2Hx5bUdOPDoPJDABLYbVztOAIaXfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0aZ9cRrXGgenEI63wi8c0AgoyG6s/eokKIjv6OzIWB31NaA7
	BYbZbeOkdo0AUNX+yM2YGCAP9EmcIgtRTK3ba/3aq2rcri67F68V
X-Gm-Gg: ASbGncvPxHV6pRw56pviRKT2CMsfsHisS3lGLCELjcB6//j7sFZqcjDLefU8M5A+irn
	Ii6syTk0Mfs+DPDar614I/SUyRNYUPzjbrngRLa2susROCCVEGvraEbtWAfsevizY6jYPwfBsf1
	8Kf5JUkjvGzRihYTdC8cZ0A8kqN674SLYkn+49sqfO5kO0clVj4WAZxB7hw1gFzhHqwBMgZ9Fa4
	hpxZcXHdcvuArcGUYfaNcVvHk5i99F4cUmZDHALDQznTtpkFDYT9UI4UFOE3E8AJYRMVHe0UR6k
	9TaG0d3p00MAER0RVkNiN6IxGEJP52VPraHml2KqbO6bYzpa7y+D+SqidXzZ//UBLkwkU6JcxO2
	wDnVmTEUvx6QUHS4X
X-Google-Smtp-Source: AGHT+IEC0C0d+DYM8KdIaUvUgJgks+JgO4LiPSAwNKNuUQIS0gx2Q8fQIw/0qV9UDTxtFURTT38lEg==
X-Received: by 2002:a05:620a:f02:b0:7c0:a389:f26f with SMTP id af79cd13be357-7c23c047145mr175846085a.56.1740455727170;
        Mon, 24 Feb 2025 19:55:27 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c2992ffsm60738785a.7.2025.02.24.19.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:26 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F0B7B1200043;
	Mon, 24 Feb 2025 22:55:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Feb 2025 22:55:25 -0500
X-ME-Sender: <xms:LT-9Z94wqxXEYd4aQd8FQQBiH3TCBbiDYF-MPjfU6ZXFbLuSQPPPYw>
    <xme:LT-9Z65eaeBmrbM5QPhBbQ-Wi8wJ5pgHWJgSomr214ztzKZ2Inhfo6Lj92C987FnF
    jv58jRB_fXQDmue-w>
X-ME-Received: <xmr:LT-9Z0f8tVthd4rh6FLd-k3bZEpE3Nwk3fB-8YMTfHh8meFFWihfY9WQEw>
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
X-ME-Proxy: <xmx:LT-9Z2Kge_WH8db9hxIRgKx0JEF9dZhmCPkZT2LPYp1XKLI2x5uTlQ>
    <xmx:LT-9ZxIaV6oovYWBbGLhe0Pjj4lNrQNGl4JwLaZaAbC5gFu-W7M7aA>
    <xmx:LT-9Z_zhAO4j5QbU50oKFaHgHOi5YeootZcSw0g4TG-OYx9-3nDKAg>
    <xmx:LT-9Z9IxVnDpg55DtbFw2prqduNbfmznnAjDG-IRQJPJ47Kat1Cw7Q>
    <xmx:LT-9Z0avvlfckIdmAmRwyrnZyynz_10N1ggMfdUkeDhgCF8GHfoLfMfg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:25 -0500 (EST)
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
Subject: [PATCH rcu 04/11] rcu: handle unstable rdp in rcu_read_unlock_strict()
Date: Mon, 24 Feb 2025 19:55:09 -0800
Message-Id: <20250225035516.26443-5-boqun.feng@gmail.com>
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

rcu_read_unlock_strict() can be called with preemption enabled
which can make for an unstable rdp and a racy norm value.

Fix this by dropping the preempt-count in __rcu_read_unlock()
after the call to rcu_read_unlock_strict(), adjusting the
preempt-count check appropriately.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rcupdate.h |  2 +-
 kernel/rcu/tree_plugin.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48e5c03df1dd..257e9ae34414 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
 
 static inline void __rcu_read_unlock(void)
 {
-	preempt_enable();
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		rcu_read_unlock_strict();
+	preempt_enable();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3600152b858e..9573408a9800 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -833,8 +833,17 @@ void rcu_read_unlock_strict(void)
 {
 	struct rcu_data *rdp;
 
-	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+	if (irqs_disabled() || in_atomic_preempt_off() || !rcu_state.gp_kthread)
 		return;
+
+	/*
+	 * rcu_report_qs_rdp() can only be invoked with a stable rdp and
+	 * from the local CPU.
+	 *
+	 * The in_atomic_preempt_off() check ensures that we come here holding
+	 * the last preempt_count (which will get dropped once we return to
+	 * __rcu_read_unlock().
+	 */
 	rdp = this_cpu_ptr(&rcu_data);
 	rdp->cpu_no_qs.b.norm = false;
 	rcu_report_qs_rdp(rdp);
-- 
2.39.5 (Apple Git-154)


