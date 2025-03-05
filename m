Return-Path: <linux-kselftest+bounces-28283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13C3A4F522
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333B23A9E16
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962319B5A9;
	Wed,  5 Mar 2025 03:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgG+aZCp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D739B194A75;
	Wed,  5 Mar 2025 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143943; cv=none; b=rBEizOTg0+sNhR+V8Ob1YYXVPkNZVXi2Mz5beHfmLsxirxWu7133RNBAL1/MV9xT/UfpASYaTvKXiGmP2FpPcpKePNYm5KWFnG/uw1oP4h0rhG+JT0tqRFWqgp5FoU6PaHJ9kkMY/JZbfHTTwyvOMWbHYKQwy71/5BHpinjCcdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143943; c=relaxed/simple;
	bh=FTbCxoRNzeptyiCsRyZeAdbu5kGrrtfegvCbyVJPKRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdRS7IH036ZUtb6Kn7FglhkiUuxMcRZArhvqMIYjEKFZCg5MCx4eSAxYGFaZ/lwRBZXSSUxUzAC7uGDPZ1+wQ8XfM4oj+Y7U5HNEz59GbckKD2OwjdiMtp5fmGEswL/iTtJ9MwDJCWYbw1xkXdlfDMXO5DC/mkUGXW5T2RwgX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgG+aZCp; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c3b533a683so316093185a.2;
        Tue, 04 Mar 2025 19:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143941; x=1741748741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u6CYER+QWDFGbqGupxQEB5sdNaMc6sLr8skppdSjdWU=;
        b=RgG+aZCpYc/QG9nIwQogyY733KubmOsI2LaZiRCjgGbtFOsjmUB57begpeROQkzb4Z
         rzPImilxoTkihWZb0S86TqxItZNP6tLlH1IveWKZyARIQGVXij1UqBtOTSN1YIsD8VYB
         jkCaGaU9RkNRe08QJMQL5LosSItyZmd4sIzrACBwhtztttSlaKSpWvXOjFwRvObHQDZP
         r9E7voJmU/N15gMRSd+lkJpUSx9xnHArJUWLJtoiZSVe/fzeDqwYpFzFtk4Z0z5+oQs9
         kKM+E1MJk0tw7cngiv1fHAy06eo8ljzNPRm3ker22q78AKLYshVL59UKH4Cc7QmCU8D5
         d07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143941; x=1741748741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6CYER+QWDFGbqGupxQEB5sdNaMc6sLr8skppdSjdWU=;
        b=Q7yDRaRmo/5z1w/uI8rNczs4WPYWcmtxB71Ym+H1iqfyPzZ+lz5hsCYVnaqFVs3a/7
         YiAawROs8FhvXFKhEXCWzkWwmntDAMEJEnXvxpTYiccEp9EdNSRuVLI3hb4FKQ40Majg
         Dd5j2o2Ns2Ofss/5vvemwEwFfxNK1D6lInCkVzrUC55CmUpM7C0fohhPvlERTlYjRElL
         Tl2Hm/u9iU3EvsPriXu5aR48tEKi/nC/mV/+r0Q2xrouCtCZdrCUNvWlLVoZ9GsU3sCu
         MOJ4vrlAMopkjtoOcJLRr8110IIklOAluDAFGUhpSdxiKrn6DSEQp/9lMUPAJp6YqNOu
         S9EA==
X-Forwarded-Encrypted: i=1; AJvYcCU9XqiUOc2RZ2f1oY3dfJEUZGErxAOGKBIETF1BQKno8oyRl89xKdUaDTmzhBjfJA9E1BmbvLFdqTbuuqpIWkQQ@vger.kernel.org, AJvYcCWUJUkQoyeb3pNAUdbLzbCyXLCKAfM6KSlur3zSzJFNd3Kb5HCVcguhrvCAlFdod9qWGgDK+dfNGb8D/ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95J/wn9CJE+6+5wVz3mVFs27g4FeOfM6c7lFAFeuWRvpV5vp4
	/iWOlRPQt5ryXHP27M260AdzHiAcFNGWabfT6VW0u06lWegYbbay
X-Gm-Gg: ASbGncuCij53nY6R/sGx++8WxD5bY6PXhrdNFYJjcZoKGiH/PrI9c21oGfEx+sj5VLI
	DxGn80g+zXCOrDo4YNEVDjDRWupy/jyNKIq8pQ6oAmPAwq9DiC1rTo/VkwjoCmOOOC5w3tGoPnQ
	d5iHDUxAQv7ulLHtAB6rkcujL0yLwc0uiPMJx8N+jxyqV7N6jyxliJAp3+Y0PZq/SgsG+bF5guO
	q6fTIP/aOvRy5hLDq4AZ2/EslODvoLkaXde53ELuveDJn1PcJ0XwHcSMu+bxkXSvhRh7s2bDduJ
	arQfbhk0W39bOB0eV0gnVf8AgZAF4O406cjX6vYZGU6gpr90B0PBriZ0QFpEQenNBM7rX0j9BX9
	sxkNO9h2huyCMwIYAJnol3eaZTkejWZc+s24=
X-Google-Smtp-Source: AGHT+IFFQiKwXNk+FSZRxYuGGL1vRU4+A1PP9vowX0NB2SJbrCiTrutdhkP19/BkACOv1Vq3pcdscQ==
X-Received: by 2002:a05:620a:6887:b0:7c0:9f12:2b90 with SMTP id af79cd13be357-7c3d8bd2be6mr306010285a.6.1741143940679;
        Tue, 04 Mar 2025 19:05:40 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3cc0c20ffsm210181585a.91.2025.03.04.19.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:40 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9F431120006A;
	Tue,  4 Mar 2025 22:05:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 04 Mar 2025 22:05:39 -0500
