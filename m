Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEDB6BDF60
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 04:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCQDPS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 23:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjCQDOI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 23:14:08 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CB81C339;
        Thu, 16 Mar 2023 20:13:50 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id hf2so204249qtb.3;
        Thu, 16 Mar 2023 20:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679022830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+Fb5i+KhMbej/UhF/LB5X6VMJfIWLMpGYs1y3tWWv4=;
        b=QdFw3No4mVBPGSZdFjoNnjdIHSCvthanqz5n2Cay9Plf87sC4+Ox3yHR5H/oBIHmNq
         09yKcQ5BVYyCIifXea+wTDSdIMwTLv5BgggmamjAzK/evTvezu9G1amjuesxzdOEwcHU
         n2wTIw7KMHQ6HFN3hRxB4WsCqHB3no87UjIS2OpVIhaFMObq9vgvtBlQCXORJheumO7o
         tru7zdAZ0qd52b8bh41/H8lxYPobqcQ5bCgswsmqmSYa1a1GRQIkyrv2jZ2FKvR1bwsE
         13odczsjmAhx4R5XTFBX0qPvjaAhHXNqw5uiok7Au0cZK5pt8mYnijsK/gCi25bCd96F
         1LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679022830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+Fb5i+KhMbej/UhF/LB5X6VMJfIWLMpGYs1y3tWWv4=;
        b=DpkNX3r8iVHYb8bKE89opkChHXWzqwD4QKjWJVeMRuo0SOeXDMkFLP2pVs7xmjTBr1
         sMmk6v0w05PkVKVfILnQ5x+M2qiIIhYugCf8P8LuafIV5JakDdQCaugAPeh9ny/l3/Nx
         tyhom7K8Bp25rRbnY+rsB3byg40xzvMeeqAQ2h1vgayr1d6a8dNn62LWG2g0kgwrBk6v
         KP1jY/jKMJKGE43FBOh0pyq2GjWIpjzHW9rPl69cuqObMqpfu2foc6L3/CCDRokp1qLY
         HrZLbUzWE2VAtUdCB9AT3WAzCIQOu10PGy4Tj0bTxvaHVNmiQ+ledrq1V7M9pdPFyoDp
         Sq1A==
X-Gm-Message-State: AO0yUKWL5zCDcash0ie7AjXG/HNAXAEeAWLunf2wJnM2mF+zRpgCc+ot
        YToxbYBR2ghquajvHwY75+Q=
X-Google-Smtp-Source: AK7set+6qVfjpzivz6voyblrqOQEKvOxRAoZ26YKlShivCb0mGwq59WAMnhuCDGfdjBBXkdORI+nqg==
X-Received: by 2002:a05:622a:1787:b0:3bf:ca3d:673c with SMTP id s7-20020a05622a178700b003bfca3d673cmr8036401qtk.2.1679022829828;
        Thu, 16 Mar 2023 20:13:49 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v4-20020ac87484000000b003bffe7fdc38sm828766qtq.9.2023.03.16.20.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 20:13:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8E8D827C005A;
        Thu, 16 Mar 2023 23:13:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Mar 2023 23:13:48 -0400
X-ME-Sender: <xms:7NoTZI5pOewUcdor5Nk3ldiI43Zt9GSzs_z7Oguc3YawVGUGC9A3Uw>
    <xme:7NoTZJ6hJeTFfE-tRFLQWB6CWOYKmYA8s9eyHR32abv2tJjQXHRY319vvkAD5f8FK
    2tM2hjkB-cscalm7Q>
X-ME-Received: <xmr:7NoTZHccQuxTmWHDmvZr9vv2ASuXYaccuigOUYJrpVWcAIv-mygU60sHlHM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeu
    gfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:7NoTZNJ0ULKKtOcet_qOSDIZH1EfMGDJCsm5Grz-vDCdAJbS0dJKDQ>
    <xmx:7NoTZMItEj8UMGEfC-ozriydS4EIGv9_BIUYNbtYQkUcPYTJXMfxlQ>
    <xmx:7NoTZOxjmBubx2uf73JnhiWIS4zO7bEl4B7421FEKjcdlrrTgFE93w>
    <xmx:7NoTZMJYRYEJ2R5xrKHk8IcHQ67z81YvGtzK4Xp1OKUTodiWDv6xyQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 23:13:48 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <shuah@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        seanjc@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH rcu 1/7] locking/lockdep: Introduce lock_sync()
