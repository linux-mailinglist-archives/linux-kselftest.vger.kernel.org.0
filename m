Return-Path: <linux-kselftest+bounces-26998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB754A3C3FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD9E3B6F5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F423211A38;
	Wed, 19 Feb 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWRBiEiG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5820FA98;
	Wed, 19 Feb 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979604; cv=none; b=QdcIKM0TmpJJxfO/uXdpJUgd0uVIK/jdzqUBGpbaZz+DoGYE3vYdYfCHzuA+UnzhYgcAqB+9SSx9bLda682xClDRthec9ESw8MVWeUAFKjmqSwwpodx5YmIWlfyiEOQQujXjsKMv89G50i6D06JwLrCUKKpHmT78OSHPd/J8wlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979604; c=relaxed/simple;
	bh=D4UAwGRV/rLGXDfFkq1T0zDIPu8VapGkWiAaTWgA+wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lag333xMu1HpUvEF6vXRkG881JJxYYh0/lPgWttASMJNmj7J3cfkMYei32V/lVN7BoeEVxLE9GGpV9XC9+985GzI56Oo/dxFMWR96tQw15IwgXUpjR1EHHMkEH8cvQNrKzcwpnYMXCG1KqAgPqPR40beTAUxeIjuZyqUggkiQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWRBiEiG; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e65e0a3f7eso30644656d6.0;
        Wed, 19 Feb 2025 07:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979601; x=1740584401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g49jKhUh2JPVCZHODS61I1a/EiyeOU7HVFqD+UrZfhs=;
        b=MWRBiEiGyhXfTs/Gd5F1c+SgB3OscvNAAdh1A8LU3AOyTJfhAXlNwbEWEoL7tw4lnN
         W/YE+XiEV+kje4PaDFDKs/8qq0TMyd9ofgC/jbA4qByqs+3C/5TTfX/9EkyDOBsL4tvy
         /8IrCD5YX8+Ka1TTyI0O20VVlrDqUhML3Kx7eMoJyduFu0O5OcKEnesiqiGvSbi33fVY
         GXHB3JXwtyRYwzHC+vEWr0oEBFinp2mAWS9k+pwGxTth94eN6xp7g1Oja/JAMeZISy3Y
         JsNpCYE14ld87i6M8C7h8qqyNKebXWdJXZNh8TmesMaNkQN1WSA68Lk0LZefJZI1978l
         ZghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979601; x=1740584401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g49jKhUh2JPVCZHODS61I1a/EiyeOU7HVFqD+UrZfhs=;
        b=EWw9GV2nUO922c5Wi82L58Ao9RztQW81v6BuQzA4JJHtVyoOVLfmcfUzelgwiIbKun
         QH+C/85xXFmjlvk2gyUWsm869exGre8Yu3OECvbFyGBJtaN/UGqCJKHg7/y2fsyCmv67
         OTeowqR0VtQlXWdUTh2sIgr7te5sQCGng0F0JIDEe0P6UWEr+e0R9y6NYJ/YMvuMMDwj
         m9hEqmD96mPCYtmjDCmzR6IZxuDHhB1Y4qZEhEfr7JnrP3H0QjsZ974pX30Vo320VGbb
         njR81WoKb1BT7aw9BPWwfv812QaVeCiYSQhl4sQ+dPNa07bgczGTmyYeNql2m5pRN8He
         As+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2LnrF5ax5aW5eTviqGPxKyfFqwwgyIkNDXzQplwW1rNmNx4aUl9sALi8QA7SnzZSMa8jVTs/6UjOdedvv@vger.kernel.org, AJvYcCVYO/UBxwBc9q1M5HUGtK5k/Puu1c/NJkwDMJUW5WIF8vg2iw+Ns1YW1qohsrkQtHpdZCHqsfVAuUd6jv8mNuVn@vger.kernel.org, AJvYcCW4WnbWdayRlLAeABE05BSzuiAQ+sEsacXMtM1+4KK4nzsl2ns2tLClxPdDqTCskOmMnYUSmli2UE2Mk/bUTBjN4j1q@vger.kernel.org, AJvYcCXMz7vuuYeYeS+aor8GRipOJQttEEP+fqnLTQ165w26ZMYE9mzB8mABhiznMZc4O/JlIhTbfwsQ5E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQv/cKXkVQDE9Wc+qWflDL78PJuEuWih9RJvJkRrJ/JQEu0mU
	M10eLIkQmdLlgDHo4kJ/Hj22p1bC6XfC6guvlQWB38ZUUA3hlFIP
