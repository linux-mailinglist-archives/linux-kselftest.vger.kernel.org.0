Return-Path: <linux-kselftest+bounces-27313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D751FA4137A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16257165438
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77783241666;
	Mon, 24 Feb 2025 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzX2nhIX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65C227E86;
	Mon, 24 Feb 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363765; cv=none; b=lqgwVNoW/2G1mKc1b5gTou5DfHVUinQMBFR/t0CYOtqPOgNGC/DpjJKoB1PKhXyID2uqXOAdg/1NGqj25cLn29+yu/ZcpaKDzWZme5eZaMGFPaMk6RPYmLupgB4XnLrrVh8OU4OyfZ9GkAmjMB2iQ7Q/zN36KacvBIDpaVCuGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363765; c=relaxed/simple;
	bh=ivvgjhZ1dzBCvoS8KY01scRvocfceY53UhjRI5+E+TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uy/IXe0CCL2PCJy3XE1idjKoBu6cdXIn6p2b0lDSOU1LxpNvECUsBDQykzHxfZWb4z/+5lIrWJVRAbtbAiHi/RWaC6FraNKhQMrR3pYDIcUebtWyIVTyk3J8u/JN8cTil8kBjS09tQNqBsI2i4NAz/xT0kQ6JwkM2NrcgEq6XD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzX2nhIX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e6719e6e82so33524416d6.2;
        Sun, 23 Feb 2025 18:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363762; x=1740968562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uQqtypxCvU6d0bgYV6SXXcCNS5AjtvZwsSrkwgJ8kLo=;
        b=gzX2nhIXn2Nh/pvLdN7wqbfvqepU62uD6KT30JplemCP+GjqNNfSMEJjT1Cw9xz8x6
         S6yPmQIoFgX5IubmwI2qeXz+7KqyG9sQh4aY6aPLNm5uNkyiF7JzjsCVZ/a7/wkOhA5H
         qWpQre8vhwzQCNxgUF1OryljqFu9AXzY+pdGXSCWn9o5NuxnaYvLBjhcNRInuTVKW8aL
         u48EECMPjdR7EJunyKE7yjTu6eDoSydBTOBhIuVgxq/JoIpo/jU5uyNc0ZEi9dzVQLMy
         dl2rv8B6z2hNj2pGBWVsOQWQjO++HolSgz3520fTNWsVwyysoo9Ij2vhmEFkmIp4tVnC
         9uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363762; x=1740968562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQqtypxCvU6d0bgYV6SXXcCNS5AjtvZwsSrkwgJ8kLo=;
        b=ILR7KxqHskMKZJ3LATsegRIpDmr1s0+6BArqBC5BE80lp7EPi4q1KlkSS8YvlqC42k
         9rdU841fiFDGCRfoW4+sKdSRbI25j1EE8pMNEb4P2OWjuKljxhzwf6k7wpFN6RloBMtT
         YEb93XPGb/H+F7zuZsohwQKCJEthK2CGW7CuHZTgDfBLlviCfk//qx3zWvokXzEg2qDg
         NZHkhI9jqP8wX27o7yJPwoZMgRpy9bY6DnHHGE6S1qPLwIMDKLYqBobnP6mhmO3uhXzK
         t1jao8pZAM+QVnJWt7ttrpCQnO5wxEFuy5XvEx0zn8pCp2fiRCRvgx1slFw9ixH/Nrvy
         5huw==
X-Forwarded-Encrypted: i=1; AJvYcCVevp1S8jRgvzPTJQyQHHt+lOvLc+abC5W62jw/Gb+R7impZ3eXGpLIth/L/RhuyIUf1W4TRGcumIyabKcusakj@vger.kernel.org, AJvYcCWJIA7JGjXjAUaSPaOArVnuwMHDcutRhgVgtHTrCMkjxvGtiKT9LLJCQkhF6lKR8xfsSEM=@vger.kernel.org, AJvYcCX7WqADk52m41NZT5sPE0Yc0TLzShm9wWI8J2+Y41qJLAb1Lt8Xs+rdwHg/lduRXso5mgLz8o6+EdrHUEmL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+PCzzQYxM5unZCxnVgzHARQKSvM2JWX5GmrMQRy47y+fqRuyz
	6dlcnzCaJ2WodpzfsJVRkz9x6fcZf0Fzmynajf9eGBZq2J70TbB0
