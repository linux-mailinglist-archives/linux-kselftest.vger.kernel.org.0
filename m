Return-Path: <linux-kselftest+bounces-27312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6235AA4136D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4263188AABA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18D023A996;
	Mon, 24 Feb 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UheFGIen"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566A32066F2;
	Mon, 24 Feb 2025 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363763; cv=none; b=GAw6Wu93R14ZZuL2b4iV0hKWHlbpT1vCCSfg08+Kfc9rdt1WnCTI5mUX1dxTH+IJs8ympySLXC1N5j0puOhs4LxxjwOgA3399IX2TlejHSylmMmDKA748QF6nYWjqKBdGF70wEmA/LTIvXKziLBKDv0yZ3EOjzP3dTcI1wbJ6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363763; c=relaxed/simple;
	bh=kAUdkuuHIe0hHKVg4sC/0Qh5Fb6pN442dDVYb1BISTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1gDYd4f7mNNFdU/KH0zWXN99Z66Ac5Zv3oLqY8ZGXaoBRqZiC6tYawpzbSHwLM0Kovunq4DL+XWSr/pocuglPpsKFUuULraPiiq0JyKgW2uYrkPiXt8dA8MyIGniRuPuRS9rPs9omh/cQzmBWJqloHXDgHL2/o3VuTRA/6VpVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UheFGIen; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0ade6036aso492449185a.0;
        Sun, 23 Feb 2025 18:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363761; x=1740968561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HoXXo7te2qdCoqRU2DAsTQhDKL9OLvKsbtcGFLuSrXc=;
        b=UheFGIenFPdOK3I3vZbk7qW684gRr4c72LvY3IBr+Ob+BwejHRuFSgACYSvYru7o8G
         AhAsbmkd0uZHfFLyOpJNRO1ZwIgBEq9tF1WctxAJgZuHmDQe3hh4Fj6gmp8ih22K0MJx
         FaRFRRRCbh+01+Gth/+DzB1GL15L93UdmtXu2anPQdP4mS2xj5A00eWppFuWlKRuuqum
         Fz6xh/3UtE7/Ii07EXftNW0qEvBVN/Yyv2Wkyzw8IxswpQAwGe5lK+aoAqwgvTeJbps9
         2CtCDt7PuHFCHPeWnVkcMAY26YCfGSBPZuEMccjgMQQykF6ubdjh9a00DhCvoQkTlJPR
         yY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363761; x=1740968561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HoXXo7te2qdCoqRU2DAsTQhDKL9OLvKsbtcGFLuSrXc=;
        b=OOiRb9VxLk/Sl45uyYK1vGrYZX2hmkRuKW2REauAD6mSn7QfKPlHkLTHvkhfHev2vE
         jerxJ3lWHAVdCTB47tKU/mL27cJPibRRcxhDaMJDCrmnD7xDTK6SOnF99A8ACaRkdxDp
         D16Ech6aXysrKjHI/ynOFht1xgIgJ+Vvpf0sV5CXeN1By+afYr8IbaTNkI8/bDkUaJmb
         PioIt8qA15YoB7lymsXUmXI4bZYYb0ZgppNtmALYcvisdqV+awqVUVH77cwIOhancSMM
         qDnenmac+kw8yb2TGu1mw4ZkrxIMzowOVpYIsxfzNtwnIovz4P7cTWn1uD5EUreN1iJe
         RYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9j8HQCrArVAJmxwHAhIRsc34Dhxl3YT1EhQpzHznDTPYRh3e6BXYHqURsx9u2a1I8MNI=@vger.kernel.org, AJvYcCX2iCRegL8FV/NH5OpxK+wuvwnh7bjgTjoPWc4ipyTBm1EjIhtxB7vji0uJHslQwxWrnA0a5RAnOFMxy8de2Vlp@vger.kernel.org, AJvYcCXZjdV0aKsYfvFIQVdn0VwacPZvpjvhammA6ocpETxPA3qtKwvQijQNZP4pOYUfoOr9P3VToJe94CIP1LO/@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVItVtFvl+pv12tHp4U5xL/I4rr9eEkJGqMq0rKOq4Baei1m7
	Gnbjt4sNZEVbLkIAec2Rekbgrqn2P7rMbbi9bmteALH4dZ/IBFdq
