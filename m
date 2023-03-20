Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCEA6C1FA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 19:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCTS1G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 14:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCTS0p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 14:26:45 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945782F045;
        Mon, 20 Mar 2023 11:19:23 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x1so14186435qtr.7;
        Mon, 20 Mar 2023 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679336362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7SGt6ewy4QpyyXpB8gIh5m2EuN+scGEW+i/GxtvTBQ=;
        b=p2mcp5FgF8qi5F4m0kaETbVJn96x9JFsij//ka36qLR33Q87pGCyvr/L0AWPt1Mft1
         Y3la7Y3Ak9p8recnj9MuWsNFdxlSj8NThUmhYDU5rZvrxSvZopXpoePBaz561lHTws8Q
         waXIHZ6M2BkE0FW1mRcYtz5EOXG0FitAKshMfysNFZiVaBWLhAqJY4R0WnSWzVMcOnmX
         PeG3rIwi+Tk9mJxhRZAnRSeBz/ULuGA1TC/K2YH0QC6txV04v1UI9MxA6Ul8uXvcR0m9
         TZcF8vyAxJigGIppHrGFoFKftDX4oDtNbmUyJJ14/37IMoM+kiOBo4SjbA7HGyxgGTXl
         GHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7SGt6ewy4QpyyXpB8gIh5m2EuN+scGEW+i/GxtvTBQ=;
        b=CxVg7lcAkppEFm6oqbUHA/CyaIa7ZGlYIcrnGPHrZ0vfb/otsjwBE+2Uqc6WwCUd51
         fGZ8w0rgOkvv7mTARl6CarDA7vyLkzFEzykUaVVC+XAhQMg1G7BdJ79dsNeORkeKGITD
         6h6eNtWMdDj1s7NgSww3iGhTn4mO08wBvX6GI2xNfXYqD2jFEzZJDrFIyjuGQW8a+5hy
         XzCpx+MnVYVxoW6Q5Jyr2gQw/5MA5YYnxRTId8m6+dGnVbHEVCFczNujj3EhAUaJKcLO
         KNYEv2lklUftzK9gNm83/nJj5zgn23+XYQY1x8FrHV8UhsvQe5zduTSJlbt6KKgrxaLD
         PyzQ==
X-Gm-Message-State: AO0yUKX6lTy1dxq5mdWdD7Y2jBHRbsx9rNIviFu1Gh/h/WQTwkfnjyPD
        VyTj4M31SMZvKnWW1Nw2Qsk=
X-Google-Smtp-Source: AK7set++ETVq5GzrgGjrmpd/i6tixAfyGPb810touxsUo1OlfAB3y1s5qt4PVmudKLhbTlNc8vr5nw==
X-Received: by 2002:ac8:5f8b:0:b0:3bd:1a07:2086 with SMTP id j11-20020ac85f8b000000b003bd1a072086mr124163qta.36.1679336362542;
        Mon, 20 Mar 2023 11:19:22 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a24c600b00745ba217187sm7805279qkn.3.2023.03.20.11.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:19:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2456E27C005B;
        Mon, 20 Mar 2023 14:19:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 20 Mar 2023 14:19:21 -0400
X-ME-Sender: <xms:qKMYZHl_jHbMPC76phPqQFBBzdH7GTNRhVDgFSd6t7loBWP85kTKhA>
    <xme:qKMYZK0Y2225S3QaQ8hyBSjJP2eOMkh_lQb__zJNClrbiH7BxQGRMgK8GT1VKuiPV
    TuB43dkodNib8wWPw>
X-ME-Received: <xmr:qKMYZNpHUVuJ2kz5MIPftwdbUtuP0z_fxMmtuSoVTjdTFffGx3PtMpE9SJuP6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:qKMYZPnfBHamQzApCPLRRJKPTIGn4NkIyqzijhDo4bfLhgKMmGgucg>
    <xmx:qKMYZF3XHEW6X6-StQ9QiEgJW07EMh2Mu7li8r6pwKYMgVfRjLnFlg>
    <xmx:qKMYZOvcZwe9QGD0oR7sAOUYtBqyVVCsCCrCiIWBAF55uYmOYp7xHw>
    <xmx:qaMYZHV5nMGsjihCrLXSZIhvyG8BdgFUqRJb3Cz-jR5YWXG1BmFyxg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 14:19:20 -0400 (EDT)
Date:   Mon, 20 Mar 2023 11:19:05 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
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
Subject: Re: [PATCH rcu 7/7] rcutorture: Add srcu_lockdep.sh
Message-ID: <ZBijmdz2ucql+BSb@boqun-archlinux>
References: <20230317031339.10277-1-boqun.feng@gmail.com>
 <20230317031339.10277-8-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317031339.10277-8-boqun.feng@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paul,

On Thu, Mar 16, 2023 at 08:13:39PM -0700, Boqun Feng wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit adds an srcu_lockdep.sh script that checks whether lockdep
> correctly classifies SRCU-based, SRCU/mutex-based, and SRCU/rwsem-based
> deadlocks.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> [ boqun: Fix "RCUTORTURE" with "$RCUTORTURE" ]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  .../selftests/rcutorture/bin/srcu_lockdep.sh  | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100755 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> new file mode 100755
> index 000000000000..961932754684
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh

Could you provide the SPDX header and copyright bits for this newly
added file? For small changes I can do it myself, however this is about
licenses and copyright, so I need it from you, thanks!

Regards,
Boqun

> @@ -0,0 +1,73 @@
> +#!/bin/bash
> +#
> +# Run SRCU-lockdep tests and report any that fail to meet expectations.
> +
> +usage () {
> +	echo "Usage: $scriptname optional arguments:"
> +	echo "       --datestamp string"
> +	exit 1
> +}
> +
> +ds=`date +%Y.%m.%d-%H.%M.%S`-srcu_lockdep
> +scriptname="$0"
> +
> +T="`mktemp -d ${TMPDIR-/tmp}/srcu_lockdep.sh.XXXXXX`"
> +trap 'rm -rf $T' 0
> +
> +RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> +PATH=${RCUTORTURE}/bin:$PATH; export PATH
> +. functions.sh
> +
> +while test $# -gt 0
> +do
> +	case "$1" in
> +	--datestamp)
> +		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._/-]*$' '^--'
> +		ds=$2
> +		shift
> +		;;
> +	*)
> +		echo Unknown argument $1
> +		usage
> +		;;
> +	esac
> +	shift
> +done
> +
> +err=
> +nerrs=0
> +for d in 0 1
> +do
> +	for t in 0 1 2
> +	do
> +		for c in 1 2 3
> +		do
> +			err=
> +			val=$((d*1000+t*10+c))
> +			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --bootargs "rcutorture.test_srcu_lockdep=$val" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
> +			ret=$?
> +			mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
> +			if test "$d" -ne 0 && test "$ret" -eq 0
> +			then
> +				err=1
> +				echo -n Unexpected success for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> +			fi
> +			if test "$d" -eq 0 && test "$ret" -ne 0
> +			then
> +				err=1
> +				echo -n Unexpected failure for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> +			fi
> +			if test -n "$err"
> +			then
> +				grep "rcu_torture_init_srcu_lockdep: test_srcu_lockdep = " "$RCUTORTURE/res/$ds/$val/SRCU-P/console.log" | sed -e 's/^.*rcu_torture_init_srcu_lockdep://' >> "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> +				cat "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
> +				nerrs=$((nerrs+1))
> +			fi
> +		done
> +	done
> +done
> +if test "$nerrs" -ne 0
> +then
> +	exit 1
> +fi
> +exit 0
> -- 
> 2.39.2
> 
