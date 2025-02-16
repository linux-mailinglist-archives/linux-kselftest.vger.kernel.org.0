Return-Path: <linux-kselftest+bounces-26739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD0BA3736A
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 10:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B8116C0C0
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7767918C92F;
	Sun, 16 Feb 2025 09:40:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE16290F;
	Sun, 16 Feb 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739698830; cv=none; b=rtNjTl34CzTupkU61Ad9QeBaahRIelgxNld9AaMIdsF1lQT661lGymRz3mrxBJnAW++hKPN7dTZWOYSQtGleEJZ98aXQ9opod5L1Fnq7IfbnUyubSbGIeuv9Xh/vQfWVk8QusDKNYOosxZpkigKPufcBP8ZLRpiYxLPX4OQHGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739698830; c=relaxed/simple;
	bh=zCIUMQNWbz0RyKAwHEoIEGbL6E4OPshHS5Xt4dnxspk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW9/7LlGwzNHYrXv7U8a1rPzXzefApvrdMXdbBhXFqLAZd+ZgsVCfvqX8zCAxKTBhgIVYHpbJFUl4k61DZK2O/3nTZfNPaIjj5MoYJlByoEJPfUUithhajaPYLeuq/SQXwQXF1k0N5gmZ1fZ2m+lDkiixBhC/UyUljgLcnvJoHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51G9deOg002270;
	Sun, 16 Feb 2025 10:39:40 +0100
Date: Sun, 16 Feb 2025 10:39:40 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: only run constructor tests on nolibc
Message-ID: <20250216093940.GA2192@1wt.eu>
References: <20250212-nolibc-test-constructor-v1-1-c963875b3da4@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212-nolibc-test-constructor-v1-1-c963875b3da4@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 12, 2025 at 07:01:01PM +0100, Thomas Weiﬂschuh wrote:
> The nolibc testsuite can be run against other libcs to test for
> interoperability. Some aspects of the constructor execution are not
> standardized and musl does not provide all tested feature, for one it
> does not provide arguments to the constructors, anymore?
>
> Skip the constructor tests on non-nolibc configurations.

I'm not much surprised, I've always avoided arguments in my use of
constructors due to a lack of portability. However the patch disables
all constructors tests, while I'm seeing that the linkage_test version
does not make use of arguments, though there is an implied expectation
that they're executed in declaration order, which is not granted.

I'm wondering if we shouldn't make the tests more robust:
  1) explicitly set linkage_test_constructor_test_value to zero in the
     declaration, because here it's not set so we have no guarantee
     (we're not in the kernel)
  2) only add values to check for cumulated values (e.g. |1 in const1,
     |2 in const2) and verify that the result is properly 3
  3) make the argument test add a distinct value (|4) so that when
     testing it's instantly obvious which test was not called.

And indeed, we can disable the tests we know fail on other libcs and
even split that by feature (e.g. test that at least one constructor
was called using !=0, that all non-arg ones were called via &3 == 3,
and that the args were passed via &4==4). That would allow to further
refine the tests if desired so that we can keep the differences in mind.

In any case all of this can also be done later, and I'm obviously fine
with this immediate adjustement.

> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

