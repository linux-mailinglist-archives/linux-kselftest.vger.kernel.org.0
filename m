Return-Path: <linux-kselftest+bounces-27306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8BFA4136C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B98174501
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662831F418A;
	Mon, 24 Feb 2025 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4/Go+t2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999751A2390;
	Mon, 24 Feb 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363756; cv=none; b=K9/OVLAJo/9B2W1AzhCxS0CSJ9q+AboECmbBSqk0MW6Xvj8SBcEdnZfsuEFVWQ7WyAxNpheTNPwztuZ0DhV504QT97LYAN2VCI3tGPaJSgZpj1kLU4rkKWpcMkTEDSmAsHSjV2fB7Z+dMU8kHvj+6s4vOsrr03EWHoUOeRTK/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363756; c=relaxed/simple;
	bh=TgHuhjSSnyReNfhJRKsOVKxVBGTwz2BqA8pdzW/huhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VzZaWczv32ozCbk7ieSP66y2T0ao60QJxeLs+d8oCVWvFNW0Wver755zP4FPbL6g0e9a+UU/t0WQ+xGGDdzoUY+vCc3LT3lb2wcreimUOYNUD/jlo6j7SRYWrynW9YTTjDyDtkZGLM+ag+HIntQrpOqt4N+NL2najYLf2mteXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4/Go+t2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471fe5e0a80so34221141cf.1;
        Sun, 23 Feb 2025 18:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363753; x=1740968553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YGLAsuKK/f3ek23KfjWTWNPSOmHZjb22aDmgZC2NlGs=;
        b=M4/Go+t2K82cr8/gqI6/u/FWnhuuxGwEaAKiFEeiX+cJHiHUdeKZbK2S2HLg2IT2q1
         plsfqURXB9wAX9hzohIc1PzYWEST579uWwHa6Et14zVV/BKnet/MHtPU20YndoTUBN22
         Ecapjr636Z9LIAddpV14FfJCktlI8VdIWHJW/bJMNhlCpYgCoX+RIHkSfwA/82aFOudB
         x1Z47+7vPbQBIl5Y1JdU9wis0kEfDNRaBzbJVIS+6e2RBBUbiIPic/73L/eKvLQf5t0o
         UPkBLARvgNPTycuQMHon27puRKcAzIIjL1iRlTvaWVhdwNp6VaUQCsWX4JacDBfNt9Vz
         +piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363753; x=1740968553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGLAsuKK/f3ek23KfjWTWNPSOmHZjb22aDmgZC2NlGs=;
        b=J4o1tRCM51P0eLpzT+Cw6ko0BvWGq/gpDEQK6+dJ8LnpBE4oJjTNZhiEcMDrtOHhnR
         vAqAp+M8UC8o7p10V3tpBxwqTeF+7BEzNxAGq6Vo6G7Y1zG1EWQDxdmwAcIq91LCtCSL
         0Fyb+L2q7q7DORas2AZ3S5nIFlCyBPKkFRgt36uqsplcDNS7LMIu6NASW4TNxMIOp096
         Hh4iHHU/PZsPMSqxjVMMWwU1jDVKh3HfjjrKK5jkimBCaE+zJyEs3x7uO/6+ffpbqTSV
         XrAsydcyl6/e+WtVaVDWzd0lVBj+DdHnGs1yTd97aBO5eRpMsaTh/FnhlWBrlU4QPadd
         BJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCWHnPXicsQ2xC5Fq0wAeEgikdXPb9hyBd+a3AgiUTApG5zmav4QrG+eDJhejwM71NCdeEk=@vger.kernel.org, AJvYcCXHyUkJrUeffTncDx2lY1SQY1dztyS90FwpPRxKFi1+ZqfX0UEqEsAduRmOQnk1CGoMz9x0AqAG2cXcL6re@vger.kernel.org, AJvYcCXgMsN5RxWUDWsrZSJfEkmzqdF9Te9W8MO8tWn2tmkvog6kIONEiFXcUeKhB38n/rj0ZnKn5endN4nDuWCnPzra@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1X5RiN/u8eFobXJDYME39RO6ULqjawtqfB1kVL6Gxzl+LTKFg
	Uy3o0N2O9CX1qPAOjJi5ORyXGa/i3TR8vH7Dj/9w4p2v9Xo4YjOe
