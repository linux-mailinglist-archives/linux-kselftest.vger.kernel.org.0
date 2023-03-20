Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82166C1EA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 18:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjCTR5S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 13:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCTR4w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 13:56:52 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F240113C2;
        Mon, 20 Mar 2023 10:51:44 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id n2so14133832qtp.0;
        Mon, 20 Mar 2023 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679334621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jadN/M9/QEeUH+7TUE8KXiajBk6vI/UOdAVnM9LqwP4=;
        b=mCUiDaIv3X2cv1paAnSxarsTJTOwhi+j/JIwMrGT7nIWhz7gsblqHK8Z6lETCS2mEs
         Exn3yXF7il9SZiFjSe8aD/gPoDfymRynCvjDGJlA1pPMYCh+3gleK5KJwyFkUo1k5mud
         ZgHFbS0NkXhxWWemmh1F24RvcpzjQTlUVVNN0ImSbv7PUqbeoeJEtjx84qy9ln+JEGDV
         G4wOixZFowdgVklEgkvwNh+L4QTmJItPT2DVUQJQkVlvlk1RgLnM8Cg5tJVVYGbM8abj
         xWAngsbo2cxo84UoUfBQ/Ff8XFVEfTlpioR7LMA7vGJv1AblGhYE9iIke548OLdMaaDS
         Aoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jadN/M9/QEeUH+7TUE8KXiajBk6vI/UOdAVnM9LqwP4=;
        b=LTjCjvzSI4seOiCa2T6cQ/DHlZVV4fcDH+iPbiO4eQC8LNZ80I0O3IiwH5pV4JHIoV
         Gr6xNGJMTn/j0CvuB1lBAM/EPd1UrzG8rYJL72NGlnNvwkJA3HYlXHGD2JFu3ywzJ5u1
         aRQvemoN9SWLBgaI0ErQEGQE/RJ8t6DjjDfh4Zx+lj5nkMdEy3/okAG61PgR/8sjmMrZ
         dT2mwxuYIe0TzNfTUWO3Ybinprh5cWyFwbbXG17pxIOki8VxveMLW5qGkEB9yu4VXEpR
         GFdK/h02Eiz/xb4lhmHly/8Tm7sfHgS2S8vYikLFM6UTGdt9e56BVjikQr6vdGMqnU7c
         I89A==
X-Gm-Message-State: AO0yUKUHnPDSrEq6EVPc9HFJmeHJVWI0Kc3SaaLmrWwjAOtU2ucLxR5I
        VL+mxHeEk5JqZDQD2bIbypU=
X-Google-Smtp-Source: AK7set/jR4MhDQ20YHO0s2tkcQ+UNrs2h8FqKTMW58USlS3w8CKf1W0XST+8K41ffAvmYQM5O0LmBg==
X-Received: by 2002:ac8:57d2:0:b0:3e1:59e8:7437 with SMTP id w18-20020ac857d2000000b003e159e87437mr228834qta.0.1679334621067;
        Mon, 20 Mar 2023 10:50:21 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id r9-20020a37a809000000b007463509f94asm3916840qke.55.2023.03.20.10.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:50:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id A619427C005A;
        Mon, 20 Mar 2023 13:50:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 20 Mar 2023 13:50:19 -0400
X-ME-Sender: <xms:2pwYZENlbVs7OMv8zNs254-163z6BGFa7vg0cQX6_-IoT2r9vzFdgw>
    <xme:2pwYZK9rSPJiGSIXR-Q6s0NFWmNHClcf0eDJbHiqnJMdU1-VjvZrKF6c-wQ0U_I5l
    15184jDpnQnI1_uyQ>
X-ME-Received: <xmr:2pwYZLRrSThimcC11eYLn0EWE2fieaZvLkMDtJvuvF5fvXdb0UqkF9M9GgxYMQ>
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
X-ME-Proxy: <xmx:2pwYZMv_2ZS1cQUzBdqfAi2-jCAiOmNBzjNtAlhPeUvCU1nBaqpnNA>
    <xmx:2pwYZMcPClLOOesYkm7VY0gi-nxv9BGB7ni2Vjugu0AptKkSI1rGsg>
    <xmx:2pwYZA0e0JZPUal5rpddiJ8VcjrblvD1t_MOWztYE7X5JXXUnhWkWQ>
    <xmx:25wYZK8YLSoMIM1E1NXEEi8k75ZRKMk7jvKAkTlvx20c2Lqh_f1GiA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 13:50:18 -0400 (EDT)
Date:   Mon, 20 Mar 2023 10:50:03 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH rcu 4/7] locking/lockdep: Improve the deadlock scenario
 print for sync and read lock
Message-ID: <ZBicy8d37opl62X5@boqun-archlinux>
References: <20230317031339.10277-1-boqun.feng@gmail.com>
 <20230317031339.10277-5-boqun.feng@gmail.com>
 <20230320121305.GK2194297@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320121305.GK2194297@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 20, 2023 at 01:13:05PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 16, 2023 at 08:13:36PM -0700, Boqun Feng wrote:
> > Lock scenario print is always a weak spot of lockdep splats. Improvement
> > can be made if we rework the dependency search and the error printing.
> > 
> > However without touching the graph search, we can improve a little for
> > the circular deadlock case, since we have the to-be-added lock
> > dependency, and know whether these two locks are read/write/sync.
> > 
> > In order to know whether a held_lock is sync or not, a bit was
> > "stolen" from ->references, which reduce our limit for the same lock
> > class nesting from 2^12 to 2^11, and it should still be good enough.
> > 
> > Besides, since we now have bit in held_lock for sync, we don't need the
> > "hardirqoffs being 1" trick, and also we can avoid the __lock_release()
> > if we jump out of __lock_acquire() before the held_lock stored.
> > 
> > With these changes, a deadlock case evolved with read lock and sync gets
> > a better print-out from:
> > 
> > 	[...]  Possible unsafe locking scenario:
> > 	[...]
> > 	[...]        CPU0                    CPU1
> > 	[...]        ----                    ----
> > 	[...]   lock(srcuA);
> > 	[...]                                lock(srcuB);
> > 	[...]                                lock(srcuA);
> > 	[...]   lock(srcuB);
> > 
> > to
> > 
> > 	[...]  Possible unsafe locking scenario:
> > 	[...]
> > 	[...]        CPU0                    CPU1
> > 	[...]        ----                    ----
> > 	[...]   rlock(srcuA);
> > 	[...]                                lock(srcuB);
> > 	[...]                                lock(srcuA);
> > 	[...]   sync(srcuB);
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  include/linux/lockdep.h  |  3 ++-
> >  kernel/locking/lockdep.c | 48 ++++++++++++++++++++++++++--------------
> >  2 files changed, 34 insertions(+), 17 deletions(-)
> > 
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 14d9dbedc6c1..b32256e9e944 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -134,7 +134,8 @@ struct held_lock {
> >  	unsigned int read:2;        /* see lock_acquire() comment */
> >  	unsigned int check:1;       /* see lock_acquire() comment */
> >  	unsigned int hardirqs_off:1;
> > -	unsigned int references:12;					/* 32 bits */
> > +	unsigned int sync:1;
> > +	unsigned int references:11;					/* 32 bits */
> >  	unsigned int pin_count;
> >  };
> >  
> 
> Yeah, I suppose we can do that -- another option is to steal some bits
> from pin_count, but whatever (references used to be 11 a long while ago,
> no problem going back to that).

Thanks!

> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Applied locally.

Regards,
Boqun
