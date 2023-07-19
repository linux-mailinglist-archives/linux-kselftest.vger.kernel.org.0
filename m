Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C830175904C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 10:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjGSIb0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjGSIbZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 04:31:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9285119B2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 01:31:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so174465e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 01:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689755480; x=1690360280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=exAe9trlaLTrotgzAK4UhCIPmcdcgp8j/K/meffveUE=;
        b=lcJnaiAm3Be56FbhlG9pndVnrZ4LRESHm8dWQGuWhuJwivFWQd53QC98DMfQHYZnv2
         Tw2vsqotJaqRCD5Mpd5cxCtnxwNf5go7ot5BCG5HQJKp/krBURXy2ZgtK/FxrFtLrKNR
         5I5ScX/Hrf0cQy3NiSSzVWZeAdRXb7Ofx2bXigs4EdMQDeCNIVnMwbicG8JUNQOSEMWS
         +0zZckiPs1wlyh/cc4eAnPbrIdZSVE3XZl4qIZvsr4GaxG21pn+xLp+Erx3yth5UYspy
         S4NDwjFS185G+jTGmghjIdWQ8ffQPelbQotm1YzdzRDxIuO9XkixJ8uf5uUv+Ker/X5a
         EZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689755480; x=1690360280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exAe9trlaLTrotgzAK4UhCIPmcdcgp8j/K/meffveUE=;
        b=WeRxVoaolJNBz6hkWXJzPvO0p67TpMVfArtC3GH7LpTVdEGcP4Top7mhM3nkG7hhwE
         U8KEWZIidJH7rEVOyYumnk+mWDLbUrklqM41LmzDay5+EBtMSO968JqtoXSiHOfJvZB6
         3K+FBWcHhu8fx75EB718rKDeibeOAAckuZ8Uv27snW+6uE/klmA5eVcJwxBs9oyQSJ2S
         36ABo4p9aWhAlNOUXLV38W/GrRQtdVBfNnmB82gak06tXENkPQbghWhLF9R1HGgicHMh
         p/tHINjb17S4ykubSTsEPXaKWKRoMIowNHWx6HvgJwJ/AyY0emuvZYkSFiU3Ue2dmq5x
         2icw==
X-Gm-Message-State: ABy/qLZv+EYeh9oSFJH0simp9zdGaLCi7RRt0G9f0O+tfTj00Iw7LARf
        5XA4IwllkHXuuXAGqPhxG7ONuQXDoBrFbCIndU5jlg==
X-Google-Smtp-Source: APBJJlES64MMTM7v5XYnOJf6b6Nt7q7upKMw890OTdS+lh7iY1mf9rsRnGdMfinnvwLdrJuWZDgvEL7VoAmzD21MSgc=
X-Received: by 2002:a05:600c:4746:b0:3fd:e15:6d5 with SMTP id
 w6-20020a05600c474600b003fd0e1506d5mr18215wmo.2.1689755480261; Wed, 19 Jul
 2023 01:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-10-rmoar@google.com>
 <CABVgOS=1kwHn8BtB55i3TMcXB9+RveiyGn4aYja_agkc4_yH-w@mail.gmail.com> <CA+GJov4BdZx-5MfbtWCs2jDYOfq8CuZm3FZ4VFPYm8MNTj-mnQ@mail.gmail.com>
