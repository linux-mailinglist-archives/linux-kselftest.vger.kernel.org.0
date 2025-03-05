Return-Path: <linux-kselftest+bounces-28277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26A1A4F516
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524117A3AFF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8120D189919;
	Wed,  5 Mar 2025 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpfPtzJ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9C17B505;
	Wed,  5 Mar 2025 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143920; cv=none; b=evERz7oBVgqDtn8ANznOgx9rMAKSLWmRMlWQP8OaqyKVppAMrmtGIy4t42rkaBrAzqOBSzhycecFJK1ymObWSZugfVAWHy0eIoQcrTmqU0tjIkycI+jqkEC+tEEl45/LVwPz4RNjHjy7JRTuPMTZI4C3fTWWiPihqqr2Z/DU+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143920; c=relaxed/simple;
	bh=hk5QnFJjSZ7iRvyqIS25iiV+mIdjcFuYUi707oreHVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUQXzZb365TMjuwOmQmehdc9tfyRboQBkABXoDzr5N9r+kDVG8hsaGtwvj/rlIBvXf8f0pMsZyTXnJj2AaQpE1PQO7TeS3udMoW+1IlfSW74QyZVz8kgg0QqjbbXJlCkY50CifA8NtZPkuaBEII24iWdOfhbC9jo5QhMijMXki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpfPtzJ/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0155af484so867141385a.0;
        Tue, 04 Mar 2025 19:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143917; x=1741748717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BxBF1wo3KRiCLNdhUdmDsNLFXHfzkw5YNel2ubjhH4Q=;
        b=fpfPtzJ/a1ntVd58B9zhXrXfR/gUvjcTnGLWNqEuKV3jSa0VH/qGxFKpRlb2+qfeoy
         nPl7IySeg5gZBvpyflHgcR3oC63NLg6HGeYj8S4CB0IDeMymTnBkJ9gjrfM7w+LB9Utm
         UtiZEUYVw0XbdnZHB8sGJIHhUnGkrP+UwcG8Mv0siqps5LJAX6teR1rVr31r87mNfolu
         lo/dmBzLt/rqTklwwTpQ14ImHv8j26zvSvrKXbMYyW8hlcMBMuVUsP5HBeHC4DMsXJ5k
         r3myAxbAQcaZHrX5qlPQ8d+hcONagser1/BqeBNCMkhRhitHM3aa2s+JHq1f8k6I6nz7
         xhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143917; x=1741748717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxBF1wo3KRiCLNdhUdmDsNLFXHfzkw5YNel2ubjhH4Q=;
        b=jxEr0Jt3IbPWoANhy04kCLRePXdeUuAfr6+8ttg0S9/IEJ4MM6SrZG6U6q7SjkGaZO
         5XEHh4frjdRKlKBis9vUOZ3RIiNOW7UVdj2zB0HlTRRb3MjVkJG1cnHe/A4+qxV8YEqv
         p6vXGzLJTZJkxYaz9Nd0x986WVm84wzdSuZemeAtW2JYRFvGMNF+VYm6NUz+nyNn3VFF
         oUTghIQJ4ScxNwwFjzMmL5AJ1pI3lTjxKMisSz/8yXAbR09ZjlCWT/yecFmOC52Y3UbP
         t0SUamj9UhChBHy/8H4dynV57242txAhbcQbeWat4+L6Lob+LQN/g0YD/OCU7+nb5gzb
         Ancg==
X-Forwarded-Encrypted: i=1; AJvYcCVY1p1dccWTqB7sBiKGlYf6YRrHRe9d4a7bfPLnIPVdFR3FS25mGUnJseU+Vvyjos7mJemRya9uUR2FcxQevk4R@vger.kernel.org, AJvYcCVtsfZ0MgK2LMlaMGred+UNGSGDnzoxFQ1z4wx0KSWCBFOXk/sR9+W49RRvOm/Uap/RKlCi1kAcsNERWrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1xnptUqIm3iG+Xt4B42/06MBdkUuNIbSmt43L8/d2VkVUAJ3t
	2OeFGjMNrZGdSqRTXGByU//lKARuuKI9qyKoTHfKtuxRO/sQPfgJ
X-Gm-Gg: ASbGnctgV+pDG8yy5XcferJLsPkxIg+nhRpxRpsoGXjPIXiyDDWP70N3eINNTAlwzU/
	IfeTu1LaJgizNitEkoEPFcSDayXL1JzgfzFheYeFZMEoDaa08axe9YHkLzn/lIWGdWB9ntH0Xy5
	wzlt6OQid4xQJywUoveX2fdvFNhwEITR5WEFf3aqa4SE8g2gVnbwe4N8Ii32RG9tplvm3Hgu4eU
	THVwxGrNvIUXIt5R0iIDoy93rKWmd/r67XK7ZMVEdH2SDL8PqfUMs/LQov2CYBnUxASnvC3uMCE
	ubY9EcoA8PiZgWf8KTO+qNhBvdYrIjIzqLP4Nl/1UMZdcmc+Fh5cMopoP3xeBe0DSiGki+87ovJ
	V9duu9ZIS4h3CmUVV8Km29UqXwNrN9Ewicrc=
