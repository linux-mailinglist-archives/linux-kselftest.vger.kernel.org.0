Return-Path: <linux-kselftest+bounces-27315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE6DA41379
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C392D188B3AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EB7242901;
	Mon, 24 Feb 2025 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuecK9Wz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F1241682;
	Mon, 24 Feb 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363768; cv=none; b=CTrwMJld4nTA6/aHxbUvcoqhy7cMgEg9RKhcPhAbfUrkuIwmskktl5hXzGnRUh5Z47cp7Iy85ikRUsluHIVq9Aj3wWHdMCGJOq2GdPhfR/Jp6PxifyNmcZzVLjJsE+okygybmRGVWpiMfrTcFwmy2MoA9h+N2gIV0TcaGVSLBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363768; c=relaxed/simple;
	bh=aBreVKJt9M2Mo1GiqPEfTdZ2p2QA3tyIinn8cNmB6YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pcTlLe8mF2eA4vD2skjC0r6B+CEwzxJWUFDohGJQ+dQdLoOBpiao8TTpEvTdNgnNys3pNnE4zl4VKdSDrA9pVxUJxVJmuhOHUTTIZE2qp7mDmQFqF3U01H1IId+RtSWMleSkAAHJPK6Raf8ZJSR5PDp48OREArSr5BUDAhUeanQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuecK9Wz; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd0d09215aso27612806d6.2;
        Sun, 23 Feb 2025 18:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363765; x=1740968565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6iNUHb0+00l4f0ZTUqicqdX9tAj3JGSCI33HuVMMHHs=;
        b=ZuecK9WzL86Xk164a3yDwSXpHV9oDwIlsGxNW2lWuqCrHf/DuVq03yeTyQWcpl8VSz
         kx/aTzcMTkyT+As/kde8OykVlm8+R7+7haMnG0fsmcu/+uWa855GiMTlqsI+x0AfAZrW
         6FDFrsvdS2pKxAOwNAh1gncYJTK6GJy7bUXquZggbRh4B6AyCYF01zhMElgZMj/q05h6
         q6RhfQgdVwyLeV6u1aCARMZbKeTf0jq7AYUaFXgUMDNMR4uVRQbOXGj5KcS58JxOogbg
         SVK3SqNhb5RmY4f3G2WFCLHo6qNo6tCFo5s52+c+pOvBNn7TSYkC7B3v4AX71jqKp+P+
         m1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363765; x=1740968565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iNUHb0+00l4f0ZTUqicqdX9tAj3JGSCI33HuVMMHHs=;
        b=J8r89a4jJH2lzcs0UKfgUV6quiZWAgxDt4q/drbpMvnNuSGWIzJX+iNe0nriXKckPd
         rY85ZFg7nR0p/slG2MK+wbe1/q+A+3ACW0F5IMPX9nsRKsDYCdLWRBPQs2u+AJsL4oK8
         iqGAUywrhcP5rDdhacwMr31hSu4q4SMb2djBrMZufSoWiQW6XfZdXB6J7duopOCqhzeh
         Yfr/YW8b4JQRC0oC3RJL7yx/jHv7Pl4+zBnIkeBJPSe+QNNbCO3qCzBbwTUuQDzrgYdu
         dy8sfCyfGTbvpC47Z9Yz9zW5UbXe2JajzCLBOYuvJiJCB/QElElKxcv/06IPgeypJhBV
         neNg==
X-Forwarded-Encrypted: i=1; AJvYcCU309EVXTrRaBt8O861RE4bNxL24LAIfDj/0VH2Egm/BWc8bhrDNwJTM1tHn786GOJm7jVb8dvoace1tCDjimbI@vger.kernel.org, AJvYcCWSw3RtKyMCwCJG/DPoJCEADd7PpELSCyTN5j3mIup8pn46MxZ8laV8DJG1WPW0sVOE3fc=@vger.kernel.org, AJvYcCX9I6uH7mGvxf17t+DWkBkvpbphR52XfObmDKiaPJK/++vOi678WPdLTgcCRsauUCvK+QFGAbAr7skDQHsK@vger.kernel.org
X-Gm-Message-State: AOJu0YxokuSubP1BO3C62Yujlr66JQGMe/LfHkV3/HLwHIEBmRB4uxSP
	P27bnbNWGh/WrBn0VEwaoaa7+kkqAocjwXX78E/COPFeATbSR76b
X-Gm-Gg: ASbGnctpCoPQF3OCnLRQjmDPKLwnjVy/YvmPjPEpRVp2eC1+J4dK9p585VWTrq8hvbZ
	9ufkGFFH8HLFRIirslnE9BeaaeVTyViA5DwE0R2n9TczLRRVwVxB7KlaIm2uxdHI/jelBSK+umJ
	WBdcdQX8/eMEm9/dmbHCvNJtwHuyZiC1Kgy/mp1PWmocwD9i5M8ueoWRkoaNdgob7yZqt5v5LjV
	0a7BbYeZ4RAYU5fN06jsxi5/Xv9tQqr5MDpHI/bna8T3MhxInbTTT+NDd2VzDqZ32dnjgGFkYNq
	1DP8DcNMRpsmHOQ89HIMkYEe2bNla/1U57ZKrnA/oEgfEd3J5y6r6wla0TvaxWlLupdlawDIaH4
	RWMytRfJyuHUJ6CGn
