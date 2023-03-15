Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3466BC1DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjCOXzc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjCOXz1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:55:27 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FFB5CECC;
        Wed, 15 Mar 2023 16:55:16 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id i24so65437qtm.6;
        Wed, 15 Mar 2023 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678924516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H/g9hELla+E2WCiG57rQXta1ANtz3zbn27MBRyeXeek=;
        b=BtgUmZx1vp0Hv27lp/KNyeaecN/0NWwaGaeI3t4tR0IYc3ZryCcGe0M6e0QAYuz8nE
         r+jebOvyJ3rdOVJCVWZqNHCKx0FKhvTChfY6Vmg0B2hsGyy+iVwwbdHYj2i43mYBbo+m
         zyWGeckzwM9j261GTD8wP9OEC79kwd3cPCwIpHijlLceJx5uMPK5hPkhDO7/j55c5+6g
         nndOIxceyE7T3ZiIuT/JSfJXvnzXhDzAn/LZU6d+kd+Z2jAUPDR5zLcQs46nVg/gtNkx
         Lbsvz3aFpqlxQxLOpi6q2w+7vAUsuPHV7v0c1yMwARqS1jmM/lr1gTW7l/N3gZg/uszd
         UARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/g9hELla+E2WCiG57rQXta1ANtz3zbn27MBRyeXeek=;
        b=CYc4bRbBhvQr2XIAZoz1aTHhOs9wCwC4zui1GwGpwNp9ug3k3gcJZ7iuJI8GEDSPMT
         Ys1+hnPCvWIyHKEReZcyQkWWV6Z6JJc1W2jt0TQdNaPQnZzPRVUa8esOhCOFIQXeaaEM
         35Pu1JoYYJ7lhgKjCZ7GM7gwWaussAv+OymYPVcYzGQOAe6di/6z8rrFXw6G6fUhdOKz
         lVtHUzlhmzGSEbujozBU2/4LA3EnqB1U1kWr9LJX2k7jGiy54uBcOasxK/9I4xr30guA
         yp7BaWJGq3waKaNmHgrTp5oJrKKerWhzCyfi4aFElN9Pltv1M1ounq6Z9YjbSS7lMxZa
         ZIuA==
X-Gm-Message-State: AO0yUKXsnQIr/TQ84kICZ2ZPeyQpWtiXdD/7d5zQo4keX8Mu4QJYFfN4
        nQa2lmSQQDm4aWVJAboYJUNlB3fgPiU=
X-Google-Smtp-Source: AK7set/E4rJbr7eKHqTf5BN+Mj+CB6owxZN5u/cB0dnRM4NqIu9VZC7UZRaMkhCp6+xM+/XXHRkDHw==
X-Received: by 2002:a05:622a:1a25:b0:3b8:5057:377b with SMTP id f37-20020a05622a1a2500b003b85057377bmr3054365qtb.65.1678924515895;
        Wed, 15 Mar 2023 16:55:15 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z9-20020ac86b89000000b003b9bb59543fsm4623645qts.61.2023.03.15.16.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:55:15 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 018FB27C0054;
        Wed, 15 Mar 2023 19:55:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 Mar 2023 19:55:15 -0400
X-ME-Sender: <xms:4loSZA1O-roGWH9HBuBpCXIgv6_KFDmZaf0RM9QOwGJjMdLpQ1RNdQ>
    <xme:4loSZLEFpQC8CgPTbh9QRUtdsfXkrqIu6a0L2TCPdbCp8JSfmsDt4rnAagnS7mbmw
    ZFMA-Wyqm_ySpgMyg>
X-ME-Received: <xmr:4loSZI7K7D1_p0F0wv0VbNV6XQ0znmiaQo_7wfGr34apt_w8l4Z57_3ev9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:4loSZJ0-mT9dlcArsPbHk5UwHCC4eTuugnTV_OXWHPFxcWf0sRi4Tg>
    <xmx:4loSZDF7gN2hrIGCRpccznn-O25fhk0MTGxgmIKCJr3Mq9OrQz944A>
    <xmx:4loSZC8WdU53DrH2My2ZytN-Hk1JxJn3lyUeXblYwKyxokXnS9c1ug>
    <xmx:41oSZDFg5HFIgYdAx_yUXY6uD8PshLO2TjbqwB4mz7c5DTHeDduzUw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 19:55:14 -0400 (EDT)
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
Subject: [PATCH rcu 5/8] torture: Permit kvm-again.sh --duration to default to previous run
Date:   Wed, 15 Mar 2023 16:54:51 -0700
Message-Id: <20230315235454.2993-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315235454.2993-1-boqun.feng@gmail.com>
References: <20230315235454.2993-1-boqun.feng@gmail.com>
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
2.39.2

