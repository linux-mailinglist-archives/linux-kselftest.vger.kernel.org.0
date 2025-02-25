Return-Path: <linux-kselftest+bounces-27407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33AAA433F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42856189AEB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADEF19ABC6;
	Tue, 25 Feb 2025 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IufL76ak"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66B7DA7F;
	Tue, 25 Feb 2025 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455725; cv=none; b=P1nYWntOuzvxTArs4CCqnzbmHI8RzIq8j6QsuYk2TVsgeOnCTYIXJ9VJ79z2QXnTmf/aBEC2tw02vqQ8kiNtIWS3dVVab41XeuoHeomNp+s0gsZ5aU2j4Yc6NrCvD7qniK15GpxX0YblFEJLf6+Bm99tgbxSVigNKL08pI0Y81s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455725; c=relaxed/simple;
	bh=Zn31EETp8TJfWpBU9ejw5q50uSb1zcIQxp4Yl0+1bcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6469QCvjTv2NfSquaC9dhu6gqILg4AWs1Mq6WlYb8Q6sy6bVk8XKIn/3UF+FOaLtzZSfg6SVbB3AW/kR7SKrOMOtUWXTgsqkpuD6Vft/FlfUNy11QgMvobl8uD4qciH2wssqN0Bae/VSnN75eEC//QQEzGwo1fEHNxgraYjW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IufL76ak; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd420f82e2so73283136d6.1;
        Mon, 24 Feb 2025 19:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455722; x=1741060522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WkOpGtQNsRJi/XKiVrTpjQ+EnHtEuuYo1UdNJPBjtUU=;
        b=IufL76akw4FYlmPOZjqQt6MA2M4NBS33hwc/sdqWNCG0Km5quk6C83FB/euKxic2At
         ApUAQ4yPCJUTZ4c/XwGWLtB7JvtgwC0c+c3RQ7na1neWI62DOVVWwNFDNIw2BWpBXY2J
         LeLsDRVCmeBevHhcQurlrR0BJ3W2MhoqOyhB3qzdTg7Zkt+MlcIq1Sxlk9nfzyIftSMz
         tGIZuauaggscn2essZ6qTyEWHz9W+h1UJwZx6DQHlzIGagoAFRHXLbXLXmEatgJ5BZmH
         bFc7PW0ZB6YlbcL9TUEDR2TwmGWKRlAWzAfVtahlNOrQ471xkbkI04bAtZay5CnY48T3
         s2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455722; x=1741060522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkOpGtQNsRJi/XKiVrTpjQ+EnHtEuuYo1UdNJPBjtUU=;
        b=FL9B5207ATgujrlYUs9AYA7nKjdRhSKqhIeMNnIo+hELx6sXocxkr7RKyWoSdGMSM7
         XdGqZ4QZgFAc9HB0/BjE4/Lfs6TTSpkhXv0PDLaZSPHAxL+JfIpWiyyV90NSjA6eRtZs
         7RvyZCGInY3wn+nV7jviR1RvAEdXN3SCHwMepXnCWHBw0BRItOvA31SCzscDiDn7e46+
         iIxnub4zfdYBn1ZpwGnhuK/pW0mHFtitgioD19mcotOmnHAVocL5G4PeroQk+qYcHCW3
         hRTpv5X2s1ZHRmHpdLRqN898oGdsiWAH1kGg0xYnu+PFBCWQ/dvIzPlHP9xvws0KpaBW
         RqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq3k9Cw6/yTrEVCZknoAx7MCu5mgl9dj2QQQqMvFrEUb3QL2q58RzxkV1qqrh0mm2fJnbUVFoqqXTS9Et67ENGUb94@vger.kernel.org, AJvYcCW8RyX8hafE83WjcvpXwLt0a/Pt72KkFL1Whp22Exfyc6d9ZrANQiEYMLW0TRQvBsGj19EZy4357WSjmq19J32n@vger.kernel.org, AJvYcCWR4ZyCMVlsJTAYL/CCokU/w1sbfYj93G20inopohHCyxfrejyE8n5jbPseELApG6UWl5Hle/OstYN9I4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bQTMzKrTlhiF0oAuMI57csDJMehw799SMyGXTZGUxBC0AbVR
	BhKbFrikf3WvExaEhXkFF1KEBTI5tFxRlpTq5+GgrLdTyAllwBqQBKzs7Q==
