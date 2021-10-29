Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB7440293
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhJ2Sz5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 14:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJ2Sz5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 14:55:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437C2C061714
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 11:53:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so11294500pjl.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBv+CmSBrWb0ocEAJGD5OU4xQhjlyiCSACmPaFkV+I4=;
        b=UkxUEWUWz1xYHSm4eO8IgCee9Cl7olfUF0YnVboSTpIQQU2j9nVYj2VVMWelsX1QSf
         um1ai8rw3M5CO8oWbbvsg7YVdfuCAVlm4+Koz8MfPGXoi07zT/VdlfwhQJuKPYudSLUm
         JUihFMnA81Cm8MSDrJOiounpcNP7E6usnzbqMW2kZ2bXP+iEGAn7Dc9WyGZnaVAiRbxc
         QuqC8br8boKRUS86Jw2QuQddqLvMVOfdSa0KmAOgBuajL9Tx8Ij/HlMgqeXNHwbmkfUJ
         pBsrurqoi7SR5EvKGX3rs4t3teLkcWjdZN7i1RuyEuGjlXDSPfzFTZOKZMTcd1tLks53
         nj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBv+CmSBrWb0ocEAJGD5OU4xQhjlyiCSACmPaFkV+I4=;
        b=nYeu4bd+uir+UWbQSXRja3gCpCLJKTCEjvW73LPhRmWTRMHx8SxWpRmlODdRXSkl3w
         6rXSH9n0UmyQ5Alnl05MlZ6CLbxxK6PeDbDkDqAWgCAKHz9e5IWWBVA+6s8viLxvdUq9
         uyCekwTwhwSgjsmZ0BSguLqalSBCM2o6MEKzPrOT2nQsKh4wQP1ykAc9yTrxE4tw33xN
         k4QDlzSErXolByFOdE9xoMFpkaoya/CAIkBWDDPg9WRsa+Pp5f8q7yEpd46i8etgPZlz
         8XBsYZzOu1iokGSYpDYT43Pf4RKG2q0X9LdoE/2pi3CVyWlaeQneDL1/9GHGp43NMJD0
         10Pw==
X-Gm-Message-State: AOAM531sqK+lvKDyWD3jMxDTG4hSQ8ZCKgUYPcf1yfcmH6CvW/RmG9JW
        xOUkqgKnxig41T+WTjdnAH0hHnOdnOboghXj7sRK2Q==
X-Google-Smtp-Source: ABdhPJzGoDLyGtyWEbHlWgMAPwTNPa8f3hBhvJkWfz8iePx2TipsZY39uUrw3L65nju3l83WKhblEEME9EHkbLfrpwg=
X-Received: by 2002:a17:90b:1c0c:: with SMTP id oc12mr13415336pjb.124.1635533607445;
 Fri, 29 Oct 2021 11:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211029183339.3216491-1-kaleshsingh@google.com>
 <20211029183339.3216491-2-kaleshsingh@google.com> <20211029144524.367d6789@gandalf.local.home>
