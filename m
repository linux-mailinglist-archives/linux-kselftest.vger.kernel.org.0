Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16966D7093
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 01:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjDDXWt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 19:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbjDDXWs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 19:22:48 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF093C06;
        Tue,  4 Apr 2023 16:22:47 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5445009c26bso645531667b3.8;
        Tue, 04 Apr 2023 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680650567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Jae+kgNJA+vLUqMPfGkfrIa2AP/V2belPN6CLTFIj4=;
        b=lrNvuQ0LdMh2j1HS2tfDOqZu5mtZn3hsS107OH71RhDivc/IGjuDSTK3Nm7+ykyRT1
         aGhiSqwb5mKlES6w6X8BlzFHBUtt/BUhCiX/AdhNoRPgUca/l1/gIEiAtXS9qdKrohY0
         oloz42lKY6FazrTsjB49EbnL3Zdb430lO4eY+xDJd3mzTezahdxxEEU6ju7RiF2dNiIC
         rm9hxdVxhX6F7T1ZdNe7hIywNabgsMSn8WdYf5Ys/Y13pC/7rlQwAGd9m866t5Pt3N5G
         EsVS/V1GHmE/eXLrd1LdznPHTAaFaCiYjpUNOy4sZ/KRH49I4/gxUlPeUUvLl0mwM1uF
         6RTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680650567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Jae+kgNJA+vLUqMPfGkfrIa2AP/V2belPN6CLTFIj4=;
        b=Lokpqh8RTpjHiA0hiP/nRwoq9m/fs2x3VWzMzIEnmqegQgs+PkySfeN1+rnvicfVn1
         51KiGE7wgcS4JRlz/6vuHilCRcsySCpERfKLfXwj0+LU6rFTn9GKSJExahNI+q4v/JJ5
         XlKBICpzuTy68UP2JoME9sTSO2ERmLWlPId9JpLN9hk1/kfCyYCHKuysygnwOlFVk4Hp
         iE/IZoQTAW26EWxyZGTTIW8pdSeszPCxQdrgzoRZ4HGwfJI9rKcO2YU7SL/YOoTCf1wQ
         LQ9WG7Tj/gyqGqswiV1uor4j8qQe/i0sdLOmD1BQEIdRkLEKWdQNCcpYIhVRGxGBrweY
         gEPg==
X-Gm-Message-State: AAQBX9fnD8rJfGQPLFybj0U/MCsPfHflz+jbAy51EZiz6GVniQ+rH/dI
        hGCT5OleoETFuCZ2XizrZjW4ZeukZXoAlSJywDg=
X-Google-Smtp-Source: AKy350aZv6OvJxb3sMF82CLnMDw/7BR6i7oF2hYP7FkvOx2EN+LUytmEvif//qmWBvZLGup0Xw9MIRpL36vCT78ulPE=
X-Received: by 2002:a81:ad0b:0:b0:545:3f42:2d97 with SMTP id
 l11-20020a81ad0b000000b005453f422d97mr2481053ywh.3.1680650566822; Tue, 04 Apr
 2023 16:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
 <20230403162024.sespaq5iwbjan4xl@mail.corp.redhat.com> <20230404013731.GA38303@quokka>
In-Reply-To: <20230404013731.GA38303@quokka>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Tue, 4 Apr 2023 16:22:35 -0700
Message-ID: <CAEc3jaBaY4GAHTtXyCZGw=AoxfBQ_9-rxorrS0KwJjAFyN993A@mail.gmail.com>
Subject: Re: [PATCH 00/11] selftests: hid: import the tests from hid-tools
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Benjamin,

I like the direction of bundling the tests with the kernel and should
make it easier in case there are driver changes breaking tests as
well.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

Thanks,
Roderick Colenbrander

