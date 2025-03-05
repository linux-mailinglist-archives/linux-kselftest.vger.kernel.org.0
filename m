Return-Path: <linux-kselftest+bounces-28275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953F2A4F511
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A366D188FA83
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784433FBB3;
	Wed,  5 Mar 2025 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ydz45RRq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D7469D;
	Wed,  5 Mar 2025 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143914; cv=none; b=pXEBKxx9raXPA4IBerxej/qZGPVeDFW0JQjE0qgxZYzXpkNc37M2czMzIiUwIFN7I64vFxgmH4FKST+PPZQw3g9hn43MIyVGdprqkcVyR0f/h2UlhL1Np+arbRHq6uBpDp3WcYxluF4VX+Iz8ud+tvxze13mXTMufUntAQxW2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143914; c=relaxed/simple;
	bh=uIzTrgOptV+UJekRK9fZqgVZ4HuhUabXU00kNLk3AQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X8ZTKJ3OtILmqz9z5Yi6WjB6gR5nwCR3/D1fUSm2pVuoF6WkpjYSqk6uw2EMwlZ1JzRm1VFCNDqihV9/fEtjM0AmhqQb8BUQIrnI5/40PmDeijVr3lIIr7KjgviMREhtfrNZ5jp/CKF8/j8LvSqrWKONOugpOPEJpng6wV3qYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ydz45RRq; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be49f6b331so615689485a.1;
        Tue, 04 Mar 2025 19:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143912; x=1741748712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TtAhruDk29bBD+n/3w0sFbMJ4Qpp/JAWf4U/2iqtCyo=;
        b=Ydz45RRqYOLcT7H/sK6vDJjSg0DdQ3L5oNBADSBWHPKC5+vWmDKZYiX4TykSU7kDvD
         +uquPwyIxQuZ9ZxKCfBL4VeoGIAE54DBn8y73NEHmxJ/lvDG+4C0G61gkFde0coIX0DY
         Frdgdc0s1C6fUpIwecBKIsAiShhaKdy6jfWPswGvKw95wiGPX5AbL6BaWum/UEgCiaoI
         ZRWGO01LS6tKOh4UTiGDd5rGDdTNlNpTM4bWgFwVy32QPUq4pTwoSq0pe7gaYbGq7ICn
         09URTTDVzdQx8O2GryF9WpQEco4nbK1Pb9gcWOp26QJlLJ/Tzh5KNI9H48/A1sl2hK8K
         6D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143912; x=1741748712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtAhruDk29bBD+n/3w0sFbMJ4Qpp/JAWf4U/2iqtCyo=;
        b=nfJt+lIlRjgK5c2PJx3NzN/2lBWsjpgr/T7OeLv6BOaww/e3sTd1B/Nv6U5kOoVoqq
         fVO0YH2Nm97EBAZyG8mxREHoEt1xSlHGpURZAtIyt3/6rShwAycFaHJK6CuvPS4EvM60
         E3h6OEtNR54asJKYAwiCGTfgCLclxz/kuCmsbw0//zwFPHTWGxKoWkKrDWyDH+jJgH1m
         CsCIKxg4rS52fML2jawkasCZdqFxuGgibOAFlcJgSh2Eh8GALnoYNcNwLAKGDN7eJb9T
         zmqW3jZdld2wt6WrnewOOh9PVsUG/wmHHStXFu8Dt5XttrAPTJ8Uv9do581E5kFwPCXz
         rJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi3gvcO5My4yzZyLDMpHRruWuRxMqjf4gQlta2ESyCBIt8476iz5gTq4wKP8kXE+DpHd5gvUt4gUO5yaLEgFqc@vger.kernel.org, AJvYcCXGmMUhLKM3U58CfXqiUbjftJKDwroQeBo5gTqWamnuKi4d/+CQdlOcDOeX4H6XDtBf6+Uvr8xD7SD9EQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwenMmcxMlD9DECzO2T0F3BiG2AAvHs2pSeYW6QaexTmU+Idwct
	UHJAeNJpbvR+ptM9HFk8ZuALkk0dat/1dwKzO8UxgyfJnLo73Vzy
X-Gm-Gg: ASbGnctVq6L7jpZI/yxbZguOXVUuKH4FZsYTlOnxXm2QDJNQteeukproSY4+7m2zMQy
	kluVemb37/+iFFuwD8eqxrDqajIvN5YQPrK4bfiV9TD31PSOQvtsAYig/GeNF088dMiRS6v4xgw
	iHumOeIUxz7AF1xZzFZfg5KNBGYxzPRoj4ReDeak/CVZK+aMgN9BYXfnHs9k9seixIRfCxx0Id/
	NvBpUIILqqwJcBz5YQuwU//oE0HPLI6FQqp1cxI3VipEszck0cKh7MYtR5RSbGpQY0wkAWsXLji
	O7kk+kX62r3GRwPSVcsfBIG3687eE7tdRo9Ou1dPeJfUQVNiqOzVSWhbesEomjvC5s2EtHNZwTu
	YfIruHjSz8z9a9Vxmcg9jn1YWLWfljPfBY1w=
