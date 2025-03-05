Return-Path: <linux-kselftest+bounces-28285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEFEA4F526
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737597A3B22
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C819DF4B;
	Wed,  5 Mar 2025 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC3Z9lfH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6ED18B467;
	Wed,  5 Mar 2025 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143949; cv=none; b=ZSQidVDPZCJ67hEDCaynCWEYvVyhHiUsE4jeMkt0YVIn5yVAHkTu7BfYZBYyGe/ON6FIjhctWphiRwwBhkxME9kSmmoi9FRHAR0ToQ3v7kqxwj/YwV882lfZf/vMsfDOhxj7R5xsTIGeVAtZgrFsa+W6CS5aPBfUsq7ahqoZClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143949; c=relaxed/simple;
	bh=8zRq7ZAPDEtp3MVmA8IoDvypSZucbtkomFIWTGs/T30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3vMTLvibgux4gnYM2WyoEhZKdBIqbD/aQ+Vzrxse9zOAIsG0aufQFIqJHlHByXR++rEYjBdfCHE2jAvDdzKfTbZ/wBGI9PaoKQrwnpdt2pCA35/NTw3wez9+V/TlpLUPRwIe6LCtoiblN8bVgFgzy7zJ8pQUIuI7kWKidrpYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC3Z9lfH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c08fc20194so1061861185a.2;
        Tue, 04 Mar 2025 19:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143947; x=1741748747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pfiiCaIQ/4q3ANbC0HgoJrrFUh49fZ9FI7aYC2TsAOA=;
        b=RC3Z9lfHvlLG7CYrosvga6fvC8nmRYI7epotfKmlM74B3MK0yo7yJ2K8Nr1/iMfI3E
         +6+28Z0u4IjpSouMaJS0Qd6RQzz/tS2U+M514A8ccYnrQYVPo4fLKZMRhQg7Yx2rQHuX
         1mqSGAcE3W2YLqz+CAFOp/Dxdsoqv/3kPJh1sgG2Lc/N73m3l614tKzQxKw+1xorDE2/
         GPckljEBUcHnvxFqYyTDsvqe/fzuyP6qDzR8wy277nkBFFVe7X5l4deDgNXG0AbHpHTE
         HZbsWfNU0yxRvpzUx0wTGm6TB+/kl4p6p5LPhSR2roW5gMr9LPxrx4ImZJaVUdyw2EkK
         vn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143947; x=1741748747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfiiCaIQ/4q3ANbC0HgoJrrFUh49fZ9FI7aYC2TsAOA=;
        b=jlaHw9b8YV/WC1LdO7pFCC8EB8C2utaGRTrbWeujTQZnrfnIiHWIZ8hM+ABMzf40mR
         cuhPZsqJexosFp7dEb5SVCiZqr5bGys+fUrUi79J0ZXEsEuZAYuYdNdSRbEQ7QXVvO3K
         0spZgIrfnWahrhcpTn8GBYz4yHtSMjP25H25MNbnH9vhYwTrRI1xJhZfi5Eyss06JYlH
         DmingLXexpTCrGCdHPxSKPdfBRkFUQF9B9wT0HKSQRhry1G1nwx7qoC5uIerd/iGKM9N
         Y0TAk63K2Yj1HLnxEKpMqYDJKZQYWzIVWPgxNAIlx7JaYQaSw204M5ZKnKd49mOFZdZQ
         eiug==
X-Forwarded-Encrypted: i=1; AJvYcCVEyFL7KKkqOij6ZG3HFXavkcHNz/eIdL2HvXFFEd9MLTEDpL5RIVgooVK72CyGwTxr5YHG2lQ9QLvopneb1o9A@vger.kernel.org, AJvYcCVwUFmZmIfDK7BnTE7nFf1CjpbVTn54H8LwoLoVaCO1vzlF8/q22BXj5lyWw54O6Xh9pXlLqQXWPNK8zXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeuEtND50Fyu4xL8GkFqEuNIaW1p4ipdGRy42GzqTfriY1F0d
	xsFb9mrAKcNYKXawfqD2ceKMrHQip2+EZebFSBVqF/VBhta7OfON
X-Gm-Gg: ASbGnctK6cKx8OrqnhHSvRRvseY//mmxB5a/avfMT/ahsTW5JxqdQ5Ja2+kRgj01yKh
	Pzg7APutTDjsGbfvIHI/Bb2MnP4OYcHs9qpXNfTQgGtachgV5trvpOJWNF6cslYs0THm5FfnXs9
	REKX/46kGDLp4oBbWuGLKzD9UjI5hzzlrMkNZitb4Z/afg7x+FHWXeZxOR11WLy6zfpyCiygWpp
	PanOQS/UvqMJcFgW5LUdtU2slzD9TQz74LDWHRDuk9eLUKvqNvzzP+LyVhxbi280hm1wkNump8J
	ZQxWEfItncQqigEuC59CGaCtk3AhCqHDdQstYqUV/C/AO4NgCeSMcMcvhMQKCJBzxtSfHS5b3SU
	cIURc6BBvGK2EzhuXu5VH6lcVHBUQQPwIoIs=
