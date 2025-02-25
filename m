Return-Path: <linux-kselftest+bounces-27489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56538A4477A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE2016B00B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810071946DA;
	Tue, 25 Feb 2025 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fs5S5rdz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584E19340B;
	Tue, 25 Feb 2025 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503349; cv=none; b=cONAly95fxOqNEOOZU8DkExMisxTsNI3dxIL8XWRb3k8Ddq+flfZdLDOG6N3++BuNVXGWjNZQdHghB7se9Zrx7CoE+Dc5s8Q1KcgUXvToxahEN19zRZXRMvJOvL6dhEexP2+2kwA/tOHzugX/2QaYRH2dPUuR5kZOop9/vAr2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503349; c=relaxed/simple;
	bh=lV70D+fEACCSNM/jT2P9vf+mSVZCldNuJXWNwFQvsBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PG+WwHAYnRRHm2UlkLENjwRH36XRZQ+u89BHtn1Ad/6qK6QKIFGI4F+ChHHqId/ZHpRwkH6F+ctlwsm6bBdoDPmr/PpvosgJsUtVsZj5/KkMNedG7RXxBpXk9aY5LYGbz0UuPPF0ydMZyjm8I7G2WkCSqe80hs5vMPgCM6eDZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fs5S5rdz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740503338;
	bh=lV70D+fEACCSNM/jT2P9vf+mSVZCldNuJXWNwFQvsBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fs5S5rdzLfGAcAuosUMrKU3yI2FmgCyeo8Lim/UNW5MLNsRu+Umc5wNaFRstTGNEZ
	 9h+St42jOXvUx/LqH+zzjqLRlNhGVJLXkoqMiTS67EFdPG+dcmvRT0b2wJ+oX0SvEM
	 E3p9e5+9Jqt0jgaXlIMssAwp5DKCUGyNOd7OpIxY=
Date: Tue, 25 Feb 2025 10:37:24 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: only run constructor tests on nolibc
Message-ID: <b36e1946-fda8-4893-b081-7ac9b4933947@t-8ch.de>
References: <20250212-nolibc-test-constructor-v1-1-c963875b3da4@weissschuh.net>
 <20250216093940.GA2192@1wt.eu>
 <670b08a4-9bc5-4700-94bb-272fda5c59d7@t-8ch.de>
 <20250222093851.GA13258@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250222093851.GA13258@1wt.eu>

Hi Willy,

On 2025-02-22 10:38:51+0100, Willy Tarreau wrote:
> On Mon, Feb 17, 2025 at 10:24:11PM +0100, Thomas Weißschuh wrote:
> > On 2025-02-16 10:39:40+0100, Willy Tarreau wrote:
> > > On Wed, Feb 12, 2025 at 07:01:01PM +0100, Thomas Weißschuh wrote:
> > > > The nolibc testsuite can be run against other libcs to test for
> > > > interoperability. Some aspects of the constructor execution are not
> > > > standardized and musl does not provide all tested feature, for one it
> > > > does not provide arguments to the constructors, anymore?
> > > >
> > > > Skip the constructor tests on non-nolibc configurations.
> > > 
> > > I'm not much surprised, I've always avoided arguments in my use of
> > > constructors due to a lack of portability. However the patch disables
> > > all constructors tests, while I'm seeing that the linkage_test version
> > > does not make use of arguments, though there is an implied expectation
> > > that they're executed in declaration order, which is not granted.
> > 
> > The tests are written specifically to test for execution order.
> > While we can not rely on the order for other libcs, the idea was to
> > expect a given order for the nolibc implementation.
> 
> OK.
> 
> > > I'm wondering if we shouldn't make the tests more robust:
> > >   1) explicitly set linkage_test_constructor_test_value to zero in the
> > >      declaration, because here it's not set so we have no guarantee
> > >      (we're not in the kernel)
> > 
> > Ack.
> > 
> > >   2) only add values to check for cumulated values (e.g. |1 in const1,
> > >      |2 in const2) and verify that the result is properly 3
> > 
> > This would stop validating the order.
> 
> That was my purpose but OK I got it. Then there's another option which
> preserves the order and even gives history:
> 
>   __attribute__((constructor))
>   static void constructor1(void)
>   {
>       constructor_test_value = constructor_test_value * 0x10 + 1;
>   }
> 
>   __attribute__((constructor))
>   static void constructor2(void)
>   {
>       constructor_test_value = constructor_test_value * 0x10 + 2;
>   }
>  
> Then if executed in the right order, you'll find 0x12. If both
> are executed in any order, it will always be >= 0x10. If only one
> is executed, it will be < 0x10, and if none is executed, it's 0.

Sounds good! Do you want to write a patch?
It should also add the missing zero-initializion of
constructor_test_value.


Thomas

