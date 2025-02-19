Return-Path: <linux-kselftest+bounces-26996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B55CA3C3F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FBA3A9597
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0920E004;
	Wed, 19 Feb 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktjY2zhE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2720CCC3;
	Wed, 19 Feb 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979601; cv=none; b=gQzxIbBfhRiij7PeCpQS32liZhlstSvhgu1DHD9REvqNcCsnz5ZpInnEb5aVBPqnzyC1QpYdxwMu+OrM+9t3aP4hdscqtCpjmpQFF8MeyNlxkgoqBuKd1yt24jNJGEY3nZZg86wmmqS6cHC7jSUi5nhHK4xaEO9bZ/u+5c/ALPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979601; c=relaxed/simple;
	bh=Sxbh7eyLhcLoR0do4P0OJfKFlD3IeVj7tyXLSdMhHaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQF15gGRq4E/H6EBBoDv/7fLTMubt/Rie4ASnIMnz+iKg+YHsGbXjPpWfFU5TCELGIsjSrgXYbUNItU1pKii2ofQdggnKJuXMVjgdoo4gGjviEIXWI0zVaN3NZD4mhM2SCIG0Ur8S4emmVbaNBdOwN1FHgv/PxNEqT74hDneTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktjY2zhE; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-471ede4b8e5so17780681cf.2;
        Wed, 19 Feb 2025 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979598; x=1740584398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DXUUfkV9OQ+11WK+rSlNV17A2B0TJ7HDdrMLEvcLdnU=;
        b=ktjY2zhE4h9Ls1bCpc/lDAGQWVTvBsN8OlwuBJAEJh2FoaM1gYA2f2ndStWnm1/MRw
         ckgTU27GK2di+6JmuX5y9wtrrOeJy9wGsl8gH94CJNOh7/tw7vCNf0CKGZp8HIuzPPbI
         LeAxxJ/iITXRILUD4FlDrMV8bXbdr4/bJSYwTpnCZ+T0I2jc9BpmWNDHRIb+HKvVouZQ
         6+3D1pXTEhPfYsANafUuVhyr10fopPUsoanD8h20T8WK7AUsIGfeZap4cIIui9OzBK6I
         PsFeHyvZZ1uiNUk4XIYEO9OiderjJ0ZU9KDrx/0vseK9BhG7BKA+vike8iRNJLD+zrLL
         lgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979598; x=1740584398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXUUfkV9OQ+11WK+rSlNV17A2B0TJ7HDdrMLEvcLdnU=;
        b=lDrInSVywxXUheYawUPBK7tPZuiMsYdP1W5xz9xggqqRCjkvM0/HJHvFOdcjMH1kRd
         JuMYQ14OMgelsPRtG2vNw+2nyvrcaT6Gx79lTLy2biNlkWG9FFHr6RqUtF+Gg5FL+Z3M
         9UmevSOOGpIz7LYYZnIic08qZZwQCNcZjFhFgUT2xtzdTC+hzqazXw5kkUjf+MtdURmY
         5REB4ch6paVsFhnRnGVkP1Shxi6zwOKmx8eIehnZSw/RwMQpPEm1LSld6sZ+iRbpvBM3
         PxTiuM5k1Lz256x48IFMmKGH/Z+MMNeJ1eexdXYOyxdeHxDww/2uvIeOwcpXXEaCHjJ8
         t/hA==
X-Forwarded-Encrypted: i=1; AJvYcCUGrGMn4wWIPUJDtDb6aWQ7gIgSMEybE5c2FMYTuCezXUkJZseE/LNdltBqOfYm0fzNSD1hCY8PdXGqwEvuOrBY@vger.kernel.org, AJvYcCUIW7ug10SDaXiOyVq+k/2sjivLbiZe5cUzwn5pxxxGndf1GaPhZSiX7DusjGisWTeZjX8fau2Vx5/jz9ud@vger.kernel.org, AJvYcCV4qzKxqIXQQqefCSuffitpv/lo0hrkzKh8UgPopd2lTQs0pMlPK4BqTMVskwk1wzdmBslJrjnPfaA=@vger.kernel.org, AJvYcCX/imZFjIE0DdxmlLm3LdfpKE3r74Yb56LG6/+JIq2NdLBg6xdAqRiMJDYFlAkjvKQVLwZKp5zoiBqdIOMYEIn9/zXV@vger.kernel.org
X-Gm-Message-State: AOJu0YzCT5JzKnwcjiQaTXBitvijnMiF+unkXC2OmNv2a5mDTZ4EPj4v
	oQXeK44wbHHEBo5vQT+c0JrCWZgl7DB2T3Y94pMQKtRNX1zw1UsR