X-Gm-Gg: ASbGncvtcprgay+9DY4IwvYc2xsrQhReVwCYSnqJ58reZlVSzQt8ob1EDgwhGXd+GcO
	JvqLIRte4iHPozauSABDvEO1Maz4XigS5WObvd3eDmxrORMC3ckCLSXHlJ9pvr1fmTcMJXNISSv
	UTTE6G4ObP3REPQNVgCr9h8kY1s/peYOVoQu7LlhFh34wDW5RrZ13IqBuymcPTNYP37E9xXTykd
	8upkcfkrYKxklWKXqZRcwTGaDrWG2HExGM9pLVhSolOfFUXOi1wdmn/kSJGlJ1r6XWeEY08fbJj
	4z8gVljCtCLIOz3Z8uPiw/x+xtBXR28c9Qj95uawOCznILp3vH74ge3H+to593V9fXOfjGwMY5N
	62nEpTHZILGw27AJR
X-Google-Smtp-Source: AGHT+IEZNGEvL+X6WQsjqqBoVy8Xl/SkDXAOELoRPMIY4g9ibmVObQC07YvQ0QLcC5b11t6JdM6nkw==
X-Received: by 2002:a05:6214:d07:b0:6e6:69e4:825e with SMTP id 6a1803df08f44-6e6ae8f3b6cmr123259076d6.21.1740363761352;
        Sun, 23 Feb 2025 18:22:41 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e69c93e8d0sm56723336d6.108.2025.02.23.18.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:41 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 880FF1200043;
	Sun, 23 Feb 2025 21:22:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 23 Feb 2025 21:22:40 -0500
X-ME-Sender: <xms:8Ne7ZxvlAgyYOlvX1AhK6yKcK35dY-W-NhffNMDz1RqxRf4tUziSxA>
    <xme:8Ne7Z6fq653j0rPdxkmZr7btrbQICBjp9xTu2UzA_g34OvPmSNkx_7wBJvPOYZs8O
    Z8tBTIXaELj8evFEw>
X-ME-Received: <xmr:8Ne7Z0xLmU2-qtPILFx2LEZWwxmezKeCcVaQ9Edaie34bdA8GenZZYBHHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedujedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomhdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhshh
    esjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtoheprhhoshhtvgguthesghho
    ohgumhhishdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:8Ne7Z4PD3lqLkN_ymwm-6z9xZ64tXBqhbLin9603liDIMnADNurAdw>
    <xmx:8Ne7Zx-1iOdmEbdK7sz_iMN16Wafw6YL7_OrvZrg9Hjxc8onDSMBdg>
    <xmx:8Ne7Z4WUacM1Tis_KnIJY4oTORYRqgEWfpC_3EOQLzhuAM81UcG9yw>
    <xmx:8Ne7ZydMncLhZoJbpESavwsL1HV7tT-7IXKSp9NWNK8mSCqBPMa7ng>
    <xmx:8Ne7Z3dDCT5Zi7EHtzy2Kn4dzEgERlQ7Dgss92YCgLRsbXHwwhNYfmAk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:40 -0500 (EST)
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
	bpf@vger.kernel.org
Subject: [PATCH rcu 16/20] rcutorture:  Make scenario SRCU-P use srcu_read_lock_fast()
Date: Sun, 23 Feb 2025 18:22:10 -0800
Message-Id: <20250224022214.12037-17-boqun.feng@gmail.com>
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

This commit causes the rcutorture SRCU-P scenario use the
srcu_read_lock_fast() and srcu_read_unlock_fast() functions.  This will
cause these two functions to be regularly tested by several developers
(myself included), for example, those who use torture.sh as an RCU
acceptance test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
index 2db39f298d18..fb61703690cb 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
@@ -2,3 +2,4 @@ rcutorture.torture_type=srcud
 rcupdate.rcu_self_test=1
 rcutorture.fwd_progress=3
 srcutree.big_cpu_lim=5
+rcutorture.reader_flavor=0x8
-- 
2.39.5 (Apple Git-154)


