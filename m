Return-Path: <linux-kselftest+bounces-28282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6234FA4F520
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F6B16BC21
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A04A1957FC;
	Wed,  5 Mar 2025 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2vvkN2p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7938119408C;
	Wed,  5 Mar 2025 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143940; cv=none; b=BSp357LEDh5ilBjj8IUssIESzA5RkDUjBx/BNczPnpND0L1xDO0ydQZURdueefqHFCYu6Yau/uuknrhCprAugO7HDeRmJr1HQTEL2/l9Xd/bcrDiPXVNmUFXpb0V7iy2jtA5ZMaZ8pbY85+rFTgaRQ2c0fiqtbsbbgmKI536/bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143940; c=relaxed/simple;
	bh=htVQ/cFn8gDimJsI774ZgbzxQst76++Dz7pcCkF7/uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6g1dUp8sVKVUQvqiHWrM0KnCU9JpFoFqcZOExQKSumNbXS+bYZo0iiLFOEbbKEO2zFLZU+Vg+sMMpGF6IbXkDoVNaAoCDmK53cox/h3iGaQg3uz/UD3n1stPtM8Y15tkiOPw8GICnTOHOLyskpFt/HCkIsQ6+CsdVzW2eAvAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2vvkN2p; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7be49f6b331so615720885a.1;
        Tue, 04 Mar 2025 19:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143937; x=1741748737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+smKTbDA0k13UVYSv6ftLrHf0Uww1eKxMUTHXNn3NLI=;
        b=Y2vvkN2pukZQ5gim8EFZ3Z+b1gNid9hyc6ueKKmwqG6RTQ4le+GWVLJXuXyz/v8DSp
         Fn39kVd3Zcce3a/D06KW+RLsghBedb1YL6/Y0i5kSJKWac0BdTuExdODFFLI6odPercz
         CAH8W2iTKZSloURDRpmQgyxWYqNKcXyrJH2cM9aQJWc1KbdEqYaptjEWvi5mmxBSKaiQ
         gfrtfYgkrVDMS6CZ9VNcgvQH0d34JubCVMC5wpdPkUH55kIG3fZHCF9a+JxEXT2NL+Mc
         4tp/5MYt8wC3UIKYNQDKHvzPvFOoGDt02gZ9Vz5PySqVpDQeL8//vIIepW+o1JJNmeFI
         KaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143937; x=1741748737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+smKTbDA0k13UVYSv6ftLrHf0Uww1eKxMUTHXNn3NLI=;
        b=HNTHeulk7zSUedfcqz6tuRhMm6lm57Kg3fjhwXKxNLOYd5PthqTU5uY1EBBxVXUSwP
         1cnkQmG/fnGYBTUZzqSOsSSpw8J8M0gx3FMHbyRgkiMBYSz6aqLmbNrXiKfJXOnd779X
         nmuSmyXss68GlMIQT7A5Rrt72CV11q8rQkeceHRhDxLvFbIspKWJ+YTWF87rJ0t/jWKf
         DEut7z8P+YZSHoXNWIvfuq3ulr2WS7xB0fx6TvAWpgaCYbwmWQ+gWnusclJDuEyZU9sm
         JjgESSEZ5V45RCw1bR7jT5U8ughwJLIWpWvbcTq5FuIkDwr0RPOHhPBZLIsBEVcCgHpj
         /ktA==
X-Forwarded-Encrypted: i=1; AJvYcCUZegP8wdCcsd5a23uj+tp97Y2Wc2LP/JOxu0y3PJz4dke6OsW9dc99n1PVzOa0vaG4DuwZrHESfqvaR2A=@vger.kernel.org, AJvYcCVRcajaA1iP/DblVHWTFy92CWdy18E2nTpmKqz1vfwj1+rLu0CLh64lGwLAsmobRnUX453HPrnAeGuZW6cu4BuZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzODyvmnIKK6j5ZjAPV1SWMmlt2loVxNPIuGMxBLxwUsCMmmMBj
	7CrZHfhQv9H575hXdi5VI2UqKwywW/AfB5z1uSa5LbsB+itnF8Vc
