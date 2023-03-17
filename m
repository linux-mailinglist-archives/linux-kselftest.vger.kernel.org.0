Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E946BDF66
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 04:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCQDPX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 23:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCQDOI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 23:14:08 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E131C5A5;
        Thu, 16 Mar 2023 20:13:53 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id qh28so2694872qvb.7;
        Thu, 16 Mar 2023 20:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679022832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l+cxk4GRXEy3PWXlv26d2F3VWdrTeh7XQDcb/gZHyn4=;
        b=WV+SSosX+LSP9x5dty+3YbEqmAPAUQDCF83larBgi6og0Aw5VjpVorLzHq30Wq/RY6
         ZZJOw7VnBBtpMlzBp8mNUlK/bn5X+i4O0nRjl8DkcLucOaApZ9TvMDNzHm+JFJQ8K/Nw
         kHiJTtQ8QFuJ3w2elqBwXPp5rwdnCZ6buC3Wm3CHxXI9YM6K/GGjXffMZfk70udXzdLL
         aBDJEN/CvRzhXzbSU6waNKe5NHsz4YWq7TcjCXxKd/fAH92Ki9d9xxEeuilhezTgiEic
         Cf2+bNs2tpekPqsYP2zbBsQaPHsCLasyqk8+TN2jhtWJ4ZGsI24TfrjRaFC7cG9wYlX0
         VaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679022832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+cxk4GRXEy3PWXlv26d2F3VWdrTeh7XQDcb/gZHyn4=;
        b=BigdZcoQ7sQC5jrOeJGDtqfueafE7inoDahc1mzVQqOGB0ZODRuqP2iNkzMwsAKN8C
         d/14cqpTP2P0qFp0bSeY0H44MWxIsB3TcQOkpgcF/VxlnG7li5IFVYQJa2fAaVITmyfD
         dTdGnlc4no1JG1mVbXQvMoycsS2JwuKlIoWyV8h54I5wsjnVBY1ERFi4BfUTzc0Su6Et
         jAPf21MAJaj/gpbfVu3XXZjc5B/YFY0qhPUwBDoqFe8qyWw5rMmkLulCR0KfhluSnEpy
         5uXkR03svxrDK/ONuoDGd+baNHG+IISWe9MVNC2BQKCoXSWcab7mbZWg/lP3zHcNLXbd
         +SDQ==
X-Gm-Message-State: AO0yUKUkoX72yxqL9URusBAQEn/hTpsYKQaXqqg6SwM4rptBmYoPEr4z
        8MliEGyEoFnh73taGGC4oLg=
X-Google-Smtp-Source: AK7set8RP3+6SAfsQgJ4ywKwsYSMSkHSN8UMChqof//OKVEdbhULyWO1xA3rWns2AUHAI7suuCxJRA==
X-Received: by 2002:a05:6214:1d01:b0:577:5ffe:e0d8 with SMTP id e1-20020a0562141d0100b005775ffee0d8mr44428281qvd.24.1679022832634;
        Thu, 16 Mar 2023 20:13:52 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g2-20020a37b602000000b0071aacb2c76asm781448qkf.132.2023.03.16.20.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 20:13:52 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8819027C0054;
        Thu, 16 Mar 2023 23:13:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 16 Mar 2023 23:13:51 -0400
X-ME-Sender: <xms:79oTZCGaCtq3AZq4NKLvRr-3rLcQ3T0N9h0s3hP2cDAy2W_T10UaYA>
    <xme:79oTZDViX1nd8LA_k7XN1uVmra6UHO1MBYmcx0ANKU3fX2n5aYRjijQPk75MWDjVP
    FY1RZzvQNIS6O-Ffw>
X-ME-Received: <xmr:79oTZMLGFDZRU6moEEkUEkqekDvOytytX3plUMpMTnH1hT5u9l7xIw7Q8N0>
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
X-ME-Proxy: <xmx:79oTZMFYJm1mrOHEuTb5D002r9YhCIinrYN5M811w3BEANGt_JS_kQ>
    <xmx:79oTZIX0QFnPvPkZl-dnh2JRjRoH-mYVvlKxDpaiasZoZ_eqpnC37w>
    <xmx:79oTZPM22p0wfNDQyDSQfkDNqQXKzuxW_P4t2XCeFNjkAoEPqsvJHQ>
    <xmx:79oTZJeoVMbKBXxhQVr2wtxhBk7gcHDmRmI2tuFdp-oskznImSx3OQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 23:13:51 -0400 (EDT)
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
Subject: [PATCH rcu 3/7] locking: Reduce the number of locks in ww_mutex stress tests
Date:   Thu, 16 Mar 2023 20:13:35 -0700
Message-Id: <20230317031339.10277-4-boqun.feng@gmail.com>
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

The stress test in test_ww_mutex_init() uses 4095 locks since
lockdep::reference has 12 bits, and since we are going to reduce it to
11 bits to support lock_sync(), and 2047 is still a reasonable number of
the max nesting level for locks, so adjust the test.

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202302011445.9d99dae2-oliver.sang@intel.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
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
2.39.2

