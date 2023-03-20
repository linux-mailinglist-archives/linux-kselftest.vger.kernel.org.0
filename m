Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298716C211B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 20:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjCTTRg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 15:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjCTTRD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 15:17:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CE627986;
        Mon, 20 Mar 2023 12:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D415B810A2;
        Mon, 20 Mar 2023 19:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342FCC433EF;
        Mon, 20 Mar 2023 19:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679339341;
        bh=wI6e8dF9QWeQTHj3aH/nWph/qbO30pJkS3UaoSgbqag=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cfTTMOxtvo+qzmcbrPwQpeo+8VpSVGas9VlFj7oTHZ8R6CeXFX6OefHryR1wy8xhp
         Lp0dxH77u93dK74luU2Rogli6p1BZH3SG918hb8TaUkgPMIAfH48iSzMVYZW3+otSZ
         Am4we3//Fzs+g5HvJiQjgziKPj9pCIjupmFFJvlkW+f1/2IimF2i7o93Snsqj5NmDK
         oPZYt07HCEUhTJWKwp9NrUamGBzBztpB9yldv4nKJtBwkUNnJagcMBqkiX9D+Rqic0
         aeAv1BH7a9aZc0gEbaE304fLU7r7i2Z9KVN52KvQOy3HoJCstJJmHygyqBdgOepf/z
         wwB63M2+ex5Pg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C32921540395; Mon, 20 Mar 2023 12:09:00 -0700 (PDT)
Date:   Mon, 20 Mar 2023 12:09:00 -0700
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
Message-ID: <bed30db4-d998-4382-a9a1-716c6f428263@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230317031339.10277-1-boqun.feng@gmail.com>
 <20230317031339.10277-8-boqun.feng@gmail.com>
 <ZBijmdz2ucql+BSb@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBijmdz2ucql+BSb@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 20, 2023 at 11:19:05AM -0700, Boqun Feng wrote:
> Hi Paul,
> 
> On Thu, Mar 16, 2023 at 08:13:39PM -0700, Boqun Feng wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit adds an srcu_lockdep.sh script that checks whether lockdep
> > correctly classifies SRCU-based, SRCU/mutex-based, and SRCU/rwsem-based
> > deadlocks.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > [ boqun: Fix "RCUTORTURE" with "$RCUTORTURE" ]
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  .../selftests/rcutorture/bin/srcu_lockdep.sh  | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100755 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> > 
> > diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> > new file mode 100755
> > index 000000000000..961932754684
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> 
> Could you provide the SPDX header and copyright bits for this newly
> added file? For small changes I can do it myself, however this is about
> licenses and copyright, so I need it from you, thanks!

Good catch, thank you!

Would you like a delta patch to merge into your existing one, or would
you prefer a replacement patch?  Either way works for me.

							Thanx, Paul

> Regards,
> Boqun
> 
> > @@ -0,0 +1,73 @@
> > +#!/bin/bash
> > +#
> > +# Run SRCU-lockdep tests and report any that fail to meet expectations.
> > +
> > +usage () {
> > +	echo "Usage: $scriptname optional arguments:"
> > +	echo "       --datestamp string"
> > +	exit 1
> > +}
> > +
> > +ds=`date +%Y.%m.%d-%H.%M.%S`-srcu_lockdep
> > +scriptname="$0"
> > +
> > +T="`mktemp -d ${TMPDIR-/tmp}/srcu_lockdep.sh.XXXXXX`"
> > +trap 'rm -rf $T' 0
> > +
> > +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> > +PATH=${RCUTORTURE}/bin:$PATH; export PATH
> > +. functions.sh
> > +
> > +while test $# -gt 0
> > +do
> > +	case "$1" in
> > +	--datestamp)
> > +		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._/-]*$' '^--'
> > +		ds=$2
> > +		shift
> > +		;;
> > +	*)
> > +		echo Unknown argument $1
> > +		usage
> > +		;;
> > +	esac
> > +	shift
> > +done
> > +
> > +err=
> > +nerrs=0
> > +for d in 0 1
> > +do
> > +	for t in 0 1 2
> > +	do
> > +		for c in 1 2 3
> > +		do
> > +			err=
> > +			val=$((d*1000+t*10+c))
> > +			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --bootargs "rcutorture.test_srcu_lockdep=$val" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
> > +			ret=$?
> > +			mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
> > +			if test "$d" -ne 0 && test "$ret" -eq 0
> > +			then
> > +				err=1
> > +				echo -n Unexpected success for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> > +			fi
> > +			if test "$d" -eq 0 && test "$ret" -ne 0
> > +			then
> > +				err=1
> > +				echo -n Unexpected failure for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> > +			fi
> > +			if test -n "$err"
> > +			then
> > +				grep "rcu_torture_init_srcu_lockdep: test_srcu_lockdep = " "$RCUTORTURE/res/$ds/$val/SRCU-P/console.log" | sed -e 's/^.*rcu_torture_init_srcu_lockdep://' >> "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> > +				cat "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> > +				nerrs=$((nerrs+1))
> > +			fi
> > +		done
> > +	done
> > +done
> > +if test "$nerrs" -ne 0
> > +then
> > +	exit 1
> > +fi
> > +exit 0
> > -- 
> > 2.39.2
> > 
