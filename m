Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8566C8AE8
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 05:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjCYEgL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 00:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCYEgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 00:36:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2D8CC15
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 21:36:08 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p15so4602836ybl.9
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 21:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679718967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1LGR/3TY22nb3vOMnqAoBqOOCf+dssWyMgD/QwtIg5w=;
        b=D/671zKjcgW/MBPT2S74HqN3JwGVE+hTDMpvhYtvoVnp+kDpEhxgCqrTh7p10+tED3
         JpkOgySVyL3nLr6Stffo655D8W5pVAcHl8IbdgMd7PYSInwNIfc9+/glpr6Afswcda54
         bVDfoJhHnXeULaEmZDbXbnkts/4lOpn01RCfPherH3YvWq2t5kanueoqbLBJYtyJPqvH
         ld07zhHJI7Gx1SMm1lNxabjqsRMmiiCBv2Cy+8VFY1izFyKiFWaYagWhWkuJvHpFI7s/
         4SHVn9Pkgwu34+4EbSdXnAvq7T+Ftiv/la+P2VoElRH/3Eji8nlL8UET7+Fh46WEjyuS
         ZyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679718967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LGR/3TY22nb3vOMnqAoBqOOCf+dssWyMgD/QwtIg5w=;
        b=QwFFyGB/XCxDvsVB1/W5Dw7dZxeuOtAaEyqj58+mlp3tNNQie1J1gJSH2bcaEk7fLd
         klGRhf6JkimkXHHmt5SBT7RnVxEgUi8Q/U8qjD/V7NttiwnV3575j+uzNr98aJlTO17H
         9xMly7WgtB1ikAjEOFe5Ccz1cwj9WPcbbKeDwwxHgHFqLX3FfeI3kN4GsJCYwWWgfgu8
         l6BlbPHtOxingIrXoyszr2BBVh5SVL3j9yWpPbslAJu7+SFQx8jTNB3jNaUV+PsMChEG
         U5ku0vxORtGDIZffPY8XyFQkLxuAJw42ZVcys6WKQ/8DAmUd4ln7lb3QASiLdY13w85K
         8A/w==
X-Gm-Message-State: AAQBX9fbU3xSPu5vzyXZYtBo3rJK1ZAsNmbvQ126alEFzvZqPradDCXs
        2EAYjwIqQcAzej1CbXXhe4E14Smc7oQt+naVurYYmA==
X-Google-Smtp-Source: AKy350ZA1tsJJCczN1fZoEr1fh2uGGJzV+WPjwDldeelA3fCcGCnhFltIqPP+3hUsj0Zt6M+f4rxMpQLLxR4Zyn+6AI=
X-Received: by 2002:a05:6902:1507:b0:b78:8bd8:6e77 with SMTP id
 q7-20020a056902150700b00b788bd86e77mr1266735ybu.8.1679718967170; Fri, 24 Mar
 2023 21:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com> <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com> <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com> <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat> <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
 <20230323163639.xtwpid2uunwnzai4@houat> <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
 <CABVgOSnMeoRzExfqsjC_zAX_=TyqpAFuiGD6NWkus7+2Rdho4A@mail.gmail.com>
 <97f60824-7067-62cc-2882-d998072886ce@gmail.com> <CABVgOSmx3A4Vwos2_8xO-XQrQAw5gvY0nc5zLpLmcJ7FtA-dTQ@mail.gmail.com>
 <f0b4d2ad-9635-9ab8-7cd7-bfadded94714@gmail.com> <a02044e7-3210-a0c2-ceda-8c19fadd237a@gmail.com>
In-Reply-To: <a02044e7-3210-a0c2-ceda-8c19fadd237a@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 25 Mar 2023 12:35:55 +0800
Message-ID: <CABVgOSmSEYRqxTXCEttZvpE33euxvRYE-3scZ8DrOSibeZW=bg@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device creation
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000061de2505f7b20ce2"
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

