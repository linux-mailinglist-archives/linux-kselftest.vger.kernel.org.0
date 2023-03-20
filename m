Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A16C229F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 21:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCTU2F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 16:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCTU1j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 16:27:39 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AF534F79;
        Mon, 20 Mar 2023 13:27:00 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id n2so14789552qtp.0;
        Mon, 20 Mar 2023 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679344017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP+DDhOOPdM28aMhqmlGJ2/+YkBO9E6JeUPqNBtvtEo=;
        b=DffpttkLpDHILskLvIQMHPLfYpLwJBngYTE6A1FaptZvq4JYEivrt0fuXS1+SRE/vY
         mzbOmWoLnvU9VdCU9CDpB0wWQXaF6LjEsvaaTgXeXeTC+IoAAaE74OOKrufbYS5EPOmG
         JjE0E9lwLpW+pVncUtH9Adv7yhoZr18yt4sirY3vhtiGoet2opMfmRXgvZ1kqY5gVrXm
         AeUoold4UuK17QTl9RCWqVe4vlkhykdWFdsRhD/GJLq25gorO+OkQAHSnQFQzq1wBID/
         +TqlPjltuCTAVSXIV1ko0HjbouVEaHu+eiBJVmINrLF887GAqrKCmqh2r4ZnFpqdaAWW
         zvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP+DDhOOPdM28aMhqmlGJ2/+YkBO9E6JeUPqNBtvtEo=;
        b=Eu3w5DEQqJg7GhB0Bfg5SpyT+gEulgDjjVY3OGMvVHbKTbF7CzstLGaYEj2O72zyFo
         XSilng3qJth5KJZ4diq0NnLsamd/bPrYMqfDIFDyD38Sq3X84/+AoxwHVNChJXyxG231
         y9GMt9cmBarfKvdbynFvTT/PjIEQUP5RlhBe9aea4zxcErScMvBQbvRa3esAUhnOYdOZ
         LzOdMmJY+aHtvqgHKQ1a1lvh+8E0/+FzFkMBioBrifRQQsKopCofTqZpxRgv6rfWJC1v
         zQoEPS1dIbPpki6sy5+gSVyOEMSvn7xrwbEM/EfERDbCcdHl+WPfwV15qUMIe7ohbe9I
         +c7w==
X-Gm-Message-State: AO0yUKX6La2nIdJtj3DN1ZRyLRM+2vrK3CC+Tr5ldFjkkKck+iLm4zmt
        6S6eCJGUBmdVat28GZqIGpw=
X-Google-Smtp-Source: AK7set/UNEkpTV3rETYJouRrcFk7ijRfWvnS9EqJrRmT/gVpiI3+8RCItBHTJbcSu0J/yDSDMqV6LQ==
X-Received: by 2002:ac8:7f05:0:b0:3b6:8b52:1359 with SMTP id f5-20020ac87f05000000b003b68b521359mr1791444qtk.0.1679344017281;
        Mon, 20 Mar 2023 13:26:57 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v10-20020ac873ca000000b003e29583cf22sm1709390qtp.91.2023.03.20.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:26:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id F3D4F27C005C;
        Mon, 20 Mar 2023 16:26:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 20 Mar 2023 16:26:56 -0400
X-ME-Sender: <xms:j8EYZJlyYCqnUyHv_WCHzY-uFsowav0YykpCbACwdZP3VWAxESMVkw>
    <xme:j8EYZE1dCE2KvaY8ghGQnj7aTWd4fz1fMwyDFwPgbqzC3CAcmNrFbR1Nucjwd_iba
    TVUOt-R1K8zIADY7Q>
X-ME-Received: <xmr:j8EYZPo_vxAMjAM4RIPr4Rsa_TPoLkLdz8OQZVcVgxZuOcHcgYWx8-RILw0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:j8EYZJlFRAC2jOW61zJWQtfOym6VWSqEoXh3A3lMv7YFkKLtEEStRw>
    <xmx:j8EYZH3c6IbdxEXCU-zWPX2wnnER6PD3ulBxwWye1kgU0xf-rM4qhw>
    <xmx:j8EYZIvLYNFRHbmdfBvLbSiLv12QYTcRVxGlLkrrtoO6iFi8v9NOqw>
    <xmx:j8EYZJW_XjkSv-4a1XEW2ST1TVE8oFYCpV0c8sbkl6Erh4rUbpde0A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 16:26:55 -0400 (EDT)
Date:   Mon, 20 Mar 2023 13:26:39 -0700
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
Message-ID: <ZBjBf1JpeOP/1EXP@boqun-archlinux>
References: <20230317031339.10277-1-boqun.feng@gmail.com>
 <20230317031339.10277-8-boqun.feng@gmail.com>
 <ZBijmdz2ucql+BSb@boqun-archlinux>
 <bed30db4-d998-4382-a9a1-716c6f428263@paulmck-laptop>
 <ZBizxQ9BY/hQk8+Y@boqun-archlinux>
 <15e799a8-0e63-4bd9-9a01-028c9d906904@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e799a8-0e63-4bd9-9a01-028c9d906904@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 20, 2023 at 01:22:24PM -0700, Paul E. McKenney wrote:
> On Mon, Mar 20, 2023 at 12:28:05PM -0700, Boqun Feng wrote:
> > On Mon, Mar 20, 2023 at 12:09:00PM -0700, Paul E. McKenney wrote:
> > > On Mon, Mar 20, 2023 at 11:19:05AM -0700, Boqun Feng wrote:
> > > > Hi Paul,
> > > > 
> > > > On Thu, Mar 16, 2023 at 08:13:39PM -0700, Boqun Feng wrote:
> > > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > 
> > > > > This commit adds an srcu_lockdep.sh script that checks whether lockdep
> > > > > correctly classifies SRCU-based, SRCU/mutex-based, and SRCU/rwsem-based
> > > > > deadlocks.
> > > > > 
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > [ boqun: Fix "RCUTORTURE" with "$RCUTORTURE" ]
> > > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > > ---
> > > > >  .../selftests/rcutorture/bin/srcu_lockdep.sh  | 73 +++++++++++++++++++
> > > > >  1 file changed, 73 insertions(+)
> > > > >  create mode 100755 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> > > > > 
> > > > > diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> > > > > new file mode 100755
> > > > > index 000000000000..961932754684
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> > > > 
> > > > Could you provide the SPDX header and copyright bits for this newly
> > > > added file? For small changes I can do it myself, however this is about
> > > > licenses and copyright, so I need it from you, thanks!
> > > 
> > > Good catch, thank you!
> > > 
> > > Would you like a delta patch to merge into your existing one, or would
> > > you prefer a replacement patch?  Either way works for me.
> > > 
> > 
> > A delta patch if that's not much trouble. I will fold it into this one.
> 
> Here you go!
> 

Thanks! Fold it in patch #7.

Regards,
Boqun

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> rcutorture: Add proper comment header to srcu_lockdep.sh
> 
> This patch adds a proper comment header to srcu_lockdep.sh,
> and is intended to be folded into 9dc68f40c665 ("rcutorture: Add
> srcu_lockdep.sh").
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> index 961932754684..2e63ef009d59 100755
> --- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> +++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
> @@ -1,6 +1,11 @@
>  #!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
>  #
>  # Run SRCU-lockdep tests and report any that fail to meet expectations.
> +#
> +# Copyright (C) 2021 Meta Platforms, Inc.
> +#
> +# Authors: Paul E. McKenney <paulmck@kernel.org>
>  
>  usage () {
>  	echo "Usage: $scriptname optional arguments:"
