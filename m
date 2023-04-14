Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E96E1CBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjDNGgM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 02:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNGgL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 02:36:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC69A198A
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 23:36:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v6so16388378wrv.8
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681454168; x=1684046168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QtetKkT1JBDxGtVgVPHHkhb1HhaxmeW8oarXllUvvV8=;
        b=jpjm8dG/2vQqiVK5CPcwNr8twyvjpROlAdiQ2ViEnmtnhz75lBQASV0RVIzIHbJtW3
         w6AP/hs+peXXBacp3Ss1qsa61lNdmC2uIFVUyMn/IkaWpe35b72tBX0j1qlJcIUeaEmx
         BvcqyuDpwfgJfaDEdmhQf/x9Hz3uIBqLbqRCddYfE5UZPh8cXycChC6svZ0pSaV+e29a
         BICmZ7VLeYjiL5fdeHG3khv2AosEOAuQ1XFntCaVCmUHqvfDTfWdDlroa5jJYd41Vrq4
         w2fTr/J1etb8WvqukNQkXP5P49vSf1mUwGZXkSDKferj0LuF/cK7ZRTASr024wPtXh/6
         xjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681454168; x=1684046168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtetKkT1JBDxGtVgVPHHkhb1HhaxmeW8oarXllUvvV8=;
        b=CC+eFvxSGy2vAjPwHYk7cJKKV4UlJbQc00DdDlxGdDttKZ6Uux1a0w3TmQ6fdYsWci
         +SP0kCjimZSsnj0g8nOTG2F37LMPeCR/HH4w/MIG1x0/M9Psd+eYjU4YnxlssP8o6xQ9
         zLhLEM/vTL3623vKj3tI0ZUFc71Lv0EDHCjOe0qzbovPqecYZBIxK8Xz4zNPu2b4MJu5
         wiPy5Ic2EnZObGmhTiaDVVjQ2SgWJnZiSRtlp9izoNm9CgEHV2L+FsN2NdKfDlufOkvi
         mpRP68yDeBmLS8BKs1lFi+MJn9AqCXDWScsCyZVXv+XJewoBik4NYvZG/qpNgzi1SuFb
         aVrg==
X-Gm-Message-State: AAQBX9dzZKjfZP4o9SUIWnfQU+yGTQrtKC4szLHR30YKMt6iwVf3vJ+N
        RidSZ+QPAFi3T4JjfFtdpA9ZCjB92YwUpgj7DecJsg==
X-Google-Smtp-Source: AKy350Z6i9LfdgWDyPQJ+hRT2ZtSeDCgZf/oyzlkHsaXcg4mssO2iLiyKXuFYUxy05uFvD6zk3mxQq2a12HHAV71jzw=
X-Received: by 2002:a5d:460c:0:b0:2f5:cd2e:8ab1 with SMTP id
 t12-20020a5d460c000000b002f5cd2e8ab1mr821393wrq.2.1681454168133; Thu, 13 Apr
 2023 23:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230411160056.1586-1-michal.wajdeczko@intel.com>
 <20230411160056.1586-4-michal.wajdeczko@intel.com> <CA+GJov53J4WhXXUSrGDPZ-hqogL0eYOzaf_RgGQ1paj=_EtLUA@mail.gmail.com>
 <CABVgOSnyvEhgNyxqvJtu6ttXSdAB6t1SaN6-4SCmHYW25AKZoA@mail.gmail.com> <9f6977ec-372e-e2cf-e282-805b444d3ce4@intel.com>
In-Reply-To: <9f6977ec-372e-e2cf-e282-805b444d3ce4@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 14 Apr 2023 14:35:55 +0800
Message-ID: <CABVgOSkRz3UEH1mX0YtxXbfw+tWOGhoJ-qu664ox58vze9N_bw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: Update reporting function to support results
 from subtests
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006c091605f9460e6f"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000006c091605f9460e6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Apr 2023 at 21:15, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
>
>
> On 13.04.2023 08:31, David Gow wrote:
> > On Thu, 13 Apr 2023 at 04:28, Rae Moar <rmoar@google.com> wrote:
> >>
> >> On Tue, Apr 11, 2023 at 12:01=E2=80=AFPM Michal Wajdeczko
> >> <michal.wajdeczko@intel.com> wrote:
> >>>
> >>> There is function to report status of either suite or test, but it
> >>> doesn't support parameterized subtests that have to log report on
> >>> its own. Extend it to also accept subtest level results to avoid
> >>> code duplication.
> >>>
> >>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> >>> Cc: David Gow <davidgow@google.com>
> >>> ---
> >>>  lib/kunit/test.c | 28 +++++++++++++++++-----------
> >>>  1 file changed, 17 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> >>> index 5679197b5f8a..692fce258c5b 100644
> >>> --- a/lib/kunit/test.c
> >>> +++ b/lib/kunit/test.c
> >>> @@ -154,8 +154,14 @@ static void kunit_print_suite_start(struct kunit=
_suite *suite)
> >>>                   kunit_suite_num_test_cases(suite));
> >>>  }
> >>>
> >>> +enum kunit_test_or_suite {
> >>> +       KUNIT_SUITE =3D 0,
> >>> +       KUNIT_TEST,
> >>> +       KUNIT_SUBTEST,
> >>> +};
> >>> +
> >>
> >> Hi Michal!
> >>
> >> Since KUnit's goal is to progress toward supporting arbitrary levels
> >> of testing, I like the idea of starting to adjust these helper
> >> functions to allow for greater levels of testing.
> >>
> >> However, I'm not sure about this kunit_test_or_suite enum. If our goal
> >> is to support an arbitrary number of levels of tests then this enum
> >> still limits us to a finite number of levels. However, if we only want
> >> to focus on supporting parameterized tests (which is our direct goal),
> >> this could be the right solution.
> >>
> >> Maybe instead we could use an integer denoting the test level instead?
> >> This would remove the limit but would also remove the nice names of
> >> the levels.
>
> we can use integer as param but at the same time we can also have define
> or anonymous enum as nice aliases to currently known/used levels:
>
> /* Currently supported test levels */
> enum {
>         KUNIT_LEVEL_SUITE =3D 0,
>         KUNIT_LEVEL_TEST,
>         KUNIT_LEVEL_PARAMTEST,
> };
>
> /* Future levels are TBD */
> #define KUNIT_LEVEL_SUBTEST(n)  (KUNIT_LEVEL_TEST + (n))
>

