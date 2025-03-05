Return-Path: <linux-kselftest+bounces-28279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8287A4F51A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2139188FB02
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927E18FDB1;
	Wed,  5 Mar 2025 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4+IfiPx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977D18E362;
	Wed,  5 Mar 2025 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143928; cv=none; b=LHeXh59rqaSZPF8KKekBgCFiWOQsaQ1U1vDrzN2/SwIH5vgtU2F697UInI4/r8b9ESKHgCpHQatJA/xxKgpC2rwOUgec1mqJyxztEllDB53BdWrdGWmxQh8Gs5HRVYauwSIvTHga/u+DYMbe8A+d20xJ5uTkDie8rbKWskc2ZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143928; c=relaxed/simple;
	bh=yaJ+DQyu7jgku83hxrldRW9Dcg/hxCWf9piH4QXexso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWpVcc3wQedRJ7pC/ZGmm3gSZOPONqxFopsgBzXxW+a1Qi6avFVY0m07uKRJligP2snxcAMNGZ+lFgr8q0TrShN+8W+117ONehb7+EyJ+n8+amXRgpRSnTuVgU/b8KYfrRuuDE2pkC00X3kfD4qC+o+06wMQcTEqtF3UcA0hv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4+IfiPx; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47208e35f9cso73429061cf.3;
        Tue, 04 Mar 2025 19:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143926; x=1741748726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p1+X3BI72665Sj5vQpqBBeIcR4eyUiWJXeRi1lyT/24=;
        b=d4+IfiPxoUsQ2TMTjW0XcWD/m6ksqPW1Co6nieFNcOFcEv6mST7eLR9+atoqmBVDnc
         w9mWPRW087AN4XIZauLmiuLHcDcnc8tsA+j0Y6IxX+t6bztl0LsDHXXcgG1tTjw5TuGq
         2MMxGJ+3mdiwVyJwb9GioODHEY93lm+3jaXkLEagEYad0W0QHdOcLvVbSK+dX29IcZvn
         XTId34aOg0tRXe8oS9z0PZaZ2Uzm6rboLlUO/jICLL1GHv+qlkn6ibHEbV4QUojCcyrB
         HvuFdC5nX9qFH1oBKHT1pNF9txJW/f4Tf2wLQVLEgFePN5YP6gfeueMC/GU3VtTSqPwO
         fTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143926; x=1741748726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p1+X3BI72665Sj5vQpqBBeIcR4eyUiWJXeRi1lyT/24=;
        b=tXVHwXlZN1plKXnkcMtK9vShNg2M0KZfRTRId64LLC8I5Lx9WisWYiag6QNUNlK7Qw
         3dg9+jOuSNY8Us5raisWZvoC740nSG3EDb+yII5igIEB8Uj3cpmgwwMYZ6ql+LSA8vFu
         EgVuK9WEQe6G4v30Kv1ivHjbVJ+JJjTOPOXSohsDWcO0Oox7Uux50mxSkCIJOlANbWGM
         P5dLAGM6k4W6lUpMgDBCMSOUqOXEWt4zjAKeJyLtMQS1z2ZDEpb8AF6gpfHznAt/fcCH
         jTRgo6JxPwrN+iCx3LoarMPYHouCV+nRsTnjztoOc0CwYkOKgcvc7nNVZMo+he3ue5jB
         t54Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKTnC8W5qhokBM7oaHQKwdjqvvWnNnR0IVVYBRe9wA41lB/nPqewDGFTbNpkRe82CzLKHLwGMD2fBtLSsBb7+HAiMQ@vger.kernel.org, AJvYcCWoww8zMiYYVMgM6Fr55c45TEGUHkivA6gcwYjTUEoWTYGfA8bjk4KLX3jeZJn9CTJkxD5N+X4ZMEocwLxczWl4@vger.kernel.org, AJvYcCXcyLwxUjhn7uvuMc85EOfe2sOQwnW1RjIXcyKg3KF3/ItIs4lUHa8BOGasItKi/m+YmeW5ZlMPOoIzdCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OK1xtoO8UxgiD1kYgriUDL7QsRDT/mecVHYOOUcTmEri4Eth
	hbZpW7VoTHBzEMffvTyJ31kDo6C2Hu0ejfmQZZvUWvQJc9Hnegb+
X-Gm-Gg: ASbGncsnLlyfmVtVMvn5VDlh80QNUXtq/URF3BEy5Xq4uQXv4PNDUhr7zgFN9MVGTiq
	cfeBqDbql4QJDkAek3bYby6T4d00PMX8eZ/cJ/e+FE4SLhGbAUNZK7qXYbNvybvibaUfKmQ5uCK
	vYqN63gkIbOiNuj5XyTPA2bEw85lDDjIg6GI+X/2FryT70Jdv4WpmzLPA9haJ0LJ+5fbJec9i3Q
	l7jIdAckm/BocZM+a+hBpQM3KJQPdI5lf4c4jcs3Sngs6uxIMC2aX6KUgr+4nzOPtkTYBo4NUJO
	6n16lFHMUyMtBbpl6gG/1r96SnSO4T/y27w1vyO2x7XXu+1IaUbGQEtwoD3y032ZQD1KjFtrVOh
	Pdl9KHi0EVfSM84eClAr+svZV+3TdABsFCHA=
