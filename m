Return-Path: <linux-kselftest+bounces-46093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0B1C738FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2B4E62BFAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492EE315767;
	Thu, 20 Nov 2025 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5qMLTiS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2051A23BF9C;
	Thu, 20 Nov 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636006; cv=none; b=NqfelsHzDYecnmSrpS3ILW12b6wMER04wxLHd/29/5gcLhV5FgsGd7fcUKV/nYK40K8bL2FKVkmXcGHN5aSEXhfW0A//aBuABeYr77rYQbQdudnoxlIMos/IjC7Jhyo3cxEL/HLA/s7QIoHK4Mz4ijWJvnU3eChhY1+EdMXe11Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636006; c=relaxed/simple;
	bh=3aWGyKh+4pSYIAH3l2yvH8Yb93l4QLZEop9JnOkqe3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+e9UxAVi5zGpExXFxNZkDvFj8IWJxpiyZZ6HvvE9f4eQcuOPYqnk/dk4wOH4sWKRiN2jnI5DLegM76bQYyVBXTyv9h0/jJvMTPP84VVlrA1Pf0uxoxFjjc52hb/frGPUuussfQxQRy5b5bW8XfXiqAtKeC4szCVPLpM8hDx3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5qMLTiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58263C4CEF1;
	Thu, 20 Nov 2025 10:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763636005;
	bh=3aWGyKh+4pSYIAH3l2yvH8Yb93l4QLZEop9JnOkqe3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5qMLTiSILeSxOk74lvYZgbjmRN2wxGy73B9l48sNvB//Dz66c03RjNzFOyu/NXUK
	 KvstWhbmtsi8eXJrZ+nCPU4IC8+P5iFRZRuXFQUD+kK1PKgRb7NfLs6uDZtQX7wWUT
	 jD+A4koBxZ9zumW40xFThz9QIf7sz+HPtT8Cfe92R7X/O+cf/S+4xyKvasD6thS/9x
	 WsOvI3WkNz1RNkcX3VbbJCWwjFfoxRuPwos/oEsGmIm0B9yKrhELVI1+tIizpunJic
	 N3ELeAMj3sdwgyASCjJZ807c6YTuTOznURfpmzHpvm8yl1YImBk2vrBjRUs/NsBCpa
	 qbE1VTvRrXQDA==
Date: Thu, 20 Nov 2025 11:53:21 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: jikos@kernel.org, shuah@kernel.org, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] selftests: hid: tests: test_wacom_generic: add base
 test for display devices and opaque devices
Message-ID: <awbmhna3hkra2eoc7lcl23d3mzfsk7qty5t4zl3m7s6hau3v4u@uzqkqudwttlp>
References: <20251117014721.3142490-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117014721.3142490-1-alex.t.tran@gmail.com>

Hi Alex,

On Nov 16 2025, Alex Tran wrote:
> Verify Wacom devices set INPUT_PROP_DIRECT appropriately on display devices
> and INPUT_PROP_POINTER appropriately on opaque devices. Tests are defined
> in the base class and disabled for inapplicable device types.
> 
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> ---
>  .../selftests/hid/tests/test_wacom_generic.py       | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/tools/testing/selftests/hid/tests/test_wacom_generic.py
> index 2d6d04f0f..aa2a175f2 100644
> --- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
> +++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
> @@ -600,15 +600,17 @@ class BaseTest:
>  
>          def test_prop_direct(self):
>              """
> -            Todo: Verify that INPUT_PROP_DIRECT is set on display devices.
> +            Verify that INPUT_PROP_DIRECT is set on display devices.
>              """
> -            pass
> +            evdev = self.uhdev.get_evdev()
> +            assert libevdev.INPUT_PROP_DIRECT in evdev.properties
>  
>          def test_prop_pointer(self):
>              """
> -            Todo: Verify that INPUT_PROP_POINTER is set on opaque devices.
> +            Verify that INPUT_PROP_POINTER is set on opaque devices.
>              """
> -            pass
> +            evdev = self.uhdev.get_evdev()
> +            assert libevdev.INPUT_PROP_POINTER in evdev.properties
>  
>  
>  class PenTabletTest(BaseTest.TestTablet):
> @@ -622,6 +624,8 @@ class TouchTabletTest(BaseTest.TestTablet):
>  
>  
>  class TestOpaqueTablet(PenTabletTest):
> +    test_prop_direct = None

That seems very awkward to do.

Why not drop the 2 tests from the TestTablet class, move
`test_prop_direct()` in that subclass (TestOpaqueTablet), and add a new
TestDirectTablet class that TestDTH2452Tablet will be a subclass of?

Basically try to make better use of subclassing instead of adding the
tests at the top level class and selectively remove them in the
subclasses.

Cheers,
Benjamin

> +
>      def create_device(self):
>          return OpaqueTablet()
>  
> @@ -864,6 +868,7 @@ class TestPTHX60_Pen(TestOpaqueCTLTablet):
>  
>  class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest):
>      ContactIds = namedtuple("ContactIds", "contact_id, tracking_id, slot_num")
> +    test_prop_pointer = None
>  
>      def create_device(self):
>          return test_multitouch.Digitizer(
> -- 
> 2.51.0
> 

