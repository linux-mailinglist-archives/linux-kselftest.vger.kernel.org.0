Return-Path: <linux-kselftest+bounces-27311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38729A41380
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04913B57DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C773F22DFB1;
	Mon, 24 Feb 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHLfz5jX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EEF2063CB;
	Mon, 24 Feb 2025 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363763; cv=none; b=n5ErI8I8vdGe+h4dnlrjv7WbTBp538t3dQ8Q5lIq5ZjpvQS4J/UI4lZFdx0sgYPLocIrYTO9ds4VuGGFzdCoBr8AQGCDb5wzGhwFySpSjvP0Uvm1qdKlPBZiu2bOwD7tLbzJJ9flxoz3BARu2iim9bEttRNaQjQcI4B/94X+ckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363763; c=relaxed/simple;
	bh=h8HBUzXuphlZNQxNxs1uJ1SrYCmrEvzUpER8NpS6wz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNH6UL63rnQnzb4yetv41m/GgjSlBaFAKz5gLCD7iT5kUj48PlH/HnXzDa27JfnWe1TeNqPn8CYF7+ti1MPRxtgc2KUUgQ0kK47EWBmW2+M13RkGz2MYlaNG87BXzfbhJ3Ld+Tu51/U/bLvj6FgUumxweslepkxKjsv3ppWwPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHLfz5jX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e68943a295so35295096d6.0;
        Sun, 23 Feb 2025 18:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363760; x=1740968560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oog4qI5g2vg4T9pens3ux9X508RzykqUXStM/G8prXE=;
        b=fHLfz5jXqb694TcHdpEDQnSdy5XYuzZEnyr488I+Jq4ELylqM8qNRPhqzy3OWKmm8G
         T71m0aLXAxU+mvyfKfzU7OZTW4PfnMEEShfePHAkhPZtNVHsiVJyQDYmSr40WehZGTqI
         9Mx5N3rt/ZFbf6+a18VvTcZx0DNLIxlWwYUDwcFAVot6Xsh1yBAF4f16Xi4xKBjLtHJz
         NynwxfVyPvmS3bh9HV8nksKtZjGgucnVwVVvKVDkvsR+CxurfjqKV4lCU9mkasCCyDYh
         SH/lDXMfQN9Ub62greux0krO/qt+kD/jxAFZuP2CytryLdiyl72YBK+htL9518BEGOb9
         HFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363760; x=1740968560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oog4qI5g2vg4T9pens3ux9X508RzykqUXStM/G8prXE=;
        b=cVyu4mbXxGm0cSXOnVkqSswE5ztia53AAZj/MJoMBq+alESE4COtTka7cTiuktY1qr
         t5zFebpjWfFMzvsQ7qJZHS0UH8XaqZJ/OHhHo3UaSbwxtvzUuwNZ47E9rGIcVYDY2F9d
         QW662YvBlfIBrLxxSsZseXb4R/8fwP8ZU/IT+zEuA4aR1XHidDEZ0wEs0X5ktFJbI7uj
         HVxccM0jPX4JOUy+n8cunqkntOyCQ5yf7V4NEIEQavXZwtyzn+56fJbWBX1f007rAPEc
         G/C6c36c94hcm2ARjyyHyI4zRY0SITWuJeecSBzmSif3hNM/g3C2sDqof+ePZE87o7X8
         dxNg==
X-Forwarded-Encrypted: i=1; AJvYcCV9vlPIAI3DOBnBynf/D6WHTO3ZvAAzwL5bnmqWA9S9ntlj6Nui2OOom4OmLAhmhnI0reShjFyWqMuxpmhnKzg9@vger.kernel.org, AJvYcCVXM63GcVEywOiwgcHhnBoSdxKIgsSso3l0a3uD/XNXoN5H7pK3z3mrJaYW1V/EGv2L7yc=@vger.kernel.org, AJvYcCW9bPstb8oXI0LADyaEjJtfz/moMtWXP8+Dm8vX7npa0F6qlVkpPfYGLnTiQsj0fCO1tIv4sHQIoF0+fWh5@vger.kernel.org
X-Gm-Message-State: AOJu0YxftwsZdSdDOQT+0AuQOxLZoFZQsSLZW+DT/Fg8Mq4t2xJJ1Yc+
	bvHP0HqJTMnSwHZO5i9JnHswei4H3ybPBqp4SB3wMwOQuPcU1KIK
