Return-Path: <linux-kselftest+bounces-46165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 153ABC76D89
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 02:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93CE1356FC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAB527FD4F;
	Fri, 21 Nov 2025 01:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="0ZI0JWnB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArBBjmzR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241C274FDC;
	Fri, 21 Nov 2025 01:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763687270; cv=none; b=ioBz2cOWhjxKhki6B/01ob2ObKLuVhrpXPqQjH13w13u6tgCqwcyRNFcKvIs9y8cp/dP+2hBoecumk5z7ZRpIiI/td5Zk0IclPljGyjIB3lQDzp/zkwHzQ1LH8q3Ho/7n3BXiinbFryAg/SNDPaX8kUTNKSORU8DoFrfw1cSpjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763687270; c=relaxed/simple;
	bh=Fe9UHUAmq7/WInUlOtK/pd6bKsZ1wCLJviDVoGEZC1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9QfcQeZKxhKcAvpghxesc3QHsw09RGXpqjcutYVPQeBSkJwe6EO7M7jwohR8A+YgbhW3DsXKH990fUrrDribroMegDI2qqxz79CeMqouTRb/DXtNhZPRO0bH1zsI8Es45xggx0zF6EGv++CA7j20z9wWFBVAIeY1jsuuekUtN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=0ZI0JWnB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArBBjmzR; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 03C2D1D00061;
	Thu, 20 Nov 2025 20:07:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 20 Nov 2025 20:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763687267;
	 x=1763773667; bh=flExpwKsOFLn3nGWjFeZND6vqUIE/ZguTyJ+0e3fyUY=; b=
	0ZI0JWnBOT+C5yEKXy3skX81pQBmFySm72CNYFcskgnrZyPTFidaDPiVnyqoHqKY
	Y3F9li7BLAXfWT0PxWuoBhyW8+4Aaaiut8S7G/ub7q9OCXc8GKK/b3gd+MISlXGW
	qPHDC3OYDDEZmDdjAthGulq2o5U1gXIysNz2OO58RbvF9lQ8EqAdj17uB3SG3WvK
	LGwcL05h5hDJhjYas1jV95LaONyv1f7AI8nYlQm+t3PWtv24mUuU8CjIWKRYSBnB
	Twdv96wClorIUqzfDFPHF9US4yoLAGOH0wyU+c1Yd/w0LIKf895qDrpx/mxfUUPN
	vJCRThkNCfLJqZ1vAt2YcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763687267; x=
	1763773667; bh=flExpwKsOFLn3nGWjFeZND6vqUIE/ZguTyJ+0e3fyUY=; b=A
	rBBjmzR5mKpOenN7bOFF8xBmZ0iD/hvUOaRy0BfvD9kNtiKDILLmgFaI5SC5ZJOH
	E+1GEAk/L9rCmlZugESuUVrLAINsDwjtKGhoh+dr+9uD2jfsm5zF7yuBpxmzKpA2
	S6lCNd7FLL3waJZO12Z07R/2iVxkD3/meVIT+ELNG8iRwmuh2iSIDi34FDnY+mPi
	4A+qTjNj+pmNYkEBoKFaGV0F0XpVGAcrTWEoJ9smv4DNnlNXs+PLGOv0K9TSAdTu
	1U4sGN1/ulTyjpeUO3pEyKo/7iKGr8UlI+G6l4P1XKHlEhPuOQ2L81u4mwlD5MxW
	FkdKTm97YQE0YNlrXHLNg==
X-ME-Sender: <xms:Y7sfac72MR3In1YWt2wBinF6Ki4Pb8oDmkFo4HT5SLSnR9Hv3_LzVw>
    <xme:Y7sfaeXfjI0hGFsdWZ2fBOPrtdzYg0zKLB0Ofqz5kl2VnwhNYoI0Lk1Dhdd5MBrKe
    8G5NO441au8c7ZTcCaKUQ86FhwqAXe9IKBoIgVV45r8cCNolf0B9mg>
