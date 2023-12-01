Return-Path: <linux-kselftest+bounces-936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0957C80031F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 06:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78832B20E34
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 05:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B230679F0;
	Fri,  1 Dec 2023 05:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="S18Ijh+U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q3QBGAOR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A011737;
	Thu, 30 Nov 2023 21:41:34 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 314F45C00B3;
	Fri,  1 Dec 2023 00:41:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 01 Dec 2023 00:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701409294; x=1701495694; bh=VI
	VAGb1X16We2oTan/QFiX0huQNGmn/H7YzOv7YDoas=; b=S18Ijh+UMM6gDVZfuT
	W86hcOHUunu0QwO2bG4eU7TBOpqVN1tkwOqlcyyCphluWNDVSzwB6f3UCD+Pm8Ig
	/pE1wYvbbi0ayN5JP6zV/BECvXzuZguYykYuFNxQYFygpSsSdZ/eWUy9U07jUBfZ
	HbSNYgp1YQWHT0z80dcyPR2+z1uciMdqvvGjaXsc5YA7k83XK3+NRnd8gqXEM0M2
	iXVqIfcwwk/M1/Kdlhe8dpCQu3s4WQgoxYG7UpRAUHUtqziphng7JW/oIvGIsX0d
	zll1RQJVVlooSH9t0yytRPmgRmi4KFUT2hNepYNKRTrDhUK7xsxDfFrDKkpcVhaF
	z8iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701409294; x=1701495694; bh=VIVAGb1X16We2
	oTan/QFiX0huQNGmn/H7YzOv7YDoas=; b=q3QBGAORBI5++33HEkgkcTR2OaZl9
	dWDf8pIsr5yV8pM+0uL5rzx7rtv1V0N+p/LmZ5keFpl/crM4JWP3CtrBnKr4fp3y
	xjEKTKCVXtvcq3zgVPz2darAskEJJvSjfZnmbWhzsBHgYEskbaXHg5IPTfGSwSvO
	+ykQObSnLizU4oZAt1J43q2nCaV6z/nw5Wy2mhMURMKJfGh1BAMTZ7BtNvQNhiEp
	vp92frOSSm/KhpsaM1mua1mxZ3JIq55iMZcBJnnKKMvCnDZcJPZDWQE6l2ilaLEe
	l4dTheglicggL/lDBpFcCJg4ob9499bB8nD8fwsjTUkO7tAxXRqlpCi0g==
X-ME-Sender: <xms:DXJpZYMrfEw5W37EaQzdJwasQMK87XtIBjSApldNWgqVC2y71Bwrqw>
    <xme:DXJpZe9UsB6L0YZBfHKojw1Ykdw53KdljpsR7h-tmJN-7848BiNjkgnUA5BC3FE7F
    g5mJBLH2uww_B-vP8w>
X-ME-Received: <xmr:DXJpZfQ7FwOzXww0gAkLt7ZPk9N0vddxJwESC_rE-bVBO6UTtZc0BtBTWejp88Hx3nVizDK9AM8tRtL-G1G4Hnb8lQUdYen9kam0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeffgefgtdegueetffdtkeefveeflefhudeifedvgffh
    geeiheethfeggfekleelfeenucffohhmrghinhepmhhitghrohhsohhfthdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvghtvghr
    rdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:DnJpZQsrlVKrpo3EAP0hPWWM2K-NRZBkyC8Mt8VekxJKv6whEdLcrg>
    <xmx:DnJpZQf6lqJ-p-MBo8Z4zGsA3uczzxPIdiRLcunZB3wMDxtpQxt1Zg>
    <xmx:DnJpZU1bRfAqh3SPlWj13Sh66qwvfBCKO0_oBNaimLPsUCL7bAMbWQ>
    <xmx:DnJpZVGehc1imK1clbFanCwG7OL97smbbpCi-rvNs9_Nz6wMVFIv7Q>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 00:41:30 -0500 (EST)
