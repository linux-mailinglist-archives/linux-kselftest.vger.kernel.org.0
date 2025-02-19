Return-Path: <linux-kselftest+bounces-26988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A38EA3C3EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C2A7A9714
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFE11FDA85;
	Wed, 19 Feb 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiA+fDPw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E71F9A86;
	Wed, 19 Feb 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979587; cv=none; b=s07XSn9wHsr/17cmcB3WYUip9S5ZEf0Le5CGQNV387e5TgJb+PPbHyxJmYKoVqVmM4qgrQ5rhB7TzWnCBkvG8srbfG96Ul3ERYPN2Q8eug8SMZbz2jl9UUARF9SPchfbYVVj8Te+/fFBt5FhFGJUu6UzuxDT6vb0EX5hTerBkns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979587; c=relaxed/simple;
	bh=8C80FkUL6UxhkhIFrzMJWhu+QKYCRjycCjOk31gTRkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=blzfHRwyPaiHehqiLx/Gv6T5UvBQR6+ncwGVrp9xf+jZ/MZUVfbk14CTDpqxWlGk40PDYFcsBEEQCX7oJf27F5nJxH+/dcewyM6jywKTEQhOY+uxkEdHzLs+n9hwjFKN0AlnPBhUwnA8cEZBsigC59Thb01qMY17p+H9mnHaGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiA+fDPw; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c081915cf3so38567585a.1;
        Wed, 19 Feb 2025 07:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979584; x=1740584384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ofD7XcJUOd4xqsL7s6Ab7/z/fB9Vrf2jGOtfQ6KGwPw=;
        b=KiA+fDPw0vhtv3hy0Uptfu0ThodH0FCIkKbfyOYLWYJ5rbGzpRFXR6IS9dWSlBm3vK
         rJiYEAO4l1ZR//Q8D3izmq4KcdO8yaqq9vUxt1t1zf8wwXUieQCKqRD0RYRg3WD18xDL
         zeSWrrJqqViZLRYHLw0fzaxdJkSiQSa5g4yDsw2VvNkyIH/zz1hEwZw3Ex2IVtAMjaf3
         2PDCWNp/Hhyx3Jw8AJ5kjWO7B7RVCPTuIn4fJJwxPO3Mp4XsWExVKG/zJkrZlSyO2sfJ
         244ApOuLnGRmQ0aMshQo9OvX6KcXut4tXGF3xudMjO5Wr6r/5ztFJtejDxI0Nq2HleK2
         ckbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979584; x=1740584384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ofD7XcJUOd4xqsL7s6Ab7/z/fB9Vrf2jGOtfQ6KGwPw=;
        b=wYUJXBspROChBOxaswZuLPjE+FcEWbHiIU3QyV7SymnWOFZxtfuiX1R0r68NJRkHL+
         M4MPb9DVqRh0BxxfLVcZTLn5UeJX0AAvPRZTEGXLcigwLTCTnbNPYzuVwsvlzBXxSJm+
         1GLxxNXLsliqwoV2L4CmWmfwBUcBEdS3afEmVcb33NhXfKHZCIDdYLCLzn9Pwg7hYkUn
         3i5TeAkGhoGYsltBU8vRrk+2i8u1KDCKiFaK4s/l4uI5QDxgZB1b2zCgRQgcLT14tAa4
         7hha/2aIFLWkoKZt4+hz7jgW2eGWaRF+mXcBAfIcLwpdZB6W7stGqdfrH1HD7bhRKDRk
         XrjA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ02ZX3xMB7f1cFCjq1XXzS94NiJX6i1F4bEcOUpx/w4EJYVN53HX2fj598+HBRPKJPPHhjUIfKGE=@vger.kernel.org, AJvYcCUdLHga4mmenHkk2SjqEei4Pejt5cuyQ9WBcdAD/Jn0jqtxCjTimQcdO80IlIuw/qnnO99A0jUTzUArwhtx996BpN5X@vger.kernel.org, AJvYcCVezHzLmXig6faP4z1B17FRZhIhIpTxSQP5JqBZ8ARerqEpGRN8I9z+fnT9y+68RW/gPbvyHe5KZrI1/rpY@vger.kernel.org, AJvYcCXoLmtJK+de+pid6JXY8qrjuZNwPc+weLA5sSd3/9pKgLj7p5N48gW+ciqitP6dw2q+2OyCTvy+RuT0DfOqIBpp@vger.kernel.org
X-Gm-Message-State: AOJu0YxbeMORQibN1y3WZN7nyU6Z8BS76t9TqTw+XAHzpFYxMXptastJ
	T5J7Q2cX7GgqnIhBeFENEXMt9Wxdgjyh8+aRnTGXGBN+Blz5qT3y