In-Reply-To: <20211029144524.367d6789@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 29 Oct 2021 11:53:16 -0700
Message-ID: <CAC_TJve9OsL5taBN0ckgjG4=HxvmWfP6ULwwqnVsDyRxuQuRkg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tracing/histogram: Optimize division by constants
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, mhiramat@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 29, 2021 at 11:45 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 29 Oct 2021 11:33:27 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > If the divisor is a constant use specific division functions to
> > avoid extra branches when the trigger is hit.
> >
> > If the divisor constant but not a power of 2, the division can be
> > replaced with a multiplication and shift in the following case:
> >
> > Let X = dividend and Y = divisor.
> >
> > Choose Z = some power of 2. If Y <= Z, then:
> >     X / Y = (X * (Z / Y)) / Z
> >
> > (Z / Y) is a constant (mult) which is calculated at parse time, so:
> >     X / Y = (X * mult) / Z
> >
> > The division by Z can be replaced by a shift since Z is a power of 2:
> >     X / Y = (X * mult) >> shift
> >
> > As long, as X < Z the results will not be off by more than 1.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >
> > Changes in v2:
> >   - Return -EDOM if divisor is a constant and zero, per Steve
> >
> >  kernel/trace/trace_events_hist.c | 117 ++++++++++++++++++++++++++++++-
> >  1 file changed, 116 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 364cb3091789..1084aa41f047 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -68,7 +68,8 @@
> >       C(INVALID_SORT_FIELD,   "Sort field must be a key or a val"),   \
> >       C(INVALID_STR_OPERAND,  "String type can not be an operand in expression"), \
> >       C(EXPECT_NUMBER,        "Expecting numeric literal"),           \
> > -     C(UNARY_MINUS_SUBEXPR,  "Unary minus not supported in sub-expressions"),
> > +     C(UNARY_MINUS_SUBEXPR,  "Unary minus not supported in sub-expressions"), \
> > +     C(DIVISION_BY_ZERO,     "Division by zero"),
> >
> >  #undef C
> >  #define C(a, b)              HIST_ERR_##a
> > @@ -92,6 +93,7 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
> >  #define HIST_FIELDS_MAX              (TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
> >  #define HIST_ACTIONS_MAX     8
> >  #define HIST_CONST_DIGITS_MAX        21
> > +#define HIST_DIV_SHIFT               20  /* For optimizing division by constants */
> >
> >  enum field_op_id {
> >       FIELD_OP_NONE,
> > @@ -160,6 +162,8 @@ struct hist_field {
> >
> >       /* Numeric literals are represented as u64 */
> >       u64                             constant;
> > +     /* Used to optimize division by constants */
> > +     u64                             div_multiplier;
> >  };
> >
> >  static u64 hist_field_none(struct hist_field *field,
> > @@ -311,6 +315,72 @@ static u64 hist_field_div(struct hist_field *hist_field,
> >       return div64_u64(val1, val2);
> >  }
> >
> > +static u64 div_by_power_of_two(struct hist_field *hist_field,
> > +                             struct tracing_map_elt *elt,
> > +                             struct trace_buffer *buffer,
> > +                             struct ring_buffer_event *rbe,
> > +                             void *event)
> > +{
> > +     struct hist_field *operand1 = hist_field->operands[0];
> > +     struct hist_field *operand2 = hist_field->operands[1];
> > +
> > +     u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
> > +     u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
>
> If these functions are only called when val2 is constant, can't we make it
> such that we get val2 from the hist_field directly? That is:
>
>         u64 val2 = operand2->constant;

operand2 might be a var ref to a constant, so we would need to resolve
that with hist_field_var_ref().

-Kalesh

>
> That would save us a function call, and an indirect on at that (that gets
> slowed down by spectre).
>
> Same for the ones below.
>
> -- Steve
>
>
> > +
> > +     return val1 >> __ffs64(val2);
> > +}
> > +
> > +static u64 div_by_not_power_of_two(struct hist_field *hist_field,
> > +                             struct tracing_map_elt *elt,
> > +                             struct trace_buffer *buffer,
> > +                             struct ring_buffer_event *rbe,
> > +                             void *event)
> > +{
> > +     struct hist_field *operand1 = hist_field->operands[0];
> > +     struct hist_field *operand2 = hist_field->operands[1];
> > +
> > +     u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
> > +     u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
> > +
> > +     return div64_u64(val1, val2);
> > +}
> > +
> > +static u64 div_by_mult_and_shift(struct hist_field *hist_field,
> > +                             struct tracing_map_elt *elt,
> > +                             struct trace_buffer *buffer,
> > +                             struct ring_buffer_event *rbe,
> > +                             void *event)
> > +{
> > +     struct hist_field *operand1 = hist_field->operands[0];
> > +     struct hist_field *operand2 = hist_field->operands[1];
> > +
> > +     u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
> > +
> > +     /*
> > +      * If the divisor is a constant, do a multiplication and shift instead.
> > +      *
> > +      * Choose Z = some power of 2. If Y <= Z, then:
> > +      *     X / Y = (X * (Z / Y)) / Z
> > +      *
> > +      * (Z / Y) is a constant (mult) which is calculated at parse time, so:
> > +      *     X / Y = (X * mult) / Z
> > +      *
> > +      * The division by Z can be replaced by a shift since Z is a power of 2:
> > +      *     X / Y = (X * mult) >> HIST_DIV_SHIFT
> > +      *
> > +      * As long, as X < Z the results will not be off by more than 1.
> > +      */
> > +     if (val1 < (1 << HIST_DIV_SHIFT)) {
> > +             u64 mult = operand2->div_multiplier;
> > +
> > +             return (val1 * mult + ((1 << HIST_DIV_SHIFT) - 1)) >> HIST_DIV_SHIFT;
> > +     } else {
> > +             u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
> > +
> > +             return div64_u64(val1, val2);
> > +     }
> > +}
> > +
> >  static u64 hist_field_mult(struct hist_field *hist_field,
> >                          struct tracing_map_elt *elt,
> >                          struct trace_buffer *buffer,
> > @@ -573,6 +643,37 @@ struct snapshot_context {
> >       void                    *key;
> >  };
> >
> > +
> > +static struct hist_field *find_var_field(struct hist_trigger_data *hist_data,
> > +                                      const char *var_name);
> > +
> > +/*
> > + * Returns the specific division function to use if the divisor
> > + * is constant. This avoids extra branches when the trigger is hit.
> > + */
> > +static hist_field_fn_t hist_field_get_div_fn(struct hist_field *divisor)
> > +{
> > +     u64 div;
> > +
> > +     if (divisor->flags & HIST_FIELD_FL_VAR_REF) {
> > +             struct hist_field *var;
> > +
> > +             var = find_var_field(divisor->var.hist_data, divisor->name);
> > +             div = var->constant;
> > +     } else
> > +             div = divisor->constant;
> > +
> > +     if (!(div & (div - 1)))
> > +             return div_by_power_of_two;
> > +
> > +     /* If the divisor is too large, do a regular division */
> > +     if (div > (1 << HIST_DIV_SHIFT))
> > +             return div_by_not_power_of_two;
> > +
> > +     divisor->div_multiplier = div64_u64((u64)(1 << HIST_DIV_SHIFT), div);
> > +     return div_by_mult_and_shift;
> > +}
> > +
> >  static void track_data_free(struct track_data *track_data)
> >  {
> >       struct hist_elt_data *elt_data;
> > @@ -2575,6 +2676,20 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> >       expr->operands[0] = operand1;
> >       expr->operands[1] = operand2;
> >
> > +
> > +     if (field_op == FIELD_OP_DIV &&
> > +                     operand2_flags & HIST_FIELD_FL_CONST) {
> > +             u64 divisor = (var2) ? var2->constant : operand2->constant;
> > +
> > +             if (!divisor) {
> > +                     hist_err(file->tr, HIST_ERR_DIVISION_BY_ZERO, errpos(str));
> > +                     ret = -EDOM;
> > +                     goto free;
> > +             }
> > +
> > +             op_fn = hist_field_get_div_fn(operand2);
> > +     }
> > +
> >       if (combine_consts) {
> >               if (var1)
> >                       expr->operands[0] = var1;
>
