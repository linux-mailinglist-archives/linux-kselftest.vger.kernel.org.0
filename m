Return-Path: <linux-kselftest+bounces-27417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A59BA43405
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27DFE7A573F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A129257449;
	Tue, 25 Feb 2025 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJs3X768"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDFB256C8C;
	Tue, 25 Feb 2025 03:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455740; cv=none; b=BQfTjcJjmLnHxa6cw84/rhDAcOHn+qtanvJ7ydh9BWA3W6F49FmGVd4rDm6dr4LbixrMp+bHoGyqbUnvzCDfOCpcEIhA3algm24hF8YY19o4LjV8+czkvZEFElQ2UDddu4clpvyxkTgW6KMrxEV4Me+zSqBY9O9llNgvwrr2J5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455740; c=relaxed/simple;
	bh=hqCPdIph2mEXGKw96mZQH91SjWkRnJXKURdGMWJHfS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bgDWJBtxuZc3ZcwsPCR4S2KoR547JDlJZWlhamEoWthMWmtA0YyGijdCtqy74H3p235OXVBn/EDgKriiA7tF3WbY28do/6wf1MW1kWTydxFDPBA3IWAbz7peUui63fduP1aWK0wBKFlvdECrhnNnAQnvz0oFNVnHoY2NBt4b7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJs3X768; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471eb0e3536so78830541cf.3;
        Mon, 24 Feb 2025 19:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455738; x=1741060538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PqEV+yYJyqQ0AIRDTVm+hLCdqAfJYbttiuL3CvWulpU=;
        b=OJs3X768dAQC6CgGqZZi7i7mspSXe++mJO2rFfPctqV1vhgY28aDbr47A7fpNOYx5I
         1VqKm2QHqfeBz7EWXVCD53NWFiDWqxKLm4fO9syVpU++DfmkUHn5dkDeaiw51yXcaPgF
         32/WysFFP+VzC57Hi2vLQAGwoxWXpbHfWN7Dn+V+sG6FYRpEw3JAW5ULVUVTy1p6Hae2
         fHJjaNiLFHSWSPUiRJg8clnPMiOXjadn1Gjp6invEYx9HoK2Ubji83nYDbRa+iTE69TQ
         kRjV4VvwN9T2Wq19gJq5v/ZG+CT4v6rUJfrc1LtxqO8D9oH0RRfBTS8atqnsayBnQfUm
         fRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455738; x=1741060538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqEV+yYJyqQ0AIRDTVm+hLCdqAfJYbttiuL3CvWulpU=;
        b=KFE9/QgoPHo8oxPY9c6/dR7C4d+DlsA4g+tl+yxSbtDQgvjWVBWMy0muUumtKa1bC9
         rqM7laFvNRs764YhN58x1f/F0aun7Ur8c2X6RrPrpPtbfTdZpfzpA6+za2PCSiDWnr90
         n+wybk4DMLIRagrPNLbC6N1g0XWZkp7tp6oPJ07YKdkX7V2Ng23AQN5mJpnZptYRjibW
         LluJ/msfeAyL2w/+Yxdid/JVjv0h0O7d+n4uHpq1LUhrfBiw2WdE8UewUswz3vvSiUaL
         4NYFq6hQJyJ72CZPc3MF+sNEM7dAUzPWpcSQ50xG4+pXOMFH3KyjnE3k1VPcd6HNGS32
         lurQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlx4FeRUm1TPtgD65oKk0iwwTt0EXM1QcJyJshh65XohXp+EVu6dRI5OldhtiFo1g4Ua1Dt/0jqFtU6lg=@vger.kernel.org, AJvYcCWs290I8NBDw6+WhtthEn5+3QMDPJ6KZR1loX4Z8UXp27wiWuVCpi6CRpQDaVmIkKNlL2nwvSBhk8OnFVQZA8eA@vger.kernel.org, AJvYcCXLr64yp3T15y1IdT3fYRTZsa8Qz9KikJFhDnuXd/nO4FyRz0WpW43hNJ9++rq6f690gymaOatOaNtrr0wdLxV1JQl5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywykmu8gVtls+DZpu1+6cyIE0hLuo9hx2iS/eLaCSabHfAE1p/9
	aP0S7Yif6S9c2P3Q61hY+wJ2KvE4Hbd2srEDsM/WBq1iiQ4B3upa
