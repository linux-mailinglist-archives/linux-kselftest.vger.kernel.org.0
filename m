Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28F26C5DF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCWE0p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCWE0l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:26:41 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06192231CE;
        Wed, 22 Mar 2023 21:26:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s12so25286194qtq.11;
        Wed, 22 Mar 2023 21:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679545592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5S62Y7aGNi4D2I6NuRPT2zIYY8rxE7q2KUx5uJfic1c=;
        b=kk4foQ5cUez7Q/oiDN/UXNlIrxxKo4KIWvzA92IiWkcQHqZRlSZSQ8Ao8nUkMOTjzr
         FCyqMnEsxvvwV7V2DbywfboQs2mlt1DbMEr5qx+rk1iUhVJzo6X2zWwsU7DYmza3Dh8L
         Umpv9zqiP22nRhb9/yfEmW6XKIF6FLxHVzfLAmqByAixnMxJiqdOSuKLnl9NLryaagyR
         VO8thFWslhb7nNfbqHiERNKgwxtfJ0JsDM1QUOFVu10WDHo/SY+rMdPs1bLiqf3MlWHD
         btfrXf4ZYZSUWOdpJORD/xbwwvDPjl0RBvt2L1C958BMkxxCl94/Pb2RCZ1ymeQQ2RWn
         pWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679545592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5S62Y7aGNi4D2I6NuRPT2zIYY8rxE7q2KUx5uJfic1c=;
        b=Zg6vQEem6JmI0jRnXpRfYBnZ1Hhu4r1N69eRPPWJoPOZDDeuU/gOs5rAZU/MkzAMPc
         3iMqTKeWUHzK4afMwUDcLksVXy60T1YPnq0jVy+7bYyuEVxAVIhFePgz2/Vl7eG2vWN6
         lME4qX5AbL04DYl5OPf1V3AQdIUQW4L2cTDuw9bp0LMFJ/bsgs5obJps+xUpatmfc44i
         +5Yn2B6A+RVk8IzCNSDtjMPNdaeC+fR8pZ7V2KBB49+67PK9ygXc069iD9znD2ilC8M3
         xKpat3KWTBu2AzcknbHpc7llaW+AiNiVyjGxU8IinEbsgX9oatZVWnwSoJgeBcleHD8C
         +SPw==
X-Gm-Message-State: AO0yUKVpEAY+co9kDGi5o3cqTkAPxrKEsFcx5RvcqNgo2MwyMLhBKWj1
        zljLgRteHaDYPmDFPEecEG0=
X-Google-Smtp-Source: AK7set8pLmScoz61lyaelKl/XvtQOLXjV1jHCbylxOnTNY112i4/NMiid4SJ4puYLBZcDeFHyrsAdA==
X-Received: by 2002:ac8:5ac9:0:b0:3e0:d161:29b1 with SMTP id d9-20020ac85ac9000000b003e0d16129b1mr6906050qtd.24.1679545592087;
        Wed, 22 Mar 2023 21:26:32 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 142-20020a370494000000b007468cc74c77sm6600464qke.4.2023.03.22.21.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:26:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 02DC027C0054;
        Thu, 23 Mar 2023 00:26:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Mar 2023 00:26:31 -0400
X-ME-Sender: <xms:9tQbZKRYtcZgY82AgNODEE-EjGJBUKS8BxNId4UI4b2eOz2U7OIGbQ>
    <xme:9tQbZPwxAMBQ3pyppqqr9Ff-Gar3tv850bIT_f-D0vFxM-3vFGiCuo1rjd9B5P_mY
    T5qR587z21-YexuZA>
X-ME-Received: <xmr:9tQbZH0IroAKbicK35nLnJnfNQGcQeHg6TeQ3oHMYVhJshmmTsFlOz_lxC5IVgyjl8ikOMlyVYZ9KmCwqVSUD_-FOmaSmBaUS5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeu
    gfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:9tQbZGBX2aOHTZXZJ-cVdXLuG0BcfGRJYKrAn0K-mTATQUF3r56XlQ>
    <xmx:9tQbZDg4zhC5fX1_T2EKeqPHFhYozOCl9qqnbtVgcT-SJvSzVNYlmA>
    <xmx:9tQbZCrc1lI7LDO38twTFVYNyQsmmOsBTIiIRcL6YENo7QfMSvdvww>
    <xmx:99QbZMaOYD06ob9yq3tZZaHJLXfoSrWG2j8PSAlB9yI0R96Fyu07cA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:26:30 -0400 (EDT)
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
        linux-kselftest@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu v2 3/7] locking: Reduce the number of locks in ww_mutex stress tests
Date:   Wed, 22 Mar 2023 21:26:10 -0700
Message-Id: <20230323042614.1191120-4-boqun.feng@gmail.com>
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

The stress test in test_ww_mutex_init() uses 4095 locks since
lockdep::reference has 12 bits, and since we are going to reduce it to
11 bits to support lock_sync(), and 2047 is still a reasonable number of
the max nesting level for locks, so adjust the test.

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202302011445.9d99dae2-oliver.sang@intel.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/test-ww_mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 29dc253d03af..93cca6e69860 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -659,7 +659,7 @@ static int __init test_ww_mutex_init(void)
 	if (ret)
 		return ret;
 
-	ret = stress(4095, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
+	ret = stress(2047, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
 	if (ret)
 		return ret;
 
-- 
2.38.1

