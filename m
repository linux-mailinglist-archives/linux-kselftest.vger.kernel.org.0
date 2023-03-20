Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1476C2198
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 20:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCTTeE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 15:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCTTda (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 15:33:30 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0525136C5;
        Mon, 20 Mar 2023 12:28:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id bz27so2765342qtb.1;
        Mon, 20 Mar 2023 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679340503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD9AXKBAh8HyIexaR70QcnQFYbhZUDFzWQoXICwDVuo=;
        b=Ay+14zqV5M6t83JCFWXWGDo0B0F18hyV3doDfVKRAtuzQiDLpZdudZemCh0jXXn0qC
         1qtQfKO7vkMuiTeD9bN2mYNPyHKPUv8Qn2G7ehQynLuafPUaQG25Snq98rlzY5qI37UO
         tHS0KurXZ++dlvGyg3r2nkiYrzaG0RM64aH4RO61aFmG/YykwrKkt4c45vfwbcjlOUo+
         nHMNovv1+sqq7Rw3kTnnihU5bk71hCkROmeBFPbBHmx+9q1J6EQ4FYpPXrH7NPpPBvm9
         vfo1zI6rESBAjHhuL5nsl3xjxDgzRd9MdnLiYWpuNfMP1XpBoMZEmiqEvktLMzL54i03
         dOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679340503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HD9AXKBAh8HyIexaR70QcnQFYbhZUDFzWQoXICwDVuo=;
        b=cLr0VeMILtkAo3HKfdZo1xhKMQEI/xQRnzTmM8APcqP6SuzE7WZKW6gI9iN6B4w5qN
         IhKVenmw/GvvkjcEhfHRgijgxkOpcykBDmS8UNu8BWM7Sb48Xa+90zkv13yNLlxeGklp
         1csdoxPHSLJP0qsJQdCVdQp9fngPnQ0Xk4wqIsV+pVEVyoX1dT5IA5856zFGJHznuwCV
         nS5FS8nrEgC16U3r292G50IiwdfBWhml2m2NcLP7+1OsahhmbkroMM8yHlZO4fXIaDVU
         234xIiPVZ4xwOEZ92hXtXsJ1V+hgooI0j0Q5DgkjGKtwzhPETMhYiKmrSCO23K4Bfs2T
         rzgQ==
X-Gm-Message-State: AO0yUKVpbHo3QKNbUyp2xllsq1/8A5ZkrY8OYKx5m7acp1M/K1t7Wg3s
        IgAoXVMKrL1cHYR0oqkUyC8=
X-Google-Smtp-Source: AK7set9prBP30YV2N+bl0uv5/DZq7n5gqeA2bdbYn01NNDwtqeNc41hEWzNbzPr/MlN2Se7FQ0xujA==
X-Received: by 2002:a05:622a:45:b0:3e2:e280:c4a1 with SMTP id y5-20020a05622a004500b003e2e280c4a1mr404602qtw.52.1679340502719;
        Mon, 20 Mar 2023 12:28:22 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o197-20020a3741ce000000b0073b575f3603sm7878176qka.101.2023.03.20.12.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 12:28:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 63E3B27C0054;
        Mon, 20 Mar 2023 15:28:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 20 Mar 2023 15:28:21 -0400
X-ME-Sender: <xms:1LMYZElGByfLATrnic20MzPYjK2OHdja5DR-1U_I92tX0aonk5L7Zw>
    <xme:1LMYZD2fgIgz5EAcmOek41tYyCStg85VRU_TkAC9xYwSAL1feFpp2wsmwl1RhBbxG
    UR5PhN8lOmvXiJWFQ>
X-ME-Received: <xmr:1LMYZCrzcFeudpYnN9ofcNZQJpXe5YMvsIKZCxTgdCnjk6qeJRxycoB_aSatyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:1LMYZAmxKpGz82E6D5jkbyoqvbQLYMzVkAMUyk1SjoEXp_pFiXJkRA>
    <xmx:1LMYZC07y2g-lEktBeiMWgiJtj1Cu9MJi72AaXAWPq9hliO5odyQXw>
    <xmx:1LMYZHs8FUpUK_-Gm0JkvEUwXwumvoggSmpiM5J0q2ovXYmX9RJM1w>
    <xmx:1bMYZMV3ZJZkQQ9CnlsYDUy4KVgSX1g2UFGT7R9cI8OmVICbQDDaDg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 15:28:20 -0400 (EDT)
Date:   Mon, 20 Mar 2023 12:28:05 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <ZBizxQ9BY/hQk8+Y@boqun-archlinux>
References: <20230317031339.10277-1-boqun.feng@gmail.com>
 <20230317031339.10277-8-boqun.feng@gmail.com>
 <ZBijmdz2ucql+BSb@boqun-archlinux>
 <bed30db4-d998-4382-a9a1-716c6f428263@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed30db4-d998-4382-a9a1-716c6f428263@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 20, 2023 at 12:09:00PM -0700, Paul E. McKenney wrote:
> On Mon, Mar 20, 2023 at 11:19:05AM -0700, Boqun Feng wrote:
> > Hi Paul,
> > 
> > On Thu, Mar 16, 2023 at 08:13:39PM -0700, Boqun Feng wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > This commit adds an srcu_lockdep.sh script that checks whether lockdep
> > > correctly classifies SRCU-based, SRCU/mutex-based, and SRCU/rwsem-based
> > > deadlocks.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > [ boqun: Fix "RCUTORTURE" with "$RCUTORTURE" ]
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  .../selftests/rcutorture/bin/srcu_lockdep.sh  | 73 +++++++++++++++++++
> > >  1 file changed, 73 insertions(+)
> > >  create mode 100755 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> > > 
> > > diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> > > new file mode 100755
> > > index 000000000000..961932754684
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> > 
> > Could you provide the SPDX header and copyright bits for this newly
> > added file? For small changes I can do it myself, however this is about
> > licenses and copyright, so I need it from you, thanks!
> 
> Good catch, thank you!
> 
> Would you like a delta patch to merge into your existing one, or would
> you prefer a replacement patch?  Either way works for me.
> 

A delta patch if that's not much trouble. I will fold it into this one.

Regards,
Boqun

> 							Thanx, Paul
> 
> > Regards,
> > Boqun
> > 
> > > @@ -0,0 +1,73 @@
> > > +#!/bin/bash
> > > +#
> > > +# Run SRCU-lockdep tests and report any that fail to meet expectations.
> > > +
> > > +usage () {
> > > +	echo "Usage: $scriptname optional arguments:"
> > > +	echo "       --datestamp string"
> > > +	exit 1
> > > +}
> > > +
> > > +ds=`date +%Y.%m.%d-%H.%M.%S`-srcu_lockdep
> > > +scriptname="$0"
> > > +
> > > +T="`mktemp -d ${TMPDIR-/tmp}/srcu_lockdep.sh.XXXXXX`"
> > > +trap 'rm -rf $T' 0
> > > +
> > > +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> > > +PATH=${RCUTORTURE}/bin:$PATH; export PATH
> > > +. functions.sh
> > > +
> > > +while test $# -gt 0
> > > +do
> > > +	case "$1" in
> > > +	--datestamp)
> > > +		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._/-]*$' '^--'
> > > +		ds=$2
> > > +		shift
> > > +		;;
> > > +	*)
> > > +		echo Unknown argument $1
> > > +		usage
> > > +		;;
> > > +	esac
> > > +	shift
> > > +done
> > > +
> > > +err=
> > > +nerrs=0
> > > +for d in 0 1
> > > +do
> > > +	for t in 0 1 2
> > > +	do
> > > +		for c in 1 2 3
> > > +		do
> > > +			err=
> > > +			val=$((d*1000+t*10+c))
> > > +			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --bootargs "rcutorture.test_srcu_lockdep=$val" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
> > > +			ret=$?
> > > +			mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
> > > +			if test "$d" -ne 0 && test "$ret" -eq 0
> > > +			then
> > > +				err=1
> > > +				echo -n Unexpected success for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> > > +			fi
> > > +			if test "$d" -eq 0 && test "$ret" -ne 0
> > > +			then
> > > +				err=1
> > > +				echo -n Unexpected failure for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> > > +			fi
> > > +			if test -n "$err"
> > > +			then
> > > +				grep "rcu_torture_init_srcu_lockdep: test_srcu_lockdep = " "$RCUTORTURE/res/$ds/$val/SRCU-P/console.log" | sed -e 's/^.*rcu_torture_init_srcu_lockdep://' >> "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> > > +				cat "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> > > +				nerrs=$((nerrs+1))
> > > +			fi
> > > +		done
> > > +	done
> > > +done
> > > +if test "$nerrs" -ne 0
> > > +then
> > > +	exit 1
> > > +fi
> > > +exit 0
> > > -- 
> > > 2.39.2
> > > 
