Return-Path: <linux-kselftest+bounces-27299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD33A4135E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7171C3A40F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938EC1A9B28;
	Mon, 24 Feb 2025 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDUqj5aA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB21A3153;
	Mon, 24 Feb 2025 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363744; cv=none; b=jikj8cgYZJoqdkvdmCfJrpg/hznI/tZRUAFCN4uN0Tj8/y0G+mTeHwiXhy8eHxS6okbynSRXx5/t3rAD7oQfJZBjIyEqqbLZjC7uwH3KedE4hOi0wxU6OdpznmkadAucH44YF2qop5g0KJitQAfSDVLcs7seMHcs3Fa0BRXYAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363744; c=relaxed/simple;
	bh=IWWFvnRQmBN9XFMhXfPj63PsErr3J9ivkWHm1D9uPTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MFkseZgb/NkDQTBF8olR4dJbESt5l6irT9HjeBkYC1beUgZYs3fjo1D0IazzWTl5oacjfAUQJKst35MXx6amQ6rS6G791VVSBN6lmW1Z+uiFQYiG8K+zJn7sWjBjI0KtK8JGEpExMhwmVtC4QtBmQpHVUdXKOPhdFeF8iVvsjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDUqj5aA; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0818add57so411383285a.3;
        Sun, 23 Feb 2025 18:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363741; x=1740968541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DdxxxEQunYArASFbJzD0EbW0TcJj5v5m/sYqOFYiFGc=;
        b=bDUqj5aANHVi929lFyjp9T+NDkv3FrukazGK17egG6gnR/rISjnGGAclRSxq/yVgwG
         GbRiEZhrgNwB8kFQ6dR59TyPL0GV4vL/KzDIjfAtBYrts7UYxxux2Y4uuK4Jr3b3jWXu
         Mx4tc/g/OOBN6oiGWaoovxZk/qOT0n5W36xhuSm70NcF9NCN9aZ577GV4QIioxqorT1y
         /6VW3Anh3UgVH4qIkq3aMkJcsv4BkrtxDpDWfb/pyNQcTi3swkzI9ixIOKgX0EWkRPs7
         Mi7W5gSh8u7a+uQEonRZwcULoWR2Goa+7wl1bf0Pjcur4T+xs3R+kAbRjiS/pRvG/5bJ
         4OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363741; x=1740968541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DdxxxEQunYArASFbJzD0EbW0TcJj5v5m/sYqOFYiFGc=;
        b=sP+4qufvSmM7Eakhi6OOpwLkGMZFGWSH927A54iR1X5FUZbh1AMCuxJ4ivUCgTqT5j
         Is+aEKx9p06TMBe5Z+8coXk4w2TEr3YazNNDLzF/JEpLCID4lj/Gkv6CUenevBf9AcnI
         FXxqrxdVOo+LhL38P6eYFmYYgCwKR83uOjicZlIYPsXOXBHIoeJmBqrkcWsIkiDR6CW9
         ioxMCAtyMNOUC+57pA4XTRhDiuoiwDkawrFE+3hny2cTbhET+PUyoJVYY7O0t2vpS51B
         FUw69bsXo8U5fqCJtz61QW+8cnQ8PyttLdc/QBf8TvH3geTSllTTE3Z09+QGyirQtlsM
         5MQw==
X-Forwarded-Encrypted: i=1; AJvYcCWm4gzH6lHBsi/bkGyBX0YopDk/SgvgrQP9q9NCvWICu2xdvGqT7rZeWpkNmNJ7DiHW8Og=@vger.kernel.org, AJvYcCWqv6t2sOCzPqdBlUTyxZxY/xyN7JRoM635Y4ydSp5z/Jlm0n6X03c3QQVgo6ghVhhTwXf5En7h7kAYz3z3JIF4@vger.kernel.org, AJvYcCXxW6D4Om1IltbdxDsLusmIw1Vg7poYLs9ZX7VKzvKy5hTxXESSj3F+7RlZETFd4Y+XOkvSSDqSLG5M/P9i@vger.kernel.org
X-Gm-Message-State: AOJu0YweftAajX/YZptu4UWfYxskVbbGhbvz2FoYFJuOmhtdRQdGDJm1
	gD+dytR5FK8zCX7UhC9SW24PjvCJTY45LRfkiinql7SwFBc3UMOZ