X-Google-Smtp-Source: AGHT+IGSPnM2N0ins91abjkg9pNmv3v/fx5zOwCLPHARmT5szHhUZiMfGjc0ivQMHY/Uv2wzvA+SKw==
X-Received: by 2002:a05:620a:86cb:b0:7c3:c869:1aff with SMTP id af79cd13be357-7c3d8dec0a3mr230019085a.16.1741143946987;
        Tue, 04 Mar 2025 19:05:46 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0d34fadsm323062985a.12.2025.03.04.19.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:46 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id B7D64120006A;
	Tue,  4 Mar 2025 22:05:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 04 Mar 2025 22:05:45 -0500
X-ME-Sender: <xms:ib_HZ7-pmSBlPrSMVrVzAonR_f8qkXToU1Rhc6Q5d1oOtrMIuGX2kw>
    <xme:ib_HZ3v8-FWgaFjheIptM_PeeazukbLMWd5glvVR0wJJNvMVEOO5ppggmO20YsIYq
    fzu8VgQ455lcYAQYA>
X-ME-Received: <xmr:ib_HZ5BanrA6nWQQaXQpBwNxCNGItK8y7-X-Nd6AYLXmpdRkOEUGV7FEPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeefkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpmhhlrggu
    vghksehsuhhsvgdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrd
    horhhgpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdgu
    vgdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprh
    gtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
    uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrug
    hhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghr
    nhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:ib_HZ3dbbRooXmi3hIeFZPvpZzf1OKjcXnmMeSiWh1Crjhc4eGC4xw>
    <xmx:ib_HZwOgtEBMgCQkA2ErmEolaB81hBuBNcNCull0GV198DmL1tgbdw>
    <xmx:ib_HZ5lvVXLZx3hXCGA_IUtOLTaYVFSp5u2Wj9yLo7LS98HySNuRsg>
    <xmx:ib_HZ6uLTXKJdc3RaI82it2cb3XRUUw_Uxu7MhmDXH5uCPPXjkEyXA>
    <xmx:ib_HZ6vm1GrTsPrd8zoBhyKmQ3jAFuKaHPl2qGA-KGcESYQZPKxLqpJ1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:44 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev,	cheung wall <zzqq0103.hey@gmail.com>
Subject: [PATCH rcu 10/10] rcu: Use _full() API to debug synchronize_rcu()
Date: Tue,  4 Mar 2025 19:05:05 -0800
Message-ID: <20250305030505.94059-11-boqun.feng@gmail.com>
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

Switch for using of get_state_synchronize_rcu_full() and
poll_state_synchronize_rcu_full() pair to debug a normal
synchronize_rcu() call.

Just using "not" full APIs to identify if a grace period is
passed or not might lead to a false-positive kernel splat.

It can happen, because get_state_synchronize_rcu() compresses
both normal and expedited states into one single unsigned long
value, so a poll_state_synchronize_rcu() can miss GP-completion
when synchronize_rcu()/synchronize_rcu_expedited() concurrently
run.

To address this, switch to poll_state_synchronize_rcu_full() and
get_state_synchronize_rcu_full() APIs, which use separate variables
for expedited and normal states.

Reported-by: cheung wall <zzqq0103.hey@gmail.com>
Closes: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20250227131613.52683-3-urezki@gmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rcupdate_wait.h | 3 +++
 kernel/rcu/tree.c             | 8 +++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index f9bed3d3f78d..4c92d4291cce 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -16,6 +16,9 @@
 struct rcu_synchronize {
 	struct rcu_head head;
 	struct completion completion;
+
+	/* This is for debugging. */
+	struct rcu_gp_oldstate oldstate;
 };
 void wakeme_after_rcu(struct rcu_head *head);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 131fb463ba68..fb98d4d9d9c9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1612,12 +1612,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 {
 	struct rcu_synchronize *rs = container_of(
 		(struct rcu_head *) node, struct rcu_synchronize, head);
-	unsigned long oldstate = (unsigned long) rs->head.func;
 
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
-		!poll_state_synchronize_rcu(oldstate),
-		"A full grace period is not passed yet: %lu",
-		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
+		!poll_state_synchronize_rcu_full(&rs->oldstate),
+		"A full grace period is not passed yet!\n");
 
 	/* Finally. */
 	complete(&rs->completion);
@@ -3218,7 +3216,7 @@ static void synchronize_rcu_normal(void)
 	 * snapshot before adding a request.
 	 */
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
-		rs.head.func = (void *) get_state_synchronize_rcu();
+		get_state_synchronize_rcu_full(&rs.oldstate);
 
 	rcu_sr_normal_add_req(&rs);
 
-- 
2.48.1


