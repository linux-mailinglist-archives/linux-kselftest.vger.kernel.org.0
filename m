Return-Path: <linux-kselftest+bounces-937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D201380034E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 06:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272CFB20CDB
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 05:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404248BE2;
	Fri,  1 Dec 2023 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="hq/7dtSp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zlwrPDgD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B58FF2;
	Thu, 30 Nov 2023 21:50:33 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 0054C5C01FA;
	Fri,  1 Dec 2023 00:50:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 01 Dec 2023 00:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701409832; x=1701496232; bh=HA
	oIgayt4dzQItoKFtBDJpE7xDivsFeofUDonoOwfjc=; b=hq/7dtSp+9qsFQ5n30
	D3iaITLjHEIszLjvGc+96sMRrUO0UQAUuDbEEm7689A32P0SE5yIgJKFo+nzDH2b
	4U+fh96hPUF2f18e8c0mjfapa7xExEcUC85ihsdHGwtyHlx3Z7rZySlG0ZajsrkC
	0EteylAdda0pnuwC8CbVtLL2OgGNuuXGfBFZOJMe3pfKY0mESJuCybMGJQlJUiAU
	+qui/cUOgzxSnFAHkfrz7hIw6auhq52XvSxLn9VDg6mFP2mFey2tkFFR6AifLsFI
	2WPgK4/74twWaGDExETxvBhpL9NzUoc7c5cDc7uRqDZslz+3DhgVoqZscOiTTrkB
	QTFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701409832; x=1701496232; bh=HAoIgayt4dzQI
	toKFtBDJpE7xDivsFeofUDonoOwfjc=; b=zlwrPDgDNo8vLu/voZbluEgHZXWMK
	95BKDtll776PujvD5zpl43jOhvVLLZlcVvPihLb72WuRJuq2nQ2JJ0FNUHpnSnr/
	6UUzblZFXPHp8XGERbXRnhgN1PNWeUenTjxPL3PGrAKzWp0pg2jM2V+dbF/2bBW+
	oe1yzxFjgknmX4ZE+78MPXyRfYBt8yLTtSnKorjXd8gjT1UZuUnWOUgqbVGW9gKx
	QPsNN2GCOqxjqVsHJcGwF4NzpgYc8i9q4jjDXw1+1aE5SUgC5x3vFnUbsk+4ZbAE
	wYFYZlnw+qU1e9CtBQbTxV8vQkxq9Jswam3RNLRze9b6CU9uYEL8gE7rQ==
X-ME-Sender: <xms:KHRpZSwQOceoQgGSajzLDnNj1WrImdjM4D-cxZowCKMgGqHcpbwt6w>
    <xme:KHRpZeSGWXAMWfP0OU5yXQZvA6bYk5g1IJtWwew10fXyd1bub1N056O629go_vhIH
    ab-qYDxmj5AMHD7wHg>
X-ME-Received: <xmr:KHRpZUWf305S7BJ_0Ek-1jakp5A1CUzC1EArPu02bLff76ScVFutxHYSegRMflMFHpzjNMX-JO8CGMPkLtcpHIiwjAwLeG_7tmdq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeffgefgtdegueetffdtkeefveeflefhudeifedvgffh
    geeiheethfeggfekleelfeenucffohhmrghinhepmhhitghrohhsohhfthdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvghtvghr
    rdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:KHRpZYg6zmz2qeUJqMIoJRGv-2M11R0F5O13zTIpR3eKxFCtpC3ywg>
    <xmx:KHRpZUDgCL5wTvjT3sdKIS7Tcme1IVfEH8esVzlVJaQTLPDvwXNckQ>
    <xmx:KHRpZZKXJ5_9BICyMRhIHa3mDfMURzJU6V727f1NWKXpaK0RtYoQRA>
    <xmx:KHRpZT4lX-qL-cwuIVgZubenZcO1HVku9NxYfFQcRH1DhghdTbC1Ng>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 00:50:29 -0500 (EST)
Date: Fri, 1 Dec 2023 15:50:26 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] selftests/hid: tablets: be stricter for some
 transitions
Message-ID: <20231201055026.GA615081@quokka>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
 <20231129-wip-selftests-v1-12-ba15a1fe1b0d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-wip-selftests-v1-12-ba15a1fe1b0d@kernel.org>