X-Gm-Gg: ASbGncuYQx4qUn980X2tapHbjBlFaVJVHfVEwfviHJpw+1k2w+AwdNF2jUET5OBMHAk
	2UDyQM5ktT/NmTKH9wyDNzSHPYbGf3NRPdHOJAMkPdLC3e5qQmKF7DGFc5J8j9XQFs73WwH/kUg
	yz8sTR9chhvPuI/u9ep4CBq+sqX7VfaVViZEGjBu40V3iLS219MimjrskjnKExYOf2fRpwCuea2
	lr6M3fkhhntRK7dERfBta6icGQ/mhdGDvKUPfQlhdrW8qU7zwbpOzqrdVOZoJf3/YNnSCNIiv4l
	97vHnFoFVpF0RIW+WruGw1lII806VeQn2Cyn200sZR1bOKDlB1FdfBcNxDcAL03V1VVrUAHeT+J
	6FdAK7fXYjAOE/qDK
X-Google-Smtp-Source: AGHT+IGUSog6nwxcNA18fQoC5dGEQkV9c1YwPYJYckbB/HQopiZwY63sHGbjZDO/LBtKd+Y4ciduqg==
X-Received: by 2002:a05:622a:10c:b0:472:3e4:53fe with SMTP id d75a77b69052e-47224611fb7mr150683901cf.0.1740363753370;
        Sun, 23 Feb 2025 18:22:33 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47209a1b133sm62076051cf.70.2025.02.23.18.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:33 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 78D701200043;
	Sun, 23 Feb 2025 21:22:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 23 Feb 2025 21:22:32 -0500
X-ME-Sender: <xms:6Ne7Z0RrD_MHp-D20ziblE7OmQ-zz1tY4rh8DXo6fb1UWn_UzgtOzw>
    <xme:6Ne7ZxzglXpM2-j01pNSpYDx69I4ubWXQEYywyP14_LMEtpYdEfa9z-PLHklo_uoO
    4jIXG6LBBbHvnVDAw>
X-ME-Received: <xmr:6Ne7Zx3sWbLJ-xZd-HUTd175ZSDLyA7gKVTkauQY873mPZlig70v_4S7bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomhdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhshh
    esjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtoheprhhoshhtvgguthesghho
    ohgumhhishdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:6Ne7Z4ACC9DS1PORqxlsNoqLXSurO0CFrhJpwQ0jNJdurkCRXHjtqA>
    <xmx:6Ne7Z9jUMgORbG6KPgzl3nST3I-p6-TcKGkI_KIMj9a2En1KYjXW7Q>
    <xmx:6Ne7Z0pM5Q8Wt--GE9_-abfVKUnyj0KPQePQqy96QZf2q0hmBVafzQ>
    <xmx:6Ne7ZwiJAbrX3QspDa0JiSsFeyFtFNOsZrsVw5ctWzlJ5_3CSkdmPw>
    <xmx:6Ne7Z0RV1d9KujVAaU3v4znOHtgrqKtKHb-Kg9CXpV-XqU9gdpaTn3Iw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:31 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH rcu 10/20] srcu: Pull pointer-to-integer conversion into __srcu_ptr_to_ctr()
Date: Sun, 23 Feb 2025 18:22:04 -0800
Message-Id: <20250224022214.12037-11-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250224022214.12037-1-boqun.feng@gmail.com>
References: <20250224022214.12037-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit abstracts the srcu_read_lock*() pointer-to-integer conversion
into a new __srcu_ptr_to_ctr().  This will be used in rcutorture for
testing an srcu_read_lock_fast() that returns a pointer rather than
an integer.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcutree.h | 9 ++++++++-
 kernel/rcu/srcutree.c    | 4 ++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index e29cc57eac81..f41bb3a55a04 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -211,6 +211,13 @@ void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
 
+// Converts a per-CPU pointer to an ->srcu_ctrs[] array element to that
+// element's index.
+static inline bool __srcu_ptr_to_ctr(struct srcu_struct *ssp, struct srcu_ctr __percpu *scpp)
+{
+	return scpp - &ssp->sda->srcu_ctrs[0];
+}
+
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.  Returns an index that must be passed to the matching
@@ -228,7 +235,7 @@ static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
 	this_cpu_inc(scp->srcu_locks.counter); /* Y */
 	barrier(); /* Avoid leaking the critical section. */
-	return scp - &ssp->sda->srcu_ctrs[0];
+	return __srcu_ptr_to_ctr(ssp, scp);
 }
 
 /*
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 8b5c50bc98e5..a91651866485 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -753,7 +753,7 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 
 	this_cpu_inc(scp->srcu_locks.counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
-	return scp - &ssp->sda->srcu_ctrs[0];
+	return __srcu_ptr_to_ctr(ssp, scp);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
 
@@ -783,7 +783,7 @@ int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
 
 	atomic_long_inc(&scp->srcu_locks);
 	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
-	return scpp - &ssp->sda->srcu_ctrs[0];
+	return __srcu_ptr_to_ctr(ssp, scpp);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
 
-- 
2.39.5 (Apple Git-154)


