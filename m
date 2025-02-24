Return-Path: <linux-kselftest+bounces-27305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39400A41361
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10857A5813
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC2A1EA7E5;
	Mon, 24 Feb 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om0+Va3F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB67B1DF988;
	Mon, 24 Feb 2025 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363754; cv=none; b=eCvmhZmTNYj8gR7cqY8ps5E9dEFEUWwN5KxrDhAGA57Y/kw+7FSvLZ9lsYw8ZxBKvPv1jEmhSQOwYPwzzQ4HZKCgjgM/2Jk8u+9aBP928v+nhYME0p5vJzvvJyeOxzvf4gd5xPLa0e3Hx0warTyv6zXamY28QpdSd4LsVOGD1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363754; c=relaxed/simple;
	bh=FJ4Rb41z1ufJ+wTZ0uFJtruWUxDLdj5Ng58pCay5gII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EuoXERcY7lq5+rP3vf4ITWMicX9XLTze8WkOhc8I1XojZjU4Wx0QqvujXZy+VW9spYQxBRDMNmDA9/uc2ZEEXqmxt5JqY4UoFNRRwmUp+XMMT9d3I7q+qjAqFs0jpCBC37zxhBV+3X6tDrEqjui++5TrzaF3ggh8FYbaarBmT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Om0+Va3F; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6df83fd01cbso17405806d6.2;
        Sun, 23 Feb 2025 18:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363751; x=1740968551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kUQeyMIXkWewc+GJgkcRvcJST3TpV64E6KpD7DCbPAI=;
        b=Om0+Va3F/ozLUm1PmUc9VuI414kcUD70dXinX7R37W7iBJgbn3BPbgwF9EqVKGJUKK
         zTS4spNGFh2fma1NWqQwtuVjvRiGrSmCAUIkm1yu8kuZyjtgMVfxf4nhdbJdjCliS2tT
         4DwSkFOC7cvX15qxwbVf47wt5kOdf/0CD+1D7bWZT1MaRVFiwSU0gdncsQlFnYVQOpMe
         z5W0uQ8Bn7SkQx8493g4e+yD/8dRS67i3gaBNkXPPdH6KUqA6lGou7yHWKvMzyZyFQ9R
         raIP/HJYLV5k8MDd6xgJ1AJFUtnMJ0R6jKKTZPwPVhcTjsNgcQ9UqAC5ivisNRYWGjds
         2PGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363751; x=1740968551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUQeyMIXkWewc+GJgkcRvcJST3TpV64E6KpD7DCbPAI=;
        b=bZizlq/Er9ZVbOymMeDpuH5j8tnSvbpt7mC0VpPAGU5zaVFWPLW4vBVHisaOpV7unV
         SnrNx/mFcQ8mAnTP5b4a4EeNedi9OALR+cKps6amd0ljZ3Vd4Dm4xjVQXjIIrwn0Cbg3
         g8iJ3bCvKwp9BAaRZVz2Mu+uliYuHGPQKVZKYs1AeX8tE4S/XSGVfbBl7/jY3MnxCHig
         XVHGY4Xc4Ndt27D5XvnJcaR5t3UHTpUp5pSR9XND5T+N9/8RzcJ07iFghuz5UjH/ol1i
         4nWvZIFdHfV+two8ySSRJTR9sYbDeUe7BCdtKQ+BBCNOUtQGG7gI66tqEYlEm058TYOp
         y3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8+3Ba0HmqP+iWrbGNfla/Ak2OlAHAaG8MtN4TLn2ql+HVQz4kjzZGV07e6HKRD+idnKszN+bpx3Kspdrbdtjk@vger.kernel.org, AJvYcCXFwXfMcCMKmUr3nQIKhIHOfdo8MsH1VV8FEOlxCxznceptTAzSaEVVYcZ6yjPBkEdcg8s=@vger.kernel.org, AJvYcCXt3yWa6vwKUXUyXLrxMP3vXI4CSszvB8dRiFOE8EiPxdi8eWuVuoeKhocC1OZ5mpmm2lRwbJwM2YPRpRmf@vger.kernel.org
X-Gm-Message-State: AOJu0YySxK9Y7QQ7ZIl3VC3FptffamKi/Qzb8FpWIUXKRgXlazol4/tl
	o6nw9DaBH0ySAbCAZpvahZpl0T7qrb3fndwzQ836sR/3vUWLcR2B
X-Gm-Gg: ASbGncuTELLDp4xxH1ePLry9Tl+edRvHiDgZYMJRQuOPGcOfuB0gw5QqjGGFeFRNSuI
	Dr/hx2FSLZKLxa8SBXSDS5VRACLrvgcsJUKQtiGDl8c1v1bc/357ESnJfpiyVB+uu7ecJ2sPZRe
	tdL5GIcJWq8E50McwdFzDF2Vt97Qd7Ub7wt+MnAfh0CTIIbNmkDME8vKb3Jfp4umImE7jDS5UwM
	vcqPQ+BhQe5Ff3nLb88xpZgdvjyEF7DuIBzDDEuz7koltJPxsDW42/9ZnGxjFdptkA1MPIr/aQD
	tJfCrmrAKOUV/fRO4A41MctoGYIUD/LLuh2M9QQ1cxxbEIstOKOydxnHpg9wtEns48GPSX4AjQP
	hqgZFfvZEee9u3/uC