--00000000000061de2505f7b20ce2
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Mar 2023 at 18:17, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> On 3/24/23 12:05, Matti Vaittinen wrote:
> > On 3/24/23 11:52, David Gow wrote:
> >> On Fri, 24 Mar 2023 at 14:51, Matti Vaittinen
> >> <mazziesaccount@gmail.com> wrote:
> >>>
> >>> On 3/24/23 08:34, David Gow wrote:
> >>>> On Fri, 24 Mar 2023 at 14:11, Matti Vaittinen
> >>>> <mazziesaccount@gmail.com> wrote:
> >
> >>>> I think that sounds like a good strategy for now, and we can work on a
> >>>> set of 'generic helpers' which have an associated bus and struct
> >>>> kunit_device in the meantime. If we can continue to use
> >>>> root_device_register until those are ready, that'd be very convenient.
> >>>
> >>> Would it be a tiny bit more acceptable if we did add a very simple:
> >>>
> >>> #define kunit_root_device_register(name) root_device_register(name)
> >>> #define kunit_root_device_unregister(dev) root_device_unregister(dev)
> >>>
> >>> to include/kunit/device.h (or somesuch)
> >>>
> >>> This should help us later to at least spot the places where
> >>> root_device_[un]register() is abused and (potentially mass-)covert them
> >>> to use the proper helpers when they're available.
> >>>
> >>
> >> Great idea.
> >>
> >> The code I've been playing with has the following in
> >> include/kunit/device.h:
> >>
> >> /* Register a new device against a KUnit test. */
> >> struct device *kunit_device_register(struct kunit *test, const char
> >> *name);
> >> /* Unregister a device created by kunit_device_register() early (i.e.,
> >> before test cleanup). */
> >> void kunit_device_unregister(struct kunit *test, struct device *dev);
> >>
> >> If we used the same names, and just forwarded them to
> >> root_device_register() and root_device_unregister() for now
> >> (discarding the struct kunit pointer), then I expect we could just
> >> swap out the implementation to gain the extra functionality.
>
> There's one thing though. If the goal is to do a direct replacement and
> if automatic device deletion upon test completion / test abort is
> planned - then it should be there also for these initial wrappers.
>

Yeah, that's an excellent point. It's a pretty subtle change in
behaviour to suddenly introduce that, so changing it behind the scenes
is probably unwise.

> If these wrappers don't yet include the automatic device clean-up - then
> it probably makes more sense to just do the kunit_root_device_* defines
> because the tests are likely to need removing the explicit device
> clean-ups when proper APIs are finished.
>

I sent out my prototype implementation of this here, which does do the
automatic cleanup:
https://lore.kernel.org/linux-kselftest/20230325043104.3761770-1-davidgow@google.com/T/#mf797239a8bce11630875fdf60aab9ed627add1f0

It's probably overkill to squeeze into your patch series, though,
given it also adds and uses a whole new kunit_defer() API.

Cheers,
-- David

--00000000000061de2505f7b20ce2
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCZ
lBSn63TGN6G01s8BjINnNF4Sa2CA1RRE/5o+Nl4jxzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMjUwNDM2MDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAnizs2i5DBmLkHbFHwmmO
sMrmGHzQyfMyLwojI3vnVjRrb58CljKEJj7MZR5UonFS9xGrTrfz9rtQ8vwqxg12i425ZT+uP+FT
ccCsQRUTXdxjppwrgoPYAGh2ipXoUBMXO322FJPFpIQG28K78TwAAXx3HdAYoXv/JLLEovFqlE+p
2M99kIf5px3dYaCTsz6bHZQtDd5R8UT3iO5M2g+3O0zRsraUiRfqfzSzfYIMu4AtdnGz0vraqNQ9
wSnp5lSxkj++TDiobOujxMnBDGvhKcOYRWuoyRUcoXlAgwvV0rwJ+16wn0Whw8YIsntUUpCmtmK1
7BkxwEpE1YGk6FTaqQ==
--00000000000061de2505f7b20ce2--
