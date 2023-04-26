Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC526EEE8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 08:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbjDZGwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 02:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbjDZGwJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 02:52:09 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACED62D7E
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Apr 2023 23:51:58 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3ef31924c64so317761cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Apr 2023 23:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682491918; x=1685083918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6b2OuXWTmTqsbPgpr8Y3OIWx5QThEiO+WS9T1s3oGhY=;
        b=NbWiM8kMr6gEX/990z5bTsWBIRAmZheHcfWfeVddxI6Mt1Y/L3vck3vzjX/JqFE+oV
         5CaxmPR1YniGElqyUdHkeyXM+OS9rHmHEVhRBqp96Wn0W2YbObOsZp5GdFcMEy5qgjXx
         jImDbP36dth0oi5pMl5VTb8czY9RcYCGJzBVGD3Hv/eMT5kGyvsiJMaP6zj94AO6ZOLO
         FSeQnMKqaZQXHy0qLTxcCAyt4gV8t2+oxLHg1W7IaZybZDyTG0OllXva9cgoEADfZH2h
         +R84lHW9uysSep2bfH+gsW4XeZ4skY5h9LvxFGXg1ydtSW8/L5IHSvtouNOMDHyC13zD
         plBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682491918; x=1685083918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6b2OuXWTmTqsbPgpr8Y3OIWx5QThEiO+WS9T1s3oGhY=;
        b=j3Hibd2Nx/UJjc5F5ltK24cQloB6j6CPD0fD4QzNfSl20MtRR99VhlEeGJ/euQY8CW
         iakAoHT1FU0p4YgyYudtJ7ImsKmN0A9mqWbGyxe7XQFd6eUqYFbBN/oTvjCvT+COXaju
         6iAt/ykjQTo5EOxNBKo/S7CpKeNlhkcRptW0XiYJuFKP/EwTOsbBh894zcuXgKJgCUnX
         qBAqgdqHccegMJy4l59aZRmI9Po+I48sNEnx2O7uBQziqE0SobW/1xBay24pgdZzf6/c
         6XA/eQpTG0k3S1TGCK1Y7DnRHbZ+XmEDUApGGvNGbGfQ0xYcvO+FCnsouAlpoYMRM+1t
         OUjw==
X-Gm-Message-State: AC+VfDyv4tvuDKz3jKvpUosNw5y3j5akEJzhK8OXKGUpx709TGlnS5Or
        6qwf4iREN/MbikHUmbjyIzRgcmJ/6iYkXfPGOFHxNQ==
X-Google-Smtp-Source: ACHHUZ65QRA+WH2ViYNCiho5VWgtJE4TC91Nkqqj+oOyCYpHaQiXotsbWAsk2qVd2rjv+LsSaYe6KNu2V9kYs9nTiYQ=
X-Received: by 2002:a05:622a:1ce:b0:3ef:31a5:13c with SMTP id
 t14-20020a05622a01ce00b003ef31a5013cmr165018qtw.3.1682491917727; Tue, 25 Apr
 2023 23:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230421084226.2278282-1-davidgow@google.com> <54b49d4ddf371d0581f3b795f50f7f6673557a96.camel@sipsolutions.net>
 <5a820cf9aae169e18635a8c867835817a50892b0.camel@sipsolutions.net>
In-Reply-To: <5a820cf9aae169e18635a8c867835817a50892b0.camel@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 26 Apr 2023 14:51:45 +0800
Message-ID: <CABVgOS=ca71mj=qsPBvji-iTf-QsjDrxGzOymVGBJj8oHaJzWg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] kunit: Deferred action helpers
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001c35b205fa37adf4"
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

--0000000000001c35b205fa37adf4
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Apr 2023 at 22:02, Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> Hi David,
>
> On Mon, 2023-04-24 at 14:32 +0200, Benjamin Berg wrote:
> > On Fri, 2023-04-21 at 16:42 +0800, 'David Gow' via KUnit Development wrote:
> > > This is v1 of the KUnit deferred actions API, which implements an
> > > equivalent of devm_add_action[1] on top of KUnit managed resources. This
> > > provides a simple way of scheduling a function to run when the test
> > > terminates (whether successfully, or with an error). It's therefore very
> > > useful for freeing resources, or otherwise cleaning up.
> > >
> > > The notable changes since RFCv2[2] are:
> > > - Got rid of the 'cancellation token' concept. It was overcomplicated,
> > >   and we can add it back if we need to.
> > > - kunit_add_action() therefore now returns 0 on success, and an error
> > >   otherwise (like devm_add_action()). Though you may wish to use:
> > > - Added kunit_add_action_or_reset(), which will call the deferred
> > >   function if an error occurs. (See devm_add_action_or_reset()). This
> > >   also returns an error on failure, which can be asserted safely.
> > > - Got rid of the function pointer typedef. Personally, I liked it, but
> > >   it's more typedef-y than most kernel code.
> > > - Got rid of the 'internal_gfp' argument: all internal state is now
> > >   allocated with GFP_KERNEL. The main KUnit resource API can be used
> > >   instead if this doesn't work for your use-case.
> > >
> > > I'd love to hear any further thoughts!
> >
> > I am happy with it as-is.
>
> Oh, wait. Nothing big, but I just noticed that the new API functions
> seem to not yet be exported using EXPORT_SYMBOL_GPL.

Ah, nice catch! I'll add those to the next version.

Cheers,
-- David

--0000000000001c35b205fa37adf4
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDE
nnWr2Q7B6h+p2p5/j0St/ZSYCpEhhr61wyLxpVkALDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MjYwNjUxNThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAFpVMILgcXbghKLx/GWfu
rnJs7qNFUppnpiiYCPh+9v9StVg2coG6sZIjyXN2C03flhu4XvuCWW9VkrOyPYzEfu5855kud3ui
kQAVveJwKujiWhOnNNxTAM0yhHLEVmHXNikpRF34bP+VaNYepSdVrfPW2glIaTDmBlkcHmfg3Q2/
gyDuV/IKTQA8X7LYClpfmg4TzHa0PIqcX1zp+E/4NANY9hi+3uNqCKVG1nGaHgf06lBByn2JbtA3
P2uRfDbF//PPtXaiM6vlQXiUXPs5/n4WfIBfxvT2kzgUZuT2Qtj0NdpnUvJX4AeNy7k2QyUP5gqf
bKKbSJNY7RrTQdj1kw==
--0000000000001c35b205fa37adf4--
