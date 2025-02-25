Return-Path: <linux-kselftest+bounces-27413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C59BA433FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CF53B6010
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8690E254850;
	Tue, 25 Feb 2025 03:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrIJTzYP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E81925B8;
	Tue, 25 Feb 2025 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455734; cv=none; b=AN77+GdwVVdkRXAumOpPP+8tM0vOGQu3Yie1M4nmfmFeb3Q343dKPMVOH/+h/dQQLNWjPn4BIyXp1zEnX6J58NkX6TXvz6XzHr8wfLhJUw7GrRClvtt9uGDgOxVeWRLh3kw9myGL3T3BdqOdVoBrUm3/79y6i4DZ7aLM09tXeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455734; c=relaxed/simple;
	bh=1tDISaYeQ3S03meuTtLRl+xFGXAMQ/cviepaRDjCquQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWDd2umhBHjDYXCY4H3IKepyW4LVWCq0IBpU5T0P4K4PwPPR8paXOYWrd2iFoGzuJ3zDeE2b0e66ussySthFQevEygNOOjMupB6JQ0xfX1w+jRmSwKVuyISRL6urD4RYf4VSPNdmaHK5BILKeAn8RSUrQj6VYlVot2pXVXo9ehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrIJTzYP; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46fd4bf03cbso82720761cf.0;
        Mon, 24 Feb 2025 19:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455732; x=1741060532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9YYDq/qQc7Ji7bn3SbKnVlJKz11oqy/6rCNHG+ssGTA=;
        b=OrIJTzYPNtVw121sqywg+5NZlAjri0KqaMtXOwTLb3E9p0zBWVjAbvFjGI5HE3N1ds
         qc9RVunTXm2tqkageKLrZECBa9pziBQtBWHrGXGzAfhWLYxcf2ecgitPrwx2bKXaTiq4
         gDWVjV8FdWFW3vg2wIJj/BXuU5tSs9A+EIz/OO7VAmxzi2u9ZuWQ1VwwZV3b3SgQctyC
         ZAzYJu+NFVToYSZuosAdcl+GT7wbFTD2VQOF5wyjVBdrlvijeDrkd3YItUcRhuEAEtwW
         8PDufQqumvpiA7mVFgl7HGPWi3OTcbzG9wmGjXsMX7YFz0EphJ+7cGLMfvLmL2ljKBD8
         HuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455732; x=1741060532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YYDq/qQc7Ji7bn3SbKnVlJKz11oqy/6rCNHG+ssGTA=;
        b=r1IcbLSCagZ8DvJJN3sjq1XURkPWb0RNnTexlwIJGL/zc3rxbKdl/MXUvWoa4Tj3Vo
         krS2BX4jbi46TjHmctnMOgbJLRSyef/1OXXcmGaGgrdvC21T0QqUSgnn4+KdfdfSGJNY
         SeRnDrEXKcF+yWob0TiZUDLt8WV3ep04oLV2t0m4GImPpp5iRCB9RtRS2M2GTGG5Jc58
         1fISA5W7H6VXVwJN386qwObPHxHmN0fIHy31raWB7rdAtMJ/aUwXOx9w+4KF5uG5yt5F
         lOhq67XvELjqL2Sh/M83/FkHCMGkehw2+4fhtKOX0M0FBh5prVjQordm2Yr0d7LIXx9W
         A/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw0leKEnOryB3jvuRdKTw8Z59MQZ2QVKzDhKJV0rG3rGgZSr/OXMljw1p4inXFwf26rD48H8fQdTM3jBI=@vger.kernel.org, AJvYcCV6eeuWcv8j7MXuSypX2rQYCz6c4pXjQ6OVEIbeoCe8Ukv9F9BiR+FRQQ6E7sgQT+OOx01lw+LNGZFNZ7oTOmcCcRop@vger.kernel.org, AJvYcCWpR1HU8MUKAdsimATH8AbKF27kNVJG/um3ui5kZIenYirauLvPO4CZoJF0MR1fVpMuA7j4u4T/04IZmm1xtFHA@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgbMhsPnlmLfFjeOzRqX0NHYHgkfvaTbMKsitsy54JYIlTqlm
	rfZhMMBodem1fvqX7pVDmysf89tgSgeqdGYpQPw3Or3qB3ffp8bD
