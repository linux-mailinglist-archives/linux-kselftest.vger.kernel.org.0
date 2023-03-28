Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1556CBF94
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjC1MqG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 08:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjC1Mp5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 08:45:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21439AF07
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 05:45:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so9339512wmq.4
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680007523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9veLpvm3V3yyHvsrsxqRm8mkzvbCp1hw1TFPuWfZDpg=;
        b=aMkHupxM1P9H6jCEKY2S/WoRzR6FRzOYhFhH/ABAZnV44OlGDPH4RjbkE+O/tnTT6x
         9TAVgbahV/ZDQQ+g8Y7QJnj1lYBErEAA4Akc6iZ9ArFplxDIh+kNRqnjfGtQQtr8cbgb
         fdwXmP2NIWwatvap6ltPFRDISd0pTrzAg1cnZCMVf/ZrjegCH0vu/hu3idSM8zx63X1o
         7q+vNiSayt8aTB5eTunxMNGs9/eH9d80FZ6I+ydZuKvuEV8glzURvvZ//oByC4zRd+S3
         t9ojLop0W8id/8KvxYy5SnAnSnKyIAAjhIcA2GusL4fqqpAQ3hw+BkckYbwkUvHfHlBV
         v46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680007523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9veLpvm3V3yyHvsrsxqRm8mkzvbCp1hw1TFPuWfZDpg=;
        b=zN+IGCjMnIz3fmiwoxg0WWw4tO4qt2JSncs28bWtiLLezo+HbntlFjIac990zqmZGc
         Xq3OnKKKERiXSeKeGyu7PCIxupeWnHj4qkZ4JFsZOzQeaQjV7dWHJDf5bD6A1tjCkb9p
         CogcM0G7SPoepkD06nC1/jFMdIG3U8WOZH2BePLQ6yzYnhAitHFXjQa9xEdWQbU6m/7u
         cnG5lpWsT/ey9aJC6Y/6bM6ZfSVb8B26D6s+ocDshrjBHR96T/t1dU4dIURelQza4m+F
         JbKceNkd2/EH7YCN27M+9WBSXMDMQI3yzdNrDN+ePecoGyDWBNk0s7qLF1YctU5Om2OY
         yOWQ==
X-Gm-Message-State: AO0yUKV/9YbSHQkg3UnGmok7Bk6uIJwJ0kT2g3TOqZLLluprd0wgenI2
        56hsfzV16S46rodSsNjN2QMQvsb/ao1gB4edZ/zZGA==
X-Google-Smtp-Source: AK7set+ledd+drpHIpsG7+OgCtMnLKfAZV+VWtOxJbQIKrW8vdv2q4unjuYjgC1QPZaklT3wJNz+qVVhl/wDfND7xZU=
X-Received: by 2002:a1c:4b07:0:b0:3df:97b0:ba02 with SMTP id
 y7-20020a1c4b07000000b003df97b0ba02mr3490013wma.3.1680007522289; Tue, 28 Mar
 2023 05:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679915278.git.mazziesaccount@gmail.com>
 <f2c7f7b04f7e4ee7b9cef73ecba672f5fa40eb73.1679915278.git.mazziesaccount@gmail.com>
 <ZCGFgypeuJXqNwQt@kroah.com> <e027fc0c-83e0-be6f-d62b-dac00ce9b761@gmail.com> <ZCGONl0mC8oyBj-0@kroah.com>
In-Reply-To: <ZCGONl0mC8oyBj-0@kroah.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 28 Mar 2023 20:45:09 +0800
Message-ID: <CABVgOSnUCsxPf1mAL03GQzaw_kFtgf5J7aTPodo=j6O+wYZ2iQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] kunit: Add kunit wrappers for (root) device creation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a2f0be05f7f53bc4"
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

--000000000000a2f0be05f7f53bc4
Content-Type: text/plain; charset="UTF-8"

Thanks, Gred and Matti.

On Mon, 27 Mar 2023 at 20:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 27, 2023 at 03:20:06PM +0300, Matti Vaittinen wrote:
> > On 3/27/23 15:01, Greg Kroah-Hartman wrote:
> > > On Mon, Mar 27, 2023 at 02:34:02PM +0300, Matti Vaittinen wrote:
> > > > A few tests need to have a valid struct device. One such example is
> > > > tests which want to be testing devm-managed interfaces.
> > > >
> > > > Add kunit wrapper for root_device_[un]register(), which create a root
> > > > device and also add a kunit managed clean-up routine for the device
> > > > destruction upon test exit.
> > >
> > > I really do not like this as a "root device" is a horrible hack and
> > > should only be used if you have to hang other devices off of it and you
> > > don't have a real device to tie those devices to.
> > >
> > > Here you are abusing it and attempting to treat it as a real device,
> > > which it is not at all, because:
> > >

