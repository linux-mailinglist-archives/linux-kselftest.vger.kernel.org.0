Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BE96BA265
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 23:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCNWVk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 18:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCNWVh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 18:21:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0064D2B1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 15:20:58 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id r1so4653698ybu.5
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 15:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678832454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prmEhq3NQgLd3x/54m3N/hnamRPai5NrclABlw05kvc=;
        b=W+qNZdRIotMleNE57r9jiKwraAWhd5MwTIvahen0WEkE5PzTRfmpRXWqkUhrPuXIJq
         iOnlW0h/sR5EQYT1noYI5h5qxP67NxcyQAYUBvPIaBiOTQ6INBGE5VpUu4nLVv1ZgT02
         UaGlJgByAVV73JGmEHYNz/tvTczs8bNZngZHMdpmlwhzd0aMyKtTskgYYO5Z069HIK2B
         cVaMa5F5P19meeZJc60/mXF3AP4vN/fYubS4IlRxhs0oMqcLwh8BqCqcUp6kNhSOb7DB
         40YDvH/qdQ3IsnL5+jzoJFLVvdy1p1rDNpZ2WNL95MejPc/m90zkXXi/+fyynxXl5xwJ
         oY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678832454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prmEhq3NQgLd3x/54m3N/hnamRPai5NrclABlw05kvc=;
        b=cl8zZ+lV7Q52MAAPEwq3zwEJHMqN5V7IKFrU5MZ9cvxEtWTJKA/B8wgwi/2HHrfdVV
         lmgMc7AWg6HBhI0naUHF2DNKGIW318iYoPCMh41I77PctvxAkABAUj/gTLGcDKoy5u+e
         N1YHWP9NM39rNy/Rl5WKSbdiAJ1l3AmOJGyotZFEjleVo2Gx2YT/3JtQxLE8cVCu5spG
         WNcnRodGmI/2SBCc0VyW1S7Rs/DYBeCdYTgLr+6YGc4Qsi4ZRUCeixqDOFvEB+fJVilt
         hZLPLt5HA/o1GSQ+okpI25f2Gn0Iy6x8dkeFMjNHGv0e1qBSk4QHZI7Nwvg45dYpPfZL
         lB+A==
X-Gm-Message-State: AO0yUKXRugxB0E5M3jyxkqeFHgOCpZDCz7lzRDtbK/04yPKungto0Gk5
        1+7BjECkJZKTgP639pbvpR/N6JWMzUrq6h/VxUmg0A==
X-Google-Smtp-Source: AK7set8SkYGNcFnfYPsMfzR9x36zzygYapNbW6uZiul45TDLPJiNPfU+4GRchnUtuOZ+roEgbEeaRI7iP32Bln9WT6o=
X-Received: by 2002:a5b:38a:0:b0:ac9:cb97:bd0e with SMTP id
 k10-20020a5b038a000000b00ac9cb97bd0emr19406415ybp.5.1678832453903; Tue, 14
 Mar 2023 15:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230310222002.3633162-1-rmoar@google.com> <490271eb-1429-2217-6e38-837c6e5e328b@gmail.com>
In-Reply-To: <490271eb-1429-2217-6e38-837c6e5e328b@gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 14 Mar 2023 18:20:42 -0400
Message-ID: <CA+GJov4hw7yDRo2_uYWWe0chmBEtUh+t8aYhxSDXp2zch9cYvg@mail.gmail.com>
Subject: Re: [KTAP V2 PATCH] ktap_v2: add skip test result
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     davidgow@google.com, skhan@linuxfoundation.org,
        keescook@chromium.org, Tim.Bird@sony.com,
        brendanhiggins@google.com, corbet@lwn.net,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 11, 2023 at 10:52=E2=80=AFPM Frank Rowand <frowand.list@gmail.c=
om> wrote:
>
> On 3/10/23 16:20, Rae Moar wrote:
> > Add the test result "skip" to KTAP version 2 as an alternative way to
> > indicate a test was skipped.
> >
> > The current spec uses the "#SKIP" directive to indicate that a test was
> > skipped. However, the "#SKIP" directive is not always evident when quic=
kly
> > skimming through KTAP results.
> >
> > The "skip" result would provide an alternative that could make it clear=
er
> > that a test has not successfully passed because it was skipped.
> >
> > Before:
> >
> >  KTAP version 1
> >  1..1
> >    KTAP version 1
> >    1..2
> >    ok 1 case_1
> >    ok 2 case_2 #SKIP
> >  ok 1 suite
> >
> > After:
> >
> >  KTAP version 2
> >  1..1
> >    KTAP version 2
> >    1..2
> >    ok 1 case_1
> >    skip 2 case_2
> >  ok 1 suite
> >
> > Here is a link to a version of the KUnit parser that is able to parse
> > the skip test result for KTAP version 2. Note this parser is still able
> > to parse the "#SKIP" directive.
> >
> > Link: https://kunit-review.googlesource.com/c/linux/+/5689
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > --->
> > Note: this patch is based on Frank's ktap_spec_version_2 branch.
> >
> >  Documentation/dev-tools/ktap.rst | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools=
/ktap.rst
> > index ff77f4aaa6ef..f48aa00db8f0 100644
> > --- a/Documentation/dev-tools/ktap.rst
> > +++ b/Documentation/dev-tools/ktap.rst
> > @@ -74,7 +74,8 @@ They are required and must have the format:
> >       <result> <number> [<description>][ # [<directive>] [<diagnostic d=
ata>]]
> >
> >  The result can be either "ok", which indicates the test case passed,
> > -or "not ok", which indicates that the test case failed.
> > +"not ok", which indicates that the test case failed, or "skip", which =
indicates
> > +the test case did not run.
> >
> >  <number> represents the number of the test being performed. The first =
test must
> >  have the number 1 and the number then must increase by 1 for each addi=
tional
> > @@ -91,12 +92,13 @@ A directive is a keyword that indicates a different=
 outcome for a test other