X-Gm-Gg: ASbGncvDAI5Q3rG5b0SeAuFDSiBhywewsqgmOB/uirbUTgifXuulTOWw15xvpIHNgdP
	6OehkRh+6DcjCrVLapWY2SOiN5+Dwvz3WkN7zLHiHYVFzBgPZRiKd22wmzFzhyjqmsvWJtXyhYh
	7mAykGa6jMKPPsUN1zMDpy0A4POO+eDD4VELE8JEBBO4BwfwonWO34biCT8tx11EFBA4Y5dk91N
	jQv8IYTauNlQOrlU/bUgfLfSdwwQp5S6AzfCIQNNI/7Lfavae5JFTKxvlmpaMUBXZBvMZJi3zhE
	gS9+N/zxcq31088QLE/cRZGqbY9aGoYU7i7yylicbYLygioRkfa47IVH49Q1Pnwrvk415n4yZKM
	UMS5q+bw6wBkj2I6g
X-Google-Smtp-Source: AGHT+IEkuhFM1Iq0XCFaLoezdyIrc0QYsLOXTpVv+69A5554K4E8nebum/GazflySakZWD8qUdK27Q==
X-Received: by 2002:a05:6214:20e7:b0:6e6:62e0:886a with SMTP id 6a1803df08f44-6e6b01dc31amr153086266d6.43.1740363762621;
        Sun, 23 Feb 2025 18:22:42 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7792f5sm127714046d6.18.2025.02.23.18.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:42 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E51991200043;
	Sun, 23 Feb 2025 21:22:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 23 Feb 2025 21:22:41 -0500
X-ME-Sender: <xms:8de7Z19KYtEFcub2ftg6yQApvICiaiggTc3e-WlGsCy12NOQoUqVMg>
    <xme:8de7Z5sgNa9oVNW9eod42Z6lOQnr-FrOM4KNvndP3TrTPTjJMrOS2xToqUVEjE7-W
    cjuvIN2AvUk2tHlAw>
X-ME-Received: <xmr:8de7ZzB8LsWYa3JDyNSYf6eyRl-UinWEhyo_HLYP19ME_apQIsuijvB6Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrg
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
X-ME-Proxy: <xmx:8de7Z5dsgRnfdMQTsD18PsXpN_i-p1tOsCAAN-z_L-bT4wb2G0DmDg>
    <xmx:8de7Z6OqIm2BtseI1u7zxVWfv_MfFSwQhpGPdJi8YGLVr2HaDp1l7A>
    <xmx:8de7Z7m1O8ZFEBeNFsQkgWvmvUG4r35gKQ7meP4tqGym5RW81qIYwA>
    <xmx:8de7Z0sn2nPC4xNZK_RxHfcMD4kO6a2s8rXxR3p6_ZAul5_V0Z45YQ>
    <xmx:8de7Z8vpBJ8DKzHd_9KwlY01kByZUwQwOSbVNT5pZLql-iFYXAFSVRjp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:41 -0500 (EST)
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
Subject: [PATCH rcu 17/20] srcu: Fix srcu_read_unlock_{lite,nmisafe}() kernel-doc
Date: Sun, 23 Feb 2025 18:22:11 -0800
Message-Id: <20250224022214.12037-18-boqun.feng@gmail.com>
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

The srcu_read_unlock_lite() and srcu_read_unlock_nmisafe() both say that
their idx parameters must come from srcu_read_lock().  This would be bad,
because a given srcu_struct structure may be used only with one flavor of
SRCU reader.  This commit therefore updates the srcu_read_unlock_lite()
kernel-doc header to say that its idx parameter must be obtained
from srcu_read_lock_lite() and the srcu_read_unlock_nmisafe()
kernel-doc header to say that its idx parameter must be obtained from
srcu_read_lock_nmisafe().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 63bddc301423..a0df80baaccf 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -402,7 +402,7 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
 /**
  * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
- * @idx: return value from corresponding srcu_read_lock().
+ * @idx: return value from corresponding srcu_read_lock_lite().
  *
  * Exit a light-weight SRCU read-side critical section.
  */
@@ -418,7 +418,7 @@ static inline void srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
 /**
  * srcu_read_unlock_nmisafe - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
- * @idx: return value from corresponding srcu_read_lock().
+ * @idx: return value from corresponding srcu_read_lock_nmisafe().
  *
  * Exit an SRCU read-side critical section, but in an NMI-safe manner.
  */
-- 
2.39.5 (Apple Git-154)