On Mon, Apr 3, 2023 at 6:54=E2=80=AFPM Peter Hutterer <peter.hutterer@who-t=
.net> wrote:
>
> On Mon, Apr 03, 2023 at 06:20:24PM +0200, Benjamin Tissoires wrote:
> > On Feb 17 2023, Benjamin Tissoires wrote:
> > > I have been running hid-tools for a while, but it was in its own
> > > separate repository for multiple reasons. And the past few weeks
> > > I finally managed to make the kernel tests in that repo in a
> > > state where we can merge them in the kernel tree directly:
> > >
> > > - the tests run in ~2 to 3 minutes
> > > - the tests are way more reliable than previously
> > > - the tests are mostly self-contained now (to the exception
> > >   of the Sony ones)
> > >
> > > To be able to run the tests we need to use the latest release
> > > of hid-tools, as this project still keeps the HID parsing logic
> > > and is capable of generating the HID events.
> > >
> > > The series also ensures we can run the tests with vmtest.sh,
> > > allowing for a quick development and test in the tree itself.
> > >
> > > This should allow us to require tests to be added to a series
> > > when we see fit and keep them alive properly instead of having
> > > to deal with 2 repositories.
> > >
> > > In Cc are all of the people who participated in the elaboration
> > > of those tests, so please send back a signed-off-by for each
> > > commit you are part of.
> > >
> > > This series applies on top of the for-6.3/hid-bpf branch, which
> > > is the one that added the tools/testing/selftests/hid directory.
> > > Given that this is unlikely this series will make the cut for
> > > 6.3, we might just consider this series to be based on top of
> > > the future 6.3-rc1.
> > >
> > > Cheers,
> > > Benjamin
> > >
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > ---
> >
> > Jiri, do you mind if I push that code in the hid tree with the followin=
g
> > changes:
> > - Peter privately gave me his signed-off-by
>
> Apologies, this fell off my list after the initial ack in a meeting with
> Benjamin. This time publicly:
>   Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> for the relevant commits.
>
> Cheers,
>   Peter
>
>
> > - I included changes from https://gitlab.freedesktop.org/libevdev/hid-t=
ools/-/merge_requests/143
> >   to fix the failing sony tests in v6.3
> >
> > I am not a big fan of sending a v2 because the ML are not happy with th=
e
> > amount of changes...
> >
> > Cheers,
> > Benjamin
> >
> > > Benjamin Tissoires (11):
> > >       selftests: hid: make vmtest rely on make
> > >       selftests: hid: import hid-tools hid-core tests
> > >       selftests: hid: import hid-tools hid-gamepad tests
> > >       selftests: hid: import hid-tools hid-keyboards tests
> > >       selftests: hid: import hid-tools hid-mouse tests
> > >       selftests: hid: import hid-tools hid-multitouch and hid-tablets=
 tests
> > >       selftests: hid: import hid-tools wacom tests
> > >       selftests: hid: import hid-tools hid-apple tests
> > >       selftests: hid: import hid-tools hid-ite tests
> > >       selftests: hid: import hid-tools hid-sony and hid-playstation t=
ests
> > >       selftests: hid: import hid-tools usb-crash tests
> > >
> > >  tools/testing/selftests/hid/Makefile               |   12 +
> > >  tools/testing/selftests/hid/config                 |   11 +
> > >  tools/testing/selftests/hid/hid-apple.sh           |    7 +
> > >  tools/testing/selftests/hid/hid-core.sh            |    7 +
> > >  tools/testing/selftests/hid/hid-gamepad.sh         |    7 +
> > >  tools/testing/selftests/hid/hid-ite.sh             |    7 +
> > >  tools/testing/selftests/hid/hid-keyboard.sh        |    7 +
> > >  tools/testing/selftests/hid/hid-mouse.sh           |    7 +
> > >  tools/testing/selftests/hid/hid-multitouch.sh      |    7 +
> > >  tools/testing/selftests/hid/hid-sony.sh            |    7 +
> > >  tools/testing/selftests/hid/hid-tablet.sh          |    7 +
> > >  tools/testing/selftests/hid/hid-usb_crash.sh       |    7 +
> > >  tools/testing/selftests/hid/hid-wacom.sh           |    7 +
> > >  tools/testing/selftests/hid/run-hid-tools-tests.sh |   28 +
> > >  tools/testing/selftests/hid/settings               |    3 +
> > >  tools/testing/selftests/hid/tests/__init__.py      |    2 +
> > >  tools/testing/selftests/hid/tests/base.py          |  345 ++++
> > >  tools/testing/selftests/hid/tests/conftest.py      |   81 +
> > >  .../selftests/hid/tests/descriptors_wacom.py       | 1360 ++++++++++=
+++
> > >  .../selftests/hid/tests/test_apple_keyboard.py     |  440 +++++
> > >  tools/testing/selftests/hid/tests/test_gamepad.py  |  209 ++
> > >  tools/testing/selftests/hid/tests/test_hid_core.py |  154 ++
> > >  .../selftests/hid/tests/test_ite_keyboard.py       |  166 ++
> > >  tools/testing/selftests/hid/tests/test_keyboard.py |  485 +++++
> > >  tools/testing/selftests/hid/tests/test_mouse.py    |  977 +++++++++
> > >  .../testing/selftests/hid/tests/test_multitouch.py | 2088 ++++++++++=
++++++++++
> > >  tools/testing/selftests/hid/tests/test_sony.py     |  282 +++
> > >  tools/testing/selftests/hid/tests/test_tablet.py   |  872 ++++++++
> > >  .../testing/selftests/hid/tests/test_usb_crash.py  |  103 +
> > >  .../selftests/hid/tests/test_wacom_generic.py      |  844 ++++++++
> > >  tools/testing/selftests/hid/vmtest.sh              |   25 +-
> > >  31 files changed, 8554 insertions(+), 10 deletions(-)
> > > ---
> > > base-commit: 2f7f4efb9411770b4ad99eb314d6418e980248b4
> > > change-id: 20230217-import-hid-tools-tests-dc0cd4f3c8a8
> > >
> > > Best regards,
> > > --
> > > Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> >
