Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ED96C7804
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 07:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCXGe6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 02:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjCXGe5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 02:34:57 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5AA1B545
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Mar 2023 23:34:32 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j7so1005763ybg.4
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Mar 2023 23:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679639672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LvOi8WUvRS4ulUFxzqLp4ezEMk7FOBVx68zKVKtYTCU=;
        b=LXcx5a5pF2wpZVZxGqIli5kOfK0V0OmqsCmojl/gSC1HRjIfFwaLq543rLqhDIa9gZ
         bFX/y+RI3zwjsNTJM8EXcR8/oGXKhxlilZzsfEJAp+/HnaUgkGvmA3Q9Ny07tvUP4e4w
         TT45ytTObW4X0EfQ/nNh/8RsC75DkTxCgEp22Jr5w1kzh2iGeeQailhB4mQQrdRKtroA
         A9zNDTNuQy3JJSBZqOClrITNvZEtqx+4Nv3/yOCUM953YoSSpifBf/YlOAeuNF2dIw5m
         Tfv90rbC9xo2NW2yMRNtpWpcFITmJ6fDxI8K7kzNVR+szYm0hnTc4ZJqDyCLhhzef2OI
         fn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679639672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvOi8WUvRS4ulUFxzqLp4ezEMk7FOBVx68zKVKtYTCU=;
        b=CItT7qgzsty5o7pOwOVNaPccRi59Aic+noytwa3v2B5JCJ+YNCjBh0Nm0Uj5QfKmaj
         yo07gDZCDUzLV4d8ZbzsPGBS3P9HH0wyA/W1Gb9+RZk/zym1/7z0mEYBH0fPlVgV+7JP
         xbe7BU1dtKkutU2iKSH7rKz+M3YB4bvYpZisRAjL83o8G//z16mzxbN4FoWCBBieBDnI
         FMH8ArCeQEenI9MXaHbdgs9AljQutxjSjAs2GQPgjueCWKh/iRTPrjTJCk+R/KiLfZq2
         tjp7/y8rRSyO9H5AOzpS3mftWqdklroVdcjSUg0izd/SrQ930KsTdGYRq33uHRN0PRR+
         nIpg==
X-Gm-Message-State: AAQBX9eH8kv3ubOxhFyLkCsR7KLrKxZP56uOxmrvCKwTXAjv/xfk2WFh
        Zgde0b4Q+6CeMIRlzDI59nuybGaMRA8jvqqtBW2QpA==
X-Google-Smtp-Source: AKy350akey46vO/29yZJ09UctkZycjISDVnjzOikdoJnNjgVlZdk9miYsI24cwUI7xvpPU2bo1kyZUFZev+jJeyURBo=
X-Received: by 2002:a05:6902:168d:b0:b6c:2d28:b3e7 with SMTP id
 bx13-20020a056902168d00b00b6c2d28b3e7mr714718ybb.9.1679639671817; Thu, 23 Mar
 2023 23:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com> <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com> <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com> <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat> <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
 <20230323163639.xtwpid2uunwnzai4@houat> <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
In-Reply-To: <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 24 Mar 2023 14:34:19 +0800
Message-ID: <CABVgOSnMeoRzExfqsjC_zAX_=TyqpAFuiGD6NWkus7+2Rdho4A@mail.gmail.com>
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
        boundary="000000000000030a1605f79f96a3"
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

--000000000000030a1605f79f96a3
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Mar 2023 at 14:11, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> On 3/23/23 18:36, Maxime Ripard wrote:
> > On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:
> >> On 3/23/23 14:29, Maxime Ripard wrote:
> >>> On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> >>>
> >>> This is the description of what was happening:
> >>> https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/
> >>
> >> Thanks Maxime. Do I read this correcty. The devm_ unwinding not being done
> >> when root_device_register() is used is not because root_device_unregister()
> >> would not trigger the unwinding - but rather because DRM code on top of this
> >> device keeps the refcount increased?
> >
> > There's a difference of behaviour between a root_device and any device
> > with a bus: the root_device will only release the devm resources when
> > it's freed (in device_release), but a bus device will also do it in
> > device_del (through bus_remove_device() -> device_release_driver() ->
> > device_release_driver_internal() -> __device_release_driver() ->
> > device_unbind_cleanup(), which are skipped (in multiple places) if
> > there's no bus and no driver attached to the device).
> >
> > It does affect DRM, but I'm pretty sure it will affect any framework
> > that deals with device hotplugging by deferring the framework structure
> > until the last (userspace) user closes its file descriptor. So I'd
> > assume that v4l2 and cec at least are also affected, and most likely
> > others.
>
> Thanks for the explanation and patience :)
>

