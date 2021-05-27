Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2344392966
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 May 2021 10:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhE0IXE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 May 2021 04:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbhE0IW7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 May 2021 04:22:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483B7C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 01:21:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g17so3561611wrs.13
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lFoVRWeyLX+dqy8VeUNCKkFZhuwgTmc/BzN/bZM2cE=;
        b=RgYdthoA0ScLIlGKF3eJ929l7/wsL1haeieEmRQz/WcL7s8EOqICPaxanyW4IOu79X
         NOiSf4PveTH7xlItQ4TmFHW0D3nmI659pJU0WfRsVlWa/tkHk+BMVVZ77jcQUs+A8Xib
         KkE4gN4spkBYDkZxuP+SyDtbdt2EWZgDqMSvOsi3TWzAJ5fcjCA0P0g2F9Q3VniqP6Ab
         KS8f+91xg/TZ15gK86hletjRrS7dx7j05zxThwMRFD6viRqW5oe+c9DHpcIPQ3rMTSs/
         DYKlYDOhoIOuXza44N+j4KZTGLcJqBkFWuugni84H4MsfBR6+Wr0134+FCjFS0JU5M6Z
         jy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lFoVRWeyLX+dqy8VeUNCKkFZhuwgTmc/BzN/bZM2cE=;
        b=odIfz1/GJn6PqsCwZ8eyZuwqgnxJbtdI7zXf1iwMd/By8ebz++YTjiUV7I9FO05ELR
         6DPHEzgo1l7BO0E3c65SOzlAgVbFqL+t8BxvzXv4HOxygxGRzgTpb+LrS1gsSgjtMF4C
         BO5Iof1Hv3Utki1AxLjC5VgVlHHURiHSNSuwY/jpi44rVrShFQh5B6LzYj1vgr1qcBm1
         544305h3ZT4Nl6ID9Gc1Fx3ZDGbUW7s3T9q3khcuYDOczX09eAzeiUvM0z2Mv7cPQjCb
         /rjPNlnF97b5Gll3ONkig1cMfOANq8+FBYM2awS6NjiQiJn97O755AXJcEHviYgAU8xU
         OMww==
X-Gm-Message-State: AOAM533VrY4WM3AqW0S+renwTT3CwCH3DC5TpwhcOfftbDXtQ+7RbhNn
        10RaPE4rrItruxwqzUu+UXvKhlkeR+lrqcolkT7BUw==
X-Google-Smtp-Source: ABdhPJyg2wJBf7588Oc1C997d8EIOPaI3sLBMPTLIhAgA44ACm8OC1fTBtxHQHLQ71XpfqMV4YTCfnxqElZZpIyCOvM=
X-Received: by 2002:adf:e58d:: with SMTP id l13mr1993501wrm.369.1622103684759;
 Thu, 27 May 2021 01:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210526081112.3652290-1-davidgow@google.com> <20210526081112.3652290-3-davidgow@google.com>
 <YK4NRlyrYJ8ktsWQ@elver.google.com> <CAGS_qxp=EV1iy5tCs+YpxH-Pug=MDTBXo3jSc13-h7HJnzBnDA@mail.gmail.com>
In-Reply-To: <CAGS_qxp=EV1iy5tCs+YpxH-Pug=MDTBXo3jSc13-h7HJnzBnDA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 May 2021 16:21:13 +0800
Message-ID: <CABVgOS=Lu4YwmnvmvcnAUS9YyANf6rW3px3ZEAyrL2hOo=bpUw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: test: Add example_skip test suite which is
 always skipped
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f02ef805c34b7153"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000f02ef805c34b7153
Content-Type: text/plain; charset="UTF-8"

