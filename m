Return-Path: <linux-kselftest+bounces-29841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62CCA72100
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 22:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A656E3BCF1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 21:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF743253B59;
	Wed, 26 Mar 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ccwE1uBt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF692AD02;
	Wed, 26 Mar 2025 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743025927; cv=none; b=GzBISzHmcgatpmXdG9hv4KFCj0DBx+yhxs1IQqOitMwRzl4mMyyzV/L8tVfdao1xCItYAvr4wPOetfuBgyJ/Kp+C9hfctc1Rs5ySBR+v99R2dc3/JMXx9xWl80/PlVnafijk/Vx1E2zPYW8oS0L6aWSAWYCrWrP1N+8k4XyJXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743025927; c=relaxed/simple;
	bh=E7kr/pxzFv3vUyE91rsLl/E9VrXg3DOOVZED/WIMboo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO2ycgJ/JlhiAN6nQULAlYQBuclr6T1H7kn3cVPXgjAyMgMZ+mRy7t2b8B1Xo+XcqttXCss7OyeaOytm1HsW2q5XHYHfYb0F0kovb2aVlEj2nbbUqxFa5EeGWs+v7Q5ah0zmzvsEBHJS0U+DeaNll4K5ilZ5KbLfxDxNAZH2gPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ccwE1uBt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1743025915;
	bh=E7kr/pxzFv3vUyE91rsLl/E9VrXg3DOOVZED/WIMboo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ccwE1uBtbu2l/p5le7kqE45+XoDN4GZPzFyUFdjRoOnMTj3Va12W8jW3FuW7v8llV
	 isxvg9JY6cULw1qBQykv1mcSMK0nv7U02cW6IbVAgKF4xiEP2edXEAUSTDGS5Y0XWE
	 pb3yC61nwKHq0cHmGwGNa/7AeCrnzyGQ7QSA+Xp4=
Date: Wed, 26 Mar 2025 22:51:54 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tools/nolibc: MIPS: entrypoint cleanups and
 N32/N64 ABIs
Message-ID: <60e78caf-49e5-42ad-900c-9813518d838b@t-8ch.de>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
 <20250326205434.bPx_kVUx@breakpoint.cc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326205434.bPx_kVUx@breakpoint.cc>

On 2025-03-26 21:54:34+0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-25 18:02:34 [+0100], Thomas Weißschuh wrote:
> > Introduce support for the N32 and N64 ABIs. As preparation, the
> > entrypoint is first simplified significantly. Thanks to Maciej for all
> > the valuable information.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Tested-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc> [ICT Loongson-3]

Thanks!

> mips32le works as-is.
> For mips64le I had to s/-march=mips64r6/-march=mips64r2 to match the
> ABI. Which makes me wonder: Why do do we need to pass -march here and
> can't rely on toolchain defaults?

The goal here is to have an as-wide-as-possible test matrix for
nolibc-test, which will mostly be running on QEMU anyways.
Also we need to run the correct QEMU user variant; by fixing the
architecture this is easy to do.


Thomas

