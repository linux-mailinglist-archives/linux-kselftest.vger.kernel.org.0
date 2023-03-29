Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC76A6CF516
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 23:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjC2VPJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 17:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjC2VPI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 17:15:08 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103502D4D
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 14:15:06 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-545e907790fso201934157b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680124505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXC4MTheNGQBhmhUBKx9j9CdlTfCf6zg5go5xfHK3Cc=;
        b=VTqpyDYoJUREYflZRqr1BUX891DRC0dl4/GIMu4nq9OOd3x2poQV+Xd83sBW9jJAtm
         ki3cvbM8TERKoUCa7JR2bbMNclQsfCnq4nYLkCOrHQz9M2WnjVlP7y44dxA2wHvEqCuA
         57EITOquGxYHc2U63RHnj0UX7QlS9cyPzD8O3xD1ZvAX77871lfXkRB0v/I6pMQjOAqn
         htIXSR0YZoC2xEO4/X15dXE+jIZDD005f3EJU1dlplANozf91k3zrLVofsor2gUg0xdc
         tZ9woUimhwR0QxzXoNKOQ7yZx450MWhrSt06D1FDPEOz6UNW96Sgc23zfin3Ittcgxif
         2ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680124505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXC4MTheNGQBhmhUBKx9j9CdlTfCf6zg5go5xfHK3Cc=;
        b=MLkc+69h6Mm5/q3fITYkVD0vx3eflSGloocTlwBgd4HD51KNY6A7aUyUwK5qpxMPTw
         +UPGtfRtvySysvpiFJNm5+4x2buSJiVd/tF88HHSE6WU0qT9lFQaDMRThFUeafH+61AZ
         6R5lC2Lc6FHH4vf1Nu7Lh28fRd2qb/SuxnYIK4cnwpRbBzK6Ybuwr7Ixzdhu52X9d4Ut
         aolSxZoUMUVoIP54cYS7X6rVSUDLj7ifumFU03S7lx3RenkMo72QSbutMIp6XU3MW2LU
         XXuwsFZ4AAZU63laXKATxR7+zgpIcKk76LWUSDlqib9TYresel7jlomEdvtpjQPon4zU
         Lbgg==
X-Gm-Message-State: AAQBX9cHr8A5E+buf2h4edsEuzE25/F9rgiT+Gwxl/H2JtaKW9GzYp93
        UAE4M0WoH2060gAU6HfOP4IVme8nwpaDZe9YUUsn3w==
X-Google-Smtp-Source: AKy350aQyn/TP180u2kbRTp3AVC/E8uKO6CULBFPZAkt19UdsNguHggT0HyxUvByt4xMjbPz4Khhad9HHKJLsXjSi8A=
X-Received: by 2002:a81:ae4f:0:b0:545:ed8e:f4f6 with SMTP id
 g15-20020a81ae4f000000b00545ed8ef4f6mr6177531ywk.5.1680124504649; Wed, 29 Mar
 2023 14:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230316225926.494921-1-rmoar@google.com> <5626cd99-f44a-97db-334e-99f1d62112a1@gmail.com>
In-Reply-To: <5626cd99-f44a-97db-334e-99f1d62112a1@gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 29 Mar 2023 17:14:52 -0400
Message-ID: <CA+GJov5B7Y8fqm7QtDuvx88m7QPEPF6bYqMqbEGf0cp=E=zGCg@mail.gmail.com>
Subject: Re: [KTAP V2 PATCH] ktap_v2: allow prefix to KTAP lines
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     davidgow@google.com, skhan@linuxfoundation.org,
        keescook@chromium.org, Tim.Bird@sony.com,
        brendanhiggins@google.com, corbet@lwn.net,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@lists.linux.dev, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 26, 2023 at 10:12=E2=80=AFPM Frank Rowand <frowand.list@gmail.c=
om> wrote:
>
> On 3/16/23 17:59, Rae Moar wrote:
> > Change the KTAP v2 spec to allow variable prefixes to KTAP lines,
> > instead of fixed indentation of two spaces. However, the prefix must be
> > constant on the same level of testing (besides unknown lines).
> >
> > This was proposed by Tim Bird in 2021 and then supported by Frank Rowan=
d
> > in 2022 (see link below).
> >
> > Link: https://lore.kernel.org/all/bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@=
gmail.com/
>
> Another link to the same thread, but expanded to show all replies in one =
page is:
>
>   https://lore.kernel.org/all/bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.=
com/T/#u
>
> Near the top of that thread I proposed alternative 1 (essentially what Ti=
m
> originally suggested, and what Rae proposes here) and alternative 2 (with
> slight variant 2b).  The overall preference seemed to be alternative 1, b=
ut
> if we wanted to provide a method to provide test or system metadata then
> alternative 2 might provide both a test prefix and metadata.
>
> Alternate 1 provides the vast majority of what I need the prefix for, but
> I think there has been a recent comment that it would be useful to be abl=
e
> to report system metadata (sorry, I haven't found a reference for that ye=
t).
> In my case, it would be informative to use metadata to report which confi=
g
> options that impact the DT unittests are enabled.
>

