Return-Path: <linux-kselftest+bounces-27415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3361A433FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1331762B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDD8256C6F;
	Tue, 25 Feb 2025 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMHwwhFZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD82566D9;
	Tue, 25 Feb 2025 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455737; cv=none; b=KqfqRLbo1kyPwIVmdIytBnZgSvi3ln9A6YWCHqgTP0+Mv6c3YfAMRLo2qm+KKtZiG4YYyJq3SdislqpUfBmmjJv1NmjciI8sYg3RqruPHw1a29aK94PJryoRDQDGwe/coGNG9HvQq7QsXxFGuF8MMNUgoiHPWOczpaIiLciOnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455737; c=relaxed/simple;
	bh=lypcfpF4/N47ol4CwHDwwB0rg0jxZ07VELUbrb87mhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrCrSvKRSCckUKNhdgsL4fd2WqelcNpZxRI3M0cWzS4i1IuYO5YST2MmBibMR8sCbwxgP4F6drTsqQxX1eSkoMMDiKm9vvlJeFmwhGzOoasdrypnTjoXgrodHWB1uxnQ86S+ZnIUO8buVgJj9MrBrBdppuWqRy6/7DhQ7aOdnsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMHwwhFZ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-472180fec01so49122431cf.0;
        Mon, 24 Feb 2025 19:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455733; x=1741060533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h419Jx9H2aghJLfc8GQxEdkY5w4iKmNadb4INpgW1eA=;
        b=KMHwwhFZ6Fx9oElOCGJpmypR0h53HRAa/leq9vXuN+yP+X9RC5jC3hcxRgovBQ2QbE
         Qtdk57innRStYNDX8uuVpN+19RnXmJInRiEqMGM6m8WOuGlHVfvnOB+UGbFzhoaoQgfx
         B1BmmxicgsiVTKtiDrjZ9k6pmX0F1OtQPQ7dmS5s+DISS2jUT6GkU8oHtmnaN3DKe6Ub
         ZYWU15x+lpN+jhHyF2ZwANCF+Lf2p+fmzn0HCIFgLIcThvsod+ueCBrOeUjKj0rNDlku
         Ob08SrwG8JZm3qYhJ/qMxfPfbfn4RAKoF+/ufGYKyR0leMrro6km/Pa/yGMj29tVgkNi
         GHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455733; x=1741060533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h419Jx9H2aghJLfc8GQxEdkY5w4iKmNadb4INpgW1eA=;
        b=f2Cd9nk31lp88etDV9xVd7Dmbi33TJA3sZOWWuMPsPyB6+kZ2nv3GRn1kJY0bpAFUV
         aguY2Yw4ZZJGeGU8ckhp7AIaFYst8sVOji5TaTrW1X2uB7drNjdJdBeLe2tHGQhIIkwL
         PGrp4l2+pT0lGFrUQf8RWDFgKEQNzTN+0mMAZK1cXFt7sYamyscP8Lg+hW/zoVYKoRpx
         OwHd4DdGqzCjPIPMpn1pO2HMzE378fwcniOL2/FMQAI9h0xi6XAhBSaSkUTbxRyT6o2J
         Zt6YwDzkE+FTSUAH4EfB1l8zXHRrpWUfQLSBCaEn+JznUA02JPWmxiGZaMTUIRCAKAsI
         /8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMwlBXPHLiKIir8O6oNfV0SVkl7IsvTAixpE1rF+fV9KEf/RPB6gytlMBb8GRv+LM/oB1Dt+4K6rNMcKJAEVwt@vger.kernel.org, AJvYcCVgAO+n1W260wE8cODvF9FDuBaGmX8OPrLBmeAnG6ct48EOGrCxVo4jY3iSRQi17XzzOuMvHG11KogiP7E=@vger.kernel.org, AJvYcCWN523XRorrGTkFMlrlC+hlEQa0FTv9aJDK6j+ILlAqFwzYktROCE42hh468h524iC5K19XqbYItn0bSlQaNp6e2x94@vger.kernel.org
X-Gm-Message-State: AOJu0YyuExUfPoYMRiJq91vzvXS3ZHJynkLnw//y9xLOGuHosiqrcTxa
	khSRxzVQOZBYH82GoOUXAaFdQGbw5TS+xclQfwYrX730yP59Aoqw
