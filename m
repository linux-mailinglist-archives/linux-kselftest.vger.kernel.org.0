Return-Path: <linux-kselftest+bounces-27416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC40A43402
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AC8176336
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC78256C8A;
	Tue, 25 Feb 2025 03:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/wtI3DN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228281A2393;
	Tue, 25 Feb 2025 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455738; cv=none; b=Ys5hRy86luALhxh/8/rESmXI4xezZR4kXxfrkWYIJL0+F0uyyN35piErYnvqh7m4oDq07u+UnB40iUc3D9YA2Yi115eXxsqDTlEM4/GY3V4eLsHOEGqI+ERGbnk+bx8bbufVFFvHYNeBUJBk4zzTHwKxUkcp15VWRtITWOohwrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455738; c=relaxed/simple;
	bh=IhkoHcLkUW1HTDPz7nFHSIO9D1UaWcIW0uk1mkBzn9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+Nzf2lW8a+iZqdBgOweYN4UMzWF3vzU9kFZE7sUCQtjdyX+gPAvjMqglHt4O2zGKnk5HiHhuPGoS0/695aW5ZpkTgOmE1tuVdYDJ3mExqZBJjwx+RhoKFUgZXJT6IUpjMhc+wQlqymvUHde3OhbU96VU0oHqaLszHlbc1kd338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/wtI3DN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47210a94356so41102451cf.3;
        Mon, 24 Feb 2025 19:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455736; x=1741060536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jXC9zawY7wJtvjckwQj8TFr/iOcB1jE0LV9gQoKP54I=;
        b=Z/wtI3DN4HZIZekchGXDUt8SYb8oSB0KavIddHY7hZdL52WgOlDWbPZ4KJv0j35C8a
         +g/CwJv5bWzGPNG1BCcMim0oM9c3rdnTGPpqTbLzkKNYOzLyBN/k1/ce3I+hqm0ZdfNQ
         WYK2wEoS0kveuR0K+DsGMaPCGbn+FcYoA26N474N21w7myJiJWnJEz/NdXxWleVOwUkk
         ZohglnebcMS42xUeRl9YwrHKoeQPH57NpyT1GxID99RyDERfhWjHa0tbn/1BYm6iyXRe
         gu3bDhqcalccOrlZkUNb0UY0oC2w3EZQkNCzZn7bF/pqxr9ddSpcFrOjPzigy614laTY
         oStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455736; x=1741060536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXC9zawY7wJtvjckwQj8TFr/iOcB1jE0LV9gQoKP54I=;
        b=LnnGWzJAA7W764Jqq88yf71hKAhgjSmoTl//5cZsobBYtOqHufZksYiyAAzpZlrLyp
         vHew8YLZbQT6k7apa8J0XUv1zVI0U0ckS6ncj5nVVeHjpA6ejM1iH7IzNWzVhzUbrTax
         QhTB+ddMLFjFsXGI1dhWDkOW9YvzDtk5LVqDFOmMiAcQCuuRNLuC/n0auK46C8RjtIxN
         b3tCcPGJceoJUzzDKDdytRHDJlu4L6slLN4sMk7SjP72AbCg5YN29RULoE1UxtKrw84z
         or3Ova0+I50PWlSI2vGuVjjnkbwrGvYGfstknRgn7BghrbooDBW4pq3kVgeyKnQeSAm2
         gVQw==
X-Forwarded-Encrypted: i=1; AJvYcCURexsYCQpLZET/cu8KJgyvRwGK56SBAZqW1p21CQ+/7Bn2sIsOd/jpq9zVJBZfCeh3nOJOnUKgwW+ZJ5YN8+7F@vger.kernel.org, AJvYcCWFQ+3/d8Ah+kzYgkbLB3f3wqSF3okeWa7i8Kc2yv3EGYRo0fXVHhCMKcudad9F+rNHUYn6ffMWS4au+oA=@vger.kernel.org, AJvYcCX8de0PolR13KyrNp/He5fbGZHH/1Kh8lICZnNV3bScpjsxbXQWqHCsF6Szlr0oT1xcWKI8v5ie6CqDpBKi7N31yFtK@vger.kernel.org
X-Gm-Message-State: AOJu0YwKsSa/LzZtKJut24xR2WPtcEi64cSL0N4FzzlDR/mflWApwJ+B
	kBYPHudXai3X23n41PSmBuci45d0uAyJ98YyHgT7UlGEHzVETcVw