X-Google-Smtp-Source: AGHT+IHwQLXuLEQr6SIyS0fEOaahuVSMv1SsSL+2Iy9aA+a8PVMQN3EvE91Y8mnyVFrxKHSo2M8kYg==
X-Received: by 2002:a05:620a:6190:b0:7c3:c3e1:3200 with SMTP id af79cd13be357-7c3d8e4638amr284054285a.1.1741143911563;
        Tue, 04 Mar 2025 19:05:11 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3bfb2a5e3sm331906985a.41.2025.03.04.19.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:11 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 652D8120006A;
	Tue,  4 Mar 2025 22:05:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 04 Mar 2025 22:05:10 -0500
X-ME-Sender: <xms:Zr_HZ8wbXq--XXYslbbNxSkkZNsZ2GNp0gajfIbKWwhTnagViLFghA>
    <xme:Zr_HZwQ6EQghexBNJ_NCy_XUXiyroWQBaVLV4KWENh8h5FtDYKmgLbyMoQsERaFNc
    gCPGsY9uFg533882Q>
X-ME-Received: <xmr:Zr_HZ-WjhdQ2eIlHZQlGRjv_MqUrJXcyitg5QguQSIHwzAx0ZgSZAtJHow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepkefggfevuedtuefhgeetveduudffjeejvdej
    ffettdekgfeujeegvddtuedtfeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepfeejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhmlhgruggv
    khesshhushgvrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdroh
    hrghdprhgtphhtthhopehjohhhnhdrohhgnhgvshhssehlihhnuhhtrhhonhhigidruggv
    pdhrtghpthhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtg
    hpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvggu
    vghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhh
    ihrgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhn
    rghnuggvshdrohhrgh
X-ME-Proxy: <xmx:Zr_HZ6jyJYC-it1RQ1vHWM6KRbNUjAO_svgO2G93Sli1db6dQNnazA>
    <xmx:Zr_HZ-AFT0fk9hl3lxH-jR1XicCJd9oXRkUXduBH0JGB0SpwmCDW4g>
    <xmx:Zr_HZ7JcU4eenAE7l1N2fVw1g3bCv25xYSXBz4-s-OjQ6S3Zb6I-6g>
    <xmx:Zr_HZ1D1e8ahvlEpSZgU844TsTsP0D7ZalwjCIweHyPzZjDGpMrKxA>
    <xmx:Zr_HZ-wfnm9C1Th2OCSrnxBms7W5hEcu7QuLOTBQbTvKjkT46Y1siCSM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:08 -0500 (EST)
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
Subject: [PATCH rcu 00/10] Miscellaneous RCU changes for v6.15
Date: Tue,  4 Mar 2025 19:04:55 -0800
Message-ID: <20250305030505.94059-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Please find the upcoming miscellaneous RCU changes. The changes can also
be found at:

        git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git misc.2025.03.04a

Regards,
Boqun

Paul E. McKenney (6):
  rcu: Split rcu_report_exp_cpu_mult() mask parameter and use for
    tracing
  rcu: Fix get_state_synchronize_rcu_full() GP-start detection
  rcu-tasks: Move RCU Tasks self-tests to core_initcall()
  rcu/nocb: Print segment lengths in show_rcu_nocb_gp_state()
  context_tracking: Make RCU watch ct_kernel_exit_state() warning
  Flush console log from kernel_power_off()

Uladzislau Rezki (Sony) (3):
  rcutorture: Allow a negative value for nfakewriters
  rcu: Update TREE05.boot to test normal synchronize_rcu()
  rcu: Use _full() API to debug synchronize_rcu()

Zilin Guan (1):
  rcu: Remove READ_ONCE() for rdp->gpwrap access in __note_gp_changes()

 include/linux/printk.h                        |  6 ++++
 include/linux/rcupdate.h                      |  6 ----
 include/linux/rcupdate_wait.h                 |  3 ++
 init/main.c                                   |  1 -
 kernel/context_tracking.c                     |  9 +++---
 kernel/printk/printk.c                        |  4 +--
 kernel/rcu/rcu.h                              |  2 +-
 kernel/rcu/rcutorture.c                       | 22 ++++++++++----
 kernel/rcu/tasks.h                            |  5 +++-
 kernel/rcu/tree.c                             | 29 +++++++++++--------
 kernel/rcu/tree_exp.h                         |  6 ++--
 kernel/rcu/tree_nocb.h                        | 20 +++++++++----
 kernel/reboot.c                               |  1 +
 .../rcutorture/configs/rcu/TREE05.boot        |  6 ++++
 14 files changed, 78 insertions(+), 42 deletions(-)

-- 
2.48.1