On Wed, Nov 29, 2023 at 04:24:37PM +0100, Benjamin Tissoires wrote:
> To accommodate for legacy devices, we rely on the last state of a
> transition to be valid:
> for example when we test PEN_IS_OUT_OF_RANGE to PEN_IS_IN_CONTACT,
> any "normal" device that reports an InRange bit would insert a
> PEN_IS_IN_RANGE state between the 2.
> 
> This is of course valid, but this solution prevents to detect false
> releases emitted by some firmware:
> when pressing an "eraser mode" button, they might send an extra
> PEN_IS_OUT_OF_RANGE that we may want to filter.
> 
> So define 2 sets of transitions: one that is the ideal behavior, and
> one that is OK, it won't break user space, but we have serious doubts
> if we are doing the right thing. And depending on the test, either
> ask only for valid transitions, or tolerate weird ones.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  tools/testing/selftests/hid/tests/test_tablet.py | 122 +++++++++++++++++++----
>  1 file changed, 104 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
> index f24cf2e168a4..625dd9dcb935 100644
> --- a/tools/testing/selftests/hid/tests/test_tablet.py
> +++ b/tools/testing/selftests/hid/tests/test_tablet.py
> @@ -109,7 +109,7 @@ class PenState(Enum):
>  
>          return cls((touch, tool, button))
>  
> -    def apply(self, events) -> "PenState":
> +    def apply(self, events, strict) -> "PenState":

fwiw, if you're doing type annotations anyway, it'd be nice to do them
for args as well, `strict: bool` in this case.

>          if libevdev.EV_SYN.SYN_REPORT in events:
>              raise ValueError("EV_SYN is in the event sequence")
>          touch = self.touch
> @@ -148,13 +148,97 @@ class PenState(Enum):
>              button = None
>  
>          new_state = PenState((touch, tool, button))
> -        assert (
> -            new_state in self.valid_transitions()
> -        ), f"moving from {self} to {new_state} is forbidden"
> +        if strict:
> +            assert (
> +                new_state in self.valid_transitions()
> +            ), f"moving from {self} to {new_state} is forbidden"
> +        else:
> +            assert (
> +                new_state in self.historical_tolerated_transitions()
> +            ), f"moving from {self} to {new_state} is forbidden"
>  
>          return new_state
>  
>      def valid_transitions(self) -> Tuple["PenState", ...]:
> +        """Following the state machine in the URL above.
> +
> +        Note that those transitions are from the evdev point of view, not HID"""
> +        if self == PenState.PEN_IS_OUT_OF_RANGE:
> +            return (
> +                PenState.PEN_IS_OUT_OF_RANGE,
> +                PenState.PEN_IS_IN_RANGE,
> +                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
> +                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
> +                PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
> +                PenState.PEN_IS_IN_CONTACT,
> +                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
> +                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
> +                PenState.PEN_IS_ERASING,
> +            )
> +
> +        if self == PenState.PEN_IS_IN_RANGE:
> +            return (
> +                PenState.PEN_IS_IN_RANGE,
> +                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
> +                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
> +                PenState.PEN_IS_OUT_OF_RANGE,
> +                PenState.PEN_IS_IN_CONTACT,
> +            )
> +
> +        if self == PenState.PEN_IS_IN_CONTACT:
> +            return (
> +                PenState.PEN_IS_IN_CONTACT,
> +                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
> +                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
> +                PenState.PEN_IS_IN_RANGE,
> +            )
> +
> +        if self == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
> +            return (
> +                PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
> +                PenState.PEN_IS_OUT_OF_RANGE,
> +                PenState.PEN_IS_ERASING,
> +            )
> +
> +        if self == PenState.PEN_IS_ERASING:
> +            return (
> +                PenState.PEN_IS_ERASING,
> +                PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
> +            )
> +
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
> +            )
> +
> +        return tuple()
> +
> +    def historical_tolerated_transitions(self) -> Tuple["PenState", ...]:

s/historically/ to be grammatically correct, I guess.


