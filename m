Return-Path: <linux-kselftest+bounces-27309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74EFA41378
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D963A6675
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938D7204687;
	Mon, 24 Feb 2025 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoTSSQUT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC811FDA79;
	Mon, 24 Feb 2025 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363760; cv=none; b=LKrsnwzC6dNbvbYnyVTr5ncDgHRkvFU4u+pj7RlcX32NzWvLo7i+1p2t/gTF4BW476x0J5y6leBtt4T4AjoDD+0XbrBQWG68Qx5wX+agIcIUWbEdkHkGzHeHGUipwhEG7yMEdnGJdJICP7evEFuGK+DNOdcqOhZ27HwZLGiMju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363760; c=relaxed/simple;
	bh=eWuqWsxlsJdHvX9J4PpjZoW4YF4OyOGuqZuyk6j8YHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QyxtL0p60C82IS/TocS6XM2lE9V9QcRJztmzD6ZpZcvkRkWLNYEcgTybpOBaPZwOwfRPYqd14m5cPPmak53daLuu0SlMhN0w7OUoIjS0hoEkgR5rZ4Eyhlxb7r2HsscYTrlYe0CdiWqBDV3N0PKsc5Fmf7u9imOt7bayEAbPXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoTSSQUT; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c2303a56d6so43915285a.3;
        Sun, 23 Feb 2025 18:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363757; x=1740968557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cs7/tYIYyEnsMEUFXtBt9RoaeQsr5/p8PlPMftFjBMc=;
        b=AoTSSQUTE0406cBg2euHav0H58Vo+pU5Axd2/OTKDYBy+LOCuNRmhD0Muv5DnWrzfw
         V7lh046ELyQr5BLELmMyHVbSuzyGJ0/lHznGLevkWoFt7XAEq5nn0oZW0FHRrkIfhKtA
         ArTM83Dc+hKR9fZFHlQzhsjlXHjkSbrES6KLhZueRcJM8itli8mQ6LR6ddkC87rfDl85
         PIrggkcsQjIkcqRxkWITbIIxGDJ6WLssYE8aGntFkHzK/acrfAEzu9HxWL09OBcTpzDO
         LEOGbc1VbO0n39pkcgOAmypAvmOgNEroCyc/iZNgXtCL8FMfB88DKoDt02GG49oulg5O
         hjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363757; x=1740968557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cs7/tYIYyEnsMEUFXtBt9RoaeQsr5/p8PlPMftFjBMc=;
        b=aW9vfaVfcePk6W/FDdmGxcLMo5RIyjeBEpJSo9Xw25vwRVvYd7hUtzbTWC0+H2bdgM
         sbwu2aZiA6Q6HP5c+QOIaw6EVfXnEkij8thb6kGPw3cGnOsHTRcVmImUIbaJMKM106C6
         hn/XEfJT2vbFeuF0Px3PeBhqntrp8rkCI5bWt9Ea5tRezrSIP9JNRUnAaiH1YMQoCMbv
         rhRdNZDOU3jkR1QPrDI5x3snYp2hhR3avSeas6BZQS0RTb1aXB1XEJ+dYpWT5RYRVNYU
         I0HbM1nNji08RC2RkdW73yPDLcHSfVJfHmfdRwYLhe5RKvB3yFhV1HrcuDVt2ceWjGuj
         e/yg==
X-Forwarded-Encrypted: i=1; AJvYcCVAsh9Yvx1g/6KYb0bTnStvtalzzB5gYqYi2Fy2JKn5Ruw3+JEBW0SMMeb9vT3/gMNUDds=@vger.kernel.org, AJvYcCVgDgjmrUHq0FMICyzEmQSK6PP8WAKSyJrSj5dcLmmrz197W52KXy1akFUOocFhLe+q2XEN2/JYmhUOE0/yBlVU@vger.kernel.org, AJvYcCVwudu1WyEmLXrC8AIk2K3E0/kZiKQl2nUc4wHo3YgGnxqwmcCqf4gqm4yOVQnduPnA5my5SSOCgVFw8D6+@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHVxPcAxbw2ChJzDOn9ZJWQYmSPjDx1cdjLgYJb0VVPWtodLd
	8KB0uVUhl4p0zEvj6qbptgXWco5ANSrwfnbp+M3o8apd+PbUmq2i
