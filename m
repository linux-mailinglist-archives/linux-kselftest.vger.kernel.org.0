Return-Path: <linux-kselftest+bounces-28276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D8DA4F514
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05CD188FAB5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718CE16F271;
	Wed,  5 Mar 2025 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbT6ht7e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C311624CF;
	Wed,  5 Mar 2025 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143918; cv=none; b=Is9yuRbxg6VtC+YMxA5AkycIvmsCI9G7tB9nh4W4x1as/mJn0VU/9W1crN5bWP0hxmoUnyGUjmkg5ZzLWcvnpzTyTsYreLt6Ju+maZZh8feFAV4xhHtMArqgKxQmBgW6ZwRh31rA9tg4OQA5AW79ZvV6aBnR4FV6Opwy8M8Qqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143918; c=relaxed/simple;
	bh=ktfnCTdprKnslNhLJY+ueq/kb0WJC7nvwCfvHWR/fNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K080qV9kmGHXYTHwdt0ghTcEY238zxlcDYTCuKzdn29Wb1yeSvPcYI5uHtNxwPjS+vGuRSWK3Sltrbaiw3inVlObZSQv7PfHl+ko3NgX2oR6JbZCroNjeQ0FnRQZQ2QhTGPeqt+FykZWDJckAi2LM1k2C8M53TC/saDSfUpEArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbT6ht7e; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8e6dee861so4296266d6.1;
        Tue, 04 Mar 2025 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143915; x=1741748715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6dypZEQA15NBPzNlTYgAS3T1CsEbXqMrVbTKXugqbh8=;
        b=IbT6ht7eLj4wmunbcz6BEpWSSxGtPN2iKGs1iSU2ELZuDQ0SLPgzN760eiEnwBtV6k
         eK9ugn0RUnWSWvpd/teklt2uc6InysHiE8uggl6BPHQWSWedNsHIyaSHT/hqmeXkCskn
         6GA2kHKH3Uv2niqGGCWW9q8r209+vcenO6QUQKtEKoIVEk4VJiFGMzu/+VzYVqinWulC
         L2SBwBGJU1t1m5Zfb3qxZS1YYUOpX1hGUGBWp0bw6k2ZZC9oKRtgHHHM0u8cRYXwYiga
         /lzTTPFilvm1E+LQtiNRDJ/YjM6GbbXXMWqXt6X0Iwb2uKy3weWTVLOuzvc5cDa9ED6W
         saDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143915; x=1741748715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dypZEQA15NBPzNlTYgAS3T1CsEbXqMrVbTKXugqbh8=;
        b=Zxn5v+jswXfIpajl0Bc1VuLyStLQF5H8tWthRmRTHWEC9SUToOxTGw9UYilIC86v/S
         jGDuN4wcEELExeKLnA3XqF64gS3nCV85XLdFiSzcXY8W1NKj0jB+GOhG6hB1Mr3R5BMe
         K0jK23aMjKw/jr3snzNtePtsW6hutc3Y4sXWW6Y8ACmA+CBSB4nswKLCakEmekDBdDg4
         ezTP/5Q6lYJ5F8EOGtbwujZTRpnzGVCsuZApjc+JOH3eoNpJXQQiio1j9Fz5SRCIdGYq
         9iOZFRcvHBwfuAyCQBPiBeVfzg03SjoXXjG6iAlL0Px/+cSQmRQix29XYXKLzXKBU5n6
         i0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI7HulfIqeytx9VJ9akdrIZssIutlRxJP3RmAT7M8/Xs0rW9g8bpQ1aTmaWnccFSsK0wfDcffY6S0R4RyAkii0@vger.kernel.org, AJvYcCXZJwZAxh7X0VHPATll0FxadlhwVGvyBypKYl86GNSqSDASIbf+8rQNl5SRs2kUV9L9WM5pR3BcPzwY0zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1LEJIqw9tLZfpFeNVY57BkzzBwajW1IWKnboXcZW0SpzxIqH
	wmFazXjLqRGS8ZA9k7YNf95Q/X5RLy3S2PgQ8Ga7yJgdo/HI8UeH
