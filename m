Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EA769BBD1
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Feb 2023 21:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjBRUZF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Feb 2023 15:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRUZE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Feb 2023 15:25:04 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D731449B;
        Sat, 18 Feb 2023 12:25:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bh24-20020a05600c3d1800b003e00c739ce4so914930wmb.5;
        Sat, 18 Feb 2023 12:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fnClkfweopowbdR40jeonbkmj2uO2v4cKHbuN3BZUnc=;
        b=qO5AyZJYI4UYaQ/+7Ay+K/vB/kk+EI7AhIb5V2CjWVZf5NGSJ5m011fe1u7JsJERv1
         tVfaAEbCT+BBd4/g5i+jE3Iq6H8JGdhoq/G1uSuO1maXtY24mbnnfyseK+6foLtnClhR
         Rslf5ySVQNar6m6RJHBcZX6CVEtuQb1Q8QSqeT/e1o3aRu4PRbZ+TRdEBFLr/dMYptXK
         0UFzIF1xDEvuB4bRfN2Zn3bA5WMk9wx+/5Z28lJ176RtsoEJYJGtM4pj42sqn3YIFpnj
         nLYtPOyHTnzu5BgTkSSSZYribgXvs7kq5gPqPyS4VUOw46tcUoVxUocqR8gzfMy7Z7Od
         ZUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fnClkfweopowbdR40jeonbkmj2uO2v4cKHbuN3BZUnc=;
        b=i4LLzKDr17foWsfDoM01yZ8uqNiXUoLBc7XBeGvwUdpxCLiTdLgYhhBDT/0DJ1nflI
         zecRRBnIc6OWW8yMuuRzAOoPd0Y97r5HKve5UC1pNbsYVBRsxvoTQpPbbeW5FSDBTr0a
         ytFrv1k/WNWKpnXjepU7Nd6lZQBh10lAYkrT9oLJAIwMb1FfApuJ+sh4Y6DzTQ1H/LPl
         dvqa7jIukcb5BHun/szdOA2yJb3SFXGepsPp1R13Mj40JiYEuRZ2pCO7oBqV72oesKMp
         lz7gdiIvGyVaN+LlQxWxtTibSMpm/t1XFjKO7CkMztdgP9Ti7vzCLdebhy2eEwWS7cgy
         I+Ew==
X-Gm-Message-State: AO0yUKWJ/IpBKNdUgv+bYTZu+25thWIlbZT176BP5HaPdyoWCsw5r0vE
        qwWGVPGlje7j14uJub2/nsg=
X-Google-Smtp-Source: AK7set9x/isF0UWp+vX8BJUWQzZriCwHh0cHtknKngyZBD14scUDZEij3cT7rKCWUIfbvGrEn14kBA==
X-Received: by 2002:a05:600c:3297:b0:3e2:12a2:ecdc with SMTP id t23-20020a05600c329700b003e212a2ecdcmr7335061wmp.25.1676751900106;
        Sat, 18 Feb 2023 12:25:00 -0800 (PST)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c214600b003dfe549da4fsm4655866wml.18.2023.02.18.12.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 12:24:58 -0800 (PST)
Date:   Sat, 18 Feb 2023 21:24:58 +0100
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Candle Sun <candle.sun@unisoc.com>,
        Jose Torreguitar <jtguitar@google.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>
Subject: Re: [PATCH 03/11] selftests: hid: import hid-tools hid-gamepad tests
From:   "Silvan Jegen" <s.jegen@gmail.com>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
 <20230217-import-hid-tools-tests-v1-3-d1c48590d0ee@redhat.com>
In-Reply-To: <20230217-import-hid-tools-tests-v1-3-d1c48590d0ee@redhat.com>
Message-Id: <2I689D01YEK5A.22EBD98QJR04K@homearch.localdomain>
User-Agent: mblaze/1.2-17-g916c852 (2022-12-31)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> These tests have been developed in the hid-tools[0] tree for a while.
> Now that we have  a proper selftests/hid kernel entry and that the tests
> are more reliable, it is time to directly include those in the kernel
> tree.
>=20
> [0] https://gitlab.freedesktop.org/libevdev/hid-tools
>=20
> Cc: Candle Sun <candle.sun@unisoc.com>
> Cc: Jose Torreguitar <jtguitar@google.com>
> Cc: Peter Hutterer <peter.hutterer@who-t.net>
> Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>
> Cc: Silvan Jegen <s.jegen@gmail.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  tools/testing/selftests/hid/Makefile              |   1 +
>  tools/testing/selftests/hid/hid-gamepad.sh        |   7 +
>  tools/testing/selftests/hid/tests/test_gamepad.py | 209 ++++++++++++++++=
++++++
>  3 files changed, 217 insertions(+)

It was only a one line change from my side but in any case.

Signed-off-by: Silvan Jegen <s.jegen@gmail.com>


