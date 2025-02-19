Return-Path: <linux-kselftest+bounces-26991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C2A3C3DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261383A7D3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA81FECC1;
	Wed, 19 Feb 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCVUxx4L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF71FE460;
	Wed, 19 Feb 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979592; cv=none; b=ayQDstBjWQIl46H/fK+P5lO33IuKEB3zznSc0EK1iEJQJN4QgDYecOkeqMGa8+YoMEYW8j3RA7FgpaHbPh8yRhvBpyzLz7JE8rYhuawn8XXOKzGNN8xw6QnNtqURdupz6pbFqURqgJgWHZgdsmxcZDFU5CDjW+u9fHqP5qVhrrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979592; c=relaxed/simple;
	bh=E4DOK7CZSE+8C5BIDnNVpQpjchBMdv+a0J1vSOpXW4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEhrCTED8wyQPkGmXAHD8wHeCpcNZcgGYxSO3ecab3AN0zDbk4w1Aq0FqV1v4jnxiIRsPnh6f78q/C1bEPsyn81Gjpe/e+0eKusRL20HelbkhfGSuNuJnOE2J0ZQKawJr9bzOw7q3QMJt9fBEut59iiDJ9fnTlXbUYif4t4cU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCVUxx4L; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46c8474d8daso54974791cf.3;
        Wed, 19 Feb 2025 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979590; x=1740584390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9wKCsh3WlUhdoC06/NmntTkWBtKoL75s1nVYFuFmkfY=;
        b=FCVUxx4LY+erSNHJN4uokiL69qVNzdt7wO86eJmCgW4Rb6/4ucPJ3Br1QzH/48UccZ
         p+MKqPa964j0i2teTnVMfMCeTI5XPvOIl3ldFuKTcIEj7LaMUBWyy9FSVdACXczrwYPz
         LCdui3qq9EjAcAl/ZxxzJ6WlTyWTbkc0VD0D3FE/1chjvOUV8+qDm18ZcjoSPDKrnRWH
         7J4CRYzI2wqLpolh+L/CR3Pb7u8hnMXPL36YfWrOjoAqcTs+Yq9QWoMQWBpscSN8DziN
         hqDdlinPXoHk16tYqlBAV66VzZX1p5Xfsxi9EgxyPCpN94/R8XvcyoYVBGO8LOV2+5/Y
         l5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979590; x=1740584390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wKCsh3WlUhdoC06/NmntTkWBtKoL75s1nVYFuFmkfY=;
        b=QYVd33jYZmQuAG3D7FJOCjoMRdlCQSYJPYWz+Xlt8so9tTNRJmYnUo7D/+G2u+aBJc
         NbZVK38sVN3hVdpIdBurDByH8SusaGLexeyvHy0Ay+Hk1s8U6gM8Pa/puLiNMAsAKsv0
         Xx6nhzyY4XTp0nDGq+cG+eG/ggt6Nbkw815TI+Jm5y5JXcFqXYJaRXtPHBeXtU8mtW4l
         oC02rQaWKJVDhn7qagvUSmmaABzYVLhf97PLOCVaHVm670Iuu4KLuw6rrr+pTMcRv86a
         bNOXeuRS8my0pp37W4AY6/ZBbS9GXLBYRry8Qosvtux3fWiTzy6W++7JdcNw/7taBFsI
         L3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUsTjuicTP9xqWa7WQxQY47e1HO8eEFeBmpkzy/8jX9qip8BBoUXJoi/Kvy0v3JoHUsmvyARAgbVhgOTBt/cuG33ox7@vger.kernel.org, AJvYcCUtdXKAyUEvXKF1+aGf83fJ6dI0rR5q0Y14Ptl4eM9d8lcO27OSEqjbc/H+3iE0dkknKw1uLr3yAxZletaK@vger.kernel.org, AJvYcCWHQfgtRPLmHqwRXp4rcmShqhro++mWyQexsmixppL6xvQfxPIovdtwiNCNeNB/znOCuC7kdnGiIa8=@vger.kernel.org, AJvYcCWZh1vhS80O94VC4eUz7jSVg9Zp/cNVZGvwkT9D/CuO+m49o+TvOt5swoLfYe7iIxIghFKo2cs48nZEvQ4qnQN7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0AesedRdg9gZVpnlIQ4bG6aPp6skdeyMOePIRrnzAOxT8Nv1D
	aLBy/lGFs1gWnn+txocfkyWjU5kE/qPeI9cESOEBXHoDWYffGWP9
