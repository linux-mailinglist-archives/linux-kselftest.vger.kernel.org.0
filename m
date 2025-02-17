Return-Path: <linux-kselftest+bounces-26808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45EFA38DEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 22:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD3E7A365C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 21:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F41239068;
	Mon, 17 Feb 2025 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cf13lexb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB7226545;
	Mon, 17 Feb 2025 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827465; cv=none; b=C6BhXSHdA9CUiJQrwRBNoMewFV5LDiH/BEPKDMLV7/WzMHu5UtPTIZdDU4m49QFGobNPCCZrM0XHJXrdd4B4INbAW5pwSGNL65iv/m3EZkOv6vA9yu2aZaV1ueEX9XbpnkOK2JCwKW3AwwqcLzyHsiC0KSxivt+8Qcp5daoxQgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827465; c=relaxed/simple;
	bh=Ud5AdYG8+a1y/QVeOHk++qClTlkN6nV7FSy/uOKzi1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsNpQ3N/ouwnKOv5DiBfAa1ApXB9Wm0z5F/RuU+0VpgZ4pToauLTcOJNZLCulfqk0cc/uilh9AmqktdUJF3ViPoUIyLCfbrzHCGOx2O2uUZ8IsWz5n84HdingzW/ntWumoG3jQE6IGQpqseXNk0rNioXG+MV0jad37LvKADYE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cf13lexb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739827452;
	bh=Ud5AdYG8+a1y/QVeOHk++qClTlkN6nV7FSy/uOKzi1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cf13lexbEDQC0MU8f1sDRTEWicwBoEF3z8GGyOAug2y8ZIs7PUdDrh87IY+2A+f78
	 uIWSXacEkiNtt7G5i80SAMTCPnb9OD9dWFNWkN933R0Hdo52doK6GfzbgZwIpoxTNz
	 kl63PRMGGtWL/ckhHD9BdWCEv8GcPxBqpENzeQrc=
Date: Mon, 17 Feb 2025 22:24:11 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: only run constructor tests on nolibc
Message-ID: <670b08a4-9bc5-4700-94bb-272fda5c59d7@t-8ch.de>
References: <20250212-nolibc-test-constructor-v1-1-c963875b3da4@weissschuh.net>
 <20250216093940.GA2192@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250216093940.GA2192@1wt.eu>

On 2025-02-16 10:39:40+0100, Willy Tarreau wrote:
> On Wed, Feb 12, 2025 at 07:01:01PM +0100, Thomas Weißschuh wrote:
> > The nolibc testsuite can be run against other libcs to test for
> > interoperability. Some aspects of the constructor execution are not
> > standardized and musl does not provide all tested feature, for one it
> > does not provide arguments to the constructors, anymore?
> >
> > Skip the constructor tests on non-nolibc configurations.
> 
> I'm not much surprised, I've always avoided arguments in my use of
> constructors due to a lack of portability. However the patch disables
> all constructors tests, while I'm seeing that the linkage_test version
> does not make use of arguments, though there is an implied expectation
> that they're executed in declaration order, which is not granted.

The tests are written specifically to test for execution order.
While we can not rely on the order for other libcs, the idea was to
expect a given order for the nolibc implementation.

> I'm wondering if we shouldn't make the tests more robust:
>   1) explicitly set linkage_test_constructor_test_value to zero in the
>      declaration, because here it's not set so we have no guarantee
>      (we're not in the kernel)

Ack.

>   2) only add values to check for cumulated values (e.g. |1 in const1,
>      |2 in const2) and verify that the result is properly 3

This would stop validating the order.

>   3) make the argument test add a distinct value (|4) so that when
>      testing it's instantly obvious which test was not called.
> 
> And indeed, we can disable the tests we know fail on other libcs and
> even split that by feature (e.g. test that at least one constructor
> was called using !=0, that all non-arg ones were called via &3 == 3,
> and that the args were passed via &4==4). That would allow to further
> refine the tests if desired so that we can keep the differences in mind.

I'm not yet convinced about the additional value.
But I'll give it some thought.

> In any case all of this can also be done later, and I'm obviously fine
> with this immediate adjustement.
> 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!

> Willy

