Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C776BA1BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 23:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCNWEQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCNWEP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 18:04:15 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FE923C73
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 15:04:12 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i6so17279813ybu.8
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 15:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678831451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/zfGwQbbEb+qzil00/Ab0eaet+X5p/Mt1ykcP2N7RM=;
        b=fYljs8WgUXJBQKmxjkcKuXOyiTHePzPXZgCVZ8tN9Z5Q0c+nGrVNTrWmfdNXK3xjV9
         ggfR/vMUbO/riD3uEIrU5LPab2ewbyQrFk11d+hSLAtwyKGDUElTOOwrWGOVtLQFV6EW
         yiWmBlrI/brXxVEZi7J7H3Zhks9j3IvecomhFfjzNVIHkeg5I3FYiY9ZU+51Pry4b7lR
         1pWQyv2xY/kRIlM3q8/P18BmIK/XdWN3CbcWq+PEvpZk7uUDXlriiQbekWcAWMREzeB4
         c5Pxv0mSNRI6VJeNyAfpIWzb7l/2pOPNtZ/n+MKGMV5u0r2LpJBR6IxlP/Rj4eYr86gt
         h+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678831451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/zfGwQbbEb+qzil00/Ab0eaet+X5p/Mt1ykcP2N7RM=;
        b=deJGzgBSVP+GLYYnyeGkVRCLH6OFgpZXv4MRHhp84dkL1AIk2eIVT/jCINFeiI35br
         uNYGPILC5lV40RAzQa4hdbf21NyEU+3ygIq1oAC3Fbk3Uv5x1OxGEhC5tks0ntJYTF+z
         i7/LpqurwJRJsXezC73BIOuXpS0nVZoB0yR42rB/uzBVhzNrX9Y5uTxgu5ol68dxVeFB
         KuwkAx3NREJVtqm2afdrcTkdytKSWoV45XexWcYDkybwp0d6qXHzBwLV5zgwYkOu0m9/
         ICotTcbKCQ2fghIVS50QSstmUWBr+zUKRaPsblgX3i/4/4gzlc8zXmOeice6qhjfKk5V
         KYRg==
X-Gm-Message-State: AO0yUKW5ecjUZj6QyLA90b9yvK4bClg/rCh7XCmlgVFHmuQ4aWq9jdia
        eyaOE1Qvy5K1C5IiH/aLqrnE7a1vZYFJ+BesM8i0Gw==
X-Google-Smtp-Source: AK7set9rQ7rPhZlkXSA3LRVnEVHuJtVWqq4MoZuUqrCGlf5p8e2zSmw2HRhw5AcoExqE9fhI6qPtoWZ6olrg9oTBDzg=
X-Received: by 2002:a05:6902:251:b0:9f1:6c48:f95f with SMTP id
 k17-20020a056902025100b009f16c48f95fmr12126616ybs.5.1678831451300; Tue, 14
 Mar 2023 15:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230310222002.3633162-1-rmoar@google.com> <BYAPR13MB2503C590A2AE6FEF6BCAC529FDBB9@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB2503C590A2AE6FEF6BCAC529FDBB9@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 14 Mar 2023 18:03:59 -0400
Message-ID: <CA+GJov5O6hGdjYMXjRd34MEZuyBuukyJCOsS=HeO30h43eLQbQ@mail.gmail.com>
Subject: Re: [KTAP V2 PATCH] ktap_v2: add skip test result
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>,
        "dlatypov@google.com" <dlatypov@google.com>,
        "kernelci@groups.io" <kernelci@groups.io>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Sat, Mar 11, 2023 at 12:37=E2=80=AFPM Bird, Tim <Tim.Bird@sony.com> wrot=
e:
>
>
>
> > -----Original Message-----
> > From: Rae Moar <rmoar@google.com>
> >
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
>
> Is there an implementation patch (RFC or otherwise) that accompanies
> this change in the spec?

Hi Tim!

Other than the KUnit parser implementation I linked in the commit
message, there is no current implementation patch that accompanies
this proposal. I was very curious to learn what others thought of the
idea of the skip result. An implementation patch should definitely be
created to implement the necessary changes to kselftest output and a
few commonly used parsers.

>
> Also, can you tell me which kselftest modules you expect to use this
> new 'skip' result, as opposed to the #SKIP directive?  Are there patches
> pending submission that already use this?

There are no current patches in my knowledge that are proposing to use
this. This idea partly stems from your suggestion from the KTAP v1
discussions where you proposed an unknown test result type:
https://lore.kernel.org/all/BYAPR13MB25037E7EE38DE8717DC7D254FDCB9@BYAPR13M=
B2503.namprd13.prod.outlook.com/.
I would be open to this suggestion as an alternative.

>
> Which in-tree and out-of-tree results parsers would be affected?
>
> I know my Fuego kselftest results parser would be affected.

I honestly have much to learn about different results parsers. I
suspect every parser in use would be affected, except for those that
only care about failures and simply grep for "not ok". Their results
might actually be more clear by not including skipped tests. I will
continue to do more research on this and explore this in a potential
implementation patch. I ask everyone to feel free to correct or
enlighten me about the different parsers they use.

>
> While I recognize the slight improvement in human readability, this
> will cause a fair amount of churn.  And it takes us out of TAP compliance=
.
> Can you quantify the churn a bit?

I do realize this would create quite a bit of churn and if people
think it is not worth the extra effort I would understand that. But
thinking towards the future of KTAP, I suspect we will eventually want
to shift away from using the SKIP directive as it is inherently
confusing to allow multiple result types with the directive, as Frank
mentioned. It might be a question of when we want to make this shift?

I find it difficult to specifically quantify the churn. Looking at a
LKFT build on linaro about 11% of tests were skipped and that was
widespread across different types of tests. So skipped tests are
certainly in widespread use. However, I suspect the actual changes to
the code that creates kselftest output and for each parser would not
be too difficult. But it would require parsers that did not currently
care about skipped tests to decide how to handle the new result.

One thing to note on the created churn: I have noticed a proportion of
kselftests currently implement skipped tests in a way that does not
use the SKIP directive. They use a comment of the format "# [SKIP]"
prior to a test result line with no SKIP directive. Thus, in order to
reach KTAP compliance the way skip tests are handled would need to be
changed in these cases anyways.

Thanks!
Rae


>
>  -- Tim
>
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
> > ---
> >
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
> > +- "SKIP", which indicates a test was skipped (note this is an alternat=
ive to
> > +  the "skip" result type and if the SKIP directive is used, the
> > +  result can be any type - "ok", "not ok", or "skip")
> >  - "TODO", which indicates that a test is not expected to pass at the m=
oment,
> >    e.g. because the feature it is testing is known to be broken. While =
this
> >    directive is inherited from TAP, its use in the kernel is discourage=
d.
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
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
>
