Return-Path: <linux-kselftest+bounces-48665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB91FD0D3E0
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 10:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4ABAF3005F3C
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 09:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C823D7E6;
	Sat, 10 Jan 2026 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5nbRnqk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59650097C;
	Sat, 10 Jan 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768036833; cv=none; b=Awo/PPnAdFoY1M4rLwTp/ASLjM3MTWbECTVLBKM/IB2qsDfcRg4MQnqvYJ7JzSUaaYzf9C5xk8g/IZZF9l+TX/FrN5XuO9Ax4F8GCagQSYUl99/ijK7LgD/vETECOrEcjDQu3eE9IyG4twDbXguaWK7+aaJ+lmlmVdpCbyMcaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768036833; c=relaxed/simple;
	bh=KKQtxoH3rYBYZwb0H4z4PIa/K3M/KmoAeEeb+nV8ZC0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=exxHtQsBNupm3kjyZEwRAGmN7vKapBDTRB6rGv//UwJ49/MlOZhEbjmgYfbrNgjaupiNJuY0/hj5HkE9q9kSmIFjBbIvgQYscjVbdqmAG7xjK8+9nfX+Ntuh1IUDYmFgWXjARvdsgSg7YuMpv1TvmeMDTdzodLMqzvOBm9Ehz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5nbRnqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BABC4CEF1;
	Sat, 10 Jan 2026 09:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768036832;
	bh=KKQtxoH3rYBYZwb0H4z4PIa/K3M/KmoAeEeb+nV8ZC0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=e5nbRnqkrmpqJL669y3TwB7vzH359xmBdq58AvNVfsZhcyXqx39qkfWb2OsZLQ0XV
	 9LKDvxIDzM/JKvtXhcSHXlSBWLdeGRvhDqMEMJosc5gzgpFnLUPpDSqYdjuM3jTruE
	 MdFpH7jE1rNW29Lot6vOKiy8LLOoaq2SfYEFVgUg4hWlI99R8y87hcy3evvXr2Qtd+
	 ABqyrsluMRbEGaecyXhTFXrxwGQh6BbWP14QoarCLsSeza1zJVfOoDylk24JSgS6y/
	 5AtV40MwYKfRiparTR4D77qvwlzXxrIOIq75K1egLrkXZHldorYp7+o5gzU3HjnzHx
	 7XEXIdSE71jGg==
Date: Sat, 10 Jan 2026 10:20:30 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Alex Tran <alex.t.tran@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, shuah@kernel.org, 
    linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
    Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Subject: Re: [PATCH v2 RESEND] selftests: hid: tests: test_wacom_generic:
 add tests for display devices and opaque devices
In-Reply-To: <20251220204811.3539836-1-alex.t.tran@gmail.com>
Message-ID: <38r99s88-7pp2-6s6n-2148-34s5rrs4s225@xreary.bet>
References: <20251220204811.3539836-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 20 Dec 2025, Alex Tran wrote:

> Verify Wacom devices set INPUT_PROP_DIRECT on display devices and
> INPUT_PROP_POINTER on opaque devices. Moved test_prop_pointer into
> TestOpaqueTablet. Created a DirectTabletTest mixin class for 
> test_prop_direct that can be inherited by display tablet test classes.
> Used DirectTabletTest for TestDTH2452Tablet case.
> 
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>

Let me CC Benjamin and Wacom folks to take a look here as well.

> ---
> Changes in v2:
> - Removed the tests from the BaseTest class
> - Removed disabling tests for certain subclasses
> - Moved test_prop_pointer under TestOpaqueTablet
> - Created DirectTabletTest mixin class
> - Moved test_prop_direct under TestDTH2452Tablet
>  .../selftests/hid/tests/test_wacom_generic.py | 30 +++++++++++--------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/tools/testing/selftests/hid/tests/test_wacom_generic.py
> index 2d6d04f0f..9d0b0802d 100644
> --- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
> +++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
> @@ -598,18 +598,6 @@ class BaseTest:
>                  if unit_set:
>                      assert required[usage].contains(field)
>  
> -        def test_prop_direct(self):
> -            """
> -            Todo: Verify that INPUT_PROP_DIRECT is set on display devices.
> -            """
> -            pass
> -
> -        def test_prop_pointer(self):
> -            """
> -            Todo: Verify that INPUT_PROP_POINTER is set on opaque devices.
> -            """
> -            pass
> -
>  
>  class PenTabletTest(BaseTest.TestTablet):
>      def assertName(self, uhdev):
> @@ -677,6 +665,13 @@ class TestOpaqueTablet(PenTabletTest):
>              uhdev.event(130, 240, pressure=0), [], auto_syn=False, strict=True
>          )
>  
> +    def test_prop_pointer(self):
> +        """
> +        Verify that INPUT_PROP_POINTER is set on opaque devices.
> +        """
> +        evdev = self.uhdev.get_evdev()
> +        assert libevdev.INPUT_PROP_POINTER in evdev.properties
> +
>  
>  class TestOpaqueCTLTablet(TestOpaqueTablet):
>      def create_device(self):
> @@ -862,7 +857,16 @@ class TestPTHX60_Pen(TestOpaqueCTLTablet):
>          )
>  
>  
> -class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest):
> +class DirectTabletTest():
> +    def test_prop_direct(self):
> +        """
> +        Verify that INPUT_PROP_DIRECT is set on display devices.
> +        """
> +        evdev = self.uhdev.get_evdev()
> +        assert libevdev.INPUT_PROP_DIRECT in evdev.properties
> +
> +
> +class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest, DirectTabletTest):
>      ContactIds = namedtuple("ContactIds", "contact_id, tracking_id, slot_num")
>  
>      def create_device(self):
> -- 
> 2.51.0
> 

-- 
Jiri Kosina
SUSE Labs


