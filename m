Return-Path: <linux-kselftest+bounces-28280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E12A4F51C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFD0188FD22
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12115192B65;
	Wed,  5 Mar 2025 03:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGw5oyCB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C9191F6D;
	Wed,  5 Mar 2025 03:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143933; cv=none; b=NKlTAiYVw1Nv1vbEPxJbgOXbxW8DYPaD84bODlYcCKTbQGRT47uPOa2NIs4nE0XM5uJ7qmDm9I+cGY0CLXrruCZ4EcjLLfsozTniXa3q6eD4lopITA0Pq2JV7SQf04ydirSU2UcKZtmwYzjm43yJKiRuN5/sn0hbddJ7HLlrtgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143933; c=relaxed/simple;
	bh=hNiZZCSUKvfl7+umet8AF50whccofULzH7u022xq+jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgsjZp9Z63UGiAbl8SgA2067NTTfZp5mw0Tzo1ZPmdaYtsvX5weTFaICj/w3kUaBFkMGzzM2vTxBpL8EMH1yWeHrfwnM+Z7dnRuaMr/89MkRcejfvigPKkkVPYtN5djg6dwcw6YE5JEw01ZcHwPVRpVbg+rXXakAOTWE5e1SkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGw5oyCB; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4750ca77d47so2872311cf.0;
        Tue, 04 Mar 2025 19:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143930; x=1741748730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XCzSTpBwfsU59VREINAqcwK+Vgtr2DU2DpO7Ee45wZ8=;
        b=OGw5oyCBZdPw1Pe1Sppsm211coeaPlWVS1twYqIgWCwgv1tDGfUfnaU2QkC8atF0p4
         IbAHsAIcvbGY6CsViFscsKsZ56l9UTCcE5pyxZQ1l92fT4DGqnQim3dRUhN06siHaxtb
         g1nzda+fznNUMLlkaBJqE3IcHJfh2I7OdQ40iVbORquth1vZjxtwZVR3lyDhn6ACYJ3+
         gI01bGcjfC9YzSKeXeyYhibjTDWbDkurCOHqFdWpsfefdvjD2Rz0qqIDnoL51AKyMvWK
         61jhnVnH3T85m2fEShdF+1ebExB9fubklf1YBurTZ8OfNpx+VTgKHWM3D+gZpl7MY8un
         st8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143930; x=1741748730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCzSTpBwfsU59VREINAqcwK+Vgtr2DU2DpO7Ee45wZ8=;
        b=ajE3wGW0L4CjsKE/VB39Lk5GUDNv8puMN/8UozDUGMs5aCpI7Vwj0nv/43aHIutSYi
         O6TOqb5y8axIBpxfEumrgUQvTGhfdquMuZPiDzPp6zHXCx0OUCwUkWGfZ346c/wYpAuF
         iCO+/LhvI6SYaCmnKqj964ZmFTnrbQtJ6sEDCiEDArMBgs52SC0Glur8wbZXdxbejc3Z
         35CbbWWmZKRRTs3oGRy7knCAl8/INM5YqHXPwTrULUG8AGqent5avr4h8nnhfhJSknJo
         HpbfWTCHmUmwdtk6BDUiKhAe4ccEm3dB5TF5cRVyj8gWjVvw3UnSD/+4kN7nD5IGv+4J
         06Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVHWLvjvv1KyDQK5E2dTddyrwnlOG9gn4tFE6xxFqqoGP7uSZuytyQCtYLfSbQU9gWVT2QLrr/hO8fARpxFQWJY@vger.kernel.org, AJvYcCVS6PcGB95lpwZp5z5a0k4O61h4FVEvFxyXTONhF0w0u1QtdoI5JI2BoEkSLFbqiYY24EbxYss6reaGN78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLPegkm97Ee7efU5iYot/0WLW5+CG3jENIDR8D1gkis1CVVMsF
	473aEZS2ae+EbdrEx3GyhI+E6Mhv0UaRwCBKbFi7bkrLAzBstNEe
X-Gm-Gg: ASbGncsDuflDs28J0y6y0VaLf6IeztZHZvyEXOA62GKjAopS1rih+O4nmBG9yOQPWyE
	n/qJHdiS1XvXkHUqDk3T+u1PKW4J04mKxm9PXzKRJdKWiDVbpNSerZfRxRQD+EHtHqNBzwB3k6D
	NPOuxiA78CyOzSHt+tNxLSg6uKFaNglSXp2lceApe8dyhH3nUWXDU5fBxeq8H34NHcd4FX6UANf
	fAihXg/l6tEWd/HyKdbXY6lwohjBHRleq+lJGYELJfosioIycvEbm+6++/oNmoWaq1vDcTMR8NA
	uqVCps/yW/qZM2VjVhp8/YHWMqfr/ovV8hAT9ikwBPhe5wOByhYddps+Eqpujpti4q+tWL8P8Up
	fO07Un59J9vNA0yW7b20X2LjJG+Mr7bwPDqI=
X-Google-Smtp-Source: AGHT+IEuiQDV23EHLSAqALRzSuoMugSbMB/MT1RJRogJrMdDmPlxKFA23NwZEG9gtrXQh9L3GdXQpA==
X-Received: by 2002:ac8:5891:0:b0:474:f074:e85e with SMTP id d75a77b69052e-4750b4bdb1bmr26172761cf.41.1741143930057;
        Tue, 04 Mar 2025 19:05:30 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4750804b8c7sm9595601cf.33.2025.03.04.19.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:29 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id ED03B120006A;
	Tue,  4 Mar 2025 22:05:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 04 Mar 2025 22:05:28 -0500
