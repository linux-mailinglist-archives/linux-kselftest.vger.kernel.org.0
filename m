Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4826C5DFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjCWE1e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCWE07 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:26:59 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721462E818;
        Wed, 22 Mar 2023 21:26:43 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id t13so13509687qvn.2;
        Wed, 22 Mar 2023 21:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679545602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=efDV6U2zyYsMsWuuNQGofNGAB5NUHCq/yzKFmIivv8E=;
        b=EuoSntJP+ybxGT+2QlpkWUO0yz8DQ7K1K3tKDrgYb2xjx7IqM+H8njWpp0xFMyYrxf
         g9G4vjKNb1lHKQ5vWJpj5sM/R2hQWNJfQnsJBFRz9u/8qvzQRaetLGhwOGC1t5fXM/Dn
         lnhrLq4M/6b8pINZ9LmA1WK9rVrOxvqwa4jDSL6NxXFG0U8Xvjjl4koVv8qGChG0+798
         xx09cls9eGo0Pvj6PuVzgKTj14Kug/Y6Mh3pLqEHI8eAf22CUB1ZT5tZGaMcjGmPSlTM
         KNcrwxrhkvAshQuv6B/iyamjy0ERhEGbSddIr4WwIeiTfIM0yMlrIpGhVyWVlrPmZrCU
         ZK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679545602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efDV6U2zyYsMsWuuNQGofNGAB5NUHCq/yzKFmIivv8E=;
        b=2YuGO6yw+piarOfZsL1e0xTZlhF287ZUQERBYRaiY7+JNmmeW3a7C9hktHohgMlRBC
         jnCSMaYeODFkLG/PvtZxeey5gyVbdFvNKsVMwI0mXDyLc5WDFqkIiqYSQxQPKdOjSyDH
         5BiLcwm8OlgTnVhvv8RHq0akBe6Vm02gKnb1fNVPuQDTgF3SOHQzWrWeQDS6DjPAT0Gd
         Z5DPdVAQOCcm+Js9Mh+XXTPkx/Z7PTG8ZbCGIyoGGugBxnQmdu2Bd9NPbhcNE01wI4k8
         gOtQSoMWDxbmzdXAycT1oYzrglxGTueyHoSnO2ByKP0r5v43emu3cVontlWIZL8fBGd7
         1/mw==
X-Gm-Message-State: AO0yUKU5y2YyIlkrDRug/3rwl5m9M/+jQ0egqGzWD1sm8Qd3VLzoiDJY
        zbkflv8T/nCT36xElUUBFEA=
X-Google-Smtp-Source: AK7set+H2pOotiMoDnvduIG03T6vAWGX7brsAgDlEd1lYq2+3HpbybydQ59Yn31yibXBlpO3hSqbNg==
X-Received: by 2002:a05:6214:1d2f:b0:5c2:3e10:53e4 with SMTP id f15-20020a0562141d2f00b005c23e1053e4mr10947113qvd.15.1679545601710;
        Wed, 22 Mar 2023 21:26:41 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a040b00b007468733cd1fsm1690872qkp.58.2023.03.22.21.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:26:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id AF41B27C0054;
        Thu, 23 Mar 2023 00:26:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Mar 2023 00:26:40 -0400
X-ME-Sender: <xms:ANUbZD7kC798jLkomc-3c5kSiXxKgYs2sAjPRI2I2agB_UB-sFoCGg>
    <xme:ANUbZI7-PXxDTtD8UQSRdXtuOAOSC38V0lEyDu8eT2R0V5cz7Q8WX0HWkQ7la2YDA
    B3CZMosC9gtGcBcqQ>
X-ME-Received: <xmr:ANUbZKdOYV_vP--40pTAKFMxKHrf24CpIQ89UqLyFn4hx6jOd-Aar7_lNcM7zbFJdh4DcjfGi-UDxQr_wsSqVHuqFL1RYmEyxG4>
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
X-ME-Proxy: <xmx:ANUbZELz76GVtqN7TX5wcqCIGd7zCO-dpY5ToByzklPEh5Xbcdp7VQ>
    <xmx:ANUbZHKj00AWKhu9Vk4rjOMbAdb2QONAYWOm60T2hSRsmMssxHGhdA>
    <xmx:ANUbZNyf88gUgbYVjhWk9PDAr78rEBWsNVR6oY7tvwJ-k8FwZotiqg>
    <xmx:ANUbZPIfYj57KUAOPoIfyCQJ0kHXea_3pf5bnqwSrxdZCk2gRh2Rsg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:26:40 -0400 (EDT)
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
Subject: [PATCH rcu v2 7/7] rcutorture: Add srcu_lockdep.sh
Date:   Wed, 22 Mar 2023 21:26:14 -0700
Message-Id: <20230323042614.1191120-8-boqun.feng@gmail.com>
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

This commit adds an srcu_lockdep.sh script that checks whether lockdep
correctly classifies SRCU-based, SRCU/mutex-based, and SRCU/rwsem-based
deadlocks.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ boqun: Fix "RCUTORTURE" with "$RCUTORTURE" ]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 .../selftests/rcutorture/bin/srcu_lockdep.sh  | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
new file mode 100755
index 000000000000..2e63ef009d59
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -0,0 +1,78 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Run SRCU-lockdep tests and report any that fail to meet expectations.
+#
+# Copyright (C) 2021 Meta Platforms, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+usage () {
+	echo "Usage: $scriptname optional arguments:"
+	echo "       --datestamp string"
+	exit 1
+}
+
+ds=`date +%Y.%m.%d-%H.%M.%S`-srcu_lockdep
+scriptname="$0"
+
+T="`mktemp -d ${TMPDIR-/tmp}/srcu_lockdep.sh.XXXXXX`"
+trap 'rm -rf $T' 0
+
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
+. functions.sh
+
+while test $# -gt 0
+do
+	case "$1" in
+	--datestamp)
+		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._/-]*$' '^--'
+		ds=$2
+		shift
+		;;
+	*)
+		echo Unknown argument $1
+		usage
+		;;
+	esac
+	shift
+done
+
+err=
+nerrs=0
+for d in 0 1
+do
+	for t in 0 1 2
+	do
+		for c in 1 2 3
+		do
+			err=
+			val=$((d*1000+t*10+c))
+			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --bootargs "rcutorture.test_srcu_lockdep=$val" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
+			ret=$?
+			mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
+			if test "$d" -ne 0 && test "$ret" -eq 0
+			then
+				err=1
+				echo -n Unexpected success for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+			fi
+			if test "$d" -eq 0 && test "$ret" -ne 0
+			then
+				err=1
+				echo -n Unexpected failure for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+			fi
+			if test -n "$err"
+			then
+				grep "rcu_torture_init_srcu_lockdep: test_srcu_lockdep = " "$RCUTORTURE/res/$ds/$val/SRCU-P/console.log" | sed -e 's/^.*rcu_torture_init_srcu_lockdep://' >> "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+				cat "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+				nerrs=$((nerrs+1))
+			fi
+		done
+	done
+done
+if test "$nerrs" -ne 0
+then
+	exit 1
+fi
+exit 0
-- 
2.38.1

