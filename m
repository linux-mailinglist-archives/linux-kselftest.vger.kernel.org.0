Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951C61FB99F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 18:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbgFPQF1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 12:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731892AbgFPQF0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 12:05:26 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E16A9208B3;
        Tue, 16 Jun 2020 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592323524;
        bh=ks7oTR0dBTQho5wZY/4P/pQhNNKKTFFjsmkw85qYz6Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=koMKw2eneymdxBBwylQeANO4EeVqfIW0oXVEJT85TpOyONSkg48r2Vw8Tpf57ZNks
         D3b/RGk2uuFRgNkmI2Z+lraBQ/LejOijnqRZdIwgEDfV+gvvqDEDAgYh+im3a+iyWL
         7domg38gechKdK6aBPfRwvq2tCrUDCQJEH4803hA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C97DD3521103; Tue, 16 Jun 2020 09:05:24 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:05:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, shuah@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] torture: Pass --kmake-arg to all make invocations
Message-ID: <20200616160524.GW2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200616094924.159539-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616094924.159539-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16, 2020 at 11:49:24AM +0200, Marco Elver wrote:
> We need to pass the arguments provided to --kmake-arg to all make
> invocations. In particular, the make invocations generating the configs
> need to see the final make arguments, e.g. if config variables depend on
> particular variables that are passed to make.
> 
> For example, when using '--kcsan --kmake-arg CC=clang-11', we would lose
> CONFIG_KCSAN=y due to 'make oldconfig' not seeing that we want to use a
> compiler that supports KCSAN.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Queued and pushed, thank you!

Would the following patch make sense, at least until such time
as some other compiler supports KCSAN?

							Thanx, Paul

------------------------------------------------------------------------

commit 88bcaa730b6d40ddf69b09ed6f0a14803d087d99
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jun 16 09:02:34 2020 -0700

    torture: Make --kcsan default to using Clang 11
    
    Currently, Clang 11 is the only compiler that can support KCSAN.
    Therefore, as a convenience to the KCSAN user, this commit causes
    --kcsan to specify Clang 11 unless a "CC=" argument was already
    specified via the --kmake-arg argument.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 446f680..f8c6cfa 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -34,6 +34,7 @@ TORTURE_KCONFIG_ARG=""
 TORTURE_KCONFIG_KASAN_ARG=""
 TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
+TORTURE_KMAKE_KCSAN_ARG=""
 TORTURE_QEMU_MEM=512
 TORTURE_SHUTDOWN_GRACE=180
 TORTURE_SUITE=rcu
@@ -144,6 +145,7 @@ do
 		;;
 	--kcsan)
 		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y"; export TORTURE_KCONFIG_KCSAN_ARG
+		TORTURE_KMAKE_KCSAN_ARG="CC=clang-11"
 		;;
 	--kmake-arg)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
@@ -214,6 +216,11 @@ else
 	exit 1
 fi
 
+if test -n "$TORTURE_KMAKE_KCSAN_ARG" && ! echo "$TORTURE_KMAKE_ARG" | grep -q 'CC='
+then
+	TORTURE_KMAKE_ARG="$TORTURE_KMAKE_ARG $TORTURE_KMAKE_KCSAN_ARG"
+fi
+
 CONFIGFRAG=${KVM}/configs/${TORTURE_SUITE}; export CONFIGFRAG
 
 defaultconfigs="`tr '\012' ' ' < $CONFIGFRAG/CFLIST`"