X-Google-Smtp-Source: AGHT+IFGnIWRDDkB+R8MV7hu1vyojxOiEmgcPh7SpQHpo6uSxFjLJ1i7br7f+Plyna8lLf0sf8pNkg==
X-Received: by 2002:a05:6214:21e9:b0:6e6:5aa2:4e4f with SMTP id 6a1803df08f44-6e6b01a9dcemr175224056d6.32.1740363765483;
        Sun, 23 Feb 2025 18:22:45 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e6ac353309sm43626336d6.12.2025.02.23.18.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:45 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9A6DE1200043;
	Sun, 23 Feb 2025 21:22:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 23 Feb 2025 21:22:44 -0500
X-ME-Sender: <xms:9Ne7ZxwuXsU5qVHZoT47-tpEmpVBHUXhv3tFxJIPLJ_aXjQz9xYbig>
    <xme:9Ne7ZxTmTLhThZ4yelRSMOfj2Lnp3PPML744Kak98Z-z4DDN0tBuEz0wJ5dSK-Rgd
    X3ro7RRICDEhml0dA>
X-ME-Received: <xmr:9Ne7Z7VGRPno6qmNglpl3poKqMUrZMtCA7kYJHR8a55sL6ql4LIucPD37w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
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
X-ME-Proxy: <xmx:9Ne7ZzglWOMsohd7t0n83bEKwGorKOROLjceU52OX3CcTWJYr7UYrQ>
    <xmx:9Ne7ZzDt2xli0goIdn4N-gBhSAbZ32NieFZLwt9wocSMNlW3UKzMvw>
    <xmx:9Ne7Z8K542JSOiu_wO5VDR-pdEwQSZPZxAerZCmRuBOG12I_N-XVEw>
    <xmx:9Ne7ZyD1T6HkmkXnQ6k4aOLhYRjD9nchhWK167fc5jJfw0vl8v5Xug>
    <xmx:9Ne7Z3zrdkeMbdbQobOoL9ThMtPFM1YZMrpFTtBZCywFhtW9QBkJ6soi>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:44 -0500 (EST)
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
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH rcu 19/20] srcu: Add srcu_down_read_fast() and srcu_up_read_fast()
Date: Sun, 23 Feb 2025 18:22:13 -0800
Message-Id: <20250224022214.12037-20-boqun.feng@gmail.com>
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

A pair of matching srcu_read_lock_fast() and srcu_read_unlock_fast()
invocations must take place within the same context, for example, within
the same task.  Otherwise, lockdep complains, as is the right thing to
do for most use cases.

However, there are use cases involving tracing (for example, uretprobes)
in which an SRCU reader needs to begin in one task and end in a
timer handler, which might interrupt some other task.  This commit
therefore supplies the semaphore-like srcu_down_read_fast() and
srcu_up_read_fast() functions, which act like srcu_read_lock_fast() and
srcu_read_unlock_fast(), but permitting srcu_up_read_fast() to be invoked
in a different context than was the matching srcu_down_read_fast().

Neither srcu_down_read_fast() nor srcu_up_read_fast() may be invoked
from an NMI handler.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcu.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 317eab82a5f0..900b0d5c05f5 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -281,6 +281,24 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 	return retval;
 }
 
+/**
+ * srcu_down_read_fast - register a new reader for an SRCU-protected structure.
+ * @ssp: srcu_struct in which to register the new reader.
+ *
+ * Enter a semaphore-like SRCU read-side critical section, but for
+ * a light-weight smp_mb()-free reader.  See srcu_read_lock_fast() and
+ * srcu_down_read() for more information.
+ *
+ * The same srcu_struct may be used concurrently by srcu_down_read_fast()
+ * and srcu_read_lock_fast().
+ */
+static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires(ssp)
+{
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	return __srcu_read_lock_fast(ssp);
+}
+
 /**
  * srcu_read_lock_lite - register a new reader for an SRCU-protected structure.
  * @ssp: srcu_struct in which to register the new reader.
@@ -400,6 +418,22 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
 	__srcu_read_unlock_fast(ssp, scp);
 }
 
+/**
+ * srcu_up_read_fast - unregister a old reader from an SRCU-protected structure.
+ * @ssp: srcu_struct in which to unregister the old reader.
+ * @scp: return value from corresponding srcu_read_lock_fast().
+ *
+ * Exit an SRCU read-side critical section, but not necessarily from
+ * the same context as the maching srcu_down_read_fast().
+ */
+static inline void srcu_up_read_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+	__releases(ssp)
+{
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
+	__srcu_read_unlock_fast(ssp, scp);
+}
+
 /**
  * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
-- 
2.39.5 (Apple Git-154)


