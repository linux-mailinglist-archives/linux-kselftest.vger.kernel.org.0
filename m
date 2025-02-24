Return-Path: <linux-kselftest+bounces-27303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E19A41365
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B453B676E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F0B1D619F;
	Mon, 24 Feb 2025 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGWzCXtQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864FF1C84B5;
	Mon, 24 Feb 2025 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363750; cv=none; b=aEpLJGVwgB/36uQ51h5Yu+Ujg3E/jt30wnV7yoYA5LwXydsDAkkoJ2MiCvKaKoXe9LH8Bfd70q8P+EkuxKuG//D+FpVvz0l3SeUe+ntQ3Hs3B1Z+qjFGxYa7H8YBsg4yGbjTFelt7hTCEzD4+XORiMB0uEKJDHEhiNtBKTgfo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363750; c=relaxed/simple;
	bh=jXfx3DcR/gIMfS6LpI1FhxoXAND9nxcBAQS0dO6cBLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iuxqGCJ0pxL4X5S8Wz7iyQZMtymJkenzfIaDdyOmYBXlu/BQO+TOD7sk9EkPbtDP/xr2ar/yYNVLKoRfDlFrUOxl9GzA57j3eNJZuwO2zD0KXYfLZBNp+UV1RB4QSBiyJNvUNRbS+ri95nNVk8ph2B1PnBu/af8v6FLW7rhh0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGWzCXtQ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e65e0a3f7eso17748536d6.0;
        Sun, 23 Feb 2025 18:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363747; x=1740968547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NgjdExsgtBixOhKRmg8fzqCy/iqJaNe7nEbvDmdzUZw=;
        b=gGWzCXtQKhfi/UThlcLtwCXxc+jJD4wajILX16xM08uvwbaS3w4PdDQ5UFM1wQDvj5
         1/wcuch0GTSAPTHtp8SSEVjRFkCRFiRWldw4jSR2qwOwNP6eU8M9+3XwmqwRqT8KpXnm
         kxsH4IQairg5rCAa1GwvNcFIfBhg707GxwLL7pr5XHP2MhTreeSKJ1jXmRHLbV0HWVms
         GElavAHTc++XHMGhAnJr6AqchJozGisMJeE1ZIoukA/bD72EONES/mILOSPMS5eMvxJ7
         Hn9yhS0KYE538Awed6CrkQyMtGL8v6FWc5cI9aTlZkLPuXpuLTYHDGz8HesNoKJuaITg
         fNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363747; x=1740968547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgjdExsgtBixOhKRmg8fzqCy/iqJaNe7nEbvDmdzUZw=;
        b=LvgjcxpWzKlMwy8iICQ9dB/lj7Kp4oOa8l+NSdv4u+2j/l+Z4K0ODqGHla4XL/bPOE
         kyb5jt8J1o7B4tfPq3fg7XJJHrGNJosTMwtEXppgEIexztpXkZvUDnkl4A039VB6FjsU
         csmrys9oUJEj4Pu4GcV3cPYZikkAnGTotjD1BWG1XIiDPX6UGDSh7EL65v8y0LJZop5c
         jwX9z/w0eX8TNpg4QH3fETrVgD6tVnCBGlyJn/eK1v9zzy1yLvaL0utmWMnayUlWdmiM
         YOfK0Zar/xF5+tWqef/9vsJKmZVP37tGma4rBcTE4dI40gjuhcPs5juqPBLiK4tTgEJi
         zV/A==
X-Forwarded-Encrypted: i=1; AJvYcCV60UnT9NI+O5Px9mE9A+jayLmWHTDfmuazsELy0WlCTenZez3hSBT3z/+SaS1CR15klGo=@vger.kernel.org, AJvYcCVuHiXgyj+iB2riE5/MVGwnJlMPdqqz86g4LlVSJm31KPM7FYcA0yvwbXjH1m0Bc3RNz7Udst73Jjlp9onY@vger.kernel.org, AJvYcCW/bcysgTJO2Ohuf8ZPm+R9FA79yP1F8pRv3I6Ioxdg8cpbXmogyiQjXBvAkeaN0zJvhTwthEeWPfTD/nyPgpmT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/yN/AzJTpHA9sQp2AOl7fSStATZUm9O7XO37uGxM4433DV2x
	R3QEJaw6WZc0XOH+5ZLqeRyI5Y625PKbfoSJELbd3w55y6fEfuh0