X-Gm-Gg: ASbGncvWbQT3Oy816EV/cKbvDlrZRewAqt6bMPtrFoL4PaYfXomdXfL+nx1169DMBPw
	DSCfH191BPlQ+ZhlRaBssPCMWeCoPateibIv8MZ3n6QRGys1zUk/1dumNjRTPefWcwSUDceeOod
	w1Qrh4XV42MgNDU0d+IE8wwbTijJDibEWnLS1nwu5XRbfaEavbm+IDBs7uXLqs/s61qH7rscF+Z
	6hdEsFRNfRMebf2HDqo+5WpRMgGobENTMlg+QTVCU4t1d8M5R/qkdd8PqTuflXicqqRHaZhywFA
	AvH/amwrYFi4PZkDroLBB/K8XSPGLUeJiJSBiC5TAeKZRKXe6n2ISVTvqtLNZXhqP1hD4wmsRfx
	Qqc58KQ==
X-Google-Smtp-Source: AGHT+IGUyQ/A0US33jzg7vCcmi8MjDzGL0WvmQXJkuZ2xGoiUtRwR+bXig7hTWuZe/sXU9VvUI/veA==
X-Received: by 2002:a05:620a:27d2:b0:7c0:b795:9812 with SMTP id af79cd13be357-7c0b795a79bmr421215785a.7.1739979584545;
        Wed, 19 Feb 2025 07:39:44 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b7a62d8bsm85690385a.8.2025.02.19.07.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:39:44 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 731C81200043;
	Wed, 19 Feb 2025 10:39:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 10:39:43 -0500
X-ME-Sender: <xms:P_u1Z2xcZamyrVBWwJaDddZSBgK53unCQXjFy9_B5Xy4J5nAawwy5w>
    <xme:P_u1ZyR-t1R1bmuj-yOvpT1Qa15DELGgGPNnaJDetyUZCkE-ljnXXyOXMKxNdbeQL
    hX-hAy3E-pLUBZDAQ>
X-ME-Received: <xmr:P_u1Z4VlBWZDC1vL_x8KuQqMsbA0KhEE2ZOxhrZoTELnarrMuFYSxFlK6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
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
X-ME-Proxy: <xmx:P_u1Z8gjAXsNOL88YHsS7o7A7XZWSSqOl-8fnMTE-s9MmHtjiHnwGg>
    <xmx:P_u1Z4CwRQ7VXitEQ6zfIxO7E8jyeNX-ffdiuSCY6DRN9y_AIT1TFg>
    <xmx:P_u1Z9LCJeezETzs-WbYaAL9SV0eZyiwm93Wh22yZUtN_plNDskSqA>
    <xmx:P_u1Z_AwUoAP21dpWJUPDQWqJb11QPxf8wqpeEUA5XI5JcCIcVwbcA>
    <xmx:P_u1ZwxD58CvOezJWJzVJk7FfTPp2WY8yx6pcIKeHFbw8nXZy6NjbXtK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:42 -0500 (EST)
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
Subject: [PATCH rcu 01/11] torture: Add get_torture_init_jiffies() for test-start time
Date: Wed, 19 Feb 2025 07:39:28 -0800
Message-Id: <20250219153938.24966-2-boqun.feng@gmail.com>
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

This commit adds a get_torture_init_jiffies() function that returns the
value of the jiffies counter at the start of the test, that is, at the
point where torture_init_begin() was invoked.

This will be used to enable torture-test holdoffs for tests implemented
using per-CPU kthreads, which are created and deleted by CPU-hotplug
operations, and thus (unlike normal kthreads) don't automatically know
when the test started.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/torture.h |  1 +
 kernel/torture.c        | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 0134e7221cae..1b59056c3b18 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -104,6 +104,7 @@ int torture_stutter_init(int s, int sgap);
 /* Initialization and cleanup. */
 bool torture_init_begin(char *ttype, int v);
 void torture_init_end(void);
+unsigned long get_torture_init_jiffies(void);
 bool torture_cleanup_begin(void);
 void torture_cleanup_end(void);
 bool torture_must_stop(void);
diff --git a/kernel/torture.c b/kernel/torture.c
index dede150aef01..3a0a8cc60401 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -792,6 +792,8 @@ static void torture_stutter_cleanup(void)
 	stutter_task = NULL;
 }
 
+static unsigned long torture_init_jiffies;
+
 static void
 torture_print_module_parms(void)
 {
@@ -821,6 +823,7 @@ bool torture_init_begin(char *ttype, int v)
 	torture_type = ttype;
 	verbose = v;
 	fullstop = FULLSTOP_DONTSTOP;
+	WRITE_ONCE(torture_init_jiffies, jiffies); // Lockless reads.
 	torture_print_module_parms();
 	return true;
 }
@@ -836,6 +839,15 @@ void torture_init_end(void)
 }
 EXPORT_SYMBOL_GPL(torture_init_end);
 
+/*
+ * Get the torture_init_begin()-time value of the jiffies counter.
+ */
+unsigned long get_torture_init_jiffies(void)
+{
+	return READ_ONCE(torture_init_jiffies);
+}
+EXPORT_SYMBOL_GPL(get_torture_init_jiffies);
+
 /*
  * Clean up torture module.  Please note that this is -not- invoked via
  * the usual module_exit() mechanism, but rather by an explicit call from
-- 
2.39.5 (Apple Git-154)


