Return-Path: <linux-kselftest+bounces-17947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6481C978171
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 15:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D6528199B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8521DA63A;
	Fri, 13 Sep 2024 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVNi1oIH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4321D86D6;
	Fri, 13 Sep 2024 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235230; cv=none; b=LosxJOtb+QpYWtxeCOtQz2u5CyxFnA337i7zjhkp1kcsR/NVgSABU9vVfqBElHT1FvVR8H7F6nscpZjjFysej7oWdISqnzdYCs6cnP6jSkpJn5dM/kRwGFAXqPxBooZA/8L+RJLni6FvwfwSZh6VinxVgQoDhcPDivH9Nb2oN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235230; c=relaxed/simple;
	bh=yf2GMxg1XefxfAsl9eGXYlqULarFfBfcXvs5DfHxdng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnGEBDxLU06HOi9miDL84MBLeU3Ab8qPJu6038OZjrFiwwJY03BcN5Eu/H8XxYweAxRsaAMTUPD1kH87fD9qxRZxyoOfDZi3Tf9rVcLy7ytdfP72VtLaL6KlekcClI2fiTZRwIvuFfGHxeVHuviKFIb5yrmXG/hIJ2T12rgdIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVNi1oIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8622EC4CEC5;
	Fri, 13 Sep 2024 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235230;
	bh=yf2GMxg1XefxfAsl9eGXYlqULarFfBfcXvs5DfHxdng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVNi1oIHTvjVZBxX2Dyg8MCcsk3lXAuSqrlA9K5OrCzoIFDt6wNYHaUYiK3dy/ncY
	 q/fpJj1RUqB6PeYZdH+xH+6uE3P9mu2YryzYodrAiZpJ9QHv12db3RSfAE8C2Mo6PN
	 5H7YCj5R27dV78eWk5IjDmuzNiVe9/JHPY4vFDVNLiwWw5PVed0fGbfRDCTt/xUL9a
	 EtldTn6DHPqxjWMHiAAIBhYMe3MiQvTbag+PHw18hubLyD71dee5+9hDON6kxqN9bZ
	 MbCVfMVO363XcdC31iu6FdtG4XM8rAZXPbC7yQuvuKuws1CTcW7P10dtqNlpGdDayI
	 /n0FLFZlaadgQ==
Date: Fri, 13 Sep 2024 15:47:05 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
	Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: (subset) [PATCH HID v2 00/11] HID: bpf: add a new hook to
 control hid-generic
Message-ID: <etbeblypdylnngwuwjfqkmkduk4iup7uq4c5zkwrssoi6u7jvg@gtf3gpzrloii>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
 <172623473588.1192461.11090201509053454593.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172623473588.1192461.11090201509053454593.b4-ty@kernel.org>

On Sep 13 2024, Benjamin Tissoires wrote:
> On Tue, 10 Sep 2024 23:43:36 +0900, Benjamin Tissoires wrote:
> > This is a slight change from the fundamentals of HID-BPF.
> > In theory, HID-BPF is abstract to the kernel itself, and makes
> > only changes at the HID level (through report descriptors or
> > events emitted to/from the device).
> > 
> > However, we have seen a few use cases where HID-BPF might interact with
> > the running kernel when the target device is already handled by a
> > specific device.
> > 
> > [...]
> 
> Applied to hid/hid.git (for-6.12/bpf), thanks!
> 
> [01/11] HID: bpf: move HID-BPF report descriptor fixup earlier
>         https://git.kernel.org/hid/hid/c/f10a11b7b599
> [02/11] HID: core: save one kmemdup during .probe()
>         https://git.kernel.org/hid/hid/c/6941754dbbc7
> [03/11] HID: core: remove one more kmemdup on .probe()
>         https://git.kernel.org/hid/hid/c/4fe29f36d2a3
> [04/11] HID: bpf: allow write access to quirks field in struct hid_device
>         https://git.kernel.org/hid/hid/c/b722f588adc6
> [05/11] selftests/hid: add dependency on hid_common.h
>         https://git.kernel.org/hid/hid/c/3d816765e12e
> [06/11] selftests/hid: cleanup C tests by adding a common struct uhid_device
>         https://git.kernel.org/hid/hid/c/28023a0f99d1
> [07/11] selftests/hid: allow to parametrize bus/vid/pid/rdesc on the test device
>         https://git.kernel.org/hid/hid/c/10d3147f9bb1
> [08/11] HID: add per device quirk to force bind to hid-generic
>         https://git.kernel.org/hid/hid/c/d030f826ea47
> [09/11] selftests/hid: add test for assigning a given device to hid-generic
>         https://git.kernel.org/hid/hid/c/10929078201f
> 

Just for completeness, I've dropped 10/11 and 11/11 when applying the
series because even if they are working it's unclear if the use case is
rock solid, like the first one is.

The patches are still on the LKML, so if anyone believes they required
it, we can alwasy pull them in later.

Cheers,
Benjamin

