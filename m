Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B280A77EDF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 01:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347226AbjHPXrb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 19:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347227AbjHPXrA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 19:47:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99A5272C;
        Wed, 16 Aug 2023 16:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 538CE63F75;
        Wed, 16 Aug 2023 23:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF2C433C8;
        Wed, 16 Aug 2023 23:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692229602;
        bh=cbvmhmhg7nmA1ZldK9uxk4YpbqNtTE8dCc5mN3alF9M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Sj/Q9LtxOBhqdhI0LxRCDOa33rBQTyA5ZWaRs1cZolVFkne00XvgtcYvKS9aOxVVn
         DAfxKUYdmxBcoVH3ese3CMNn4OLaWrmF6UbZfcpjEahdFp7FOB54cVMRYCDL8nCSe7
         9qAvrO0cpDTlvrMQCVupxZ1oPD+nqELYFQB4r7/vWb/v8ZPcKem2dadbs/sgy83uO7
         C+huuvUTmBDr+y9U8DLKqA95IWkr94YBgJ2nkFWhyuHFfsdaI/sF2Wt2POICC0AYsN
         fy/boTXd2UgtxJwiEIigu6tG4dFNd/4Q7Rg6ZtJxtJkG8wZXzipl0RFWka3E/rAL4Q
         uVAwI3qcJb5Rg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 430D2CE0593; Wed, 16 Aug 2023 16:46:42 -0700 (PDT)
Date:   Wed, 16 Aug 2023 16:46:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Joel <agnel.joel@gmail.com>,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] rcutorture: Copy out ftrace into its own console file
Message-ID: <bd06ed64-dcc9-4514-b6b0-f11591ac37f1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230815190949.GA3207581@google.com>
 <6a234118-1ad2-4e22-ad80-f35a1dab8f03@paulmck-laptop>
 <CAEXW_YQkPOPXEwTCc3nZ2CH_scOomPgz7ACYECi3k64T+YD5Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQkPOPXEwTCc3nZ2CH_scOomPgz7ACYECi3k64T+YD5Vg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 16, 2023 at 07:27:03PM -0400, Joel Fernandes wrote:
> On Wed, Aug 16, 2023 at 6:57 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Aug 15, 2023 at 07:09:49PM +0000, Joel Fernandes (Google) wrote:
> > > When debugging, it can be difficult to quickly find the ftrace dump
> > > within the console log, which in turn makes it difficult to process it
> > > independent of the result of the console output.  This commit therefore
> > > copies the contents of the buffers into its own file to make it easier
> > > to locate and process the ftrace dump. The original ftrace dump is still
> > > available in the console log in cases where it is more convenient to
> > > process it there, for example, when you have a script that processes
> > > console output as well as ftrace-dump data.
> > >
> > > Also handle the case of multiple ftrace dumps potentially showing up in the
> > > log. Example for a file like [1], it will extract as [2].
> > >
> > > [1]:
> > > foo
> > > foo
> > > Dumping ftrace buffer:
> > > ---------------------------------
> > > blah
> > > blah
> > > ---------------------------------
> > > more
> > > bar
> > > baz
> > > Dumping ftrace buffer:
> > > ---------------------------------
> > > blah2
> > > blah2
> > > ---------------------------------
> > > bleh
> > > bleh
> > >
> > > [2]:
> > >
> > > Ftrace dump 1:
> > > blah
> > > blah
> > >
> > > Ftrace dump 2:
> > > blah2
> > > blah2
> > >
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > Very good, and I did queue this one.
> >
> > I fixed the indentation of the awk script.  Perhaps your text editor is
> > being too smart for our good?  ;-)
> 
> Thanks!  Yes the editor messing up is a possibility, I'll go look at
> that, though the indent seems still messed up in your dev branch:
> 
> The line "/Dumping ftrace buffer:/ " has spaces, as does the "awk <
> $1" line. Is that intentional?  All the following ones have tabs.

Not intentional at all, thank you for catching it!

How about the fixup patch shown below, to be merged into the current
commit?

							Thanx, Paul

------------------------------------------------------------------------

commit 2322b84997c61e98bd48369f12c9b83b6e0d0ffb
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Aug 16 16:44:49 2023 -0700

    fixup! rcutorture: Copy out ftrace into its own console file
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 1ac86f68a436..6e415ddb206f 100755
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -339,9 +339,9 @@ specify_qemu_net () {
 # [...]
 # ---------------------------------
 extract_ftrace_from_console() {
-        awk < "$1" '
+	awk < "$1" '
 
-        /Dumping ftrace buffer:/ {
+	/Dumping ftrace buffer:/ {
 		buffer_count++
 		print "Ftrace dump " buffer_count ":"
 		capture = 1
