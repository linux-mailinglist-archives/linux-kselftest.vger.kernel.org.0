Return-Path: <linux-kselftest+bounces-49436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C28D3BDE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 04:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCFE84E3538
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 03:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671403176E1;
	Tue, 20 Jan 2026 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgV42XfC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322323168F1;
	Tue, 20 Jan 2026 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768878830; cv=none; b=bX7XQ3GOJMJVAfY9bnik68McjQ6b1yof1VnGnLgbEKyO+JYoj7IeNTJmXu9rQk2fN4MRbP7zu7WtoVRyK19XGoSDh4Y4sRG1sYzRiduIRIcM1xM4ivTPj7tFyjAets9dJ9HtDbQt4DHvkUvyzRHgvoNba3p5Cx7O/cpntroFctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768878830; c=relaxed/simple;
	bh=DJAuZlJz8lGAhCkuulrkzoE0q6lEHdX6GnVmfyNYeKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkn0BRjqPXXmwJCFRk31eDS9WkTU2X2+NVDF33aH1yM9NASCoYZ1p55ZccpaNBiUM1eGNK6sym1p8rIULyAw3pwkqkMev0JGWgfpS4TNNyXOW1muXuUejRyC7hzeDZkpB99IstLCwwqJJAT0njjF+vQXHll6XSMNu8vHatobVtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgV42XfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42875C116C6;
	Tue, 20 Jan 2026 03:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768878829;
	bh=DJAuZlJz8lGAhCkuulrkzoE0q6lEHdX6GnVmfyNYeKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgV42XfCq2LoNsapkzsXe6dCltQVMxLybNqkjhQAxRYyB/7J4iDwckKlOiykhLIsD
	 O6u8FJjAiKOaE9+ctAcs7FMWIcnjcEcRXJwr/wk/LFFE+MZJvbIxY7C+r/uHB2bNLk
	 CKe0z36bmdxt8e7FwTz68jiyijWdw1u2/YQvzcvvwREOpjW2SXUnsMvuxXymoWMk6e
	 FwEP7DjkgjJePiFvRFT/NUiDWUBdsFRWABNH1eK4A0586Wf8TmTI6ksXoAxqcM9yGa
	 MU0JH9e3Bx18AmSLhjs68VH5vKGJj2ymkH+CmPX9mWj2htOAzdQ2PwHnTawjErzp5C
	 o5QHEb/5k2osw==
Date: Tue, 20 Jan 2026 03:13:45 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>, linux-gpio@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: (subset) [PATCH 00/23] gpiolib: Adopt revocable mechanism for
 UAF prevention
Message-ID: <aW7y6aRwuf6y9BVl@google.com>
References: <20260116081036.352286-1-tzungbi@kernel.org>
 <176883238369.34730.6318990234727983164.b4-ty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176883238369.34730.6318990234727983164.b4-ty@oss.qualcomm.com>

On Mon, Jan 19, 2026 at 03:21:30PM +0100, Bartosz Golaszewski wrote:
> Tzung-Bi: I queued these two for fixes. Please resend patch 04/23 separately
> so that I can queue it for v6.19 as well. 01/23 and 03/23 risk impacting a
> very fragile path in GPIOLIB so any changes to it will have to wait until
> v7.0-rc1 to give it a lot of time in next.
> 
> [02/23] gpiolib: cdev: Fix resource leaks on errors in gpiolib_cdev_register()
>         commit: be037ec1785d76351037103ce6baddd3299606ee
> [05/23] gpiolib: cdev: Correct return code on memory allocation failure
>         commit: c7843298bf973d4bc7f4346140661e117186decc

v2 of [04/23]: https://lore.kernel.org/all/20260120030857.2144847-1-tzungbi@kernel.org

