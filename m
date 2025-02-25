Return-Path: <linux-kselftest+bounces-27414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EBFA43401
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B547D7AAEB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426A2566FB;
	Tue, 25 Feb 2025 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WacBkQSY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5112255E4E;
	Tue, 25 Feb 2025 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455737; cv=none; b=omfo8PepqzB1fmETXF/xuy/SYtvnmyqzqrfRVT23jkiLoycpbKLC+YwaBCrHTdT3nQTFXx55j/bi8HL8VjGfZj60xhu3pYFnVwyBcAC5r22feQezEbqNqmFZGWdYPLPqnEx0IOhAiTycmDlQ0jQGx2y+3IvpLb42GsM8XOY3EHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455737; c=relaxed/simple;
	bh=tmww1+SJua+4wlLpPC9mhEo3DKU5TCZTK6AeKQiu02g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Amyf7vEe/AB95M7uP0Rl2eey3/Lppocf+NJ+Gh//azPFrxP1uomgcqJwqwUgiAhXf5pz9CRu8hDGYflx8/YjFLainufbfMM4kpWgBqDvAjQuJyTJ5jPCv228RGzAZHfEIa/aKxYHiPgiBrwBpxmmD34WRnP3QZHM2iqvTWjeOIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WacBkQSY; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e660740061so46365166d6.3;
        Mon, 24 Feb 2025 19:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455734; x=1741060534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9uLvu0VnuSfBzmKR1xOZZZMcPxk+1xKCMKGMXIs8E2g=;
        b=WacBkQSY4Qbr8WiEcTJSjw3qb4v4HvC01Fg4Leq4Lzk1zKnWS4k72SuUz9feTX6V+p
         yimedAUE207rhIVfQF3JSkhWDslNvd5vCHJwOKCtjA8gyyKOV8NnHIL7WZqRfyIOXeL4
         lP60ulRvV0qEzAFMIGtElDcsfcBPRGK2FbHfyTRAmTrQReEXvcm/TpCaRxzKsscHWFi4
         pTo5cRhHmSn26vKP8HqDUvWKezrBy5ic+vpI0VEMvvlluTLnfPY2DxXzHyVg+zHfvenO
         qEjGST+WOC4+lQSNkI9wJN8ezyUYykDlPI/xbj9ytRNk7uiGNLZZiD5pnjDMYbyO12Qm
         dCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455734; x=1741060534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uLvu0VnuSfBzmKR1xOZZZMcPxk+1xKCMKGMXIs8E2g=;
        b=EAc/0+bkc2O19s9/LjV3jLj5240hfh2EYybByTfz8v8H4hy2RWiK3qXQt0MyVAULOP
         IfGscb2SAqB1kcv4AkW0qlkFEQHDYIQ13OZRAPY01GiECuxAw30E8yKrDeHHNX5rpYCo
         4n+eKAeKhz92wVjzUFSt3x5plLdUhgmu13uAt5qN+yRdOiXITYFqwumzE/ZNUxFdJEzG
         RljCFOBqxJYI6s+HW8XnlPMixjDX132ylFIWwD7IurkUTdcai9klUg7OlcAUYRjkpHkf
         Sb1uoGXiJKt0AhwUYrkhgFvsh3WLheMUvrj7/pro6pMk+sjMBcGR964G+hXkkZFK2ttl
         WpTw==
X-Forwarded-Encrypted: i=1; AJvYcCVA37CNIEtkOcGucfL8fsfrNM8YJVX0TvQPcbR1IrC6Az/M+aHKxSu9Nlll2WBndrgBEagxVbziN9a0PIE=@vger.kernel.org, AJvYcCWoNJjMWkUPASRu0hpRK5MHYZcjQJhTvLXMICFeZPz/sPvdCEbkbPsp6AN3SRfytcBrb0JDt+4p6LIOGhwd8mHV/jH4@vger.kernel.org, AJvYcCWxUr15q7oBLldPbjfhDvTjP9UEkVJI5e6oZuwMTv99FVx+RLGBWRDFBX8Pk8eiDbomFKJf3poqazgeKDbc7PM4@vger.kernel.org
X-Gm-Message-State: AOJu0YzyP5HGPhl3WKbSULR7dzETeeagHITOpxlexeNRS31w3zGRFGv1
	W623NBplR+Ts42Vqn0ceWWOzKUcbSmGf0UXx5Rqo89PcSCBbbYy0
