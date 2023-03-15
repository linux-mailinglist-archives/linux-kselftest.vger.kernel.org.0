Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDBA6BC1DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjCOXzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjCOXzY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:55:24 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD5561536;
        Wed, 15 Mar 2023 16:55:15 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r16so53879qtx.9;
        Wed, 15 Mar 2023 16:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678924514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JaJV0W3JpTKcuvbp4OnNcGpM+ZfLpz31BXaPlTpOHes=;
        b=LwTIMY/691Ca2SxnUr999kk1iyHrVvNB2X4RoKGJ0l5dMghNHWFOMYCN9I0hcp5fSz
         j7cFVsxJlONl5cR85L/bt2ajTlEuijKwFuBwkgwBg9cJVtJQ74IFYExNo+LCGE/V6UGB
         okT4wuntfBEduzFjTNNkBdXOOERuJCCabbfiWasdP36r2JC+9wVlq7DvPY7O5bbK66yh
         dyzwRlLElJgGoYJQzEBdEVMp1NqQTh4yFINJR+aiFcXvrYHEVhwU8V/OP1TloYjwKXE1
         ICuWdd9UCmf/6sFEAcb4kprJjMA7jm1UUAMcvSyZwKgDHDhqQ7zZR7l357gcjiME6gW9
         7gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JaJV0W3JpTKcuvbp4OnNcGpM+ZfLpz31BXaPlTpOHes=;
        b=qEWYT6BhNc7qb8ZSvPzOSmjlYut+lZoYVshGRqDfwWKzNiwy1fta4rkFb98pMOUtQq
         5wEFtV9yAmZVE66sTf8c1qOtDdqhelycix/15eSLZxegkP1Y6JgbgUSGOGDd+kmS3V+j
         0IK1D5/sCdn6aEgwFG/G7dXFLXF8KhZG04xHmIcmrMbDqOm3CtrG9Vxc2We786hQE6ND
         rS9YesZxAX34UcsXbZ38/RKhxm8WEzPz84+w8R2pT2XWCd+05BZJqlvZfnsbMDcE+Y+w
         y8wRgKFtmi5gGuEPnTkICyQMLHbkK55OCt/NVHSdHmfght2vgl5mlSJ+/0gotVcgCOui
         hYWA==
X-Gm-Message-State: AO0yUKWNWJ6xd6yTM2fUNZbZhlOmdE4Bcl1HCj6O+0OqSHapziEnM+uT
        +k6Bt16AtLeeKwelFlRWHbI=
X-Google-Smtp-Source: AK7set+bq9Fru+65rGY7BwCoLvKsiUQemXgyLiN3CLIR66H4yS3gnKeQyyf+auXz7XVyub9nNEyFOA==
X-Received: by 2002:a05:622a:89:b0:3bf:cfa6:55a1 with SMTP id o9-20020a05622a008900b003bfcfa655a1mr3493806qtw.12.1678924514546;
        Wed, 15 Mar 2023 16:55:14 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id f8-20020ac81348000000b0039cc0fbdb61sm4639549qtj.53.2023.03.15.16.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:55:14 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id AE50027C0054;
        Wed, 15 Mar 2023 19:55:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 Mar 2023 19:55:13 -0400
X-ME-Sender: <xms:4VoSZK3y3CA9ElTQuHUt_xGVSPS9_iYZfrIbuG0RCCGh_3q3DRzAxQ>
    <xme:4VoSZNHdjIXQ5R2vRRhjlT3I6liJcLzsnKLn4_zI5kx5H2koPdr0mCkR6OvmA8uLc
    AmoGy881HcsXlAlyA>
X-ME-Received: <xmr:4VoSZC6QUB419F7paT25IXTS95yRoTjs7gTTq74bRH7WeoDk5Ei4I39E-sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:4VoSZL0jIl2A3DOP51aSt1ASL_QuK_Wn_tOVuLgj-k-WwmD3Ds6n8g>
    <xmx:4VoSZNHJJGiTbxF7ysqzDqE-9sKLZdckp1CEOEkukM1Tcra4WAgUhg>
    <xmx:4VoSZE9QjjAMuUy64HIj8yNHNIuVhNg_0vKe6TDvLJkBPNiZev4ClQ>
    <xmx:4VoSZFF_tlRurZlqFBOdTmo0hC96ElO-Fb8vYNeLQod5Ar2T652Z3A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 19:55:13 -0400 (EDT)
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
Subject: [PATCH rcu 4/8] tools: rcu: Add usage function and check for argument
Date:   Wed, 15 Mar 2023 16:54:50 -0700
Message-Id: <20230315235454.2993-5-boqun.feng@gmail.com>
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
2.39.2

