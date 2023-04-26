Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249BA6EF83F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 18:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbjDZQSV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 12:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjDZQSU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 12:18:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A063AA9
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 09:18:17 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3ef31924c64so451651cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682525896; x=1685117896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W02sX+/Hi4nz+GqWmTPn+DU21bazDZwB7HxRWfvvek=;
        b=tailfJl3EV8FGH5dmAR21htd7YKNYN6qouW89bQ8OM6IUv2DyIUg9YGmCoSD2i2vxI
         5FORrs22Tp7xc3HaJ+L9wBy/OQqV/DWHHpIvcNvMuBWf2xFOy8eZSs1P0oCfK9UdLaIu
         1+abaLNZWyUgAKfNRL9i/w0bdMYnLKZcvLU5DXihBwf7LpUlzsBWFthDriWBx4pISApJ
         bIf6r2UZDRbPwdZdEUdrgk33lEZoHpS01jSAN9K5GbP+5TrX+LcErr24O9guzWUGS1Bn
         6uIxdxf20gkxy0Vl53I4v7g7WTKK0iPy8FT2leqFyUUfmm9kbcW43NkqtUr/X7XjAWvK
         uFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682525896; x=1685117896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9W02sX+/Hi4nz+GqWmTPn+DU21bazDZwB7HxRWfvvek=;
        b=SILMZLR+obssIEbZiI82sNkx1r/s9u7mpdca9MRM7RNt5T6Q+BoR7PQVYmDKPsY9lL
         uR7wlD2g/zONuRaF7zI4EzDd8nAR4AiSX7e4jjIND3xV8Q680O1QmD1Uv8g5ZTwR7JxK
         UPJaxSTwVsxE86VduhwUVcR7j3oOoGoMes7160J6YEZea1lX5HsfD0fOxPec1jZhtnYO
         j5tbQ5BGDcH6Cq/I99Kad3PnXNPB54VzfMes2+h/h9B0mvYO1IwiLGaB2djEtQ7pTYyk
         lsMemus/o+IUSBfYJNL/AjGn1eTBSx7Ipzw+ItRTf1tLmDCTLXBcFrLWkWBxThL6POXK
         yViw==
X-Gm-Message-State: AC+VfDyP3dDn8odrPWikMNVujSi5DUmtu0OlLrnZ8IjC5o92+fDz/Qg3
        XDZmL7NQfuaYkatgvYaJn4up+vkcRnCstFiLbnD2IQ==
X-Google-Smtp-Source: ACHHUZ5qSy43WhoYTYSr7H4zeYG3GOp2G/TDkLGtP15iQBs2p7alpyexFoz7zlKTTveLnuYKaAqp0cMBAD2HvjW1AN8=
X-Received: by 2002:a05:622a:199a:b0:3de:1aaa:42f5 with SMTP id
 u26-20020a05622a199a00b003de1aaa42f5mr336311qtc.15.1682525896412; Wed, 26 Apr
 2023 09:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230420205734.1288498-1-rmoar@google.com> <ce5b723d-2395-8974-ba62-1ee519732218@gmail.com>
In-Reply-To: <ce5b723d-2395-8974-ba62-1ee519732218@gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 26 Apr 2023 12:18:02 -0400
Message-ID: <CA+GJov5nG3fXz9KX-DdkpJ2R98f1LD=rnURomzvUzHHsAODr8A@mail.gmail.com>
Subject: Re: [KTAP V2 PATCH] ktap_v2: add test metadata
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

On Tue, Apr 25, 2023 at 4:55=E2=80=AFPM Frank Rowand <frowand.list@gmail.co=
m> wrote:
>
> On 4/20/23 15:57, Rae Moar wrote:
> > Add specification for declaring test metadata to the KTAP v2 spec.
> >
> > The purpose of test metadata is to allow for the declaration of essenti=
al
> > testing information in KTAP output. This information includes test
> > names, test configuration info, test attributes, and test files.
> >
> > There have been similar ideas around the idea of test metadata such as =
test
> > prefixes and test name lines. However, I propose this specification as =
an
> > overall fix for these issues.
>
> This seems like a cleaner approach.
>
> >
> > These test metadata lines are a form of diagnostic lines with the
> > format: "# <metadata_type>: <data>". As a type of diagnostic line, test
> > metadata lines are compliant with KTAP v1, which will help to not
> > interfere too much with current parsers.
> >
> > Specifically the "# Subtest:" line is derived from the TAP 14 spec:
> > https://testanything.org/tap-version-14-specification.html.
> >
> > The proposed location for test metadata is in the test header, between =
the
> > version line and the test plan line. Note including diagnostic lines in
> > the test header is a depature from KTAP v1.
> >
> > This location provides two main benefits:
> >
> > First, metadata will be printed prior to when subtests are run. Then if=
 a
