Return-Path: <linux-kselftest+bounces-27307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A33A41367
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE03D7A56A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF951FC7D1;
	Mon, 24 Feb 2025 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jup5R1a8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C01A23A4;
	Mon, 24 Feb 2025 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363757; cv=none; b=cbc9yTacV7bywOxCzPzMcgzwK6eZ/TGpJkYkYHIaHhu7gLyZFyek6Y/bCGfTnJliG02ahJTO3AJkUpr1yVA0USpbLLDexNllChb1zTVDXMN1nQaOsDCB5byplcDqn+/v+vqJkxgObxrKUysLinZNeccYB7erUR5z7AwtBHxwKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363757; c=relaxed/simple;
	bh=YrHT1FYi1+OzGm9Y+UlE/vWNj9k1nIL2jAmcMpxhAJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GOyCj22EcRv1y0qYhC6Ngi3bhdhjfDmEjtZYSMColdtvweVWA005cLQCAZcEdcgWnp20fsMY3nW3aAm7V+huFLaOJYF2ofCDNnyHR78GAK0jrOcgVWb69nYfx7mZmO15qJL+2EBynBtk8QWXsPW4eiOXlfQ3++jnJftSd/h9pAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jup5R1a8; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7be8f281714so496476385a.1;
        Sun, 23 Feb 2025 18:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363755; x=1740968555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b4UbglbVJKQ61dofpRaNQb5dypoLHjOhU9tZFxlz6Bc=;
        b=jup5R1a86jcAl3VM3zxMtAbP0Te58weFlknwBvoT7br5OWuPYqhlP4jwlFkSyKkDP+
         vkV6XNas+/pf48gKE1DpqhPO21/xsDkAakLr4tygXorBzFZWOmsbkFkC3dmd+/yKeUs0
         U7mh1DFRLwwg1UiOmg4cPwZeqsJ07XVcWSW0sXEoouLMSJ3eH+Cs+Ou1vY1E8tQJ0dOh
         95quRa5UNt+CRS8SKgipYSudZbEjibua42Gi3kLmz1zpd4qmWa/tIF8hcuo0ux697kSD
         1Q4ojUfpRRzS5p8LWLjZb0qQhu0P82sBG9ZJZgB9D61rJSjiGYnsJToK9lQzcTIZB9p9
         qxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363755; x=1740968555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4UbglbVJKQ61dofpRaNQb5dypoLHjOhU9tZFxlz6Bc=;
        b=vkBQQFc11HymwggBzD0LVp8U0/KeGAmFtfQA4/RwKUak4nXsulIq3HSvsEwVIRXJsO
         U3qxkygVfS8GoSbASljjX9/16/XCznf14WT8nYV82f3ZmswMOPKDyVmxU6KiGZmizwpz
         yc8XtmEq/S9NC4B4B1h1JtYhrK1moC2B+Ru4qIAG1Jm/HuTLG9oDsXE2yJAzSaLQXW2I
         TzpyPEqzUygn15AgJJ5P4wW7FMsi81Ha8Y/FRmGOkRZ2DY0W/IrHN/LtkSGhR1qxwhIe
         cGwhHjxYubbXF2sFfj6yYxHfNvlZjlM+SwHQmI5BntN91qFl12aatszllmgesBcSjsJx
         2BHw==
X-Forwarded-Encrypted: i=1; AJvYcCV13iIWB4PTaMdNhngWdzO7QWIMm0BhMCTyCXlB5b/nOICy1YSyLJDAKQ+QePcV3DNbcRE=@vger.kernel.org, AJvYcCX+sMxBpt1ahnN7ttznoPbHpjXHfkluO08OAqMHYSmDphWSsEQAFnY+XZZ+gnpCOhgpro/Jq0uDuLPdBGWh@vger.kernel.org, AJvYcCXr8qW9jb0GufzFgjffbeZj0uDs5M8pjRFqCfykF1R7Eh48NXDYUdiD7KHKtWUJ+Kpmt+97bIFhKAYLaTZt2A3D@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXKhL2MHqNQP1K2vs+5W/KCgYEcFWYTDU0F+wni0BAWntPgbv
	LVbuq0fIC5DHk48qAgJtNlhNSac0wcghKgJper5l/OUM1wC7lShZ
