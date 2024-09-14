Return-Path: <linux-kselftest+bounces-17977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB24978DD0
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 07:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE108B26414
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 05:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E2781742;
	Sat, 14 Sep 2024 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTmTbFyc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD3171E76;
	Sat, 14 Sep 2024 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291566; cv=none; b=Rvv6NGvRrY1X3wvh/Wp1aI/qdmXYinAJHX4LfQGDSerP1PqMKPNRQZtKxNJz6UTJDyMskL4iaMGD0HVZodMitEHa5il29BLzsl8GGEAbz8//iERqVyHT1+ie9THBpDRVfvp3DmDjYqAX21PtFZISw5VfpJNyQeYDxcf9SczR3rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291566; c=relaxed/simple;
	bh=SptWBzVXVMO961EGzmJjmAEgdxo1I93o+UdFRaq7ucE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upYeUFOACZ/x/1x4IsppVElnbdIl3bPEY5Bj9GJScHjM3eZGBz6tJh+bvm7UPg1SKNeBt/Txb69jyssKs0/88S5XY/TNO6tPDHZ4XTzWqXVkxPhvG5iFGwt9khV6AWnqn4m96cBWf1ZXd2PcEbZELSTU+UsVZpEzTOA35f5We1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTmTbFyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B04DC4CEC0;
	Sat, 14 Sep 2024 05:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726291566;
	bh=SptWBzVXVMO961EGzmJjmAEgdxo1I93o+UdFRaq7ucE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTmTbFycChuNMeGaHfPrZmdAbuR5rxnULYrzBMhnfK/wtKHPS/qqAmyyZeXvpq76l
	 OZDesFb/Fk8aDRwmHVHmxht5iPzLdXFYWxrDuI0SXIYok06vZ306PCyMjzvvqUDf66
	 jXxrfS9f5Qa/rZ8RsooguQeIAbcuy3+v6JIAd0Er2ICI71PnPiIit071LMRh3rcLDn
	 MXJRDmnFZSsT6cpRAjBIGeGwuoxk68peuSdB0Rp8SzX7sBu7hcdv274Uu2I5OPc39R
	 R0jU03EkR3UXdLvoJ19RrVmRogZ13XJGk+U+hEcDgtZ1Qiwf6MugG7PEgY7htLmJXX
	 0vCmtwSocQ+sw==
Date: Sat, 14 Sep 2024 07:26:01 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
	Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: (subset) [PATCH HID v2 00/11] HID: bpf: add a new hook to
 control hid-generic
Message-ID: <7al2grhs6qatjmxk2tft6widqfjwnklfljpppufy4ee62cehcy@peo2shxwyk5b>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
 <172623473588.1192461.11090201509053454593.b4-ty@kernel.org>
 <etbeblypdylnngwuwjfqkmkduk4iup7uq4c5zkwrssoi6u7jvg@gtf3gpzrloii>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <etbeblypdylnngwuwjfqkmkduk4iup7uq4c5zkwrssoi6u7jvg@gtf3gpzrloii>

On Sep 13 2024, Benjamin Tissoires wrote:
> On Sep 13 2024, Benjamin Tissoires wrote:
> > On Tue, 10 Sep 2024 23:43:36 +0900, Benjamin Tissoires wrote:
> > > This is a slight change from the fundamentals of HID-BPF.
> > > In theory, HID-BPF is abstract to the kernel itself, and makes
> > > only changes at the HID level (through report descriptors or
> > > events emitted to/from the device).
> > > 
> > > However, we have seen a few use cases where HID-BPF might interact with
> > > the running kernel when the target device is already handled by a
> > > specific device.
> > > 
> > > [...]
> > 
> > Applied to hid/hid.git (for-6.12/bpf), thanks!
> > 
> > [01/11] HID: bpf: move HID-BPF report descriptor fixup earlier
> >         https://git.kernel.org/hid/hid/c/f10a11b7b599
> > [02/11] HID: core: save one kmemdup during .probe()
> >         https://git.kernel.org/hid/hid/c/6941754dbbc7
> > [03/11] HID: core: remove one more kmemdup on .probe()
> >         https://git.kernel.org/hid/hid/c/4fe29f36d2a3
> > [04/11] HID: bpf: allow write access to quirks field in struct hid_device
> >         https://git.kernel.org/hid/hid/c/b722f588adc6
> > [05/11] selftests/hid: add dependency on hid_common.h
> >         https://git.kernel.org/hid/hid/c/3d816765e12e
> > [06/11] selftests/hid: cleanup C tests by adding a common struct uhid_device
> >         https://git.kernel.org/hid/hid/c/28023a0f99d1
> > [07/11] selftests/hid: allow to parametrize bus/vid/pid/rdesc on the test device
> >         https://git.kernel.org/hid/hid/c/10d3147f9bb1
> > [08/11] HID: add per device quirk to force bind to hid-generic
> >         https://git.kernel.org/hid/hid/c/d030f826ea47
> > [09/11] selftests/hid: add test for assigning a given device to hid-generic
> >         https://git.kernel.org/hid/hid/c/10929078201f
> > 
> 
> Just for completeness, I've dropped 10/11 and 11/11 when applying the
> series because even if they are working it's unclear if the use case is
> rock solid, like the first one is.
> 
> The patches are still on the LKML, so if anyone believes they required
> it, we can alwasy pull them in later.

And I just dropped them from for-next, I had some KASAN issues in the
testsuite, meaning that something is off in the memory allocation/free.

Cheers,
Benjamin

