Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EB4517D7C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 08:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiECGkq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 02:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiECGkp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 02:40:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064442181C
        for <linux-kselftest@vger.kernel.org>; Mon,  2 May 2022 23:37:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b19so21990564wrh.11
        for <linux-kselftest@vger.kernel.org>; Mon, 02 May 2022 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gCu6szw5pLSFgYG8WXtr/92+blaX846WxNS4HmX+IA=;
        b=QF6E75nv6C60qejnZ+Ad3VW1eWoWpzbhBWv46TDN16DXOn4mJIR0ZWRy0DaF5G5xRz
         6v+8VRYBxkvIK6+Nb58ukO2xEPi2xbNucfaiaPbAiGi2prORU0VCXtUOGQy8SqHfYKJL
         7F8VXb0CkUeWSJKs6aQA26bopoEZJS8eifMZBlhTvPIipeBgm8HRypZCpfc2BTXmN0T4
         kG1cfDZstQ+aBGyaz16Q+AV3ASpkDzk6IErWS76ddWXFiA51CxcwC89Q8MT3BVh8GDgs
         pRGm+hHR3Z9qlQ9iEpRIOdIirnsWEzq12wDnuFSBoFbPj3djUTY7GJSrY3RC/6cFAq11
         EK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gCu6szw5pLSFgYG8WXtr/92+blaX846WxNS4HmX+IA=;
        b=I9334opRaX68JIu3miHHUacHzwWBOFPbNqz3hgJhmJQKDysCTrtOYXKqFpXYaDYv1U
         0rwWFYIsKIo6PwIdvpRYEgD22MBO5eOSzKdDCZ1872cuF8bk8Ku6X448SSinnXBoKmyp
         oqmb2fbXfJ5d7OYtg55+XgSYE/LXIrnW0OY18jIDQblrzsnagb1/wxx713iiVTj5H+fV
         2e2kexJDfGOC15aO0Bul5y31bOR+JYmvch3nPyFVrd/GCdJx15mQ55zTlzyLZkRdAzQA
         WPOm5c8hVmWAJQMzzv1E2Mfffn5k9302fVvFE+Rq4mlYLL9ajxqYaANed55k5BixenKs
         AWRg==
X-Gm-Message-State: AOAM531LM1DQlTEUiGEtOSgyDd5Ws2tDorYi+lyC+B7LcBUFTjuHSB56
        63+Ol9VE1hOlBigCMFTnQLQANBC2KsDAPcprt3dopfZ92QK97Q==
X-Google-Smtp-Source: ABdhPJztwqn5ImKrhaqWP7Wgf78jUDt65492BiUJia54cy7cODm6Jn5/8+Mmd1M94bYdSGK5tE7NCV3T6Ub5ifVWBk0=
X-Received: by 2002:a5d:6651:0:b0:20a:df2f:8027 with SMTP id
 f17-20020a5d6651000000b0020adf2f8027mr11451799wrw.269.1651559832406; Mon, 02
 May 2022 23:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220430045639.839186-1-davidgow@google.com> <CAGS_qxrVnDnUD=0f8vX5C2SWG2mxxXdAWU9A+P7h-K2Y1nm88A@mail.gmail.com>
In-Reply-To: <CAGS_qxrVnDnUD=0f8vX5C2SWG2mxxXdAWU9A+P7h-K2Y1nm88A@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 3 May 2022 14:37:00 +0800
Message-ID: <CABVgOS=W8ub72D2LWwDsbfNBO6mFpceZWm+r+8Ct53pUcFJ_4g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Add list of all valid test configs on UML
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000028d86205de15bd52"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000028d86205de15bd52
Content-Type: text/plain; charset="UTF-8"

On Tue, May 3, 2022 at 6:37 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, Apr 29, 2022 at 11:56 PM David Gow <davidgow@google.com> wrote:
> >
> > It's often desirable (particularly in test automation) to run as many
> > tests as possible. This config enables all the tests which work as
> > builtins under UML at present, increasing the total tests run from 156
> > to 342 (not counting 36 'skipped' tests).
>
> Just to clear up potential confusion for others, I'll note that these
> aren't counting test cases.
> This is from kunit.py's output, so it counts each parameter from
> parameterized tests as "subtests."
>
> Copying my command from
> https://kunit-review.googlesource.com/c/linux/+/5249, one can use this
> to count the # of test cases.
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=...
> --raw_output=kunit --kernel_args=kunit.action=list | egrep
> '^[a-z0-9_-]+\.[a-z0-9_-]+'
>
> I see this enabling a total of 260 test _cases_ (including skipped).
>
> The default (basically just CONFIG_KUNIT_ALL_TESTS=y) gives 192
> (including skipped).
>

