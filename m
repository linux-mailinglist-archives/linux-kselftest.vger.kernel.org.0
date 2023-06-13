Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D9D72ED15
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 22:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjFMUfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFMUfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 16:35:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE43DC
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:35:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso3557a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686688509; x=1689280509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lw9w+Kt9/2EySc4cY9S0OTAvlIbfF/Wk8MfupO7YiHY=;
        b=zNvffmkCh9eDAmwr3srT9kEx4Hse8WAvmLAEPD2N4cICBRTsUPHS6WMOAv+jwvp0ms
         5w0OqoQIHxl+Tr1nalxTE/HhNMRtLswYVmFBfTfmDA0BmlZG4aTtHUsJNHrXOrjAAo90
         8qht+hm8l7OqBh0R1d2TgO8JiZpSxmBq6Tpsx/V6BPxYZFz7BuDm1esleSonHHHhIq5g
         CwCnMb9lb5gCxuG9vNQLjK0EPXixn5KuFvF/r0fQLM7UOb2lst11NawGMxK+yepIOK4c
         uVNS9pcWtQGY5NtfpAb86jyoYZ/VMY5slYDlhTEbxMhMblaXlm8Kw5LQmggBN2SIpYQg
         GRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688509; x=1689280509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lw9w+Kt9/2EySc4cY9S0OTAvlIbfF/Wk8MfupO7YiHY=;
        b=hdtL6EDabBytlB9nLftP87tq2Xv9uT55wP/7Md75j8trMZ6XZhsICDBmoDa7p6DctX
         zuIcqETG5gloQtlSeid6+kAkFbrDhdHF9YbUg/7fJXXVOxjNVPwpGzriY36I71bYC9tU
         h2moa3r+eVu6JdpvBY3dT4zEjiJ/drJ4AG/jFwmFn040PTclnq158I9BrPClzLiold9l
         /9EtMbLWgfyqHd6T4xgn2G1JL59WekeeUpSl033oEcP46Z1u2sXG5HEmFufCKKLcfX7l
         rS6p21dJiGm+ZewVlJvqCPKcM8ZReZIo2t7UhzbHt27PtAG+d+jbNotexQ5clJPT23Lq
         L2Uw==
X-Gm-Message-State: AC+VfDzPykMoNRyAAljj2920p9FieEbWLCqzqfEF/G/DLB/Fi+Pm/jNc
        TXix/kSSjYyEKw1y5vBrNODxrFJ646ZEQQLjL2TEjeNFjdTo/aXNbIo=
X-Google-Smtp-Source: ACHHUZ7zCDorDc54ljQ7CIOycOvykI8G2Sz7kH0yEbqHi1QgUiUbwSEokqiFCXBWNBOf91/aaBCX0t9ohWMYAvQTiNM=
X-Received: by 2002:a50:8713:0:b0:505:863:d85f with SMTP id
 i19-20020a508713000000b005050863d85fmr24245edb.4.1686688508574; Tue, 13 Jun
 2023 13:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com> <CABVgOS=By=bpUELmNBMv39Swx+-Ec_XHo-=3yUfmcpOPU7N=8A@mail.gmail.com>