X-ME-Sender: <xms:eL_HZy0GsMthYdnOzh5BUg2WxuhrLYrfillg7Lmiu7HSmE0tyqrzCw>
    <xme:eL_HZ1Er8d7FJ8m_UNGwofGX2bjqjeq8H8y8KfFUtLmd2GK4pka8Bb4Xq1EVxde-C
    Kgg6QAvtiPU5tObZg>
X-ME-Received: <xmr:eL_HZ66Ppr2HOPq0B60_Fd6O_tbxamUDSde7WFqKUGtjgc4a7rYh0ujU5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfeejpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhmlhgruggvkhesshhushgvrdgtohhmpdhrtghpthhtohep
    rhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehjohhhnhdrohhgnh
    gvshhssehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepshgvnhhoiihhrghtshhk
    hiestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrgh
X-ME-Proxy: <xmx:eL_HZz3tTALhBHrkdtsNV6PgLb4Va4U8ij98yDkVvCqe_qrGc8KddA>
    <xmx:eL_HZ1GVZe7NhPj3MFXe-r5tuaAPyOXM_54Xfl6wK3y-cc_-WosUfg>
    <xmx:eL_HZ8_1-SrkzrJaGa1s5UEGpkNZUjzPmZILMlcwYRZ8PBlmnYsMYA>
    <xmx:eL_HZ6k0t253gxqj4H_VhFdlFCw1Ei1I9OV08Xd_bM8X-U1I9ciQNQ>
    <xmx:eL_HZ9EOzt_OVciliAoopAmF6lU3Vj2wmQdxQLLrZzP6w4O6jO8F14Eh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:27 -0500 (EST)
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
Subject: [PATCH rcu 05/10] rcu/nocb: Print segment lengths in show_rcu_nocb_gp_state()
Date: Tue,  4 Mar 2025 19:05:00 -0800
Message-ID: <20250305030505.94059-6-boqun.feng@gmail.com>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

Analysis of an rcutorture callback-based forward-progress test failure was
hampered by the lack of ->cblist segment lengths.  This commit therefore
adds this information, so that what would have been ".W85620.N." (there
are some callbacks waiting for grace period sequence number 85620 and
some number more that have not yet been assigned to a grace period)
now prints as ".W2(85620).N6." (there are 2 callbacks waiting for grace
period 85620 and 6 not yet assigned to a grace period).  Note that
"D" (done), "N" (next and not yet assigned to a grace period, and "B"
(bypass, also not yet assigned to a grace period) have just the number
of callbacks without the parenthesized grace-period sequence number.

In contrast, "W" (waiting for the current grace period) and "R" (ready
to wait for the next grace period to start) both have parenthesized
grace-period sequence numbers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_nocb.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2605dd234a13..5ff3bc56ff51 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1557,8 +1557,11 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 /* Dump out nocb kthread state for the specified rcu_data structure. */
 static void show_rcu_nocb_state(struct rcu_data *rdp)
 {
-	char bufw[20];
-	char bufr[20];
+	char bufd[22];
+	char bufw[45];
+	char bufr[45];
+	char bufn[22];
+	char bufb[22];
 	struct rcu_data *nocb_next_rdp;
 	struct rcu_segcblist *rsclp = &rdp->cblist;
 	bool waslocked;
@@ -1572,9 +1575,13 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 					      typeof(*rdp),
 					      nocb_entry_rdp);
 
-	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
-	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
-	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
+	sprintf(bufd, "%ld", rsclp->seglen[RCU_DONE_TAIL]);
+	sprintf(bufw, "%ld(%ld)", rsclp->seglen[RCU_WAIT_TAIL], rsclp->gp_seq[RCU_WAIT_TAIL]);
+	sprintf(bufr, "%ld(%ld)", rsclp->seglen[RCU_NEXT_READY_TAIL],
+		      rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
+	sprintf(bufn, "%ld", rsclp->seglen[RCU_NEXT_TAIL]);
+	sprintf(bufb, "%ld", rcu_cblist_n_cbs(&rdp->nocb_bypass));
+	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%s%c%s%c%s%c%s%c%s q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
 		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
 		"kK"[!!rdp->nocb_cb_kthread],
@@ -1586,12 +1593,15 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		jiffies - rdp->nocb_nobypass_last,
 		rdp->nocb_nobypass_count,
 		".D"[rcu_segcblist_ready_cbs(rsclp)],
+		rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ? "" : bufd,
 		".W"[!rcu_segcblist_segempty(rsclp, RCU_WAIT_TAIL)],
 		rcu_segcblist_segempty(rsclp, RCU_WAIT_TAIL) ? "" : bufw,
 		".R"[!rcu_segcblist_segempty(rsclp, RCU_NEXT_READY_TAIL)],
 		rcu_segcblist_segempty(rsclp, RCU_NEXT_READY_TAIL) ? "" : bufr,
 		".N"[!rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL)],
+		rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL) ? "" : bufn,
 		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
+		!rcu_cblist_n_cbs(&rdp->nocb_bypass) ? "" : bufb,
 		rcu_segcblist_n_cbs(&rdp->cblist),
 		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
 		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_cb_kthread) : -1,
-- 
2.48.1


