Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF4D43BECB
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 03:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbhJ0BMJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 21:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbhJ0BMJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 21:12:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236AAC061570
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 18:09:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m21so1214851pgu.13
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 18:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IE1yW+OMDFYK7DVFzbjLOEHKVUKZvs6KTijL3WSzHgs=;
        b=NLNyXqReix36CnFm1oFZAZzWewcBWEwwtwbwJQL1EqMUIYV8pEqTcKuyH6Kdy0Px4V
         2pNR+PqQqvFi/tW0FOcQ5fsKwQjkn5w2HBZwkDMcA+U+MAi5uXLCl+3s874yt0wyhFpT
         GMjsk+L/F72TgL/e9+UJcfgPXjbBJZY6ngzNKjMAFZxAy1uBQGShKV49ljsdDZoxtbFy
         soxwso5992LkvJM/vKNtmDLloczp2Hq++1GH4SiW9cWja2WhpGpwoOReyQoaFs9oSPar
         s+wULBwFIa8Re4QBM0DghmfyIUxe3BKsXSc6VnamBgDdu2YNf5y/d6CoPLN3R4GjxTkE
         ehMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IE1yW+OMDFYK7DVFzbjLOEHKVUKZvs6KTijL3WSzHgs=;
        b=ilyueRbGsO2IUfPISPel92WL0S+ovW5/+qUCdYOqZwwdABQVMYc1qV6sfqa+24aD+Z
         jvdNhFTJoVxqgjU8YzTnxYyzArX6y31k7AfEMmp306fSs2fW4USJ793NtxKK7bghN/cH
         7+aCXMHYCHCohvCEUI7R1sNAeBiy4kbSwgSM0ex5P+UEfSJNHwf9b/cgM8ea0vb/w4DW
         zylDclXCxr9VhCCS1X8fpdOCMJ6Owhfejth0VhDZ424MIunDxXQTEjBarRVV3vXhT6qH
         5LentNOWV2xdtwCE1d629gQAhjjf8J93XtDufDSLvzU/7t+3OmRhEK+Z450C6jqfKjtn
         AgiA==
X-Gm-Message-State: AOAM5300booTA3UlYNv970cs5VWwNKSob1T2P8wROK3xEqNJcgxosw4l
        iu+EY+95r4wxaQV389r01nLOtWLF7Poo+6sNfW5ug4iDGXo=
X-Google-Smtp-Source: ABdhPJwd5SxRRHuClfQQAiRjCXQTrpzQChfLU0PAB6BN/EZhNgwPC0gDz0AC+Eq2iNzGTJUXciRXHM1e4aJmtX+MHVk=
X-Received: by 2002:a05:6a00:179c:b0:47c:2092:c28c with SMTP id
 s28-20020a056a00179c00b0047c2092c28cmr3188193pfg.59.1635296973719; Tue, 26
 Oct 2021 18:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211025200852.3002369-1-kaleshsingh@google.com>
 <20211025200852.3002369-7-kaleshsingh@google.com> <20211026151451.7f3e09a4@gandalf.local.home>
 <CAC_TJveHgsPZw7p7BWOgQw6h8GNU_Pv_WUjNmw3AUq+wnSzk6Q@mail.gmail.com> <20211026201846.08990d1d@rorschach.local.home>
In-Reply-To: <20211026201846.08990d1d@rorschach.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 26 Oct 2021 18:09:22 -0700
Message-ID: <CAC_TJve-mKSojaXtukdFeQKvPz-8TQtS=pgGD0Z18Wt6yJi7dg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] tracing/histogram: Optimize division by a power of 2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 26, 2021 at 5:18 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Oct 2021 16:39:13 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > >         // This works best for small divisors
> > >         if (div > max_div) {
> > >                 // only do a real division
> > >                 return;
> > >         }
> > >         shift = 20;
> > >         mult = ((1 << shift) + div - 1) / div;
> > >         delta = mult * div - (1 << shift);
> > >         if (!delta) {
> > >                 /* div is a power of 2 */
> > >                 max = -1;
> > >                 return;
> > >         }
> > >         max = (1 << shift) / delta;
> >
> > I'm still trying to digest the above algorithm.
>
> mult = (2^20 + div - 1) / div;
>
> The "div - 1" is to round up.
>
> Basically, it's doing:  X / div  = X * (2^20 / div) / 2^20
>
> If div is constant, the 2^20 / div is constant, and the "2^20" is the
> same as a shift.
>
> So multiplier is 2^20 / div, and the shift is 20.
>
> But because there's rounding errors it is only accurate up to the
> difference of:
>
>   delta = mult * div / 2^20
>
> That is if mult is a power of two, then there would be no rounding
> errors, and the delta is zero, making the max infinite:
>
>   max = 2^20 / delta as delta goes to zero.
>
> > But doesn't this add 2 extra divisions? What am I missing here?
>
> The above is only done at parsing not during the trace, where we care
> about.

Hi Steve,

Thanks for the explanation, this cleared it up for me.

- Kalesh

>
> > >
> > >
> > > We would of course need to use 64 bit operations (maybe only do this for 64
> > > bit machines). And perhaps even use bigger shift values to get a bigger max.
> > >
> > > Then we could do:
> > >
> > >         if (val1 < max)
> > >                 return (val1 * mult) >> shift;
>
> This is done at the time of recording.
>
> Actually, it would be:
>
>         if (val1 < max)
>                 return (val1 * mult) >> shift;
>         else
>                 return val1 / div;
>
> -- Steve
