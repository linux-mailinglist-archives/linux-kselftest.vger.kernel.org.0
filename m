Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366A164F0C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 19:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiLPSMZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 13:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiLPSMY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 13:12:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972B920995
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 10:12:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so3209670pjd.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 10:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9AvFs+mQ9NvsJS8PCk/jQ9HRlu8dyTK47yIOgmc4j1w=;
        b=Z8HAKYx0UY/wu6NVqgsze4WbTymS+TIwPZKlAOTZHZNQvL+odF4DJP+a0EtqODJLG+
         P6OR2GWtkeMbYmvG9vgv2EVGh3J+4D+435J4QzqYTHPz801yG/ElNzFzc7/IIh7SIkxd
         1dVMIQ+yEGFdO3W9FFeH9PtvU6qCguIbrbDqPx8PTjBlhaYALLu6jUNAh2CbrRpACQoN
         zanigDW0F193AC03lAYwjlfHz9TYBVcNW3pu0tp/H67Eb8nVBA/mfn02U37Qy45uDRPP
         C880rQ57sQYeKFNFunkSqyeZ7oI6fmK8QlAoo2SLh5yC0g7ZhY3wiHgIu1sJqp9muigf
         yd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AvFs+mQ9NvsJS8PCk/jQ9HRlu8dyTK47yIOgmc4j1w=;
        b=ZcTk9imFdi2ccav64jqW7pWkK+sW9llccs1AD1m4L30OrPhcBiJFhPD4W9j+2SsyXu
         8GdExXbmR2R90s3xvfKcxR8pOZwuvJspLrQvvzSivGRdHb/5DVAwK4P/UhTVYAkATYla
         HD6L4793RKTv3r3kCvnyhO/mMKtiaECil1kYHa5oanwymmi8/jCmC8RC4mKVgh9q5Niz
         Pq0CkbDiRRZ0RBZnnJ98Tw4JA09KR4XPydfgK6t9husRqEXcJy42GMbkpk6Wk8Fg24uJ
         wbRMhcdw4udeSrX+PPiKohNP0svdH7eUYi0NVi6Fn7LBkoIlOzvit8roJfHhlRxUe612
         v/vw==
X-Gm-Message-State: ANoB5pm8aN5kQcSIdGovaDaMJRnPA9yGxZdAcrYCFhIY7fbKjH+w/J2h
        D12kzkSyz1GmGMtNojL8YBgQWB8gPmS6Kys+veIJzA==
X-Google-Smtp-Source: AA0mqf78wqBM9aLl5xrt1webKvseMwn62xPSVHCYh0jx15lTP5g9KIcnYuXdLMWYz0eZo7MsT6YbznTDbXh4vw3ArEc=
X-Received: by 2002:a17:903:3052:b0:189:63ef:ef3b with SMTP id
 u18-20020a170903305200b0018963efef3bmr66036808pla.112.1671214341841; Fri, 16
 Dec 2022 10:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20221207154939.2532830-1-jeffxu@google.com> <20221207154939.2532830-4-jeffxu@google.com>
 <202212080821.5AE7EE99@keescook> <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
 <Y5yS8wCnuYGLHMj4@x1n> <CALmYWFsDhX76zbcyhYAW-u0BBwD+m+TKpt4_pZTMt+22zHhrGQ@mail.gmail.com>
 <20221216094259.bec91e4abd6cf54a05ce2813@linux-foundation.org>
In-Reply-To: <20221216094259.bec91e4abd6cf54a05ce2813@linux-foundation.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 16 Dec 2022 10:11:44 -0800
Message-ID: <CALmYWFsNp87a5uVQUAb4PG0khFN8Xxd=ibh9Q7g-Y0XW1Mn-8Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Kees Cook <keescook@chromium.org>,
        jeffxu@chromium.org, skhan@linuxfoundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 16, 2022 at 9:43 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 16 Dec 2022 09:15:40 -0800 Jeff Xu <jeffxu@google.com> wrote:
>
> > On Fri, Dec 16, 2022 at 7:47 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Hi, Jeff,
> > >
> > > On Thu, Dec 08, 2022 at 02:55:45PM -0800, Jeff Xu wrote:
> > > > > > +     if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
> > >
> > > [...]
> > >
> > > > > > +             pr_warn_ratelimited(
> > > > > > +                     "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
> > > > > > +                     task_pid_nr(current), get_task_comm(comm, current));
> > >
> > > This will be frequently dumped right now with mm-unstable.  Is that what it
> > > wanted to achieve?
> > >
> > > [   10.822575] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=491 'systemd'
> > > [   10.824743] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=495 '(sd-executor)'
> > > ...
> > >
> > > If there's already a sane default value (and also knobs for the user to
> > > change the default) not sure whether it's saner to just keep it silent as
> > > before?
> > >
> > Thanks for your comments.
> >
> > The intention is it is a reminder to adjust API calls to explicitly
> > setting this bit.
>
> Do we need to warn more than once per boot?  If not, use pr_warn_once()?
>
Once per boot seems too little, it would be nice if we can list all processes.
I agree ratelimited might be too much.
There is a feature gap here for logging.

Kees, what do you think ?


> > The sysctl vm.memfd_noexec = 0 1 is for transaction to the final
> > state, and 2 depends on API call setting this bit.
> >
> > The log is ratelimited, and there is a rate limit setting:
> > /proc/sys/kernel/printk_ratelimit
> > /proc/sys/kernel/printk_ratelimit_burst
> >
>
