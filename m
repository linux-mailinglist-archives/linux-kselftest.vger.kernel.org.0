Return-Path: <linux-kselftest+bounces-37196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DD6B02F3F
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 09:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F097A4DFA
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 07:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D311DEFE0;
	Sun, 13 Jul 2025 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI8SSuho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F91DE8A0;
	Sun, 13 Jul 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752392665; cv=none; b=qdc/GUhqoagqW7mKbvRpwXMJv8Bjkmy1pEZ5DQx3Oh5v71LqXU46hNMHHNodC1Z1xQeU0p5QBiOIv4rihI4KliidLg62/+VA8p3ToYJKktU2K63hBMkaciM8X8D6Uf27/0oA1HhN6vJDzC7X5YfIO5vkYbWWhu2eoFRVMK/AfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752392665; c=relaxed/simple;
	bh=1T55ZVvTbVSqEPW19PQ0DsUTLJOEqRb59DkqWVIWeLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+RDqQEhhgtqhu1HvpL7QKjKGXupJtb1SYh3UAC/n6wqCqmAQymS7b3/Rqsm1Gj6ICzxiaUT5zsEmp0qhotzDPuedHdHuseCUZVx14Jf919v1gbSlrFUowrBTvyH3g+nN/tFjL4lLRF6aCvCejDYPf4/DqeUDHvfG6BH6wvwFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI8SSuho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B06C4CEE3;
	Sun, 13 Jul 2025 07:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752392664;
	bh=1T55ZVvTbVSqEPW19PQ0DsUTLJOEqRb59DkqWVIWeLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hI8SSuhoii5Bhe9YufS/56XfS3Wfuj84STYsMeoKCkVn4C6wZzEW7QbzCFXx9DNAd
	 iFmXmbiDmHN4GenyCp3h99IBjYEBfqSvlx7VzFgL6Sxjry1a72o8JIJxcAgU0Uq6eG
	 9anA3oRlDtrAgNZv+GEKQCebFr3Rf35C3MmPdX0Gk7RxrlQE5TvfnMvi4AmdH+ziL7
	 BQ2riTZlkKA/LzBJr5q3Dvw2Aiw3lvoujE+3P8tqJRlbWAgV89sV1ZRRThTucrxTxQ
	 EcUuuPBOe3hp6CL9Atde9hwPjaFDFcRv/Gra0i/FD7fMrDF82odfXqlisPIVkPZMFH
	 +716xME2DgexQ==
Date: Sun, 13 Jul 2025 09:44:20 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/hid: add a test case for the recent
 syzbot underflow
Message-ID: <qjas3gu47h65hq4ppoagogte6gxi246x7j4sbnd6bi2axo4abc@scun755iynel>
References: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
 <20250710-report-size-null-v2-4-ccf922b7c4e5@kernel.org>
 <o57fhjeipgeb37e2pr6z6qtv3uuon3jsbejj37hgazqxqtklis@c6mumvsempsa>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o57fhjeipgeb37e2pr6z6qtv3uuon3jsbejj37hgazqxqtklis@c6mumvsempsa>