There's a tradeoff here in that we want to pull in as little code (and
complexity) as possible into unit tests, both to make them as easy as
possible to write, and to make them as targeted as possible. This
leads to a lot of tests manually filling out structures with the bare
minimum to get the code being tested to run, and creating "root
devices" seems to have been a convenient way of doing that while only
registering _one_ thing in a big global list per test. So having a
"real device" is not something I'd consider a _necessity_ in designing
these sorts of helpers: a convincing enough fake is sometimes better.

That being said, now that I've got a bit of a better understanding of
the device model, I agree that "root devices" are not an ideal
solution, even if they are a convenient one. I'm still not thrilled by
the prospect of having to register extra things like drivers to get
these simple tests to work, but when wrapped behind helpers, it's a
nice solution in practice.

> > > > Special note: In some cases the device reference-count does not reach
> > > > zero and devm-unwinding is not done if device is not sitting on a bus.
> > > > The root_device_[un]register() are dealing with such devices and thus
> > > > this interface may not be usable by all in its current form. More
> > > > information can be found from:
> > > > https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/
> > >
> > > See, not a real device, doesn't follow normal "struct device" rules and
> > > lifetimes, don't try to use it for a test as it will only cause problems
> > > and you will be forced to work around that in a test.

I think there's still some confusion around exactly what these issues
are, and if they're indeed bugs or expected behaviour. I think it
hangs off the question of what uses of a device with no driver
attached are valid. My initial reading through of the various bits of
the devres implementation seemed to imply that using it with such an
unattached device was supported, but I'm less certain now. In any
case, Maxime's tests in the other thread are a good starting point to
clarify this behaviour, and if we use the bus-based KUnit helpers, it
won't matter either way.

> >
> > Ok. I understood using the root-device has been a work-around in some other
> > tests. Thus continuing use it for tests where we don't need the bus until we
> > have a proper alternative was suggested by David.
> >
> > > Do the right thing here, create a fake bus and add devices to it.
> > >
> > > Heck, I'll even write that code if you want it, what's the requirement,
> > > something like:
> > >     struct device *kunit_device_create(struct kunit *test, const char *name);
> > >     void kunit_device_destroy(struct device *dev);
> >
> > Thanks for the offer Greg. This, however, is being already worked on by
> > David. I don't want to step on his toes by writing the same thing, nor do I
> > think I should be pushing him to rush on his work.
>
> Ok, David, my offer stands, if you want me to write this I will be glad
> to do so.

I'm happy to keep working on this, but would definitely appreciate
your feedback.

I've put my work-in-progress code here:
https://kunit.googlesource.com/linux/+/refs/heads/kunit/device-helpers%5E%21/#F0

It creates a "kunit" bus, and adds a few helpers to create both
devices and drivers on that bus, and clean them up when the test
exits. It seems to work on all of the tests which used
root_device_register so far (except those -- only
test_iio_find_closest_gain_low so far -- which create multiple devices
with the same name, as the driver name won't be unique), and the drm
tests work fine when ported to it as well.

There's still a lot of cleanup to do and questions which need
answering, including:
- Working out how best to provide an owning module (it's currently
just kunit, but probably should be the module which contains the
actual tests)
- Improving the API around drivers: probably exposing the helper to
create a driver, and add a way of cleaning it up early.
- Properly testing it with modules, not just with kunit.py (including
looking at what actually appears in sysfs)
- Experimenting with using probe, etc, callbacks.
- Cleaning up lots of ugly, still experimental code, documenting, testing, etc.

The thought of trying to expand the match function to support, e.g.,
devicetree occurred to me, but I _think_ that devicetree-based tests
are probably still better off using a platform_device. Regardless, it
can probably wait to a follow-up

In any case, does this seem like the right way forward?

Cheers,
-- David

--000000000000a2f0be05f7f53bc4
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDj
bIV+34iPu3Z/b1tx5Xxul5zartaNzqTyH8AKeNwY9zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMjgxMjQ1MjNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEhGT4R+dJU302AHNKoqA
fr29Wl14fRDJQ7NVG7xUwvhTf2U3H7B9l1OJhWUXbKdQMRAVT7n95A5LinRXV00WQZe0mLY39Uc5
KGknjGYuNxoM80tUumXBqmJwFkpvy+NgX9esbqmKEOoGrc+NoYncPs7na0TRq+tgmSp+FvshzQss
qnjb3rKMbXjRLC5EW4X60tp/mK4kNtBOU158LvQJGdFGG8T6lsph7fL1QwqQpFJXy1JvKfSwgrkY
v75yYVWpUXm0lc0c3sHFk3BrPo7CAQ4oJ+SWjeOPxYgkFvGixUU43g0xwAlJbi5FBYoxfEkQcgFP
JXsVtFc4Mqx8etgWbA==
--000000000000a2f0be05f7f53bc4--
