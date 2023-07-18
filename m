Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717A8758647
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 22:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGRUty (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 16:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjGRUtx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 16:49:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750D8198C
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 13:49:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so117755e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689713389; x=1692305389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgQcqwhLTNI8qX6knCzj+hGMtjn0S20ah/hoUWW0q2U=;
        b=hVKdbNRuovsCs+y0Lf2bjXemqvVB1qeWfMqk5yyraYwCcDvNKtONwM+9XfpFN1W2NA
         tjgJrVAb3dsXBTNQ49SmM3AwnYOhUE/vqp/wEYLOf83X2W+tDVEXTHfYPKQ2tUo9NPaT
         dw5ZrZz/j56/coQr2r1iopReeZ+mBe+jfH/39c/vzxbEe4h2YJfXd+fcTPAwN0H0T4cV
         MBqZJQwb6H1hrxwxIbfv56yZ0fo9pEyNfm1ssTyQdVI+F44curhBWxXdMIR7a+769jzY
         mh2JTM5D3dwczbjf4t4s/+GLzOEMKj457HnZ9/URUATtGgVJn5v2gsUDhUBv+VENOOLr
         PzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689713389; x=1692305389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgQcqwhLTNI8qX6knCzj+hGMtjn0S20ah/hoUWW0q2U=;
        b=hiTv1I9++WIC3RrKaF+uVXDTV+cwDaRzFcWZjRFjcPxhIbRQusOGvKHoiJyXA3IVaB
         5VBioJub0eiFZa152jzyKd5D6LfG8QL/Gf4KCxs6uHLGBLYVgpOaHu4fPBHphWtqo2aK
         l0wewexSjXMrEojl12RJu7gp5A6yx3BEqY2HPeVsVTG2wOaGqQIXT36J49Dhxs8dTn/O
         TrnfG5uK6BZw9X0FgpBZ9gLeyQOQF73G+60dL63N3LCLNFdY3BXFK0/xK+a9fd143wtx
         zbGTjnn5vbGvAbjZaa3hNNFtGsxXwtgtQThZeTwCMnVkzWV57EdYXEYYScVuMSv8qDhk
         UBPQ==
X-Gm-Message-State: ABy/qLa1zNl+QQRo5jouoOxJuH8geEpNOaQqiLO5d6DMqrP6u7rOyZ3V
        EMI2t8AR5rg7lPwoJtCyRPytvIddKCXNOTAaEuMfEQ==
X-Google-Smtp-Source: APBJJlEXJgViNiRV7+HWXgtPyoNb/rXxkQwn9HrWqWCqXqR19OSLFrNI1QNrW14keUR5xmaeSR91zkFruRzzHPqWgfY=
X-Received: by 2002:a05:600c:3ca0:b0:3f7:7bd4:3b9d with SMTP id
 bg32-20020a05600c3ca000b003f77bd43b9dmr162464wmb.6.1689713388786; Tue, 18 Jul
 2023 13:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-10-rmoar@google.com>
 <CABVgOS=1kwHn8BtB55i3TMcXB9+RveiyGn4aYja_agkc4_yH-w@mail.gmail.com>
In-Reply-To: <CABVgOS=1kwHn8BtB55i3TMcXB9+RveiyGn4aYja_agkc4_yH-w@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 18 Jul 2023 16:49:35 -0400
Message-ID: <CA+GJov4BdZx-5MfbtWCs2jDYOfq8CuZm3FZ4VFPYm8MNTj-mnQ@mail.gmail.com>
Subject: Re: [RFC v2 9/9] kunit: Add documentation of KUnit test attributes
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 3:39=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 8 Jul 2023 at 05:10, Rae Moar <rmoar@google.com> wrote:
> >
> > Add documentation on the use of test attributes under the section "Tips=
 for
> > Running KUnit Tests" in the KUnit docs.
> >
> > Documentation includes three sections on how to mark tests with attribu=
tes,
> > how attributes are reported, and how the user can filter tests using te=
st
> > attributes.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> Looks good overall. Some nitpicks below.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> >
> > Changes since v1:
> > - This is a new patch
> >
> >  .../dev-tools/kunit/running_tips.rst          | 163 ++++++++++++++++++
> >  1 file changed, 163 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documenta=
tion/dev-tools/kunit/running_tips.rst
> > index 8e8c493f17d1..c9bc5a6595d3 100644
> > --- a/Documentation/dev-tools/kunit/running_tips.rst
> > +++ b/Documentation/dev-tools/kunit/running_tips.rst
> > @@ -262,3 +262,166 @@ other code executed during boot, e.g.
> >         # Reset coverage counters before running the test.
> >         $ echo 0 > /sys/kernel/debug/gcov/reset
> >         $ modprobe kunit-example-test
> > +
> > +
> > +Test Attributes and Filtering
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +
> > +Test suites and cases can be marked with test attributes, such as spee=
d of
> > +test. These attributes will later be printed in test output and can be=
 used to
> > +filter test execution.
> > +
> > +Marking Test Attributes
> > +-----------------------
> > +
> > +Tests are marked with an attribute by including a ``kunit_attributes``=
 object
> > +in the test definition.
> > +
> > +Test cases can be marked using the ``KUNIT_CASE_ATTR(test_name, attrib=
utes)``
> > +macro to define the test case instead of ``KUNIT_CASE(test_name)``.
> > +
> > +.. code-block:: c
> > +
> > +       static const struct kunit_attributes example_attr =3D {
> > +               .speed =3D KUNIT_VERY_SLOW,
> > +       };
> > +
> > +       static struct kunit_case example_test_cases[] =3D {
> > +               KUNIT_CASE_ATTR(example_test, example_attr),
> > +       };
> > +
> > +.. note::
> > +       To mark a test case as slow, you can also use ``KUNIT_CASE_SLOW=
(test_name)``.
> > +       This is a helpful macro as the slow attribute is the most commo=
nly used.
> > +
> > +Test suites can be marked with an attribute by setting the "attr" fiel=
d in the
> > +suite definition.
> > +
> > +.. code-block:: c
> > +
> > +       static const struct kunit_attributes example_attr =3D {
> > +               .speed =3D KUNIT_VERY_SLOW,
> > +       };
> > +
> > +       static struct kunit_suite example_test_suite =3D {
> > +               ...,
> > +               .attr =3D example_attr,
> > +       };
> > +
> > +.. note::
> > +       Not all attributes need to be set in a ``kunit_attributes`` obj=
ect. Unset
> > +       attributes will remain uninitialized and act as though the attr=
ibute is set
> > +       to 0 or NULL. Thus, if an attribute is set to 0, it is treated =
as unset.
> > +       These unset attributes will not be reported and may act as a de=
fault value
> > +       for filtering purposes.
> > +
> > +Reporting Attributes
> > +--------------------
> > +
> > +When a user runs tests, attributes will be present in kernel output (i=
n KTAP
> > +format). This is an example of how test attributes for test cases will=
 be formatted
> > +in Kernel output:
> > +
> > +.. code-block:: none
> > +
> > +       # example_test.speed: slow
> > +       ok 1 example_test
> > +
> > +This is an example of how test attributes for test suites will be form=
atted in
> > +Kernel output:
> > +
> > +.. code-block:: none
> > +
> > +         KTAP version 2
> > +         # Subtest: example_suite
> > +         # module: kunit_example_test
> > +         1..3
> > +         ...
> > +       ok 1 example_suite
> > +
>
> Maybe worth noting that kunit.py will hide these for passing tests by
> default, and --raw_output is needed to see them?
>

I will definitely add this in. If attributes are popular in the
future, I could create a future patch to show attributes in the parser
output as well.

> > +Additionally, users can output a full attribute report of tests with t=
heir
> > +attributes, using the command line flag ``--list_tests_attr``:
> > +
> > +.. code-block:: bash
> > +
> > +       kunit.py run "example" --list_tests_attr
> > +
> > +.. note::
> > +       This report can be accessed when running KUnit manually by pass=
ing in the
> > +       module_param ``kunit.action=3Dlist_attr``.
> > +
> > +Filtering
> > +---------
> > +
> > +Users can filter tests using the ``--filter`` command line flag when r=
unning
> > +tests. As an example:
> > +
> > +.. code-block:: bash
> > +
> > +       kunit.py run --filter speed=3Dslow
> > +
> > +
> > +You can also use the following operations on filters: "<", ">", "<=3D"=
, ">=3D",
> > +"!=3D", and "=3D". Example:
> > +
> > +.. code-block:: bash
> > +
> > +       kunit.py run --filter "speed>slow"
> > +
> > +This example will run all tests with speeds faster than slow. Note tha=
t the
> > +characters < and > are often interpreted by the shell, so they may nee=
d to be
> > +quoted or escaped, as above.
> > +
> > +Additionally, you can use multiple filters at once. Simply separate fi=
lters
> > +using commas. Example:
> > +
> > +.. code-block:: bash
> > +
> > +       kunit.py run --filter "speed>slow, module=3Dkunit_example_test"
> > +
> > +.. note::
> > +       You can use this filtering feature when running KUnit manually =
by passing
> > +       the filter as a module param: ``kunit.filter=3D"speed>slow, spe=
ed<=3Dnormal"``.
> > +
> > +Filtered tests will not run or show up in the test output. You can use=
 the
> > +``--filter_skip`` flag to skip filtered tests instead. These tests wil=
l be
> > +shown in the test output in the test but will not run. To use this fea=
ture when
> > +running KUnit manually, use the ``kunit.filter`` module param with
> > +``kunit.filter_action=3Dskip``.
> > +
> > +Rules of Filtering Procedure
> > +----------------------------
> > +
> > +Since both suites and test cases can have attributes, there may be con=
flicts
> > +between attributes during filtering. The process of filtering follows =
these
> > +rules:
> > +
> > +- Filtering always operates at a per-test level.
> > +
> > +- If a test has an attribute set, then the test's value is filtered on=
.
> > +
> > +- Otherwise, the value falls back to the suite's value.
> > +
> > +- If neither are set, the attribute has a global "default" value, whic=
h is used.
> > +
> > +List of Current Attributes
> > +--------------------------
>
> I wonder whether this should end up part of the KTAP spec (or as an
> appendix/supplement to it). Or even as a separate page within the
> KUnit documentation to avoid running_tips.rst from getting too huge.

I am a bit hesitant to move this as part of the KTAP spec in case
there will exist KTAP attributes/data that are not supported by the
KUnit test attributes framework (could be runtime specific attributes
that use a different framework?).

However, I do worry about the size of this page. Do you think that I
should move all of the attributes to a new documentation page?

>
> > +
> > +``speed``
> > +
> > +This attribute indicates the speed of a test's execution (how slow or =
fast the
> > +test is).
> > +
> > +This attribute is saved as an enum with the following categories: "nor=
mal",
> > +"slow", or "very_slow". The assumed default speed for tests is "normal=
". This
> > +indicates that the test takes a relatively trivial amount of time (les=
s than
> > +1 second), regardless of the machine it is running on. Any test slower=
 than
> > +this could be marked as "slow" or "very_slow".
>
> Is it worth noting that "KUNIT_CASE_SLOW()" can be used to easily set
> this to slow?

This definitely seems important to add. I will add this to the documentatio=
n.

>
>
> > +
> > +``module``
> > +
> > +This attribute indicates the name of the module associated with the te=
st.
> > +
> > +This attribute is automatically saved as a string and is printed for e=
ach suite.
> > +Tests can also be filtered using this attribute.
> > +
> > --
> > 2.41.0.255.g8b1d071c50-goog
>
> >
>
> Error: new blank line at EOF.

Oops. I will change this.
