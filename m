Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8A855CE9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbiF1Bhc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 21:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbiF1Bhb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 21:37:31 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB8167FE;
        Mon, 27 Jun 2022 18:37:29 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-101cdfddfacso15219392fac.7;
        Mon, 27 Jun 2022 18:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+iiToTiGOo1svHqA9uXgf321ab0pJGwYuuV/tHk2bQ=;
        b=AO48hpqXc7DKZ91ujoVg6Rs/Ab5ZOHDCjvCGTz88tBXheJXq7lZGdfiQzycDIXN/LT
         l4VwkBy9Ji5cXHdk2XOvFjTiYuvN6Q/NK4riuxMMl/AEhwtMAflyl4jE0iTqttag1LNF
         hGtBJYqp9CGXBcgEmIaTkuhSUP5JTorQd6p/m6gD5TRgIXdABBYafHZaFlFzmEi+Ya14
         etxBFk08h1wEm44GFZvqYwzjPRB9k1oC/UaOmOQ0W83GmmsVR3Wi/VCK5ZizPyegNBk3
         03udTpMlaHQxx9gRIyM+4DDQDk/2jgyOI2JH21HmJD8Oz7oWJ9A9BOQBwBTGzfUnIwuY
         mO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+iiToTiGOo1svHqA9uXgf321ab0pJGwYuuV/tHk2bQ=;
        b=KnbqhqOXMs51hVeJ17GsXmIA31fkSxp/EGVmmRGb7UkYqbzQiarxphII4bVev9sEuS
         bHmWKqshV8T7Is9FntouVZfeBnCslnWeXv+bEikEGiN7/mYSocjkxJ3YGYje0H7fkJ+E
         CtndtFicjZ6DRzkbgCKMLdDqhRliT8yqrdJcfb1HtCGrXyFzxGS8xPGu8VUtTdwTHe5u
         sFtgxfEZBtMoQRwJk9wUNM3zEmo1wU1efDI81ctrvBeB9ItxOGhLZTww1jP4AlIoP3TA
         m7BO1wzB6AOjE3eUlPjl2/I0JRZD2NVYiLSj/hlQZLG1fFYO6vEEOD5Cl5uegq+D3hu0
         VV0Q==
X-Gm-Message-State: AJIora/ici8rbl2mbYnCc/5ipvNTxRyCYPXxRWpiG6tOSHOCKaL04Mmf
        cdlmYqkpFVapfUrZQRuvWq8F2ARfeiN7XVMxBXpVxloCDLkhxg==
X-Google-Smtp-Source: AGRyM1vdl38sN57XPeuLqGQuzHX980InZnIVkbNoXruC8BbL4QeiXLyy09Is0BssoflbwTMOX747g9WNQKk7fwQ/WTI=
X-Received: by 2002:a05:6870:e95:b0:106:a8fe:1dc5 with SMTP id
 mm21-20020a0568700e9500b00106a8fe1dc5mr11712950oab.217.1656380248689; Mon, 27
 Jun 2022 18:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220626025604.277413-1-xiehuan09@gmail.com> <20220626025604.277413-5-xiehuan09@gmail.com>
 <YrkSkuluNhGcMyOu@debian.me> <CAEr6+EAesikgaZGCfgB4LQLkD=7rQ-LckRpNoXYq31QZ4pL9sA@mail.gmail.com>
In-Reply-To: <CAEr6+EAesikgaZGCfgB4LQLkD=7rQ-LckRpNoXYq31QZ4pL9sA@mail.gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Tue, 28 Jun 2022 09:37:17 +0800
Message-ID: <CAEr6+ECTFauRPzVAH+znERX=K4fxOyB23E=6yX6avCt8LS9MoA@mail.gmail.com>
Subject: Re: [PATCH v13 4/4] Documentation: trace/objtrace: Add documentation
 for objtrace
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Song Chen <chensong_2000@189.cn>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Masami,

I would like to ask if I change the document like "Bagas Sanjaya"
rewording in the next version.
I don't know if I can add your Reviewed-by again, I don't know the
rules very well ;-)

