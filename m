Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C7D434069
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 23:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhJSVX3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 17:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhJSVX3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 17:23:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA125C06161C
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 14:21:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 21so14598505plo.13
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2jhZlXrpk36rWXoQ81LZZvnNqC+n5/mdi3guRUAkO0=;
        b=LYi4+NnnfP0J6789EEebKcu0dApyAjclojXAdKGfIBZY+gpjAy9yZ1/cwG5vc+9FEI
         gi/Co6xxDkkvTlbOgEmMuyARACCagckvkPyYt/BIvmV6O6XZBu1XgPl0PscxBVXkA594
         o1X8qHYYsaBk/GmlBsxNhtKxr7qsMe+aTvmVJzIy5MCSqi8B608gp9frwfyzmlaMrxVL
         9qwpBgYY9EoKeOt+d3JNuQ2YbkqIT9QAZznAxXglyE3fOusihHg+m4h5ceUVWhBWRzrv
         6bUD7gUhsp50oLl262iLa4vgkQEml9CTBwc4iIKT4q7rKwUFST+WUex8s07PV63QYKsj
         qhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2jhZlXrpk36rWXoQ81LZZvnNqC+n5/mdi3guRUAkO0=;
        b=g78HrhNCeQp5eB0DC5/i4mYTJEUv/4nUwDuPeUafOaVVrldoyn0aqdI/FD1u1Eiz8p
         Vz7fMOd0Hco/RHNmmAooXp5Y8xVRQOEZYpOo6rQuOlgm+cXtdh37ktSAHOOcxqtg8apC
         FkS5nHShgZZaaJ2VxlBLo5HT4AMnRyq5ti0sc5eT4zGodTy+owQq+9lIGXDTm0kaFYkt
         UwXfWfpWeOO/4p8GAz7+TUMweFSMJMSvRyLHsRCmw8skzZprDcinYqDvNu3butNrZkWO
         VDYlOc0Ln++UItc3ru84GI3ieTPq1lJSFPuUYSRrKqbf0U46I6HAwdG3jcoW5FEhue7O
         cVWg==
X-Gm-Message-State: AOAM532e9CpGfnZ6TXCtduMzPcySp+yQwNnRGkwe7f/ErEOS3O+3zUsr
        t8zQqU3HKalohRSmbfQHJqfwjvKcBdtsQDSkj47jkw==
X-Google-Smtp-Source: ABdhPJyivSREcZuKv29sI/+MMH86C8+W8Oqv2bEXBGZ8Niv3bwWkKi+GwQDZJSNnRnxHFl4ELw3HtwM9L+4LHR0bN9U=
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr2553281pjb.124.1634678475225;
 Tue, 19 Oct 2021 14:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210915195306.612966-1-kaleshsingh@google.com>
 <20210915195306.612966-2-kaleshsingh@google.com> <20211019164834.465b2a53@gandalf.local.home>
In-Reply-To: <20211019164834.465b2a53@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 19 Oct 2021 14:21:04 -0700
Message-ID: <CAC_TJvfT-1SeEhDnVjRfcv1SjKmZbcdy=cBVXYeB1GLTv+=e+w@mail.gmail.com>
Subject: Re: [PATCH 1/5] tracing: Add support for creating hist trigger
 variables from literal
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 19, 2021 at 1:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 15 Sep 2021 19:52:45 +0000
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > Currently hist trigger expressions don't support the use of numeric
> > literals:
> >       e.g. echo 'hist:keys=common_pid:x=$y-1234'
> >               --> is not valid expression syntax
> >
> > Having the ability to use numeric constants in hist triggers supports
> > a wider range of expressions for creating variables.
>
> I'm not against the patch, but I'm curious to what use case this would be
> useful for. In the cover letter it mentions the division and multiplication
> for finding associated buckets, but what is the addition / subtraction used
> for?

Addition and subtraction are already supported operations. The use
case given in Documentation/trace/histogram.rst is for calculating
latencies. I don't have a use case where the constants may be needed
in the addition/subtraction, but for simplicity and completeness we
support them for all operations.

- Kalesh

>
> -- Steve
>
>
> >
> > Add support for creating trace event histogram variables from numeric
> > literals.
> >
> >       e.g. echo 'hist:keys=common_pid:x=1234,y=size-1024' >> event/trigger
> >
> > A negative numeric constant is created, using unary minus operator
> > (parentheses are required).
> >
> >       e.g. echo 'hist:keys=common_pid:z=-(2)' >> event/trigger
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> >