X-Gm-Gg: ASbGncsdHhkOOCVeqOk7TA9VcCz+8UsThKMiFLq7Zyt2jZ66vXUOydqu53OU3H3ahBk
	ufCRAffA0CO6rZrzVyFfO1laA3/QNGf256z6NlV9RO9Ds7khGBnFdow9UyfrW2wpLOERl4dcWVL
	GBvfCuXOvvaA9tu/7K4zGWNJUn8yVHJgFTt6dhuJoL+BH4SFOV+kJFJd9BbAxVGw+Jgv4oPM1Yq
	vrd9ymtdV4n0YXbPxRXhgo5mxY1okbq4/IjrCyRvodGRH4Zf0/zcfwyDrFnpnxYaMWxKOVYx39a
	laV00hKkJ6yROP3BdxHR7PZWXVinohR/0FxSM9fsMPQtrxZwiYL34JpYBTSj8LGd4tGhLgzxWYf
	ewTZ93g1BPTcC97gd
X-Google-Smtp-Source: AGHT+IFJ0c4dK35a+uqh/H+mgY4++zlo+aC7ovaC3i7iZFv0MXgycDMLedqpsay7Y6JGaqjxgV3XgA==
X-Received: by 2002:a05:620a:1a04:b0:7c0:9df3:a0d7 with SMTP id af79cd13be357-7c0cef49da6mr1415529885a.41.1740363754658;
        Sun, 23 Feb 2025 18:22:34 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785c09sm127670766d6.36.2025.02.23.18.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:34 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id CCFCF1200043;
	Sun, 23 Feb 2025 21:22:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 23 Feb 2025 21:22:33 -0500
X-ME-Sender: <xms:6de7ZyQwcei_UZOOQUyUz0RRKe4VZGoJUsM7hDVpAyA0c6wX0qRFmg>
    <xme:6de7Z3zzl4pw_1mU4_TgRVP856Fg7nCA8AOeVx-qRlOks1Lh8C4zorYmUQ6SAq3Zt
    Jao_TWamBwNIIHHyg>
X-ME-Received: <xmr:6de7Z_1rJH1fbmAQgh5fc1WD5xSn-sOOYjFb6jdfGZGcGrlx2zhAD3Uxkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
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
X-ME-Proxy: <xmx:6de7Z-C0pjnakYsGSjQtVLXXodxNiJGyqtkejK4PrWAUBfCvaI7QGA>
    <xmx:6de7Z7gHQI0I_OgfV8jeFMpqcpOWmGto7EnEgWrbi4FfbML8fVuloA>
    <xmx:6de7Z6o1udmB7foGPhFVr28oUsnFkhJFwHWh1qeJ2i3e7CR--l2wWw>
    <xmx:6de7Z-gmaHGgAySwQfTrwaopu2q63x2LfMdUOD9xzWUs63UJNBSUXw>
    <xmx:6de7Z6TN3fLrw9IoVamb-UqQbWgiasCFNfK5j0e2HBtFiEOaU57Aa6hv>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:33 -0500 (EST)
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
Subject: [PATCH rcu 11/20] srcu: Pull integer-to-pointer conversion into __srcu_ctr_to_ptr()
Date: Sun, 23 Feb 2025 18:22:05 -0800
Message-Id: <20250224022214.12037-12-boqun.feng@gmail.com>
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

This commit abstracts the srcu_read_unlock*() integer-to-pointer
conversion into a new __srcu_ctr_to_ptr().  This will be used
in rcutorture for testing an srcu_read_unlock_fast() that avoids
array-indexing overhead by taking a pointer rather than an integer.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcutree.h | 9 ++++++++-
 kernel/rcu/srcutree.c    | 6 ++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index f41bb3a55a04..55fa400624bb 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -218,6 +218,13 @@ static inline bool __srcu_ptr_to_ctr(struct srcu_struct *ssp, struct srcu_ctr __
 	return scpp - &ssp->sda->srcu_ctrs[0];
 }
 
+// Converts an integer to a per-CPU pointer to the corresponding
+// ->srcu_ctrs[] array element.
+static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ssp, int idx)
+{
+	return &ssp->sda->srcu_ctrs[idx];
+}
+
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.  Returns an index that must be passed to the matching
@@ -252,7 +259,7 @@ static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
 {
 	barrier();  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_unlocks.counter);  /* Z */
+	this_cpu_inc(__srcu_ctr_to_ptr(ssp, idx)->srcu_unlocks.counter);  /* Z */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
 }
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index a91651866485..7a8ace83c98d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -765,7 +765,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	smp_mb(); /* C */  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_unlocks.counter);
+	this_cpu_inc(__srcu_ctr_to_ptr(ssp, idx)->srcu_unlocks.counter);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
@@ -794,10 +794,8 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
  */
 void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 {
-	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
-
 	smp_mb__before_atomic(); /* C */  /* Avoid leaking the critical section. */
-	atomic_long_inc(&sdp->srcu_ctrs[idx].srcu_unlocks);
+	atomic_long_inc(&raw_cpu_ptr(__srcu_ctr_to_ptr(ssp, idx))->srcu_unlocks);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock_nmisafe);
 
-- 
2.39.5 (Apple Git-154)


