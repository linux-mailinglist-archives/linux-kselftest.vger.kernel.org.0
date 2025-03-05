Return-Path: <linux-kselftest+bounces-28281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD3A4F51E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DCF1890350
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B28194A65;
	Wed,  5 Mar 2025 03:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mubgNmf5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D75194137;
	Wed,  5 Mar 2025 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143937; cv=none; b=lqs2H9hW9JCDcGpl6Gc9ROnV3au0BxG5vriIU5EacAQHVBVPS3gD4XOfA+0ISfrjalzCC5FWIfNdZZ/wtAB4FptrWItpsYOE+QJJhuBlD9x/MXyx1LbK4xWLy/pUcwgFEz7mi9o/nzM+Zb5L9QfmDQLWKcSibFdHUVVReYXjxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143937; c=relaxed/simple;
	bh=TPhOEkbATR6OP9mFw8RaL7AaoyzMl3a7Rp30LlcUOPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keg/RsdjA3lokebElKyrvKrqkEh37LndtQfeoYDhNVyQKjy+n/vNvOoBNLtF0U54+JdJ63rAXo+Xcrx/iswj6xPKjIbHWLcArcWKLbUYqputKYp8J0aEPQzd2XvpUX4dX+nLOf/tHVpV4Rb8JMv8TVH6RiviY24CSsY9TpEN0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mubgNmf5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c3ca86e8c3so136634385a.1;
        Tue, 04 Mar 2025 19:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143933; x=1741748733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lebFfDdf7ODuwMHKUv+6Ka+hc9tfR3Q/RE97364NVwU=;
        b=mubgNmf5jbj2UHeG11qxTnAbpKv+XFfU1aeGUImUwaif9dtCnoqpOXwnC3i0Lyv9Bq
         md+NMyycXabW+g2ddVd2jAYubpIUigKvBcHS54PuzHTIuKecQ5gcvRoE799LG2xKzW8G
         6wRLA730c0q/0kxigKFXqrCGcR12/pgvQEBIldvhOSW+ABtQ1zw1RmCHHDTBYgwVWrU2
         7ybxRYC09WkcZZArqjBa0iIEsvkb7lANRtaR4oIA+2vnU43j7y3bWAnFWgg9XogGnbMf
         /FWxNev57Gqlp1ns/zeX9hZ2h81z8i36WOaME61gxe+7tONKCP1g11JQ9sbiuJ7vDSTl
         lopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143933; x=1741748733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lebFfDdf7ODuwMHKUv+6Ka+hc9tfR3Q/RE97364NVwU=;
        b=RME0AWGWQnRc3ONSW5SMB07RGIWmK8aPZ7Ee/0+Q+ZYEoHLgLfR/IK4AQ6yiWt4ZYn
         gD+7F4DKm2CY6OcFZNQ3SFU5g8lGbU5fNh63rgLPZUh7tiPtXhzEtNa537/DQRzZtBKW
         gfdhPFQUbGNHJb/IuAJ4JT6zoN32gYCSDTi4S/a591XxXuEPMnFiCzuFMy0sB54YlC/T
         8UenFg8prRrOraauuMmv35bnWvg4ofOvTHOpozSyp2N7fcCZDisKlADqphtc7aIWvM4b
         /iCcv4znNi7q1+1gREKdAP8+geV0VZZuQt7P26BRocL3KQStZGX6uL2KKnlPK63RmkNx
         Gsgw==
X-Forwarded-Encrypted: i=1; AJvYcCXlpMYpcmAB6DB6qqukqSWaUO8drsJNBZeC0KhAW6XMDB16R6ZR4OxcbeyYKuKhjc7uYbHYz88rf2usghA=@vger.kernel.org, AJvYcCXvY593p23sXJKqklFbPjlzfj5qe+pBm+mivurZjyxRwxXWp69lkKPeyswIgqXihypbcNbQihsmqXBsFwymQj0+@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTLM/1XUEw1BGdzNe8yzakY80IDSp6dTHYI6yK19I7u/5f/1E
	WLUiulxw6SOKd6wnVlx27I03I73GMga7QpRyBRx5VkWFj+U/kX4Y
X-Gm-Gg: ASbGncsGLfIGLjwjOATLd4yxWVmZokV+M++JfOey6QJLjNHOg8fZBo9EQDUr2IuHoDU
	0qJuaBvZGZ20Sc+iKAUQZTcNSuhDO4HRm3aUqnrJVMWOZgF5ZC+6SxyLn6e+IwwJ5lTQAGLFV0e
	mNW0R8HOOrJA0+arou44CeMcWukVzNaY0+f7HoeTpSBp9p8KBZPluOl/t0CkJV/Kn5hYOaIdnIW
	ftZZO+7pxGVtBY+dSYfj/8+Fsc9M6E35xYLwNSo893PWkP2dXwdFBeCZ6ij0W8+rXdAjDuda5Oc
	DRciT/bMaqdc2GBp8Y36nymsXMg6+mA2h079bQN22VI1fFmCPrspV2/xdX43MkoOoAkv0V8s3Jg
	8cQDBsMc0nfc36CSY78uyp1RzStB+qbBws4o=
