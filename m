Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6219D6C5E0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCWEju (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCWEjs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:39:48 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD3725E31;
        Wed, 22 Mar 2023 21:39:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id n2so25402696qtp.0;
        Wed, 22 Mar 2023 21:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/p+415ml8u7S5uPVpzM3VN2d4OyiFzVETTNfWzjy5Xo=;
        b=NGLX5O2VPNV2Vnt0cER10ndlTTqJWc7KUZzNHQe9L11HC2alrY0+8K557PRdFRqrQz
         VdX+LrEq4JVau5EQ68B9aMhH+b+He9/ckXETRMdBRgH9fV089/4TKLV4oxW0W/8Egu+0
         1zHQLSE/6uwN3Gkp6G8y0zbjNDeMM50rB12tLCsAkPN32yJQM4/t56ZJcmgtDdxdkVxO
         HZUk09ks+ZgGP4q2JsBcjrHXLqEXBLH0jE6hq4Be2Bal5RV/WJ9K/YdCjSaVBuVmziMV
         TFOJvLynNeiJy6XRTKhsxfSiJOG4GJS7Zk+kDiXqc3YrQJc78fXPCcnQIy3yS+v8B4EA
         S8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/p+415ml8u7S5uPVpzM3VN2d4OyiFzVETTNfWzjy5Xo=;
        b=pPj0EhTsFpjvsIaIu/MLkCzCMhEqNWDNpuZJDXuHxyGz1mGJd0dKUxnNF8kFrEf0Ox
         jqHp32QVk0FsgmIYz1LPKsaVewHj1QbrvPPKseQrJbWVo/KylCKRTEvDny9dW8iVKxQz
         kME786Qb+JMsaoLLWY4uAluUZnokkCClNbGs1Vuu2LHmmG9292sT2qo/UdLGUkATfZ6x
         Vh9VJ/dtYot+bqiS0q+/jFoEc23IQ83NwxQ3igyXByHc7HVheMkDmf9a4+evS9Kbzov3
         cX+8ye4lBBkZ0RBJr77gEA5xmolT761XRSmJIUe6dV99muJgN243fRc1HpfafvlcPs8D
         2+NQ==
X-Gm-Message-State: AO0yUKVfh+UWcbMbLDMo4Sxw5atRMr6Y/eWuQ2m/dOhn3LMHzCEh1ms8
        7IwgvqOfrABPXuLo9FfFXq8=
X-Google-Smtp-Source: AK7set/EcUr/+FKEfLEuRZwv5m/FvhcRXkjLqxNioPkgjR56iUuPcMeg26uh2htZ1w+H2yZ67OrfvA==
X-Received: by 2002:a05:622a:199b:b0:3bf:ba1b:3615 with SMTP id u27-20020a05622a199b00b003bfba1b3615mr9833998qtc.55.1679546386815;
        Wed, 22 Mar 2023 21:39:46 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g8-20020ac870c8000000b003e38ffab498sm1180040qtp.24.2023.03.22.21.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:39:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id EC5E927C0054;
        Thu, 23 Mar 2023 00:39:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 23 Mar 2023 00:39:45 -0400
X-ME-Sender: <xms:EdgbZNZRmIFJWKyTGz1Nlc4Aayb-lxhVEC48Cha_IWg9ZegVfd9DzQ>
    <xme:EdgbZEY4n1R3BbnFnibtT6ind9uz_kCeQOwmIWQn1sa-a3FkGoVCq0vJ7JyS2nUXY
    7cS8_Re1d1PpFuklg>
X-ME-Received: <xmr:EdgbZP8xQqA8kLTFr2xGaQ0I2A5jIijdvk5ketWW594GlNC_jLMsysaemXshm6foGJeehlo8swAI5FfKEbabmh2-8PkWGM2ZLJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:EdgbZLrPETO_pikFxNaHKLopD5OiKrwq0GT9DaNZqxEviTjk4VrSNA>
    <xmx:EdgbZIpS8sZNWEfQWi2GEbRhJUrQp6gX_HbYaLh0aUeYI7RtTh3gVA>
    <xmx:EdgbZBS9c6-Qinv2eVtQBIbI9OOrvPF_j6OA5g3ewwEq7NbLU93m1g>
    <xmx:EdgbZF4bxbpevuKFnwcq1KwrVJSJA-QP-a_XDwXnjRONQ1xFaKmz4A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:39:45 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <shuah@kernel.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH rcu v2 01/10] rcutorture: Add test_nmis module parameter
Date:   Wed, 22 Mar 2023 21:39:26 -0700
Message-Id: <20230323043935.1221184-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230323043935.1221184-1-boqun.feng@gmail.com>
References: <20230323043935.1221184-1-boqun.feng@gmail.com>
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

This commit adds a test_nmis module parameter to generate the
specified number of NMI stack backtraces 15 seconds apart.  This module
parameter can be used to test NMI delivery and accompanying diagnostics.
Note that this parameter is ignored when rcutorture is a module rather
than built into the kernel.  This could be changed with the addition of
an EXPORT_SYMBOL_GPL().

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8e6c023212cb..480bba142e3a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -119,6 +119,7 @@ torture_param(int, stutter, 5, "Number of seconds to run/halt test");
 torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
 torture_param(int, test_boost_duration, 4, "Duration of each boost test, seconds.");
 torture_param(int, test_boost_interval, 7, "Interval between boost tests, seconds.");
+torture_param(int, test_nmis, 0, "End-test NMI tests, 0 to disable.");
 torture_param(bool, test_no_idle_hz, true, "Test support for tickless idle CPUs");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 
@@ -2358,7 +2359,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "read_exit_delay=%d read_exit_burst=%d "
-		 "nocbs_nthreads=%d nocbs_toggle=%d\n",
+		 "nocbs_nthreads=%d nocbs_toggle=%d "
+		 "test_nmis=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -2369,7 +2371,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
 		 read_exit_delay, read_exit_burst,
-		 nocbs_nthreads, nocbs_toggle);
+		 nocbs_nthreads, nocbs_toggle,
+		 test_nmis);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -3273,6 +3276,29 @@ static void rcu_torture_read_exit_cleanup(void)
 	torture_stop_kthread(rcutorture_read_exit, read_exit_task);
 }
 
+static void rcutorture_test_nmis(int n)
+{
+#if IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)
+	int cpu;
+	int dumpcpu;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		preempt_disable();
+		cpu = smp_processor_id();
+		dumpcpu = cpu + 1;
+		if (dumpcpu >= nr_cpu_ids)
+			dumpcpu = 0;
+		pr_alert("%s: CPU %d invoking dump_cpu_task(%d)\n", __func__, cpu, dumpcpu);
+		dump_cpu_task(dumpcpu);
+		preempt_enable();
+		schedule_timeout_uninterruptible(15 * HZ);
+	}
+#else // #if IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)
+	WARN_ONCE(n, "Non-zero rcutorture.test_nmis=%d permitted only when rcutorture is built in.\n", test_nmis);
+#endif // #else // #if IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)
+}
+
 static enum cpuhp_state rcutor_hp;
 
 static void
@@ -3297,6 +3323,8 @@ rcu_torture_cleanup(void)
 		return;
 	}
 
+	rcutorture_test_nmis(test_nmis);
+
 	if (cur_ops->gp_kthread_dbg)
 		cur_ops->gp_kthread_dbg();
 	rcu_torture_read_exit_cleanup();
-- 
2.38.1