X-Google-Smtp-Source: AGHT+IFbBzLp/C77QcAR9BoVEbCyhnuueyF8GxM8KCxvhjob14XQ4UwhaxUTFVNhUWH98KTaLoUecg==
X-Received: by 2002:a05:622a:20a:b0:474:fd83:46c2 with SMTP id d75a77b69052e-4750b23c91dmr14286011cf.9.1741143925875;
        Tue, 04 Mar 2025 19:05:25 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4750a6b3b86sm6741061cf.42.2025.03.04.19.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:25 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id A5EE4120006A;
	Tue,  4 Mar 2025 22:05:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 04 Mar 2025 22:05:24 -0500
X-ME-Sender: <xms:dL_HZ9qtZOaaW9oxQ019BZx-0y7OX2USLVBpRgRrNLrcCjVy-xhWSg>
    <xme:dL_HZ_r9_SUcHs0ePJ399Y_sMWTs3BhEig7xJDjv19MLwYvXc-H_3Qaooz4D04oNH
    O8B5nCwWIiihtJ6lg>
X-ME-Received: <xmr:dL_HZ6MXLEVc1LXqMWrvGPcwnTnk73wfod9dh2L1FgOMfPZZt7AjpWB0jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepgedtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhmlhgruggvkhesshhushgvrdgtohhmpdhrtghpthhtohep
    rhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehjohhhnhdrohhgnh
    gvshhssehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepshgvnhhoiihhrghtshhk
    hiestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrgh
X-ME-Proxy: <xmx:dL_HZ47uKXqCsi9H7XyXN8MO3BLXA70sCyQITPQiNC6lJXtn7-g-5w>
    <xmx:dL_HZ87qWfu9EIkwf-QQmosPhsns1yuzpKkm1BeiWWIhCoQgFMl88Q>
    <xmx:dL_HZwiqDGm_MD4F6t5KuLwDEAy3QFsL5i1CRxG9m5LZq2vH9KCJUQ>
    <xmx:dL_HZ-4mJT3RT3TGbcbfAiaZ7u4xyx_EjB4P0md9UaeBOxf8cTyEmw>
    <xmx:dL_HZzI05LkmgU0oE8vPA0_3ENZjnIIQ5bxIMtU95Ymk-69thWK-Qqdr>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:22 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev,	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,	linux-trace-kernel@vger.kernel.org
Subject: [PATCH rcu 04/10] rcu-tasks: Move RCU Tasks self-tests to core_initcall()
Date: Tue,  4 Mar 2025 19:04:59 -0800
Message-ID: <20250305030505.94059-5-boqun.feng@gmail.com>
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

The timer and hrtimer softirq processing has moved to dedicated threads
for kernels built with CONFIG_IRQ_FORCED_THREADING=y.  This results in
timers not expiring until later in early boot, which in turn causes the
RCU Tasks self-tests to hang in kernels built with CONFIG_PROVE_RCU=y,
which further causes the entire kernel to hang.  One fix would be to
make timers work during this time, but there are no known users of RCU
Tasks grace periods during that time, so no justification for the added
complexity.  Not yet, anyway.

This commit therefore moves the call to rcu_init_tasks_generic() from
kernel_init_freeable() to a core_initcall().  This works because the
timer and hrtimer kthreads are created at early_initcall() time.

Fixes: 49a17639508c3 ("softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: <linux-trace-kernel@vger.kernel.org>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rcupdate.h | 6 ------
 init/main.c              | 1 -
 kernel/rcu/tasks.h       | 5 ++++-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48e5c03df1dd..36849a4ea141 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -121,12 +121,6 @@ void rcu_init(void);
 extern int rcu_scheduler_active;
 void rcu_sched_clock_irq(int user);
 
-#ifdef CONFIG_TASKS_RCU_GENERIC
-void rcu_init_tasks_generic(void);
-#else
-static inline void rcu_init_tasks_generic(void) { }
-#endif
-
 #ifdef CONFIG_RCU_STALL_COMMON
 void rcu_sysrq_start(void);
 void rcu_sysrq_end(void);
diff --git a/init/main.c b/init/main.c
index 2a1757826397..7f0a2a3dbd29 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1553,7 +1553,6 @@ static noinline void __init kernel_init_freeable(void)
 
 	init_mm_internals();
 
-	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
 	lockup_detector_init();
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 59314da5eb60..466668eb4fad 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -2256,7 +2256,7 @@ void __init tasks_cblist_init_generic(void)
 #endif
 }
 
-void __init rcu_init_tasks_generic(void)
+static int __init rcu_init_tasks_generic(void)
 {
 #ifdef CONFIG_TASKS_RCU
 	rcu_spawn_tasks_kthread();
@@ -2272,7 +2272,10 @@ void __init rcu_init_tasks_generic(void)
 
 	// Run the self-tests.
 	rcu_tasks_initiate_self_tests();
+
+	return 0;
 }
+core_initcall(rcu_init_tasks_generic);
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
-- 
2.48.1


