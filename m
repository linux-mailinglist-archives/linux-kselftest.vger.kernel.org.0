Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F384B6DF9B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjDLPTl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 11:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjDLPT3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 11:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4364B59E0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681312702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wl8XIpZwxFbJg/0roJGAYEyhzbXJ2CitbivzO+IalAs=;
        b=TzOWBip7gEWs0VBjFwRCMWbsyrLa7xsouo9hbuv/IYciW/2awBjITxyXVy41ekvXzs4+rU
        2crvEN+N/guAtmPHTksrADVpMUiz4kX/c7QuJ0uYqCv4uDm5WIls5hDeWpClxQfGWLNJIU
        WtuZjWWvAcidnbfp7RzmZX4ZU9fVc+o=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-RE7rJAejM368Mn_vihRtow-1; Wed, 12 Apr 2023 11:18:21 -0400
X-MC-Unique: RE7rJAejM368Mn_vihRtow-1
Received: by mail-yb1-f199.google.com with SMTP id b124-20020a253482000000b00b8f1b9d74ecso6552577yba.18
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 08:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312699; x=1683904699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl8XIpZwxFbJg/0roJGAYEyhzbXJ2CitbivzO+IalAs=;
        b=xWzUn9y7pxnKZcq8gzPN5aR0FJSw1N8BY++uLx4cfptMbfUPrZIduOvl/VVFgtB3eD
         eNVREC4vnFVlQPeE6HjVdJy1eYHxA96j2d6rSjCjSE063O+aPXwfa4QeeJET7fFyt6xx
         1ZozxT+O3pW/R00Zto/TPkPXNHPhwDB2CDTdWfKfnwizRdy6BAE20JtAIHikTMqFWhnT
         0eZLrGB1EcyL/xmlIEsfF6mD3N56cgga+tShWcDTChMr0g7UYulEf14jZFBKBi70gKSY
         No+sL6tPuWaqlbGWLJKhfuhxqgAJnt2MVTek0NSb0z1fXLTE+/RYxD4TZZOiw85IHDTZ
         2luw==
X-Gm-Message-State: AAQBX9e1CL8+u2T0sCiFXFcyKQAkT4Yqy1ff217zvPQTjYH3hNTb6EHU
        ybHV9IrxgWpX48nwcyKnCakz2zwQYO4wZ+m/3ekT8i6kG98Fi2H9SpkJTXS5jOSZY0OMUcxE6bN
        /DkL/ezJYLhNTEAt1LD1x8W+8e5Cci0KMLAvrQsixONkV
X-Received: by 2002:a81:c406:0:b0:54c:5102:2196 with SMTP id j6-20020a81c406000000b0054c51022196mr1616304ywi.5.1681312699244;
        Wed, 12 Apr 2023 08:18:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350bd1TpZFHUGPfNHKI2pAKVpd0WmPQcSRw2pkTE9E+JtJ0LuJUrRMmcL9V/6RlJVssw0SQ4ZMTXZg06SuHLwGiU=
X-Received: by 2002:a81:c406:0:b0:54c:5102:2196 with SMTP id
 j6-20020a81c406000000b0054c51022196mr1616282ywi.5.1681312698914; Wed, 12 Apr
 2023 08:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
 <20230403162024.sespaq5iwbjan4xl@mail.corp.redhat.com> <20230404013731.GA38303@quokka>
 <CAEc3jaBaY4GAHTtXyCZGw=AoxfBQ_9-rxorrS0KwJjAFyN993A@mail.gmail.com>
In-Reply-To: <CAEc3jaBaY4GAHTtXyCZGw=AoxfBQ_9-rxorrS0KwJjAFyN993A@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 12 Apr 2023 17:18:08 +0200
Message-ID: <CAO-hwJJqqOVoC5V1Hgfda2N_4hJJs2DN_CyDBnc0C+Owciywig@mail.gmail.com>
Subject: Re: [PATCH 00/11] selftests: hid: import the tests from hid-tools
To:     Roderick Colenbrander <thunderbird2k@gmail.com>
Cc:     Peter Hutterer <peter.hutterer@who-t.net>,
        Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Candle Sun <candle.sun@unisoc.com>,
        Jose Torreguitar <jtguitar@google.com>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Silvan Jegen <s.jegen@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Jason Gerecke <killertofu@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 5, 2023 at 1:22=E2=80=AFAM Roderick Colenbrander
<thunderbird2k@gmail.com> wrote:
>
> Hi Benjamin,
>
> I like the direction of bundling the tests with the kernel and should
> make it easier in case there are driver changes breaking tests as
> well.
>
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

Thanks everybody.

I have now pushed this series with the sony fixes from hid-tools in
the branch for-6.4/tests, in the hid tree.

Cheers,
Benjamin

