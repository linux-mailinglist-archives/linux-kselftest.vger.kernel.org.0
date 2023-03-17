Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B716BDF64
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 04:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCQDPV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 23:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCQDOK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 23:14:10 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FC31F5C9;
        Thu, 16 Mar 2023 20:13:58 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r5so4364646qtp.4;
        Thu, 16 Mar 2023 20:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679022837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jKjJq2iUpcRiss0xHIuELyHg6cgOJsVnKIWh6aQhr+o=;
        b=njafY3YZ1bwUF3TeJHoNWVte22ueJDvEHAowKhGDAgj8LwGRayCDFY5PH7yaCbD6oj
         O16shgk91L3XgnvllCZAOjXOg1Qh+KG8EGr+oVe79lyufQGc14y7XKQC2JRMf2QWLyJZ
         4YrKrEhzc0mShfnIo+oQVMqMVS29OJERYPs6yxdr0eMRpbON4Sju6ORKorSonHgV8Zlk
         samPgrFoM1mUqMIY6YKRp9x33r7ZE2znHBgf0UC+fKvmjzZUhrqVc30CYe54fSual9VR
         6Mm0LGf6fHvO+Qvm3J5ey2eCLmRofDsJcTHBEwOli/5K5H0F497tfoKgD+XJiwYN/eeI
         accA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679022837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKjJq2iUpcRiss0xHIuELyHg6cgOJsVnKIWh6aQhr+o=;
        b=NMxaqKUp7WSRjUWajQ3YWOT3yMfVhJkTPXf0rZ2omm2s726PO+AeCTiB71cnctJqFU
         HhswX0RHW/sy2VUW6bFZFGMiPe8WFU3qQfbx9dlhJ+bC/wvOczhOzD713DCbeHREagAG
         R8o1X+6VFVoQIBk5B82ZDozmpz6Ob2VzYANuH3ITrdnPuMNnxPOYdrRlj0+QyW7IDBgg
         MrZsB1xR8jJNRtb2SE+zY7v30N2aonS6ItxdTvx/fa3MldIXukjnmdYTDm3MYIB8nJPZ
         REHG8EaZaXMq1wbh7eTHWw848ve+WknFX/jHIvf723z0SyF7jsRUKnUOxGyJAtHzXUz2
         otrA==
X-Gm-Message-State: AO0yUKWqqgPib9OMbh3/uzFL2BNNa+maUm6c8PEg01x3FHyVK3mDcBLU
        KPPZzyVRVRrIyoECdbEa8eE=
X-Google-Smtp-Source: AK7set/4OLOuuf9LGJVCwC5AGdthelLPVlzBzvqm+tbNbpmadOqoU9PKPGF0SRYTn/QuVCVvy4+Hyw==
X-Received: by 2002:a05:622a:24a:b0:3bf:d87d:4945 with SMTP id c10-20020a05622a024a00b003bfd87d4945mr9981933qtx.18.1679022837771;
        Thu, 16 Mar 2023 20:13:57 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d20-20020ac85354000000b003b323387c1asm814466qto.18.2023.03.16.20.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 20:13:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id C2E4127C0054;
        Thu, 16 Mar 2023 23:13:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Mar 2023 23:13:56 -0400
X-ME-Sender: <xms:9NoTZPtLeoqFZxx5bqcWLVTdycR1xboaPoKKf40BJGZSoPmnn0_KsA>
    <xme:9NoTZAf4r9NjzyGnlzh8qLAVFY042ZGgF4FnTgi_cdN2WYeVefV1fvtEytBqmscyW
    Tz-Syb75ShCEPbpZg>
X-ME-Received: <xmr:9NoTZCw9l-rfYqLZ3fKBrsP8k7vimEE34Z-hAt_5hc9pfdVUHFipC-5xXeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:9NoTZOP_zZTty0uVojoeQfJuk_E4DCdVGww0N7N_wN3iw26PXPEdRg>
    <xmx:9NoTZP-pI2v_Et0yEmziLpxjgCbnJDFCfd6y0gp5Udphv0jiGiRUqQ>
    <xmx:9NoTZOUX5QJ9f-WB1No1281Da4aTX6IgGtWYreVH-qNHr7ck3dpFzw>
    <xmx:9NoTZKeeuXYjFcNULRxNy98QCprNmp1hn_L5XBwqDGBEdmAR5TpQiw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 23:13:56 -0400 (EDT)
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
Subject: [PATCH rcu 7/7] rcutorture: Add srcu_lockdep.sh
Date:   Thu, 16 Mar 2023 20:13:39 -0700
Message-Id: <20230317031339.10277-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317031339.10277-1-boqun.feng@gmail.com>
References: <20230317031339.10277-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../selftests/rcutorture/bin/srcu_lockdep.sh  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
new file mode 100755
index 000000000000..961932754684
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -0,0 +1,73 @@
+#!/bin/bash
+#
+# Run SRCU-lockdep tests and report any that fail to meet expectations.
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
2.39.2

