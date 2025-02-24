Return-Path: <linux-kselftest+bounces-27316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33214A4138D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A103AA4CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7787242926;
	Mon, 24 Feb 2025 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTIdZnLC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06F241C87;
	Mon, 24 Feb 2025 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363769; cv=none; b=i9D3NoZk1FrM7o/PtsdPN9RuN+k6PYGYiM2X3gcxe5uqs8KWu6m0D/6RZ68PmcDZIITdz9gFl0TwkIgtb7DwCuV4ccFNaj0vnxbtbXeGLYiTt5bm5Wtpi78EYIlUOoBvbhamUCecT/E5rb8aeOaBcPL9YHO+6CRJa+qFoNg9FnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363769; c=relaxed/simple;
	bh=Z7wcVTQ2PMbca+VamTK60Bfots1ruiWDLXTJSx+zoDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DRTRyZMb1krESw/GuSAbqsndk2fl0cAlweIjuj9p6XKtHVPoKgWHb1XGMzUR3Kf8p+jAWpnNTsG64IbEDSIUtEMbTwOSGAe9YKES9jXdBbM6bPy/tW7LMwRJaWDKliYmcvYJief5dBti/G/Wz/cBiYAZmOGfr+Jpc+wci64me1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTIdZnLC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47210ab1283so57654981cf.1;
        Sun, 23 Feb 2025 18:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363767; x=1740968567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Meuv+MydLFL2FaXVwlNSjl8ifFrRUaf5oa8eloYWNAY=;
        b=UTIdZnLC/We+kcPwiP+quF3DmhU7+nqO6mZukeiFLr/z0iFRtVbn8yd1MHijbCSxcj
         EDxrxCfWN8rNocFsx4xt06RT+34A1t0EeoA+PDp4tPiN1hBK1P86ZNUK9Tclu3W9pAQZ
         1nIyzFNG2Y3V6fBmMedi8pvBcPCqNAnRBQl2Eobnt6nMul63IaydXeI4gV2r8ViCE1RO
         1AIjLR8MUBLDS2AXE+jvS2lWqGxA8/i68rF5QdZiTAbtYjs0ZEF70yBGAuawzuxQbYgA
         jiY8mOfxJhujYHpoa2fNetkSeirlMuY/1bgHg7CmZ6XWmFw5i0CdusBg3m1l/CiLh15X
         iudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363767; x=1740968567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Meuv+MydLFL2FaXVwlNSjl8ifFrRUaf5oa8eloYWNAY=;
        b=BoemCvro8iGuVbkte5zGSW4mLaTpJJvqZBXQUaWDOQEd3uTe5NYbfkVLYcBekVdofz
         ovtbhSSbP+VQH3FPMHwRi56onZIsNWajGqMRhp+8LR+37/LeTduDo0ZopZsbNQ5NGC8c
         PgV0PefAd1zegVR8DWFVg/QrX2F1dxqz5eH10JAFm08c2e1b7Ia0hr00Eg9e2leuSUCe
         noP5DZxkIN+MvO8rVniHHo6tVtBFA00jRyWsOOPPs2HoUDEwppD5DxyY2grL4pmJN2XH
         tKrfOY4AaI5CPbtkFh+cDWkoBh4rxQjM2cV65otETw3V9LIu467mWJSlVBl3XcBaUISW
         SEPg==
X-Forwarded-Encrypted: i=1; AJvYcCU9nohnHBZH8xsO5AyH6umHDefn6FRH0Eo17QAs6M1kq7QaieJBfKXMYWLYBbQEj2K9fUg=@vger.kernel.org, AJvYcCUGywl/xdpWZmvl/G32A7kNc6iqpAjGNHc5lrK1KA2yHVulytKP3QcYqV+gkeZ1No8A9IbCYq5IdTSDG45yng2p@vger.kernel.org, AJvYcCXsnEDSpVA6W0NBvNxITCtIeMuiIY1HRsy0fKvtXpdJDCY06GvsHpfFERuyAbNEkgofRDMpDOAjPCI+Vfmm@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrfqKPNF95weA39UXJlbmZ3qYLkZfAJ5CoprvPhkcgTIzSDdm
	QuNn05tdGf5w+70kXSVGe37GDT5LTqfL1SvNwco4VlzupcuYJmCU
X-Gm-Gg: ASbGnctVTHvrE2GE706rYrp+LlRPNE0GFG3fN7g45tytpv0cUvpFLHQy4a+hY6/AOsp
	cYejlhe8//T31lNDC0Qb3BMWDOn8eFigXJSN69fHOUCYLzyVJ8rxD7Y0REPAdZdd3hIFfrd0E7I
	hS+VSLWnfvG0gZ5LouRbWSOmZf0PHU1nzACgBe66IBlBe8GYLiKOeFFc4BZp6Mj2diRtBgqN66n
	tmSElMaZrFceAOghW1afa1YHTucr9o7yq1+Ti9QbGVLlpzGOSMD4RpGIobhqEBBk8QBkU71mon1
	eH6QjAB4SnrXT/JAUZXJRiyVPaabJGP9YR+wWTFZGZfBfPo5TtSed7fBxdbgBA14JfkiomSrKPY
	rLPkGSSDOScL5beOm