X-Gm-Gg: ASbGncunh0aiQxF2Ptkp/j8VDx5FwJKC3uuvnUBi+N8lcH5Wh0RVtLiacaECop/W9Ha
	8SNQoeMidX6uELK3/bi9sQWCJj35Rv9g1QakxgZTGVzFAHiC1gicSKOJetGClOQ9v/IR8KuTsJe
	O3qwCenPXHKjpsDjhxUAXP8RTh0j41E6Ox3iWr172zNdETrGBME2eM+HFf8mUcezWyuOr+OoaGo
	YliD1vwVw46an4IYYfmMxF634w74+8b8O7JLEo+JFrzXZqBcOXF26JGCUdYpsxtFI632SyIvlua
	mWClbJncBGL0+OQVpq3cjbealv0bA+IyjmPdgFtPyXes2MxOHFZzkHTBPGUgpbk1V1ibdd7Pc6G
	fPxT1tw==
X-Google-Smtp-Source: AGHT+IEDOaP4WvAaavXVvi07vocNXXdapgSvYoTu3BImtbcRfGx9IrOx5iLACAan2j2jHLOzhT0yuQ==
X-Received: by 2002:a05:622a:11d6:b0:471:ff97:4883 with SMTP id d75a77b69052e-471ff974aaemr92692151cf.29.1739979589670;
        Wed, 19 Feb 2025 07:39:49 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471ead6bdeesm38050731cf.32.2025.02.19.07.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:39:49 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8B3881200043;
	Wed, 19 Feb 2025 10:39:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 10:39:48 -0500
X-ME-Sender: <xms:RPu1ZxCm7h40lPjMZvJi4NsATpj_D0yr9LsOfWVbAOo4Ewfz0rAeIw>
    <xme:RPu1Z_gwhdMe6VxCVA7o5aeK4RJ32FtrypZF_Mlh0k47S7kcaSHAcLnzNudlGNP2c
    tcXoOrzcRPMhCrQ5w>
X-ME-Received: <xmr:RPu1Z8kBteX8NRz1aG0ExBuO_XYvXulCRKJ0nj6qJ6f2yJQbntk79cC6tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehrohhs
    thgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegv
    fhhfihgtihhoshdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:RPu1Z7zE26VUSWI5lwkpEyYZEDn2jh8KQAJjdI7D3L_KrTio2O6h2g>
    <xmx:RPu1Z2Rw57Jkji_xn0B3V-PjviIDt8dABeqNuibghwpcm0bWaDaLOg>
    <xmx:RPu1Z-ZOm_CPcVdcrxGa0nSf1frAHD_rKscWU5FQ25FTo8jJZUYYHw>
    <xmx:RPu1Z3TNqJ2NTDP1qYDYsmrG9zteZWgHe1tMmM-dm7sJwkpOyZT1Iw>
    <xmx:RPu1Z0B_FtEfZA2_ODMgcZv9VkeOBoGNW7N66gb25VpozsbHgkb7X_EL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:47 -0500 (EST)
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH rcu 04/11] rcutorture: Expand failure/close-call grace-period output
Date: Wed, 19 Feb 2025 07:39:31 -0800
Message-Id: <20250219153938.24966-5-boqun.feng@gmail.com>
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

With only eight bits per grace-period sequence number, wrap can happen
in 64 grace periods.  This commit therefore increases this to sixteen
bits for normal grace-period sequence numbers and the combined short-form
polling sequence numbers, thus deferring wrap for at least 16,384 grace
periods.  Because expedited grace periods go faster, expand these to 24
bits, deferring wrap for at least 4,194,304 expedited grace periods.
These longer wrap times makes it easier to correlate these numbers to
trace-event output.

Note that the low-order two bits are reserved for intra-grace-period
state, hence the above wrap numbers being a factor of four smaller than
you might expect.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcu.h        |  4 ++--
 kernel/rcu/rcutorture.c | 12 ++++++------
 kernel/rcu/tiny.c       |  8 ++++----
 kernel/rcu/tree.c       | 18 +++++++++---------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index a6098997a14b..705fcbe6f500 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -590,8 +590,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
 #endif
