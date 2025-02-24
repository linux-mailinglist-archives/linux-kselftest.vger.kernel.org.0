Return-Path: <linux-kselftest+bounces-27308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DB6A4136B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306CC7A4932
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36FB1FE468;
	Mon, 24 Feb 2025 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wyrlz9Ge"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7FF1FC0F3;
	Mon, 24 Feb 2025 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363758; cv=none; b=tBCyP+H/NqXXG6U83/jWA2CJDpzQryDjOTMoDBQU9vZ2+sd5a7FboALQidTlSJjttPON+HHFrJRoZ0Bl1KoJB5Fjn6qAIv8esgovWuvw+3BaDpEjiOLNZbL37sPjxyw4eSiC3hkDfTf/mI5uXdkvSbIgnlcVbAnwSOlAsYwzvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363758; c=relaxed/simple;
	bh=vYGr4oase6oAhv/S3mUkEU7TFl9z4yEqQk+LuMvaIG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ajf4yj5QAE6bknpFi5wt4gufo5+XxFkzoI8pVY35wB67GEq6J7jopGY/Nx0JW03J/LU8iMJwIIoLqYa0g0IKWlXvV1vLyrt9HvHyxCvf/U0MwiLnG7RwTjDT+B/wixKM73lFyeQQO3UQHbQtSe9AfULXK3vJuMSyg/N77aNnwpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wyrlz9Ge; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47210ab1283so57653511cf.1;
        Sun, 23 Feb 2025 18:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363756; x=1740968556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9xc+k+HYzIVy9Ic6oMLdV0EroWNk+iKQ9YparoGG0Ik=;
        b=Wyrlz9GeIxY2YjJXe5tWrd95p9p7msqGEXxXi7/xqTBOWk15M67/8i6xjkyjPEnxfY
         7whIWckBQfsOppeoMzX8gqiDmThtLSLLx7CNewck+VgH5IJkC1iwKJf5iN/bZOiTc4OL
         NKhF3NEHxA2Q5IFTOetiKYqIavYrWiQRYF0g+mZLItX2t6zviYxXoLtlkiHRFPDPwtlK
         H3b0/jHXKExi8KFpXcC8TlMT0UlYsqiK6jGTqfpBEiEOABU45LTPaMGA9WCLHqYRSBxL
         IbBcZ27krs1gKqlvRQmqJ57HZGCaMQMN/iM1T1zxVBtiuk8Bd5q3fPp9UCo2BYzHwiVI
         cbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363756; x=1740968556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xc+k+HYzIVy9Ic6oMLdV0EroWNk+iKQ9YparoGG0Ik=;
        b=XAE0xVenYtwI2iEnypHaVncaOZqYupa3hnDtyZ7ZBsAFyw3ELng6Z1MJJkebQVcP62
         Ah2cTVjzHbxz1C1zEUyn59iMrfDmuYoHT7WX/qLup+GYqFXH/eS+8CJjRHRLayxdPXSH
         Xec7Mp983Y1iOgZXz+QYFq/sbup4Xc1aRoT5qZavA9p7iKtDOGreM2Ezq4ItGeJDSOSZ
         +eVZFflxVnvIZFS8Qdd4fWDdzHOtR/YQQ9BJt1uu2NH0e/Br9BO08DD/eT+bX78d+UyU
         ggKAuwZQ+LAiJrH1kbJ5rYG3CrE/UVZvyD3m541b3+nldk+qSPgo0f6+Nk/mZyc/1P7W
         72OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYVXgGI3Zhbm/451ylKto2Ngp9o9DlE/s1UC69F1nXqBsu6qsxAdaSEooXf3P2gv4SYVU=@vger.kernel.org, AJvYcCV7hMTbtS+HFsQDNoNrGKiBA4375C3eYAOqWfBQHqkv++sCUMSrIMfgK+hg2njCuPStzrRH4RE8GR+EqgIxyeib@vger.kernel.org, AJvYcCWECpV444VOB/ZhaCFlRFBaz6KZBnvGKirat0hzS+OdIT+CsaVSIbbFybjEdiax1rjAxrOU3ktMyvb/Bfr4@vger.kernel.org
X-Gm-Message-State: AOJu0YzacwxkFy1U4fXaZEG9uhAgBn6kIpF5pzn3ch39XObqenW8uHL0
	MiK6DKfYGCkMdfRNfKAZ7a6M9A7n/yzD/iTG8lrLtsO81fLCne/2