>          """Following the state machine in the URL above, with a couple of addition
>          for skipping the in-range state, due to historical reasons.
>  
> @@ -678,10 +762,12 @@ class BaseTest:
>              self.debug_reports(r, uhdev, events)
>              return events
>  
> -        def validate_transitions(self, from_state, pen, evdev, events):
> +        def validate_transitions(self, from_state, pen, evdev, events, allow_intermediate_states):
>              # check that the final state is correct
>              pen.assert_expected_input_events(evdev)
>  
> +            state = from_state
> +
>              # check that the transitions are valid
>              sync_events = []
>              while libevdev.InputEvent(libevdev.EV_SYN.SYN_REPORT) in events:
> @@ -691,12 +777,12 @@ class BaseTest:
>                  events = events[idx + 1 :]
>  
>                  # now check for a valid transition
> -                from_state = from_state.apply(sync_events)
> +                state = state.apply(sync_events, not allow_intermediate_states)
>  
>              if events:
> -                from_state = from_state.apply(sync_events)
> +                state = state.apply(sync_events, not allow_intermediate_states)
>  
> -        def _test_states(self, state_list, scribble):
> +        def _test_states(self, state_list, scribble, allow_intermediate_states):
>              """Internal method to test against a list of
>              transition between states.
>              state_list is a list of PenState objects
> @@ -711,7 +797,7 @@ class BaseTest:
>              p = Pen(50, 60)
>              uhdev.move_to(p, PenState.PEN_IS_OUT_OF_RANGE)
>              events = self.post(uhdev, p)
> -            self.validate_transitions(cur_state, p, evdev, events)
> +            self.validate_transitions(cur_state, p, evdev, events, allow_intermediate_states)
>  
>              cur_state = p.current_state
>  
> @@ -720,14 +806,14 @@ class BaseTest:
>                      p.x += 1
>                      p.y -= 1
>                      events = self.post(uhdev, p)
> -                    self.validate_transitions(cur_state, p, evdev, events)
> +                    self.validate_transitions(cur_state, p, evdev, events, allow_intermediate_states)
>                      assert len(events) >= 3  # X, Y, SYN
>                  uhdev.move_to(p, state)
>                  if scribble and state != PenState.PEN_IS_OUT_OF_RANGE:
>                      p.x += 1
>                      p.y -= 1
>                  events = self.post(uhdev, p)
> -                self.validate_transitions(cur_state, p, evdev, events)
> +                self.validate_transitions(cur_state, p, evdev, events, allow_intermediate_states)
>                  cur_state = p.current_state
>  
>          @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
> @@ -740,7 +826,7 @@ class BaseTest:
>              we don't have Invert nor Erase bits, so just move in/out-of-range or proximity.
>              https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
>              """
> -            self._test_states(state_list, scribble)
> +            self._test_states(state_list, scribble, False)

not everyone's cup of tea but code like this becomes more immediately
readable as:
              self._test_states(state_list, scribble, allow_intermediate_states=False)


Anyway, this looks good to me (esp the intention) and is
Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

>  
>          @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
>          @pytest.mark.parametrize(
> @@ -754,7 +840,7 @@ class BaseTest:
>              """This is not adhering to the Windows Pen Implementation state machine
>              but we should expect the kernel to behave properly, mostly for historical
>              reasons."""
> -            self._test_states(state_list, scribble)
> +            self._test_states(state_list, scribble, True)
>  
>          @pytest.mark.skip_if_uhdev(
>              lambda uhdev: "Barrel Switch" not in uhdev.fields,
> @@ -770,7 +856,7 @@ class BaseTest:
>          )
>          def test_valid_primary_button_pen_states(self, state_list, scribble):
>              """Rework the transition state machine by adding the primary button."""
> -            self._test_states(state_list, scribble)
> +            self._test_states(state_list, scribble, False)
>  
>          @pytest.mark.skip_if_uhdev(
>              lambda uhdev: "Secondary Barrel Switch" not in uhdev.fields,
> @@ -786,7 +872,7 @@ class BaseTest:
>          )
>          def test_valid_secondary_button_pen_states(self, state_list, scribble):
>              """Rework the transition state machine by adding the secondary button."""
> -            self._test_states(state_list, scribble)
> +            self._test_states(state_list, scribble, False)
>  
>          @pytest.mark.skip_if_uhdev(
>              lambda uhdev: "Invert" not in uhdev.fields,
> @@ -806,7 +892,7 @@ class BaseTest:
>              to erase.
>              https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
>              """
> -            self._test_states(state_list, scribble)
> +            self._test_states(state_list, scribble, False)
>  
>          @pytest.mark.skip_if_uhdev(
>              lambda uhdev: "Invert" not in uhdev.fields,
> @@ -826,7 +912,7 @@ class BaseTest:
>              to erase.
>              https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
>              """
> -            self._test_states(state_list, scribble)
> +            self._test_states(state_list, scribble, True)
>  
>          @pytest.mark.skip_if_uhdev(
>              lambda uhdev: "Invert" not in uhdev.fields,
> @@ -843,7 +929,7 @@ class BaseTest:
>              For example, a pen that has the eraser button might wobble between
>              touching and erasing if the tablet doesn't enforce the Windows
>              state machine."""
> -            self._test_states(state_list, scribble)
> +            self._test_states(state_list, scribble, True)
>  
>  
>  class GXTP_pen(PenDigitizer):
> 
> -- 
> 2.41.0
> 