In-Reply-To: <CA+GJov4BdZx-5MfbtWCs2jDYOfq8CuZm3FZ4VFPYm8MNTj-mnQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Jul 2023 16:31:08 +0800
Message-ID: <CABVgOS=qO2vESvwYUEYCneMHRdVWwNES6TqpTnWN6KW+8f=16g@mail.gmail.com>
Subject: Re: [RFC v2 9/9] kunit: Add documentation of KUnit test attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003041340600d2db16"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000003041340600d2db16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Jul 2023 at 04:49, Rae Moar <rmoar@google.com> wrote:
>
> On Tue, Jul 18, 2023 at 3:39=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >
> > On Sat, 8 Jul 2023 at 05:10, Rae Moar <rmoar@google.com> wrote:
> > >
> > > Add documentation on the use of test attributes under the section "Ti=
ps for
> > > Running KUnit Tests" in the KUnit docs.
> > >
> > > Documentation includes three sections on how to mark tests with attri=
butes,
> > > how attributes are reported, and how the user can filter tests using =
test
> > > attributes.
> > >
> > > Signed-off-by: Rae Moar <rmoar@google.com>
> > > ---
> >
> > Looks good overall. Some nitpicks below.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> >
> > >
> > > Changes since v1:
> > > - This is a new patch
> > >
> > >  .../dev-tools/kunit/running_tips.rst          | 163 ++++++++++++++++=
++
> > >  1 file changed, 163 insertions(+)
> > >
> > > diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documen=
tation/dev-tools/kunit/running_tips.rst
> > > index 8e8c493f17d1..c9bc5a6595d3 100644
> > > --- a/Documentation/dev-tools/kunit/running_tips.rst
> > > +++ b/Documentation/dev-tools/kunit/running_tips.rst
> > > @@ -262,3 +262,166 @@ other code executed during boot, e.g.
> > >         # Reset coverage counters before running the test.
> > >         $ echo 0 > /sys/kernel/debug/gcov/reset
> > >         $ modprobe kunit-example-test
> > > +
> > > +
> > > +Test Attributes and Filtering
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Test suites and cases can be marked with test attributes, such as sp=
eed of
> > > +test. These attributes will later be printed in test output and can =
be used to
> > > +filter test execution.
> > > +
> > > +Marking Test Attributes
> > > +-----------------------
> > > +
> > > +Tests are marked with an attribute by including a ``kunit_attributes=
`` object
> > > +in the test definition.
> > > +
> > > +Test cases can be marked using the ``KUNIT_CASE_ATTR(test_name, attr=
ibutes)``
> > > +macro to define the test case instead of ``KUNIT_CASE(test_name)``.
> > > +
> > > +.. code-block:: c
> > > +
> > > +       static const struct kunit_attributes example_attr =3D {
> > > +               .speed =3D KUNIT_VERY_SLOW,
> > > +       };
> > > +
> > > +       static struct kunit_case example_test_cases[] =3D {
> > > +               KUNIT_CASE_ATTR(example_test, example_attr),
> > > +       };
> > > +
> > > +.. note::
> > > +       To mark a test case as slow, you can also use ``KUNIT_CASE_SL=
OW(test_name)``.
> > > +       This is a helpful macro as the slow attribute is the most com=
monly used.
> > > +
> > > +Test suites can be marked with an attribute by setting the "attr" fi=
eld in the
> > > +suite definition.
> > > +
> > > +.. code-block:: c
> > > +
> > > +       static const struct kunit_attributes example_attr =3D {
> > > +               .speed =3D KUNIT_VERY_SLOW,
> > > +       };
> > > +
> > > +       static struct kunit_suite example_test_suite =3D {
> > > +               ...,
> > > +               .attr =3D example_attr,
> > > +       };
> > > +
> > > +.. note::
> > > +       Not all attributes need to be set in a ``kunit_attributes`` o=
bject. Unset
> > > +       attributes will remain uninitialized and act as though the at=
tribute is set
> > > +       to 0 or NULL. Thus, if an attribute is set to 0, it is treate=
d as unset.
> > > +       These unset attributes will not be reported and may act as a =
default value
> > > +       for filtering purposes.
> > > +
> > > +Reporting Attributes
> > > +--------------------
> > > +
> > > +When a user runs tests, attributes will be present in kernel output =
(in KTAP
> > > +format). This is an example of how test attributes for test cases wi=
ll be formatted
> > > +in Kernel output:
> > > +
> > > +.. code-block:: none
> > > +
> > > +       # example_test.speed: slow
> > > +       ok 1 example_test
> > > +
> > > +This is an example of how test attributes for test suites will be fo=
rmatted in
> > > +Kernel output:
> > > +
> > > +.. code-block:: none
> > > +
> > > +         KTAP version 2
> > > +         # Subtest: example_suite
> > > +         # module: kunit_example_test
> > > +         1..3
> > > +         ...
> > > +       ok 1 example_suite
> > > +
> >
> > Maybe worth noting that kunit.py will hide these for passing tests by
> > default, and --raw_output is needed to see them?
> >
>
> I will definitely add this in. If attributes are popular in the
> future, I could create a future patch to show attributes in the parser
> output as well.

Yeah, that could definitely be useful as a follow-up patch.

> > > +Additionally, users can output a full attribute report of tests with=
 their
> > > +attributes, using the command line flag ``--list_tests_attr``:
> > > +
> > > +.. code-block:: bash
> > > +
> > > +       kunit.py run "example" --list_tests_attr
> > > +
> > > +.. note::
> > > +       This report can be accessed when running KUnit manually by pa=
ssing in the
> > > +       module_param ``kunit.action=3Dlist_attr``.
> > > +
> > > +Filtering
> > > +---------
> > > +
> > > +Users can filter tests using the ``--filter`` command line flag when=
 running