X-Gm-Gg: ASbGncv4WBc0R9oEFBLyXGL72GyyhwRtWM6mce+Xlh/TExwwrvUwmBdLMVB+XK0bZza
	dumWCeOLo4Uuc0NgMpVSrx2nV9rUwbDsEM+VJiVfk5PvA4y8RKW/jC0HWn+18/A7qVFYhv9OaPs
	mrVxyUvAmvWXWAalC6Q3ttW1aCF/EbzeP/5FxVYT38qxQ387za7b39yfBhXKbeGt3dMHmk/qm/f
	r7vH5pg54gYlF/VfUuJ34Qq2p3q3akrEqhk/WZ71Xok+TIzG6n1DBPS1wDo2xkN4uZz33yQhRYL
	Y2s9MONBGVoTHpDeiB5/Ss44m6hdl5P/ALWWUkBGRJwy3G5e4V4/KjT2qk11o9GRM6PFwr/rNSz
	IUxC9enzhYaJeK+sc
X-Google-Smtp-Source: AGHT+IEyu+HpjxoL6jLdU8QlNCqQMreXwroF2Gy7vXziN5drHf/L9XWouCuyl5ZeNAVe+tBWLmGsbA==
X-Received: by 2002:ac8:5f8d:0:b0:471:98d7:6f52 with SMTP id d75a77b69052e-473772292c1mr23391531cf.27.1740455737638;
        Mon, 24 Feb 2025 19:55:37 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47378093f75sm5077551cf.81.2025.02.24.19.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:37 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 54C521200043;
	Mon, 24 Feb 2025 22:55:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Feb 2025 22:55:36 -0500
X-ME-Sender: <xms:OD-9Z4G-iIGQPgLIUNC308rYIvKScu4zjTGGjKSynZq8Hpxa2yFV8A>
    <xme:OD-9ZxUfQ8c-7LhrMf4zK54b2XtltJEjJkxWV-W7YAaEubaDT3870wAkmb_bMMn1J
    JRoSRiHDGkA7rPi-A>
X-ME-Received: <xmr:OD-9ZyJyPfrxZwGZl_FDG_jihsHwUBfqWNmjQtVq_nB6s9S4gjDqNFZhUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeeftddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrd
    huphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgv
    lhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiph
    hlvghtthdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehroh
    hsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:OD-9Z6GQ77g3i5WnFLJnnmqEkqLobUNH6fpCMLm3LsKrhyji3TQMLQ>
    <xmx:OD-9Z-X-oCjDXsUOrESpioCGcBqvLUuPSMD3pzuV50qKP0rHDMgvmw>
    <xmx:OD-9Z9PhkAMjelULeDfC42W0Qxp_cJeMMRkW3Qu32zQZS71eShQpRg>
    <xmx:OD-9Z11KtUobSBW1fA6fxwiXTcOH1IVOs9Iu398zA2LiXUr0Yt8PIQ>
    <xmx:OD-9Z3UEbeyVbfbgvwUX2RvzLT6KSARuaGCutElgjmr6kLR5TMgWgCJK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:35 -0500 (EST)
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
Subject: [PATCH rcu 11/11] rcutorture: Make scenario TREE07 build CONFIG_PREEMPT_LAZY=y
Date: Mon, 24 Feb 2025 19:55:16 -0800
Message-Id: <20250225035516.26443-12-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225035516.26443-1-boqun.feng@gmail.com>
References: <20250225035516.26443-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit tests lazy preemption by causing the TREE07 rcutorture
scenario to build its kernel with CONFIG_PREEMPT_LAZY=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE07 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE07 b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
index d30922d8c883..352393bc5c56 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE07
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
@@ -1,7 +1,8 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT_LAZY=y
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TREE_RCU=y
-- 
2.39.5 (Apple Git-154)


