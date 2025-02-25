Return-Path: <linux-kselftest+bounces-27406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A7BA433EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E13173EBB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E691624F8;
	Tue, 25 Feb 2025 03:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwrz8vy5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3401F5EA;
	Tue, 25 Feb 2025 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455724; cv=none; b=OtvILkxzFjsBDexD6WU4KAL7IGoWh0EsDrBfJ0w4X8v9T5TrWLL18lHo66gUQ7DPuMqRbcaK8l2xIQaDotGNqcUAWjNiolLx1ZTeaBDDMQEno7kqz9qFv29qJxPYyVrBPrKMC2ZVU9wODIT9SBfA5DcOZzRurjClTcq8PcIlnY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455724; c=relaxed/simple;
	bh=pefu+apHg1FJIpZcIST1bAC3m5urfKWcflNtgIKaluA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n+rt6pZTx9da4Hh1X+N2BaY9uBAbg+4UXyxNBDB7FRogyC2HQXZd9himIFccqQqaHvtLj2+5lThVLA4Rk9NK7tTCa1nXWgMXXLfv7dFkwmRZ1FdEpAMSQFeXv1sGeGSaAN1CWVrIoHvCG0LQ/OYyPQDcEa9NbscWwddI2fWP8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwrz8vy5; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4721aede532so53743431cf.2;
        Mon, 24 Feb 2025 19:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455721; x=1741060521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zkjhQDR6B/e9DB3av0qlqp5AWtugskcn9vkx4gxJatw=;
        b=lwrz8vy5FVNsWmaexLrF8GGMHqpSk3BnBjcaY64ej3FYJ5ery4EucHW89+ykKDipb0
         uPoOzmV7yxCgLy6i5Y8xoaky8nArdVfWbbE/IxhdrSbTzhrPYaDhD5Fg5ekHTZ03V2ZH
         nqlpMYWeJNZuD2H1++GqypNvlqzz/w38up+aYquyEt5sg9w7BNU+bmpPNBTC/otT913E
         JWWY6oKm6IR9o/XL9EKFqQVx/oI/IvxaRLMvxBeOuWZSaxHMDDAAUWOtD8zsFl73cjiZ
         hmQ1PSOZQOKYXZDJLslWQrJDSNylylE0/8fiy1Krsi6qUCK2GSgBabWivwn/8X28Qdjv
         1VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455721; x=1741060521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkjhQDR6B/e9DB3av0qlqp5AWtugskcn9vkx4gxJatw=;
        b=ispCT7zM2RKuAif/E7uJhBgsuEbArL2OFjR23AvF2ayb5siWEUT9VBK38B8oMYMvsv
         lUG9G0huqpdN5bOndZSsybo5DsGaxv678dzvzyKZy2U242iA5Q2OAXMdciVDNL9LQ9uZ
         9NLq9hUptSdTw8uwBtNschvAVtpybMYJnIA7MNl47Rsdb6kbf+lVjnhuAw2xUHEeXEw9
         BEuwjiRno0O9b/NxHfk8P1TxOGY+0Xd7wLUTzXahaMlEOSEjV+ibD2VJlofGrG9vQu6F
         yPiZA+jivr0cwkGUnkrtgnKMqByaTtW5NznDw1SljekJ8pplIDgkJKBQ79w4fMZz4oIV
         gCYg==
X-Forwarded-Encrypted: i=1; AJvYcCV1reE+QLzv7hbKB+VzxST+HlReChM6sgfQE5Sf2k+Dh4WxGPBsMKh9Qppuq7JMIMUn5l2brNjdB6akxshL3O/9@vger.kernel.org, AJvYcCVGO68QG36OQ9vre6tQ8WHxRY/PErl/DTN94ljMHlWOAyfmZv8UXHpWsr58LAnVlOi6xOdtu1Ef1It+5BI3GpE3B2Ul@vger.kernel.org, AJvYcCXwYL6EoI+DgkT79vcQM42fSGM2r60AFRq/uEOOKq1a24cqb8ukQN82FwFHZ6JgpJ4DLB+cw4whQcKAnhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcUpw+4Ojasr27diqIR+RGpXgZmlSOUXnBlo/gmKVhdr/WqxSA
	K+8XYoCKzLWIl9jmk8fcGm4HTq0CErpf14QFHtPHoKE2/H+zxPHm
X-Gm-Gg: ASbGncuY5udv35CBKHkioZLGMwQ6NWOGleBQUrOm51uYXyGUJpQfRoNUVKuQkDoXUR2
	bhTeRurRNuD9hfJgS5DwjSkz5AmbV+hLwswTGusGK1HK4xjivlgANaaET8ZVMpgGftpubt3yMyj
	qvFynCLToWQq8nmql4MiJHmX7T8l3F1oj0JQG5kcMo2p61HoZoGjr938WEjRZLCNJYkGAmaSCRW
	fRZTpA5sbhTeMR/vwsbTIagULcaeKv3UC55tNA34axJ6j9YEjXjXiJBdwju1IUejv9cPcd4ea7H
	KThyx76Lg6BTY5oYzgySa2kVvrHw6xjZOCAXKXo/rgx7AifEHHt6dIjuRKRPYQxQjvfDyuMO4QJ
	MJg9/ajI43+pmn3un