On Jul 11 2025, Benjamin Tissoires wrote:
> On Jul 10 2025, Benjamin Tissoires wrote:
> > Syzbot found a buffer underflow in __hid_request(). Add a related test
> > case for it.
> > 
> > It's not perfect, but it allows to catch a corner case when a report
> > descriptor is crafted so that it has a size of 0.
> > 
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> >  tools/testing/selftests/hid/tests/test_mouse.py | 70 +++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/hid/tests/test_mouse.py b/tools/testing/selftests/hid/tests/test_mouse.py
> > index 66daf7e5975ca50f0b065080669d7f6123fb177f..eb4e15a0e53bd5f3c8e0ea02365ff9da7eead93d 100644
> > --- a/tools/testing/selftests/hid/tests/test_mouse.py
> > +++ b/tools/testing/selftests/hid/tests/test_mouse.py
> > @@ -439,6 +439,68 @@ class BadResolutionMultiplierMouse(ResolutionMultiplierMouse):
> >          return 32  # EPIPE
> >  
> >  
> > +class BadReportDescriptorMouse(BaseMouse):
> > +    """
> > +    This "device" was one autogenerated by syzbot. There are a lot of issues in
> > +    it, and the most problematic is that it declares features that have no
> > +    size.
> > +
> > +    This leads to report->size being set to 0 and can mess up with usbhid
> > +    internals.  Fortunately, uhid merely passes the incoming buffer, without
> > +    touching it so a buffer of size 0 will be translated to [] without
> > +    triggering a kernel oops.
> > +
> > +    Because the report descriptor is wrong, no input are created, and we need
> > +    to tweak a little bit the parameters to make it look correct.
> > +    """
> > +
> > +    # fmt: off
> > +    report_descriptor = [
> > +        0x96, 0x01, 0x00,              # Report Count (1)                    0
> > +        0x06, 0x01, 0x00,              # Usage Page (Generic Desktop)        3
> > +        # 0x03, 0x00, 0x00, 0x00, 0x00,  # Ignored by the kernel somehow
> > +        0x2a, 0x90, 0xa0,              # Usage Maximum (41104)               6
> > +        0x27, 0x00, 0x00, 0x00, 0x00,  # Logical Maximum (0)                 9
> > +        0xb3, 0x81, 0x3e, 0x25, 0x03,  # Feature (Cnst,Arr,Abs,Vol)          14
> > +        0x1b, 0xdd, 0xe8, 0x40, 0x50,  # Usage Minimum (1346431197)          19
> > +        0x3b, 0x5d, 0x8c, 0x3d, 0xda,  # Designator Index                    24
> > +    ]
> > +    # fmt: on
> > +
> > +    def __init__(
> > +        self, rdesc=report_descriptor, name=None, input_info=(3, 0x045E, 0x07DA)
> > +    ):
> > +        super().__init__(rdesc, name, input_info)
> > +        self.high_resolution_report_called = False
> > +
> > +    def get_evdev(self, application=None):
> > +        assert self._input_nodes is None
> > +        return (
> > +            "Ok"  # should be a list or None, but both would fail, so abusing the system
> > +        )
> > +
> > +    def next_sync_events(self, application=None):
> > +        # there are no evdev nodes, so no events
> > +        return []
> > +
> > +    def is_ready(self):
> > +        # we wait for the SET_REPORT command to come
> > +        return self.high_resolution_report_called
> > +
> > +    def set_report(self, req, rnum, rtype, data):
> > +        if rtype != self.UHID_FEATURE_REPORT:
> > +            raise InvalidHIDCommunication(f"Unexpected report type: {rtype}")
> > +        if rnum != 0x0:
> > +            raise InvalidHIDCommunication(f"Unexpected report number: {rnum}")
> > +
> > +        if len(data) != 1:
> > +            raise InvalidHIDCommunication(f"Unexpected data: {data}, expected '[0]'")
> 
> For the record, while thinking more about this, I realized that I
> changed the API for uhid with the previous patches.
> 
> *But* after second thoughts, every request to a HID device made through
> hid_hw_request() would see that change, but every request made through
> hid_hw_raw_request() already has the new behaviour. So that means that
> the users are already facing situations where they might have or not the
> first byte being the null report ID when it is 0, so, maybe we are
> making things more straightforward in the end.
> 

Looking into this more:
- uhid is mainly used for BLE devices
- uhid is also used for testing, but I don't see that change a big issue
- for BLE devices, we can check which kernel module is calling
	hid_hw_request()
- and in those modules, we can check which are using a Bluetooth device
- and then we can check if the command is used with a report ID or not.

Doing all the checks above gives me confidence that the only time the
report ID 0 is used is when using the resolution multiplier. I don't
expect a lot of BLE device without report ID to expose a feature with a
high resolution wheel.

But for a more extensive checking:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/profiles/input/hog-lib.c#n879
in function set_report(), bluez does the same shift if the report ID is
0 and the given buffer has a size > 0.

So I think this patch will also fix a hypothetical BLE device without
report ID with high resolution wheel.

Therefore, I'm going to merge this series as it is (and include those
blobs in the commit description).

Cheers,
Benjamin

> > +
> > +        self.high_resolution_report_called = True
> > +
> > +        return 0
> > +
> > +
> >  class ResolutionMultiplierHWheelMouse(TwoWheelMouse):
> >      # fmt: off
> >      report_descriptor = [
> > @@ -975,3 +1037,11 @@ class TestMiMouse(TestWheelMouse):
> >              # assert below print out the real error
> >              pass
> >          assert remaining == []
> > +
> > +
> > +class TestBadReportDescriptorMouse(base.BaseTestCase.TestUhid):
> > +    def create_device(self):
> > +        return BadReportDescriptorMouse()
> > +
> > +    def assertName(self, uhdev):
> > +        pass
> > 
> > -- 
> > 2.49.0
> > 