>
> Thanks,
> Roderick Colenbrander
>
> On Mon, Apr 3, 2023 at 6:54=E2=80=AFPM Peter Hutterer <peter.hutterer@who=
-t.net> wrote:
> >
> > On Mon, Apr 03, 2023 at 06:20:24PM +0200, Benjamin Tissoires wrote:
> > > On Feb 17 2023, Benjamin Tissoires wrote:
> > > > I have been running hid-tools for a while, but it was in its own
> > > > separate repository for multiple reasons. And the past few weeks
> > > > I finally managed to make the kernel tests in that repo in a
> > > > state where we can merge them in the kernel tree directly:
> > > >
> > > > - the tests run in ~2 to 3 minutes
> > > > - the tests are way more reliable than previously
> > > > - the tests are mostly self-contained now (to the exception
> > > >   of the Sony ones)
> > > >
> > > > To be able to run the tests we need to use the latest release
> > > > of hid-tools, as this project still keeps the HID parsing logic
> > > > and is capable of generating the HID events.
> > > >
> > > > The series also ensures we can run the tests with vmtest.sh,
> > > > allowing for a quick development and test in the tree itself.
> > > >
> > > > This should allow us to require tests to be added to a series
> > > > when we see fit and keep them alive properly instead of having
> > > > to deal with 2 repositories.
> > > >
> > > > In Cc are all of the people who participated in the elaboration
> > > > of those tests, so please send back a signed-off-by for each
> > > > commit you are part of.
> > > >
> > > > This series applies on top of the for-6.3/hid-bpf branch, which
> > > > is the one that added the tools/testing/selftests/hid directory.
> > > > Given that this is unlikely this series will make the cut for
> > > > 6.3, we might just consider this series to be based on top of
> > > > the future 6.3-rc1.
> > > >
> > > > Cheers,
> > > > Benjamin
> > > >
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > ---
> > >
> > > Jiri, do you mind if I push that code in the hid tree with the follow=
ing
> > > changes:
> > > - Peter privately gave me his signed-off-by
> >
> > Apologies, this fell off my list after the initial ack in a meeting wit=
h
> > Benjamin. This time publicly:
> >   Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > for the relevant commits.
> >
> > Cheers,
> >   Peter
> >
> >
> > > - I included changes from https://gitlab.freedesktop.org/libevdev/hid=
-tools/-/merge_requests/143
> > >   to fix the failing sony tests in v6.3
> > >
> > > I am not a big fan of sending a v2 because the ML are not happy with =
the
> > > amount of changes...
> > >
> > > Cheers,
> > > Benjamin
> > >
> > > > Benjamin Tissoires (11):
> > > >       selftests: hid: make vmtest rely on make
> > > >       selftests: hid: import hid-tools hid-core tests
> > > >       selftests: hid: import hid-tools hid-gamepad tests
> > > >       selftests: hid: import hid-tools hid-keyboards tests
> > > >       selftests: hid: import hid-tools hid-mouse tests
> > > >       selftests: hid: import hid-tools hid-multitouch and hid-table=
ts tests
> > > >       selftests: hid: import hid-tools wacom tests
> > > >       selftests: hid: import hid-tools hid-apple tests
> > > >       selftests: hid: import hid-tools hid-ite tests
> > > >       selftests: hid: import hid-tools hid-sony and hid-playstation=
 tests
> > > >       selftests: hid: import hid-tools usb-crash tests
> > > >
> > > >  tools/testing/selftests/hid/Makefile               |   12 +
> > > >  tools/testing/selftests/hid/config                 |   11 +
> > > >  tools/testing/selftests/hid/hid-apple.sh           |    7 +
> > > >  tools/testing/selftests/hid/hid-core.sh            |    7 +
> > > >  tools/testing/selftests/hid/hid-gamepad.sh         |    7 +
> > > >  tools/testing/selftests/hid/hid-ite.sh             |    7 +
> > > >  tools/testing/selftests/hid/hid-keyboard.sh        |    7 +
> > > >  tools/testing/selftests/hid/hid-mouse.sh           |    7 +
> > > >  tools/testing/selftests/hid/hid-multitouch.sh      |    7 +
> > > >  tools/testing/selftests/hid/hid-sony.sh            |    7 +
> > > >  tools/testing/selftests/hid/hid-tablet.sh          |    7 +
> > > >  tools/testing/selftests/hid/hid-usb_crash.sh       |    7 +
> > > >  tools/testing/selftests/hid/hid-wacom.sh           |    7 +
> > > >  tools/testing/selftests/hid/run-hid-tools-tests.sh |   28 +
> > > >  tools/testing/selftests/hid/settings               |    3 +
> > > >  tools/testing/selftests/hid/tests/__init__.py      |    2 +
> > > >  tools/testing/selftests/hid/tests/base.py          |  345 ++++
> > > >  tools/testing/selftests/hid/tests/conftest.py      |   81 +
> > > >  .../selftests/hid/tests/descriptors_wacom.py       | 1360 ++++++++=
+++++
> > > >  .../selftests/hid/tests/test_apple_keyboard.py     |  440 +++++
> > > >  tools/testing/selftests/hid/tests/test_gamepad.py  |  209 ++
> > > >  tools/testing/selftests/hid/tests/test_hid_core.py |  154 ++
> > > >  .../selftests/hid/tests/test_ite_keyboard.py       |  166 ++
> > > >  tools/testing/selftests/hid/tests/test_keyboard.py |  485 +++++
> > > >  tools/testing/selftests/hid/tests/test_mouse.py    |  977 ++++++++=
+
> > > >  .../testing/selftests/hid/tests/test_multitouch.py | 2088 ++++++++=
++++++++++++
> > > >  tools/testing/selftests/hid/tests/test_sony.py     |  282 +++
> > > >  tools/testing/selftests/hid/tests/test_tablet.py   |  872 ++++++++
> > > >  .../testing/selftests/hid/tests/test_usb_crash.py  |  103 +
> > > >  .../selftests/hid/tests/test_wacom_generic.py      |  844 ++++++++
> > > >  tools/testing/selftests/hid/vmtest.sh              |   25 +-
> > > >  31 files changed, 8554 insertions(+), 10 deletions(-)
> > > > ---
> > > > base-commit: 2f7f4efb9411770b4ad99eb314d6418e980248b4
> > > > change-id: 20230217-import-hid-tools-tests-dc0cd4f3c8a8
> > > >
> > > > Best regards,
> > > > --
> > > > Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > >
> > >
>