>=20
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftes=
ts/hid/Makefile
> index bdcb36d80c8c..d16a22477140 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -6,6 +6,7 @@ include ../../../scripts/Makefile.arch
>  include ../../../scripts/Makefile.include
> =20
>  TEST_PROGS :=3D hid-core.sh
> +TEST_PROGS +=3D hid-gamepad.sh
> =20
>  CXX ?=3D $(CROSS_COMPILE)g++
> =20
> diff --git a/tools/testing/selftests/hid/hid-gamepad.sh b/tools/testing/s=
elftests/hid/hid-gamepad.sh
> new file mode 100755
> index 000000000000..1ba00c0ca95f
> --- /dev/null
> +++ b/tools/testing/selftests/hid/hid-gamepad.sh
> @@ -0,0 +1,7 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Runs tests for the HID subsystem
> +
> +export TARGET=3Dtest_gamepad.py
> +
> +bash ./run-hid-tools-tests.sh
> diff --git a/tools/testing/selftests/hid/tests/test_gamepad.py b/tools/te=
sting/selftests/hid/tests/test_gamepad.py
> new file mode 100644
> index 000000000000..26c74040b796
> --- /dev/null
> +++ b/tools/testing/selftests/hid/tests/test_gamepad.py
> @@ -0,0 +1,209 @@
> +#!/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# -*- coding: utf-8 -*-
> +#
> +# Copyright (c) 2019 Benjamin Tissoires <benjamin.tissoires@gmail.com>
> +# Copyright (c) 2019 Red Hat, Inc.
> +#
> +
> +from . import base
> +import libevdev
> +import pytest
> +
> +from hidtools.device.base_gamepad import AsusGamepad, SaitekGamepad
> +
> +import logging
> +
> +logger =3D logging.getLogger("hidtools.test.gamepad")
> +
> +
> +class BaseTest:
> +    class TestGamepad(base.BaseTestCase.TestUhid):
> +        @pytest.fixture(autouse=3DTrue)
> +        def send_initial_state(self):
> +            """send an empty report to initialize the axes"""
> +            uhdev =3D self.uhdev
> +
> +            r =3D uhdev.event()
> +            events =3D uhdev.next_sync_events()
> +            self.debug_reports(r, uhdev, events)
> +
> +        def assert_button(self, button):
> +            uhdev =3D self.uhdev
> +            evdev =3D uhdev.get_evdev()
> +            syn_event =3D self.syn_event
> +
> +            buttons =3D {}
> +            key =3D libevdev.evbit(uhdev.buttons_map[button])
> +
> +            buttons[button] =3D True
> +            r =3D uhdev.event(buttons=3Dbuttons)
> +            expected_event =3D libevdev.InputEvent(key, 1)
> +            events =3D uhdev.next_sync_events()
> +            self.debug_reports(r, uhdev, events)
> +            self.assertInputEventsIn((syn_event, expected_event), events=
)
> +            assert evdev.value[key] =3D=3D 1
> +
> +            buttons[button] =3D False
> +            r =3D uhdev.event(buttons=3Dbuttons)
> +            expected_event =3D libevdev.InputEvent(key, 0)
> +            events =3D uhdev.next_sync_events()
> +            self.debug_reports(r, uhdev, events)
> +            self.assertInputEventsIn((syn_event, expected_event), events=
)
> +            assert evdev.value[key] =3D=3D 0
> +
> +        def test_buttons(self):
> +            """check for button reliability."""
> +            uhdev =3D self.uhdev
> +
> +            for b in uhdev.buttons:
> +                self.assert_button(b)
> +
> +        def test_dual_buttons(self):
> +            """check for button reliability when pressing 2 buttons"""
> +            uhdev =3D self.uhdev
> +            evdev =3D uhdev.get_evdev()
> +            syn_event =3D self.syn_event
> +
> +            # can change intended b1 b2 values
> +            b1 =3D uhdev.buttons[0]
> +            key1 =3D libevdev.evbit(uhdev.buttons_map[b1])
> +            b2 =3D uhdev.buttons[1]
> +            key2 =3D libevdev.evbit(uhdev.buttons_map[b2])
> +
> +            buttons =3D {b1: True, b2: True}
> +            r =3D uhdev.event(buttons=3Dbuttons)
> +            expected_event0 =3D libevdev.InputEvent(key1, 1)
> +            expected_event1 =3D libevdev.InputEvent(key2, 1)
> +            events =3D uhdev.next_sync_events()
> +            self.debug_reports(r, uhdev, events)
> +            self.assertInputEventsIn(
> +                (syn_event, expected_event0, expected_event1), events
> +            )
> +            assert evdev.value[key1] =3D=3D 1
> +            assert evdev.value[key2] =3D=3D 1
> +
> +            buttons =3D {b1: False, b2: None}
> +            r =3D uhdev.event(buttons=3Dbuttons)
> +            expected_event =3D libevdev.InputEvent(key1, 0)
> +            events =3D uhdev.next_sync_events()
> +            self.debug_reports(r, uhdev, events)
> +            self.assertInputEventsIn((syn_event, expected_event), events=
)
> +            assert evdev.value[key1] =3D=3D 0
> +            assert evdev.value[key2] =3D=3D 1
> +
> +            buttons =3D {b1: None, b2: False}
> +            r =3D uhdev.event(buttons=3Dbuttons)
> +            expected_event =3D libevdev.InputEvent(key2, 0)
> +            events =3D uhdev.next_sync_events()
> +            self.debug_reports(r, uhdev, events)
> +            self.assertInputEventsIn((syn_event, expected_event), events=
)
> +            assert evdev.value[key1] =3D=3D 0
> +            assert evdev.value[key2] =3D=3D 0
> +
> +        def _get_libevdev_abs_events(self, which):
> +            """Returns which ABS_* evdev axes are expected for the given=
 stick"""