X-Gm-Gg: ASbGncuk+uIJ5IBm0xjHXwHwGLSBkzx9TEGNCKQEXUkzF2ov4zrWTARI0HozmIV+QMt
	+/+A6W9szofq0x1Q/vMWVAZgVsY5qRLCHHK7aTgCnX+piE6BiNTykKy18DfCV0YNNpcWUFgd7HE
	JxtPmMNEcqCWfdz5BkCKrX9jsqfzpQsSBzEJXluB73NAqyoS257qkzIPsDmnzCIddzGE4LEq+ti
	MS45pMURDV0rDEpgxQbY5z/U6qO9DQVNvbTvH4QOzmWw7U7ORpuwhTFWOZPmfrEkmpo6yLf2Zml
	t32jIFk83dfPJ3T58Fv4T6G+QvkcoTHBhJA+Bz1ZwfBbylKjM8IeRaXjz0MKYnt4oGBx2m/Du4z
	rhGNJVYEgLd2Klof+
X-Google-Smtp-Source: AGHT+IFYTMVp6JYLVO/whvadX5BcZfW43b4gbDKbaMnb7W7u3y3MHECALfKNOxhOC+OdWqH3s0bwIw==
X-Received: by 2002:a05:622a:388:b0:471:fde4:f09e with SMTP id d75a77b69052e-4722295d3c7mr159638211cf.36.1740363755990;
        Sun, 23 Feb 2025 18:22:35 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09d5980e1sm952821385a.13.2025.02.23.18.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:35 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2987F1200043;
	Sun, 23 Feb 2025 21:22:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 23 Feb 2025 21:22:35 -0500
X-ME-Sender: <xms:69e7Z2bdXUvhY2q_ktEj6_4mxum1XbtvojSQpWZHtVbD2e3KOkZTvQ>
    <xme:69e7Z5YE30GFYBxHyIGzDVMhVBripm2iQhnU3P540mBuFSjDAVdxczf7RE1vS9ow3
    faP82UIwb4s8o20Mg>
X-ME-Received: <xmr:69e7Zw8QvK-L3Uutd9Ta1XScPhv8NaY7xP1ojzXbBDPijgFLAsfkTpo4cg>
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
X-ME-Proxy: <xmx:69e7Z4q8N94WyYkduFouVOnfQNXQODc2TFgOC1nJdzwgRDArSUkJ8g>
    <xmx:69e7ZxoHm2hG5JusReTkwPBfeIpZcYrT-AaWfYhqki6VpY_qASU_nw>
    <xmx:69e7Z2T-QWsqI1hJnXaWjGEq4tyhEcd0xy9R2XtmSp4spZRYFcV5Gw>
    <xmx:69e7Zxq6dKTx9pB3U3S-3Amlzz34BUiK66MPgHW1tSjMLnXRHExD1g>
    <xmx:69e7Z-5ljwnvTJ3DJYxig6SaLx4usaoBO6pF3hLCK_K397_EeE8Ac2iP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:34 -0500 (EST)
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
Subject: [PATCH rcu 12/20] srcu: Move SRCU Tree/Tiny definitions from srcu.h
Date: Sun, 23 Feb 2025 18:22:06 -0800
Message-Id: <20250224022214.12037-13-boqun.feng@gmail.com>
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

There are a couple of definitions under "#ifdef CONFIG_TINY_SRCU"
in include/linux/srcu.h.  There is no point in them being there,
so this commit moves them to include/linux/srcutiny.h and
include/linux/srcutree.c, thus eliminating that #ifdef.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcu.h     | 10 +---------
 include/linux/srcutiny.h |  3 +++
 include/linux/srcutree.h |  1 +
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 505f5bdce444..2bd0e24e9b55 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -52,6 +52,7 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_SLOWGP	SRCU_READ_FLAVOR_LITE
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
+void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
 
 #ifdef CONFIG_TINY_SRCU
 #include <linux/srcutiny.h>
@@ -64,15 +65,6 @@ int init_srcu_struct(struct srcu_struct *ssp);
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
 		void (*func)(struct rcu_head *head));
 void cleanup_srcu_struct(struct srcu_struct *ssp);
-int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
-void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
-#ifdef CONFIG_TINY_SRCU
-#define __srcu_read_lock_lite __srcu_read_lock
-#define __srcu_read_unlock_lite __srcu_read_unlock
-#else // #ifdef CONFIG_TINY_SRCU
-int __srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp);
-void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx) __releases(ssp);
-#endif // #else // #ifdef CONFIG_TINY_SRCU
 void synchronize_srcu(struct srcu_struct *ssp);
 
 #define SRCU_GET_STATE_COMPLETED 0x1
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index b347bde1aac2..a6194f7a7e34 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -71,6 +71,9 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 	return idx;
 }
 
+#define __srcu_read_lock_lite __srcu_read_lock
+#define __srcu_read_unlock_lite __srcu_read_unlock
+
 static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
 {
 	synchronize_srcu(ssp);
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 55fa400624bb..ef3065c0cadc 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -207,6 +207,7 @@ struct srcu_struct {
 #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
 #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
 
+int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
-- 
2.39.5 (Apple Git-154)


