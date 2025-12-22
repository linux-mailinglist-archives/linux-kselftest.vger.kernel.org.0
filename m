Return-Path: <linux-kselftest+bounces-47816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD87CD4E08
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 08:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 878EE3007952
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED9530F529;
	Mon, 22 Dec 2025 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="j4Z7O2XQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EiXe7zye"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE3244692;
	Mon, 22 Dec 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766389012; cv=none; b=lhwH8Bm9EtSnJ+bb2xA0R7nS6g7BnYuyQrT/AgivKADlbwSywbbycGl+Eyi9gVXxRnHsi4mODlzou4zDuvkeIz6DibIIkGolcw5ATCQLMgbvQT/KUHZfkJUhaildr+JYKKmeHMr7nhjI630A8nRviiS5UdSEDTa+HPRsV+jH6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766389012; c=relaxed/simple;
	bh=ccZ9aZCUdKjWKE/97kgDcPBVbuqHGmW/nuML7bsqJF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr/rmP23Dics18yDrOJ81be8/3IYJ6+CLn7HByfgVM2oz6PVkGTLA/xu97QBEYv5a8VAzEDHhy8xBnhdUhvKA/d1zhZytjtYYBAB55KmgPkzQqwNxhVtjN84ZhjkgFBWe2f6mjclsFh3rfpPjqnnKGaBPxW6WJNdVF2oqxwi7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=j4Z7O2XQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EiXe7zye; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 56D71EC00E6;
	Mon, 22 Dec 2025 02:36:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 22 Dec 2025 02:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766389007;
	 x=1766475407; bh=AI44dLTmHl+MVSvOAdK5Ib2ucEmYOTRiMWOCfXcJgNA=; b=
	j4Z7O2XQEchtaurlJxko9fPEYAK0WsmVD94Ss7Dvw7MH6LH24oO5e9DjiIaZChO6
	3TZpDB9hWAD6NidChxZiyUP5mmHXPacPmsvYD7X0n6a2zpbJdodz8YszDiXUHa2f
	52GNWGxyvvgbU6JA2+C/vLjl0VTeleEJc0Xx7h1bzilhc49jTwyRd2F7wLE97Dj0
	18/RHeiWxXWSq2zNLLvofSSZfxlps7DZf+9v8V6MTWr/F8yi5z37WM7Uk8KrkkXV
	5cpRI0ng9zjAxCLvBR4UBFJR4C+YSpnu+xi4Sh4eiWvWcHAbgDYgC9nRj3YWaTLY
	vKdawuMmFdiJU41worL9fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766389007; x=
	1766475407; bh=AI44dLTmHl+MVSvOAdK5Ib2ucEmYOTRiMWOCfXcJgNA=; b=E
	iXe7zye6ynWO5J3JmN0j4B3TBj5pZTfT1PYOGZO/fSGlrdZmswX4AHnizKldHUUR
	gCiaCGMKdjpdwgshk038FH983g4nXkafdAU7+tazKq+5SvFrMlfgshHTbC2ixyEE
	DKGtpafy5t3tVLY6GoHUVvwVkpcwdLEljWhNysHqpaBiQ7K6yYT6m4wzVvXyQwvP
	7f6cLDuPJ7cOL+kQar0n/UMIiLxEVZj/q2raJo0RLMa0zybTQMt1siQ0qHa7Tiq2
	MyZvWYlJUD2uDk4dq1C3LeWLLPHpYutIZI3G/7oA5gAobLMqrKJcG+eLrcnbXsst
	P3eB0zb7kxJk/YTUXQwGg==
X-ME-Sender: <xms:D_VIaS8aJoEA4sBbGviaLP8SzTfK-k2MhxtEs3ngCP6T8nvEToYTZQ>
    <xme:D_VIaTIWtS_Swg0ecB3ZlDI1GZreeWkJB6aL-DgHSCiubkjfOFU4nat9CITTpGMOm
    ezzk_EjqTgejWG0Et0Q2AoTwIlJcTgnuWpexs-RXJc2auxFWvJFC6E>
