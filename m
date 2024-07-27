Return-Path: <linux-kselftest+bounces-14314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BFD93E068
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F501F21813
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B118308E;
	Sat, 27 Jul 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/S1bFiv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C67470;
	Sat, 27 Jul 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722103833; cv=none; b=Ze1KFy5hBvrVao1lS9BvUWWXNytlq8raZZO+ZUw7P55y9igf9Q1xIekHJSnI9eDPARSoopResUgSXsQTG++dBv+CMM1obHmf3tFPjGND+K7iEgrRa1DHJ7UVdpfSBZWzjVzqtvB3DlitwS3L0QhN9mgFmlgboXD+f0//1JFuhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722103833; c=relaxed/simple;
	bh=zlABaadhvFHp0oZ6FFLIWEU2EQWEwhOhVKdxlKQcx3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSISGQeJ7bz1FJgdK9dJdWxvMpq0w4zbZfjBEp6Oe+mzWzTJht3X+6iBs1XuiR4jF+t3HYtu+SvbTld4iZ7pmsb5ysrdjaYGA/pQwx9s9o98wwT3Kzk5wkciFwVHgYBOjXmUOOFyW5lRDmKZRVC8pyUwpLqDaXmDWVKdBm1UV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/S1bFiv; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so676760276.2;
        Sat, 27 Jul 2024 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722103830; x=1722708630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8GXSL9+pEaFlUy/iMZ0metWt0BsFvkNW53VDiHwizg=;
        b=Z/S1bFivyGwFGgwZgZQeCgMiFFTZPt4HZ4HwamR/rAtRwSqylIVfy80n65FHysIKOJ
         opvwqOI/msLvU785yoL+2CnE80Ls45l1fI56WipBXArWLQL0J5X1/ompGyWDjA0NPJr0
         yh0w9B3Ujc1/ebOFYr10eg0Aav0Sqkid1EeQGdNTCWmHljW2jbh7qOML7u0DFaF94eRd
         D31sTfRE95n6SR0t/q7T/9OOPgGVBV+qznREJta8IBoGw55AyFWabF0qalZG4IQz0a8i
         EHhjOV5d7lh6DxpPbvi1iadaRhscyXsx2Q8TOy/78ZSoYJWGfDmmJBzi4NNpFkheZqRW
         ozYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722103830; x=1722708630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8GXSL9+pEaFlUy/iMZ0metWt0BsFvkNW53VDiHwizg=;
        b=QBp16g2WrCqyZEcpH7ExvppNoILx2LWk5v41b4Emr4pdW6SBoNHTznCEP1jDA6u2NT
         +AyFkO+3mgSJolFXnF6l8lMXjJruoGIdIn1aURhugqYTEHvDNU88fz6MM+mOKOfz5ues
         nf1yTxjsqu5wWimcJbHmLI2FXmLf13+6rFOBQ8j1Q+ZfdFaaKSr8lxbAXefBbC5C42OK
         lQWi0tWT5uJS2vRYIS77CjuMKP/l8DHi9vTnBsxgZGHIGvCA29wR0hqW5XlPPNzaSPEO
         7T+fxrVMOdi6WskYj3aaXyzLoGM3lTsqPKZQI7h59mukb0OF9MncROpHRk7SCFuJAKoe
         4sIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUli0GahhZyGK/bwzn6UH8uTpAz88FBxIAbzRIUa7fI62VClUnvTaDThGxvqJq3a/RoO63xvS7f3xsUv3W8+nTge7xbXvy4n0bReTePXiysqHub5zFbgC5JqabD3K1vHx1dpma3eF+n/v7MKzKv
X-Gm-Message-State: AOJu0YxJest/eUpklvyUXGCXbYAB4Bf7n1LmazWmoupFiSz4fypP/Q4f
	hPxzp3xHqNcVD48LZMP1X0ulYmyg1MNR/5o6y3qH5J0WYB3LpJ9k
X-Google-Smtp-Source: AGHT+IEUBssDqF49luapyssQ1Jl7uLcNwe4blGUpQHGlf8FfI98CQIv4Kf/VPLMEYRTJTAUyzuYANQ==
X-Received: by 2002:a05:6902:f84:b0:e0b:6951:c766 with SMTP id 3f1490d57ef6-e0b6951e0b0mr750054276.49.1722103830200;
        Sat, 27 Jul 2024 11:10:30 -0700 (PDT)
Received: from localhost (c-71-203-131-184.hsd1.fl.comcast.net. [71.203.131.184])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a93a98dsm1146551276.56.2024.07.27.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:10:29 -0700 (PDT)
Date: Sat, 27 Jul 2024 11:10:28 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kees@kernel.org,
	David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>,
	kernel@collabora.com
Subject: Re: [PATCH 0/3] bitmap: Convert test_bitmap to kunit test
Message-ID: <ZqU4FANdHOvpGc5t@yury-ThinkPad>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>

On Fri, Jul 26, 2024 at 01:26:48PM -0600, Shuah Khan wrote:
> On 7/26/24 05:06, Muhammad Usama Anjum wrote:
> > In this series, test_bitmap is being converted to kunit test. Multiple
> > patches will make the review process smooth.
> > 
> > - Patch-1: Convert the tests in lib/test_bitmap.c to kunit
> > - Patch-2: Rename the lib/test_bitmap.c to lib/bitmap_kunit.c and other
> >             configuration options
> > - Patch-3: Remove the bitmap.sh selftest
> > 
> > Muhammad Usama Anjum (3):
> >    bitmap: convert test_bitmap to KUnit test
> >    bitmap: Rename module
> >    selftests: lib: remove test_bitmap
> > 
> >   MAINTAINERS                           |   2 +-
> >   lib/Kconfig.debug                     |  15 +-
> >   lib/Makefile                          |   2 +-
> >   lib/{test_bitmap.c => bitmap_kunit.c} | 624 ++++++++++++--------------
> >   tools/testing/selftests/lib/Makefile  |   2 +-
> >   tools/testing/selftests/lib/bitmap.sh |   3 -
> >   tools/testing/selftests/lib/config    |   1 -
> >   7 files changed, 295 insertions(+), 354 deletions(-)
> >   rename lib/{test_bitmap.c => bitmap_kunit.c} (70%)
> >   delete mode 100755 tools/testing/selftests/lib/bitmap.sh
> > 
> 
> Can you tell me how this conversion helps?
> 
> It is removing the ability to run bitmap tests during boot.
> It doesn't make sense to blindly convert all test under lib
> to kunit - Nack on this change or any change that takes away
> the ability to run tests and makes them dependent on kunit.

Hi Muhammad,

In addition to Shuah's and John's reasoning. This patch wipes the
test history (git blame will point on you for most of the test),
breaks boot-time testing support, messes with config names and
usability, and drops kselftest support for ... exactly, what?

KUNIT engine here doesn't improve on readability, neither shorten
the test length, to my taste.

If you'd like to contribute to bitmaps testing - I'm all for that.
This is the very core and performance-sensitive piece of kernel,
and any extra-coverage is always welcome.

But I think the best way would be either adding new cases to the
existing test, or writing a new test, KUNIT-based, if you like.

Thanks,
Yury