> > > +tests. As an example:
> > > +
> > > +.. code-block:: bash
> > > +
> > > +       kunit.py run --filter speed=3Dslow
> > > +
> > > +
> > > +You can also use the following operations on filters: "<", ">", "<=
=3D", ">=3D",
> > > +"!=3D", and "=3D". Example:
> > > +
> > > +.. code-block:: bash
> > > +
> > > +       kunit.py run --filter "speed>slow"
> > > +
> > > +This example will run all tests with speeds faster than slow. Note t=
hat the
> > > +characters < and > are often interpreted by the shell, so they may n=
eed to be
> > > +quoted or escaped, as above.
> > > +
> > > +Additionally, you can use multiple filters at once. Simply separate =
filters
> > > +using commas. Example:
> > > +
> > > +.. code-block:: bash
> > > +
> > > +       kunit.py run --filter "speed>slow, module=3Dkunit_example_tes=
t"
> > > +
> > > +.. note::
> > > +       You can use this filtering feature when running KUnit manuall=
y by passing
> > > +       the filter as a module param: ``kunit.filter=3D"speed>slow, s=
peed<=3Dnormal"``.
> > > +
> > > +Filtered tests will not run or show up in the test output. You can u=
se the
> > > +``--filter_skip`` flag to skip filtered tests instead. These tests w=
ill be
> > > +shown in the test output in the test but will not run. To use this f=
eature when
> > > +running KUnit manually, use the ``kunit.filter`` module param with
> > > +``kunit.filter_action=3Dskip``.
> > > +
> > > +Rules of Filtering Procedure
> > > +----------------------------
> > > +
> > > +Since both suites and test cases can have attributes, there may be c=
onflicts
> > > +between attributes during filtering. The process of filtering follow=
s these
> > > +rules:
> > > +
> > > +- Filtering always operates at a per-test level.
> > > +
> > > +- If a test has an attribute set, then the test's value is filtered =
on.
> > > +
> > > +- Otherwise, the value falls back to the suite's value.
> > > +
> > > +- If neither are set, the attribute has a global "default" value, wh=
ich is used.
> > > +
> > > +List of Current Attributes
> > > +--------------------------
> >
> > I wonder whether this should end up part of the KTAP spec (or as an
> > appendix/supplement to it). Or even as a separate page within the
> > KUnit documentation to avoid running_tips.rst from getting too huge.
>
> I am a bit hesitant to move this as part of the KTAP spec in case
> there will exist KTAP attributes/data that are not supported by the
> KUnit test attributes framework (could be runtime specific attributes
> that use a different framework?).

This is probably something best worked out as part of the KTAP spec
process. Either attribute names are a free-for-all (albeit hopefully
one where there are some documented 'common' attributes), or we need
some sort of namespacing between "General KTAP attributes",
"KUnit-specific attributes", "subsystem-specific attributes",
"totally-made-up-on-the-spot attributes", etc.

e.g., email headers have a list of 'standard' ones, but anyone can add
their own as long as it starts with 'X-'. Or OpenGL extensions are
always of the form GL_blah_blah_blah_<vendor> (where vendor is the
code for the company that proposed it, or EXT or ARB for those which
have been agreed upon by everyone).

> However, I do worry about the size of this page. Do you think that I
> should move all of the attributes to a new documentation page?

While I don't think it's a problem with only two attributes, it'd
probably be the more futureproof thing to do.

That being said, maybe we wait until there's a decision on the KTAP
side? Up to you.



> >
> > > +
> > > +``speed``
> > > +
> > > +This attribute indicates the speed of a test's execution (how slow o=
r fast the
> > > +test is).
> > > +
> > > +This attribute is saved as an enum with the following categories: "n=
ormal",
> > > +"slow", or "very_slow". The assumed default speed for tests is "norm=
al". This
> > > +indicates that the test takes a relatively trivial amount of time (l=
ess than
> > > +1 second), regardless of the machine it is running on. Any test slow=
er than
> > > +this could be marked as "slow" or "very_slow".
> >
> > Is it worth noting that "KUNIT_CASE_SLOW()" can be used to easily set
> > this to slow?
>
> This definitely seems important to add. I will add this to the documentat=
ion.
>
> >
> >
> > > +
> > > +``module``
> > > +
> > > +This attribute indicates the name of the module associated with the =
test.
> > > +
> > > +This attribute is automatically saved as a string and is printed for=
 each suite.
> > > +Tests can also be filtered using this attribute.
> > > +
> > > --
> > > 2.41.0.255.g8b1d071c50-goog
> >
> > >
> >
> > Error: new blank line at EOF.
>
> Oops. I will change this.

--0000000000003041340600d2db16
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBq
vUPrv8pDEDApY84zHaugjXL0AfSIYnyxf1GKWu6oNTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTkwODMxMjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAPqsBjoRnKASq4GpgxX3o
8wuNNAkO73Bfyb61OTomzWKgrvr9vyCiBPPqpNBbeCSHW4nv+GdWVLj30s+N9FQVeTaYObLcoNmf
73qsQY/c305cJ7LfX54MIVHtnxGjyZjFicfX83BgP9FRj+MxWrXoj2fpPGa+NyXrg4OCFoqIvMOl
XDBees7cgDX9QnVNHxL8uhjerNJbT2DXSXkRD1WI76ToEBNLK90GeoIO+204alvtMdqwxVq7nvRF
s6KuqAuWjtdtEjaRxE88DfaTkGBLocpZH2UNHaUqi1W1OEU3bXk+fxf9qQDICSgV1H6UVsb5c87P
XDGu28Ucw1aQEogEgQ==
--0000000000003041340600d2db16--