X-ME-Sender: <xms:g7_HZwoI9S3YbbAnHf1moH797XFX3UyPuvIXmDQFzTrBpPTKw0P-ZQ>
    <xme:g7_HZ2qEuxNyNjEUstgVK9wgbX-j7VjMZVBJb2N_qVC6779E_olqTDjHEynNv5Y8v
    x5yx4NW3fsiuuABzQ>
X-ME-Received: <xmr:g7_HZ1P15tTlF_NbxQnR1dP6l1S27xzsmFiXRrbJgwYiQgdyfAXciUjpPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeefjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpmhhlrggu
    vghksehsuhhsvgdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrd
    horhhgpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdgu
    vgdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprh
    gtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
    uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrug
    hhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghr
    nhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:g7_HZ35yJo5JC9T3C3UBjJiirBDHIIGMOrNm1pNmTjrppmyrTx2pUA>
    <xmx:g7_HZ_63px3W2ID3AFigu0-VMR8SKmhPwuC1EkGDwTmerElniwMS7A>
    <xmx:g7_HZ3gnxrJMYKMGLdeYWpeIPNNL4umh7WEiqvsHYjcz8GEzapWHnA>
    <xmx:g7_HZ54vEgvP0Jcf4MV-QDJnuqoluZoJrnsNKHJxMciZ0Zr4pEuGyg>
    <xmx:g7_HZyIH3__g4X_Tka2Cc60lNHQKEszLrjTohkY_Gsvp2dvArTvvnB-b>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:38 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>,	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,	Yuntao Wang <ytcoode@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Guo Weikang <guoweikang.kernel@gmail.com>,	KP Singh <kpsingh@kernel.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Joel Granados <joel.granados@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	zhangguopeng <zhangguopeng@kylinos.cn>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>,
	linux-kernel@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH rcu 08/10] rcutorture: Allow a negative value for nfakewriters
Date: Tue,  4 Mar 2025 19:05:03 -0800
Message-ID: <20250305030505.94059-9-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305030505.94059-1-boqun.feng@gmail.com>
References: <20250305030505.94059-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Currently "nfakewriters" parameter can be set to any value but
there is no possibility to adjust it automatically based on how
many CPUs a system has where a test is run on.

To address this, if the "nfakewriters" is set to negative it will
be adjusted to num_online_cpus() during torture initialization.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Link: https://lore.kernel.org/r/20250227131613.52683-1-urezki@gmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d26fb1d33ed9..726c2d63ab66 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -147,6 +147,7 @@ MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
 
 static int nrealnocbers;
 static int nrealreaders;
+static int nrealfakewriters;
 static struct task_struct *writer_task;
 static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
@@ -1728,7 +1729,7 @@ rcu_torture_fakewriter(void *arg)
 	do {
 		torture_hrtimeout_jiffies(torture_random(&rand) % 10, &rand);
 		if (cur_ops->cb_barrier != NULL &&
-		    torture_random(&rand) % (nfakewriters * 8) == 0) {
+		    torture_random(&rand) % (nrealfakewriters * 8) == 0) {
 			cur_ops->cb_barrier();
 		} else {
 			switch (synctype[torture_random(&rand) % nsynctypes]) {
@@ -2522,7 +2523,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d "
 		 "preempt_duration=%d preempt_interval=%d\n",
-		 torture_type, tag, nrealreaders, nfakewriters,
+		 torture_type, tag, nrealreaders, nrealfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
 		 test_boost, cur_ops->can_boost,
@@ -3597,7 +3598,7 @@ rcu_torture_cleanup(void)
 	rcu_torture_reader_mbchk = NULL;
 
 	if (fakewriter_tasks) {
-		for (i = 0; i < nfakewriters; i++)
+		for (i = 0; i < nrealfakewriters; i++)
 			torture_stop_kthread(rcu_torture_fakewriter,
 					     fakewriter_tasks[i]);
 		kfree(fakewriter_tasks);
@@ -3994,6 +3995,14 @@ rcu_torture_init(void)
 
 	rcu_torture_init_srcu_lockdep();
 
+	if (nfakewriters >= 0) {
+		nrealfakewriters = nfakewriters;
+	} else {
+		nrealfakewriters = num_online_cpus() - 2 - nfakewriters;
+		if (nrealfakewriters <= 0)
+			nrealfakewriters = 1;
+	}
+
 	if (nreaders >= 0) {
 		nrealreaders = nreaders;
 	} else {
@@ -4050,8 +4059,9 @@ rcu_torture_init(void)
 					  writer_task);
 	if (torture_init_error(firsterr))
 		goto unwind;
-	if (nfakewriters > 0) {
-		fakewriter_tasks = kcalloc(nfakewriters,
+
+	if (nrealfakewriters > 0) {
+		fakewriter_tasks = kcalloc(nrealfakewriters,
 					   sizeof(fakewriter_tasks[0]),
 					   GFP_KERNEL);
 		if (fakewriter_tasks == NULL) {
@@ -4060,7 +4070,7 @@ rcu_torture_init(void)
 			goto unwind;
 		}
 	}
-	for (i = 0; i < nfakewriters; i++) {
+	for (i = 0; i < nrealfakewriters; i++) {
 		firsterr = torture_create_kthread(rcu_torture_fakewriter,
 						  NULL, fakewriter_tasks[i]);
 		if (torture_init_error(firsterr))
-- 
2.48.1


