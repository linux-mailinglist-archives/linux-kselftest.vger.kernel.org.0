Return-Path: <linux-kselftest+bounces-26990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E002A3C3D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113EC1677B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D7D1FE46C;
	Wed, 19 Feb 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5lpIgR1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E31FDE10;
	Wed, 19 Feb 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979591; cv=none; b=dsz4TwhNefze/LN5GVWKXEyZWx4vcqhc67cipKnJGqRb3+HmtrcawQd4CBrLCPlwDSOpM2QkUNQFlevfSU83sDDulQvUkrdscBRwuo2aUwc30tA3rkHj08Y9pV6zYssANvY2J2uX/73rdXzLo+jdmI8deG+2gdhCc1j8zzDR3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979591; c=relaxed/simple;
	bh=nz4/EkLWseE40NLXUhT4N656FcYiIt8edVQLtvFFTsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmb/HodYWwTrzEsfdVaO61i9xkofitowhp5yHrk5pvvtFDREWntYJZb1A4RqPojM+E+/sEUIDew1vqNKGa9tAcy2yuV4oOmNA9Trqg45h6CX/XNtUbd2wAROHr/OpS2HEvk4KoKXwPtRXpngkg0OwgEQUwG90fs6uy4A5m4BYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5lpIgR1; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0ba9825e9so43942185a.0;
        Wed, 19 Feb 2025 07:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979588; x=1740584388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2IGK/jN7/zS07b2i1C9QicOMxwRniAh4o+TnE4u4gaA=;
        b=h5lpIgR1MkFuwCbcvU2hyVxstnovNrTcmNEv4lVNP62a75Opbs4/BLGq0zFTRtXa3N
         5GrY/fLPAfNcwSvuZ9nDMwzDJmsY2ZMZIillmTjeXAx3o+yHncbQaaiiLhj6MFPUsFdE
         3orXNuM8mpTcgefhVJMXGB8M5E82U017+aZC1ULBsSg5kfDZ0lgRVrzoq3phLfv4teIV
         +ZN4Ta9dStaSVlARLfOiGIkrLQN/cFy4KuI9BEcdtkibhpzhf1DLBQtoPGzrnvlQZ/7J
         n1C0nSxV9ztsjpaDQH32KYEV8PN1wN1ZQ42OnSeRcDK64KjJ4I48TRwkDIDdoXLP4tZk
         eadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979588; x=1740584388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2IGK/jN7/zS07b2i1C9QicOMxwRniAh4o+TnE4u4gaA=;
        b=DInTV4sNO9SrgKS8HAz2dvT1nd8GfVICQ8Edq02iy2qZoZjcsHrShOgfLxBE9r/3m+
         K+pmnepOO4+KM/YXOSDGmM2iMj+HAthfFXhAZlxWNlsQ0iqaeZDSo/UzpTomVIqz2m+h
         dkD6R+clpHdUyK4PkTxzWKgASxZnOzgaM+5jBmxQXFO2EgI3WSorFiVtOeyIwzSO6s2n
         kav+k0veJhodaHe+JXm+G/aAuccY3LKY9HdHJo0Fj8Kh/UhMYvglru5WgL0S2VT0E9wY
         BQL1e8dCjia3zup5RMA1jwO1YMSTsZUd/TGxBr2uqeZJe5L5Z/FyoFU74t8f7syCR1bd
         PQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyYkiC/prAsnMnwfLmfIUjx5WoiUZ5qa1KXTnzR0cKHLpG7uLQO2kPS56XkszMnWOaerey3LvCS50=@vger.kernel.org, AJvYcCV4BS+Zy1wkW6VVMhzIpCMtxAuDDRMcUUzuXWhRQDEN6XNt1oKQOelDWvqrbFpGdingSoHEmkgdMiMTTB6uHxNd@vger.kernel.org, AJvYcCWWFqmNfyd2Br/tny3cbO9hVLKWV7IPlDq6jtg6Ujr4BAdVgoAFLkiYf14dWtj/5yelUPowKfGwU5k8YgqrawIPXLQn@vger.kernel.org, AJvYcCWqvtihdfBD9SzqJPnBo9KMTsKZxbrfaL+cNCEEW9ikQn4usQXwj8tirlFVk2TJQaoN6icrSmKJHa17FGb/@vger.kernel.org
X-Gm-Message-State: AOJu0YwL2EJQDumd1gyN6QahFJSwXQM/R+CZOR6dHbGeDMAFANYo5rgV
	RTQ+vC1On3d/zbnnGDFwPbOZaCfGGPT4life5pW/erfG1mV4axSK
X-Gm-Gg: ASbGncujYCR/b2BKvXEemQ4w39bXB+toaqXi+cXYW8S+z5Oga+UWI4ESMkpe+MRY7ar
	xHw0qjRma8gXT3zmeFjRsaJ4fXEAHRynulPEoT40zsl7NEQXJPV5Zpl8iu3XV1HSFAkNkgh+6eF
	3tqu4xDVU2od6UQuwox7s5oLnYqmw/Qd2qQQAJCw3m7a1xko9GelpMjSXtoypEkVYBpYur2U32s
	t7ObEzEwAUZMpqegDPx80bDu6R8UOul0h5X7xGPDRiWstWtn59dGXwdJ8QqHvP6SXlUZI+Wq7Zj
	3zpugSwEJVmrpRrN1CMCDsuqWfZ5BBO+C+F9dLrGKtIeL7PJDXiL840XvI65IWgjSLfhp+nmThc
	LU2ZpPg==
