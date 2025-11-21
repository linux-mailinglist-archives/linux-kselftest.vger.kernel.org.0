Return-Path: <linux-kselftest+bounces-46164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B47C76D95
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 02:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id CAF9D31497
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B927A103;
	Fri, 21 Nov 2025 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="gON/6Awy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jwIYec9m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493D27703E;
	Fri, 21 Nov 2025 01:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763687266; cv=none; b=FWC0FdCSSB9GSfq1YtDjxLwUzSPKdzw2YYN/TgPoCSOleA8l1Mi/G1GYX63/BVxAUHHK/Qjlwu1T8eSiL3tn6HXvpJtMaoTL8PJHf2R/+lPbAdJd8qgNG8sj+GcUy/1leisqiCUlTrKnoS8pNzDp1BUbcqquC2eqQnM4s6KfHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763687266; c=relaxed/simple;
	bh=aj8jO1hPBjsPtMUS5tjA/50PXJwqy1Z02JzgOhNjvRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8Suiczi4qf/1bShrp5umpdALNzrhEVK9Jcvww9NpxtDurZEL2q9pE7AIUtmmrNgzVkPEw24JfENY+VDSiPnRT8uGXkF4Nn9fkobI4gkUZbTLrEMTDjeA1J1DAHxHySJen50T944XbShk8bN1nIWksM4/L538E5RPX4zFjsLSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=gON/6Awy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jwIYec9m; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3EA2B7A0035;
	Thu, 20 Nov 2025 20:07:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 20 Nov 2025 20:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763687264;
	 x=1763773664; bh=AbCygkFIcWfwu1F6Lp8axQFGJ43F+ftdjxZvH/VM+Ts=; b=
	gON/6AwyYY/FqBy6RYxYs8fcz6qTkDjdJb/IyTwBkMFBNNdHURnRoFd7fM3GdKWl
	qHuPuWugJyEjWBaau072E68lItJt9KjpsTk8lUgn+69PEIVh+HA3tj1skewKr51Z
	9q2D905K0TKtXX8l6BLL9zS13K7IBg6KdUCT3/kWB+jN+aFeoXoKQdHrmBIFBF1p
	wDrgPNkdZjf4Y1JFb1lydk53BOwkjWgSYSNk5PdtWB35LITNj5orK9aG1ZoiraRY
	Jwtz9CjhA4JFH+Ia/7NYssKwKtAcWD5/51Rme6LjBO4MAE7vEsHLzLHhxgmlZ0VU
	QVZiXWuQomE1TMfY1x5DhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763687264; x=
	1763773664; bh=AbCygkFIcWfwu1F6Lp8axQFGJ43F+ftdjxZvH/VM+Ts=; b=j
	wIYec9ml8Z/c1SO7IB66vu+QQ5WW6PKx3MsILEZ3sTUrbyr0WFvVEO/ReUA6cIPQ
	FsPG6lMP4TWV5ZRtXn0RtT8wnksANMr8pRG7PjbLmL7EwruAnIDRgooBUPWbrivr
	NZGD2wjJCcWypP4fTazcy7aJpxaj/E4keNLsbEnCr7y0sb7Z3Kovw15HZ/JWPj1h
	6zVeJHEQKqTZ1nle4YE6xM96FUG6Sn1F/+ZVxTzQ4aBDACawPhFDDb6lMAUliSN5
	pFcSuAYXdfXN6ByB1fAi8m+sJMGY2MG6LYv7O+Ezmv3Au0QOf+Jrk8nHEgmsrUbR
	GpEj33AS+nC/9zmMdNVhg==
X-ME-Sender: <xms:X7sfaegZv3IMn8CWAoyHcglmT7wJR2jfAUGc9w3W5OxVEbJEgdRoGw>
    <xme:X7sfafctJrDjGyUvi2N2yvtRv9tMsrw_RoOOm9vxFIBjxIPFApT5E-UXK378WD9FK
    Nnxakn6pLs2m_dOV76cPrNRojKxHpj3A7qjqIVVYBNt9u_dI7_aSPY>