Yup, that's definitely the case. I guess I still was thinking in KTAP
terms, where all subtests are effectively tests.

That being said, I do think the total (sub)test (including parameters,
etc) number is the one that's more visible: not only does kunit_tool
print it, but it's also what we've been using as our go to "number of
tests" generally.

> >
> > They can be run with:
> > ./tools/testing/kunit/kunit.py run
> > --kunitconfig=./tools/testing/kunit/configs/all_tests_uml.config
> >
> > This acts as an in-between point between the KUNIT_ALL_TESTS config
> > (which enables only tests whose dependencies are already enabled), and
> > the kunit_tool --alltests option, which tries to use allyesconfig,
> > taking a very long time to build and breaking very often.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Tested-by: Daniel Latypov <dlatypov@google.com>
>
> Looks good to me, some small comments below.
>
> > ---
> >  .../kunit/configs/all_tests_uml.config        | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 tools/testing/kunit/configs/all_tests_uml.config
> >
> > diff --git a/tools/testing/kunit/configs/all_tests_uml.config b/tools/testing/kunit/configs/all_tests_uml.config
> > new file mode 100644
> > index 000000000000..bdee36bef4a3
> > --- /dev/null
> > +++ b/tools/testing/kunit/configs/all_tests_uml.config
> > @@ -0,0 +1,37 @@
> > +# This config enables as many tests as possible under UML.
> > +# It is intended for use in continuous integration systems and similar for
> > +# automated testing of as much as possible.
> > +# The config is manually maintained, though it uses KUNIT_ALL_TESTS=y to enable
> > +# any tests whose dependencies are already satisfied. Please feel free to add
> > +# more options if they any new tests.
>
> missing: "enable"?
> "if they enable any new tests"
>
Whoops, I was switching from "there are any" to "if they enable any"
and clearly got distracted halfway through. :-)

> Hmm, should we state a preference for how heavy (time or
> resource-wise) tests should be?
> Because the comment says it's meant for automation, but I can imagine
> humans wanting to run it.
> (I'm completely fine with us not stating one, just throwing the idea
> out there for discussion)

I think we're probably okay with being a little bit lenient on test
times. The time_test_cases.time64_to_tm_test_date_range and similar
tests take quite a long time in some situations already (older hw,
running under some emulators), but is generally pretty close to
instant under most UML setups. Particularly given that not building
with allyesconfig already saves us many, many minutes of time.

>
> Currently, I get this with an incremental rebuild:
> Elapsed time: 141.627s total, 1.384s configuring, 136.175s building,
> 3.970s running
>
> But we do have tests on other arches that take ~30s to run (kfence),
> for example.
> Would such tests be candidates for inclusion in this file?
> Or is it only problematic when they start taking a couple minutes each?

I think we probably have to just play this by ear a bit (particularly
since how long something takes is dependent on more than the test
itself). Kfence seems (if you'll forgive the expression) on the fence,
to me. If something's much slower than kfence, I'd probably be
skeptical of including it, particularly if lots of such tests emerged.
But ultimately, the line here is "is this reasonable to run (a) in a
CI system, and (b) interactively". If it's consuming too many
resources on a shared system or the total testing time is more than
single-digits-minutes, we'd have to consider the value longer tests
are actually adding.

-- David

--00000000000028d86205de15bd52
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBc
YNtw5uWMDXGw/mLOYqK+yMlZHU8cUWpa2NUZ8AQfljAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA1MDMwNjM3MTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAl3+U6+hAtz/AH/zhWr4r
LJlY2LE+sNzIPBRFeyid3OjKXtBoqUP+HJFUxppwBcAPjr7+fjAYqJfrCihmDHIO2+j5bds1HGYs
HABuw1KsCfoK3J4mRG2aaA+mBqB3vl6T9ddER4V5ryQNlOR0HbhakTjUAQz0pZg671rYHdcjrmEe
U6LjnKcYmpvN1shlhT4ODonUelRd3oH2a0FVvvHrk8gnyedk4rnBo62ObanW5zpCX1JSyvp3tbI6
yHMowTffqRgeXZiYbn0/mynSefRLLFrujIiVAxAwDwsjJPnoRYblsL604Mq9y2OY2lXut5+udV1e
x0cCxVIbAKiZ7HLoMA==
--00000000000028d86205de15bd52--
