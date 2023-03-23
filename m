Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4346C5DF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCWE0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjCWE0o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:26:44 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC7E231D5;
        Wed, 22 Mar 2023 21:26:37 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id hf2so21163206qtb.3;
        Wed, 22 Mar 2023 21:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679545597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=inbcMwmN/oYyFdYCofTQ0HmTr97rTTI0w5emhM/S7CY=;
        b=nd/0oUQwN336TvvwtO2TkreRnNDtAT5rqa58DUXodPTFcb1azJpZOoNwZ+gkYMi9zS
         reoEFjEBrVVku6glkIyn47qoiFo2tiAE8Hi50sChhfdqNvEzd5IPyrBtVW7jCH3/OnO5
         Mp8FMiD3kcKsSXs5J7OsrNJpNL6CxK6zWbd9kc9ez4VCEtUdo1Ib+SXkVvZbTqAgQ9/1
         zZ9xiPRJad2NsMZuObi6+6u0sIkudJK986vNobeAm+VxAaJhR0A2vXpxWOSbQLceE1de
         lujSgd/Y9BEAPDG06/EAgZa8UC+Wlq0pKTKEixNVQS2VE+rZuag4/FK6VdldmLkrAFfO
         5NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679545597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inbcMwmN/oYyFdYCofTQ0HmTr97rTTI0w5emhM/S7CY=;
        b=k8Xz4JptV68dmwVyY3z/WGJ1NXM+bxHXwLbKcCFNxxZsSbdFz5nOp0CioEMou/FziJ
         bXKqNOnDvozJ8K2KShwpHfr0j2uV8KbMurd3kQrieLcQvhxG9GUFEYajwBAVOpoVBumr
         tJF+duIHTBQMpr59cUdQ5fG5YBuhHOelAFhDH1/XDE3XlyOnnhSWkbHZAsAD0VhkxRue
         qz0+JyDbBq7wF84UJ/1IICXMHUfDYE4aOrLF8L3U3S5Marh8zelYXN1i0xMk4GcuKua0
         9Ugp7n5S4f3kyFHuoOdnOleyFimvADhVCZPxojDZ+kDWheSefv/eQ2wbs1INMZB96Eyw
         DomA==
X-Gm-Message-State: AO0yUKV0VUg08RfR1XHG2RbHo0EkBzxp9mGSumgP1VoR1o1kDFa1Jmf8
        zgxQ6tvOCcasZkEcUBUFe48=
X-Google-Smtp-Source: AK7set8Y7j2RaYifKakVXV7fcNR/5zlvKtSirUfXnlRQdwdBYeXYXst8cIVBQHBwT7jwJicNjdBSZw==
X-Received: by 2002:a05:622a:103:b0:3c0:3d56:8c40 with SMTP id u3-20020a05622a010300b003c03d568c40mr9778598qtw.62.1679545596759;
        Wed, 22 Mar 2023 21:26:36 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id r80-20020a374453000000b007465ee178a3sm11304328qka.96.2023.03.22.21.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:26:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id BE53927C0054;
        Thu, 23 Mar 2023 00:26:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 Mar 2023 00:26:35 -0400
X-ME-Sender: <xms:-9QbZHXXgZXaJbUeqYmN3XGYthT3y8Z6zU6wEZfXZ3ZSDZ-W0VysOA>
    <xme:-9QbZPn2ra3qdxog5xoy9x7uzQclxsEHqTClHN50Jd_E59r09GQZ3qzjxj-5MLkqY
    BpR0tvKWpZlCc7tiw>
X-ME-Received: <xmr:-9QbZDY24tHl_p813LNcqUcM8r_u04Js9Z0Tjgz4dbfLMBr_33QQ0sCX6YnuUtaymGkVJpdcXLYti54tO1gSNCQ_t4Qr0WVAJNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:-9QbZCUFsayTkTgyRaCweG3FGWITsb1FQ0dPUiREyCydUxw2mhXh3A>
    <xmx:-9QbZBkzXqJc24x25k6l_ogBye9wHY_SHQqnpe1-xHPWSqwg1tXqig>
    <xmx:-9QbZPfT9g1BQgm-ADMhd-WgR1JlQpbtJ2UaYmDjT_8NclbMqxehdQ>
    <xmx:-9QbZBH4qz5kujicwo6qyY34NZxZUMCu_oiC6SgqeM8yQn70lsrfTg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:26:35 -0400 (EDT)
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
Subject: [PATCH rcu v2 5/7] rcutorture: Add SRCU deadlock scenarios
Date:   Wed, 22 Mar 2023 21:26:12 -0700
Message-Id: <20230323042614.1191120-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230323042614.1191120-1-boqun.feng@gmail.com>
References: <20230323042614.1191120-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In order to test the new SRCU-lockdep functionality, this commit adds
an rcutorture.test_srcu_lockdep module parameter that, when non-zero,
selects an SRCU deadlock scenario to execute.  This parameter is a
five-digit number formatted as DNNL, where "D" is 1 to force a deadlock
and 0 to avoid doing so; "NN" is the test number, 0 for SRCU-based, 1
for SRCU/mutex-based, and 2 for SRCU/rwsem-based; and "L" is the number
of steps in the deadlock cycle.