X-ME-Received: <xmr:Y7sfacIORpwPFd-pT5Rc8BRr26m9RK5Q8KD2cN8LC2aKYVvMeReRPm1m5PYwXvqJ7FGRFT5v-GbXEHzDVnPZBe8LJIMujyCslu5uyqekooMDkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrvghtvghr
    ucfjuhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
    eqnecuggftrfgrthhtvghrnhepteegfffhleetvedugfffhfekleehvedvkedtffevfeel
    ledtgfdtffehieevjeeknecuffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgvthgvrhdr
    hhhuthhtvghrvghrseifhhhoqdhtrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughmih
    htrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehvrgguihhm
    segtihhrqhhuvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhdrhhhuthhtvghr
    vghrseifhhhoqdhtrdhnvghtpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:Y7sfaYt7usnGGck72qXuV6R-sWVsDqaPB7E5DnLfj9BA9YaRGDblmA>
    <xmx:Y7sfaRK1L1GnOlzUncBK4LGVloWwXrj-e6u1XfE7wxoQWmDUHQ5qJQ>
    <xmx:Y7sfaQNGCydOJ8dBEp4KFN1cn2pEudrsv_I59HACK6tMeywk7MbS5w>
    <xmx:Y7sfaUVZlUEzamPr21l4rLd2b3MXc9ELFgIrayaOU_qtXu5lPQ8Vfg>
    <xmx:Y7sfaUnaSOyFKhqFyndLZfM9krFqj_W5Ldb6Izr05lWEO8Ry9xm438on>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 20:07:44 -0500 (EST)
From: Peter Hutterer <peter.hutterer@who-t.net>
Date: Fri, 21 Nov 2025 11:07:13 +1000
Subject: [PATCH 3/3] HID: multitouch: set INPUT_PROP_PRESSUREPAD based on
 Digitizer/Button Type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-wip-hid-pressurepad-v1-3-e32e5565a527@who-t.net>
References: <20251121-wip-hid-pressurepad-v1-0-e32e5565a527@who-t.net>
In-Reply-To: <20251121-wip-hid-pressurepad-v1-0-e32e5565a527@who-t.net>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7507;
 i=peter.hutterer@who-t.net; h=from:subject:message-id;
 bh=/eg4/R7xVnJBKIdFDgm4ajRb980bl2bFPJm1VxyKdVY=;
 b=owGbwMvMwCT4yLquYEv6h/2Mp9WSGDLld4ee/ujJeUta+inz7PvVziVrA67tfPJ/8vPWG3aKr
 7f5Jjy42hHLwiDIxCArpshio+N806U20uK9a+BrmDmsTCBDGLg4BWAiWvoMc2VeGMw8+MS66Xjr
 kn9B7Axvt4kmCTEsmJKo3B86yeHSNs/NVrfWRR+6vPLBMwA=
X-Developer-Key: i=peter.hutterer@who-t.net; a=openpgp;
 fpr=3C2C43D9447D5938EF4551EBE23B7E70B467F0BF

A Digitizer/Button Type value of 1 indicates the device is a
pressurepad, see
https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection#device-capabilities-feature-report

For the selftests we have to resort to a bit of a hack: python-libevdev
gets the properties from libevdev at module init time. If libevdev
hasn't been rebuilt with the new property it won't be automatically
populated. So we hack around this by constructing the property manually.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/hid/hid-multitouch.c                       | 12 ++++++-
 .../testing/selftests/hid/tests/test_multitouch.py | 39 +++++++++++++++++++---
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 179dc316b4b518d78bdc900d9fd15756c5eba83e..382e6f50c4f7e663af7d028abb8be7cb2e6e7b8e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -81,6 +81,7 @@ MODULE_LICENSE("GPL");
 #define MT_INPUTMODE_TOUCHPAD		0x03
 
 #define MT_BUTTONTYPE_CLICKPAD		0