X-Google-Smtp-Source: AGHT+IFiS5JCKSf9kpXYqQvd4C20SO9WeFyiqD0ODJRSs4FwlxUKUEaIQb+jwmPk1FCG3Lz3izvoTA==
X-Received: by 2002:ac8:5804:0:b0:472:9ea:887b with SMTP id d75a77b69052e-472228b3738mr106238181cf.10.1740363766868;
        Sun, 23 Feb 2025 18:22:46 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720b1fe010sm59942551cf.60.2025.02.23.18.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:46 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id F0E6C1200043;
	Sun, 23 Feb 2025 21:22:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 23 Feb 2025 21:22:45 -0500
X-ME-Sender: <xms:9de7Z12BqK5IrljMNDM7sTYH_Ov-Mww0KRbBZNpXNcXYe2sixSc4Nw>
    <xme:9de7Z8G-qvGv8OFLGT1xSM_yo7VoNRI1lqWthXCu_elKjrvM1MbdgwWV1ZT8FwcsE
    INA5mhUMhtxRgjJOg>
X-ME-Received: <xmr:9de7Z172YHx5a9dFi1P9kIMyg__JoT0EW5US61bLg9k1E5zNbifIeKdVBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomhdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhshh
    esjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtoheprhhoshhtvgguthesghho
    ohgumhhishdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:9de7Zy3GLPromVxSeDY5Lh-a-P5jsYXhNoBFXNXnDIbnrGbNmfVwXg>
    <xmx:9de7Z4GT3LJg4lyWowvF-2v_j7BTp-GaC7geaE9dQ1arq78N8ydZjQ>
    <xmx:9de7Zz9QQ6750j2DHLsB5q1NhQ-4fj0Hxy0xfRdNsj6TTPfL0MgGSQ>
    <xmx:9de7Z1lWc7tQ8cSD1v95A1jLM6Zez9iuQQagy29AJK-rVZWDNZoLxw>
    <xmx:9de7Z8GGbECcBovdM_fDdAnqeRoHdZ0NVNRe8QhUbsOaN6eKlN-UFM-t>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:45 -0500 (EST)
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
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH rcu 20/20] srcu: Make SRCU-fast also be NMI-safe
Date: Sun, 23 Feb 2025 18:22:14 -0800
Message-Id: <20250224022214.12037-21-boqun.feng@gmail.com>
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

BPF uses rcu_read_lock_trace() in NMI context, so srcu_read_lock_fast()
must be NMI-safe if it is to have any chance of addressing RCU Tasks
Trace use cases.  This commit therefore causes srcu_read_lock_fast()
and srcu_read_unlock_fast() to use atomic_long_inc() instead of
this_cpu_inc() on architectures that support NMIs but do not have
NMI-safe implementations of this_cpu_inc().  Note that both x86 and
arm64 have NMI-safe implementations of this_cpu_inc(), and thus do not
pay the performance penalty inherent in atomic_inc_long().

It is tempting to use this trick to fold srcu_read_lock_nmisafe()
into srcu_read_lock(), but this would need careful thought, review,
and performance analysis.  Though those smp_mb() calls might well make
performance a non-issue.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcutree.h | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index bdc467efce3a..8bed7e6cc4c1 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -231,17 +231,24 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
  * srcu_struct.  Returns a pointer that must be passed to the matching
  * srcu_read_unlock_fast().
  *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
+ * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
+ * critical sections either because they disables interrupts, because they
+ * are a single instruction, or because they are a read-modify-write atomic
+ * operation, depending on the whims of the architecture.
+ *
+ * This means that __srcu_read_lock_fast() is not all that fast
+ * on architectures that support NMIs but do not supply NMI-safe
+ * implementations of this_cpu_inc().
  */
 static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
 {
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
-	this_cpu_inc(scp->srcu_locks.counter); /* Y */
+	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
+		this_cpu_inc(scp->srcu_locks.counter); /* Y */
+	else
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  /* Z */
 	barrier(); /* Avoid leaking the critical section. */
 	return scp;
 }
@@ -252,15 +259,22 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
  * different CPU than that which was incremented by the corresponding
  * srcu_read_lock_fast(), but it must be within the same task.
  *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
+ * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
+ * critical sections either because they disables interrupts, because they
+ * are a single instruction, or because they are a read-modify-write atomic
+ * operation, depending on the whims of the architecture.
+ *
+ * This means that __srcu_read_unlock_fast() is not all that fast
+ * on architectures that support NMIs but do not supply NMI-safe
+ * implementations of this_cpu_inc().
  */
 static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 {
 	barrier();  /* Avoid leaking the critical section. */
-	this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
+	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
+		this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
+	else
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  /* Z */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
-- 
2.39.5 (Apple Git-154)