X-Gm-Gg: ASbGnct1HhAjblOj+2tKklcQQiuQfFa2gje3zZaEk9+u5vDTXqJLna9l2zmID7Gh1NN
	/bpAl1QMJrhhAIXdRmbL6V8MOBPlU6Bw0zsw8UOu4PCBexa94bn+kSfOzilV60BBKFMxFNUIHbn
	H6O8PMddt8ToAc+WBU3pJAt0eNiDpAqWqYBOrteGgbSIvKW1w+RAWXGEgy2qbr/bChXOasZVceQ
	Dfik2UD3bFluJvasDcQBmkiVSuacGIUVUS4xf7rxZ4EWZsGmqrcMLkWTfC7PlD/5YeYU8xAEoMX
	1mdWQsMBMPVCRHvpMgvAOybu7cTkZpjQVWrTPSpQ8afaTGmJlwA6M8f77/566O6OINz7i4CIV5j
	Z3ZuzJI89pUjhORmH
X-Google-Smtp-Source: AGHT+IEjwxU9YmoI3nKfcIVCjMPgByTWVYCjFgmn68xYM5Z/nUOsRS89BtQNBjkqirCkPx4hVFuwgA==
X-Received: by 2002:a05:6214:1c0f:b0:6d3:f6bd:ca04 with SMTP id 6a1803df08f44-6e6b01d79c6mr129720876d6.40.1740363757345;
        Sun, 23 Feb 2025 18:22:37 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785ce5sm127500186d6.41.2025.02.23.18.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:37 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 883821200043;
	Sun, 23 Feb 2025 21:22:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 23 Feb 2025 21:22:36 -0500
X-ME-Sender: <xms:7Ne7Z2TDJb1uLxpJaN-lTOYCpEstRl9sVaJkzpJ64suKEnVptoQ_iA>
    <xme:7Ne7Z7wlxpbmwQsbi4tAkUN6ayi1o7kg47PD1QMNG_nUlJvuQtRxyOIBkO_4AErql
    YtDSrSsX1Dlm7xuUg>
X-ME-Received: <xmr:7Ne7Zz1R9QCyVMDPGBrihM29S2Z3lRPOpn6SZoJGhsFtnzWGiWUPOQVFaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrg
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
X-ME-Proxy: <xmx:7Ne7ZyDRj95FyeEZt4RDU0mtth4b1l8dc6anDr_1EmJiVCPIruI-bg>
    <xmx:7Ne7Z_iO4r6yRLuFJ5gYKjvLP5MsR-KdvMRlLGd9GzOnoCwTr9Y2Nw>
    <xmx:7Ne7Z-pLcDAMtyDtMONrzujttqJ4vSC5JwuDHAxclYKXKYbiszbxDw>
    <xmx:7Ne7ZyggWt5EXDDUqDxFjUAVc90QX9qq3xm0_CkfRNVbBuWa0SSzgA>
    <xmx:7Ne7Z-Rt1AJQPdfFzz8orwHV3hSunddCqnjTd1eiUs4qVlp4PBB2BfWD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:36 -0500 (EST)
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
Subject: [PATCH rcu 13/20] srcu: Add SRCU-fast readers
Date: Sun, 23 Feb 2025 18:22:07 -0800
Message-Id: <20250224022214.12037-14-boqun.feng@gmail.com>
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

This commit adds srcu_read_{,un}lock_fast(), which is similar
to srcu_read_{,un}lock_lite(), but avoids the array-indexing and
pointer-following overhead.  On a microbenchmark featuring tight
loops around empty readers, this results in about a 20% speedup
compared to RCU Tasks Trace on my x86 laptop.

Please note that SRCU-fast has drawbacks compared to RCU Tasks
Trace, including:

o	Lack of CPU stall warnings.
o	SRCU-fast readers permitted only where rcu_is_watching().
o	A pointer-sized return value from srcu_read_lock_fast() must
	be passed to the corresponding srcu_read_unlock_fast().
o	In the absence of readers, a synchronize_srcu() having _fast()
	readers will incur the latency of at least two normal RCU grace
	periods.
o	RCU Tasks Trace priority boosting could be easily added.
	Boosting SRCU readers is more difficult.

SRCU-fast also has a drawback compared to SRCU-lite, namely that the
return value from srcu_read_lock_fast()-fast is a 64-bit pointer and
that from srcu_read_lock_lite() is only a 32-bit int.