-unsigned long rcutorture_gather_gp_seqs(void);
-void rcutorture_format_gp_seqs(unsigned long seqs, char *cp);
+unsigned long long rcutorture_gather_gp_seqs(void);
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp);
 
 #ifdef CONFIG_TINY_SRCU
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2113583cae34..fb1b80498ae0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -273,8 +273,8 @@ struct rt_read_seg {
 	bool rt_preempted;
 	int rt_cpu;
 	int rt_end_cpu;
-	unsigned long rt_gp_seq;
-	unsigned long rt_gp_seq_end;
+	unsigned long long rt_gp_seq;
+	unsigned long long rt_gp_seq_end;
 };
 static int err_segs_recorded;
 static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
@@ -409,8 +409,8 @@ struct rcu_torture_ops {
 	void (*gp_slow_register)(atomic_t *rgssp);
 	void (*gp_slow_unregister)(atomic_t *rgssp);
 	bool (*reader_blocked)(void);
-	unsigned long (*gather_gp_seqs)(void);
-	void (*format_gp_seqs)(unsigned long seqs, char *cp);
+	unsigned long long (*gather_gp_seqs)(void);
+	void (*format_gp_seqs)(unsigned long long seqs, char *cp);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -3678,8 +3678,8 @@ rcu_torture_cleanup(void)
 			}
 			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) &&
 			    cur_ops->gather_gp_seqs && cur_ops->format_gp_seqs) {
-				char buf1[16+1];
-				char buf2[16+1];
+				char buf1[20+1];
+				char buf2[20+1];
 				char sepchar = '-';
 
 				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq, buf1);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index f9c4a24dc59c..8cbec3401184 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -258,15 +258,15 @@ EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 #endif
 
 #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST)
-unsigned long rcutorture_gather_gp_seqs(void)
+unsigned long long rcutorture_gather_gp_seqs(void)
 {
-	return READ_ONCE(rcu_ctrlblk.gp_seq) & 0xff;
+	return READ_ONCE(rcu_ctrlblk.gp_seq) & 0xffffULL;
 }
 EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
 
-void rcutorture_format_gp_seqs(unsigned long seqs, char *cp)
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp)
 {
-	snprintf(cp, 8, "g%02lx", seqs & 0xff);
+	snprintf(cp, 8, "g%04llx", seqs & 0xffffULL);
 }
 EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
 #endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e40c4b5c3267..83cba3d2cc48 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -539,22 +539,22 @@ void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
 /* Gather grace-period sequence numbers for rcutorture diagnostics. */
-unsigned long rcutorture_gather_gp_seqs(void)
+unsigned long long rcutorture_gather_gp_seqs(void)
 {
-	return ((READ_ONCE(rcu_state.gp_seq) & 0xff) << 16) |
-	       ((READ_ONCE(rcu_state.expedited_sequence) & 0xff) << 8) |
-	       (READ_ONCE(rcu_state.gp_seq_polled) & 0xff);
+	return ((READ_ONCE(rcu_state.gp_seq) & 0xffffULL) << 40) |
+	       ((READ_ONCE(rcu_state.expedited_sequence) & 0xffffffULL) << 16) |
+	       (READ_ONCE(rcu_state.gp_seq_polled) & 0xffffULL);
 }
 EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
 
 /* Format grace-period sequence numbers for rcutorture diagnostics. */
-void rcutorture_format_gp_seqs(unsigned long seqs, char *cp)
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp)
 {
-	unsigned int egp = (seqs >> 8) & 0xff;
-	unsigned int ggp = (seqs >> 16) & 0xff;
-	unsigned int pgp = seqs & 0xff;
+	unsigned int egp = (seqs >> 16) & 0xffffffULL;
+	unsigned int ggp = (seqs >> 40) & 0xffffULL;
+	unsigned int pgp = seqs & 0xffffULL;
 
-	snprintf(cp, 16, "g%02x:e%02x:p%02x", ggp, egp, pgp);
+	snprintf(cp, 20, "g%04x:e%06x:p%04x", ggp, egp, pgp);
 }
 EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
 
-- 
2.39.5 (Apple Git-154)