X-Google-Smtp-Source: AGHT+IGhKtPOfbP0/vWC3oiyxINHUXqLzfQbfiT0IAYpiHTHPSjosaEHla0jWewE7AnvlRlUVCbdbw==
X-Received: by 2002:a05:6214:1c4c:b0:6e6:a60f:24cf with SMTP id 6a1803df08f44-6e6ae829f69mr127020026d6.19.1740363751540;
        Sun, 23 Feb 2025 18:22:31 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dcf86a7sm127798886d6.119.2025.02.23.18.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:31 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id BB41C1200043;
	Sun, 23 Feb 2025 21:22:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 23 Feb 2025 21:22:30 -0500
X-ME-Sender: <xms:5te7ZxAO4KtOT8NpreiDJ3cOrx6M-V9A-ROOQfgRykMpXPnBhtd4-Q>
    <xme:5te7Z_h4vpneM9twEaWHOGDqd7U9qKwSEyEL49wi97UBybOJP4mdOkiP1ZFhJ84yF
    kV18MIY3hsLISUsmg>
X-ME-Received: <xmr:5te7Z8mpyCKIfN9f3cVYee5buDmuqXi7gisscQFms4hspbOAauohzQTwRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrg
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
X-ME-Proxy: <xmx:5te7Z7xMKjDhpOywzjDKDCTYwUoLSbCgt8eHqedKZugYUQ5zrmMlNA>
    <xmx:5te7Z2RYh4RSFZO__XcB7noVyUAsgKlnjvI1gFW4HaDcTfVvF80jHQ>
    <xmx:5te7Z-YWIbx1OeZiM712O5WLbI0Wc2e9U3PsRat-FLPgvhLXZ6GlmA>
    <xmx:5te7Z3T1TtcW9VGcTLqRRUmsjOurIcIUrJfUgNJoWmiayYNZ7AgXJA>
    <xmx:5te7Z0CHxYQnklBUJaNq5_OVoth5KQP1dnV1ScGBTGbfxmYmXyE8dwE2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:29 -0500 (EST)
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
Subject: [PATCH rcu 09/20] srcu: Add SRCU_READ_FLAVOR_SLOWGP to flag need for synchronize_rcu()
Date: Sun, 23 Feb 2025 18:22:03 -0800
Message-Id: <20250224022214.12037-10-boqun.feng@gmail.com>
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

This commit switches from a direct test of SRCU_READ_FLAVOR_LITE to a new
SRCU_READ_FLAVOR_SLOWGP macro to check for substituting synchronize_rcu()
for smp_mb() in SRCU grace periods.  Right now, SRCU_READ_FLAVOR_SLOWGP
is exactly SRCU_READ_FLAVOR_LITE, but the addition of the _fast() flavor
of SRCU will change that.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcu.h  | 3 +++
 kernel/rcu/srcutree.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index ca00b9af7c23..505f5bdce444 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -49,6 +49,9 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
 #define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
 				SRCU_READ_FLAVOR_LITE) // All of the above.
+#define SRCU_READ_FLAVOR_SLOWGP	SRCU_READ_FLAVOR_LITE
+						// Flavors requiring synchronize_rcu()
+						// instead of smp_mb().
 
 #ifdef CONFIG_TINY_SRCU
 #include <linux/srcutiny.h>
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 121dd290cae1..8b5c50bc98e5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -449,7 +449,7 @@ static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, uns
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
 		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
-	if (mask & SRCU_READ_FLAVOR_LITE && !gp)
+	if (mask & SRCU_READ_FLAVOR_SLOWGP && !gp)
 		return false;
 	return sum == unlocks;
 }
@@ -487,7 +487,7 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	unsigned long unlocks;
 
 	unlocks = srcu_readers_unlock_idx(ssp, idx, &rdm);
-	did_gp = !!(rdm & SRCU_READ_FLAVOR_LITE);
+	did_gp = !!(rdm & SRCU_READ_FLAVOR_SLOWGP);
 
 	/*
 	 * Make sure that a lock is always counted if the corresponding
@@ -1205,7 +1205,7 @@ static bool srcu_should_expedite(struct srcu_struct *ssp)
 
 	check_init_srcu_struct(ssp);
 	/* If _lite() readers, don't do unsolicited expediting. */
-	if (this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE)
+	if (this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_SLOWGP)
 		return false;
 	/* If the local srcu_data structure has callbacks, not idle.  */
 	sdp = raw_cpu_ptr(ssp->sda);
-- 
2.39.5 (Apple Git-154)


