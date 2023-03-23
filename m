Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486056C5E19
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCWEkL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCWEj7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:39:59 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D0B2E0E0;
        Wed, 22 Mar 2023 21:39:57 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c19so25336051qtn.13;
        Wed, 22 Mar 2023 21:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FaC6lqA1+hxWMZLXGdossnkQMCIwT3AyBFn6G9k2cMY=;
        b=IP4pHIWCbnsnOYl4aeV7YcOd/2QwmpsonTQ/gl7XuwNELdEVtwBJn4PCOa/FWybMgj
         wY0N4keqvI4Eeil3vYjnVtyYeBKcmSW+ZW8A54HtHObwAtnFanuujza9pwfsrPo/UlAb
         cVfh04+Gee8guyvuogKtYVyoBXd7ijYLvH9uTxigkqQTnfjDQJSUEmVjvxNcEZRu5gjc
         O8nUyai42wAVWxyHxuQDU3rGA8uzYv9WmyGYDWwCAzY1xF8/OV8F/KUtL9J16RR7OK2E
         dR8CnxwpGGHxp5ol07czTYUo4ydf5pB2fgxnrbjYF+DcBO1/x7TdGRbX07LykNnuYkSv
         ZPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaC6lqA1+hxWMZLXGdossnkQMCIwT3AyBFn6G9k2cMY=;
        b=5VdHHX63ouP9l2ozY+EQdSiO+R/uLh8UgElNjSiE2jslj9mH6D79HBZGvCsasSSt3u
         fE6PdhFp+0PA97wt3PZY4NI5NBgp1ZKeAuA9mZA/QfgGD8aATHz1aGNwoM8wn/08cOSb
         2Id10heC0wy5QYFuCIPqR/j80ZqavidjyzSOPiek2PYlwxH0JA34FLgpM/OJYSbqrrUy
         nJ5nwAUf6bvyWd52rLgQ2VX85Z1VJs0POxiiR2b2ot+F40W8jzkNnA8+tGlMrcJnUV3K
         gGQRJPV0uGbEYpkRmoNjRzRYtldcsnYpTi0UemhrIbWuKRKidlczI8IqdP8+L1wubZKt
         5Abw==
X-Gm-Message-State: AO0yUKWPcp0go2LdbKBER8cwvYJNefse77i1xxAzfaFwU3yxCkDiSIxh
        ClT8nlTuSxePzrpvYxj1/g8=
X-Google-Smtp-Source: AK7set8sLlZ2FlsgD+ZSbzQxo9XvxL5NladA4oW+LOLYQCy1rJY8S90NIoBFESc11gL1hkC57VanhQ==
X-Received: by 2002:a05:622a:14cb:b0:3e1:6c7e:2ee0 with SMTP id u11-20020a05622a14cb00b003e16c7e2ee0mr8115671qtx.11.1679546397061;
        Wed, 22 Mar 2023 21:39:57 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b15-20020ac86bcf000000b003e393119035sm275042qtt.19.2023.03.22.21.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:39:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3186427C0054;
        Thu, 23 Mar 2023 00:39:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 23 Mar 2023 00:39:56 -0400
X-ME-Sender: <xms:HNgbZLtK6l20-fmk10xQgynxiLNWvJJ1szRDrq0_jRss6aNOvk6nCg>
    <xme:HNgbZMfvP9LciHJyBTeEiQ440uUvOAw_4dafiYcp4yHnvY32ErHyKZE1-uuMmD6kz
    j4kFdvEhiR6gHzSIg>
X-ME-Received: <xmr:HNgbZOw5eoutWf1kMwwSxBqh3b6QsaIQodYoeez4gn4_ooGNz5FX4QKCt-ZB2theePD1e32xrt-O5KuKd7UArpZWh60GwiH86XY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:HNgbZKMdiIVSHL79qYCMnsjpwo8if7YZepWjqJE9wOe2D1C1001s2g>
    <xmx:HNgbZL_UHA6MKsV2kWl7NNrg0gK5-XVWYGJ9tpqejCMKt84M7ln2cw>
    <xmx:HNgbZKXLZCyhvHplpMx5vuhuuYGOWD7hNq5ZAtlZ0zJBmlN8J4gaZQ>
    <xmx:HNgbZBeP2db519VHPlUlEzgly0bnk_MBOowBrDrP2FvEIfkGjTqmlA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:39:55 -0400 (EDT)
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
Subject: [PATCH rcu v2 05/10] torture: Permit kvm-again.sh --duration to default to previous run
Date:   Wed, 22 Mar 2023 21:39:30 -0700
Message-Id: <20230323043935.1221184-6-boqun.feng@gmail.com>
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

Currently, invoking kvm-again.sh without a --duration argument results
in a bash error message.  This commit therefore adds quotes around the
$dur argument to kvm-transform.sh to allow a default duration to be
taken from the earlier run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 8a968fbda02c..88ca4e368489 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -193,7 +193,7 @@ do
 	qemu_cmd_dir="`dirname "$i"`"
 	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
 	jitter_dir="`dirname "$kernel_dir"`"
-	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" $dur "$bootargs" < $T/qemu-cmd > $i
+	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" "$dur" "$bootargs" < $T/qemu-cmd > $i
 	if test -n "$arg_remote"
 	then
 		echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
-- 
2.38.1