Note that rcutorture.test_srcu_lockdep=1 will also force a hard hang.

If a non-zero value of rcutorture.test_srcu_lockdep does not select a
deadlock scenario, a console message is printed and testing continues.

[ paulmck: Apply kernel test robot feedback, add rwsem support. ]
[ paulmck: Apply Dan Carpenter feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 151 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8e6c023212cb..80ff9a743d31 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -120,6 +120,7 @@ torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
 torture_param(int, test_boost_duration, 4, "Duration of each boost test, seconds.");
 torture_param(int, test_boost_interval, 7, "Interval between boost tests, seconds.");
 torture_param(bool, test_no_idle_hz, true, "Test support for tickless idle CPUs");
+torture_param(int, test_srcu_lockdep, 0, "Test specified SRCU deadlock scenario.");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 
 static char *torture_type = "rcu";
@@ -3463,6 +3464,154 @@ static void rcutorture_sync(void)
 		cur_ops->sync();
 }
 
+static DEFINE_MUTEX(mut0);
+static DEFINE_MUTEX(mut1);
+static DEFINE_MUTEX(mut2);
+static DEFINE_MUTEX(mut3);
+static DEFINE_MUTEX(mut4);
+static DEFINE_MUTEX(mut5);
+static DEFINE_MUTEX(mut6);
+static DEFINE_MUTEX(mut7);
+static DEFINE_MUTEX(mut8);
+static DEFINE_MUTEX(mut9);
+
+static DECLARE_RWSEM(rwsem0);
+static DECLARE_RWSEM(rwsem1);
+static DECLARE_RWSEM(rwsem2);
+static DECLARE_RWSEM(rwsem3);
+static DECLARE_RWSEM(rwsem4);
+static DECLARE_RWSEM(rwsem5);
+static DECLARE_RWSEM(rwsem6);
+static DECLARE_RWSEM(rwsem7);
+static DECLARE_RWSEM(rwsem8);
+static DECLARE_RWSEM(rwsem9);
+
+DEFINE_STATIC_SRCU(srcu0);
+DEFINE_STATIC_SRCU(srcu1);
+DEFINE_STATIC_SRCU(srcu2);
+DEFINE_STATIC_SRCU(srcu3);
+DEFINE_STATIC_SRCU(srcu4);
+DEFINE_STATIC_SRCU(srcu5);
+DEFINE_STATIC_SRCU(srcu6);
+DEFINE_STATIC_SRCU(srcu7);
+DEFINE_STATIC_SRCU(srcu8);
+DEFINE_STATIC_SRCU(srcu9);
+
+static int srcu_lockdep_next(const char *f, const char *fl, const char *fs, const char *fu, int i,
+			     int cyclelen, int deadlock)
+{
+	int j = i + 1;
+
+	if (j >= cyclelen)
+		j = deadlock ? 0 : -1;
+	if (j >= 0)
+		pr_info("%s: %s(%d), %s(%d), %s(%d)\n", f, fl, i, fs, j, fu, i);
+	else
+		pr_info("%s: %s(%d), %s(%d)\n", f, fl, i, fu, i);
+	return j;
+}
+
+// Test lockdep on SRCU-based deadlock scenarios.
+static void rcu_torture_init_srcu_lockdep(void)
+{
+	int cyclelen;
+	int deadlock;
+	bool err = false;
+	int i;
+	int j;
+	int idx;
+	struct mutex *muts[] = { &mut0, &mut1, &mut2, &mut3, &mut4,
+				 &mut5, &mut6, &mut7, &mut8, &mut9 };
+	struct rw_semaphore *rwsems[] = { &rwsem0, &rwsem1, &rwsem2, &rwsem3, &rwsem4,
+					  &rwsem5, &rwsem6, &rwsem7, &rwsem8, &rwsem9 };
+	struct srcu_struct *srcus[] = { &srcu0, &srcu1, &srcu2, &srcu3, &srcu4,
+					&srcu5, &srcu6, &srcu7, &srcu8, &srcu9 };
+	int testtype;
+
+	if (!test_srcu_lockdep)
+		return;
+
+	deadlock = test_srcu_lockdep / 1000;
+	testtype = (test_srcu_lockdep / 10) % 100;
+	cyclelen = test_srcu_lockdep % 10;
+	WARN_ON_ONCE(ARRAY_SIZE(muts) != ARRAY_SIZE(srcus));
+	if (WARN_ONCE(deadlock != !!deadlock,
+		      "%s: test_srcu_lockdep=%d and deadlock digit %d must be zero or one.\n",
+		      __func__, test_srcu_lockdep, deadlock))
+		err = true;
+	if (WARN_ONCE(cyclelen <= 0,
+		      "%s: test_srcu_lockdep=%d and cycle-length digit %d must be greater than zero.\n",
+		      __func__, test_srcu_lockdep, cyclelen))
+		err = true;
+	if (err)
+		goto err_out;
+
+	if (testtype == 0) {
+		pr_info("%s: test_srcu_lockdep = %05d: SRCU %d-way %sdeadlock.\n",
+			__func__, test_srcu_lockdep, cyclelen, deadlock ? "" : "non-");
+		if (deadlock && cyclelen == 1)
+			pr_info("%s: Expect hang.\n", __func__);
+		for (i = 0; i < cyclelen; i++) {
+			j = srcu_lockdep_next(__func__, "srcu_read_lock", "synchronize_srcu",
+					      "srcu_read_unlock", i, cyclelen, deadlock);
+			idx = srcu_read_lock(srcus[i]);
+			if (j >= 0)
+				synchronize_srcu(srcus[j]);
+			srcu_read_unlock(srcus[i], idx);
+		}
+		return;
+	}
+
+	if (testtype == 1) {
+		pr_info("%s: test_srcu_lockdep = %05d: SRCU/mutex %d-way %sdeadlock.\n",
+			__func__, test_srcu_lockdep, cyclelen, deadlock ? "" : "non-");
+		for (i = 0; i < cyclelen; i++) {
+			pr_info("%s: srcu_read_lock(%d), mutex_lock(%d), mutex_unlock(%d), srcu_read_unlock(%d)\n",
+				__func__, i, i, i, i);
+			idx = srcu_read_lock(srcus[i]);
+			mutex_lock(muts[i]);
+			mutex_unlock(muts[i]);
+			srcu_read_unlock(srcus[i], idx);
+
+			j = srcu_lockdep_next(__func__, "mutex_lock", "synchronize_srcu",
+					      "mutex_unlock", i, cyclelen, deadlock);
+			mutex_lock(muts[i]);
+			if (j >= 0)
+				synchronize_srcu(srcus[j]);
+			mutex_unlock(muts[i]);
+		}
+		return;
+	}
+
+	if (testtype == 2) {
+		pr_info("%s: test_srcu_lockdep = %05d: SRCU/rwsem %d-way %sdeadlock.\n",
+			__func__, test_srcu_lockdep, cyclelen, deadlock ? "" : "non-");
+		for (i = 0; i < cyclelen; i++) {
+			pr_info("%s: srcu_read_lock(%d), down_read(%d), up_read(%d), srcu_read_unlock(%d)\n",
+				__func__, i, i, i, i);
+			idx = srcu_read_lock(srcus[i]);
+			down_read(rwsems[i]);
+			up_read(rwsems[i]);
+			srcu_read_unlock(srcus[i], idx);
+
+			j = srcu_lockdep_next(__func__, "down_write", "synchronize_srcu",
+					      "up_write", i, cyclelen, deadlock);
+			down_write(rwsems[i]);
+			if (j >= 0)
+				synchronize_srcu(srcus[j]);
+			up_write(rwsems[i]);
+		}
+		return;
+	}
+
+err_out:
+	pr_info("%s: test_srcu_lockdep = %05d does nothing.\n", __func__, test_srcu_lockdep);
+	pr_info("%s: test_srcu_lockdep = DNNL.\n", __func__);
+	pr_info("%s: D: Deadlock if nonzero.\n", __func__);
+	pr_info("%s: NN: Test number, 0=SRCU, 1=SRCU/mutex, 2=SRCU/rwsem.\n", __func__);
+	pr_info("%s: L: Cycle length.\n", __func__);
+}
+
 static int __init
 rcu_torture_init(void)
 {
@@ -3504,6 +3653,8 @@ rcu_torture_init(void)
 	if (cur_ops->init)
 		cur_ops->init();
 
+	rcu_torture_init_srcu_lockdep();
+
 	if (nreaders >= 0) {
 		nrealreaders = nreaders;
 	} else {
-- 
2.38.1

