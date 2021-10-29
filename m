Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1487E4402FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJ2TTQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 15:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhJ2TTQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 15:19:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE01C061766
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 12:16:47 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i5so7449181pla.5
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fee4lFZ0WsKbU4ScFmGyAClkQKU9h+c4EKqLYfuXgB0=;
        b=IXm2qJgJhvqkz8uR0ZCpcyXWDreKFGGQ++m4ZYgklgAKpVDl1afXwqt7NqkY+Lt548
         BG8tJbHTUYPVu4V6ORZkJgmYsEH6L/XWi/WfFjm2CVcd/N0A6VU7LSpgDwcQFe5TitP6
         IFbP7z5w/vP668dEwDwP/+ilxWhYL4+qBfyiZj7hblP7P5rNYHc6DL+N1dGU2uFykzPS
         OwLd4Hd88Ca95Ja51wViAtYXdtd8wkjREKS7gf6YcDnoZBIcK3xI8eDmybGOAVuLOPrm
         J30fbxc6BpWQGl7Sc3jdeFplawEeb42z3hNoH09AXQ47VdyBcxplktOOqsF3K+oUvnwK
         vOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fee4lFZ0WsKbU4ScFmGyAClkQKU9h+c4EKqLYfuXgB0=;
        b=5P/cP6o7oGdUEA75rDI4nfRaRXWuAz53GDcxZbDFIObcm0nyB3HynzKbQ2zSk/xZ/2
         oUXTgDeC0cm6WgruYtl69O7YaXxWF56B8XWpqcfrPNsfFluvuKt9jd7kggtljM6/YKwz
         SlgCUnTDCWxtkHl/V3wi1rV4G07GyU7PAawtPX1ggzf0O9u9U4bFoze4+v5cHk0WgK8F
         /NNuTBmoOJQaaRILa9BgLijht6NLY9qxpaXbzdvVDs2I9dDMuHQSLg4RF/Z+gpuC3R3e
         v1WDN2yJGs/a1L36302CFw1OVs/zuqotk6mANHdWDd3CuG0mnY4MF0SlmV5ViTq6uheL
         FYZQ==
X-Gm-Message-State: AOAM533MV9Rj1MvLVbAaJzAKDU70onaK2cHknC4BhmTfYGtG73HDPM1v
        jo81yRg0G5nuT4CIs7BYTix26NKlN3OyQZEGB8NOiQTYt1GWMw==
X-Google-Smtp-Source: ABdhPJwXzXHZxQ2NGokm61i9oLlVLMppBzcCHYB/6lW2c0SZmj+c3A/Zfy1QyjYEv8JhZLuyJYOrcERjxh3NARPga0I=
X-Received: by 2002:a17:902:6ac4:b0:13f:52e1:8840 with SMTP id
 i4-20020a1709026ac400b0013f52e18840mr11084807plt.15.1635535006473; Fri, 29
 Oct 2021 12:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211029183339.3216491-1-kaleshsingh@google.com>
 <20211029183339.3216491-2-kaleshsingh@google.com> <20211029144524.367d6789@gandalf.local.home>
 <CAC_TJve9OsL5taBN0ckgjG4=HxvmWfP6ULwwqnVsDyRxuQuRkg@mail.gmail.com>
In-Reply-To: <CAC_TJve9OsL5taBN0ckgjG4=HxvmWfP6ULwwqnVsDyRxuQuRkg@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 29 Oct 2021 12:16:35 -0700
Message-ID: <CAC_TJvcLKT+Gaz46Y-=7f7o12zoRWD=z4Ht5cbu+y5s5K4qEWw@mail.gmail.com>
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