X-Google-Smtp-Source: AGHT+IGKh1Jas2dHp+Xdvfua6mg+rQcOKK6ebxY6bWc8rbExgK1hbPdbNn0PYQeaPxsXI5XgxzjUAA==
X-Received: by 2002:a05:620a:278c:b0:7c0:6af7:b71f with SMTP id af79cd13be357-7c0b5246a84mr584504385a.16.1739979587934;
        Wed, 19 Feb 2025 07:39:47 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0abf8a181sm231818585a.16.2025.02.19.07.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:39:47 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id D83801200043;
	Wed, 19 Feb 2025 10:39:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 10:39:46 -0500
X-ME-Sender: <xms:Qvu1Z1miWkt3Tvxb5yHBlzPRNfFnT-xeRuPmIUx90HjV_kHG49em_Q>
    <xme:Qvu1Zw0ydaN6VYavpWTALK9HJI1xeTao3umyYutfZmAkRlnvqb4rC6dWFOHgeSF63
    2OgDrlHco0P2e8y5Q>
X-ME-Received: <xmr:Qvu1Z7pVOkVaIZ2_nCyv88RTgkyYsFkfLtmeoXTOoFh7NIlos82x0heV6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehrohhs
    thgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegv
    fhhfihgtihhoshdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:Qvu1Z1kIN3u3fCVc0qcy0-vT7C3rLEGOyshfzAK-GdnP6b8JNYQZsQ>
    <xmx:Qvu1Zz1IPgT2pNg4ILqWp8xJRKEAUjNqmUiMMdUtg5ySdAvtNJSvtw>
    <xmx:Qvu1Z0ssjsK9N4Il2ldAg_ACBqbuYFqzgnBIvB3ZyVlmvGxryjFmHQ>
    <xmx:Qvu1Z3XPFeQ1pqkbxuaz-UaLczJeMpXTG1Rco_fwAxqR6gLZEmTGgQ>
    <xmx:Qvu1Z60_OXQj9FG7qcCZZvvoTUqy6m_AZemL31ph4UHPvd9ZQ-RpH0gb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:46 -0500 (EST)
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
	linux-kselftest@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 03/11] rcutorture: Include grace-period sequence numbers in failure/close-call
Date: Wed, 19 Feb 2025 07:39:30 -0800
Message-Id: <20250219153938.24966-4-boqun.feng@gmail.com>
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

This commit includes the grace-period sequence numbers at the beginning
and end of each segment in the "Failure/close-call rcutorture reader
segments" list.  These are in hexadecimal, and only the bottom byte.
Currently, only RCU is supported, with its three sequence numbers (normal,
expedited, and polled).

Note that if all the grace-period sequence numbers remain the same across
a given reader segment, only one copy of the number will be printed.
Of course, if there is a change, both sets of values will be printed.

Because the overhead of collecting this information can suppress
heisenbugs, this information is collected and printed only in kernels
built with CONFIG_RCU_TORTURE_TEST_LOG_GP=y.