Hi Frank,

Thanks for all of your ideas!

Thinking more on this topic, I do think we will want a specified way
to report test metadata in KTAP. This can be partly covered with this
idea for a prefix. However, it might not provide the flexibility or
comprehensiveness we need. For example, reporting the file for input
or output might be too verbose for a prefix.

I thought your idea on config info lines was compelling. However, I am
not sure using a result line to communicate the metadata is the best
solution. This would alter the function of a result line. And for
parsers that count "ok" and "not ok", this might create problems.

I have an idea that derives from my other KTAP proposal to declare a
test name with "# Subtest:". The idea is to declare the metadata as
diagnostic lines in between the version line and the test plan in
order to separate this information from subtest diagnostic output. We
could do something similar to below:

KTAP version 2
1..1
  KTAP version 2
  # Name: test_1          // Or as proposed: "# Subtest: test_1"
  # File: /sys/kernel/...
  # Config: CONFIG_1=3Dy CONFIG_PARAM=3D2048
  1..1
  # subtest_1 passed
  ok 1 subtest_1
# test_1 passed
ok 1 test_1

This is just an idea. I would love to hear other ideas on the best way
to report metadata. Alternatively, we could create a new line format
all together specific to report test metadata.

> >
> > As cited in the original proposal, it is useful in some Fuego tests to
> > include an identifier in the prefix. This is an example:
> >
> >  KTAP version 1
> >  1..2
> >  [batch_id 4] KTAP version 1
> >  [batch_id 4] 1..2
> >  [batch_id 4] ok 1 cyclictest with 1000 cycles
> >  [batch_id 4] # problem setting CLOCK_REALTIME
> >  [batch_id 4] not ok 2 cyclictest with CLOCK_REALTIME
> >  not ok 1 check realtime
> >  [batch_id 4] KTAP version 1
> >  [batch_id 4] 1..1
> >  [batch_id 4] ok 1 IOZone read/write 4k blocks
> >  ok 2 check I/O performance
> >
> > Here is a link to a version of the KUnit parser that is able to parse
> > variable length prefixes for KTAP version 2. Note that the prefix must
> > be constant at the same level of testing.
> >
> > Link: https://kunit-review.googlesource.com/c/linux/+/5710
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >
> > This idea has already been proposed but I wanted to potentially
> > restart the discussion by demonstrating this change can by
> > implemented in the KUnit parser. Let me know what you think.
> >
> > Note: this patch is based on Frank's ktap_spec_version_2 branch.
> >
> >  Documentation/dev-tools/ktap.rst | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools=
/ktap.rst
> > index ff77f4aaa6ef..ac61fdd97096 100644
> > --- a/Documentation/dev-tools/ktap.rst
> > +++ b/Documentation/dev-tools/ktap.rst
>
> Some additional lines of the Spec to be updated (from my alternate 1 emai=
l,
> I haven't checked the current Spec to see if these are the exact changes
> needed, but at least capture the intent:
>
> The "Version lines" format is changed from:
>
>    KTAP version 1
>
> to:
>
>    [<prefix string>] KTAP version 1
>
> The "Plan lines" format is changed from:
>
>    "1..N"
>
> to:
>
>    [<prefix string>] "1..N"
>
> The "Test case result lines" format is changed from:
>
>    <result> <number> [<description>][ # [<directive>] [<diagnostic data>]=
]
>
> to:
>
>    [<prefix string>] <result> <number> [<description>][ # [<directive>] [=
<diagnostic data>]]
>

These are all great additions to the spec. Will add in version 2. I
suppose we should add this detail to the diagnostic lines syntax as
well.