On Thu, May 27, 2021 at 2:29 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, May 26, 2021 at 1:56 AM 'Marco Elver' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > On Wed, May 26, 2021 at 01:11AM -0700, David Gow wrote:
> > > Add a new KUnit test suite which contains tests which are always
> > > skipped. This is used as an example for how to write tests which are
> > > skipped, and to demonstrate the difference between kunit_skip() and
> > > kunit_mark_skipped().
> > >
> > > Because these tests do not pass (they're skipped), they are not enabled
> > > by default, or by the KUNIT_ALL_TESTS config option: they must be
> > > enabled explicitly by setting CONFIG_KUNIT_EXAMPLE_SKIP_TEST=y in either
> > > a .config or .kunitconfig file.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > ---
> > >  lib/kunit/Kconfig                   | 15 +++++++++
> > >  lib/kunit/Makefile                  |  2 ++
> > >  lib/kunit/kunit-example-skip-test.c | 52 +++++++++++++++++++++++++++++
> > >  3 files changed, 69 insertions(+)
> > >  create mode 100644 lib/kunit/kunit-example-skip-test.c
> >
> > I don't know if this test is useful for a user of KUnit. Given it's not
> > testing KUnit functionality (I see you added tests that the feature
> > works in patch 1/3), but rather a demonstration and therefore dead code.
> > I don't think the feature is difficult to understand from the API doc
> > text.
> >
> > Instead, would it be more helpful to add something to
> > Documentation/dev-tools/kunit? Or perhaps just add something to
> > lib/kunit/kunit-example-test.c? It'd avoid introducing more Kconfig
>
> I'm in favor of putting it in kunit-example-test.c as well.
>
> But I hear there was pushback to have a non-passing test in the example?
> I guess the fear is that someone will see something that doesn't say
> "passed" in the example output and think something has gone wrong?

Yeah, (a simpler version of) this was in kunit-example-test.c before.
Brendan brought up the question of if a test which skips all the time
is useful in [1], but that was more in the context of this being a
test of the functionality than an example. The other part of this did
grow out of the discussion for whether skipped tests should be treated
as 'ok' or 'not ok' in the KTAP spec (somewhere in [2], probably), and
whether or not a test being skipped was indicative of something going
wrong.

Ultimately, I think there's some value in having an example test
that's skipped, and if people are okay with it being in the example
suite (and therefore enabled by default), I'm okay with the default
KUnit run having a splotch of yellow amongst the green in the
kunit_tool output.

> Hence this more conservative change.
> But I hope that in the absence of any replies in opposition, we can
> just keep one example-test.c
>

Agreed, I'll put this back in the existing example suite for v2: if
there's any great opposition, I can always move it back.

> > options at least.
> >
> > Thanks,
> > -- Marco
> >

Cheers,
-- David

[1]: https://lore.kernel.org/linux-kselftest/CAFd5g47auKoQPhCeMHSTMtE_9+fZ6eOHZkojV5j0AX4N4hE_pw@mail.gmail.com/
[2]: https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/

--000000000000f02ef805c34b7153
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnAYJKoZIhvcNAQcCoIIPjTCCD4kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz2MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
ILbFHw0h01NI0v+AeczGMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwgZoGCCsGAQUF
BwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
bS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouseLHIb
0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCNr3LBERPjVctGdVEb
/hN6/N6F2eUWxZLSUbuV7fOle0OvI8xz2AUBrOYQLp94ox9LqmsATKPsBl2uiktsvfs/AXNMcmOz
qsWHzfqp4XlvNgQsC/UyUMWxZoEyTDfTSat09yQjkFJ7viwzrqqscmTx5oTZz8TPRt0mbxwx3qry
wDzYxadSUQXNpNnfi0FBDYUUfuCLFWPsPsAXmgh483u0RbNik9OY/ozNq1Gvg/U0jQOlJf2IiKbE
kUL5Vq8gDDu6bETx5bHmRmSjHhwo7eVbxywczpzdFsU3dauZ3BzqhLy2pRGGzZybSH/3mf7o9y15
gmRHE7WzPLrsULHG/TM8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAyMDIw
AhABm/kO+4pd09krN7Fjk8ypMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDqcNCU
AWa7en8eAla3wTqC5t63SGadZxpPjh5mutjTvTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMTA1MjcwODIxMjVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAi/gLWKtMciKAA97VP1EhUwg9
1rYbxZiceU/WQFc5AdeRHtgouzNgOJuG2j4dK/QzAsPQ+tQAnvszKNgrPxgulJBSOXR8nKkGB3zK
YurB5ZVdvyOL5XjUa3ehSmadzNNvoLFvaAuUpTSkbTNijtbQ7r3Hy21rR/2Y/NbfqOqUT/c+Mjmb
KvhbzkTLOV0iNgvfdCS0Ri+aLJCd9gKHK/4YB0ossb9OFIUUe/gb5XY4cBwMDDOKla9+QXtNOAmc
oLr72iptfERhddDrOk4TtI/e0JagqOgljWLtGkVkROYgIud/tDfmJ+efSqqa1WVCTkYlItIKPjJf
WnZdsmy3yvXi2A==
--000000000000f02ef805c34b7153--