Date:   Thu, 16 Mar 2023 20:13:33 -0700
Message-Id: <20230317031339.10277-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317031339.10277-1-boqun.feng@gmail.com>
References: <20230317031339.10277-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, functions like synchronize_srcu() do not have lockdep
annotations resembling those of other write-side locking primitives.
Such annotations might look as follows:

	lock_acquire();
	lock_release();

Such annotations would tell lockdep that synchronize_srcu() acts like
an empty critical section that waits for other (read-side) critical
sections to finish.  This would definitely catch some deadlock, but
as pointed out by Paul Mckenney [1], this could also introduce false
positives because of irq-safe/unsafe detection.  Of course, there are
tricks could help with this:

	might_sleep(); // Existing statement in __synchronize_srcu().
	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
		local_irq_disable();
		lock_acquire();
		lock_release();
		local_irq_enable();
	}

But it would be better for lockdep to provide a separate annonation for
functions like synchronize_srcu(), so that people won't need to repeat
the ugly tricks above.

Therefore introduce lock_sync(), which is simply an lock+unlock
pair with no irq safe/unsafe deadlock check.  This works because the
to-be-annontated functions do not create real critical sections, and
there is therefore no way that irq can create extra dependencies.

[1]: https://lore.kernel.org/lkml/20180412021233.ewncg5jjuzjw3x62@tardis/

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  |  5 +++++
 kernel/locking/lockdep.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1023f349af71..14d9dbedc6c1 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -268,6 +268,10 @@ extern void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 extern void lock_release(struct lockdep_map *lock, unsigned long ip);
 
+extern void lock_sync(struct lockdep_map *lock, unsigned int subclass,
+		      int read, int check, struct lockdep_map *nest_lock,
+		      unsigned long ip);
+
 /* lock_is_held_type() returns */
 #define LOCK_STATE_UNKNOWN	-1
 #define LOCK_STATE_NOT_HELD	0
@@ -554,6 +558,7 @@ do {									\
 #define lock_map_acquire_read(l)		lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
 #define lock_map_acquire_tryread(l)		lock_acquire_shared_recursive(l, 0, 1, NULL, _THIS_IP_)
 #define lock_map_release(l)			lock_release(l, _THIS_IP_)
+#define lock_map_sync(l)			lock_sync(l, 0, 0, 1, NULL, _THIS_IP_)
 
 #ifdef CONFIG_PROVE_LOCKING
 # define might_lock(lock)						\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 50d4863974e7..36430cf8e407 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5693,6 +5693,40 @@ void lock_release(struct lockdep_map *lock, unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(lock_release);
 
+/*
+ * lock_sync() - A special annotation for synchronize_{s,}rcu()-like API.
+ *
+ * No actual critical section is created by the APIs annotated with this: these
+ * APIs are used to wait for one or multiple critical sections (on other CPUs
+ * or threads), and it means that calling these APIs inside these critical
+ * sections is potential deadlock.
+ *
+ * This annotation acts as an acqurie+release anontation pair with hardirqoff
+ * being 1. Since there's no critical section, no interrupt can create extra
+ * dependencies "inside" the annotation, hardirqoff == 1 allows us to avoid
+ * false positives.
+ */
+void lock_sync(struct lockdep_map *lock, unsigned subclass, int read,
+	       int check, struct lockdep_map *nest_lock, unsigned long ip)
+{
+	unsigned long flags;
+
+	if (unlikely(!lockdep_enabled()))
+		return;
+
+	raw_local_irq_save(flags);
+	check_flags(flags);
+
+	lockdep_recursion_inc();
+	__lock_acquire(lock, subclass, 0, read, check, 1, nest_lock, ip, 0, 0);
+
+	if (__lock_release(lock, ip))
+		check_chain_key(current);
+	lockdep_recursion_finish();
+	raw_local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(lock_sync);
+
 noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 {
 	unsigned long flags;
-- 
2.39.2