X-Gm-Gg: ASbGncv9XhTI8Inx7l6zB/YMvmOzhREZX5mPbRjIP2qBFgccCV6TxfJW/mzNzWAosHe
	IGePtOSJYbkDTydtKjurW3dx8ltdewoKZNhoPh+6NU8hZ4ir4qMLrhA+iczCUDhl4yHhxDEhn9P
	LZu5kF4XJchtZeulnW+ojqF3W37fxtyEfR0UCftDeHhvgU+Bray2A+CldDF4R2mZ+0eQU2TX+pQ
	gtqjYqL5+j4UQZ6Hzl1FzQjbVcnwdm8CvF0Y0R2BCbtZsNcZv9zZPW3CitgJnZC6eJ9McktGbgr
	qvCv5Colj1+N9JvJBAqTkSb4v5AfKPh9iXXP8GZDA9Vf+zvbQULrs0DWeFb/ZWUWquYHQJMOEXp
	M57LS3zjyTKvkaZMb
X-Google-Smtp-Source: AGHT+IHFM7nCfANUJnQWs5ua173vFVnzmAQXQGQ66e13i/keK033791LhwthqRphswwZvNeSbnygmg==
X-Received: by 2002:a05:6214:f03:b0:6d8:9be9:7d57 with SMTP id 6a1803df08f44-6e87abbab41mr27890766d6.37.1740455722610;
        Mon, 24 Feb 2025 19:55:22 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c29930asm61016285a.2.2025.02.24.19.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:22 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6EAA91200066;
	Mon, 24 Feb 2025 22:55:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 24 Feb 2025 22:55:21 -0500
X-ME-Sender: <xms:KT-9Z_kaZ9Rq6BKrCRZJiraP7DyeF3pc599Z7BrWQPL5STD9rGKCOg>
    <xme:KT-9Zy1OpCWednp30ceay1BHyLUGfoWfhyOJHacs8qdYQVv0gDhOioatdwnjucAlx
    Fgik8mBjb15y72s8w>
X-ME-Received: <xmr:KT-9Z1oPDrQ5gJeH_OwRc0iT8KRXfDjk1r9vuIa9NYWsgZxOEdnpV9aSrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeihecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:KT-9Z3nRosNP6AFzofi6IrVMGlBAltQ5fiACHfRHPwq4KoPEP0MV-A>
    <xmx:KT-9Z92qVdr1RDeXT2r7JbWXHSAyc3_kvADI1xF7m9oI_p6NHL_maw>
    <xmx:KT-9Z2vqnpg-unPB1pYEg6GyGrVzq3Of7SGGn6sh7xEqmTYuMe92mQ>
    <xmx:KT-9ZxWDhxnUxIMpTwV0nYtg0i3F3ZqP25TcPYiDSvNGsJSi19tDwQ>
    <xmx:KT-9Z816hLQ4AG1L9HUkSxMIRwkY7kchDF7phn27_854sN6-euu4s6uf>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:20 -0500 (EST)
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
Subject: [PATCH rcu 01/11] rcu: fix header guard for rcu_all_qs()
Date: Mon, 24 Feb 2025 19:55:06 -0800
Message-Id: <20250225035516.26443-2-boqun.feng@gmail.com>
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

From: Ankur Arora <ankur.a.arora@oracle.com>

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
CONFIG_PREEMPT_RCU=y.

Decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 27d86d912781..aad586f15ed0 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -103,7 +103,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.39.5 (Apple Git-154)