X-Gm-Gg: ASbGncs07XcGHIHtIe1O3IJRux8WLth8YsFV/dhuEiLIi9nX+Kp/oAyWAm0Vq+EH84c
	nb40oUO2AmLUkwZoifM+sIt/vmL33u1zlhn+COS/89+jDF+nLUOnjvuLlRZpWQHuhI7lcpfVpJl
	l9WqZlSe4GpxoZWsT2DOGoSGpDp9eoWHkIeloseJ/QbM/VPhrJ00oHKvDqjddUFUnmiBlEPJpc+
	A99WkW0QW6MVhoZjSS4r1BLgrYEyBjIXI2AVpMOArsyWFmC9bx8byt5qPR130aAT0rZxsYWvNU4
	e7QTadt/r6v4wa2bucSuLlsOqyD/EI8GWKEbfN2VR6NwJtb/r0Mw9AHsjFTq474KZGO4bv+Fylf
	W8J7cJg==
X-Google-Smtp-Source: AGHT+IGKJnxieMFJEOFo52+HKtndsK/DmeEtF5DMpKHp0PX0Qx4rfm4qgOAj21WgLMdNp0LJ8LEQ9Q==
X-Received: by 2002:a05:6214:2269:b0:6e1:c77d:db8f with SMTP id 6a1803df08f44-6e6975bd12emr39188566d6.41.1739979601245;
        Wed, 19 Feb 2025 07:40:01 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65db006efsm75685036d6.106.2025.02.19.07.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:40:00 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3BB3D1200043;
	Wed, 19 Feb 2025 10:40:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 19 Feb 2025 10:40:00 -0500
X-ME-Sender: <xms:UPu1Z4Bgds8MS1CsvwiLohDGxCbtEdSZaXLk82JU37ySC5Dh23-Hdg>
    <xme:UPu1Z6gyEO7wEhz7d03gg8-b8ZeNs-RgUlBhib_TwuHRo1uD7AgYbLPm-gy_uEEcg
    KoZFVOHckcRYXBV3Q>
X-ME-Received: <xmr:UPu1Z7nZqEQpxVlr84n_2L12NI3MQRdaVMKGsgvnY5W2BKo84z1dQvDCVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeifecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:UPu1Z-xV8FgEmKEiasXTlUS3hk1hwzWYD6Sg132_ppXtxrCK9LjGtA>
    <xmx:UPu1Z9RhWuVBNTe613lQ7B2Bcv2EJ2atcgWX-cPFTnYz8X8DR8je4A>
    <xmx:UPu1Z5a7tmOh9zbTnwiBalQIMrObEOeVj_tPNSzxGOQSWTsE0wEYtQ>
    <xmx:UPu1Z2Q0PBZEcPssFUO0_dwRaKsfljt9GXGmvMD73jV8TgKSCTbpNw>
    <xmx:UPu1Z3DzlJtoFBgWff_WDOM_lRbEipBOgrukwxdGv8JyJ53wygCKQRNt>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:59 -0500 (EST)
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
Subject: [PATCH rcu 11/11] torture: Make SRCU lockdep testing use srcu_read_lock_nmisafe()
Date: Wed, 19 Feb 2025 07:39:38 -0800
Message-Id: <20250219153938.24966-12-boqun.feng@gmail.com>
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

Recent experience shows that the srcu_read_lock_nmisafe() and
srcu_read_unlock_nmisafe() functions are not sufficiently tested.
This commit therefore causes the torture.sh script's SRCU lockdep testing
to use these two functions.  This will cause these two functions to
be regularly tested by several developers (myself included) who use
torture.sh as an RCU acceptance test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 2e63ef009d59..2db12c5cad9c 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -49,7 +49,7 @@ do
 		do
 			err=
 			val=$((d*1000+t*10+c))
-			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --bootargs "rcutorture.test_srcu_lockdep=$val" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
+			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" --bootargs "rcutorture.test_srcu_lockdep=$val rcutorture.reader_flavor=0x2" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
 			ret=$?
 			mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
 			if test "$d" -ne 0 && test "$ret" -eq 0
-- 
2.39.5 (Apple Git-154)