X-Gm-Gg: ASbGncu6xqovG9khZJr2YT5/qAg2dgFBgI8Fwz2AoalCD6R7yGM3p4dVwBJKJFkbu+d
	8B7hdxysfdXxm3Tm7ynoFtsaqRMjYZXj51FZ3FbOQKdA1PmTjpS10rHDbGdpBu1MMxEmyuI+ljf
	v9RvTO31xPkUsL0TY8eJ+iodYZUFfKb8kQFo/Sl24nJs13nHCQAz0DVYTWcmVvJQhTUSqPeiaQd
	KVkvCL1Z8KR75oqXBE0kvYXn4845uo7GYAAN48nBGsqRLvhTJtdZT6o1pzvXm2MRjy/yQm7Ap/o
	koWuI1ef4B6CCT+4KX5aBw5h08amuYvNiupqcDq+3aNKqAI2KlY7+ZY9vAfjQwDL7lLUcm0fZ1Q
	62oP7isFBNi1zH+9ba2GTL/iTOfX8ebxTw6w=
X-Google-Smtp-Source: AGHT+IHoVSPzj/lvLcsVS6uwvkqTeZb7BDh933B4bENtWOIJJDtOsAV+fXzGX+/TwWLAUI/Xcxu2+A==
X-Received: by 2002:a05:620a:2720:b0:7c0:bde7:61b1 with SMTP id af79cd13be357-7c3d8ef3766mr251160685a.50.1741143937345;
        Tue, 04 Mar 2025 19:05:37 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8a2170bcasm60554756d6.34.2025.03.04.19.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:37 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 476B1120006A;
	Tue,  4 Mar 2025 22:05:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 04 Mar 2025 22:05:36 -0500
X-ME-Sender: <xms:gL_HZ2uQhfoBSN-AUCth5YeBh2ctwa6_zsHc7aMptTa8YziZSh0SGg>
    <xme:gL_HZ7e7ON9Uzrx76p1Vs3gNyoAGTnuc5nPioVaUWhvXQh8BjIYIjcyYNx5KHjXW4
    Fv-CCVp3ccK060a2g>
X-ME-Received: <xmr:gL_HZxyv4rlN7D1u_EiwprOY9S0VWGQBr-1_q7yhMXNlHyjIKmAqfOQv-Q>
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
X-ME-Proxy: <xmx:gL_HZxMji8lTi4O7-4C_eXI0sYL-lZVrCjWeWczO-aWj2EKE1uWBtQ>
    <xmx:gL_HZ2_FiN0Dw3Db-kAhaBmcRgb1-IU68t0LntX6x3pUyBKHVKjH3w>
    <xmx:gL_HZ5Vm2PlNEbA2oEB7oXmXGV3c6KJFL1tMhYWBvX1Y8B-vxAnIdA>
    <xmx:gL_HZ_ccRwcGpKux16zw3G3cCx2qLqpBA-pFgISboVZQ9LnWBWROXg>
    <xmx:gL_HZwcMsuuhuasD07T0UXzuzaxTuvkEBXGa7UV3uS2N0uBEDuETRGle>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:34 -0500 (EST)
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
Subject: [PATCH rcu 07/10] Flush console log from kernel_power_off()
Date: Tue,  4 Mar 2025 19:05:02 -0800
Message-ID: <20250305030505.94059-8-boqun.feng@gmail.com>
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

Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
and shutdown time, which hides shutdown-time RCU issues from rcutorture.
Therefore, make pr_flush() public and invoke it after then last print
in kernel_power_off().

[ paulmck: Apply John Ogness feedback. ]
[ paulmck: Appy Sebastian Andrzej Siewior feedback. ]
[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://lore.kernel.org/r/5f743488-dc2a-4f19-bdda-cf50b9314832@paulmck-laptop
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/printk.h | 6 ++++++
 kernel/printk/printk.c | 4 +---
 kernel/reboot.c        | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..5b462029d03c 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -207,6 +207,7 @@ void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
+bool pr_flush(int timeout_ms, bool reset_on_progress);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -315,6 +316,11 @@ static inline void nbcon_atomic_flush_unsafe(void)
 {
 }
 
+static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
+{
+	return true;
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 07668433644b..057db78876cd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2461,7 +2461,6 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 #else /* CONFIG_PRINTK */
@@ -2474,7 +2473,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 static u64 syslog_seq;
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 #endif /* CONFIG_PRINTK */
@@ -4466,7 +4464,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * Context: Process context. May sleep while acquiring console lock.
  * Return: true if all usable printers are caught up.
  */
-static bool pr_flush(int timeout_ms, bool reset_on_progress)
+bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
diff --git a/kernel/reboot.c b/kernel/reboot.c
index b5a8569e5d81..41ab9e1ba357 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -704,6 +704,7 @@ void kernel_power_off(void)
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
+	pr_flush(1000, true);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_power_off();
 }
-- 
2.48.1


