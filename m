Return-Path: <linux-kselftest+bounces-32893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2B0AB4B0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 07:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D68B462FFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 05:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6A51DDA1B;
	Tue, 13 May 2025 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bxXomr4j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FD145B25;
	Tue, 13 May 2025 05:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747114424; cv=none; b=GLw4kvpEDKeGzIxlBOTsu3V8avOyTNE08kIzOieaTTcb3wHrZiOOPALP+MigjwWQ8+XbQhhDMSM5l9WNzhcPZzJPf4gJ9gh12WiJH74S2ropCZJ7AZEkHNBHWwc7bPmGy040H4ZtnhhbDtES0UYguVcnLI7q+hMOupM9hPe9Y8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747114424; c=relaxed/simple;
	bh=0t2qgpOwlmiwcivUP1+Ab7YO1v3OcpVmH/SDvga1764=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjYRqhv+pyCqVxmrBmzSI8+3eN26Hv1v5pAZiDt4+mHCG3cpoJgq24RoDspIHvqxKDIkKFmv/zQlZfHZwOYYbuznOCIiQA2570QcLuIhcuB5QUBtyspRLIsgbBtOSLbJUEXE9ZQpoqB/zfTNRhGxX8hAIjrnscaeAFNmbw5m5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bxXomr4j; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747114416;
	bh=0t2qgpOwlmiwcivUP1+Ab7YO1v3OcpVmH/SDvga1764=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxXomr4jtXjOlm8x/IU7MKClEJ0TIHk5yFoQqV8QMQLVGVOuttJqLVYvvV7X9OV/f
	 WP552m5MJPAu1ejBLpN4FaFGHi4r5SEjoUQ1wwsSnIixwkc8k7yPdgP6xfiu4B/VS6
	 ZzN2x32U936K4Kd+skps1gSJ+OuT/c18X4ToKtw0=
Date: Tue, 13 May 2025 07:33:35 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 00/14] kselftest harness and nolibc compatibility
Message-ID: <03197313-559f-4e62-915b-ac04a55c9794@t-8ch.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <d8d36e51-9456-49a3-88c4-44cffdcc5c0a@t-8ch.de>
 <a699b6d0-f028-43d1-93c9-250b6c8c4a6b@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a699b6d0-f028-43d1-93c9-250b6c8c4a6b@linuxfoundation.org>

On 2025-05-12 15:32:40-0600, Shuah Khan wrote:
> On 5/10/25 00:54, Thomas Weißschuh wrote:
> > Hi Shuah and Kees,
> > 
> > On 2025-05-05 17:15:18+0200, Thomas Weißschuh wrote:
> > > Nolibc is useful for selftests as the test programs can be very small,
> > > and compiled with just a kernel crosscompiler, without userspace support.
> > > Currently nolibc is only usable with kselftest.h, not the more
> > > convenient to use kselftest_harness.h
> > > This series provides this compatibility by removing the usage of problematic
> > > libc features from the harness.
> > 
> > I'd like to get this series into the next merge window.
> > For that I'd like to expose it to linux-next through the nolibc tree.
> > If you don't have the time for a review or issues crop up, I will drop
> > the patches again.
> > 
> > Are you fine with that?
> 
> Didn't I respond to v13 saying you can include in your nolibc PR?
> If I didn't here is my Reviewed-by.

You did ack v3. But as some patches changed, I wanted to reconfirm the
new contents.

> > 
> > The issues reported by Mark have been fixed and tests have been written
> > for them.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks!
As most patches already carry your Ack, I transformed this Reviewed-by
into an Acked-by for the two new patches for consistency.


Thomas

