Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500D96C1EAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 18:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCTR6A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 13:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCTR5d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 13:57:33 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448BD20A33;
        Mon, 20 Mar 2023 10:52:20 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r5so14091671qtp.4;
        Mon, 20 Mar 2023 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679334649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQjkM9PKDL5Zc9X+NMDMWOfI4hV9Swlkx+f/dG2dChg=;
        b=NHZvq4NyIsQu/bi+Y0C7qiEnTDsnRv2Hza5qRUgyBE7ysLi9ulHO4V8FY4h6Habp4d
         Bvrn8eDqsJoNOyigPTSAHuNWtBRyCnk8YuipaPC4vNry5SWYj+H1eTemsrRco2fxm8M0
         e4bfalj/k2MsF+ACl+sA8hxXZekOUIl9Rz2/VhDPcp+W9GgRKaXplvUAEWfybNaS2knQ
         agKo6sKxC5Vpl1RBgOyXK9evHdi2g+Tt6hOGkkvXHdz25CVff7CQ+juP/AdylQuWcjCJ
         lnDAq8E8/QWN1+jIaKttJ3bUixmG+mbP+SjTecvwVVDp7NpM8ZhqKn8AyBtH3AWQymcG
         pdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQjkM9PKDL5Zc9X+NMDMWOfI4hV9Swlkx+f/dG2dChg=;
        b=lodlJsUuab3A5IdbX50njI1O8+QD6kvFkYcjbgWeR8x6g97CGE69/7G+5QvxXsAe5V
         uGlDn4k3m19nj7yob3zBlKZXQW9ecmHnp8CyXjs9MiOHOSu0iF60gXVCTV79LrIaq3l1
         6G81Yv5xJctBeH4BAE0HZCuEY9JMk3k8m/lJCx5X3BL3QCfE4K7EMdmIFNtXTpRcXYZp
         m9xLavkf3RVUrwY+BjSdTgXlxEdAU2F4vwZzPUFX2NPEhOlGq/EpCuHL0taz0SSadgxb
         nRrmvcrIqDHFLGnzPsQ2IrnEOAk9xpzZPirE82ZjWqNmIoNpuLoEW7p08njd4IRpNM14
         3rvg==
X-Gm-Message-State: AO0yUKUcbH16SpzEtqDxIYwf2g3EccuPLbFP01/k5DDdEIeYLOTm4009
        GDOCsHMtVpfLXInGNqdIEl0=
X-Google-Smtp-Source: AK7set9sgEJEikEBKPoxGLfLfLDV0IT4GGv9HZLouBThxSD+zT6GhvxJSpjZOowxWibHrwfR/6rr+w==
X-Received: by 2002:a05:622a:15ce:b0:3b9:2c3:675a with SMTP id d14-20020a05622a15ce00b003b902c3675amr26957376qty.62.1679334649322;
        Mon, 20 Mar 2023 10:50:49 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j185-20020a37b9c2000000b007465ad44891sm6730604qkf.102.2023.03.20.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:50:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 345C927C0054;
        Mon, 20 Mar 2023 13:50:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 20 Mar 2023 13:50:48 -0400
X-ME-Sender: <xms:95wYZBdaX6pf4AGjFJyspywePh07NNRMqplYmrWcwBG8nSKWHZzZAg>
    <xme:95wYZPMhtHyVfLou4dTb7ZAVVN1xB2bzQ1Fudeac0Xf8dKXn0lpA5_JXSGtGWb3yw
    1GZm1DB5Molbg1WBw>
X-ME-Received: <xmr:95wYZKgel-xWXq6hoS2lyrwIy0AyJroZWDEvn8wV8-Y8xZQji4oC0lazs25o5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:95wYZK9pprnul8jWLvwPWyh6hDoGQiK87GMBalhaeiWKoeButWrwvw>
    <xmx:95wYZNv9ZfqOKFAc2lNCn96Z_7pyP_57tiVF-O4eiRZuRacoGnTOcw>
    <xmx:95wYZJF0SrCNu3DAInmwPShaQ0-8GeGYOJLCrvg7Fqwh2cOxZ8xd8w>
    <xmx:-JwYZGMuxNlO0TxalPBCdI5ilsQjduFjXOuSsQVgFzt8ahle717wvw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 13:50:47 -0400 (EDT)
Date:   Mon, 20 Mar 2023 10:50:32 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <shuah@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        seanjc@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH rcu 1/7] locking/lockdep: Introduce lock_sync()
Message-ID: <ZBic6FfmVmMERQXm@boqun-archlinux>
References: <20230317031339.10277-1-boqun.feng@gmail.com>
 <20230317031339.10277-2-boqun.feng@gmail.com>
 <20230320170614.ttnqyhemnelgmzgd@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320170614.ttnqyhemnelgmzgd@offworld>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 20, 2023 at 10:06:14AM -0700, Davidlohr Bueso wrote:
> On Thu, 16 Mar 2023, Boqun Feng wrote:
> 
> > +/*
> > + * lock_sync() - A special annotation for synchronize_{s,}rcu()-like API.
> > + *
> > + * No actual critical section is created by the APIs annotated with this: these
> > + * APIs are used to wait for one or multiple critical sections (on other CPUs
> > + * or threads), and it means that calling these APIs inside these critical
> > + * sections is potential deadlock.
> > + *
> > + * This annotation acts as an acqurie+release anontation pair with hardirqoff
> 				^acquire

Good eye! Applied locally.

Regards,
Boqun