X-Gm-Gg: ASbGncsCz5/Wv9iU3YyhIX+oqO2ieQBi1II17lalIh/gOT1ChXVyonHKddNqEghM+3u
	J39YGCC2BgR4GBsWAkLrY7PM5t3xJWrsJMh4N57DS9nNKpvMXAUyxbn4DCSo8nM8pIlTg8OBDnu
	uQznAU3ciihFHgmsDF6tAeylkHJ4pblEyeDb6cApeDLikKSXa7/+6uq4l7nYmtwe+u57Ry4oJwg
	6OhMH7alB80BpSdyTDxjkukn9v1/nmMnSpkwgIZAsA1XD/y6XcgviJ3qYKcmNkuwhncCrCZv/og
	RTmsEhYZWzHn1Fz40CDT8eXQJ0a63ZiW3mcNVZOho4vR7zA9BpUFXS682KLrJ+CZjHaq4jY/g3X
	m9Y+cv2m9OFxW6fTcdB388gxN1Iw9pc96jPc=
X-Google-Smtp-Source: AGHT+IGdU8coVX+JMyUMPQF4yyJnAWCWWGbGkl/W+cncdRf0cJd+55o4XN6k3TifudLcwTrFi2c1Sg==
X-Received: by 2002:a05:6214:da5:b0:6e6:646d:7550 with SMTP id 6a1803df08f44-6e8e6f8fdd9mr28695586d6.19.1741143914630;
        Tue, 04 Mar 2025 19:05:14 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ccbacsm74260296d6.93.2025.03.04.19.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:14 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7CCAF120006A;
	Tue,  4 Mar 2025 22:05:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 04 Mar 2025 22:05:13 -0500
X-ME-Sender: <xms:ab_HZy6Nr8aDYHRCzVcvMqY5CZWkycap1Y7bhFbrrqos8V3d6ljr5Q>
    <xme:ab_HZ76M9KPtg8mSAIaZwetYztoS4dWbsP-xABV1kZabRKbM9nQyMKxg7jPUvG44u
    2Vu0bdeWb1OSsv7Ow>
X-ME-Received: <xmr:ab_HZxf5GgD3aceLwI9MJlkrRDSFDwOH_mFO7K1uAxwyDeKTOlE26nqdmA>
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
X-ME-Proxy: <xmx:ab_HZ_IkXh-xOyAZBux8mCyKIsOvsv9eCa17foP8lu0UrF-utp0DKQ>
    <xmx:ab_HZ2Lrohff5LX6ZppFN6Ak-NL783jc7oBPLTytDKhyCo-zG_VBkQ>
    <xmx:ab_HZwzhFutHzFwXNDJVp5Nz2nx0-jU7oFqTuCk2zjIXhaxTR25cVg>
    <xmx:ab_HZ6IrnPhgPE4KrRz0V-yLZM6D0MlrVaJqpZSQb2CVU3yOao0EQw>
    <xmx:ab_HZ9bsuufxlUWyc75wJIFXxkN88rndaDTc5rFPDXBUassM55riBVX2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:12 -0500 (EST)
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
Subject: [PATCH rcu 01/10] rcu: Split rcu_report_exp_cpu_mult() mask parameter and use for tracing
Date: Tue,  4 Mar 2025 19:04:56 -0800
Message-ID: <20250305030505.94059-2-boqun.feng@gmail.com>
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

This commit renames the rcu_report_exp_cpu_mult() function from "mask"
to "mask_in" and introduced a "mask" local variable to better support
upcoming event-tracing additions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_exp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 77efed89c79e..8d4895c854c5 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -230,17 +230,19 @@ static void __maybe_unused rcu_report_exp_rnp(struct rcu_node *rnp, bool wake)
  * specified leaf rcu_node structure, which is acquired by the caller.
  */
 static void rcu_report_exp_cpu_mult(struct rcu_node *rnp, unsigned long flags,
-				    unsigned long mask, bool wake)
+				    unsigned long mask_in, bool wake)
 				    __releases(rnp->lock)
 {
 	int cpu;
+	unsigned long mask;
 	struct rcu_data *rdp;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (!(rnp->expmask & mask)) {
+	if (!(rnp->expmask & mask_in)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
+	mask = mask_in & rnp->expmask;
 	WRITE_ONCE(rnp->expmask, rnp->expmask & ~mask);
 	for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
-- 
2.48.1