> > test fails, test metadata can help discern which test is causing the is=
sue
> > and potentially why.
> >
> > Second, this location ensures that the lines will not be accidentally
> > parsed as a subtest's diagnostic lines because the lines are bordered b=
y
> > the version line and plan line.
>
> I like that.
>
> >
> > Here is an example of test metadata:
> >
> >  KTAP version 2
> >  # Config: CONFIG_TEST=3Dy
> >  1..1
> >      KTAP version 2
> >      # Subtest: test_suite
> >      # File: /sys/kernel/...
> >      # Attributes: slow
> >      # Other: example_test
> >      1..2
> >      ok 1 test_1
> >      ok 2 test_2
> >  ok 1 test_suite
> >
> > Here is a link to a version of the KUnit parser that is able to parse t=
est
> > metadata lines for KTAP version 2. Note this includes test metadata
> > lines for the main level of KTAP.
> >
> > Link: https://kunit-review.googlesource.com/c/linux/+/5809
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >
> > Hi everyone,
> >
> > I would like to use this proposal similar to an RFC to gather ideas on =
the
> > topic of test metadata. Let me know what you think.
> >
> > I am also interested in brainstorming a list of recognized metadata typ=
es.
> > Providing recognized metadata types would be helpful in parsing and
> > displaying test metadata in a useful way.
> >
> > Current ideas:
> > - "# Subtest: <test_name>" to indicate test name (name must match
> >   corresponding result line)
>
> I would prefer "Test" to "Subtest" because the type should be allowed for=
 the
> top level test, as well as for subtest levels.

Hi Frank!

Yes, I can see the reasoning to switch to "Test". Although this is a
departure from current behavior, it would be clearer. I am happy to
make this change.

>
> > - "# Attributes: <attributes list>" to indicate test attributes (list
> >   separated by commas)
> > - "# File: <file_path>" to indicate file used in testing
> >
> > Any other ideas?
>
> (Already used in an example above...)
>
> - "# Config: <config_option list> to indicate kernel configuration option=
s
>   (list separated by commas)
>
>     config_option format:
>       Option XXX is enabled: CONFIG_XXX=3Dy
>       Option XXX is not enabled: CONFIG_XXX=3Dn
>       Option XXX is text: CONFIG_XXX=3D"a text string"
>

I like this addition of the "Config" metadata. I also like all of
these format options, including the text string option. Although, I
would be interested in adding "Option XXX is loadable as a module:
CONFIG_XXX=3Dm" to the format list.

> Linux .config format is "#CONFIG_XXX is not set",
> but this would be harder to parse in a list.
>
> A text config option also complicates parsing of a list.  Maybe there
> should not be a list, instead have a separate "# Config:" line for
> each config option.

I'm not sure how to deal with multiple config options. I am split
between either using a list or multiple "Config" lines. I would be
happy with either approach. Maybe a list would be slightly better,
since it is slightly closer to the defined behavior for the attributes
metadata line.

>
> I would like to bifurcate the name space of metadata types, to names
> specified in the standard vs names not in the standard that can be
> used on an experimental or for future use in existing tests.
>
> I can think of at least two ways to implement this:
>
> (1) types that are in the specification all begin with a specific prefix,
> such as "ktap_" (bike shedding on naming welcomed), so the examples woudl=
d be
>
>   # ktap_test:
>   # ktap_attributes:
>   # ktap_file:
>   # ktap_config:
>
> (2) types that are _not_ in the specification all begin with a specific p=
refix,
> such as "custom_" (bike shedding on naming welcomed).
>

This is an interesting proposal. I like this idea of using a prefix. I
would be happy to add this. I like "ktap_" and "custom_".

Thanks!
-Rae