+#define MT_BUTTONTYPE_PRESSUREPAD	1
 
 enum latency_mode {
 	HID_LATENCY_NORMAL = 0,
@@ -179,6 +180,7 @@ struct mt_device {
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
 	bool is_buttonpad;	/* is this device a button pad? */
+	bool is_pressurepad;	/* is this device a pressurepad? */
 	bool is_haptic_touchpad;	/* is this device a haptic touchpad? */
 	bool serial_maybe;	/* need to check for serial protocol */
 
@@ -530,8 +532,14 @@ static void mt_feature_mapping(struct hid_device *hdev,
 		}
 
 		mt_get_feature(hdev, field->report);
-		if (field->value[usage->usage_index] == MT_BUTTONTYPE_CLICKPAD)
+		switch (field->value[usage->usage_index]) {
+		case MT_BUTTONTYPE_CLICKPAD:
 			td->is_buttonpad = true;
+			break;
+		case MT_BUTTONTYPE_PRESSUREPAD:
+			td->is_pressurepad = true;
+			break;
+		}
 
 		break;
 	case 0xff0000c5:
@@ -1393,6 +1401,8 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 
 	if (td->is_buttonpad)
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+	if (td->is_pressurepad)
+		__set_bit(INPUT_PROP_PRESSUREPAD, input->propbit);
 
 	app->pending_palm_slots = devm_kcalloc(&hi->input->dev,
 					       BITS_TO_LONGS(td->maxcontacts),
diff --git a/tools/testing/selftests/hid/tests/test_multitouch.py b/tools/testing/selftests/hid/tests/test_multitouch.py
index a06a087f00b6991f7514adf7f8c713bef1a43563..fa4fb2054bd4febb1d2497f2787944f538b27889 100644
--- a/tools/testing/selftests/hid/tests/test_multitouch.py
+++ b/tools/testing/selftests/hid/tests/test_multitouch.py
@@ -979,15 +979,36 @@ class BaseTest:
             assert libevdev.InputEvent(libevdev.EV_ABS.ABS_MT_ORIENTATION, 90) in events
 
     class TestPTP(TestWin8Multitouch):
+        def test_buttontype(self):
+            """Check for the right ButtonType."""
+            uhdev = self.uhdev
+            assert uhdev is not None
+            evdev = uhdev.get_evdev()
+
+            # If libevdev.so is not yet compiled with INPUT_PROP_PRESSUREPAD
+            # python-libevdev won't have it either, let's fake it
+            if not getattr(libevdev, "INPUT_PROP_PRESSUREPAD", None):
+                prop = libevdev.InputProperty(name="INPUT_PROP_PRESSUREPAD", value=0x7)
+                libevdev.INPUT_PROP_PRESSUREPAD = prop
+                libevdev.props.append(prop)
+
+            if uhdev.buttontype == HIDButtonType.CLICKPAD:
+                assert libevdev.INPUT_PROP_BUTTONPAD in evdev.properties
+            elif uhdev.buttontype == HIDButtonType.PRESSUREPAD:
+                assert libevdev.INPUT_PROP_PRESSUREPAD in evdev.properties
+            else:
+                assert libevdev.INPUT_PROP_PRESSUREPAD not in evdev.properties
+                assert libevdev.INPUT_PROP_BUTTONPAD not in evdev.properties
+
         def test_ptp_buttons(self):
             """check for button reliability.
-            There are 2 types of touchpads: the click pads and the pressure pads.
-            Each should reliably report the BTN_LEFT events.
+            There are 3 types of touchpads: click pads + pressure pads and
+            those with discrete buttons. Each should reliably report the BTN_LEFT events.
             """
             uhdev = self.uhdev
             evdev = uhdev.get_evdev()
 
-            if uhdev.buttontype == HIDButtonType.CLICKPAD:
+            if uhdev.buttontype in [HIDButtonType.CLICKPAD, HIDButtonType.PRESSUREPAD]:
                 r = uhdev.event(click=True)
                 events = uhdev.next_sync_events()
                 self.debug_reports(r, uhdev, events)
@@ -999,7 +1020,7 @@ class BaseTest:
                 self.debug_reports(r, uhdev, events)
                 assert libevdev.InputEvent(libevdev.EV_KEY.BTN_LEFT, 0) in events
                 assert evdev.value[libevdev.EV_KEY.BTN_LEFT] == 0
-            else:
+            elif uhdev.buttontype == HIDButtonType.DISCRETE_BUTTONS:
                 r = uhdev.event(left=True)
                 events = uhdev.next_sync_events()
                 self.debug_reports(r, uhdev, events)
@@ -2062,6 +2083,16 @@ class Testite_06cb_2968(BaseTest.TestPTP):
         )
 
 
+class Testven_0488_108c(BaseTest.TestPTP):
+    def create_device(self):
+        return PTP(
+            "uhid test ven_0488_108c",
+            rdesc="05 01 09 02 a1 01 85 06 09 01 a1 00 05 09 19 01 29
03 15 00 25 01 95 03 75 01 81 02 95 01 75 05 81 03 05 01 09 30 09 31 09
38 15 81 25 7f 75 08 95 03 81 06 c0 c0 05 0d 09 05 a1 01 85 01 05 0d 09
22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09
51 81 02 81 03 05 01 15 00 26 ba 0d 75 10 55 0e 65 11 09 30 35 00 46 d0
05 95 01 81 02 26 d0 06 46 bb 02 09 31 81 02 05 0d 95 01 75 10 26 ff 7f
46 ff 7f 09 30 81 02 c0 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02
75 01 81 02 95 01 75 03 25 05 09 51 81 02 81 03 05 01 15 00 26 ba 0d 75
10 55 0e 65 11 09 30 35 00 46 d0 05 95 01 81 02 26 d0 06 46 bb 02 09 31
81 02 05 0d 95 01 75 10 26 ff 7f 46 ff 7f 09 30 81 02 c0 05 0d 09 22 a1
02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81
02 81 03 05 01 15 00 26 ba 0d 75 10 55 0e 65 11 09 30 35 00 46 d0 05 95
01 81 02 26 d0 06 46 bb 02 09 31 81 02 05 0d 95 01 75 10 26 ff 7f 46 ff
7f 09 30 81 02 c0 55 0c 66 01 10 47 ff ff 00 00 27 ff ff 00 00 75 10 95
01 05 0d 09 56 81 02 09 54 25 05 95 01 75 08 81 02 05 09 09 01 25 01 75
01 95 01 81 02 95 07 81 03 05 0d 85 02 09 55 75 08 95 01 25 05 b1 02 09
59 b1 02 06 00 ff 85 03 09 c5 15 00 26 ff 00 75 08 96 00 01 b1 02 05 0e
09 01 a1 02 85 13 09 23 15 00 25 64 75 08 95 01 b1 02 c0 c0 05 0d 09 0e
a1 01 85 04 09 22 a1 02 09 52 15 00 25 0a 75 08 95 01 b1 02 c0 09 22 a1
00 85 05 09 57 09 58 75 01 95 02 25 01 b1 02 95 06 b1 03 c0 c0 06 01 ff
09 02 a1 01 09 00 85 07 15 00 26 ff 00 75 08 96 12 02 b1 02 c0 06 00 ff
09 01 a1 01 85 0d 15 00 26 ff 00 75 08 95 11 09 01 81 02 09 01 91 02 c0
05 0e 09 01 a1 01 85 11 09 35 15 00 26 ff 00 75 08 95 17 b1 02 c0 06 81
ff 09 01 a1 01 09 20 85 17 15 00 26 ff 00 75 08 95 3f 09 01 81 02 09 01
91 02 c0",
+            input_info=(0x18, 0x0488, 0x108C),
+            buttontype=HIDButtonType.PRESSUREPAD,
+        )
+
+
 class Testn_trig_1b96_0c01(BaseTest.TestWin8Multitouch):
     def create_device(self):
         return Digitizer(

-- 
2.51.1


