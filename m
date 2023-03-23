Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86506C5E16
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCWEkI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCWEj5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:39:57 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EFB26864;
        Wed, 22 Mar 2023 21:39:55 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id q88so7235613qvq.13;
        Wed, 22 Mar 2023 21:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rpd6Nuq+zKvvgRPPpUZyvF1zFoaLkJFZfbVONMKqf1k=;
        b=ZtUacI0K1D1dkHPegq3R0xQXH5D6iYly/yNMtSCqRLSggNjIaNCO+DrMYdCMROZHor
         30SUFRWDYr9ZPwjDWEfN/WMS0xfgQjHPfMFgag1qEUEL3JwMptZfhl0P9t8fVXwl4Ufp
         Begvrh8V6tpCZnMYR9TUOnSBWdkO9HIVW1IQrLFO04cfmqwte2/x/lOKZj//owgI8heW
         T9EP6QSfexXoK79ECQzFknv9CzwKtlLifKXoOPrF0BahMmayK66jgCy0DW4uYjbtR9+H
         ezIpeHjN9m1qnr4auK3dznk/6wbk4y9sx2KohpReWGrPQjuJ+EG6B2q3ovDcoWD6Agdq
         YshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpd6Nuq+zKvvgRPPpUZyvF1zFoaLkJFZfbVONMKqf1k=;
        b=i+gRrA+MHHukRh9LW9r/Bp8QSWYXkOUZJwJiRQJuhxwcrJLhK7/I38d1+FRDtmTwq8
         LVS98/nX6NEQwYS0JkbxQ9HA29g/fmYcS0Dr9jQ1LzQ9aapRZVGkhNVyM/p/Dy7T1cLM
         +iYDGXDaoyNaVETjzozQCaojqDown6tJ/Ygx9jrBiAlLDWHhD/y/j43nxFIA/T83gV/9
         wX+En8cgkOd27N+OGa4OGNLzTDB3gxrQ+U7EYxswRJCgSylrBeLXpAmQNOB0kZqtLjwz
         v61SvxIxwTu68tgDJ0CROkDI0slATmaYaBI2bKlce+7wBhn53it5gQdUJLuyRM1RmvHA
         bmjw==
X-Gm-Message-State: AO0yUKWJUINja/ZELfprwp1yNHNChyC9AUYE0zY7j3el3IyBT4Z8M3dy
        c+FlHvxQR+/svsRip6tAIWY=
X-Google-Smtp-Source: AK7set8X41D30DAr+Mb9Do//dk5O1nr2/Nkp0CUzIqGv3Ethb83zt+v3g7TV9csGvp2sp/I3EaRAjw==
X-Received: by 2002:ad4:5d6c:0:b0:5ac:daf1:1ac1 with SMTP id fn12-20020ad45d6c000000b005acdaf11ac1mr10613633qvb.27.1679546394531;
        Wed, 22 Mar 2023 21:39:54 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w2-20020ac87182000000b003b9a6d54b6csm11121127qto.59.2023.03.22.21.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:39:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A905A27C0054;
        Thu, 23 Mar 2023 00:39:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 23 Mar 2023 00:39:53 -0400
X-ME-Sender: <xms:GdgbZLZDlFfldtMlo1I3uBZnuU5FlI21UeDAVg1nXkZtwnpcYd7vlA>
    <xme:GdgbZKZ0tAZuU7bDoV_L54FYo9em-ztnd4UnR4gjDZvARL2Aj_bz1SS6xi-EZsfGK
    ZRNce8yGaZqpkuh3Q>
X-ME-Received: <xmr:GdgbZN8mC3BHog46cRSkceV-nI2P6fSSK_c3SF_K8Yvq5ACdjpvveVyKzFvJvvvAxN6jnoCYBZTgm92OTbzqmIaWCInpTaAC4RA>
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
X-ME-Proxy: <xmx:GdgbZBpTIzZKV_r6GR4qWEuA7Av-KcqMd8-6L1GZYjeYdD-jRMkwPw>
    <xmx:GdgbZGqC7y0LI3toZYE3o9kr7WfpNCx-2a9HQ-jXABgBLO78tQVw5w>
    <xmx:GdgbZHRfxGT_viAomcANeLbCnP7c3RcjOYLsx4sKEBavjW1Xworhow>
    <xmx:GdgbZL6M-BHRefOg_96W4QNlqkUdMyM8WzXNkzQ-E675poKXSkkGnQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:39:52 -0400 (EDT)
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
Subject: [PATCH rcu v2 04/10] tools: rcu: Add usage function and check for argument
Date:   Wed, 22 Mar 2023 21:39:29 -0700
Message-Id: <20230323043935.1221184-5-boqun.feng@gmail.com>
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

From: Bhaskar Chowdhury <unixbhaskar@gmail.com>

This commit converts extract-stall.sh script's header comment to a
usage() function, and adds an argument check.  While in the area, make
this script be executable.

[ paulmck: Strength argument check, remove extraneous comment. ]

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/rcu/extract-stall.sh | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)
 mode change 100644 => 100755 tools/rcu/extract-stall.sh

diff --git a/tools/rcu/extract-stall.sh b/tools/rcu/extract-stall.sh
old mode 100644
new mode 100755
index e565697c9f90..08a39ad44320
--- a/tools/rcu/extract-stall.sh
+++ b/tools/rcu/extract-stall.sh
@@ -1,11 +1,25 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
-#
-# Extract any RCU CPU stall warnings present in specified file.
-# Filter out clocksource lines.  Note that preceding-lines excludes the
-# initial line of the stall warning but trailing-lines includes it.
-#
-# Usage: extract-stall.sh dmesg-file [ preceding-lines [ trailing-lines ] ]
+
+usage() {
+	echo Extract any RCU CPU stall warnings present in specified file.
+	echo Filter out clocksource lines.  Note that preceding-lines excludes the
+	echo initial line of the stall warning but trailing-lines includes it.
+	echo
+	echo Usage: $(basename $0) dmesg-file [ preceding-lines [ trailing-lines ] ]
+	echo
+	echo Error: $1
+}
+
+# Terminate the script, if the argument is missing
+
+if test -f "$1" && test -r "$1"
+then
+	:
+else
+	usage "Console log file \"$1\" missing or unreadable."
+	exit 1
+fi
 
 echo $1
 preceding_lines="${2-3}"
-- 
2.38.1