On Mon, Jun 27, 2022 at 3:45 PM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> Hi,
>
> On Mon, Jun 27, 2022 at 10:14 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > On Sun, Jun 26, 2022 at 10:56:04AM +0800, Jeff Xie wrote:
> > > Added documentation explaining how to use objtrace trigger to get the value
> > > of the object.
> > >
> >
> > Write "Add documentation..." instead.
>
> Thanks, I will change it.
>
> > > +- objtrace
> > > +
> > > +  This command provides a way to get the value of any object, The object
> > > +  can be obtained from the dynamic event(kprobe_event/uprobe_event) or the
> > > +  static event(tracepoint).
> > > +
> > > +  Usage:
> > > +  When using the kprobe event, only need to set the objtrace(a new trigger),
> > > +  we can get the value of the object. The object is from the setting of the
> > > +  kprobe event.
> > > +
> >
> > Did you mean "the object value can be obtained by only needing to set the
> > objtrace?"
>
> Yes, that's what it means.
>
> > > +  For example:
> > > +  For the function bio_add_page():
> > > +
> > > +  int bio_add_page(struct bio *bio, struct page *page,
> > > +     unsigned int len, unsigned int offset)
> > > +
> > > +  Firstly, we can set the base of the object, thus the first string "arg1"
> > > +  stands for the value of the first parameter of this function bio_add_gage(),
> > > +
> > > +  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > > +
> >
> > Did you mean "the first parameter (arg1) is the parameter value of function
> > that is passed to kprobe_event, in this case the object base"?
>
> Yes, that's what it means.
>
> > > +  Secondly, we can get the value dynamically based on above object.
> > > +
> > > +  find the offset of the bi_size in struct bio:
> > > +  $ gdb vmlinux
> > > +  (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > > +  $1 = (unsigned int *) 0x28
> > > +
> > > +  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> > > +     p_bio_add_page_0/trigger
> > > +
> > > +  # cd /sys/kernel/debug/tracing/
> > > +  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > > +  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> > > +
> > > +  # du -sh /test.txt
> > > +  12.0K   /test.txt
> > > +
> > > +  # cat  /test.txt > /dev/null
> > > +  # cat ./trace
> > > +  # tracer: nop
> > > +  #
> > > +  # entries-in-buffer/entries-written: 128/128   #P:4
> > > +  #
> > > +  #                                _-----=> irqs-off/BH-disabled
> > > +  #                               / _----=> need-resched
> > > +  #                              | / _---=> hardirq/softirq
> > > +  #                              || / _--=> preempt-depth
> > > +  #                              ||| / _-=> migrate-disable
> > > +  #                              |||| /     delay
> > > +  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > > +  #              | |         |   |||||     |         |
> > > +               cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> > > +               cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> > > +               cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
> > > +               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> > > +               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> > > +               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
> > > +               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> > > +               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> > > +               cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> > > +               cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> > > +               cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> > > +               cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
> > > +               cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> > > +               cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> > > +               cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> > > +               cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > > +               cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > > +               cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > > +               cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > > +               cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > > +            <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
> > > +            <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> > > +            <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> > > +            <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
> > > +            <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > > +            <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > > +            <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
> > > +            <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > > +             ...
> > > +
> >
> > The output is messy, because for code example and output, literal code
> > blocks aren't used, hence trigger new warnings:
> >
> > Documentation/trace/events.rst:564: WARNING: Inline emphasis start-string without end-string.
> > Documentation/trace/events.rst:564: WARNING: Inline emphasis start-string without end-string.
> > Documentation/trace/events.rst:573: WARNING: Inline emphasis start-string without end-string.
> > Documentation/trace/events.rst:573: WARNING: Inline emphasis start-string without end-string.
> > Documentation/trace/events.rst:602: WARNING: Unexpected indentation.
> > Documentation/trace/events.rst:622: WARNING: Block quote ends without a blank line; unexpected unindent.
> > Documentation/trace/events.rst:630: WARNING: Unexpected indentation.
> >
> > I had to apply the following fixup (with rewording):
>
> Thank you so much for your help, It looks better ;-)
>
> > ---- >8 ----
> >
> > diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> > index 0dc47516013331..c15f1d25d4a071 100644
> > --- a/Documentation/trace/events.rst
> > +++ b/Documentation/trace/events.rst
> > @@ -549,85 +549,89 @@ The following commands are supported:
> >  - objtrace
> >
> >    This command provides a way to get the value of any object, The object
> > -  can be obtained from the dynamic event(kprobe_event/uprobe_event) or the
> > -  static event(tracepoint).
> > +  can be obtained from the dynamic event (kprobe_event/uprobe_event) or the
> > +  static event (tracepoint).
> >
> >    Usage:
> > -  When using the kprobe event, only need to set the objtrace(a new trigger),
> > -  we can get the value of the object. The object is from the setting of the
> > -  kprobe event.
> > +  When using the kprobe event, by only need to set the objtrace (a new
> > +  trigger), we can get the value of object that is set by kprobe event.
> >
> > -  For example:
> > -  For the function bio_add_page():
> > +  For example, for the function bio_add_page():
> >
> > -  int bio_add_page(struct bio *bio, struct page *page,
> > -       unsigned int len, unsigned int offset)
> > +  .. code-block:: c
> >
> > -  Firstly, we can set the base of the object, thus the first string "arg1"
> > -  stands for the value of the first parameter of this function bio_add_gage(),
> > +     int bio_add_page(struct bio *bio, struct page *page,
> > +                     unsigned int len, unsigned int offset)
> >
> > -  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > +  Firstly, we can set the base of the object as first parameter (arg1) to
> > +  to the function:
> >
> > -  Secondly, we can get the value dynamically based on above object.
> > +  .. code-block::
> >
> > -  find the offset of the bi_size in struct bio:
> > -  $ gdb vmlinux
> > -  (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > -  $1 = (unsigned int *) 0x28
> > +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> >
> > -  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> > -       p_bio_add_page_0/trigger
> > +  Secondly, we can get the value dynamically based on the object:
> >
> > -  # cd /sys/kernel/debug/tracing/
> > -  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > -  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> > +  .. code-block::
> >
> > -  # du -sh /test.txt
> > -  12.0K   /test.txt
> > +     find the offset of the bi_size in struct bio:
> > +     $ gdb vmlinux
> > +     (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > +     $1 = (unsigned int *) 0x28
> >
> > -  # cat  /test.txt > /dev/null
> > -  # cat ./trace
> > -  # tracer: nop
> > -  #
> > -  # entries-in-buffer/entries-written: 128/128   #P:4
> > -  #
> > -  #                                _-----=> irqs-off/BH-disabled
> > -  #                               / _----=> need-resched
> > -  #                              | / _---=> hardirq/softirq
> > -  #                              || / _--=> preempt-depth
> > -  #                              ||| / _-=> migrate-disable
> > -  #                              |||| /     delay
> > -  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > -  #              | |         |   |||||     |         |
> > -               cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> > -               cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> > -               cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
> > -               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> > -               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> > -               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
> > -               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> > -               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> > -               cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> > -               cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> > -               cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> > -               cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
> > -               cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> > -               cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> > -               cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> > -               cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > -               cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > -               cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > -               cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > -               cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > -            <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
> > -            <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> > -            <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> > -            <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
> > -            <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > -            <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > -            <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
> > -            <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > -             ...
> > +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> > +       p_bio_add_page_0/trigger
> > +
> > +     # cd /sys/kernel/debug/tracing/
> > +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> > +
> > +     # du -sh /test.txt
> > +     12.0K   /test.txt
> > +
> > +     # cat  /test.txt > /dev/null
> > +     # cat ./trace
> > +     # tracer: nop
> > +     #
> > +     # entries-in-buffer/entries-written: 128/128   #P:4
> > +     #
> > +     #                                _-----=> irqs-off/BH-disabled
> > +     #                               / _----=> need-resched
> > +     #                              | / _---=> hardirq/softirq
> > +     #                              || / _--=> preempt-depth
> > +     #                              ||| / _-=> migrate-disable
> > +     #                              |||| /     delay
> > +     #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > +     #              | |         |   |||||     |         |
> > +                  cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> > +                  cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> > +                  cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
> > +                  cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> > +                  cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> > +                  cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
> > +                  cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> > +                  cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> > +                  cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +               <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +                ...
> >
> >  7. In-kernel trace event API
> >  ============================
> >
> >
> > Thanks.
> >
> > --
> > An old man doll... just what I always wanted! - Clara
>
> Thanks,
> JeffXie

Thanks,
JeffXie
