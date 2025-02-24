Return-Path: <linux-kselftest+bounces-27304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397BFA4136A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE0D3B6DDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618891DE4EC;
	Mon, 24 Feb 2025 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK2NElW1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC61D86C6;
	Mon, 24 Feb 2025 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363752; cv=none; b=aEvUdNqlpqFbpA1t0/9s7fyYC1ZN23bBYsTi/jDq3K3OyIGymzbDxQUlPsI18qGSI+WpF2YU2s+yLQyfXHLauZ2ouCcQOgH1jPEArpLInCVj7XuxpFM4RCjDABpMVj13my5kp1jvAviLTife5o5xSU+Zy6rlCV3z/m4tGwVgR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363752; c=relaxed/simple;
	bh=/9l1ioIqmq/Hpm/G/Z1p7cG+v9hvH+kj+ihFoubN/j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEvj1osPqBVYJRfgQy8R23sRkbBosmucYm8sK42h1jAxA4WUGvn7Bch913/nVM6H7lykxgngSUP3SDp2q8cbaHJ0cxH//7so3NbWWrGNQlbREib4VCAu2oobtWdNj4e6RUBWlE/uqYND57PTlG/wvmilZt95em4SxRynn2MwkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK2NElW1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e67f377236so32018176d6.1;
        Sun, 23 Feb 2025 18:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363749; x=1740968549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fYMRQ6Hd0Y9BVpEL39V5BvX9VXJ2sUq5YH9vLc7Ts4Y=;
        b=QK2NElW1rhlj58o8BUG188Zp91jbJ3A73bSHYwoUdrooJqq4T2eOGscnCwFgUveoi2
         QMPed5ccUIRJQnfLpxqhVxloD7j4Z+9K8z/z6tUQdKN6rmpuQr5DgXn0f3iB1GLLYueQ
         oYueNfKRAleLi5lBx8xHiyTeupTe+QUYZQ8DFuDgWQDiAaW+drjqOsDKdG8qKNCFXzXK
         TfXDCngwdz0X3bF+x2+vLTqNS2GY9OxTMIndpGRrszK2lw7VE3P+VkFb/VyCQTTpNfck
         QrKlgAj6v9+sJ+LdtNt+qV3j2w90y9FWFri6tJrfW4vUFIK+GPH+XVaBVAs9it7PJr1j
         PlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363749; x=1740968549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fYMRQ6Hd0Y9BVpEL39V5BvX9VXJ2sUq5YH9vLc7Ts4Y=;
        b=W1qmnV1jml8wTbVvT4/UKHTWxdQFzLnYm3mK2NZ52ZgljTH/3YvivNPmUJVrGkr1p7
         emwV0nostRh2TyrO3LiMOaQuTeuAIJXJFkFDSb5DLZiIc//6yJrmrOSQYleZIS4OgKXO
         /H5ATtUlDii2sTwPs+y0IsfyN4F0DGwolfspp8XBd8f1xxhEmJy0cKXcH1hwmAsYxOaJ
         +tsAPy0+N5OQ7InZtXd4iVirLpdcvTex6XO2tGETddW/L1/CvMyfgJ3fMBovqVjneMXB
         EXbT3T+JzOas3AVFLxvDDWfaif+cAf3vllqXKntdNFRWSPnPliXliog0s2zSZV4MhSib
         VUuA==
X-Forwarded-Encrypted: i=1; AJvYcCU7P/XtN6Yu7Wa6jj4Hd6KjJiqB/4VMnp9AkOP8wJMEfYpI6pCdT7u8HNIsKAu4wkl6e3HrUjbEuPHVvRMbbesk@vger.kernel.org, AJvYcCUmfpGGIWG5jtr1TSv6b5sgFUCHbFGKtukRuy9wxruczzupQzhux+YT5IhD3/F622jY9/M=@vger.kernel.org, AJvYcCVBECuNADc+6TIHXEzBefQlxtTTjSed3j3YqMpm4cpustNJlSNedjbm1+BNgS+XL5oxzKQfhx9jWe1Td6MR@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNvOiBka9wC5JTSx3/CSQluiIsSZbrwCxa4hcAfou8onbREK9
	oyjH3Hrc3ZpaOSFNKo07WswwVuusU7gj8WEBta0W7xTfIuTk4yXa
X-Gm-Gg: ASbGnctiQp/UhMPszkXHiOql9PqoOZC1GjtrJidCvTWQC8fVTxW2H83j4S6IdxjLbfD
	TjZu0zIdQ39u6sa8fTspaDM4pYYILfUm5ljlBXIBqNUIMv9SbY3zzzcXWCvgRek5CMrJDbrJ6x/
	2xniM6pcK2IVJHUfYgdMNGGLJbdHOxolecLO1aybS7fmshUUi2JX/olhS3Bw6SR5Y+RAzMY9k2x
	qlhgvKtWv8+5sWyAZroeLJB3ixTkYrdAJH5Vt5ramkCUm7cJZMRP6kqHcIu5Ija7h+2OgtYLriC
	qi1KdDSQvpfOUxO+IC3gH6fdMPnw9+qeD1NrjiipU7dzmy92WTuWorb+C+KFcl/rC1d28+xzVZ5
	/x17nj8fsO3IaM4He