X-Gm-Gg: ASbGncvXfVzMWb1bBzpYB1z9FcoS6+NlgpxImtM1KpbLYtBrN8AessD0GciNtnvo9PW
	ZKte/IBlMVBhjUeH4rrK9cdMsJIPAOvBPGkgMbKUk+QNVv2CelpVsOQHt8ZmwPUbrE65GiNQWEp
	Ca/Y7NaCmFvKdVCYEZtukmjyhLNwSa5E4twYibjBTrGDF+smOB+qK5EtizGRVPdW2LkDShRaNb8
	XvKUHTQo6l366lBG4LRRUMe/yryK/BPUz7YdaboSv0eUwdvrDVEoEcz5z75pGXQPOc/SzVF3mb6
	iiPeHIFcUb7GHqjNuNsQIzrzHh2/64XUvmBanI3EpnXNO4kNVcKEZZtH9gPIeCJJqn1eqpgV7iB
	LGLuC1YWSBrRcJzMI
X-Google-Smtp-Source: AGHT+IGAajfRFO2xGulo8n/40NXHr0Led+2dTbHy2lKt/rZwX0131IbbeJmnf9Cue1pOnk2ANk5LyQ==
X-Received: by 2002:a05:6214:230b:b0:6e6:61f1:458a with SMTP id 6a1803df08f44-6e6b00935b2mr154788296d6.14.1740363760063;
        Sun, 23 Feb 2025 18:22:40 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d779271sm128282586d6.3.2025.02.23.18.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:39 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 37F341200043;
	Sun, 23 Feb 2025 21:22:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 23 Feb 2025 21:22:39 -0500
X-ME-Sender: <xms:79e7Z0Vw7OrH5qCK0suTx7zUXQmtHcUh63M-JMpjW4Yb14nU3H6-jA>
    <xme:79e7Z4nnGxHZbS3-x_XKJw2hWLyG5JwCVr7vu0234sIeA9jcTPmFmET7_6e-d1vN7
    YCiENa-8oKvUB6DdQ>
X-ME-Received: <xmr:79e7Z4YDk5K1BcvcNM-1iHjLewNrcGb_ETJzm3pl0iWLwM6-N_0i6cnHDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrg
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
X-ME-Proxy: <xmx:79e7ZzVQLjZUcIVRN-9S7JvRiyJs30s4kReXLcEfxSUIrUTNgh3p9A>
    <xmx:79e7Z-mI59AB7b6ESi0sYN-MOV1FmcisGpHoYk1twsUSCkEkvroWtw>
    <xmx:79e7Z4c9Sb1jPH4fo5H3XdtSNCMqRLOwg7VLGYWYntZ8HGIDeBGbeg>
    <xmx:79e7ZwEOiKLJ9ND3sCN87WNf-FzDqwSAk9IIaOuwnXw43bvLo3ff0Q>
    <xmx:79e7Z0mpH0Dt0bY9xvRpRrnGT5Y0Of-DMN94-PDGaN-6RDaiRH0U2qSj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:38 -0500 (EST)
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
Subject: [PATCH rcu 15/20] refscale: Add srcu_read_lock_fast() support using "srcu-fast"
Date: Sun, 23 Feb 2025 18:22:09 -0800
Message-Id: <20250224022214.12037-16-boqun.feng@gmail.com>
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

This commit creates a new srcu-fast option for the refscale.scale_type
module parameter that selects srcu_read_lock_fast() and
srcu_read_unlock_fast().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/refscale.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 1b47376acdc4..f11a7c2af778 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -216,6 +216,36 @@ static const struct ref_scale_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+static void srcu_fast_ref_scale_read_section(const int nloops)
+{
+	int i;
+	struct srcu_ctr __percpu *scp;
+
+	for (i = nloops; i >= 0; i--) {
+		scp = srcu_read_lock_fast(srcu_ctlp);
+		srcu_read_unlock_fast(srcu_ctlp, scp);
+	}
+}
+
+static void srcu_fast_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+	struct srcu_ctr __percpu *scp;
+
+	for (i = nloops; i >= 0; i--) {
+		scp = srcu_read_lock_fast(srcu_ctlp);
+		un_delay(udl, ndl);
+		srcu_read_unlock_fast(srcu_ctlp, scp);
+	}
+}
+
+static const struct ref_scale_ops srcu_fast_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= srcu_fast_ref_scale_read_section,
+	.delaysection	= srcu_fast_ref_scale_delay_section,
+	.name		= "srcu-fast"
+};
+
 static void srcu_lite_ref_scale_read_section(const int nloops)
 {
 	int i;
@@ -1163,7 +1193,7 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
+		&rcu_ops, &srcu_ops, &srcu_fast_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
 		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
 		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
-- 
2.39.5 (Apple Git-154)