X-Gm-Gg: ASbGnctjHjjh6c6EtmZqFmTSpAhv0asLSZYwsHsP92Gp/M/WjHDpmwIcbNt4qJiLzi/
	d1Wmjt8MEKqgOJ9fueI/QOgVixjGtyr2YpjfgvANYWQHiSmrt+8/laigVUTAyTkrQJtwINOtIOD
	nBYQ4Mx/3GvBwVTN+g3mWAJGO+B3i84mitSemjhgibdz8sqRXYkq6GJwu9uvfHFn2wC+DinrXlc
	t2feIQPOkm4ugoJllka1/O0pMaaKh4IceozBcazhLpWm3I25wcBPj4I0oYAaFs6lj+98ZdzCrMV
	Zz83Pz6nuWU4Lqgyg0OagfQbtjGzFcMriv7MKkuNDjfvgqSQWBpkFqZqWQIaDSvCP9gpS9TQDJ2
	KW060J/gIaIv6HIv/
X-Google-Smtp-Source: AGHT+IHgsDZI/0jVHQs54YPHxU/PatQqYvtF2q+bMn6TEOIqoQinIEowN8zhQPDQGC/qynR4HXp0gA==
X-Received: by 2002:a05:6214:48c:b0:6e6:6089:4978 with SMTP id 6a1803df08f44-6e6ae82f74dmr134500206d6.24.1740363747192;
        Sun, 23 Feb 2025 18:22:27 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d779266sm128758466d6.25.2025.02.23.18.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:26 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 35ACF1200043;
	Sun, 23 Feb 2025 21:22:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 23 Feb 2025 21:22:26 -0500
X-ME-Sender: <xms:4te7Z90CDtusIycvH8MeUF3Am8l-_FVtpmdCJx2aOQ7-IHEOq9zl_w>
    <xme:4te7Z0HiO21YrW4tnE2I6g9R79GSL0joYh3TPUC-7RlM1Yy9ezmXtbesu2tyt2R7t
    IPTp0A9p6RndXCHfA>
X-ME-Received: <xmr:4te7Z94TEjmcPmkzT1CM_oMpDVcy_JHlapjOLvDrTelnRtC7VE3xIwsNEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomhdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhshh
    esjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtoheprhhoshhtvgguthesghho
    ohgumhhishdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:4te7Z61VF6SoaDUBkw49ur14Nb9TFYTnIr-yquLNa02OxfRcLzSfWQ>
    <xmx:4te7ZwGtqBKBv8Q3nmoSBRBEKzryhkVvlELZpBXB0EP2tIR2xqZIMw>
    <xmx:4te7Z78rE1md-9gLedxhqrn4Otmnms6fLBWlubQqp5iTDov0k2DL4g>
    <xmx:4te7Z9nLKI-PAR3aykx4bf45AmLgo8ippgwBiqWsAIDq0qs0E8y49A>
    <xmx:4te7Z0GOQL4TyKpVYsE0izu5FPXbn3KuK_caOr_F3yWpzIAwIP3BrJEK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:25 -0500 (EST)
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
	syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH rcu 07/20] srcu: Force synchronization for srcu_get_delay()
Date: Sun, 23 Feb 2025 18:22:01 -0800
Message-Id: <20250224022214.12037-8-boqun.feng@gmail.com>
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

Currently, srcu_get_delay() can be called concurrently, for example,
by a CPU that is the first to request a new grace period and the CPU
processing the current grace period.  Although concurrent access is
harmless, it unnecessarily expands the state space.  Additionally,
all calls to srcu_get_delay() are from slow paths.

This commit therefore protects all calls to srcu_get_delay() with
ssp->srcu_sup->lock, which is already held on the invocation from the
srcu_funnel_gp_start() function.  While in the area, this commit also
adds a lockdep_assert_held() to srcu_get_delay() itself.

Reported-by: syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/srcutree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 247bdf42fb54..121dd290cae1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -648,6 +648,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 	unsigned long jbase = SRCU_INTERVAL;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
+	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	if (srcu_gp_is_expedited(ssp))
 		jbase = 0;
 	if (rcu_seq_state(READ_ONCE(sup->srcu_gp_seq))) {
@@ -675,9 +676,13 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	int cpu;
+	unsigned long delay;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
-	if (WARN_ON(!srcu_get_delay(ssp)))
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
+	delay = srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
+	if (WARN_ON(!delay))
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
 		return; /* Just leak it! */
@@ -1101,7 +1106,9 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 {
 	unsigned long curdelay;
 
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = !srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 
 	for (;;) {
 		if (srcu_readers_active_idx_check(ssp, idx))
@@ -1850,7 +1857,9 @@ static void process_srcu(struct work_struct *work)
 	ssp = sup->srcu_ssp;
 
 	srcu_advance_state(ssp);
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	if (curdelay) {
 		WRITE_ONCE(sup->reschedule_count, 0);
 	} else {
-- 
2.39.5 (Apple Git-154)