X-Gm-Gg: ASbGncv19FxFMd/ManjPIyaIyFI0aTxb/2HiyciOmIr+zQ3P8X5BUYrWjQcnvyqq4BY
	m2cl+1txndoa2crKhY43Dgm46VubdZiW0I9XTS/+YE5gLDe9w5BwUMJJ+aKB6oxrOakRF9cg5sr
	dbCcoekLV1OCNlGOuOjzHJolT641tr07pySSiq+kHl9UQrB0TTZA9yVSLumlWKISnPlGjeoEA8s
	tpACkjnfDrmabMj8M4aepwr9QH0+szcUf+5hA+b/u7bAFZf/afO1RbG12ZfuMd7Qy/5yTQV3U8J
	prn3DUcCxDWspnPFe2bRwm4Uu3k+MSM3NKDReNtJrFEE4+nrMS62h4HDfrN2yUghHFn7SRqsuih
	Md2o9PQ==
X-Google-Smtp-Source: AGHT+IEKVGX1xe4HQTxqbHjyHiTEUAiHRxEucuEWlFLTF3zsPBgPXOjlAW6jCHbtS39NSIH0H2tY4w==
X-Received: by 2002:a05:622a:14a:b0:471:d14e:ed28 with SMTP id d75a77b69052e-4720825eb5bmr58844001cf.4.1739979598048;
        Wed, 19 Feb 2025 07:39:58 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f52e39c7sm29970201cf.3.2025.02.19.07.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:39:57 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id DBDE41200043;
	Wed, 19 Feb 2025 10:39:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 10:39:56 -0500
X-ME-Sender: <xms:TPu1Z66jgsnmpdOC1p1bvuyu_BatDvgQyeNW7xKbQ1zqN_XPt1-VFg>
    <xme:TPu1Zz4hDDz3I7Sqx9i6hYLjklTTWLELAvhjb9EaKpksAT_7tiUat2XYz1VrjjfOa
    wV7FkCmWefvzcIJWw>
X-ME-Received: <xmr:TPu1Z5czkNfOksGFLgHAB6L3nSmoxUh54mc3HHgjWqeK5SlhxwaRHJs1FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrg
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
X-ME-Proxy: <xmx:TPu1Z3IN1xyKGlgSzGlVmkGCp9rtOdJ2sTBCxBwwGtOIVQXUMgp-1A>
    <xmx:TPu1Z-LpAPvFDJEGvWPbEXQPmj491w-RMlYMYJ9WbFQG2_fYucv_LA>
    <xmx:TPu1Z4w9w8qc1RIwtG5dAVDrLRJ1a5L8Qe84dBypLWQLYbZTZ6D63w>
    <xmx:TPu1ZyKOGlYcqEbsuqI11FlTPD29mc2QpuwiOmzZfH8AfEbQLU7YOg>
    <xmx:TPu1Z1bdCRHwAQw40TemGHj_mwsm0ZEOXA1Z75buO18dRI1OGL5Pez2z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:56 -0500 (EST)
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
Subject: [PATCH rcu 09/11] rcutorture: Complain when invalid SRCU reader_flavor is specified
Date: Wed, 19 Feb 2025 07:39:36 -0800
Message-Id: <20250219153938.24966-10-boqun.feng@gmail.com>
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

Currently, rcutorture ignores reader_flavor bits that are not in the
SRCU_READ_FLAVOR_ALL bitmask, which could confuse rcutorture users into
believing buggy patches had been fully tested.  This commit therefore
produces a splat in this case.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9c9a349b9c7f..be4e3c6b912f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -689,6 +689,8 @@ static int srcu_torture_read_lock(void)
 	int idx;
 	int ret = 0;
 
+	WARN_ON_ONCE(reader_flavor & ~SRCU_READ_FLAVOR_ALL);
+
 	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL)) {
 		idx = srcu_read_lock(srcu_ctlp);
 		WARN_ON_ONCE(idx & ~0x1);
-- 
2.39.5 (Apple Git-154)