X-ME-Received: <xmr:D_VIaYtbKp0TwS3n6ie5coP50TNbRcy1KcJ3aXM_8JJgoSLZuM3yhzeKWxISd7MwiIYdaXShQK89UZOAn5NdSdHiPxCYqekCgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthhqsfdttddtvdenucfhrhhomheprfgvthgvrhcu
    jfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtqe
    enucggtffrrghtthgvrhhnpeehuefgudejteetgfejteffgefhfeevledtveelgeeuveel
    feegkeelffehvddtleenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvghtvghr
    rdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvthdpnhgspghrtghpthhtohepledpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhhnuhhllhdophgvthgvrhdrhhhuthht
    vghrvghrrdifhhhoqdhtrdhnvghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjih
    hkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnthhishhssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegumhhithhrhidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepvhgrughimhestghirhhquhgvrdgtohhm
X-ME-Proxy: <xmx:D_VIaSDDN18RvecgwpK0eFNfZI31uVz4wchNsWKYI0Ez1aLQyjZBRA>
    <xmx:D_VIaYMNM7nAWkYGdsQn_HbTT8QNhYFiMuN6rvwldNgJzpIqgE20dQ>
    <xmx:D_VIaSB0GfgFqiV4lc3K_S_ukBNXYm3wgOMnGPqO1vaJ58SRHV6CMQ>
    <xmx:D_VIaZ4JyapZRFDaLnacLM209NA97NZvB0K1XSHKd9s44O0J4fEpMA>
    <xmx:D_VIaYylSClEDb9fBX-y854W5obao_UncNej-rdzDWNzHN4uGk3lVf4s>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Dec 2025 02:36:44 -0500 (EST)
Date: Mon, 22 Dec 2025 17:36:39 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Peter Hutterer via B4 Relay <devnull+peter.hutterer.who-t.net@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>
Subject: Re: [PATCH v2 3/4] selftests/hid: use a enum class for the different
 button types
Message-ID: <ghanyk4fsqczosltb75nvs3woj6dnfhbgglnmwoczgzl7fxbuz@6yr4sgshntzv>
References: <20251222-wip-hid-pressurepad-v2-0-054ac9689bb7@who-t.net>
 <20251222-wip-hid-pressurepad-v2-3-054ac9689bb7@who-t.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251222-wip-hid-pressurepad-v2-3-054ac9689bb7@who-t.net>

On Mon, Dec 22, 2025 at 09:43:36AM +1000, Peter Hutterer via B4 Relay wrote:
> From: Peter Hutterer <peter.hutterer@who-t.net>
>=20
> Instead of multiple spellings of a string-provided argument, let's make
> this a tad more type-safe and use an enum here.
>=20
> And while we do this fix the two wrong devices:
> - elan_04f3_313a (HP ZBook Fury 15) is discrete button pad
> - dell_044e_1220 (Dell Precision 7740) is a discrete button pad
>=20
> Equivalent hid-tools commit
> https://gitlab.freedesktop.org/libevdev/hid-tools/-/commit/8300a55bf4213c=
6a252cab8cb5b34c9ddb191625
>=20
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>

looks like 3 and 4 from this series are still linewrapped because
the patches (thanks to the rdesc) exceed 998 characters. This happeed
with earlier patches but those got merged from a local repo by Benjamin
so no-one noticed. I've filed an MR in hid-tools to wrap them, we'll
need to sync these to the kernel tree before we can file patches via
email.

https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/182

Cheers,
  Peter