X-Gm-Gg: ASbGncvE3Dia7UawkCAabKVtIYZ/3SXy5TA5QSYlIhDaJiFizWla1gfInGTMhn2kyK1
	U0GJL6FRCFNJQvFgJdQQSKdze/uVekWcAvzsGWM+hHZympbe2VXiWKNzLpvkUpNmbrBk19DTRyY
	rxVdYUm0ZVyX+584Jr/kW8QUo46Luq86qRucVEKXqTgD+6DPNjjyX3Ziy0XDrCk/mS2iyo8lpfG
	3NR2PhowAScO7PILRmPA/DFOdgtP2DC09/ETi0y/4ntj+ojSmPoYdzTiNu/kzAjDdENymLGblgN
	iS/Gjq3OLNWIdGgT7gMfvIUf4tutjmMZ4eeHBYGdtu4wmOjINnUZTgUQTbFY7Oy/KVocEWlMac9
	SaWwoybEGLvXlJc5M
X-Google-Smtp-Source: AGHT+IHMXuxSGfHeFeWe6ixvXP5jkriSYpqbZd+mVCI6P3K34NPERaJ5lBv6YBRO/9abgXR/Xk5QdA==
X-Received: by 2002:a05:622a:1ba6:b0:471:ffbc:9bf with SMTP id d75a77b69052e-4737725c824mr20978481cf.40.1740455731579;
        Mon, 24 Feb 2025 19:55:31 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4737806a530sm5087501cf.59.2025.02.24.19.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:31 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 556261200043;
	Mon, 24 Feb 2025 22:55:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 24 Feb 2025 22:55:30 -0500
X-ME-Sender: <xms:Mj-9Zycof1WpQ3Bd_getgu6ynIJYBtY4mu3Nbb11MAvm2n0rl7UIyw>
    <xme:Mj-9Z8M-IcO-nNRghXpL57OLLf_NG2SwXHUkEJfqct_GuDc-QQDIBp1-M28QaQF3S
    7ZQWpjWSGwpDSf8ug>
X-ME-Received: <xmr:Mj-9ZzhDr-B91mGR6b7Ttd3cK9qOzeKKjjkHdU_nD3yg73s5JSfVZJ4ykw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeu
    heelhfeivdegffejgfetuefgheeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlmhgt
    kheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprh
    gtphhtthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtohep
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhrvgiikhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhr
    gh
X-ME-Proxy: <xmx:Mj-9Z_9ah-0n_cvkXRGP4YU1K_8HR2CUh2p-sLEfTYxmsVAuok3_tQ>
    <xmx:Mj-9Z-ucuv-WmKDRnQSJJrPEx84oTaxigSDkZrrrl9goephMby3kIQ>
    <xmx:Mj-9Z2GO-n4hSbW7C-0IogsqifJcG_3jp43Y5tnK395FkwlfjYAAfg>
    <xmx:Mj-9Z9NWo_517UwERJU0WXFf3CAor2g-0aeTzuR72sFqAqdYyFsQEw>
    <xmx:Mj-9Z7NWwjjtJrwsVZB10y5ItcL4l7M2RMhOLAciBzm_L46clUiY3T3q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:29 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev,	Ankur Arora <ankur.a.arora@oracle.com>,
	kernel test robot <oliver.sang@intel.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH rcu 07/11] rcutorture: Update rcutorture_one_extend_check() for lazy preemption
Date: Mon, 24 Feb 2025 19:55:12 -0800
Message-Id: <20250225035516.26443-8-boqun.feng@gmail.com>
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

The rcutorture_one_extend_check() function's last check assumes that
if cur_ops->readlock_nesting() returns greater than zero, either the
RCUTORTURE_RDR_RCU_1 or the RCUTORTURE_RDR_RCU_2 bit must be set, that
is, there must be at least one rcu_read_lock() in effect.

This works for preemptible RCU and for non-preemptible RCU running in
a non-preemptible kernel.  But it fails for non-preemptible RCU running
in a preemptible kernel because then RCU's cur_ops->readlock_nesting()
function, which is rcu_torture_readlock_nesting(), will return
the PREEMPT_MASK mask bits from preempt_count().  The result will
be greater than zero if preemption is disabled, including by the
RCUTORTURE_RDR_PREEMPT and RCUTORTURE_RDR_SCHED bits.

This commit therefore adjusts this check to take into account the case
fo non-preemptible RCU running in a preemptible kernel.

[boqun: Fix the if condition and add comment]

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502171415.8ec87c87-lkp@intel.com
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d26fb1d33ed9..280bff706017 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1873,6 +1873,8 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
 #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
 static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
 {
+	int mask;
+
 	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
 		return;
 
@@ -1902,8 +1904,16 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
 	WARN_ONCE(cur_ops->extendables &&
 		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
 		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
-	WARN_ONCE(cur_ops->readlock_nesting &&
-		  !(curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
+
+	/*
+	 * non-preemptible RCU in a preemptible kernel uses "preempt_count() &
+	 * PREEMPT_MASK" as ->readlock_nesting().
+	 */
+	mask = RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
+	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
+		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
+
+	WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
 		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
 }
 
-- 
2.39.5 (Apple Git-154)