X-Gm-Gg: ASbGncsWFNZJZA9jYV3d+yk78obw+xLoMk3Rl2ozkJnH+AsISUNHAv9QWBXsGoVcFX8
	cPKuaYo0AzeRBAq3UWdBh349Z2CRwQtvEACfWB/dzt3P9KoYxjpRpOLetV8HWyoPfrd4Cz1k7OC
	f34XHrQA/kYpmxRM55G/TrqemnDoS6IPusPzyY33cNRV5sysdVSGCBcP9RiI53w8ml2oFPEvb0J
	FhOpx5OQC4iwcsKWZLgfA94IFG98QCuqiSIG2ISvr73aqXJo9vn8jofMvG9AopH3fvnCsKa/FKt
	Wisd/TEuL+v0v7dj6I5v8o57nQJ3lHjNtcMxvoSTU3boMGJnD+DvdOhIPoHfj31W5kl4x22swVl
	D2d80x5wTL+cvklQM
X-Google-Smtp-Source: AGHT+IHYqFDwVuL07beYvSc+yBY4v+L4a9R4xbWY8aepATv/v35vL6NgV1lYDMvgzLPG6DxzRx216w==
X-Received: by 2002:a05:6214:5190:b0:6d8:8109:a547 with SMTP id 6a1803df08f44-6e6ae829130mr225550176d6.22.1740455734598;
        Mon, 24 Feb 2025 19:55:34 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b153fc2sm4985826d6.77.2025.02.24.19.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:34 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 481D81200043;
	Mon, 24 Feb 2025 22:55:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Feb 2025 22:55:33 -0500
X-ME-Sender: <xms:NT-9ZyjyCAoTaPhlpYteWoMs6OOBVvYvEOztNh0qpAxUpGDdaPBt5g>
    <xme:NT-9ZzAnNYQWKMPXVWZ8LEzyI1BowzTv2MxH_o8QHt3ih-sK7ICrEIq_iwFP6RcSN
    hhxIKggzrhQEn-Ieg>
X-ME-Received: <xmr:NT-9Z6End8ORhXmX9Lq6X8DG8yStF28pyskpX11XsmrMq2hbwKOf2_YZqw>
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
X-ME-Proxy: <xmx:NT-9Z7TxpbJcepic0C8NdyVUC9JvvKmf_RNDFnJjnkT5kZvZTT9yzg>
    <xmx:NT-9Z_xlA04XsBMggXa1nzzRa6ykKUGMaqYV95YMAZg1oxna7Yd1VA>
    <xmx:NT-9Z55wSVL0VIK9YCiyd_rYDR8iZgtx814EiXLvMRKwHk-M0ZmT3Q>
    <xmx:NT-9Z8x4uEwooAMhQCelSKqBHdjDXkdAfiJEVZoyZAtey0weRN-tLA>
    <xmx:NT-9Z7iD07NCVibWbQB1LfDjrFD_SIIa1r8AbQH1FH8dEhkkKCZf5hEy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:32 -0500 (EST)
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
Subject: [PATCH rcu 09/11] rcu: limit PREEMPT_RCU configurations
Date: Mon, 24 Feb 2025 19:55:14 -0800
Message-Id: <20250225035516.26443-10-boqun.feng@gmail.com>
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

PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
which allows for dynamic switching of preemption models.

The choice of PREEMPT_RCU or not, however, is fixed at compile time.

Given that PREEMPT_RCU makes some trade-offs to optimize for latency
as opposed to throughput, configurations with limited preemption
might prefer the stronger forward-progress guarantees of PREEMPT_RCU=n.

Accordingly, explicitly limit PREEMPT_RCU=y to the latency oriented
preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
model PREEMPT_DYNAMIC.

This means the throughput oriented models, PREEMPT_NONE,
PREEMPT_VOLUNTARY, and PREEMPT_LAZY will run with PREEMPT_RCU=n.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index e2206f3a070c..dd6251678e99 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU
 
 config PREEMPT_RCU
 	bool
-	default y if PREEMPTION
+	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
 	select TREE_RCU
 	help
 	  This option selects the RCU implementation that is
-- 
2.39.5 (Apple Git-154)