> ---
>  .../testing/selftests/hid/tests/test_multitouch.py | 24 +++++++++++++---=
------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>=20
> diff --git a/tools/testing/selftests/hid/tests/test_multitouch.py b/tools=
/testing/selftests/hid/tests/test_multitouch.py
> index ece0ba8e7d34b75d42245e5936ecf804c46b0846..a06a087f00b6991f7514adf7f=
8c713bef1a43563 100644
> --- a/tools/testing/selftests/hid/tests/test_multitouch.py
> +++ b/tools/testing/selftests/hid/tests/test_multitouch.py
> @@ -9,6 +9,7 @@
>  from . import base
>  from hidtools.hut import HUT
>  from hidtools.util import BusType
> +import enum
>  import libevdev
>  import logging
>  import pytest
> @@ -232,11 +233,17 @@ class Digitizer(base.UHIDTestDevice):
>          return 0
> =20
> =20
> +class HIDButtonType(enum.IntEnum):
> +    CLICKPAD =3D 0
> +    PRESSUREPAD =3D 1
> +    DISCRETE_BUTTONS =3D 2
> +
> +
>  class PTP(Digitizer):
>      def __init__(
>          self,
>          name,
> -        type=3D"Click Pad",
> +        buttontype=3DHIDButtonType.CLICKPAD,
>          rdesc_str=3DNone,
>          rdesc=3DNone,
>          application=3D"Touch Pad",
> @@ -244,11 +251,8 @@ class PTP(Digitizer):
>          max_contacts=3DNone,
>          input_info=3DNone,
>      ):
> -        self.type =3D type.lower().replace(" ", "")
> -        if self.type =3D=3D "clickpad":
> -            self.buttontype =3D 0
> -        else:  # pressurepad
> -            self.buttontype =3D 1
> +        self.buttontype =3D buttontype
> +
>          self.clickpad_state =3D False
>          self.left_state =3D False
>          self.right_state =3D False
> @@ -983,7 +987,7 @@ class BaseTest:
>              uhdev =3D self.uhdev
>              evdev =3D uhdev.get_evdev()
> =20
> -            if uhdev.type =3D=3D "clickpad":
> +            if uhdev.buttontype =3D=3D HIDButtonType.CLICKPAD:
>                  r =3D uhdev.event(click=3DTrue)
>                  events =3D uhdev.next_sync_events()
>                  self.debug_reports(r, uhdev, events)
> @@ -1918,7 +1922,7 @@ class Testdell_044e_1220(BaseTest.TestPTP):
>      def create_device(self):
>          return PTP(
>              "uhid test dell_044e_1220",
> -            type=3D"pressurepad",
> +            buttontype=3DHIDButtonType.DISCRETE_BUTTONS,
>              rdesc=3D"05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 =
03 15 00 25 01 75 01 95 03 81 02 95 05 81 01 05 01 09 30 09 31 15 81 25 7f =
75 08 95 02 81 06 09 38 95 01 81 06 05 0c 0a 38 02 81 06 c0 c0 05 0d 09 05 =
a1 01 85 08 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 =
03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 26 af 04 75 10 55 0e 65 =
11 09 30 35 00 46 e8 03 95 01 81 02 26 7b 02 46 12 02 09 31 81 02 c0 55 0c =
66 01 10 47 ff ff 00 00 27 ff ff 00 00 75 10 95 01 05 0d 09 56 81 02 09 54 =
25 05 95 01 75 08 81 02 05 09 19 01 29 03 25 01 75 01 95 03 81 02 95 05 81 =
03 05 0d 85 09 09 55 75 08 95 01 25 05 b1 02 06 00 ff 85 0a 09 c5 15 00 26 =
ff 00 75 08 96 00 01 b1 02 c0 06 01 ff 09 01 a1 01 85 03 09 01 15 00 26 ff =
00 95 1b 81 02 85 04 09 02 95 50 81 02 85 05 09 03 95 07 b1 02 85 06 09 04 =
81 02 c0 06 02 ff 09 01 a1 01 85 07 09 02 95 86 75 08 b1 02 c0 05 0d 09 0e =
a1 01 85 0b 09 22 a1 02 09 52 15 00 25 0a 75 08 95 01 b1 02 c0 09 22 a1 00 =
85 0c 09 57 09 58 75 01 95=20
>  02 25 01 b1 02 95 06 b1 03 c0 c0",
>          )
> =20
> @@ -2018,7 +2022,7 @@ class Testelan_04f3_313a(BaseTest.TestPTP):
>      def create_device(self):
>          return PTP(
>              "uhid test elan_04f3_313a",
> -            type=3D"touchpad",
> +            buttontype=3DHIDButtonType.DISCRETE_BUTTONS,
>              input_info=3D(BusType.I2C, 0x04F3, 0x313A),
>              rdesc=3D"05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 =
03 15 00 25 01 75 01 95 03 81 02 95 05 81 03 05 01 09 30 09 31 15 81 25 7f =
75 08 95 02 81 06 75 08 95 05 81 03 c0 06 00 ff 09 01 85 0e 09 c5 15 00 26 =
ff 00 75 08 95 04 b1 02 85 0a 09 c6 15 00 26 ff 00 75 08 95 04 b1 02 c0 06 =
00 ff 09 01 a1 01 85 5c 09 01 95 0b 75 08 81 06 85 0d 09 c5 15 00 26 ff 00 =
75 08 95 04 b1 02 85 0c 09 c6 96 80 03 75 08 b1 02 85 0b 09 c7 95 82 75 08 =
b1 02 c0 05 0d 09 05 a1 01 85 04 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 =
75 01 81 02 05 09 09 02 09 03 15 00 25 01 75 01 95 02 81 02 05 0d 95 01 75 =
04 25 0f 09 51 81 02 05 01 15 00 26 d7 0e 75 10 55 0d 65 11 09 30 35 00 46 =
44 2f 95 01 81 02 46 12 16 26 eb 06 26 eb 06 09 31 81 02 05 0d 15 00 25 64 =
95 03 c0 55 0c 66 01 10 47 ff ff 00 00 27 ff ff 00 00 75 10 95 01 09 56 81 =
02 09 54 25 7f 95 01 75 08 81 02 25 01 75 01 95 08 81 03 09 c5 75 08 95 02 =
81 03 05 0d 85 02 09 55 09 59 75 04 95 02 25 0f b1 02 85 07 09 60 75 01 95 =
01 15 00 25 01 b1 02 95 0f=20
>  b1 03 06 00 ff 06 00 ff 85 06 09 c5 15 00 26 ff 00 75 08 96 00 01 b1 02 =
c0 05 0d 09 0e a1 01 85 03 09 22 a1 00 09 52 15 00 25 0a 75 10 95 01 b1 02 =
c0 09 22 a1 00 85 05 09 57 09 58 75 01 95 02 25 01 b1 02 95 0e b1 03 c0 c0 =
05 01 09 02 a1 01 85 2a 09 01 a1 00 05 09 19 01 29 03 15 00 25 01 75 01 95 =
03 81 02 95 05 81 03 05 01 09 30 09 31 15 81 25 7f 35 81 45 7f 55 00 65 13 =
75 08 95 02 81 06 75 08 95 05 81 03 c0 c0",
>          )
> @@ -2110,7 +2114,7 @@ class Testsipodev_0603_0002(BaseTest.TestPTP):
>      def create_device(self):
>          return PTP(
>              "uhid test sipodev_0603_0002",
> -            type=3D"clickpad",
> +            buttontype=3DHIDButtonType.CLICKPAD,
>              rdesc=3D"05 01 09 02 a1 01 85 03 09 01 a1 00 05 09 19 01 29 =
02 25 01 75 01 95 02 81 02 95 06 81 03 05 01 09 30 09 31 15 80 25 7f 75 08 =
95 02 81 06 c0 c0 05 0d 09 05 a1 01 85 04 09 22 a1 02 15 00 25 01 09 47 09 =
42 95 02 75 01 81 02 75 01 95 02 81 03 95 01 75 04 25 05 09 51 81 02 05 01 =
15 00 26 44 0a 75 0c 55 0e 65 11 09 30 35 00 46 ac 03 95 01 81 02 46 fe 01 =
26 34 05 75 0c 09 31 81 02 05 0d c0 55 0c 66 01 10 47 ff ff 00 00 27 ff ff =
00 00 75 10 95 01 09 56 81 02 09 54 25 0a 95 01 75 04 81 02 75 01 95 03 81 =
03 05 09 09 01 25 01 75 01 95 01 81 02 05 0d 85 0a 09 55 09 59 75 04 95 02 =
25 0f b1 02 85 0b 09 60 75 01 95 01 15 00 25 01 b1 02 95 07 b1 03 85 09 06 =
00 ff 09 c5 15 00 26 ff 00 75 08 96 00 01 b1 02 c0 05 0d 09 0e a1 01 85 06 =
09 22 a1 02 09 52 15 00 25 0a 75 08 95 01 b1 02 c0 09 22 a1 00 85 07 09 57 =
09 58 75 01 95 02 25 01 b1 02 95 06 b1 03 c0 c0 05 01 09 0c a1 01 85 08 15 =
00 25 01 09 c6 75 01 95 01 81 06 75 07 81 03 c0 05 01 09 80 a1 01 85 01 15 =
00 25 01 75 01 0a 81 00 0a=20
>  82 00 0a 83 00 95 03 81 06 95 05 81 01 c0 06 0c 00 09 01 a1 01 85 02 25 =
01 15 00 75 01 0a b5 00 0a b6 00 0a b7 00 0a cd 00 0a e2 00 0a a2 00 0a e9 =
00 0a ea 00 95 08 81 02 0a 83 01 0a 6f 00 0a 70 00 0a 88 01 0a 8a 01 0a 92 =
01 0a a8 02 0a 24 02 95 08 81 02 0a 21 02 0a 23 02 0a 96 01 0a 25 02 0a 26 =
02 0a 27 02 0a 23 02 0a b1 02 95 08 81 02 c0 06 00 ff 09 01 a1 01 85 05 15 =
00 26 ff 00 19 01 29 02 75 08 95 05 b1 02 c0",
>          )
> =20
>=20
> --=20
> 2.51.1
>=20
>=20

