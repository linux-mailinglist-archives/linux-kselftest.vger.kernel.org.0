Return-Path: <linux-kselftest+bounces-13793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4281E932F89
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 19:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734FA1C225C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A11A00F7;
	Tue, 16 Jul 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elFZMblC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE71E13CA99;
	Tue, 16 Jul 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152747; cv=none; b=CIH4ywMNQhYawunDHwrKWNlfijoPOV39r0pgV6k1PlWRNklB/WyB4DTv9qn8ABeioeUSP4mAYHtBeW3RwO60DmXa3FXhE7ASEe97dJSBJnVoeEbooede0LutFADcAhGej/1efgUoXAq61O2uK4WC8cvbA6YphBezmSI6YjY/T3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152747; c=relaxed/simple;
	bh=aZoQyJZaXPsI2kwIwZYxpxbHfH9lPGmGaVvVQ/h+Usc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCsMbV7Yp/PMD+dF6kb7W4tfnofDe55DnxfWJODwOIbMCEEs9K6+obMPJrQCDuXCxuFS/zn80B+C6McsTJMeEud7Q7pXAXf6gX3J0rCvxtUFvl5TQICU04wc5/HEJdmzo53+jefQWZD36YWZEbqinqhXBVPY1/CLeRmBO1VFd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elFZMblC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE06C116B1;
	Tue, 16 Jul 2024 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721152747;
	bh=aZoQyJZaXPsI2kwIwZYxpxbHfH9lPGmGaVvVQ/h+Usc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elFZMblC4xXuhengbYo5qIbdwxM3ZlTUasQK9biTysI/46boyJrKlcoZK8uEvH+uK
	 ZNuKYb/xdoVgBExRwn0C7XEcbsZVZFzDD27HMD8uBlouhpzAvD1VHFAyIuFNhu2+9k
	 3XJoAhryUWiJbNg2hSt9H8MKJDAGD3coeflx5v5MAvFUrsEZBo6T+5yXNPC/KoVw3a
	 dwV9Pu4sKvwQ8DOtMpfKWEPXpfabpZboxJqIpYVOAfTFoziL80ZLE145ytuj4TVoKP
	 8rBtgIwrw6oGSZpZv4Ix3eYZ4yh6pdDoF+EquvWOnbU26o6FXGvOTouJCr6usHGuok
	 dLUkuKAaueLxg==
Date: Tue, 16 Jul 2024 10:59:06 -0700
From: Kees Cook <kees@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, davidgow@google.com,
	"open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	kunit-dev@googlegroups.com,
	"kernel@collabora.com" <kernel@collabora.com>
Subject: Re: Converting kselftest test modules to kunit
Message-ID: <202407161005.CACE2E355@keescook>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
 <202407150936.C32FE24CA@keescook>
 <8412a936-b202-4313-b5b4-ce6e72a3392f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8412a936-b202-4313-b5b4-ce6e72a3392f@collabora.com>

On Tue, Jul 16, 2024 at 01:11:14PM +0500, Muhammad Usama Anjum wrote:
> On 7/15/24 9:40 PM, Kees Cook wrote:
> > On Mon, Jul 15, 2024 at 03:09:24PM +0500, Muhammad Usama Anjum wrote:
> >> Hi Kees and All,
> >>
> >> There are several tests in kselftest subsystem which load modules to tests
> >> the internals of the kernel. Most of these test modules are just loaded by
> >> the kselftest, their status isn't read and reported to the user logs. Hence
> >> they don't provide benefit of executing those tests.
> >>
> >> I've found patches from Kees where he has been converting such kselftests
> >> to kunit tests [1]. The probable motivation is to move tests output of
> >> kselftest subsystem which only triggers tests without correctly reporting
> >> the results. On the other hand, kunit is there to test the kernel's
> >> internal functions which can't be done by userspace.
> >>
> >> Kselftest:	Test user facing APIs from userspace
> >> Kunit:		Test kernel's internal functions from kernelspace
> > 
> > I would say this is a reasonable guide to how these things should
> > be separated, yes. That said, much of what was kind of ad-hoc kernel
> > internals testing that was triggered via kselftests is better done via
> > KUnit these days, but not everything.
> I started investigated when I found that kselftest doesn't parse the kernel
> logs to mark these tests pass/fail. (kselftest/lib is good example of it)
> 
> > 
> >> This brings me to conclusion that kselftest which are loading modules to
> >> test kernelspace should be converted to kunit tests. I've noted several
> >> such kselftests.
> > 
> > I would tend to agree, yes. Which stand out to you? I've mainly been
> > doing the conversions when I find myself wanting to add new tests, etc.
> lib
> 	test_bitmap
> 	prime_numbers
> 	test_printf
> 	test_scanf

Yeah, these would be nice to convert.

> 	test_strscpy (already converted, need to remove this test)

Yup, converted in bb8d9b742aa7 ("string: Merge strscpy KUnit tests into string_kunit.c")

> lock
> 	test-ww_mutex module
> net
> 	test_blackhole_dev

I don't know these very well, but yeah worth looking into.

> user
> 	test_user_copy (probably already converted, need to remove this test)

This is done in -next via cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")

> firmware
> 	test_firmware

This might not work to convert: there's a userspace half for testing
firmware loading (see the kselftest side...)

> fpu
> 	test_fpu

Seems reasonable.

> Most of these modules are found in lib/*.
> 
> Would it be desired to move these to kunit?

Checking with the authors/maintainer is probably the first thing to do;
check the git history to see who has been working on them.

-- 
Kees Cook