> >  than passed and failed. The directive is optional, and consists of a s=
ingle
> >  keyword preceding the diagnostic data. In the event that a parser enco=
unters
> >  a directive it doesn't support, it should fall back to the "ok" / "not=
 ok"
> > -result.
> > +/ "skip" result.
> >
> >  Currently accepted directives are:
> >
> > -- "SKIP", which indicates a test was skipped (note the result of the t=
est case
> > -  result line can be either "ok" or "not ok" if the SKIP directive is =
used)
>
> > +- "SKIP", which indicates a test was skipped (note this is an alternat=
ive to
> > +  the "skip" result type and if the SKIP directive is used, the
> > +  result can be any type - "ok", "not ok", or "skip")
>
> For the "SKIP" directive, result type of either "ok", or "not ok" reflect=
s the
> current real world usage, which is mixed.  I agree is makes sense to also
> allow the result type of "skip" with the "SKIP directive.
>
> I think it would be good to deprecate the "SKIP" directive, with a schedu=
led
> removal in the V3 specification - that would allow plenty of time for tes=
t
> parsers to process both V1 and V2 data, before removing processing of V1 =
data.
>
> If so, the deprecation plan should be documented.
>

Hi Frank!

This is a great point. I think it is necessary to add specifications
on how the SKIP directive will be deprecated. I will be taking all of
these suggestions when I make a v2.

Also, just letting you know I am planning on sending out two more KTAP
v2 proposals in the next few days.

Thanks for your insight.
-Rae

> >  - "TODO", which indicates that a test is not expected to pass at the m=
oment,
> >    e.g. because the feature it is testing is known to be broken. While =
this>    directive is inherited from TAP, its use in the kernel is discoura=
ged.
> > @@ -110,7 +112,7 @@ Currently accepted directives are:
> >
> >  The diagnostic data is a plain-text field which contains any additiona=
l details
> >  about why this result was produced. This is typically an error message=
 for ERROR
> > -or failed tests, or a description of missing dependencies for a SKIP r=
esult.
> > +or failed tests, or a description of missing dependencies for a skippe=
d test.
> >
> >  The diagnostic data field is optional, and results which have neither =
a
> >  directive nor any diagnostic data do not need to include the "#" field
> > @@ -130,11 +132,18 @@ The test "test_case_name" failed.
> >
> >  ::
> >
> > -     ok 1 test # SKIP necessary dependency unavailable
> > +     skip 1 test # necessary dependency unavailable
>
> Maybe add a note that the "skip" result method is preferred over the belo=
w
> "ok ... # SKIP..." example below.
>

Will add this to v2.

> >
> > -The test "test" was SKIPPED with the diagnostic message "necessary dep=
endency
> > +The test "test" was skipped with the diagnostic message "necessary dep=
endency
> >  unavailable".
> >
> > +::
> > +
> > +     ok 1 test_2 # SKIP this test should not run
> > +
> > +The test "test_2" was skipped with the diagnostic message "this test
> > +should not run".
>
> Maybe add a deprecation note here.
>

WIll add this to v2.

> > +
> >  ::
> >
> >       not ok 1 test # TIMEOUT 30 seconds
> > @@ -225,7 +234,7 @@ An example format with multiple levels of nested te=
sting:
> >           not ok 1 test_1
> >           ok 2 test_2
> >         not ok 1 test_3
> > -       ok 2 test_4 # SKIP
> > +       skip 2 test_4
> >       not ok 1 example_test_1
> >       ok 2 example_test_2
> >
> > @@ -262,7 +271,7 @@ Example KTAP output
> >         ok 1 example_test_1
> >           KTAP version 2
> >           1..2
> > -         ok 1 test_1 # SKIP test_1 skipped
> > +         skip 1 test_1 # test_1 skipped
> >           ok 2 test_2
> >         ok 2 example_test_2
> >           KTAP version 2
> >
> > base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
>