X-Google-Smtp-Source: AGHT+IHdAUF7H/T2eKG+IBzHRzOVJjJIhODGbEQUFqraSHRKitxiF7tQ2rXvt9tt/MDkDaVyb+rmmg==
X-Received: by 2002:a05:622a:2c7:b0:471:f7a3:f78 with SMTP id d75a77b69052e-47224716fc0mr177433141cf.1.1740455721384;
        Mon, 24 Feb 2025 19:55:21 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47378088079sm5095001cf.80.2025.02.24.19.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:20 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id F28BA1200043;
	Mon, 24 Feb 2025 22:55:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Feb 2025 22:55:20 -0500
X-ME-Sender: <xms:Jz-9Z94HBwrcUbuYLlbV-3tblPI0Nsht4o0zjELSmTTDHH7Je4Dw_A>
    <xme:Jz-9Z67praLRuQSLtGd7E-6k781eoaDXrlwbiO77e6xfXvB7aHji7l4K9ihkFEe_G
    6EJYAuhQj3VtgsMYg>
X-ME-Received: <xmr:Jz-9Z0crx8vDYGAoDDQ7Q4Zd0hbSPpXvqO5OJG2wmmnwvUVWnlcg-hfNUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepgeegueekgefhvedukedtveejhefhkeffveeufedu
    iedvleetledtkeehjefgieevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepfedtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprhgtph
    htthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtohepsgho
    qhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhrvgiikhhisehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrgh
X-ME-Proxy: <xmx:Jz-9Z2KjBnGMKmzBTeLtLQO-8AMDF4_diRqCW7SZG-VFpIOcz2KnLA>
    <xmx:Jz-9ZxJhOe2BiQ8-Ft-is1TIq8SByi1MBP7agCGH6UWjSbMai9EBuQ>
    <xmx:Jz-9Z_wcIyjC-OCQ4NWn1cgUPMmBy2lbIdsuaapU4JEBH8b4yly4NA>
    <xmx:Jz-9Z9JQ61U_VcMdO-kXAbxPd9574J_JcLyt9y5fTiLs5ll-NCAE6A>
    <xmx:Jz-9Z0biFqabsz3C3GqoSU2Xan7PttpDjn2SB-uhWen2GPLX7_lkiT-u>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:19 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,	Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH rcu 00/11] Lazy Preempt changes for v6.15
Date: Mon, 24 Feb 2025 19:55:05 -0800
Message-Id: <20250225035516.26443-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please find the upcoming changes for CONFIG_PREEMPT_LAZY in RCU. The
changes can also be found at:

	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git lazypreempt.2025.02.24a

Paul & Ankur, I put patch #7 and #8 (bug fixes in rcutorture) before
patch #9 (which is the one that enables non-preemptible RCU in
preemptible kernel), because I want to avoid introduce a bug in-between
a series, appreciate it if you can double check on this. Thanks!

Regards,
Boqun

Ankur Arora (7):
  rcu: fix header guard for rcu_all_qs()
  rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
  sched: update __cond_resched comment about RCU quiescent states
  rcu: handle unstable rdp in rcu_read_unlock_strict()
  rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
  osnoise: provide quiescent states
  rcu: limit PREEMPT_RCU configurations

Boqun Feng (1):
  rcutorture: Update ->extendables check for lazy preemption

Paul E. McKenney (3):
  rcutorture: Update rcutorture_one_extend_check() for lazy preemption
  rcutorture: Make scenario TREE10 build CONFIG_PREEMPT_LAZY=y
  rcutorture: Make scenario TREE07 build CONFIG_PREEMPT_LAZY=y

 include/linux/rcupdate.h                      |  2 +-
 include/linux/rcutree.h                       |  2 +-
 include/linux/srcutiny.h                      |  2 +-
 kernel/rcu/Kconfig                            |  4 +--
 kernel/rcu/rcutorture.c                       | 26 ++++++++++++---
 kernel/rcu/srcutiny.c                         | 14 ++++----
 kernel/rcu/tree_plugin.h                      | 22 ++++++++++---
 kernel/sched/core.c                           |  4 ++-
 kernel/trace/trace_osnoise.c                  | 32 +++++++++----------
 .../selftests/rcutorture/configs/rcu/TREE07   |  3 +-
 .../selftests/rcutorture/configs/rcu/TREE10   |  3 +-
 11 files changed, 73 insertions(+), 41 deletions(-)

-- 
2.39.5 (Apple Git-154)


