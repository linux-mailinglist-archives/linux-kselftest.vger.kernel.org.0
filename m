Return-Path: <linux-kselftest+bounces-47733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10494CD02F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 15:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FDFF304A8C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A0A327BE0;
	Fri, 19 Dec 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkUAGJ1K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F532720C;
	Fri, 19 Dec 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152838; cv=none; b=avLh+vrtXUHl2nFZdBZ11uYiXnhzJcljdK6YZ7mNJLXr4yLPOrjADiGZ+BVFTLvgqs87BEIsYvX1xtcx5tJnI3HKybYrUq3U2EXjQbO/qWx9caucRAw2QInXkPrLlYMF8h2d6EpWiMBXNdD34/qxmoaMwyj4mM4aWQdXfoCfPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152838; c=relaxed/simple;
	bh=vkBEp3/NsfXCRxrW91VLgzNMxDWzEcI17duAoJFUnrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr0/lU1MwOMlI6RL3eZ50iL6vfQ9fDwDNEgUt4qtKkr66Sv9X9vouVlgXFnDxhtrX65IZf5iAom01JIiQZeieCFuU9AZLd8V6B4etLJ4rqiT3a/160XXsBBn9t6VDJEu+HjRM2jH3S8vTpy4512U6vc6ba3OfiRvX6WB4DcsHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkUAGJ1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A37C4CEF1;
	Fri, 19 Dec 2025 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766152837;
	bh=vkBEp3/NsfXCRxrW91VLgzNMxDWzEcI17duAoJFUnrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkUAGJ1KWFgLTGs+xblpe8vA30DN0ZwA/O9bpG7nUF+wML5r//zyZ5iLQrJYVGGQy
	 GaPqvGECIg3C/199CLQvHLGFccGIvoSq9vQHNCgxSsGMeW+iYDInyKZwCKbpgJ0Qkz
	 N99yexftMwe+tL9wfWUEONv8GL52tDGWv5p2xu2hzmpAz9hAMj4UfTMaP0R5u6cIWs
	 YNv767A9RtJfZLHVOo4MOY2PHiGrZizhOZgejJSQyl8EcaKCjEAWbnVKs/NbtmN4+E
	 3wvlnjJSIWjlTHHfPAzG18psu+fW6xJrccPXRP89Vrf7EuqgoEEC83zd3T6CeChZ93
	 fM84qODELoOGA==
Date: Fri, 19 Dec 2025 15:00:33 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>
Subject: Re: [PATCH 3/3] HID: multitouch: set INPUT_PROP_PRESSUREPAD based on
 Digitizer/Button Type
Message-ID: <ztzmcb24hdmeyk2nk2vqwgcgy4chhvjubkz7r6hprxuefwjm5s@f4oxcb7q6zzx>
References: <20251121-wip-hid-pressurepad-v1-0-e32e5565a527@who-t.net>
 <20251121-wip-hid-pressurepad-v1-3-e32e5565a527@who-t.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-wip-hid-pressurepad-v1-3-e32e5565a527@who-t.net>