X-Google-Smtp-Source: AGHT+IHClRbnQ4ctEnkp5istwWDgkUN2nCCWyWoj8RsUc0KxJ45c4T22hIVU190OvqEKtZUeDqyb/A==
X-Received: by 2002:a05:6214:194c:b0:6e6:5d9a:9171 with SMTP id 6a1803df08f44-6e6b00fc43bmr180572626d6.23.1740363749320;
        Sun, 23 Feb 2025 18:22:29 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d779201sm128381556d6.2.2025.02.23.18.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:29 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 79A0D1200043;
	Sun, 23 Feb 2025 21:22:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 23 Feb 2025 21:22:28 -0500
X-ME-Sender: <xms:5Ne7Z0Q8G7eQNjHFLyEMGAm3vRIZfZcm-ECGWkhiQCR68jEWsBszIg>
    <xme:5Ne7ZxzdYz0Hl_YHBO2FADVUDosY9I9R2JqQV_FwpXVlf7qSCF57UKcRaTsTGEX8z
    Qo0yIAmtIYBz_uB4g>
X-ME-Received: <xmr:5Ne7Zx2lXPGUy3iYzPuBImPNxgJn9rdiCZPXKfglyjK8w4IaGD46PRnBpg>
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
X-ME-Proxy: <xmx:5Ne7Z4DHaaJA_85dHNI8_FwaMBXZLq5kmnCrwo7VhTdSv-gSFMW9IA>
    <xmx:5Ne7Z9i1ilZgMTJzlanti08GV4tiidqfQp0JGagCpOLkIBPlvR2ENQ>
    <xmx:5Ne7Z0oZduxKd5_wyBsyD9OrHnrP3zOMx18RvdrP-4AlAx75C8cWEw>
    <xmx:5Ne7ZwjS1re21Bu1iIgfPndb8aYDRus-BRR0ynAUA8Nnt2aZAgxiTg>
    <xmx:5Ne7Z0RqO9-wdBRh4y8SAU4uheKFe0eXeV79rKEP4uJNQlvh6ztKVxG_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:27 -0500 (EST)
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
Subject: [PATCH rcu 08/20] srcu: Rename srcu_check_read_flavor_lite() to srcu_check_read_flavor_force()
Date: Sun, 23 Feb 2025 18:22:02 -0800
Message-Id: <20250224022214.12037-9-boqun.feng@gmail.com>
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

This commit renames the srcu_check_read_flavor_lite() function to
srcu_check_read_flavor_force() and adds a read_flavor argument in order to
support an srcu_read_lock_fast() variant that is to avoid array indexing
in both the lock and unlock primitives.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcu.h     |  2 +-
 include/linux/srcutiny.h |  2 +-
 include/linux/srcutree.h | 10 ++++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index f6f779b9d9ff..ca00b9af7c23 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -279,7 +279,7 @@ static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_read_flavor_lite(ssp);
+	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_LITE);
 	retval = __srcu_read_lock_lite(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 1321da803274..b347bde1aac2 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -82,7 +82,7 @@ static inline void srcu_barrier(struct srcu_struct *ssp)
 }
 
 #define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
-#define srcu_check_read_flavor_lite(ssp) do { } while (0)
+#define srcu_check_read_flavor_force(ssp, read_flavor) do { } while (0)
 
 /* Defined here to avoid size increase for non-torture kernels. */
 static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 6b7eba59f384..e29cc57eac81 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -251,16 +251,18 @@ static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
 
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 
-// Record _lite() usage even for CONFIG_PROVE_RCU=n kernels.
-static inline void srcu_check_read_flavor_lite(struct srcu_struct *ssp)
+// Record reader usage even for CONFIG_PROVE_RCU=n kernels.  This is
+// needed only for flavors that require grace-period smp_mb() calls to be
+// promoted to synchronize_rcu().
+static inline void srcu_check_read_flavor_force(struct srcu_struct *ssp, int read_flavor)
 {
 	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
 
-	if (likely(READ_ONCE(sdp->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE))
+	if (likely(READ_ONCE(sdp->srcu_reader_flavor) & read_flavor))
 		return;
 
 	// Note that the cmpxchg() in __srcu_check_read_flavor() is fully ordered.
-	__srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
+	__srcu_check_read_flavor(ssp, read_flavor);
 }
 
 // Record non-_lite() usage only for CONFIG_PROVE_RCU=y kernels.
-- 
2.39.5 (Apple Git-154)


