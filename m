Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EBB493175
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jan 2022 00:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349955AbiARXq7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 18:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiARXq6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 18:46:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9145CC061574;
        Tue, 18 Jan 2022 15:46:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C882761457;
        Tue, 18 Jan 2022 23:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AF9C340E0;
        Tue, 18 Jan 2022 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642549617;
        bh=oVzp83gVtqUhhjJPDkZJhGEWXJn1dYVjgJBlh0SPBjQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=F4y+VVYF4Lr4f2Nl9f2iwHT14o8tjT5tHGZOCuVtcMSFKx0TxQXu8l4MubFQlkEcJ
         VunVxNeVSdvno7nbdIOmfljfBIO0vxtPn0Mxy/Vzj+MawB6OPxGNvRbS4hMjVVkQsu
         tr+J0vf0+1W2SUN9s+oQcHM0uAw2diPTYKb99mW73y2LEhhnIYnMeq6gQG1eFJGPRS
         uJ6u4P6PBwSOZPJh6oaVc5zFhwIFUanpncLUjztqdbPEBTCoyD2F9XS5Zo9CYnp3ow
         0UZ2D8J2oHVUr97dOpWh4sGHz6H6T91VGhTsxoLQrK9+oaObPi/FqrCW7k0zv7jttc
         J/D+ED5jQ3qxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E808A5C0A21; Tue, 18 Jan 2022 15:46:56 -0800 (PST)
Date:   Tue, 18 Jan 2022 15:46:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problems with rcutorture on ppc64le: allmodconfig(2) and other
 failures
Message-ID: <20220118234656.GA3120763@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de>
 <CAABZP2wxXW2RqpKevt9erkYg3po0ByUEFvYsgy3cRty5Rt1Qyw@mail.gmail.com>
 <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de>
 <20220118172904.GG947480@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118172904.GG947480@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 18, 2022 at 09:29:04AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 18, 2022 at 08:56:24AM +0100, Paul Menzel wrote:
> > Dear Zhouyi,
> > 
> > 
> > Thank you for your quick response.
> > 
> > 
> > Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:
> > 
> > > I have studied the rcu torture test recently. I am also interested in
> > > this topic.
> > > But I can't open
> > > [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Make.out.txt
> > > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log.txt
> > 
> > Sorry, about that. I should have checked those. I had put them into a
> > directory:
> > 
> > [1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/allmodconf-Make.out.txt
> > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/rcutorture-log.txt
> > 
> > I am going to try to test your suggestions at the end of the day.
> 
> On x86 rcutorture builds successfully.  However, allmodconfig
> on semi-recent -next got me "Can't open perl script
> "./usr/include/headers_check.pl": No such file or directory".
> Which might well be a local problem or might well be fixed by now.

Not fixed as of next-20220118.  Chasing it down...  ;-)

> Either way, it looks like I need to upgrade the torture.sh script's
> checks for failed builds.  Thank you for reporting this!

Does this make torture.sh more reliably report build failures?

						Thanx, Paul

------------------------------------------------------------------------

commit 0d302830515307ceb58e89d5fb91e81b6d22e0bf
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jan 18 15:40:49 2022 -0800

    torture: Make kvm-find-errors.sh notice missing vmlinux file
    
    Currently, an obtuse compiler diagnostic can fool kvm-find-errors.sh
    into believing that the build was successful.  This commit therefore
    adds a check for a missing vmlinux file.
    
    Link: https://lore.kernel.org/lkml/36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de/
    Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 2e9e9e2eedb69..7d3e11a6b8290 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -30,10 +30,15 @@ editor=${EDITOR-vi}
 files=
 for i in ${rundir}/*/Make.out
 do
+	scenariodir="`dirname $i`"
 	if egrep -q "error:|warning:|^ld: .*undefined reference to" < $i
 	then
 		egrep "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
 		files="$files $i.diags $i"
+	elif ! test -f ${scenariodir}/vmlinux
+	then
+		echo No ${scenariodir}/vmlinux file > $i.diags
+		files="$files $i.diags $i"
 	fi
 done
 if test -n "$files"