On Fri, Oct 29, 2021 at 11:53 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> On Fri, Oct 29, 2021 at 11:45 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri, 29 Oct 2021 11:33:27 -0700
> > Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > > If the divisor is a constant use specific division functions to
> > > avoid extra branches when the trigger is hit.
> > >
> > > If the divisor constant but not a power of 2, the division can be
> > > replaced with a multiplication and shift in the following case:
> > >
> > > Let X = dividend and Y = divisor.
> > >
> > > Choose Z = some power of 2. If Y <= Z, then:
> > >     X / Y = (X * (Z / Y)) / Z
> > >
> > > (Z / Y) is a constant (mult) which is calculated at parse time, so:
> > >     X / Y = (X * mult) / Z
> > >
> > > The division by Z can be replaced by a shift since Z is a power of 2:
> > >     X / Y = (X * mult) >> shift
> > >
> > > As long, as X < Z the results will not be off by more than 1.
> > >
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > ---
> > >
> > > Changes in v2:
> > >   - Return -EDOM if divisor is a constant and zero, per Steve
> > >
> > >  kernel/trace/trace_events_hist.c | 117 ++++++++++++++++++++++++++++++-
> > >  1 file changed, 116 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > > index 364cb3091789..1084aa41f047 100644
> > > --- a/kernel/trace/trace_events_hist.c
> > > +++ b/kernel/trace/trace_events_hist.c
> > > @@ -68,7 +68,8 @@
> > >       C(INVALID_SORT_FIELD,   "Sort field must be a key or a val"),   \
> > >       C(INVALID_STR_OPERAND,  "String type can not be an operand in expression"), \
> > >       C(EXPECT_NUMBER,        "Expecting numeric literal"),           \
> > > -     C(UNARY_MINUS_SUBEXPR,  "Unary minus not supported in sub-expressions"),
> > > +     C(UNARY_MINUS_SUBEXPR,  "Unary minus not supported in sub-expressions"), \
> > > +     C(DIVISION_BY_ZERO,     "Division by zero"),
> > >
> > >  #undef C
> > >  #define C(a, b)              HIST_ERR_##a
> > > @@ -92,6 +93,7 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
> > >  #define HIST_FIELDS_MAX              (TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
> > >  #define HIST_ACTIONS_MAX     8
> > >  #define HIST_CONST_DIGITS_MAX        21
> > > +#define HIST_DIV_SHIFT               20  /* For optimizing division by constants */
> > >
> > >  enum field_op_id {
> > >       FIELD_OP_NONE,
> > > @@ -160,6 +162,8 @@ struct hist_field {
> > >
> > >       /* Numeric literals are represented as u64 */
> > >       u64                             constant;
> > > +     /* Used to optimize division by constants */
> > > +     u64                             div_multiplier;
> > >  };
> > >
> > >  static u64 hist_field_none(struct hist_field *field,
> > > @@ -311,6 +315,72 @@ static u64 hist_field_div(struct hist_field *hist_field,
> > >       return div64_u64(val1, val2);
> > >  }
> > >
> > > +static u64 div_by_power_of_two(struct hist_field *hist_field,
> > > +                             struct tracing_map_elt *elt,
> > > +                             struct trace_buffer *buffer,
> > > +                             struct ring_buffer_event *rbe,
> > > +                             void *event)
> > > +{
> > > +     struct hist_field *operand1 = hist_field->operands[0];
> > > +     struct hist_field *operand2 = hist_field->operands[1];
> > > +
> > > +     u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
> > > +     u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
> >
> > If these functions are only called when val2 is constant, can't we make it
> > such that we get val2 from the hist_field directly? That is:
> >
> >         u64 val2 = operand2->constant;
>
> operand2 might be a var ref to a constant, so we would need to resolve
> that with hist_field_var_ref().
>
> -Kalesh
>
> >
> > That would save us a function call, and an indirect on at that (that gets
> > slowed down by spectre).

So would it be adding something like below?

if (operand2->flags & HIST_FIELD_FL_CONST)
        val2 = operand2->constant;
else
        val2 = operand2->fn(operand2, elt, buffer, rbe, event);

Thanks,
Kalesh

> >
> > Same for the ones below.
> >
> > -- Steve
> >
> >
> > > +
> > > +     return val1 >> __ffs64(val2);
> > > +}
> > > +
> > > +static u64 div_by_not_power_of_two(struct hist_field *hist_field,
> > > +                             struct tracing_map_elt *elt,
> > > +                             struct trace_buffer *buffer,
> > > +                             struct ring_buffer_event *rbe,
> > > +                             void *event)
> > > +{
> > > +     struct hist_field *operand1 = hist_field->operands[0];
> > > +     struct hist_field *operand2 = hist_field->operands[1];
> > > +
> > > +     u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
> > > +     u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
> > > +
> > > +     return div64_u64(val1, val2);
> > > +}
> > > +
> > > +static u64 div_by_mult_and_shift(struct hist_field *hist_field,
> > > +                             struct tracing_map_elt *elt,
> > > +                             struct trace_buffer *buffer,
> > > +                             struct ring_buffer_event *rbe,
> > > +                             void *event)
> > > +{
> > > +     struct hist_field *operand1 = hist_field->operands[0];
> > > +     struct hist_field *operand2 = hist_field->operands[1];
> > > +
> > > +     u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
> > > +
> > > +     /*
> > > +      * If the divisor is a constant, do a multiplication and shift instead.
> > > +      *
> > > +      * Choose Z = some power of 2. If Y <= Z, then:
> > > +      *     X / Y = (X * (Z / Y)) / Z
> > > +      *
> > > +      * (Z / Y) is a constant (mult) which is calculated at parse time, so:
> > > +      *     X / Y = (X * mult) / Z
> > > +      *
> > > +      * The division by Z can be replaced by a shift since Z is a power of 2:
> > > +      *     X / Y = (X * mult) >> HIST_DIV_SHIFT
> > > +      *
> > > +      * As long, as X < Z the results will not be off by more than 1.
> > > +      */
> > > +     if (val1 < (1 << HIST_DIV_SHIFT)) {
> > > +             u64 mult = operand2->div_multiplier;
> > > +
> > > +             return (val1 * mult + ((1 << HIST_DIV_SHIFT) - 1)) >> HIST_DIV_SHIFT;
> > > +     } else {
> > > +             u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
> > > +
> > > +             return div64_u64(val1, val2);
> > > +     }
> > > +}
> > > +
> > >  static u64 hist_field_mult(struct hist_field *hist_field,
> > >                          struct tracing_map_elt *elt,
> > >                          struct trace_buffer *buffer,
> > > @@ -573,6 +643,37 @@ struct snapshot_context {
> > >       void                    *key;
> > >  };
> > >
> > > +
> > > +static struct hist_field *find_var_field(struct hist_trigger_data *hist_data,
> > > +                                      const char *var_name);
> > > +
> > > +/*
> > > + * Returns the specific division function to use if the divisor
> > > + * is constant. This avoids extra branches when the trigger is hit.
> > > + */
> > > +static hist_field_fn_t hist_field_get_div_fn(struct hist_field *divisor)
> > > +{
> > > +     u64 div;
> > > +
> > > +     if (divisor->flags & HIST_FIELD_FL_VAR_REF) {
> > > +             struct hist_field *var;
> > > +
> > > +             var = find_var_field(divisor->var.hist_data, divisor->name);
> > > +             div = var->constant;
> > > +     } else
> > > +             div = divisor->constant;
> > > +
> > > +     if (!(div & (div - 1)))
> > > +             return div_by_power_of_two;
> > > +
> > > +     /* If the divisor is too large, do a regular division */
> > > +     if (div > (1 << HIST_DIV_SHIFT))
> > > +             return div_by_not_power_of_two;
> > > +
> > > +     divisor->div_multiplier = div64_u64((u64)(1 << HIST_DIV_SHIFT), div);
> > > +     return div_by_mult_and_shift;
> > > +}
> > > +
> > >  static void track_data_free(struct track_data *track_data)
> > >  {
> > >       struct hist_elt_data *elt_data;
> > > @@ -2575,6 +2676,20 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> > >       expr->operands[0] = operand1;
> > >       expr->operands[1] = operand2;
> > >
> > > +
> > > +     if (field_op == FIELD_OP_DIV &&
> > > +                     operand2_flags & HIST_FIELD_FL_CONST) {
> > > +             u64 divisor = (var2) ? var2->constant : operand2->constant;
> > > +
> > > +             if (!divisor) {
> > > +                     hist_err(file->tr, HIST_ERR_DIVISION_BY_ZERO, errpos(str));
> > > +                     ret = -EDOM;
> > > +                     goto free;
> > > +             }
> > > +
> > > +             op_fn = hist_field_get_div_fn(operand2);
> > > +     }
> > > +
> > >       if (combine_consts) {
> > >               if (var1)
> > >                       expr->operands[0] = var1;
> >
