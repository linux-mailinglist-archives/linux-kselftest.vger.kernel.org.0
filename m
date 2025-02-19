Return-Path: <linux-kselftest+bounces-26994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E290AA3C40F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9508016252E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949331FFC4D;
	Wed, 19 Feb 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2RxTsnz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B204E1FFC43;
	Wed, 19 Feb 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979597; cv=none; b=nvg0BmZt0K091lAtYQy0uOUoKafz22DhiaSisaHG/lVKTyiNnXCt9ivKJPU9DedfD4iBsbUj5FxE7CuaFvYzUf/iocnyj8U2tDpfl+Kw+w1FXeRvuixrV2R3rgTvYA0RBFeZoRPcq70CeifPNhNmhhSViyIolrsJqDlGUzSBxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979597; c=relaxed/simple;
	bh=dDCvWADub8vz25X0BZtP3Yy9sXvTWzxxML17DcgW9WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FgcppvWqCr6V8nCd9MaUuto8HuAmBlTC8Vi0vechHC7SIdI1YoWMbcbeuqcMfYiR2v+RVRdVhwtsCTvthuL4zN9NKPzR76kW574tp25Qko8FUxPUwUj6HSodCLGTcfVS0hSxgIM52uQJFfxPx5pXziTf9MeSvCI7CSOklryUEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2RxTsnz; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e65be7d86fso9453096d6.1;
        Wed, 19 Feb 2025 07:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979594; x=1740584394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yk2VtTast1e1Qfnv8qhEYqo3m40LX7S6X3YLKhVYCYg=;
        b=f2RxTsnzn46oHRz5niG8UFJPBTx39pxlet0TWhMqnNQ4zuf9X5t9KX4pG6od5eRzzJ
         Iq5vq8E/fZHl9lCTeZwAymLalRJCM3OovGoo+tktHQsTPecXzBnduFW0Yy8UPkKjytIU
         uuguPhqMhg1SqSgxKHG7X5WnfaBOkN6cYk3owNngwSGAbXOfRTHp/B6zWJo8y2GWOBKM
         bgw2rcRkzx+6VAi+jzfsKIWE/YLA2z7m44/K3hThBuoSJ4Zeru2fWvG9E0CcENPEgfNS
         en+4kwStTQ6kJXCWfNzhiLVViokgcd+7BXGzAxIQH4WKanFUKVQ6A1xPqxzRPweyyBqr
         NfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979594; x=1740584394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yk2VtTast1e1Qfnv8qhEYqo3m40LX7S6X3YLKhVYCYg=;
        b=bD6TWH2iOGO6krkZv2h/ayV+0NTHvFS/b2IGuVyktuOE0U4RYMXoiPWGUtRBMexxpd
         1ML/P/1FTWrET2CUfR9K66Cz+Kc+n8LeRYlxOxILbgwkkUioBrsvRHqQcG1Og27PbzZI
         KrVgA6+DttR2IF3sKF+rROSNlEqKHKLRgP6eKved+6pTBInWr+usnJDe+KoIaL0SfrvQ
         6mPZZ9b2p5rMSAobpk3IbSTiQYU4Y2QvHJvd1FyaPvbgtNY/WI/tw4WZ4yGGAHDsEZcY
         sIj6ph0BCn90g78avANcPUwXPO1V49Ei/Eedi14Wml2JxPJEWjZvMiPKpUkUUK1RAdO/
         /mjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM5/AxibyELEcAyq8qvqlXZDYqymPcBnoDSyz23FoubuSmjdcNyvUhBBWwkot3832nlmE0vePkWb+t676COLwqUgXY@vger.kernel.org, AJvYcCVisl2iWbcwjztgyKAhz5MjKCI0UppoOSm8X4ATkWAC2AWBFQGw+XIxl55OyrhjxHEoM7Y7EUW4lpw=@vger.kernel.org, AJvYcCWyZqdCh4DwAhECc1MLot85hyLiZKaq6FWMCXCZZ4VFtizf3PDnx+aF8zsfyye7cjsascNp0TBr5VH5lMMh6UVP@vger.kernel.org, AJvYcCXulqdJnTm35GB4WP+kX+FtcPrmKsVI+Od/mR2C3MBbC5/LojLJyTbCaCuJbBeGBfr5RwZjgfrAoQWXR8ev@vger.kernel.org
X-Gm-Message-State: AOJu0YzVuoxWWV6stdIsJcHSlfy8aoRnTSFlBEDFf70MKR4BDpeei2q5
	97dLfsoB0g8D6WmsCuTM1qYrEyztG4ppU+EYr1g8OIvflV0t5KRS
X-Gm-Gg: ASbGncvbjJSY8hg7+AG5Vdy6sKwOSLaIbMZMu2lv6i35do1qTM1ZetpwZqdpdSmULZj
	kHxIFLBHnDt5PTHLtiepMQKddmw5fE9Nxvp+rjY/qNzxEmu8vZGJXN8DuZhhVDhp7oXaNklLnfj
	X7+Z3Z/B13VwqnnXrHdLmP+JxGgKR8CoRzUXJKIdDZleEwMG0AZq3jjRjRT6CoSfSWSBfGXN0SR
	XTcbzIzWA6lG9QheyliskiAUI4CLxOI/R91miqqpnydja17LiEqTJNv4OIbGTsU3byxfCzEczAT
	7bhCNMuHHBRBKGCZC8l6qgbDsGke/vfADsWPM6V2c2TTKHNbO7MC2+oYOMZDWdPE080o3ZF5BCf
	W6lozsA==
