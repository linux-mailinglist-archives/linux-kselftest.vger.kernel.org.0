Return-Path: <linux-kselftest+bounces-37079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031CBB019FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 12:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE2F5A30E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D62877E8;
	Fri, 11 Jul 2025 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW5Xl+n1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758F52853F7;
	Fri, 11 Jul 2025 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231152; cv=none; b=fKrmiW4E9oYdi+qVLrjvxLVCxgfs8I4mGFcMrKgRXp93X1Q5owjIKtk/x1QDdb3BgLYKX7qgRIDQhCm52dPS9Uuy285R+O9iiDfsjPUwm1+9T/FxLqKtlmEBLp4eKur5dzcc7SlDeu3nle0wLFx9Ybr5WGdEKfTDTJAS3nYW1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231152; c=relaxed/simple;
	bh=M51lj7BhNQgLWOL2VBV3JnDPQ+P71zt4sn2H1SiZ01k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9YMQyVl4SiQRcljM0nrv9+hT/fog0UxfSxIP2XJoWLmj+L3q+xLt5IvAu4fkSLFpgASmvqQFEhIkMIS1hEQqQHQvVVtNIEW6tkkfAa9AXXjdGSxy4WX0AMS8edtYl+AHLskqCKL8HAiUMiWSNauW9yFjBFVNeVJfGroW1ZLgcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW5Xl+n1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC727C4CEF4;
	Fri, 11 Jul 2025 10:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752231150;
	bh=M51lj7BhNQgLWOL2VBV3JnDPQ+P71zt4sn2H1SiZ01k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dW5Xl+n1UWCve0DbjL1gGjqbkZgtCtumG4TQEwJLn7/b8Bera3FmDuAeOcTMEfBNv
	 zgXipFnvaIVsQCaJkFrMaOSTvX6sNeGE2nGCGcVwJK07mq7rQYVvNXtTHMTc5fGY5e
	 GyjXs576cdOia3DCbl/wmUCmxlo6okOfQDZ+yRT8PKRx/P66Ef6PuaSgpoXzGugkJZ
	 q/jae2KGOP4nyiGuBU086a7snUmBjHwiUZdFmpRNN8hXAI7yggQvVwcYqB6GO+hEU+
	 nJLnDWthdh9eII7cRTs/kltsaWVGzHCT1/cK9mPvjq2jwk64Fc26ZhNIaGzrtUvr1/
	 Zt64/WBpDqXNQ==
Date: Fri, 11 Jul 2025 12:52:25 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/hid: add a test case for the recent
 syzbot underflow
Message-ID: <o57fhjeipgeb37e2pr6z6qtv3uuon3jsbejj37hgazqxqtklis@c6mumvsempsa>
References: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
 <20250710-report-size-null-v2-4-ccf922b7c4e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-report-size-null-v2-4-ccf922b7c4e5@kernel.org>

On Jul 10 2025, Benjamin Tissoires wrote:
> Syzbot found a buffer underflow in __hid_request(). Add a related test
> case for it.
> 
> It's not perfect, but it allows to catch a corner case when a report
> descriptor is crafted so that it has a size of 0.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  tools/testing/selftests/hid/tests/test_mouse.py | 70 +++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/tools/testing/selftests/hid/tests/test_mouse.py b/tools/testing/selftests/hid/tests/test_mouse.py
> index 66daf7e5975ca50f0b065080669d7f6123fb177f..eb4e15a0e53bd5f3c8e0ea02365ff9da7eead93d 100644
> --- a/tools/testing/selftests/hid/tests/test_mouse.py
> +++ b/tools/testing/selftests/hid/tests/test_mouse.py
> @@ -439,6 +439,68 @@ class BadResolutionMultiplierMouse(ResolutionMultiplierMouse):
>          return 32  # EPIPE
>  
>  
> +class BadReportDescriptorMouse(BaseMouse):
> +    """
> +    This "device" was one autogenerated by syzbot. There are a lot of issues in
> +    it, and the most problematic is that it declares features that have no
> +    size.
> +
> +    This leads to report->size being set to 0 and can mess up with usbhid
> +    internals.  Fortunately, uhid merely passes the incoming buffer, without
> +    touching it so a buffer of size 0 will be translated to [] without
> +    triggering a kernel oops.
> +
> +    Because the report descriptor is wrong, no input are created, and we need
> +    to tweak a little bit the parameters to make it look correct.
> +    """
> +
> +    # fmt: off
> +    report_descriptor = [
> +        0x96, 0x01, 0x00,              # Report Count (1)                    0
> +        0x06, 0x01, 0x00,              # Usage Page (Generic Desktop)        3
> +        # 0x03, 0x00, 0x00, 0x00, 0x00,  # Ignored by the kernel somehow
> +        0x2a, 0x90, 0xa0,              # Usage Maximum (41104)               6
> +        0x27, 0x00, 0x00, 0x00, 0x00,  # Logical Maximum (0)                 9
> +        0xb3, 0x81, 0x3e, 0x25, 0x03,  # Feature (Cnst,Arr,Abs,Vol)          14
> +        0x1b, 0xdd, 0xe8, 0x40, 0x50,  # Usage Minimum (1346431197)          19
> +        0x3b, 0x5d, 0x8c, 0x3d, 0xda,  # Designator Index                    24
> +    ]
> +    # fmt: on
> +
> +    def __init__(
> +        self, rdesc=report_descriptor, name=None, input_info=(3, 0x045E, 0x07DA)
> +    ):
> +        super().__init__(rdesc, name, input_info)
> +        self.high_resolution_report_called = False
> +
> +    def get_evdev(self, application=None):
> +        assert self._input_nodes is None
> +        return (
> +            "Ok"  # should be a list or None, but both would fail, so abusing the system
> +        )
> +
> +    def next_sync_events(self, application=None):
> +        # there are no evdev nodes, so no events
> +        return []
> +
> +    def is_ready(self):
> +        # we wait for the SET_REPORT command to come
> +        return self.high_resolution_report_called
> +
> +    def set_report(self, req, rnum, rtype, data):
> +        if rtype != self.UHID_FEATURE_REPORT:
> +            raise InvalidHIDCommunication(f"Unexpected report type: {rtype}")
> +        if rnum != 0x0:
> +            raise InvalidHIDCommunication(f"Unexpected report number: {rnum}")
> +
> +        if len(data) != 1:
> +            raise InvalidHIDCommunication(f"Unexpected data: {data}, expected '[0]'")

For the record, while thinking more about this, I realized that I
changed the API for uhid with the previous patches.

*But* after second thoughts, every request to a HID device made through
hid_hw_request() would see that change, but every request made through
hid_hw_raw_request() already has the new behaviour. So that means that
the users are already facing situations where they might have or not the
first byte being the null report ID when it is 0, so, maybe we are
making things more straightforward in the end.

Cheers,
Benjamin

> +
> +        self.high_resolution_report_called = True
> +
> +        return 0
> +
> +
>  class ResolutionMultiplierHWheelMouse(TwoWheelMouse):
>      # fmt: off
>      report_descriptor = [
> @@ -975,3 +1037,11 @@ class TestMiMouse(TestWheelMouse):
>              # assert below print out the real error
>              pass
>          assert remaining == []
> +
> +
> +class TestBadReportDescriptorMouse(base.BaseTestCase.TestUhid):
> +    def create_device(self):
> +        return BadReportDescriptorMouse()
> +
> +    def assertName(self, uhdev):
> +        pass
> 
> -- 
> 2.49.0
> 

