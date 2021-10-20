Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B406434E5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 16:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTO53 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhJTO5Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 10:57:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60CFC06174E
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 07:55:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso682509pjm.4
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NT+VI0Pymfgi6KrPfEOh2aqPixHFbwmQSZYnbq0Cs8=;
        b=VgKpw9rBhIl9RgSTHOjvXPIBuB/3bKcIuicn3KbBJkWLJC9PScz/RQOUPKGAs2+Wf8
         Lmtc88UjoeFw2ZjzncYMNMq62hYATOHb9LamR82sNaVY6GWzAy4lCsslUBQWmONdEIp/
         um/E6qs9qGGSa55H8O5DjF4uSrQO8aGK4bxZOAqzO/QjnezVR0TDwKJ5qWq+CwSyFnuo
         qkg5qkl1ezQ0tW/XgDQnlouKgBz+uMIKnk4nNV6uMrA6AdMKI321FUFlufT4R5IU0LED
         xu2e61fNfS0wc6F0mGrAgYrISF4LHyvQmIbpAqIjNBo9gaxwPSnXpYXH9oqzKHyg+eJ4
         mEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NT+VI0Pymfgi6KrPfEOh2aqPixHFbwmQSZYnbq0Cs8=;
        b=TLD/08zV0uI6HiPHggdCnnyK1mXD9xUfIS6kT/62Sr1AW2LlZOLjvbPA3t4CASd+9e
         A9oFSia9RKhxZHug44pzfBaBFX3IbXA9N/mLMkp3vvDzrYcwJdcGDnqdpAGKtv0BDcI7
         gFjfMywaktwzn2LfP8BxYVUVL/LR94aqlaiUjQKVNiCbXLTRobtBteAChPLzduptKcWr
         WAOq2QGJh9+7Z2VkBd72y8hSBDq31DFwylbThdnPy5vKuStNZUZTb3r4+5vKLzSL4kHa
         DJoaMnwOiaPTHw85+qM4b/05V02NoWsVxFxoWg4fTCcuQENRypcPK9wTQ/D658j4/jRT
         Axdw==
X-Gm-Message-State: AOAM5326mObDB3hWllWHvMcyxbnscjay4F23eaflKOKI8yMseNdgXdRz
        hA4iORmIOntdTf0svtGBzVg75I+9A3EcorVWSo7Y4Q==
X-Google-Smtp-Source: ABdhPJy+/In60vXj7hn1ZIyupFzyRXUdajqsjYN/iP/ZUU37ATuNxBenskG9v8CQW0z7L7jYp7uAxxFe1aq9arYtWs8=
X-Received: by 2002:a17:903:18d:b0:13f:ada:9df4 with SMTP id
 z13-20020a170903018d00b0013f0ada9df4mr39582515plg.69.1634741710041; Wed, 20
 Oct 2021 07:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211020013153.4106001-1-kaleshsingh@google.com>
 <20211020013153.4106001-3-kaleshsingh@google.com> <20211019222756.1fde436b@gandalf.local.home>
In-Reply-To: <20211019222756.1fde436b@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 20 Oct 2021 07:54:59 -0700
Message-ID: <CAC_TJvcZ4ndpQpsj4ANj9LpzSu6GfPSdxpVc0XShbi9u_bSUyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tracing: Add division and multiplication support
 for hist triggers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 19, 2021 at 7:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 19 Oct 2021 18:31:39 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > +static u64 hist_field_div(struct hist_field *hist_field,
> > +                        struct tracing_map_elt *elt,
> > +                        struct trace_buffer *buffer,
> > +                        struct ring_buffer_event *rbe,
> > +                        void *event)
> > +{
> > +     struct hist_field *operand1 = hist_field->operands[0];
> > +     struct hist_field *operand2 = hist_field->operands[1];
> > +
> > +     u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
> > +     u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
> > +
> > +     /* Return -1 for the undefined case */
> > +     if (!val2)
> > +             return -1;
> > +
> > +     return div64_u64(val1, val2);
> > +}
> > +
>
> I wonder if you should add a shift operator as well?
>
> I mean, if for some reason you want to divide by a power of two, then why
> us the division. Especially if this is on a 32 bit machine.
>
> Of course, the parsing could detect that. If the divisor is a constant. Or
> we could even optimize the above with:
>
>         if (!val2)
>                 return -1;
>
>         if (!(val2 & (val2 - 1))
>                 return val1 >> __ffs64(val2);
>
> Which should be faster than a divide, and even if it isn't a power of two,
> the subtract and & should be in the noise compared to the divide.
>
> Note, the above can be added to this. I'm not suggesting changing this
> patch.

Is it worth adding something like this for the multiplication case as well?

- Kalesh

>
> -- Steve