X-Google-Smtp-Source: AGHT+IGlAQQcARDOhRF4J4fxczgN4lJdTcz+w5fjOOSEpzAt8XbbLEHDj5VJ2wA/BKyp9zk8kG27og==
X-Received: by 2002:a05:6214:21a9:b0:6e6:646d:7550 with SMTP id 6a1803df08f44-6e6972dd3c1mr70432026d6.19.1739979594596;
        Wed, 19 Feb 2025 07:39:54 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65daffd71sm75693076d6.101.2025.02.19.07.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:39:54 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 82B571200043;
	Wed, 19 Feb 2025 10:39:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 19 Feb 2025 10:39:53 -0500
X-ME-Sender: <xms:Sfu1Z1I7xXCbFXboU-WqiR2M0MVCNG6g4QujrFytGKqiO96MlJa3qg>
    <xme:Sfu1ZxIK1EpmCYhwm82GQe5XsSDKj1eGinFHYgw7hwyotB7Uz-mgeyHA8lWnEGVTL
    V5YJZEK4nhOZfhRwA>
X-ME-Received: <xmr:Sfu1Z9vNTDltNoYXm4ZeLJW-NZL8XyM326E4IzKgrSnkKKSfjvhXb8NwyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
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
X-ME-Proxy: <xmx:Sfu1Z2bUbVvLVJ1xfOGVNE8_7Vc16Xt7AW2F1plXygCqbfT2OfLcBg>
    <xmx:Sfu1Z8bX4hgElgld3igH2cJtoBTOIPLPNXX5qulE4E8xmHGvlaOLxA>
    <xmx:Sfu1Z6Bf4IWpvN_WhJsJppFRbLbeXQfNTxZo7szPuQurVKzhbiYNGA>
    <xmx:Sfu1Z6YIkPCI7EB-gN6BlGbSKPm3aD65fbSFMkOqPx2z4MWntZepHw>
    <xmx:Sfu1Z4qf0coF5QCzVVtI2FPh7BP7A7BkbEUFvky9NbgT9207lIlNaA18>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:52 -0500 (EST)
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
Subject: [PATCH rcu 07/11] rcutorture: Make cur_ops->format_gp_seqs take buffer length
Date: Wed, 19 Feb 2025 07:39:34 -0800
Message-Id: <20250219153938.24966-8-boqun.feng@gmail.com>
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

The Tree and Tiny implementations of rcutorture_format_gp_seqs() use
hard-coded constants for the length of the buffer that they format into.
This is of course an accident waiting to happen, so this commit therefore
makes them take a length argument.  The rcutorture calling code uses
ARRAY_SIZE() to safely compute this new argument.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcu.h        | 2 +-
 kernel/rcu/rcutorture.c | 8 +++++---
 kernel/rcu/tiny.c       | 4 ++--
 kernel/rcu/tree.c       | 4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 705fcbe6f500..82d8b494cc30 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -591,7 +591,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 static inline void rcu_gp_set_torture_wait(int duration) { }
 #endif
 unsigned long long rcutorture_gather_gp_seqs(void);
-void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp);
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
 
 #ifdef CONFIG_TINY_SRCU
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1fdadc1df9ad..9c9a349b9c7f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -411,7 +411,7 @@ struct rcu_torture_ops {
 	void (*gp_slow_unregister)(atomic_t *rgssp);
 	bool (*reader_blocked)(void);
 	unsigned long long (*gather_gp_seqs)(void);
-	void (*format_gp_seqs)(unsigned long long seqs, char *cp);
+	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -3688,8 +3688,10 @@ rcu_torture_cleanup(void)
 				char buf2[20+1];
 				char sepchar = '-';
 
-				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq, buf1);
-				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq_end, buf2);
+				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq,
+							buf1, ARRAY_SIZE(buf1));
+				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq_end,
+							buf2, ARRAY_SIZE(buf2));
 				if (err_segs[i].rt_gp_seq == err_segs[i].rt_gp_seq_end) {
 					if (buf2[0]) {
 						for (j = 0; buf2[j]; j++)
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 8cbec3401184..8a52aca686a5 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -264,9 +264,9 @@ unsigned long long rcutorture_gather_gp_seqs(void)
 }
 EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
 
-void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp)
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len)
 {
-	snprintf(cp, 8, "g%04llx", seqs & 0xffffULL);
+	snprintf(cp, len, "g%04llx", seqs & 0xffffULL);
 }
 EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
 #endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 83cba3d2cc48..bb061e5870c3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -548,13 +548,13 @@ unsigned long long rcutorture_gather_gp_seqs(void)
 EXPORT_SYMBOL_GPL(rcutorture_gather_gp_seqs);
 
 /* Format grace-period sequence numbers for rcutorture diagnostics. */
-void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp)
+void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len)
 {
 	unsigned int egp = (seqs >> 16) & 0xffffffULL;
 	unsigned int ggp = (seqs >> 40) & 0xffffULL;
 	unsigned int pgp = seqs & 0xffffULL;
 
-	snprintf(cp, 20, "g%04x:e%06x:p%04x", ggp, egp, pgp);
+	snprintf(cp, len, "g%04x:e%06x:p%04x", ggp, egp, pgp);
 }
 EXPORT_SYMBOL_GPL(rcutorture_format_gp_seqs);
 
-- 
2.39.5 (Apple Git-154)


