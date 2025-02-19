Return-Path: <linux-kselftest+bounces-26993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0AA3C3DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11544178FD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5DB1FF7D1;
	Wed, 19 Feb 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6yL60w9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84BC1FF1B5;
	Wed, 19 Feb 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979595; cv=none; b=VmXq326qS5SesGTqWR/wfsvVAaP0fjigEK70Yd4xzNLnF+G8P0vRM4TTNgaZL+BJmzWE7rBuem60gsmM4eHslGvoqFDVBR/He8OxOEpDdmh2SE3HPw8wRVMxgxS4iXDuun4y9yLqQkCLv2lfmMP9TfqZmgKzww73hAj9Y/e+ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979595; c=relaxed/simple;
	bh=Mdjg/iMJ7xXGTWi7Kwa4jNDbossQfzNOgdp7Pg2+FLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sJx+ZYXorOZxuZ08zlK1J3kw1c2rttRKmjTJg5zpLE1xskAz1HmlFCVYVmQIKAlVl5ovm0m87vkxFQXAUoCaJB/52sRqObUEn1JWLTceSZbaw3Nf7DSWHPXXW/nkUszfoX/yj3loSwqKFGtesAiseMnBBKLb01Enkf39P9Rq+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6yL60w9; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0ba89dda9so66558285a.0;
        Wed, 19 Feb 2025 07:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979593; x=1740584393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g1HpOZTg8XdGQXxu2XqNmobdBHB2cws90gxNC6A0vsE=;
        b=T6yL60w974xZ5iHVtmffgtfuZjtyqhPHxhdxEyYWnn0GjTUZ6z310i0V5QgX2458l+
         W24GCsnTOFZuh5r/1nx87WLO6VePQu10s8rSJgNIjhqu0AB6fT/nHj1oUbjsB1yZXie9
         2QCTxR8Sp4s3CTniL6LBrQHHG/mpnMs4KLF5eeuQ+BIK9MitOia8gYl5rhPrmawC6Kl/
         oo9tRh7e6HvhN7E4kVzgwz24CO5o8/4gLYwFb30dxdthUVdQGqdX5UcucoMJZi7kHWYB
         qh69202nlU4H4u40/lPRg6yAZrsogQPcKq7WbaL6xvLOTPfM+ZhoilQHt+Qv8wpJvM8c
         rw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979593; x=1740584393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1HpOZTg8XdGQXxu2XqNmobdBHB2cws90gxNC6A0vsE=;
        b=jmkpw1HD/0dEdZIPnVdvhrxjNuOhtzfFhNzuVr9yFznI61z8jouk8XHgvlKotiwPEZ
         v1RlCOHeixDLCvKUbR+MXZo0F1u+EFUjMbUBq3dht5x06DtdoYJAxba6pPtRkf6sLJHO
         EfRt4RWhSve2RJpiIyO8RW0gy5y5iPq3jcYAdeE7gmeDorg3rvSwrZmTBzSMKe5oJN03
         5Cpc+M+DpAhciOjP8bmhFiJG/26ersWlnlMaVVhGNyMqtcQOOb7Cy8Pb6OjHxRaq5Cj6
         GKX72AlR3QgQYq2jcfQEM1NZDN4nqFhl4wn72MIv40EeEBpfrFrArt7Fpo4YC74Pm3zJ
         shGw==
X-Forwarded-Encrypted: i=1; AJvYcCV0rmETTHlVwr1a9Ebfm741w2081KQg9TRatRWsPJ14kTtN9nV1EVGx0C2Auo/U6zfwyxDG11vlP0YYCN/70pe94hFL@vger.kernel.org, AJvYcCW3BhvG30VVnDU0Kyc9gdRDTNORtEO2K1aeaIxwsKJR6nN0PnaxKKBvyIxhF/VtES07yahoLzPbBC1mj917dbC7@vger.kernel.org, AJvYcCXXPz8fB7Ovyie6aEKhEBRs07jn/dhOTSRjMHfOjywX98f440UxS0tPfuYk5uGv4XupkjMWcmMgY24=@vger.kernel.org, AJvYcCXjAjV73S85oLtScA9QvvovvgN9msjvdTeLXi7yZve+3wWEazH/TZO4E1acfZVTyB8PsqNS/b7T3V1IpEtD@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0+sjAC/GRYVbfq12szloU67EUl5rkstMA0lRRjzaww57Kg64
	yyrGaVHIBDeIyvHDwRvoPpJjew4rN5zM1YKC9Jlh1m9vTq/qjVhx