[ paulmck: Apply feedback from Akira Yokosawa. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcu.h     | 47 ++++++++++++++++++++++++++++++++++++++--
 include/linux/srcutiny.h | 22 +++++++++++++++++++
 include/linux/srcutree.h | 38 ++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 2bd0e24e9b55..63bddc301423 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -47,9 +47,10 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
 #define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
 #define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
+#define SRCU_READ_FLAVOR_FAST	0x8		// srcu_read_lock_fast().
 #define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
-				SRCU_READ_FLAVOR_LITE) // All of the above.
-#define SRCU_READ_FLAVOR_SLOWGP	SRCU_READ_FLAVOR_LITE
+				SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_FAST) // All of the above.
+#define SRCU_READ_FLAVOR_SLOWGP	(SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_FAST)
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
@@ -253,6 +254,33 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 	return retval;
 }
 
+/**
+ * srcu_read_lock_fast - register a new reader for an SRCU-protected structure.
+ * @ssp: srcu_struct in which to register the new reader.
+ *
+ * Enter an SRCU read-side critical section, but for a light-weight
+ * smp_mb()-free reader.  See srcu_read_lock() for more information.
+ *
+ * If srcu_read_lock_fast() is ever used on an srcu_struct structure,
+ * then none of the other flavors may be used, whether before, during,
+ * or after.  Note that grace-period auto-expediting is disabled for _fast
+ * srcu_struct structures because auto-expedited grace periods invoke
+ * synchronize_rcu_expedited(), IPIs and all.
+ *
+ * Note that srcu_read_lock_fast() can be invoked only from those contexts
+ * where RCU is watching, that is, from contexts where it would be legal
+ * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
+ */
+static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *ssp) __acquires(ssp)
+{
+	struct srcu_ctr __percpu *retval;
+
+	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	retval = __srcu_read_lock_fast(ssp);
+	rcu_try_lock_acquire(&ssp->dep_map);
+	return retval;
+}
+
 /**
  * srcu_read_lock_lite - register a new reader for an SRCU-protected structure.
  * @ssp: srcu_struct in which to register the new reader.
@@ -356,6 +384,21 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	__srcu_read_unlock(ssp, idx);
 }
 
+/**
+ * srcu_read_unlock_fast - unregister a old reader from an SRCU-protected structure.
+ * @ssp: srcu_struct in which to unregister the old reader.
+ * @scp: return value from corresponding srcu_read_lock_fast().
+ *
+ * Exit a light-weight SRCU read-side critical section.
+ */
+static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+	__releases(ssp)
+{
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
+	srcu_lock_release(&ssp->dep_map);
+	__srcu_read_unlock_fast(ssp, scp);
+}
+
 /**
  * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index a6194f7a7e34..e271f9f96bfc 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -71,6 +71,28 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 	return idx;
 }
 
+struct srcu_ctr;
+
+static inline bool __srcu_ptr_to_ctr(struct srcu_struct *ssp, struct srcu_ctr __percpu *scpp)
+{
+	return (int)(intptr_t)(struct srcu_ctr __force __kernel *)scpp;
+}
+
+static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ssp, int idx)
+{
+	return (struct srcu_ctr __percpu *)(intptr_t)idx;
+}
+
+static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
+{
+	return __srcu_ctr_to_ptr(ssp, __srcu_read_lock(ssp));
+}
+
+static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+{
+	__srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
+}
+
 #define __srcu_read_lock_lite __srcu_read_lock
 #define __srcu_read_unlock_lite __srcu_read_unlock
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index ef3065c0cadc..bdc467efce3a 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -226,6 +226,44 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
 	return &ssp->sda->srcu_ctrs[idx];
 }
 
+/*
+ * Counts the new reader in the appropriate per-CPU element of the
+ * srcu_struct.  Returns a pointer that must be passed to the matching
+ * srcu_read_unlock_fast().
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
+{
+	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
+	this_cpu_inc(scp->srcu_locks.counter); /* Y */
+	barrier(); /* Avoid leaking the critical section. */
+	return scp;
+}
+
+/*
+ * Removes the count for the old reader from the appropriate
+ * per-CPU element of the srcu_struct.  Note that this may well be a
+ * different CPU than that which was incremented by the corresponding
+ * srcu_read_lock_fast(), but it must be within the same task.
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+{
+	barrier();  /* Avoid leaking the critical section. */
+	this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
+}
+
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.  Returns an index that must be passed to the matching
-- 
2.39.5 (Apple Git-154)