X-Google-Smtp-Source: AGHT+IFUmnWC34W7lEtL222mGAHp7ZE3hueA9M8c4yNFof32K5sk4hi8Ou7ClU9GimkCN6Iq8UjlKg==
X-Received: by 2002:ad4:5e87:0:b0:6e6:6477:de09 with SMTP id 6a1803df08f44-6e8e6d968ddmr21828866d6.43.1741143933598;
        Tue, 04 Mar 2025 19:05:33 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cccb0sm74171366d6.71.2025.03.04.19.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:33 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 61039120006A;
	Tue,  4 Mar 2025 22:05:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 04 Mar 2025 22:05:32 -0500
X-ME-Sender: <xms:fL_HZ-QOLZnA1RaFizCi8eRnaeOBs0w_jvJ42LEMlC3lFfjQeFWBrw>
    <xme:fL_HZzxLtm0EuZBvu7rJw0FM2NHzFgDV45SlRl8MKxKX4H7h1HJbrPl7KwchTYQ1O
    Lf1xQGSTmoGhqJDdw>
X-ME-Received: <xmr:fL_HZ71I5thIMQ_L_H8p8JYewILV9teF1zpyvfPFQBLShAdt2Tuc-F4Gkg>
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
    nhgrmhgvpdhnsggprhgtphhtthhopeefledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpmhhlrggu
    vghksehsuhhsvgdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrd
    horhhgpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdgu
    vgdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprh
    gtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
    uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrug
    hhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghr
    nhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:fL_HZ6AyhnhDC6YRrgoOXdeYC2-DYE1CK1ct5TWhChPGUL31oa960g>
    <xmx:fL_HZ3gSY4qKpf3wNz4EwGzcXY6tuCIRZJXT5L2CWoriBGXUbHeyCw>
    <xmx:fL_HZ2pJTYY6BryQRxQjld3G3RxuiMgaBM-g688OHfW_Fo5ufHYPRg>
    <xmx:fL_HZ6gPM6uI_ccmD6f9c_Vkm1McZFQziTc8T6tvR8FItKyfs3hSbA>
    <xmx:fL_HZ2RnX-xlGObuvz2DAWfalHeJ7r07mUG0pc4VaEeyiuu-82y4JB7w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:30 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev,	Breno Leitao <leitao@debian.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 06/10] context_tracking: Make RCU watch ct_kernel_exit_state() warning
Date: Tue,  4 Mar 2025 19:05:01 -0800
Message-ID: <20250305030505.94059-7-boqun.feng@gmail.com>
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

The WARN_ON_ONCE() in ct_kernel_exit_state() follows the call to
ct_state_inc(), which means that RCU is not watching this WARN_ON_ONCE().
This can (and does) result in extraneous lockdep warnings when this
WARN_ON_ONCE() triggers.  These extraneous warnings are the opposite
of helpful.

Therefore, invert the WARN_ON_ONCE() condition and move it before the
call to ct_state_inc().  This does mean that the ct_state_inc() return
value can no longer be used in the WARN_ON_ONCE() condition, so discard
this return value and instead use a call to rcu_is_watching_curr_cpu().
This call is executed only in CONFIG_RCU_EQS_DEBUG=y kernels, so there
is no added overhead in production use.

[Boqun: Add the subsystem tag in the title]

Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/bd911cd9-1fe9-447c-85e0-ea811a1dc896@paulmck-laptop
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/context_tracking.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 938c48952d26..fb5be6e9b423 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -80,17 +80,16 @@ static __always_inline void rcu_task_trace_heavyweight_exit(void)
  */
 static noinstr void ct_kernel_exit_state(int offset)
 {
-	int seq;
-
 	/*
 	 * CPUs seeing atomic_add_return() must see prior RCU read-side
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
 	rcu_task_trace_heavyweight_enter();  // Before CT state update!
-	seq = ct_state_inc(offset);
-	// RCU is no longer watching.  Better be in extended quiescent state!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
+	// RCU is still watching.  Better not be in extended quiescent state!
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !rcu_is_watching_curr_cpu());
+	(void)ct_state_inc(offset);
+	// RCU is no longer watching.
 }
 
 /*
-- 
2.48.1


