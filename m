Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75382434078
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 23:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhJSV0u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhJSV0u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:50 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04541C06174E
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 14:24:37 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f5so20546598pgc.12
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1si5m6BF6jZCqxr99Qj6El0HYO83QaZGvDIz0S0L30=;
        b=W80OU86DZhWDlHKYd/h6qPAN/PtnItZBIHXq8zniXU26IVK7CrfyrUU5+EKGh8LdHH
         ogdbRaptDNWRY3KhmeDJxthim2uUsObmoq7ujp6+Gq528vT/dkvisHHNWrtizMmvFHvD
         CxzX6256nD5KUaVbxSp83dSVFF/wLffiKJUptudpTbTlVugAZESMjKyZ83oumJYneHAc
         Karlj3m/udREInvXvJXWJ2fMSHE6O1afYk9J6wPzt9lU4rKUPa0NVF1wkXiBdJIS4yUY
         yj8P/dTK1kT3m5sAY8aJ7ZmB4TsDn0Pz/Nfei6dnB0AArFXOjnBKrXjnkwQhyoTEWt+i
         p8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1si5m6BF6jZCqxr99Qj6El0HYO83QaZGvDIz0S0L30=;
        b=SvfaUbDyf31sZ4fXAVBxpXx2KnWY98sbsEkhWE/AtwqDCwgqb7e3kFYT1a01WShZYE
         UibNWjzGK2XN/vPDcOeXccTqfbrCLMnTULN3viio+1ZUMm9WW988PWWttlHBHg0CZnQC
         qHrEz9hKM8VCwq82V5mWHFAOi227e0FeAIH/oG23CMypLjdFJtRd/b0SJKXO/UpEN/Ad
         aX5EjxTICmbV0no+N3e+6hDWyeoTygjO/iwFI4g6nmnqzl7/6eojl1WhD2leKsUckwiU
         LfHpTiJFkLpTnYr0xaCbZQX5v8x7QWaEDKQ8DEPm+JxCy1OwA2H8HAdL7XEq4spAPHHm
         HBAw==
X-Gm-Message-State: AOAM5336ALW8Agf9j8Og+lhGaYUDm//962/h5zwyl4EaHWTXM773NFA2
        vbao/gJZ7HktS+3oIhSO2yDQK455f5OJp0pjyhWFpA==
X-Google-Smtp-Source: ABdhPJyoRWH8TInbYx2Q90uq5QUbXJ8TyWTY3GCnSuCuhdVMLsoRQRll+Kom+uMG4jeaW3a4JBiY4IuX39KgviXe2s8=
X-Received: by 2002:a63:3483:: with SMTP id b125mr30964529pga.79.1634678676292;
 Tue, 19 Oct 2021 14:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210915195306.612966-1-kaleshsingh@google.com>
 <20210915195306.612966-3-kaleshsingh@google.com> <20211019164543.2ca20830@gandalf.local.home>
In-Reply-To: <20211019164543.2ca20830@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 19 Oct 2021 14:24:25 -0700
Message-ID: <CAC_TJveS5shKASQZuBeXr2SbVURQPCAWWgMEHBgnv5zPvCC40g@mail.gmail.com>
Subject: Re: [PATCH 2/5] tracing: Add division and multiplication support for
 hist triggers
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
        <linux-kselftest@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 19, 2021 at 1:45 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 15 Sep 2021 19:52:46 +0000
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
> > +     return val1 / val2;
>
> This wont work on x86 32 bit machines, as u64 division will trigger
> floating point arithmetic by the compiler, and cause a fault.

Thanks for catching this. I'll address it in the next version.

- Kalesh

>
> You'll need to use one of the div64() helpers.
>
> -- Steve
>
>
> > +}
> > +