[ paulmck: Apply Nathan Chancellor feedback for IS_ENABLED(). ]
[ paulmck: Apply feedback from kernel test robot. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/Kconfig.debug | 14 ++++++++++++++
 kernel/rcu/rcu.h         |  2 ++
 kernel/rcu/rcutorture.c  | 34 ++++++++++++++++++++++++++++++++++
 kernel/rcu/tiny.c        | 14 ++++++++++++++
 kernel/rcu/tree.c        | 20 ++++++++++++++++++++
 5 files changed, 84 insertions(+)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 6af90510a1ca..25a9dc2be0dc 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -84,6 +84,20 @@ config RCU_TORTURE_TEST_LOG_CPU
 	  Say Y here if you want CPU IDs logged.
 	  Say N if you are unsure.
 
+config RCU_TORTURE_TEST_LOG_GP
+	bool "Log grace-period numbers for rcutorture failures"
+	depends on RCU_TORTURE_TEST
+	default n
+	help
+	  This option causes rcutorture to decorate each entry of its
+	  log of failure/close-call rcutorture reader segments with the
+	  corresponding grace-period sequence numbers.	This information
+	  can be useful, but it does incur additional overhead, overhead
+	  that can make both failures and close calls less probable.
+
+	  Say Y here if you want grace-period sequence numbers logged.
+	  Say N if you are unsure.
+
 config RCU_REF_SCALE_TEST
 	tristate "Scalability tests for read-side synchronization (RCU and others)"
 	depends on DEBUG_KERNEL
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index feb3ac1dc5d5..a6098997a14b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -590,6 +590,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
 #endif
+unsigned long rcutorture_gather_gp_seqs(void);
+void rcutorture_format_gp_seqs(unsigned long seqs, char *cp);
 
 #ifdef CONFIG_TINY_SRCU
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index fbf1d7fcf61d..2113583cae34 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -273,6 +273,8 @@ struct rt_read_seg {
 	bool rt_preempted;
 	int rt_cpu;
 	int rt_end_cpu;
+	unsigned long rt_gp_seq;
+	unsigned long rt_gp_seq_end;
 };
 static int err_segs_recorded;
 static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
@@ -407,6 +409,8 @@ struct rcu_torture_ops {
 	void (*gp_slow_register)(atomic_t *rgssp);
 	void (*gp_slow_unregister)(atomic_t *rgssp);
 	bool (*reader_blocked)(void);
+	unsigned long (*gather_gp_seqs)(void);
+	void (*format_gp_seqs)(unsigned long seqs, char *cp);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -611,6 +615,8 @@ static struct rcu_torture_ops rcu_ops = {
 	.reader_blocked		= IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)
 				  ? has_rcu_reader_blocked
 				  : NULL,
+	.gather_gp_seqs		= rcutorture_gather_gp_seqs,
+	.format_gp_seqs		= rcutorture_format_gp_seqs,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -656,6 +662,8 @@ static struct rcu_torture_ops rcu_busted_ops = {
 	.sync		= synchronize_rcu_busted,
 	.exp_sync	= synchronize_rcu_busted,
 	.call		= call_rcu_busted,
+	.gather_gp_seqs	= rcutorture_gather_gp_seqs,
+	.format_gp_seqs	= rcutorture_format_gp_seqs,
 	.irq_capable	= 1,
 	.extendables	= RCUTORTURE_MAX_EXTEND,
 	.name		= "busted"
@@ -1978,6 +1986,12 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 				rtrsp[-1].rt_preempted = cur_ops->reader_blocked();
 		}
 	}
+	// Sample grace-period sequence number, as good a place as any.
+	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) && cur_ops->gather_gp_seqs) {
+		rtrsp->rt_gp_seq = cur_ops->gather_gp_seqs();
+		if (!first)
+			rtrsp[-1].rt_gp_seq_end = rtrsp->rt_gp_seq;
+	}
 
 	/*
 	 * Next, remove old protection, in decreasing order of strength
@@ -3566,6 +3580,7 @@ rcu_torture_cleanup(void)
 	int flags = 0;
 	unsigned long gp_seq = 0;
 	int i;
+	int j;
 
 	if (torture_cleanup_begin()) {
 		if (cur_ops->cb_barrier != NULL) {
@@ -3661,6 +3676,25 @@ rcu_torture_cleanup(void)
 				else
 					pr_cont(" ...");
 			}
+			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) &&
+			    cur_ops->gather_gp_seqs && cur_ops->format_gp_seqs) {
+				char buf1[16+1];
+				char buf2[16+1];
+				char sepchar = '-';
+
+				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq, buf1);
+				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq_end, buf2);
+				if (err_segs[i].rt_gp_seq == err_segs[i].rt_gp_seq_end) {
+					if (buf2[0]) {
+						for (j = 0; buf2[j]; j++)
+							buf2[j] = '.';
+						if (j)
+							buf2[j - 1] = ' ';
+					}
+					sepchar = ' ';
+				}
+				pr_cont(" %s%c%s", buf1, sepchar, buf2);
+			}
 			if (err_segs[i].rt_delay_ms != 0) {
 				pr_cont(" %s%ldms", firsttime ? "" : "+",
 					err_segs[i].rt_delay_ms);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 4b3f31911465..f9c4a24dc59c 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -257,6 +257,20 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 #endif
 
+#if IS_ENABLED(CONFIG_RCU_TORTURE_TEST)
+unsigned long rcutorture_gather_gp_seqs(void)
+{
+	return READ_ONCE(rcu_ctrlblk.gp_seq) & 0xff;
+}
+EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
+
+void rcutorture_format_gp_seqs(unsigned long seqs, char *cp)
+{
+	snprintf(cp, 8, "g%02lx", seqs & 0xff);
+}
+EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
+#endif
+
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 475f31deed14..e40c4b5c3267 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -538,6 +538,26 @@ void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 }
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
+/* Gather grace-period sequence numbers for rcutorture diagnostics. */
+unsigned long rcutorture_gather_gp_seqs(void)
+{
+	return ((READ_ONCE(rcu_state.gp_seq) & 0xff) << 16) |
+	       ((READ_ONCE(rcu_state.expedited_sequence) & 0xff) << 8) |
+	       (READ_ONCE(rcu_state.gp_seq_polled) & 0xff);
+}
+EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
+
+/* Format grace-period sequence numbers for rcutorture diagnostics. */
+void rcutorture_format_gp_seqs(unsigned long seqs, char *cp)
+{
+	unsigned int egp = (seqs >> 8) & 0xff;
+	unsigned int ggp = (seqs >> 16) & 0xff;
+	unsigned int pgp = seqs & 0xff;
+
+	snprintf(cp, 16, "g%02x:e%02x:p%02x", ggp, egp, pgp);
+}
+EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
+
 #if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK))
 /*
  * An empty function that will trigger a reschedule on
-- 
2.39.5 (Apple Git-154)