X-ME-Received: <xmr:X7sfaWx4SKjpcAKrlzFzsg-jZxBDcjA1XC_UDRYHM9vQ6H_q0FFhb-EW_kqiVuhWp2XstBEV7_ikoOUXv9e6M6D99fKB8mg1ynJY7vOaPsQzwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrvghtvghr
    ucfjuhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
    eqnecuggftrfgrthhtvghrnhepgffgffevfffgjedvkeefgeeuhfeihfefkeegjeettdel
    ueeiueegtedvkeevgfeknecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgvthgv
    rhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtpdhnsggprhgtphhtthhopeelpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepug
    hmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehvrggu
    ihhmsegtihhrqhhuvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvsh
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhdrhhhuthht
    vghrvghrseifhhhoqdhtrdhnvghtpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:X7sfae00aOaO39GGrUHMf8JmwOJ0lr3yse5kF51uvqNmIJkZ8k23mQ>
    <xmx:X7sfacyvDX79ZA8WxPNKuZZ-VFZVEnQcP-QeqCWepn05ixPSAuaL5w>
    <xmx:X7sfaTUjSiB1Dec53CiiD__qqyFA-fPfpusIHK_wW-cwfFYvNIV0-A>
    <xmx:X7sfaY9zLCLhoHI_9gOycyd-1HecWydkdvxFrcWBQb9Wf3j2bzNjVA>
    <xmx:YLsfaSv7UHwVkdSsG0YQhCc_h65ngkKPzQR7OcjZZ9M0fWL1MTxMEM9Z>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 20:07:41 -0500 (EST)
From: Peter Hutterer <peter.hutterer@who-t.net>
Date: Fri, 21 Nov 2025 11:07:12 +1000
Subject: [PATCH 2/3] selftests/hid: use a enum class for the different
 button types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-wip-hid-pressurepad-v1-2-e32e5565a527@who-t.net>
References: <20251121-wip-hid-pressurepad-v1-0-e32e5565a527@who-t.net>
In-Reply-To: <20251121-wip-hid-pressurepad-v1-0-e32e5565a527@who-t.net>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7116;
 i=peter.hutterer@who-t.net; h=from:subject:message-id;
 bh=Lc3IOQF10ywFvV7hlfa4v/mu7pLgSPj6/TO/Ja4brfA=;
 b=owGbwMvMwCT4yLquYEv6h/2Mp9WSGDLld4eerdeYribW+jRmYZjMPWG1l71vp03t3HwwX2KXR
 +ftUnbnjlgWBkEmBlkxRRYbHeebLrWRFu9dA1/DzGFlAhnCwMUpABO5uZNhfhBn92Zj18AVGS1X
 tx6Rjl5TrHrhJcOC7p/C6xbpT/3K5v6xwmGlUesdGyVxAA==
X-Developer-Key: i=peter.hutterer@who-t.net; a=openpgp;
 fpr=3C2C43D9447D5938EF4551EBE23B7E70B467F0BF

Instead of multiple spellings of a string-provided argument, let's make
this a tad more type-safe and use an enum here.

And while we do this fix the two wrong devices:
- elan_04f3_313a (HP ZBook Fury 15) is discrete button pad
- dell_044e_1220 (Dell Precision 7740) is a discrete button pad

Equivalent hid-tools commit
https://gitlab.freedesktop.org/libevdev/hid-tools/-/commit/8300a55bf4213c6a252cab8cb5b34c9ddb191625

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 .../testing/selftests/hid/tests/test_multitouch.py | 24 +++++++++++++---------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_multitouch.py b/tools/testing/selftests/hid/tests/test_multitouch.py
index ece0ba8e7d34b75d42245e5936ecf804c46b0846..a06a087f00b6991f7514adf7f8c713bef1a43563 100644
--- a/tools/testing/selftests/hid/tests/test_multitouch.py
+++ b/tools/testing/selftests/hid/tests/test_multitouch.py
@@ -9,6 +9,7 @@
 from . import base
 from hidtools.hut import HUT
 from hidtools.util import BusType
+import enum
 import libevdev
 import logging
 import pytest
@@ -232,11 +233,17 @@ class Digitizer(base.UHIDTestDevice):
         return 0
 
 
+class HIDButtonType(enum.IntEnum):
+    CLICKPAD = 0
+    PRESSUREPAD = 1
+    DISCRETE_BUTTONS = 2
+
+
 class PTP(Digitizer):
     def __init__(
         self,
         name,
-        type="Click Pad",
+        buttontype=HIDButtonType.CLICKPAD,
         rdesc_str=None,
         rdesc=None,
         application="Touch Pad",
@@ -244,11 +251,8 @@ class PTP(Digitizer):
         max_contacts=None,
         input_info=None,
     ):