> >
> > Note this proposal replaces two of my previous proposals: "ktap_v2: add
> > recognized test name line" and "ktap_v2: allow prefix to KTAP lines."
> >
> > Thanks!
> > -Rae
> >
> > Note: this patch is based on Frank's ktap_spec_version_2 branch.
> >
> >  Documentation/dev-tools/ktap.rst | 51 ++++++++++++++++++++++++++++++--
> >  1 file changed, 48 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools=
/ktap.rst
> > index ff77f4aaa6ef..a2d0a196c115 100644
> > --- a/Documentation/dev-tools/ktap.rst
> > +++ b/Documentation/dev-tools/ktap.rst
> > @@ -17,7 +17,9 @@ KTAP test results describe a series of tests (which m=
ay be nested: i.e., test
> >  can have subtests), each of which can contain both diagnostic data -- =
e.g., log
> >  lines -- and a final result. The test structure and results are
> >  machine-readable, whereas the diagnostic data is unstructured and is t=
here to
> > -aid human debugging.
> > +aid human debugging. One exception to this is test metadata lines - a =
type
> > +of diagnostic lines. Test metadata is located between the version line=
 and
> > +plan line of a test and can be machine-readable.
> >
> >  KTAP output is built from four different types of lines:
> >  - Version lines
> > @@ -28,8 +30,7 @@ KTAP output is built from four different types of lin=
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
> > @@ -166,6 +167,45 @@ even if they do not start with a "#": this is to c=
apture any other useful
> >  kernel output which may help debug the test. It is nevertheless recomm=
ended
> >  that tests always prefix any diagnostic output they have with a "#" ch=
aracter.
> >
> > +Test metadata lines
> > +-------------------
> > +
> > +Test metadata lines are a type of diagnostic lines used to the declare=
 the
> > +name of a test and other helpful testing information in the test heade=
r.
> > +These lines are often helpful for parsing and for providing context du=
ring
> > +crashes.
> > +
> > +Test metadata lines must follow the format: "# <metadata_type>: <data>=
".
> > +These lines must be located between the version line and the plan line
> > +within a test header.
> > +
> > +There are a few currently recognized metadata types:
> > +- "# Subtest: <test_name>" to indicate test name (name must match
> > +  corresponding result line)
> > +- "# Attributes: <attributes list>" to indicate test attributes (list
> > +  separated by commas)
> > +- "# File: <file_path>" to indicate file used in testing
> > +
> > +As a rule, the "# Subtest:" line is generally first to declare the tes=
t
> > +name. Note that metadata lines do not necessarily need to use a
> > +recognized metadata type.
> > +
> > +An example of using metadata lines:
> > +
> > +::
> > +
> > +        KTAP version 2
> > +        1..1
> > +        # File: /sys/kernel/...
> > +          KTAP version 2
> > +          # Subtest: example
> > +          # Attributes: slow, example_test
> > +          1..1
> > +          ok 1 test_1
> > +        # example passed
> > +        ok 1 example
> > +
> > +
> >  Unknown lines
> >  -------------
> >
> > @@ -206,6 +246,7 @@ An example of a test with two nested subtests:
> >       KTAP version 2
> >       1..1
> >         KTAP version 2
> > +       # Subtest: example
> >         1..2
> >         ok 1 test_1
> >         not ok 2 test_2
> > @@ -219,6 +260,7 @@ An example format with multiple levels of nested te=
sting:
> >       KTAP version 2
> >       1..2
> >         KTAP version 2
> > +       # Subtest: example_test_1
> >         1..2
> >           KTAP version 2
> >           1..2
> > @@ -254,6 +296,7 @@ Example KTAP output
> >       KTAP version 2
> >       1..1
> >         KTAP version 2
> > +       # Subtest: main_test
> >         1..3
> >           KTAP version 2
> >           1..1
> > @@ -261,11 +304,13 @@ Example KTAP output
> >           ok 1 test_1
> >         ok 1 example_test_1
> >           KTAP version 2
> > +            # Attributes: slow
> >           1..2
> >           ok 1 test_1 # SKIP test_1 skipped
> >           ok 2 test_2
> >         ok 2 example_test_2
> >           KTAP version 2
> > +         # Subtest: example_test_3
> >           1..3
> >           ok 1 test_1
> >           # test_2: FAIL
> >
> > base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
>
