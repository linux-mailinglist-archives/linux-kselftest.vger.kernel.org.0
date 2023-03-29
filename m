Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079B16CF22D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 20:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjC2SfE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjC2SfD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 14:35:03 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A72108
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 11:35:01 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id i6so20588372ybu.8
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680114901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoayQot9L/nb+F2GoEpkM/VcmhepGMqPcvXnqxbtncM=;
        b=a69vJ2oq4PwoxM9o2LP+M7Jp7bme3nYOwqjVWq91UXNrsdXXmwnticS6w+W049jGeu
         7ECoWiVHKD9STJG948OdsXLaOBa339f4u4J4WoQnmZQdr5q7GnpDV2SL6o6pa/RiTYpF
         5K8ZVbJra9Xc5fTqYY3Qc2Dxv72LuZZxMVvpD6yRlLjfQ2ssI6co232RDrdgPwqGQGww
         zm9/pU5YWYbmHdLJ47rAOOBwx4CzQXWb1glKTqVX4BMKto+fhG8zCSTOjM2aa/cuUAAQ
         VjNVUMyty0JUbKdDTUYYpbBVMECT7QDfbWCIGnLtrv21wrDiEgSn0Wl3kNB3YuO7qpAC
         f0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680114901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoayQot9L/nb+F2GoEpkM/VcmhepGMqPcvXnqxbtncM=;
        b=Zrp9ItjgmVB3uW0yWEfYNkcfEI+Z17GL5Yb2rYNT8jNn8wuBAU6A66QuorM4mdZk5q
         iudvo1uWyKbN1DjP6zYvUpSRBemHxDg1kyfaY4e/VA98x7yGs3HqWW7S3SngMoAU5BiA
         oo6lGujO8GbzR6A5yV1Xe7tQhW/wp5VLHh904dtbgAj9BH6uFk0JC7r3J2ujnl2uOCFA
         Q2vlPFtfuzqDqdTjRiILHN7GSpWAJ8rV1o9eBViHlAB5BeMoAPx4widY8ma84OShLKyv
         xmMgpTP58salEr85NMh+1dJZfEvjlDMFPCy0k1Vp+1m94hRlEZ31TDvy4rt4c0xLeg8p
         r4cg==
X-Gm-Message-State: AAQBX9ew0gGA5qNlTW4BcemKN+LTxv6nxJXk0QPISv2s11zT2iuigDty
        DB1OwAt8F4Z7X6A9SRuyYwthmfra0YyJt1d+lhLOSeIbL01Mrjh7kudZAA==
X-Google-Smtp-Source: AKy350Zy1QdkwfuWRxGY14CV4FlN9qRedx03HNf8V7Q4WvfJXD0ezn0NC9pWJq9y9KElQBWPdVb4Wm8bbC0/iM5XAFY=
X-Received: by 2002:a05:6902:1247:b0:b78:4b00:7772 with SMTP id
 t7-20020a056902124700b00b784b007772mr12183690ybu.5.1680114900775; Wed, 29 Mar
 2023 11:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230316225915.494688-1-rmoar@google.com> <197889b6-5773-094c-8699-26843c6519fd@gmail.com>
In-Reply-To: <197889b6-5773-094c-8699-26843c6519fd@gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 29 Mar 2023 14:34:49 -0400
Message-ID: <CA+GJov7cYs4gjpTgKiRz=NmPR37jwsFjLoCFBnDq4yqk3jwjGg@mail.gmail.com>
Subject: Re: [KTAP V2 PATCH] ktap_v2: add recognized test name line
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

On Sun, Mar 26, 2023 at 10:41=E2=80=AFPM Frank Rowand <frowand.list@gmail.c=
om> wrote:
>
> On 3/16/23 17:59, Rae Moar wrote:
> > Add recognition of the test name line ("# Subtest: <name>") to the KTAP=
 v2
> > spec.
> >
> > The purpose of this line is to declare the name of a test before its
> > results. This functionality is especially useful when trying to parse t=
est
> > results incrementally and when interpretting results after a crash.
> >
> > This line is already compliant with KTAP v1 as it is interpretted as a
> > diagnostic line by parsers. Additionally, the line is currently used by
> > KUnit tests and was derived from the TAP 14 spec:
> > https://testanything.org/tap-version-14-specification.html.
>
> It is convenient that "# Subtest: <name>" is compatible with v1, but I th=
ink
> that there is a negative that overrides the convenience.
>
> The "# Subtest: <name>" syntax means that we need to restrict the format =
of
> diagnostic lines, such that "#Subtest:" is an illegal diagnostic, at leas=
t
> for the line immediately following the Version line.
>

Hi Frank,

Yes, I see what you are saying here. It would be inconvenient for
parsers to make an exception to the method of parsing diagnostic
lines.