X-Gm-Gg: ASbGncvam9mMEH+1ThIB+Taph4rmq67kcaK7qDvO2D8lCZ+12OKBAysp1KX+F0UQa0D
	tenMhvOT7OO8P87eL1JHEZIUyWpch1CUlz5RVFBJzgFOTX2RPLsDVQoa3Y4DLmTy+UnXHohK7ez
	AqiTj8kbb66DwaGiVEqbsboZSq5kOALyQpDY76s9slMkKnkcmhDfTTErwGJQPYFLsWK1mjc9zyG
	nBa7zWpB2jBUXJLHb1KYwsZAKjFwNXaiGZgk01o192Fj0xX6B9iRumSU1DWIT09YgaJg7Tpf56Q
	3gSkGX062GJTFZcMjgho04e2rIRYbkMxrC5bOL8h+sRDutYWUk8/XrBttMNreI9bfE4ws+jQXrE
	f3CPmx1STilPJys/+
X-Google-Smtp-Source: AGHT+IF0ja1Sg/mWiJyMe7MASVqniJnXWzUOGt9oWixkxEnaidRrfPol1LofMc9zJH82mMa3+AMz3w==
X-Received: by 2002:ac8:604d:0:b0:472:dff:37fa with SMTP id d75a77b69052e-473772707c8mr22740771cf.47.1740455736147;
        Mon, 24 Feb 2025 19:55:36 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e24caasm5271531cf.47.2025.02.24.19.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:35 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id D024D1200043;
	Mon, 24 Feb 2025 22:55:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 24 Feb 2025 22:55:34 -0500
X-ME-Sender: <xms:Nj-9Z5gpLwUEVmEiMNzFLH1TF2z5MRVJFbw84AITSFs1uSrhx-I-Nw>
    <xme:Nj-9Z-BhiQSNC-4vtgfgAIXzYXgWw6_dd6gl4jOMDhQf-wgyU9R1KVz7SvVFHekTo
    hq5f026-3_dLQCTJQ>
X-ME-Received: <xmr:Nj-9Z5FETs7guUaqS1loXBmXD7loiYDHLxKMpkZ5e4abDEd-xJ9CJG_bNw>
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
X-ME-Proxy: <xmx:Nj-9Z-TjfGGwG10TA8JgEywmtax-TZNqQLlnkgJlKHEHnl7eYNvYfg>
    <xmx:Nj-9Z2ykX8GDx5Etcy0_Er8EUFWdA8dfk_oxdsw2VXNRAsXOnXbNCQ>
    <xmx:Nj-9Z06m6P8cm-giL490TcnWc0Q2QqNwZAMePKm95Iz6OzaidRw6eg>
    <xmx:Nj-9Z7x0_mEDYstQH0MkTBKVtxcVRD3A314djWeI1WFVcg1AT9twww>
    <xmx:Nj-9Z-hoOQSinSK3_JVRLGXLNRoCgXlJowZ40jnJXrsIa33TqSrYiZKb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:34 -0500 (EST)
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
Subject: [PATCH rcu 10/11] rcutorture: Make scenario TREE10 build CONFIG_PREEMPT_LAZY=y
Date: Mon, 24 Feb 2025 19:55:15 -0800
Message-Id: <20250225035516.26443-11-boqun.feng@gmail.com>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit tests lazy preemption by causing the TREE10 rcutorture
scenario to build its kernel with CONFIG_PREEMPT_LAZY=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE10 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index 759ee51d3ddc..420632b030dc 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -1,6 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=74
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_LAZY=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
-- 
2.39.5 (Apple Git-154)