-        self.type = type.lower().replace(" ", "")
-        if self.type == "clickpad":
-            self.buttontype = 0
-        else:  # pressurepad
-            self.buttontype = 1
+        self.buttontype = buttontype
+
         self.clickpad_state = False
         self.left_state = False
         self.right_state = False
@@ -983,7 +987,7 @@ class BaseTest:
             uhdev = self.uhdev
             evdev = uhdev.get_evdev()
 
-            if uhdev.type == "clickpad":
+            if uhdev.buttontype == HIDButtonType.CLICKPAD:
                 r = uhdev.event(click=True)
                 events = uhdev.next_sync_events()
                 self.debug_reports(r, uhdev, events)
@@ -1918,7 +1922,7 @@ class Testdell_044e_1220(BaseTest.TestPTP):
     def create_device(self):
         return PTP(
             "uhid test dell_044e_1220",
-            type="pressurepad",
+            buttontype=HIDButtonType.DISCRETE_BUTTONS,
             rdesc="05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29
03 15 00 25 01 75 01 95 03 81 02 95 05 81 01 05 01 09 30 09 31 15 81 25
7f 75 08 95 02 81 06 09 38 95 01 81 06 05 0c 0a 38 02 81 06 c0 c0 05 0d
09 05 a1 01 85 08 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02
95 01 75 03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 26 af 04 75
10 55 0e 65 11 09 30 35 00 46 e8 03 95 01 81 02 26 7b 02 46 12 02 09 31
81 02 c0 55 0c 66 01 10 47 ff ff 00 00 27 ff ff 00 00 75 10 95 01 05 0d
09 56 81 02 09 54 25 05 95 01 75 08 81 02 05 09 19 01 29 03 25 01 75 01
95 03 81 02 95 05 81 03 05 0d 85 09 09 55 75 08 95 01 25 05 b1 02 06 00
ff 85 0a 09 c5 15 00 26 ff 00 75 08 96 00 01 b1 02 c0 06 01 ff 09 01 a1
01 85 03 09 01 15 00 26 ff 00 95 1b 81 02 85 04 09 02 95 50 81 02 85 05
09 03 95 07 b1 02 85 06 09 04 81 02 c0 06 02 ff 09 01 a1 01 85 07 09 02
95 86 75 08 b1 02 c0 05 0d 09 0e a1 01 85 0b 09 22 a1 02 09 52 15 00 25
0a 75 08 95 01 b1 02 c0 09 22 a1 00 85 0c 09 57 09 58 75 01 95 02 25 01
b1 02 95 06 b1 03 c0 c0",
         )
 
@@ -2018,7 +2022,7 @@ class Testelan_04f3_313a(BaseTest.TestPTP):
     def create_device(self):
         return PTP(
             "uhid test elan_04f3_313a",
-            type="touchpad",
+            buttontype=HIDButtonType.DISCRETE_BUTTONS,
             input_info=(BusType.I2C, 0x04F3, 0x313A),
             rdesc="05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29
03 15 00 25 01 75 01 95 03 81 02 95 05 81 03 05 01 09 30 09 31 15 81 25
7f 75 08 95 02 81 06 75 08 95 05 81 03 c0 06 00 ff 09 01 85 0e 09 c5 15
00 26 ff 00 75 08 95 04 b1 02 85 0a 09 c6 15 00 26 ff 00 75 08 95 04 b1
02 c0 06 00 ff 09 01 a1 01 85 5c 09 01 95 0b 75 08 81 06 85 0d 09 c5 15
00 26 ff 00 75 08 95 04 b1 02 85 0c 09 c6 96 80 03 75 08 b1 02 85 0b 09
c7 95 82 75 08 b1 02 c0 05 0d 09 05 a1 01 85 04 09 22 a1 02 15 00 25 01
09 47 09 42 95 02 75 01 81 02 05 09 09 02 09 03 15 00 25 01 75 01 95 02
81 02 05 0d 95 01 75 04 25 0f 09 51 81 02 05 01 15 00 26 d7 0e 75 10 55
0d 65 11 09 30 35 00 46 44 2f 95 01 81 02 46 12 16 26 eb 06 26 eb 06 09
31 81 02 05 0d 15 00 25 64 95 03 c0 55 0c 66 01 10 47 ff ff 00 00 27 ff
ff 00 00 75 10 95 01 09 56 81 02 09 54 25 7f 95 01 75 08 81 02 25 01 75
01 95 08 81 03 09 c5 75 08 95 02 81 03 05 0d 85 02 09 55 09 59 75 04 95
02 25 0f b1 02 85 07 09 60 75 01 95 01 15 00 25 01 b1 02 95 0f b1 03 06
00 ff 06 00 ff 85 06 09 c5 15 00 26 ff 00 75 08 96 00 01 b1 02 c0 05 0d
09 0e a1 01 85 03 09 22 a1 00 09 52 15 00 25 0a 75 10 95 01 b1 02 c0 09
22 a1 00 85 05 09 57 09 58 75 01 95 02 25 01 b1 02 95 0e b1 03 c0 c0 05
01 09 02 a1 01 85 2a 09 01 a1 00 05 09 19 01 29 03 15 00 25 01 75 01 95
03 81 02 95 05 81 03 05 01 09 30 09 31 15 81 25 7f 35 81 45 7f 55 00 65
13 75 08 95 02 81 06 75 08 95 05 81 03 c0 c0",
         )