X-Gm-Gg: ASbGnctbWJxF5fDsHIT5SvVqrLd4nD6803gr1MqcgXdNvXL4zcT494l3N346LcaX+Hq
	9K/33h5TrSC2lXP2J9CZj6AttbwGmUAM/YB1oFgYhqksSz4ntuBcHHuveVK6a4Rn86UXUzEAezp
	F5TWXUGA6siGf0Ig/qC8YnAhM0hw/3pBXDv72RuTmJq66Pja+ymOm6tI/Av3f7Oa8h8e0JQTWaO
	GOEEG+UoZKfXxgkbASt8FKOIJRRqJnehxuKiiz1i86Y0OxFg0motlt+R7AomnmIYUwj60+D9PFa
	in3sVyhn0lcvGOwNCfDxN3UJ1ChzosN/jn3JiPdO471mNtWxwMEGLixOVv4xmwQOXaarD9Gri3Z
	E5AEkMk1h4tID0yaZ
X-Google-Smtp-Source: AGHT+IEDsAUAVip8lsPccMpgEXsuo884vRHK3H4G+8C+AfawM9a3nx+CeNFx3jftdkE9f5tmKS5q2g==
X-Received: by 2002:a05:620a:f14:b0:7c2:2a54:8810 with SMTP id af79cd13be357-7c22a54882dmr408863385a.23.1740363741631;
        Sun, 23 Feb 2025 18:22:21 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a3dcda55sm879624685a.58.2025.02.23.18.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:21 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id B80881200043;
	Sun, 23 Feb 2025 21:22:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 23 Feb 2025 21:22:20 -0500
X-ME-Sender: <xms:3Ne7Zy9_5Qaxx27mPr3jnHuSLvjVwXP0sC2zfdyxn64fqwxC4LCXjQ>
    <xme:3Ne7Zyt9RWlmIqFYxxQ1PacEucBKYl-s47KztwgcpZHJ5Oj6QQLQwfOvfFL63F6Nc
    ztZbOZxLX7OjiSyGQ>
X-ME-Received: <xmr:3Ne7Z4BFD-Y8ADtLJkS3pZPkM_w4xHUgTuqEXJVaW2aG-9jrSyDjPKhZoA>
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
X-ME-Proxy: <xmx:3Ne7Z6cD1QNcmkMun-6Lb47iH5XjPDfmY0O2GjLbEP3bq00taVLTbg>
    <xmx:3Ne7Z3NcMm-6EDy7aOG9L_3WBnP-GRxMN99lnG2JfDNiHijH6pK1yg>
    <xmx:3Ne7Z0lLawySXjo9EM0NjJY-MfEif3bVugTAwLo3hE_jNuzCwJFrPw>
    <xmx:3Ne7Z5s1PNd9snuelSLvoii5GJjpWP91Cz3OkKIOvYh3T1P3Ri43fw>
    <xmx:3Ne7Z9vhYJpL3KMnyyiX4GV08VutqmUDOyY_5ZDJ5YuFR-SxprQ3-HET>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:20 -0500 (EST)
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
Subject: [PATCH rcu 03/20] srcu: Use ->srcu_gp_seq for rcutorture reader batch
Date: Sun, 23 Feb 2025 18:21:57 -0800
Message-Id: <20250224022214.12037-4-boqun.feng@gmail.com>
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

This commit stops using ->srcu_idx for rcutorture's reader-batch
consistency checking, using ->srcu_gp_seq instead.  This is a first
step towards a faster srcu_read_{,un}lock_lite() that avoids the array
accesses that use ->srcu_idx.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 2 ++
 kernel/rcu/srcutree.c   | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d26fb1d33ed9..1d2de50fb5d6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -791,6 +791,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.readunlock	= srcu_torture_read_unlock,
 	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
+	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
@@ -834,6 +835,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.readunlock	= srcu_torture_read_unlock,
 	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
+	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b83c74c4dcc0..e69ce9d59abf 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1675,7 +1675,7 @@ EXPORT_SYMBOL_GPL(srcu_barrier);
  */
 unsigned long srcu_batches_completed(struct srcu_struct *ssp)
 {
-	return READ_ONCE(ssp->srcu_idx);
+	return READ_ONCE(ssp->srcu_sup->srcu_gp_seq);
 }
 EXPORT_SYMBOL_GPL(srcu_batches_completed);
 
-- 
2.39.5 (Apple Git-154)