> I think it would be cleaner to modify the Version line syntax to be:
>
>   KTAP version 2 [# <subtest_name>]
>

I like that this idea wouldn't introduce a new line, which is
invaluable. However, I would suspect this alternative may break more
parsers than the first proposal, as current parsers may search for the
full version line to find KTAP results (I know at least KUnit does
this). Therefore I slightly prefer the original proposal. Curious what
others prefer?

Overall, I advocate that KTAP should allow a way to define the name of
the test prior to the results based on the reasons discussed above and
by Daniel and Frank. So if this is the preferred method I would
understand.

> I notice that the KTAP Specification version 1 fails to specify the
> Version line syntax.  So the Specification would be updated from:
>
>   All KTAP-formatted results begin with a "version line" which specifies =
which
>   version of the (K)TAP standard the result is compliant with.
>
>   For example:
>   - "KTAP version 1"
>   - "TAP version 13"
>   - "TAP version 14"
>
> to:
>
>   The Version line is required and must have the format:
>
>   .. code-block:: none
>
>         KTAP version 2 [# <subtest_name>]
>

I like this added specificity. Would be happy to see specific version
line syntax added to the spec.

Thanks!

Rae

>   All KTAP-formatted results begin with a "version line" which specifies =
which
>   version of the (K)TAP standard the result is compliant with.
>
>   For example:
>   - "KTAP version 2"
>   - "TAP version 13"
>   - "TAP version 14"
>
> >
> > Recognition of this line would create an accepted way for different tes=
t
> > frameworks to declare the name of a test before its results.
> >
> > The proposed location for this line is between the version line and the
> > test plan line. This location ensures that the line would not be
> > accidentally parsed as a subtest's diagnostic lines. Note this proposed
> > location would be a slight differentiation from KTAP v1.
> >
> > Example of test name line:
> >
> >  KTAP version 2
> >  # Subtest: main_test
> >  1..1
> >    KTAP version 2
> >    # Subtest: sub_test
> >    1..2
> >    ok 1 test_1
> >    ok 2 test_2
> >  ok 1 sub_test
> >
> > Here is a link to a version of the KUnit parser that is able to parse t=
he
> > test name line for KTAP version 2. Note this includes a test name line =
for
> > the main level of KTAP.
> >
> > Link: https://kunit-review.googlesource.com/c/linux/+/5709
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >
> > This is a RFC. I would like to know what people think and use this as a
> > platform for discussion on KTAP v2.
> >
> > Note: this patch is based on Frank's ktap_spec_version_2 branch.
> >
> >  Documentation/dev-tools/ktap.rst | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools=
/ktap.rst
> > index ff77f4aaa6ef..9c7ed66d9f77 100644
> > --- a/Documentation/dev-tools/ktap.rst
> > +++ b/Documentation/dev-tools/ktap.rst
> > @@ -28,8 +28,7 @@ KTAP output is built from four different types of lin=
es:
> >  In general, valid KTAP output should also form valid TAP output, but s=
ome
> >  information, in particular nested test results, may be lost. Also note=
 that
> >  there is a stagnant draft specification for TAP14, KTAP diverges from =
this in
> > -a couple of places (notably the "Subtest" header), which are described=
 where
> > -relevant later in this document.
> > +a couple of places, which are described where relevant later in this d=
ocument.
> >
> >  Version lines
> >  -------------
> > @@ -44,8 +43,8 @@ For example:
> >  - "TAP version 14"
> >
> >  Note that, in KTAP, subtests also begin with a version line, which den=
otes the
>
> > -start of the nested test results. This differs from TAP14, which uses =
a
> > -separate "Subtest" line.
>
> ^^^^ This is an error in the KTAP Specification version 1.  TAP14 allows =
the case
> of "Bare Subtests", which would be the equivalent of the KTAP v1 method.
>
> > +start of the nested test results. This differs from TAP14, which uses =
only a
> > +"Subtest" line.
> >
> >  While, going forward, "KTAP version 2" should be used by compliant tes=
ts, it
> >  is expected that most parsers and other tooling will accept the other =
versions
> > @@ -166,6 +165,12 @@ even if they do not start with a "#": this is to c=
apture any other useful
> >  kernel output which may help debug the test. It is nevertheless recomm=
ended
> >  that tests always prefix any diagnostic output they have with a "#" ch=
aracter.
> >
> > +One recognized diagnostic line is the "# Subtest: <name>" line. This l=
ine
> > +is used to declare the name of a test before subtest results are print=
ed. This
> > +is helpful for parsing and for providing context during crashes. As a =
rule,
> > +this line is placed after the version line and before the plan line. N=
ote
> > +this line can be used for the main test, as well as subtests.
> > +
> >  Unknown lines
> >  -------------
> >
> > @@ -206,6 +211,7 @@ An example of a test with two nested subtests:
> >       KTAP version 2
> >       1..1
> >         KTAP version 2
> > +       # Subtest: example
> >         1..2
> >         ok 1 test_1
> >         not ok 2 test_2
> > @@ -219,6 +225,7 @@ An example format with multiple levels of nested te=
sting:
> >       KTAP version 2
> >       1..2
> >         KTAP version 2
> > +       # Subtest: example_test_1
> >         1..2
> >           KTAP version 2
> >           1..2
> > @@ -245,7 +252,7 @@ allows an arbitrary number of tests to be nested   =
  no         yes
> >
> >  The TAP14 specification does permit nested tests, but instead of using=
 another
> >  nested version line, uses a line of the form
> > -"Subtest: <name>" where <name> is the name of the parent test.
> > +"Subtest: <name>" where <name> is the name of the parent test as discu=
ssed above.
> >
> >  Example KTAP output
> >  --------------------
> > @@ -254,6 +261,7 @@ Example KTAP output
> >       KTAP version 2
> >       1..1
> >         KTAP version 2
> > +       # Subtest: main_test
> >         1..3
> >           KTAP version 2
> >           1..1
> > @@ -266,6 +274,7 @@ Example KTAP output
> >           ok 2 test_2
> >         ok 2 example_test_2
> >           KTAP version 2
> > +             # Subtest: example_test_3
> >           1..3
> >           ok 1 test_1
> >           # test_2: FAIL
> >
> > base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/197889b6-5773-094c-8699-26843c6519fd%40gmail.com.