Date: Fri, 1 Dec 2023 15:41:27 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] selftests/hid: tablets: add variants of states
 with buttons
Message-ID: <20231201054127.GA626305@quokka>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
 <20231129-wip-selftests-v1-9-ba15a1fe1b0d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-wip-selftests-v1-9-ba15a1fe1b0d@kernel.org>

On Wed, Nov 29, 2023 at 04:24:34PM +0100, Benjamin Tissoires wrote:
> Turns out that there are transitions that are unlikely to happen:
> for example, having both the tip switch and a button being changed
> at the same time (in the same report) would require either a very talented
> and precise user or a very bad hardware with a very low sampling rate.
> 
> So instead of manually building the button test by hand and forgetting
> about some cases, let's reuse the state machine and transitions we have.
> 
> This patch only adds the states and the valid transitions. The actual
> tests will be replaced later.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  tools/testing/selftests/hid/tests/test_tablet.py | 170 +++++++++++++++++++++--
>  1 file changed, 157 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
> index 83f6501fe984..80269d1a0f0a 100644
> --- a/tools/testing/selftests/hid/tests/test_tablet.py
> +++ b/tools/testing/selftests/hid/tests/test_tablet.py
> @@ -21,22 +21,66 @@ logger = logging.getLogger("hidtools.test.tablet")
>  class PenState(Enum):
>      """Pen states according to Microsoft reference:
>      https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
> -    """
>  
> -    PEN_IS_OUT_OF_RANGE = (False, None)
> -    PEN_IS_IN_RANGE = (False, libevdev.EV_KEY.BTN_TOOL_PEN)
> -    PEN_IS_IN_CONTACT = (True, libevdev.EV_KEY.BTN_TOOL_PEN)
> -    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = (False, libevdev.EV_KEY.BTN_TOOL_RUBBER)
> -    PEN_IS_ERASING = (True, libevdev.EV_KEY.BTN_TOOL_RUBBER)
> +    We extend it with the various buttons when we need to check them.
> +    """
>  
> -    def __init__(self, touch, tool):

It'd be nice to have a comment here what the False refers to. Even
nicer would be an enum class BtnTouch.DOWN so the code is instantly
readable :)

Cheers,
  Peter

> +    PEN_IS_OUT_OF_RANGE = (False, None, None)
> +    PEN_IS_IN_RANGE = (False, libevdev.EV_KEY.BTN_TOOL_PEN, None)
> +    PEN_IS_IN_RANGE_WITH_BUTTON = (
> +        False,
> +        libevdev.EV_KEY.BTN_TOOL_PEN,
> +        libevdev.EV_KEY.BTN_STYLUS,
> +    )
> +    PEN_IS_IN_RANGE_WITH_SECOND_BUTTON = (
> +        False,
> +        libevdev.EV_KEY.BTN_TOOL_PEN,
> +        libevdev.EV_KEY.BTN_STYLUS2,
> +    )
> +    PEN_IS_IN_CONTACT = (True, libevdev.EV_KEY.BTN_TOOL_PEN, None)
> +    PEN_IS_IN_CONTACT_WITH_BUTTON = (
> +        True,
> +        libevdev.EV_KEY.BTN_TOOL_PEN,
> +        libevdev.EV_KEY.BTN_STYLUS,
> +    )
> +    PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON = (
> +        True,
> +        libevdev.EV_KEY.BTN_TOOL_PEN,
> +        libevdev.EV_KEY.BTN_STYLUS2,
> +    )
> +    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = (False, libevdev.EV_KEY.BTN_TOOL_RUBBER, None)
> +    PEN_IS_IN_RANGE_WITH_ERASING_INTENT_WITH_BUTTON = (
> +        False,
> +        libevdev.EV_KEY.BTN_TOOL_RUBBER,
> +        libevdev.EV_KEY.BTN_STYLUS,
> +    )
> +    PEN_IS_IN_RANGE_WITH_ERASING_INTENT_WITH_SECOND_BUTTON = (
> +        False,
> +        libevdev.EV_KEY.BTN_TOOL_RUBBER,
> +        libevdev.EV_KEY.BTN_STYLUS2,
> +    )
> +    PEN_IS_ERASING = (True, libevdev.EV_KEY.BTN_TOOL_RUBBER, None)
> +    PEN_IS_ERASING_WITH_BUTTON = (
> +        True,
> +        libevdev.EV_KEY.BTN_TOOL_RUBBER,
> +        libevdev.EV_KEY.BTN_STYLUS,
> +    )
> +    PEN_IS_ERASING_WITH_SECOND_BUTTON = (
> +        True,
> +        libevdev.EV_KEY.BTN_TOOL_RUBBER,
> +        libevdev.EV_KEY.BTN_STYLUS2,
> +    )
> +
> +    def __init__(self, touch, tool, button):
>          self.touch = touch
>          self.tool = tool
> +        self.button = button
>  
>      @classmethod
>      def from_evdev(cls, evdev) -> "PenState":
>          touch = bool(evdev.value[libevdev.EV_KEY.BTN_TOUCH])
>          tool = None
> +        button = None
>          if (
>              evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER]
>              and not evdev.value[libevdev.EV_KEY.BTN_TOOL_PEN]
> @@ -53,7 +97,17 @@ class PenState(Enum):
>          ):
>              raise ValueError("2 tools are not allowed")
>  
> -        return cls((touch, tool))
> +        # we take only the highest button in account
> +        for b in [libevdev.EV_KEY.BTN_STYLUS, libevdev.EV_KEY.BTN_STYLUS2]:
> +            if bool(evdev.value[b]):
> +                button = b
> +
> +        # the kernel tends to insert an EV_SYN once removing the tool, so
> +        # the button will be released after
> +        if tool is None:
> +            button = None
> +
> +        return cls((touch, tool, button))
>  
>      def apply(self, events) -> "PenState":
>          if libevdev.EV_SYN.SYN_REPORT in events:
> @@ -62,6 +116,8 @@ class PenState(Enum):
>          touch_found = False
>          tool = self.tool
>          tool_found = False
> +        button = self.button
> +        button_found = False
>  
>          for ev in events:
>              if ev == libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH):
> @@ -76,12 +132,22 @@ class PenState(Enum):
>                  if tool_found:
>                      raise ValueError(f"duplicated BTN_TOOL_* in {events}")
>                  tool_found = True
> -                if ev.value:
> -                    tool = ev.code
> -                else:
> -                    tool = None
> +                tool = ev.code if ev.value else None
> +            elif ev in (
> +                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS),
> +                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS2),
> +            ):
> +                if button_found:
> +                    raise ValueError(f"duplicated BTN_STYLUS* in {events}")
> +                button_found = True
> +                button = ev.code if ev.value else None
>  
> -        new_state = PenState((touch, tool))
> +        # the kernel tends to insert an EV_SYN once removing the tool, so
> +        # the button will be released after
> +        if tool is None:
> +            button = None
> +
> +        new_state = PenState((touch, tool, button))
>          assert (
>              new_state in self.valid_transitions()
>          ), f"moving from {self} to {new_state} is forbidden"
> @@ -97,14 +163,20 @@ class PenState(Enum):
>              return (
>                  PenState.PEN_IS_OUT_OF_RANGE,
>                  PenState.PEN_IS_IN_RANGE,
> +                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
> +                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
>                  PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
>                  PenState.PEN_IS_IN_CONTACT,
> +                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
> +                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
>                  PenState.PEN_IS_ERASING,
>              )
>  
>          if self == PenState.PEN_IS_IN_RANGE:
>              return (
>                  PenState.PEN_IS_IN_RANGE,
> +                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
> +                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
>                  PenState.PEN_IS_OUT_OF_RANGE,
>                  PenState.PEN_IS_IN_CONTACT,
>              )
> @@ -112,6 +184,8 @@ class PenState(Enum):
>          if self == PenState.PEN_IS_IN_CONTACT:
>              return (
>                  PenState.PEN_IS_IN_CONTACT,
> +                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
> +                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
>                  PenState.PEN_IS_IN_RANGE,
>                  PenState.PEN_IS_OUT_OF_RANGE,
>              )
> @@ -130,6 +204,38 @@ class PenState(Enum):
>                  PenState.PEN_IS_OUT_OF_RANGE,
>              )
>  
> +        if self == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
> +            return (
> +                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
> +                PenState.PEN_IS_IN_RANGE,
> +                PenState.PEN_IS_OUT_OF_RANGE,
> +                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
> +            )
> +
> +        if self == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
> +            return (
> +                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
> +                PenState.PEN_IS_IN_CONTACT,
> +                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
> +                PenState.PEN_IS_OUT_OF_RANGE,
> +            )
> +
> +        if self == PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON:
> +            return (
> +                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
> +                PenState.PEN_IS_IN_RANGE,
> +                PenState.PEN_IS_OUT_OF_RANGE,
> +                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
> +            )
> +
> +        if self == PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON:
> +            return (
> +                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
> +                PenState.PEN_IS_IN_CONTACT,
> +                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
> +                PenState.PEN_IS_OUT_OF_RANGE,
> +            )
> +
>          return tuple()
>  
>      @staticmethod
> @@ -364,26 +470,64 @@ class PenDigitizer(base.UHIDTestDevice):
>              pen.xtilt = 0
>              pen.ytilt = 0
>              pen.twist = 0
> +            pen.barrelswitch = False
> +            pen.secondarybarrelswitch = False
>          elif state == PenState.PEN_IS_IN_RANGE:
>              pen.tipswitch = False
>              pen.inrange = True
>              pen.invert = False
>              pen.eraser = False
> +            pen.barrelswitch = False
> +            pen.secondarybarrelswitch = False
>          elif state == PenState.PEN_IS_IN_CONTACT:
>              pen.tipswitch = True
>              pen.inrange = True
>              pen.invert = False
>              pen.eraser = False
> +            pen.barrelswitch = False
> +            pen.secondarybarrelswitch = False
> +        elif state == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
> +            pen.tipswitch = False
> +            pen.inrange = True
> +            pen.invert = False
> +            pen.eraser = False
> +            pen.barrelswitch = True
> +            pen.secondarybarrelswitch = False
> +        elif state == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
> +            pen.tipswitch = True
> +            pen.inrange = True
> +            pen.invert = False
> +            pen.eraser = False
> +            pen.barrelswitch = True
> +            pen.secondarybarrelswitch = False
> +        elif state == PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON:
> +            pen.tipswitch = False
> +            pen.inrange = True
> +            pen.invert = False
> +            pen.eraser = False
> +            pen.barrelswitch = False
> +            pen.secondarybarrelswitch = True
> +        elif state == PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON:
> +            pen.tipswitch = True
> +            pen.inrange = True
> +            pen.invert = False
> +            pen.eraser = False
> +            pen.barrelswitch = False
> +            pen.secondarybarrelswitch = True
>          elif state == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
>              pen.tipswitch = False
>              pen.inrange = True
>              pen.invert = True
>              pen.eraser = False
> +            pen.barrelswitch = False
> +            pen.secondarybarrelswitch = False
>          elif state == PenState.PEN_IS_ERASING:
>              pen.tipswitch = False
>              pen.inrange = True
>              pen.invert = False
>              pen.eraser = True
> +            pen.barrelswitch = False
> +            pen.secondarybarrelswitch = False
>  
>          pen.current_state = state
>  
> 
> -- 
> 2.41.0
> 

