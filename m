Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30746C8B1E
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 06:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCYFkQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 01:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYFkQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 01:40:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A308F1A493
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 22:40:14 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id j7so4710076ybg.4
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 22:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679722814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vCFFjxpa7SQYk1+iNVjgu/pUnF5Zhw7rxtNfabw5XOI=;
        b=nt2xII3MztVl5yTM5uAH7ye5AOadiaS73XPyHqm5FRR/rmN2AvoLBorNyMwYf7ZrUP
         oC8IxPUCELMEwHPqxApCPRn0+iKwwvGNMLfolKvQJYEoRg1C3UHSoesn/GTAYQzbosuq
         0yb2RvcVin5isrn4cGM2bNoNgG6tKT30NJ2t71MvcisKIKA/WTtCKpq//iwyqRP8NJYv
         kwWmUP/SVF8vyaSqIaaBLW7QrDxvz0nckeVlkiVpkb2qvI2gpu6YBZmkHS2h5fAQ3vVb
         6D8spfT9DEEA2Y681pOPv1tMWGQFTz5IOi4Wd1GsPBQR4M0SZBCKZ2akEqz0Roe6YwJd
         KAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679722814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCFFjxpa7SQYk1+iNVjgu/pUnF5Zhw7rxtNfabw5XOI=;
        b=nrFCdNcMPt/iNSrPcB5/Pme7Ko9ftc1baR30F7ZUMLegT74MY0dWjvR1lGD6P0dRH7
         k+1y6SsaJYNFtn0ln5BSB4r3/rSSNgLbz6WsxxsbRezCzTFEJJfOBbWhGhu+mghgGMrZ
         NNG+JNZbUuGoHzqh3PKwTm79GlfIPNRmoNztND4x61bvMKnuUi9oFilGGD99m9mrDoZ5
         dlaZn6r/+mhXsVLH56ONEUBXRfU0JsD6AHTXwnpJhzEy7bwK6eFKDzK588fogM1Olj2/
         nsZlYAbTP14pjPYDkcLQHc6TLjaO3yzRIAzRx6tC85/J2STvLhLVYeiOLTjbM2FiBSDT
         c7hw==
X-Gm-Message-State: AAQBX9fzneWFTppc/eWI9knlQiF7Z5dX2Qrs4cw91q4trkXA+pVmYsII
        fs/wzchH6K3UYC43gXW8M1EVRRixR3UYOjeWKKXh3w==
X-Google-Smtp-Source: AKy350bGMY9jGMiExQ7+l7+I0suBYvYqYi0y6PjqLOtszn2fv+Q82mga+XnOKQUxK8dXEmXL+uVKXrlNzDafYKEgAe8=
X-Received: by 2002:a05:6902:728:b0:b6e:b13e:9af with SMTP id
 l8-20020a056902072800b00b6eb13e09afmr2948895ybt.8.1679722813653; Fri, 24 Mar
 2023 22:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <ZBrvhfX/NNrJefgt@kroah.com> <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com> <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com> <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat> <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
 <20230323163639.xtwpid2uunwnzai4@houat> <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
 <20230324123157.bbwvfq4gsxnlnfwb@houat>
In-Reply-To: <20230324123157.bbwvfq4gsxnlnfwb@houat>
From:   David Gow <davidgow@google.com>
Date:   Sat, 25 Mar 2023 13:40:01 +0800
Message-ID: <CABVgOSn8H=9pQfY7Exc-e37Nm6u299AJLYup6R-_97v5Fb4bpQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device creation
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
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
        boundary="000000000000a7eacd05f7b2f1ad"
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

