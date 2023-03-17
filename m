Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40DC6BF3CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 22:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCQV0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCQV0r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 17:26:47 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234A1EFAC;
        Fri, 17 Mar 2023 14:26:32 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id op8so4306098qvb.11;
        Fri, 17 Mar 2023 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTO9PAiMHyzLu/JWJW5k8It2fLbj2YzeM6Nsv7I7SPA=;
        b=AOooFp0xMb5shmFdwrYLLKW3bG6annQ2D/HhiWv/CI4te3KlN1iVru2Ln3TirqWpXW
         GyxKAvPNGt2T0ZXzS3OsacTIUVYSiRQxuDrxQMYWSwmrWPtfag+VU4+f0cnWpwDFr/XB
         86/8sAxfDAre80JF6uh+TJQIvbxk6iUP9vgNrPYxE1xftrLHUHKGZoPUkaJq6mqo4fU0
         bkQkpqnzml2jSwyMjo1PiuHiQwE3YXRBD6qWI3VVfrhPIx76S2UsY9rpjHnLOagaU5bL
         B/12tKssHVmCYNeFrDutS7oJxIYktozsoGTtmHt0JEkCPWVSlfvKkoRe0uDqi0ERfjDu
         ssIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTO9PAiMHyzLu/JWJW5k8It2fLbj2YzeM6Nsv7I7SPA=;
        b=S+nJuF/PgErNVbffcz+YNmNIMCCo3s2WUaxHSd2DO9PcCph+q7N0djJ2U5b9DWCPX6
         rASf5vSMcSUSWP4a7h1aU1xJoRhwRKoRhlXDsIxx0yNqDAjHus0x/Li15NoTUha3GQQ0
         WbXY/cx0ZAP1mtfSS3QQmsNdrSiWzhBVR1tsbgc1ucHPZ/hVV6wUHppu6Je/d5hq2bkD
         EUkDs2kgxXeQX4up9EfKYLW9N1dlNxIGrKtSxTNtSPiynSHuQT0j1OtJkBR8t+vq7xN1
         rRqTfsode9eGNsKhHRPHt++ySf6yf8diwpAjBH1YnE1NHdgjfXA2GMWM3GrLtaD92Tzg
         dxFA==
X-Gm-Message-State: AO0yUKUemw5OWLmfIT8hrjazjR4Ut+pr4amo10qH/CAkO/qTpe8B47pl
        5/1zUqi6W8sXR7n68UCq6Aw=
X-Google-Smtp-Source: AK7set8A1PH+17+Hksf9h5fcDDrayHQJR15A4XkYemMpGGaHjwOiiHuzIaF2NOEFDLlGO6f2ULtSDw==
X-Received: by 2002:a05:6214:509b:b0:5b4:89b4:1afc with SMTP id kk27-20020a056214509b00b005b489b41afcmr14343496qvb.17.1679088391308;
        Fri, 17 Mar 2023 14:26:31 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s187-20020a37a9c4000000b007456e020846sm2427709qke.13.2023.03.17.14.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:26:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 10A0727C0054;
        Fri, 17 Mar 2023 17:26:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 17 Mar 2023 17:26:30 -0400
X-ME-Sender: <xms:BNsUZCpUma_UC72kse5Nj8xDVz3GGsgbfzy4GYQq2eLpPhxxwE2Emg>
    <xme:BNsUZAqulNBamUhX56TAiDB8T9cqxP7k8NHLDskRcdnV_JSJb22OLvNv9zQwDml_m
    UOWEa_dE4J3T-Jwyw>
X-ME-Received: <xmr:BNsUZHNuQ3hfpsw-cM-65Q0YWTzSIxuz3x9_vaTvet1uCj6wo-5aLk0UhbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeeg
    vddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:BdsUZB7F2Jon2PmWbu-h7EFw7oA1-yERzKx1eihjAjENjP1sbXJHcg>
    <xmx:BdsUZB6mUKcNgTwP8B8ZPx_rD1AHIlMYvSZsSAuefGwc-nogv3M79A>
    <xmx:BdsUZBhLJFv4gDbr8CH9Z2_NFoKPSFQxRCY0fwNFDLqE0XqhpFq9bA>
    <xmx:BtsUZKQD8qG9OYxqYXv1Ei-h7wHVYzwLwIjiJtXQJYCcgdhBdSNd0g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 17:26:28 -0400 (EDT)
Date:   Fri, 17 Mar 2023 14:26:22 -0700
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
        linux-kselftest@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH rcu 3/7] locking: Reduce the number of locks in ww_mutex
 stress tests
Message-ID: <ZBTa/pQ1cm9V4Pvn@boqun-archlinux>
References: <20230317031339.10277-1-boqun.feng@gmail.com>
 <20230317031339.10277-4-boqun.feng@gmail.com>
 <2e8a6800-78e7-42bf-b4ff-5d7ef43511c5@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e8a6800-78e7-42bf-b4ff-5d7ef43511c5@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 17, 2023 at 11:38:19AM -0700, Paul E. McKenney wrote:
> On Thu, Mar 16, 2023 at 08:13:35PM -0700, Boqun Feng wrote:
> > The stress test in test_ww_mutex_init() uses 4095 locks since
> > lockdep::reference has 12 bits, and since we are going to reduce it to
> > 11 bits to support lock_sync(), and 2047 is still a reasonable number of
> > the max nesting level for locks, so adjust the test.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Link: https://lore.kernel.org/oe-lkp/202302011445.9d99dae2-oliver.sang@intel.com
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> 

Applied, thanks!

Regards,
Boqun

> > ---
> >  kernel/locking/test-ww_mutex.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> > index 29dc253d03af..93cca6e69860 100644
> > --- a/kernel/locking/test-ww_mutex.c
> > +++ b/kernel/locking/test-ww_mutex.c
> > @@ -659,7 +659,7 @@ static int __init test_ww_mutex_init(void)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = stress(4095, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
> > +	ret = stress(2047, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
> >  	if (ret)
> >  		return ret;
> >  
> > -- 
> > 2.39.2
> > 