>
>    <prefix content is a constant string>
>
>
> I wrote (with a bit of imprecision):
>
>   Indentation for "Nested tests" follows <prefix string>.  The indentatio=
n
>   does NOT precede <prefix string>.
>
> which was meant to imply that the two space indentation would follow the
> <prefix string>.
>
> The patch I am replying to instead replaces the two space indentation
> entirely with the <prefix string>.  I think this patches' version of
> indentation is superior to what I suggested.
>
> > @@ -192,9 +192,11 @@ starting with another KTAP version line and test p=
lan, and end with the overall
> >  result. If one of the subtests fail, for example, the parent test shou=
ld also
> >  fail.
> >
> > -Additionally, all lines in a subtest should be indented. One level of
> > -indentation is two spaces: "  ". The indentation should begin at the v=
ersion
> > -line and should end before the parent test's result line.
> > +Additionally, all lines in a subtest should be indented. The standard =
for one
> > +level of indentation is two spaces: "  ". However, any prefix for inde=
ntation
> > +is allowed as long as the prefix is consistent throughout that level o=
f
> > +testing. The indentation should begin at the version line and should e=
nd
> > +before the parent test's result line.
> >
> >  "Unknown lines" are not considered to be lines in a subtest and thus a=
re
> >  allowed to be either indented or not indented.
>
> I was a little more verbose about "Unknown lines":
>
>    "Unknown lines" may optionally be prefixed with the <prefix string>, b=
ut
>    are not required to be prefixed with the <prefix string>.  It is allow=
ed
>    for some "Unknown lines" to not be prefixed with the <prefix string>, =
even
>    if one or more other "Unknown lines" are prefixed with the <prefix str=
ing>.
>
> I think combining the intent ("not considered to be lines in a subtest") =
with
> the extra verbosity would be useful.
>

I agree this seems like a useful addition. Will add for version 2.

> > @@ -229,6 +231,19 @@ An example format with multiple levels of nested t=
esting:
> >       not ok 1 example_test_1
> >       ok 2 example_test_2
> >
> > +An example of a test with two nested subtests using prefixes:
> > +
> > +::
> > +
> > +     KTAP version 2
> > +     1..1
> > +     [prefix_1] KTAP version 2
> > +     [prefix_1] 1..2
> > +     [prefix_1] ok 1 test_1
> > +     [prefix_1] ok 2 test_2
> > +     # example passed
> > +     ok 1 example
> > +
>
> The "[" and "]" are meant to indicate an optional field, so the
> example would be:
>
> +       KTAP version 2
> +       1..1
> +       prefix_1 KTAP version 2
> +       prefix_1 1..2
> +       prefix_1 ok 1 test_1
> +       prefix_1 ok 2 test_2
> +       # example passed
> +       ok 1 example
> +
>

Thanks, this is better to exclude the square brackets. Will change
this for version 2.

> Of course, "[" and "]" are valid characters within the prefix string, so
> that an example of "[prefix_1]" could be mentioned as a valid example.
>
> I would suggest some additional more complex examples:
>
> +       prefix_0 KTAP version 2
> +       prefix_0 1..1
> +       prefix_0 prefix_1 KTAP version 2
> +       prefix_0 prefix_1 1..2
> +       prefix_0 prefix_1 ok 1 test_1
> +       prefix_0 prefix_1 ok 2 test_2
> +       # example passed
> +       prefix_0 ok 1 example
> +

Shouldn't the "# example passed" line include the prefix_0?

>
> +       KTAP version 2
> +       1..2
> +       prefix_1 KTAP version 2
> +       prefix_1 1..2
> +       prefix_1 ok 1 test_a_1
> +       prefix_1 ok 2 test_a_2
> +       # example passed
> +       ok 1 example
> +       prefix_2 KTAP version 2
> +       prefix_2 1..2
> +       prefix_2 ok 1 test_b_1
> +       prefix_2 ok 2 test_b_2
> +       # example passed
> +       ok 2 example
> +
>
> +       KTAP version 2
> +       1..3
> +       prefix_1 KTAP version 2
> +       prefix_1 1..2
> +       prefix_1 ok 1 test_a_1
> +       prefix_1 ok 2 test_a_2
> +       # example passed
> +       ok 1 example
> +         KTAP version 2
> +         1..2
> +         ok 1 test_b_1
> +         ok 2 test_b_2
> +       # example passed
> +       ok 2 example
> +       prefix_2 KTAP version 2
> +       prefix_2 1..2
> +       prefix_2 ok 1 test_c_1
> +       prefix_2 ok 2 test_c_2
> +       # example passed
> +       ok 3 example
> +
>
>

Otherwise, these all look very helpful. I will definitely be adding
these more complex examples in version 2.

Thanks!

Rae

>
> >
> >  Major differences between TAP and KTAP
> >  --------------------------------------
> >
> > base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
>