X-Google-Smtp-Source: AGHT+IEFZsqWR69Mpv/uPHMZFiOoQX6OOFIDU/u9tPOLAlxZDv93fbbOFOcASesA9uVRFuhKHwZFCQ==
X-Received: by 2002:a05:6214:20e3:b0:6e8:9957:e705 with SMTP id 6a1803df08f44-6e8e6d3596bmr24561186d6.34.1741143917557;
        Tue, 04 Mar 2025 19:05:17 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4750804b8c7sm9593281cf.33.2025.03.04.19.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:17 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 692DB120006A;
	Tue,  4 Mar 2025 22:05:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 04 Mar 2025 22:05:16 -0500
X-ME-Sender: <xms:bL_HZx0oqWbdF8GpkJ3w9qQL8KMQEY-FGMDFvWmm9d4Nfm0g1N0PCQ>
    <xme:bL_HZ4E-whjzgCALiaRqghIGSXpKiU5CiVgZidnu5A37D0_AgEuTOZKZzfmiTdVZo
    J-8llMkpWYkizywxg>
X-ME-Received: <xmr:bL_HZx7bKINZlGjbiOZgD4OlT1y4cThMcroTc2Ho1F-p93IQcRHeCjPgdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfeekpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhmlhgruggvkhesshhushgvrdgtohhmpdhrtghpthhtohep
    rhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehjohhhnhdrohhgnh
    gvshhssehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepshgvnhhoiihhrghtshhk
    hiestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrgh
X-ME-Proxy: <xmx:bL_HZ-2rzdUg83mOYhSCOenMTa5HZw3JmQMrWZe4rI9kUZ7xhkjW1w>
    <xmx:bL_HZ0HmyBHQqgzYkgDA5gQHHXjaRno8RhMOq_tTKr-yG_iETcVqtw>
    <xmx:bL_HZ_8LOzT01mtYTvab0yA2PFRng6BtX3yJ7UWOyjL2xkRaZ-41nw>
    <xmx:bL_HZxnHnO0bdrgGH--EDfc47DibOKEBcOhWsHVXXCgNDYtpmTgznA>
    <xmx:bL_HZ4EIXkhhKQoEugZ_sd2Wv983R5eaL0EmB1kLYXz2-eycrTH8_FPz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:15 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev,	Zilin Guan <zilinguan811@gmail.com>
Subject: [PATCH rcu 02/10] rcu: Remove READ_ONCE() for rdp->gpwrap access in __note_gp_changes()
Date: Tue,  4 Mar 2025 19:04:57 -0800
Message-ID: <20250305030505.94059-3-boqun.feng@gmail.com>
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

From: Zilin Guan <zilinguan811@gmail.com>

There is one access to the per-CPU rdp->gpwrap field in the
__note_gp_changes() function that does not use READ_ONCE(), but all other
accesses do use READ_ONCE().  When using the 8*TREE03 and CONFIG_NR_CPUS=8
configuration, KCSAN found no data races at that point.  This is because
all calls to __note_gp_changes() hold rnp->lock, which excludes writes
to the rdp->gpwrap fields for all CPUs associated with that same leaf
rcu_node structure.

This commit therefore removes READ_ONCE() from rdp->gpwrap accesses
within the __note_gp_changes() function.

Signed-off-by: Zilin Guan <zilinguan811@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 475f31deed14..e4c0ce600b2b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1254,7 +1254,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Handle the ends of any preceding grace periods first. */
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) {
+	    unlikely(rdp->gpwrap)) {
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
 		rdp->core_needs_qs = false;
@@ -1268,7 +1268,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
 	if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) {
+	    unlikely(rdp->gpwrap)) {
 		/*
 		 * If the current grace period is waiting for this CPU,
 		 * set up to detect a quiescent state, otherwise don't
@@ -1283,7 +1283,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
 	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || rdp->gpwrap)
 		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
-	if (IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(rdp->gpwrap))
+	if (IS_ENABLED(CONFIG_PROVE_RCU) && rdp->gpwrap)
 		WRITE_ONCE(rdp->last_sched_clock, jiffies);
 	WRITE_ONCE(rdp->gpwrap, false);
 	rcu_gpnum_ovf(rnp, rdp);
-- 
2.48.1