This sounds good to me!

> >>
> >> I'm curious what others opinions are on these ideas?
> >>
> >> A bit of a nit: if we do use this enum I wonder if we could clarify
> >> the name to be kunit_test_level as the current name of
> >> kunit_test_or_suite seems to indicate to me a binary of two options
> >> rather than three.
> >>
> >>>  static void kunit_print_ok_not_ok(void *test_or_suite,
> >>> -                                 bool is_test,
> >>> +                                 enum kunit_test_or_suite is_test,
> >>
> >> Similar to above, I think the name of is_test could be clarified. It
> >> is currently a bit confusing to me as they are all tests. Maybe
> >> test_level?
>
> ok
>
> >
> > I agree with Rae that this is not the ideal long-term solution.
> >
> > We're basically encoding two things here:
> > - Are we dealing with a 'struct kunit_suite' or a 'struct kunit'?
> > - How nested the test is.
> >
> > Given KUnit originally only had a 2-level nesting (suite->test), and
> > now has 3-level nesting (always suite->test[->param]), this works, but
> > the KTAP format permits arbitrary nesting of tests, and we'll want to
> > have something like that in KUnit going forward. We don't have a
> > design for that yet, but it could conceivably allow nested suites,
> > thus breaking the rule that nesting level 0 is always a suite, and the
> > rest are all tests.
>
> I guess "We don't have a design for that yet" is a key here

Yeah: I wouldn't worry too much about what the future design would
bring, tbh. As long as we don't totally paint ourselves into a corner
(and I don't think anything in this patch is at risk of doing that),
then doing whatever is sensible for the way things are now works.

>
> >
> > So there's definitely a part of me that would prefer to pass those two
> > pieces of information in separate arguments, rather than relying on an
> > enum like this.
> >
> > That being said, this is all very fuzzy future plans, rather than
> > anything concrete, and this will all likely need reworking if we do
> > anything drastic anyway, so I'm not worried if we go with this for
> > now, and change it when we need to. I do think it's an improvement
> > over what we're doing currently.
> > (For example, another possible implementation for nested tests could
> > be to get rid of the distinction between tests and suites completely:
> > or at least have them share 'struct kunit', so this wouldn't need
> > passing in separately.)
>
> maybe the problem will go away once we just replace this untyped param:
>
>         kunit_print_ok_not_ok(void *test_or_suite, ...
>
> with proper type:
>
>         kunit_print_ok_not_ok(struct kunit *test, ...
>
> and treat NULL as indication that we just want to print raw results (as
> it looks function is not using any suite attributes directly, all input
> is passed explicitly and kunit_log() expects test only)
>

Yeah: I think that makes sense. Suite results are still handled
separately in debugfs as well.

Cheers,
-- David

--0000000000006c091605f9460e6f
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDI
weFsrO61HkDFzHMzjq342WvkTDYPp+jk7kWygU7hzDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MTQwNjM2MDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAPQbbdVdRNJCITGonBTO0
+FUZZrfjQnXufxExsWDuh9pT1i5oW5MY40jLKiiX0Kg+hA6Pta05rltcGALHUFpMMKs+e1g2v0Mh
WQhuW7Ta9ywQ3jfkqbhcRfPrx+JAB2vR9aj15zpyDOdhGryYmfibi55dgAXdIpATvDZ/RFIxuAD0
013tateRVtgjGr0mHNRp7HNlE9yRjbxFO5TtOMoSXeyBriAFxXgU1Jg5Gy0xl48pLqwfZrJWIKow
kdnFF1Y5Nqcf14/dHTublca7SqTdiplCdRPZ+t/ek3l5hZLTdlWVAJCsLVmeXJ5AeJUAtB+yQd1j
IGWKeq6qGkSSjIEEKA==
--0000000000006c091605f9460e6f--