--000000000000a7eacd05f7b2f1ad
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Mar 2023 at 20:32, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Fri, Mar 24, 2023 at 08:11:52AM +0200, Matti Vaittinen wrote:
> > On 3/23/23 18:36, Maxime Ripard wrote:
> > > On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:
> > > > On 3/23/23 14:29, Maxime Ripard wrote:
> > > > > On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> > > > >
> > > > > This is the description of what was happening:
> > > > > https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/
> > > >
> > > > Thanks Maxime. Do I read this correcty. The devm_ unwinding not being done
> > > > when root_device_register() is used is not because root_device_unregister()
> > > > would not trigger the unwinding - but rather because DRM code on top of this
> > > > device keeps the refcount increased?
> > >
> > > There's a difference of behaviour between a root_device and any device
> > > with a bus: the root_device will only release the devm resources when
> > > it's freed (in device_release), but a bus device will also do it in
> > > device_del (through bus_remove_device() -> device_release_driver() ->
> > > device_release_driver_internal() -> __device_release_driver() ->
> > > device_unbind_cleanup(), which are skipped (in multiple places) if
> > > there's no bus and no driver attached to the device).
> > >
> > > It does affect DRM, but I'm pretty sure it will affect any framework
> > > that deals with device hotplugging by deferring the framework structure
> > > until the last (userspace) user closes its file descriptor. So I'd
> > > assume that v4l2 and cec at least are also affected, and most likely
> > > others.
> >
> > Thanks for the explanation and patience :)
> >
> > >
> > > > If this is the case, then it sounds like a DRM specific issue to me.
> > >
> > > I mean, I guess. One could also argue that it's because IIO doesn't
> > > properly deal with hotplugging.
> >
> > I must say I haven't been testing the IIO registration API. I've only tested
> > the helper API which is not backed up by any "IIO device". (This is fine for
> > the helper because it must by design be cleaned-up only after the
> > IIO-deregistration).
> >
> > After your explanation here, I am not convinced IIO wouldn't see the same
> > issue if I was testing the devm_iio_device_alloc() & co.
>
> It depends really. The issue DRM is trying to solve is that, when a
> device is gone, some application might still have an open FD and could
> still poke into the kernel, while all the resources would have been
> free'd if it was using devm.
>
> So everything is kept around until the last fd is closed, so you still
> have a reference to the device (even though it's been removed from its
> bus) until that time.
>
> It could be possible that IIO just doesn't handle that case at all. I
> guess most of the devices aren't hotpluggable, and there's not much to
> interact with from a userspace PoV iirc, so it might be why.
>
> > > I'm not sure how that helps. Those are
> > > common helpers which should accommodate every framework,
> >
> > Ok. Fair enough. Besides, if the root-device was sufficient - then I would
> > actually not see the need for a helper. People could in that case directly
> > use the root_device_register(). So, if helpers are provided they should be
> > backed up by a device with a bus then.
> >
> > > and your second
> > > patch breaks the kunit tests for DRM anyway.
> >
> > Oh, I must have made an error there. It was supposed to be just a
> > refactoring with no functional changes. Sorry about that. Anyways, that
> > patch can be forgotten as Greg opposes using the platform devices in generic
> > helpers.
> >
> > > > Whether it is a feature or bug is beyond my knowledge. Still, I would
> > > > not say using the root_device_[un]register() in generic code is not
> > > > feasible - unless all other subsytems have similar refcount handling.
> > > >
> > > > Sure thing using root_device_register() root_device_unregister() in DRM does
> > > > not work as such. This, however, does not mean the generic kunit helpers
> > > > should use platform_devices to force unwinding?
> > >
> > > platform_devices were a quick way to get a device that would have a bus
> > > and a driver bound to fall into the right patch above. We probably
> > > shouldn't use platform_devices and a kunit_device sounds like the best
> > > idea, but the test linked in the original mail I pointed you to should
> > > work with whatever we come up with. It works with multiple (platform,
> > > PCI, USB, etc) buses, so the mock we create should behave like their
> > > real world equivalents.
> >
> > Thanks for the patience and the explanation. Now I understand a generic test
> > device needs to sit on a bus.
> >
> > As I said, in my very specific IIO related test the test device does not
> > need a bus. Hence I'll drop the 'generic helpers' from this series.
>
> So, I went around and created a bunch of kunit tests that shows the
> problem without DRM being involved at all.
>
> It does three things:
>
>  - It registers a device, attaches a devm action, unregisters the device
>    and then checks that the action has ran.
>
>  - It registers a device, gets a reference to it, attaches a devm
>    action, puts back the reference, unregisters the device and then
>    checks that the action has ran.
>
>  - It registers a device, gets a reference to it, attaches a devm action
>    that will put back the reference, unregisters the device and then
>    checks that the action has ran.
>
> And in three cases: first with a root_device, then platform_device, then
> a platform_device that has been bound to a driver.
>
> Once you've applied that patch, you can run it using:
>
> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/base/test/ devm-inconsistencies
>
> You'll see that only the last case passes all the tests, even though the
> code itself is exactly the same.
>

This illustrates the problem very nicely, thanks.

I played around a bit with this, and I'm definitely leaning towards
this being a bug, rather than intentional behaviour. There's actually
an explicit call to devres_release_all() in device_release() which
seems to suggest that this should work:
/*
* Some platform devices are driven without driver attached
* and managed resources may have been acquired.  Make sure
* all resources are released.
*
* Drivers still can add resources into device after device
* is deleted but alive, so release devres here to avoid
* possible memory leak.
*/

My "solution" is just to call devres_release_all() in device_del() as
well, which fixes your tests (and the drm-test-managed one when ported
to use root_device_register() or my kunit_device_register() API[1]).

--8<--
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6878dfcbf0d6..adfec6185014 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3778,6 +3778,17 @@ void device_del(struct device *dev)
       device_platform_notify_remove(dev);
       device_links_purge(dev);

+       /*
+        * If a device does not have a driver attached, we need to clean up any
+        * managed resources. We do this in device_release(), but it's never
+        * called (and we leak the device) if a managed resource holds a
+        * reference to the device. So release all managed resources here,
+        * like we do in driver_detach(). We still need to do so again in
+        * device_release() in case someone adds a new resource after this
+        * point, though.
+        */
+       devres_release_all(dev);
+
       bus_notify(dev, BUS_NOTIFY_REMOVED_DEVICE);
       kobject_uevent(&dev->kobj, KOBJ_REMOVE);
       glue_dir = get_glue_dir(dev);

-->8--

It doesn't _seem_ to break anything else, and I've managed to convince
myself that it's probably the correct fix. (Albeit, as someone with a
limited knowledge of this part of the code, who also hasn't had quite
enough sleep, so take that with some salt.)

Still, I'd agree with Greg that it'd be great to have versions of your
tests upstream before making any such radical changes.

Cheers,
-- David

--000000000000a7eacd05f7b2f1ad
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBe
/Mhy5cuJiorvil44O37h9uzpfJArEhl+lGox9b7joDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMjUwNTQwMTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEABw96Bu7rQ3ap8EX6Fk+d
69F7YHzZ8rDcaYl8kf7rVwibTeIGOkr86Zq/yoHaQgrQ1wo4a5rt22r9SPkvoGrozq/ShCegfMth
wXBTenGclIaH/rcDNNZVCHLScpjmMtb4keSUNDzzCBR1FMX6LurfNvH6UXEMqsulxag8KwIWqpQB
0Kj1g0y8OZavRvUDUVrliglqqQ8yHTpALeInktn4D8d1K4hPw+EflUF5fvlKeGEWaJ8Ujr/i+544
M9d5iVUScYQ9YSMMkl0DXgPwMWTldgSB8mD5HNGf7cCfDcDBUe+ChvNLQ/SjIBNbtIvEJd+mvS6V
WpccGqmJitLivjeDYQ==
--000000000000a7eacd05f7b2f1ad--