> +            abs_map =3D self.uhdev.axes_map[which]
> +
> +            x =3D abs_map["x"].evdev
> +            y =3D abs_map["y"].evdev
> +
> +            assert x
> +            assert y
> +
> +            return x, y
> +
> +        def _test_joystick_press(self, which, data):
> +            uhdev =3D self.uhdev
> +
> +            libevdev_axes =3D self._get_libevdev_abs_events(which)
> +
> +            r =3D None
> +            if which =3D=3D "left_stick":
> +                r =3D uhdev.event(left=3Ddata)
> +            else:
> +                r =3D uhdev.event(right=3Ddata)
> +            events =3D uhdev.next_sync_events()
> +            self.debug_reports(r, uhdev, events)
> +
> +            for i, d in enumerate(data):
> +                if d is not None and d !=3D 127:
> +                    assert libevdev.InputEvent(libevdev_axes[i], d) in e=
vents
> +                else:
> +                    assert libevdev.InputEvent(libevdev_axes[i]) not in =
events
> +
> +        def test_left_joystick_press_left(self):
> +            """check for the left joystick reliability"""
> +            self._test_joystick_press("left_stick", (63, None))
> +            self._test_joystick_press("left_stick", (0, 127))
> +
> +        def test_left_joystick_press_right(self):
> +            """check for the left joystick reliability"""
> +            self._test_joystick_press("left_stick", (191, 127))
> +            self._test_joystick_press("left_stick", (255, None))
> +
> +        def test_left_joystick_press_up(self):
> +            """check for the left joystick reliability"""
> +            self._test_joystick_press("left_stick", (None, 63))
> +            self._test_joystick_press("left_stick", (127, 0))
> +
> +        def test_left_joystick_press_down(self):
> +            """check for the left joystick reliability"""
> +            self._test_joystick_press("left_stick", (127, 191))
> +            self._test_joystick_press("left_stick", (None, 255))
> +
> +        def test_right_joystick_press_left(self):
> +            """check for the right joystick reliability"""
> +            self._test_joystick_press("right_stick", (63, None))
> +            self._test_joystick_press("right_stick", (0, 127))
> +
> +        def test_right_joystick_press_right(self):
> +            """check for the right joystick reliability"""
> +            self._test_joystick_press("right_stick", (191, 127))
> +            self._test_joystick_press("right_stick", (255, None))
> +
> +        def test_right_joystick_press_up(self):
> +            """check for the right joystick reliability"""
> +            self._test_joystick_press("right_stick", (None, 63))
> +            self._test_joystick_press("right_stick", (127, 0))
> +
> +        def test_right_joystick_press_down(self):
> +            """check for the right joystick reliability"""
> +            self._test_joystick_press("right_stick", (127, 191))
> +            self._test_joystick_press("right_stick", (None, 255))
> +
> +        @pytest.mark.skip_if_uhdev(
> +            lambda uhdev: "Hat switch" not in uhdev.fields,
> +            "Device not compatible, missing Hat switch usage",
> +        )
> +        @pytest.mark.parametrize(
> +            "hat_value,expected_evdev,evdev_value",
> +            [
> +                (0, "ABS_HAT0Y", -1),
> +                (2, "ABS_HAT0X", 1),
> +                (4, "ABS_HAT0Y", 1),
> +                (6, "ABS_HAT0X", -1),
> +            ],
> +        )
> +        def test_hat_switch(self, hat_value, expected_evdev, evdev_value=
):
> +            uhdev =3D self.uhdev
> +
> +            r =3D uhdev.event(hat_switch=3Dhat_value)
> +            events =3D uhdev.next_sync_events()
> +            self.debug_reports(r, uhdev, events)
> +            assert (
> +                libevdev.InputEvent(
> +                    libevdev.evbit("EV_ABS", expected_evdev), evdev_valu=
e
> +                )
> +                in events
> +            )
> +
> +
> +class TestSaitekGamepad(BaseTest.TestGamepad):
> +    def create_device(self):
> +        return SaitekGamepad()
> +
> +
> +class TestAsusGamepad(BaseTest.TestGamepad):
> +    def create_device(self):
> +        return AsusGamepad()


