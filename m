Return-Path: <linux-kselftest+bounces-21267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE969B87C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 01:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714F5B21DF0
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 00:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD7AD23;
	Fri,  1 Nov 2024 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a1PJxLow"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CC1CA81
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730421583; cv=none; b=RtL9Mn/K+RTBKelUtJ49sVsLbIbO3fT+qCsYv87FGXPiekcAJ5iaxd5MC1j6RmNl0HhfJHOdgRSwHTKfpcgs6ftVLxQOxSf9aDKjGe3jAQgviy9XlOiG493THRoRm/oM10D3Bfi7EL+7NI0ND1uwEElDpZQUQWmKvMk32rfnFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730421583; c=relaxed/simple;
	bh=CO96cJqEyqfErHIWmZZC2b6hCDnPOpFxc1rfqRsUVNs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IT0AYBSUXCtp6W+BHjxLQUsuBVK+E/GKING5xvLVPquDPk5CfVgCaSPvP8tbAek//XFOkKuPe59DJSDesqJkd0fdCsAXJl75UFMBSGkJ5UZGjLKcSIP2lGYjmkuY9fhS/7vrBSaRkMablnWDRR6jYBv0ziBJJVnBT8Io/syNDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a1PJxLow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7966BC4CEC3;
	Fri,  1 Nov 2024 00:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730421582;
	bh=CO96cJqEyqfErHIWmZZC2b6hCDnPOpFxc1rfqRsUVNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a1PJxLowaNXMaXSZWvACsrV3x9dMZ/s/iAtfwjqraHnhZTv6AlDeUt5XuJ+513uZV
	 TTI6e+e3vSzVc4n47ILbgdYrUN5GYR3LVHAUBaDZztPCBqrQ6EdbF6GeTBL2FoJmuj
	 Oqh68wzFnJSWAclQpOCm+8Tiv3bSgnSfXAwL83Wo=
Date: Thu, 31 Oct 2024 17:39:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 ricardo@marliere.net, linux-kernel-mentees@lists.linuxfoundation.org,
 andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3] lib/math: Add int_sqrt test suite
Message-Id: <20241031173941.3487ccbfd7421d81d9b0cb97@linux-foundation.org>
In-Reply-To: <c213dbcb-35de-4afd-9d4b-f42f6a9e3de6@linuxfoundation.org>
References: <20241030134355.14294-1-luis.hernandez093@gmail.com>
	<c213dbcb-35de-4afd-9d4b-f42f6a9e3de6@linuxfoundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 11:50:16 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 10/30/24 07:43, Luis Felipe Hernandez wrote:
> > Adds test suite for integer based square root function.
> > 
> > The test suite is designed to verify the correctness of the int_sqrt()
> > math library function.
> > 
> > Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> > ---
> > Changes in v2
> >    - Add new line at the end of int_sqrt_kunit.c
> >    - Add explicit header includes for MODULE_* macros, strscpy, and ULONG_MAX
> > 
> > Changes in v3
> >    - Remove unnecesary new line after Kconfig entry for INT_SQRT_KUNIT_TEST
> >    - Correct int_sqrt instances with int_sqrt() in commit message and kconfig
> > entry desc
> >    - Fix limits.h header include path
> 
> Adding Andrew to the thread.

Thanks.

> I think this depends on the other lib kunit
> content that is already in next.

Actually the patch applies cleanly to 6.12-rc5.

> > --- a/lib/math/Makefile
> > +++ b/lib/math/Makefile
> > @@ -9,3 +9,4 @@ obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
> >   obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
> >   obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
> >   obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
> > +obj-y  += tests/

What's this change about?  It seems somewhat unrelated to adding a
single test.  I mean, there's an unrelated test listed in
lib/math/tests/Makefile so what change does this patch have upon that
one?