@@ -2110,7 +2114,7 @@ class Testsipodev_0603_0002(BaseTest.TestPTP):
     def create_device(self):
         return PTP(
             "uhid test sipodev_0603_0002",
-            type="clickpad",
+            buttontype=HIDButtonType.CLICKPAD,
             rdesc="05 01 09 02 a1 01 85 03 09 01 a1 00 05 09 19 01 29
02 25 01 75 01 95 02 81 02 95 06 81 03 05 01 09 30 09 31 15 80 25 7f 75
08 95 02 81 06 c0 c0 05 0d 09 05 a1 01 85 04 09 22 a1 02 15 00 25 01 09
47 09 42 95 02 75 01 81 02 75 01 95 02 81 03 95 01 75 04 25 05 09 51 81
02 05 01 15 00 26 44 0a 75 0c 55 0e 65 11 09 30 35 00 46 ac 03 95 01 81
02 46 fe 01 26 34 05 75 0c 09 31 81 02 05 0d c0 55 0c 66 01 10 47 ff ff
00 00 27 ff ff 00 00 75 10 95 01 09 56 81 02 09 54 25 0a 95 01 75 04 81
02 75 01 95 03 81 03 05 09 09 01 25 01 75 01 95 01 81 02 05 0d 85 0a 09
55 09 59 75 04 95 02 25 0f b1 02 85 0b 09 60 75 01 95 01 15 00 25 01 b1
02 95 07 b1 03 85 09 06 00 ff 09 c5 15 00 26 ff 00 75 08 96 00 01 b1 02
c0 05 0d 09 0e a1 01 85 06 09 22 a1 02 09 52 15 00 25 0a 75 08 95 01 b1
02 c0 09 22 a1 00 85 07 09 57 09 58 75 01 95 02 25 01 b1 02 95 06 b1 03
c0 c0 05 01 09 0c a1 01 85 08 15 00 25 01 09 c6 75 01 95 01 81 06 75 07
81 03 c0 05 01 09 80 a1 01 85 01 15 00 25 01 75 01 0a 81 00 0a 82 00 0a
83 00 95 03 81 06 95 05 81 01 c0 06 0c 00 09 01 a1 01 85 02 25 01 15 00
75 01 0a b5 00 0a b6 00 0a b7 00 0a cd 00 0a e2 00 0a a2 00 0a e9 00 0a
ea 00 95 08 81 02 0a 83 01 0a 6f 00 0a 70 00 0a 88 01 0a 8a 01 0a 92 01
0a a8 02 0a 24 02 95 08 81 02 0a 21 02 0a 23 02 0a 96 01 0a 25 02 0a 26
02 0a 27 02 0a 23 02 0a b1 02 95 08 81 02 c0 06 00 ff 09 01 a1 01 85 05
15 00 26 ff 00 19 01 29 02 75 08 95 05 b1 02 c0",
         )
 

-- 
2.51.1