Thanks from me as well -- this has certainly helped me understand some
of the details of the driver model that had slipped past me.

> >
> >> If this is the case, then it sounds like a DRM specific issue to me.
> >
> > I mean, I guess. One could also argue that it's because IIO doesn't
> > properly deal with hotplugging.
>
> I must say I haven't been testing the IIO registration API. I've only
> tested the helper API which is not backed up by any "IIO device". (This
> is fine for the helper because it must by design be cleaned-up only
> after the IIO-deregistration).
>
> After your explanation here, I am not convinced IIO wouldn't see the
> same issue if I was testing the devm_iio_device_alloc() & co.
>
> > I'm not sure how that helps. Those are
> > common helpers which should accommodate every framework,
>
> Ok. Fair enough. Besides, if the root-device was sufficient - then I
> would actually not see the need for a helper. People could in that case
> directly use the root_device_register(). So, if helpers are provided
> they should be backed up by a device with a bus then.
>

I think there is _some_ value in helpers even without a bus, but it's
much more limited:
- It's less confusing if KUnit test devices are using kunit labelled
structs and functions.
- Helpers could use KUnit's resource management API to ensure any
device created is properly unregistered and removed when the test
exits (particularly if it exits early due to, e.g., an assertion).

I've played around implementing those with a proper struct
kunit_device and the automatic cleanup on test failure, and thus far
it -- like root_device_register -- works for all of the tests except
the drm-test-managed one.

So if we really wanted to, we could use KUnit-specific helpers for
just those tests which currently work with root_device_register(), but
if we're going to try to implement a KUnit bus -- which I think is at
least worth investigating -- I'd rather not either hold up otherwise
good tests on helper development, or rush a helper out only to have to
change it a lot when we see exactly what the bus implementation would
look like.

> > and your second
> > patch breaks the kunit tests for DRM anyway.
>
> Oh, I must have made an error there. It was supposed to be just a
> refactoring with no functional changes. Sorry about that. Anyways, that
> patch can be forgotten as Greg opposes using the platform devices in
> generic helpers.
>
> >> Whether it is a feature or bug is beyond my knowledge. Still, I would
> >> not say using the root_device_[un]register() in generic code is not
> >> feasible - unless all other subsytems have similar refcount handling.
> >>
> >> Sure thing using root_device_register() root_device_unregister() in DRM does
> >> not work as such. This, however, does not mean the generic kunit helpers
> >> should use platform_devices to force unwinding?
> >
> > platform_devices were a quick way to get a device that would have a bus
> > and a driver bound to fall into the right patch above. We probably
> > shouldn't use platform_devices and a kunit_device sounds like the best
> > idea, but the test linked in the original mail I pointed you to should
> > work with whatever we come up with. It works with multiple (platform,
> > PCI, USB, etc) buses, so the mock we create should behave like their
> > real world equivalents.
> Thanks for the patience and the explanation. Now I understand a generic
> test device needs to sit on a bus.
>
> As I said, in my very specific IIO related test the test device does not
> need a bus. Hence I'll drop the 'generic helpers' from this series.
>

I think that sounds like a good strategy for now, and we can work on a
set of 'generic helpers' which have an associated bus and struct
kunit_device in the meantime. If we can continue to use
root_device_register until those are ready, that'd be very convenient.
Certainly, the helpers I'm playing with at the moment have a few other
dependencies I'd want to land first, so I suspect they wouldn't be
done in time for 6.4. It'd also make sense to see if we can make sure
any such helpers could either work well with (or at least not conflict
with) tests which use devicetree.

Regardless, thanks very much for putting all of the effort in to
working this out. I think we have a much better idea of the
requirements for this sort of thing now.

Cheers,
-- David

--000000000000030a1605f79f96a3
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA3
+sOL210qxSx5STnjTd6QSEsaRlt9rZ2yITo8+qEfiDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMjQwNjM0MzJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEACQn9Yx4d3EXFqegtTKXA
gcAE2q6mU49cGRFMctNVwzZG9nJ6Q59lSBBucMkmt3+vn6w7xcL667t7EYI5qrlUEdOsdfSiHSrj
qUsUFscA0P/WRd4D8DGSz5dWihr5NVxeqcSppF3GULYhVH9q51NbEFpreLh67k9cLdjWSss8iYqv
pnu27jkXYqxrNXO+dwFRzdUE3f7dvdm2/sO6K8oKS4QTVjd7SJU95cVYnmEXovM3U2qswYGx/9NN
SlZiBjHCZV8ToB8wHu/gxTc0uiPZa8xPZ18Z6AKmpjunccf12p8HLSkHBJ1UVTDcw3C2l69W8AYX
otaCwcffT7NpPHKWrw==
--000000000000030a1605f79f96a3--