X-Gm-Gg: ASbGncsCtWeGGdZJXX0JRvpt7aq9b15ayS32dIMmC4cwVrW+MMAzXJSRZkuM0cHTEXu
	Oo7d5LphfMjp+1RW/gVSoD7trWVL1MeW62EP0dL36xxFmzph+jA1G+VwGo7oQ7TBn5y8Whn4Xpe
	13v95GFIx7R83gBGbhCAqpLUdyf55Befy4JfLqyU58Ek6PCv5fvRf2MEriOELJ4SN44Q5XnxLO+
	ash2rC1zMXNgO0T1C3iru2wcZqsOa/miQ7m/F0nuWa0n4mJZMFdyHzonsnME79m07SUllL88pd8
	fkO0s/Z7t39WxZ2ZhK/IjqtpqtXowq9B0ME7zESEv+CATnCygHK3ueuTrl+Rm/C4W1zD5zUDU77
	inW8M8w==
X-Google-Smtp-Source: AGHT+IFa49agqfyni+0joWf7SDbq4eLWCrGN/vOb4vKOxljcaFgWj/L6ezz2FqYX4B9MZASzEKbCxQ==
X-Received: by 2002:a05:620a:26a8:b0:7c0:aea3:9b48 with SMTP id af79cd13be357-7c0aea39d40mr876939585a.21.1739979592754;
        Wed, 19 Feb 2025 07:39:52 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09fbaf3d6sm361236485a.64.2025.02.19.07.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:39:52 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id C821D1200043;
	Wed, 19 Feb 2025 10:39:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 19 Feb 2025 10:39:51 -0500
X-ME-Sender: <xms:R_u1Z8lrUZ_NB6An7TeTE6x8-b_thcRC3v7H7-J-zaJpqozeipoquA>
    <xme:R_u1Z72Ww-90lakA4KTLPBKln94mDtiqnqYOoY1L68-z6wl4Bsmb-RWbDiwNqV9h7
    5h741S9gf6K8DwVKw>
X-ME-Received: <xmr:R_u1Z6pUUaOrLJIIC1IulCl85S1hfnedYR_S0Tkm8bzhn7P0Aer3n-YdSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehrohhs
    thgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegv
    fhhfihgtihhoshdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:R_u1Z4k0TVl8m5zDZYnSD6Pu7ejM5gS4SAG5TxtSePKivmOarW-Tjw>
    <xmx:R_u1Z604otvLniOgUGhPH1HWmBnCV3-jNQVt4dSxgQpIcDFzbMKXdA>
    <xmx:R_u1Z_srYAn0YYcBbheNYprFAcBxfB8zXALrMFss3QnSQGm2-2wL0g>
    <xmx:R_u1Z2XNdw2_XftT6-cjtBtIUaHiFnaqDT2zzJSo8CLWyhKmyNBwMw>
    <xmx:R_u1Z93-V1b6TVSCYODSY8KPrl3tA75lILxW5cCX-6VkvHUTvYwk7gQp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:51 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Huth <thuth@redhat.com>,	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,	Yury Norov <yury.norov@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH rcu 06/11] rcutorture: Add ftrace-compatible timestamp to GP# failure/close-call output
Date: Wed, 19 Feb 2025 07:39:33 -0800
Message-Id: <20250219153938.24966-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219153938.24966-1-boqun.feng@gmail.com>
References: <20250219153938.24966-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds an ftrace-compatible microsecond-scale timestamp
to the failure/close-call output, but only in kernels built with
CONFIG_RCU_TORTURE_TEST_LOG_GP=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index fb1b80498ae0..1fdadc1df9ad 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -275,6 +275,7 @@ struct rt_read_seg {
 	int rt_end_cpu;
 	unsigned long long rt_gp_seq;
 	unsigned long long rt_gp_seq_end;
+	u64 rt_ts;
 };
 static int err_segs_recorded;
 static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
@@ -1989,6 +1990,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 	// Sample grace-period sequence number, as good a place as any.
 	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) && cur_ops->gather_gp_seqs) {
 		rtrsp->rt_gp_seq = cur_ops->gather_gp_seqs();
+		rtrsp->rt_ts = ktime_get_mono_fast_ns();
 		if (!first)
 			rtrsp[-1].rt_gp_seq_end = rtrsp->rt_gp_seq;
 	}
@@ -3663,7 +3665,11 @@ rcu_torture_cleanup(void)
 			pr_alert("\t: No segments recorded!!!\n");
 		firsttime = 1;
 		for (i = 0; i < rt_read_nsegs; i++) {
-			pr_alert("\t%d: %#4x", i, err_segs[i].rt_readstate);
+			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP))
+				pr_alert("\t%lluus ", div64_u64(err_segs[i].rt_ts, 1000ULL));
+			else
+				pr_alert("\t");
+			pr_cont("%d: %#4x", i, err_segs[i].rt_readstate);
 			if (err_segs[i].rt_delay_jiffies != 0) {
 				pr_cont("%s%ldjiffies", firsttime ? "" : "+",
 					err_segs[i].rt_delay_jiffies);
-- 
2.39.5 (Apple Git-154)


