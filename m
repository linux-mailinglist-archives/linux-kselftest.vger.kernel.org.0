Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032096C2272
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 21:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCTUWe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 16:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCTUWd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 16:22:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8878130B2F;
        Mon, 20 Mar 2023 13:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CA57ECE13E1;
        Mon, 20 Mar 2023 20:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105FFC433D2;
        Mon, 20 Mar 2023 20:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679343745;
        bh=CveMy0+pCgXXZvzKhxyxVeH/jvFaXFhg92cxgaOQxik=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i4uHDRkPBxUmKMAmrfWWhyvXDFj9Ra80BvZIMfgNtJthD5t0qmeXOlPMOZ57+ejMx
         /tGY1mTM6v2B3pyrXXaLY6vcE1fNMhQ5x1crN9d1Ucuif5RSk0hS8fxCqIhjvnPC17
         Aps0aMDSqnUnPg5XGWtoQ/9Be850cd/VfjCXCB+7yrlgaxEW5Vof1yHl2rAaiUKLEr
         Z0vuo0xdfSu+cB+nev+D7Wibq63j8OxSNHuKVh12a/tGhF+qJl2wi2SCnt3s1S1vJM
         MTviY8yFxiiUavuzvbZ2r2sSh+bL8HmK7HTrvnbs+kvWhbk4fahTJXFOvTd4u1leRv
         NWXYm7k06nvqw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A96AF1540395; Mon, 20 Mar 2023 13:22:24 -0700 (PDT)
Date:   Mon, 20 Mar 2023 13:22:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
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
Subject: Re: [PATCH rcu 7/7] rcutorture: Add srcu_lockdep.sh
Message-ID: <15e799a8-0e63-4bd9-9a01-028c9d906904@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230317031339.10277-1-boqun.feng@gmail.com>
 <20230317031339.10277-8-boqun.feng@gmail.com>
 <ZBijmdz2ucql+BSb@boqun-archlinux>
 <bed30db4-d998-4382-a9a1-716c6f428263@paulmck-laptop>
 <ZBizxQ9BY/hQk8+Y@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBizxQ9BY/hQk8+Y@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 20, 2023 at 12:28:05PM -0700, Boqun Feng wrote:
> On Mon, Mar 20, 2023 at 12:09:00PM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 20, 2023 at 11:19:05AM -0700, Boqun Feng wrote:
> > > Hi Paul,
> > > 
> > > On Thu, Mar 16, 2023 at 08:13:39PM -0700, Boqun Feng wrote:
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > 
> > > > This commit adds an srcu_lockdep.sh script that checks whether lockdep
> > > > correctly classifies SRCU-based, SRCU/mutex-based, and SRCU/rwsem-based
> > > > deadlocks.
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > [ boqun: Fix "RCUTORTURE" with "$RCUTORTURE" ]
> > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > ---
> > > >  .../selftests/rcutorture/bin/srcu_lockdep.sh  | 73 +++++++++++++++++++
> > > >  1 file changed, 73 insertions(+)
> > > >  create mode 100755 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> > > > 
> > > > diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> > > > new file mode 100755
> > > > index 000000000000..961932754684
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> > > 
> > > Could you provide the SPDX header and copyright bits for this newly
> > > added file? For small changes I can do it myself, however this is about
> > > licenses and copyright, so I need it from you, thanks!
> > 
> > Good catch, thank you!
> > 
> > Would you like a delta patch to merge into your existing one, or would
> > you prefer a replacement patch?  Either way works for me.
> > 
> 
> A delta patch if that's not much trouble. I will fold it into this one.

Here you go!

							Thanx, Paul

------------------------------------------------------------------------

rcutorture: Add proper comment header to srcu_lockdep.sh

This patch adds a proper comment header to srcu_lockdep.sh,
and is intended to be folded into 9dc68f40c665 ("rcutorture: Add
srcu_lockdep.sh").

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 961932754684..2e63ef009d59 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -1,6 +1,11 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Run SRCU-lockdep tests and report any that fail to meet expectations.
+#
+# Copyright (C) 2021 Meta Platforms, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
 
 usage () {
 	echo "Usage: $scriptname optional arguments:"