On Nov 21 2025, Peter Hutterer wrote:
> A Digitizer/Button Type value of 1 indicates the device is a
> pressurepad, see
> https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection#device-capabilities-feature-report
> 
> For the selftests we have to resort to a bit of a hack: python-libevdev
> gets the properties from libevdev at module init time. If libevdev
> hasn't been rebuilt with the new property it won't be automatically
> populated. So we hack around this by constructing the property manually.
> 
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
>  drivers/hid/hid-multitouch.c                       | 12 ++++++-
>  .../testing/selftests/hid/tests/test_multitouch.py | 39 +++++++++++++++++++---
>  2 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 179dc316b4b518d78bdc900d9fd15756c5eba83e..382e6f50c4f7e663af7d028abb8be7cb2e6e7b8e 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -81,6 +81,7 @@ MODULE_LICENSE("GPL");
>  #define MT_INPUTMODE_TOUCHPAD		0x03
>  
>  #define MT_BUTTONTYPE_CLICKPAD		0
> +#define MT_BUTTONTYPE_PRESSUREPAD	1
>  
>  enum latency_mode {
>  	HID_LATENCY_NORMAL = 0,
> @@ -179,6 +180,7 @@ struct mt_device {
>  	__u8 inputmode_value;	/* InputMode HID feature value */
>  	__u8 maxcontacts;
>  	bool is_buttonpad;	/* is this device a button pad? */
> +	bool is_pressurepad;	/* is this device a pressurepad? */
>  	bool is_haptic_touchpad;	/* is this device a haptic touchpad? */
>  	bool serial_maybe;	/* need to check for serial protocol */
>  
> @@ -530,8 +532,14 @@ static void mt_feature_mapping(struct hid_device *hdev,
>  		}
>  
>  		mt_get_feature(hdev, field->report);
> -		if (field->value[usage->usage_index] == MT_BUTTONTYPE_CLICKPAD)
> +		switch (field->value[usage->usage_index]) {
> +		case MT_BUTTONTYPE_CLICKPAD:
>  			td->is_buttonpad = true;
> +			break;
> +		case MT_BUTTONTYPE_PRESSUREPAD:
> +			td->is_pressurepad = true;
> +			break;
> +		}
>  
>  		break;
>  	case 0xff0000c5:
> @@ -1393,6 +1401,8 @@ static int mt_touch_input_configured(struct hid_device *hdev,
>  
>  	if (td->is_buttonpad)
>  		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> +	if (td->is_pressurepad)
> +		__set_bit(INPUT_PROP_PRESSUREPAD, input->propbit);
>  
>  	app->pending_palm_slots = devm_kcalloc(&hi->input->dev,
>  					       BITS_TO_LONGS(td->maxcontacts),
> diff --git a/tools/testing/selftests/hid/tests/test_multitouch.py b/tools/testing/selftests/hid/tests/test_multitouch.py
> index a06a087f00b6991f7514adf7f8c713bef1a43563..fa4fb2054bd4febb1d2497f2787944f538b27889 100644
> --- a/tools/testing/selftests/hid/tests/test_multitouch.py
> +++ b/tools/testing/selftests/hid/tests/test_multitouch.py
> @@ -979,15 +979,36 @@ class BaseTest:
>              assert libevdev.InputEvent(libevdev.EV_ABS.ABS_MT_ORIENTATION, 90) in events
>  
>      class TestPTP(TestWin8Multitouch):
> +        def test_buttontype(self):
> +            """Check for the right ButtonType."""
> +            uhdev = self.uhdev
> +            assert uhdev is not None
> +            evdev = uhdev.get_evdev()
> +
> +            # If libevdev.so is not yet compiled with INPUT_PROP_PRESSUREPAD
> +            # python-libevdev won't have it either, let's fake it
> +            if not getattr(libevdev, "INPUT_PROP_PRESSUREPAD", None):
> +                prop = libevdev.InputProperty(name="INPUT_PROP_PRESSUREPAD", value=0x7)
> +                libevdev.INPUT_PROP_PRESSUREPAD = prop
> +                libevdev.props.append(prop)
> +
> +            if uhdev.buttontype == HIDButtonType.CLICKPAD:
> +                assert libevdev.INPUT_PROP_BUTTONPAD in evdev.properties
> +            elif uhdev.buttontype == HIDButtonType.PRESSUREPAD:
> +                assert libevdev.INPUT_PROP_PRESSUREPAD in evdev.properties
> +            else:
> +                assert libevdev.INPUT_PROP_PRESSUREPAD not in evdev.properties
> +                assert libevdev.INPUT_PROP_BUTTONPAD not in evdev.properties
> +
>          def test_ptp_buttons(self):
>              """check for button reliability.
> -            There are 2 types of touchpads: the click pads and the pressure pads.
> -            Each should reliably report the BTN_LEFT events.
> +            There are 3 types of touchpads: click pads + pressure pads and
> +            those with discrete buttons. Each should reliably report the BTN_LEFT events.
>              """
>              uhdev = self.uhdev
>              evdev = uhdev.get_evdev()
>  
> -            if uhdev.buttontype == HIDButtonType.CLICKPAD:
> +            if uhdev.buttontype in [HIDButtonType.CLICKPAD, HIDButtonType.PRESSUREPAD]:
>                  r = uhdev.event(click=True)
>                  events = uhdev.next_sync_events()
>                  self.debug_reports(r, uhdev, events)
> @@ -999,7 +1020,7 @@ class BaseTest:
>                  self.debug_reports(r, uhdev, events)
>                  assert libevdev.InputEvent(libevdev.EV_KEY.BTN_LEFT, 0) in events
>                  assert evdev.value[libevdev.EV_KEY.BTN_LEFT] == 0
> -            else:
> +            elif uhdev.buttontype == HIDButtonType.DISCRETE_BUTTONS:
>                  r = uhdev.event(left=True)
>                  events = uhdev.next_sync_events()
>                  self.debug_reports(r, uhdev, events)
> @@ -2062,6 +2083,16 @@ class Testite_06cb_2968(BaseTest.TestPTP):
>          )
>  
>  
> +class Testven_0488_108c(BaseTest.TestPTP):
> +    def create_device(self):
> +        return PTP(
> +            "uhid test ven_0488_108c",
> +            rdesc="05 01 09 02 a1 01 85 06 09 01 a1 00 05 09 19 01 29
> 03 15 00 25 01 95 03 75 01 81 02 95 01 75 05 81 03 05 01 09 30 09 31 09
> 38 15 81 25 7f 75 08 95 03 81 06 c0 c0 05 0d 09 05 a1 01 85 01 05 0d 09
> 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09
> 51 81 02 81 03 05 01 15 00 26 ba 0d 75 10 55 0e 65 11 09 30 35 00 46 d0
> 05 95 01 81 02 26 d0 06 46 bb 02 09 31 81 02 05 0d 95 01 75 10 26 ff 7f
> 46 ff 7f 09 30 81 02 c0 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02
> 75 01 81 02 95 01 75 03 25 05 09 51 81 02 81 03 05 01 15 00 26 ba 0d 75
> 10 55 0e 65 11 09 30 35 00 46 d0 05 95 01 81 02 26 d0 06 46 bb 02 09 31
> 81 02 05 0d 95 01 75 10 26 ff 7f 46 ff 7f 09 30 81 02 c0 05 0d 09 22 a1
> 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81
> 02 81 03 05 01 15 00 26 ba 0d 75 10 55 0e 65 11 09 30 35 00 46 d0 05 95
> 01 81 02 26 d0 06 46 bb 02 09 31 81 02 05 0d 95 01 75 10 26 ff 7f 46 ff
> 7f 09 30 81 02 c0 55 0c 66 01 10 47 ff ff 00 00 27 ff ff 00 00 75 10 95
> 01 05 0d 09 56 81 02 09 54 25 05 95 01 75 08 81 02 05 09 09 01 25 01 75
> 01 95 01 81 02 95 07 81 03 05 0d 85 02 09 55 75 08 95 01 25 05 b1 02 09
> 59 b1 02 06 00 ff 85 03 09 c5 15 00 26 ff 00 75 08 96 00 01 b1 02 05 0e
> 09 01 a1 02 85 13 09 23 15 00 25 64 75 08 95 01 b1 02 c0 c0 05 0d 09 0e
> a1 01 85 04 09 22 a1 02 09 52 15 00 25 0a 75 08 95 01 b1 02 c0 09 22 a1
> 00 85 05 09 57 09 58 75 01 95 02 25 01 b1 02 95 06 b1 03 c0 c0 06 01 ff
> 09 02 a1 01 09 00 85 07 15 00 26 ff 00 75 08 96 12 02 b1 02 c0 06 00 ff
> 09 01 a1 01 85 0d 15 00 26 ff 00 75 08 95 11 09 01 81 02 09 01 91 02 c0
> 05 0e 09 01 a1 01 85 11 09 35 15 00 26 ff 00 75 08 95 17 b1 02 c0 06 81
> ff 09 01 a1 01 09 20 85 17 15 00 26 ff 00 75 08 95 3f 09 01 81 02 09 01
> 91 02 c0",

Patch is also corrupt here.

Given that you need to send another revision, would you mind splitting
the hid-multitouch.c changes from the selftests?

Cheers,
Benjamin

> +            input_info=(0x18, 0x0488, 0x108C),
> +            buttontype=HIDButtonType.PRESSUREPAD,
> +        )
> +
> +
>  class Testn_trig_1b96_0c01(BaseTest.TestWin8Multitouch):
>      def create_device(self):
>          return Digitizer(
> 
> -- 
> 2.51.1
> 