In-Reply-To: <CABVgOS=By=bpUELmNBMv39Swx+-Ec_XHo-=3yUfmcpOPU7N=8A@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 13 Jun 2023 16:34:57 -0400
Message-ID: <CA+GJov44aSWznbaUE_rdg1iTdEKfX_tHqHSpXzkNrs7dFP0A2A@mail.gmail.com>
Subject: Re: [RFC v1 0/6] kunit: Add test attributes API
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 10, 2023 at 4:29=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 10 Jun 2023 at 08:52, Rae Moar <rmoar@google.com> wrote:
> >
> > Hello everyone,
> >
> > This is an RFC patch series to propose the addition of a test attribute=
s
> > framework to KUnit.
> >
> > There has been interest in filtering out "slow" KUnit tests. Most notab=
ly,
> > a new config, CONFIG_MEMCPY_SLOW_KUNIT_TEST, has been added to exclude
> > particularly slow memcpy tests
> > (https://lore.kernel.org/all/20230118200653.give.574-kees@kernel.org/).
>
> Awesome: this is a long overdue feature.
>

Hi David!

Thank you for all the comments!

> > This proposed attributes framework would be used to save and access tes=
t
> > associated data, including whether a test is slow. These attributes wou=
ld
> > be reportable (via KTAP and command line output) and some will be
> > filterable.
>
> Why wouldn't they all be filterable? I guess I can imagine some where
> filtering wouldn't be useful, but I can't think of a technical reason
> why the filter shouldn't work.

I am definitely open to all attributes being filterable. My
reservation is that I can imagine an attribute with a complex data
type that would cause the filtering method to be difficult to
implement. If the attribute does not benefit much from being
filterable, I wonder if it is worth requiring the filtering method to
be implemented in that case.

Perhaps for now all attributes are filterable and then if this becomes
the case, this is addressed then?

>
> Also, as I understand it, I think this could also work with data which
> is not "saved" in this kunit_attributes struct you define. So we could
> have attributes which are generated automatically from other
> information about the test.
>  I could definitely see value in being able to filter on things like
> "is_parameterised" or "runs_at_init" or similar.
>

Yes! This is a great benefit of this flexible structure for
attributes. I would definitely be interested in implementing
"is_parameterised" and "runs_at_init" in future patches.

> Finally, it'd be really great if these attributes could apply to
> individual parameters in parameterised tests, in which case we could
> have and filter on the parameter value. That seems like it could be
> incredibly useful.
>

Yes, this would be an exciting extension for this project. I have
started thinking about this as potentially a follow up project.

> >
> > This framework is designed to allow for the addition of other attribute=
s in
> > the future. These attributes could include whether the test is flaky,
> > associated test files, etc.
>
> A small part of me is hesitant to add this much framework code for
> only one attribute, so it'd be nice to look into at least having an
> RFC for some of these. Hopefully we don't actually have flaky tests,
> but "is_deterministic" would be nice (alongside a future ability to
> inject a random seed, or similar). Other properties like
> "is_threadsafe", "is_reentrant", etc could be useful for future
> features. And I'm sure there could be some more subsystem-specific
> things which would be useful to filter on, too.
>

I understand the reservations to add this large framework for one
attribute. I would definitely consider adding an additional attribute
to this RFC or creating a separate RFC.

I would be happy to go ahead and add "is_deterministic" if there is
interest. As well as potentially "is_threadsafe", "is_reentrant", etc
in future patches.

> Some of these could probably replace the need for custom code to make
> the test skip itself if dependencies aren't met, too, which would be
> fun.

This would be great!

>
> I'm not sure "associated test files" quite gels perfectly with this
> system as-is (assuming I understand what that refers to). If it's the
> ability to "attach" extra data (logs, etc) to the KTAP output, that's
> possibly best injected at runtime, or added by the separate parser,
> rather than hardcoded in the kernel.
>

Hmm I see what you are saying here. If the associated test files of
interest are best injected at runtime I am happy to scrap this idea
for now.

> >
> > Note that this could intersect with the discussions on how to format
> > test-associated data in KTAP v2 that I am also involved in
> > (https://lore.kernel.org/all/20230420205734.1288498-1-rmoar@google.com/=
).
> >
> I definitely need to re-read and respond to that. I'm not 100%
> thrilled with the output format here, and I think the goal with KTAP
> "test associated data" is, as you say, related, but not identical to
> this. There'd definitely be data which doesn't make sense as a KUnit
> attribute which we might want to add to the output (e.g., data only
> calcuated while the test runs), and attributes which we might not want
> to always print out with the results.
>

I have thought much about the differences between the two concepts. My
current understanding with KTAP metadata and KUnit attributes is that
they are not going to be perfect mirrors of each other but the KUnit
attributes framework can help to save and output some of the KTAP
metadata.

I am happy to be flexible on the output format or see more discussion
on KTAP metadata in general. What part of the output is most
concerning?

> > If the overall idea seems good, I'll make sure to add tests/documentati=
on,
> > and more patches marking existing tests as slow to the patch series.
> >
>
> I think the series is good overall. If no-one else objects, let's move
> forward with it.
> I'd definitely prefer to see a few more tests and some documentation.
> Having another attribute would be great, too, though I can certainly
> live with that being a separate series.

Great! Yes I will add documentation and more tests in the next
versions. I will also work on the implementation of another attribute.


>
>
> > Thanks!
> > Rae
> >
> > Rae Moar (6):
> >   kunit: Add test attributes API structure
> >   kunit: Add speed attribute
> >   kunit: Add ability to filter attributes
> >   kunit: tool: Add command line interface to filter and report
> >     attributes
> >   kunit: memcpy: Mark tests as slow using test attributes
> >   kunit: time: Mark test as slow using test attributes
> >
> >  include/kunit/attributes.h             |  41 ++++
> >  include/kunit/test.h                   |  62 ++++++
> >  kernel/time/time_test.c                |   2 +-
> >  lib/kunit/Makefile                     |   3 +-
> >  lib/kunit/attributes.c                 | 280 +++++++++++++++++++++++++
> >  lib/kunit/executor.c                   |  89 ++++++--
> >  lib/kunit/executor_test.c              |   8 +-
> >  lib/kunit/kunit-example-test.c         |   9 +
> >  lib/kunit/test.c                       |  17 +-
> >  lib/memcpy_kunit.c                     |   8 +-
> >  tools/testing/kunit/kunit.py           |  34 ++-
> >  tools/testing/kunit/kunit_kernel.py    |   6 +-
> >  tools/testing/kunit/kunit_tool_test.py |  41 ++--
> >  13 files changed, 536 insertions(+), 64 deletions(-)
> >  create mode 100644 include/kunit/attributes.h
> >  create mode 100644 lib/kunit/attributes.c
> >
> >
> > base-commit: fefdb43943c1a0d87e1b43ae4d03e5f9a1d058f4
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