X-Gm-Gg: ASbGncvNph92YUZ7OcpXb3yqONeAEfBXi5dlnvWo3yAsruqvbup6z5YMooGAuwuRX3R
	jN1Vq6bIZUg4NJBYQLG9pUIrF2LMVR3OXo7ykF5c11Ax7c5YBqHIgNhcG5N5K504nlVFfmU2a7R
	XLPvBtN8yFo8lP+2RDR+OyVHMhAxFvYwS72yVROul39fgCrAwlOI/RQx6+OG5t4ca+xzDGPb+DT
	NYBLNA8K/62YgXqpfCkgVMdWt9exJOS9MJoFfwDviPYFdAaflgaLmLWuNtqar6GTjyVyQ6NY0cm
	wX+SSxtCI3+gJccVrTaLm0bhxRASY3TPcuvItfqK2NRbBxZRF7PKl5RPQb28Tz8mip4N39xFwtt
	CXYknTHBnnPFgF59h
X-Google-Smtp-Source: AGHT+IF1bw2/M4rJe7oPlREsRl6H7CKb+zSI/4ZcCobx1E7yiXEWmFhjkYKWpWSFZOo7fD2ufyGkCQ==
X-Received: by 2002:ac8:58c3:0:b0:472:744:e26d with SMTP id d75a77b69052e-47222944f84mr224990431cf.39.1740455732873;
        Mon, 24 Feb 2025 19:55:32 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e24400sm5295041cf.41.2025.02.24.19.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:32 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id C8CDF1200043;
	Mon, 24 Feb 2025 22:55:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 24 Feb 2025 22:55:31 -0500
X-ME-Sender: <xms:Mz-9Z7qu2smBu6OdQDdawB0_S1PDO3OL9dymZqGTa6jV6Bi6AdHMDA>
    <xme:Mz-9Z1qdhRJSwTxgURHKtLy8viiMNEQ-FEmQDeqHeCElPNaDKLJw1d-wlJDku7lwH
    5WmcZDsKzaEEeAkDQ>
X-ME-Received: <xmr:Mz-9Z4MzmwA6BaS6Mjd0TMipaPrtK6DBgfQwQ6ZQRsQq6X7Bwom1nRmZYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeiiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Mz-9Z-4MBA6GNmmvuQJGHF8MKTEpQnG10BEof-BI9CqvcI1AnGpKtQ>
    <xmx:Mz-9Z64ZAyelYGL_5E5hl-rhzMLbQfC0-P4EiJFnVB2GxxUFNPgSVA>
    <xmx:Mz-9Z2jfsnZw34aKX-TakcG6fBXwxHkbXtKGOQ3-k5xzxjZYZ8cySg>
    <xmx:Mz-9Z84gXtXIC_NZlZLBuOipl7C6YI6Q84oj3mSHOWMiyOCP-Sn72w>
    <xmx:Mz-9Z5LYJVWtxCdE438UgxRcxHeP8cwHdH8qHSKrj2w9eByDD86uNv2z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:31 -0500 (EST)
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
Subject: [PATCH rcu 08/11] rcutorture: Update ->extendables check for lazy preemption
Date: Mon, 24 Feb 2025 19:55:13 -0800
Message-Id: <20250225035516.26443-9-boqun.feng@gmail.com>
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

The rcutorture_one_extend_check() function's second last check assumes
that "preempt_count() & PREEMPT_MASK" is non-zero only if
RCUTORTURE_RDR_PREEMPT or RCUTORTURE_RDR_SCHED bit is set.

This works for preemptible RCU and for non-preemptible RCU running in
a non-preemptible kernel.  But it fails for non-preemptible RCU running
in a preemptible kernel because then rcu_read_lock() is just
preempt_disable(), which increases preempt count.

This commit therefore adjusts this check to take into account the case
fo non-preemptible RCU running in a preemptible kernel.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 280bff706017..4cae119dece8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1901,8 +1901,16 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
 	WARN_ONCE(cur_ops->extendables &&
 		  !(curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
 		  (preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
-	WARN_ONCE(cur_ops->extendables &&
-		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
+
+	/*
+	 * non-preemptible RCU in a preemptible kernel uses preempt_disable()
+	 * as rcu_read_lock().
+	 */
+	mask = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
+	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
+		mask |= RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
+
+	WARN_ONCE(cur_ops->extendables && !(curstate & mask) &&
 		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
 
 	/*
-- 
2.39.5 (Apple Git-154)


