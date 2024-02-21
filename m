Return-Path: <linux-kselftest+bounces-5171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0CF85DA3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E2A1F23BCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5ED7EEE4;
	Wed, 21 Feb 2024 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecyTr49F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91BA79DAB;
	Wed, 21 Feb 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521988; cv=none; b=Io2+soarG0fWpF73WPNe1CGanTzKlBk87LtknVthBmqvIZdOKCbjqkAwjNY+EjAWe5Qsg+QfkEZ810uf4Te5BfHov+agrd6RbZfvQKCneVkmpnZGaT+apQTzgp0uMPgsMt56ZeznJU+iVNTK0g2+JwqntTfaZymY2KQ33aBIvGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521988; c=relaxed/simple;
	bh=5V1bV3pAIFIuTSQWqdDobRb+DukBqlTZwfc7iDi3qX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYe16JDj5H0x9v5mOgDxdNgHO3m34yc8bq6TdE2KaVqqZPe4NRPcXB2KdFbWxFVWnMbFAGF4DvLViYDxQao6GUESUN1I8AsvPy0myCadFYbp1FCVm0UwIKXmSNUqDAU0yjSNJKRYArabRMGRpdbtUW1sy3I+/BQH+YoptH2aIP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecyTr49F; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso393992a12.0;
        Wed, 21 Feb 2024 05:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521986; x=1709126786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XoFhc6w6Or2jWzWThz9jNXXxehcO/WwM1R0QsjeWJp0=;
        b=ecyTr49FxuypQizLCr7RmSPCyEVRsj3Dcmap/wy4p71bX61Zi8YX/4cNmrVXIYJ3zF
         qVXScHb9w0pjvfn0c8tpQlIDPAxy9Hgn775JvdjuX50x4xIw+Ic3//OLYdLTKZfeJtEt
         zAW2eAi84mzPItcwC6zZSG9j+Ri5H0gWEBUvidMVtmnxnYaEyfdXlPerSVNvRryEcXWL
         L78xgTjG6VrzayaGyrjfgYXRQc3vd3rPZl83h9MiLs+c1qfWlNOISL7nKIeelbDLgexq
         XvoLDCmfwPRG/ZX73vbX07//g3nupwDG4rvFzbcwD0OASBQgFf66mOBcVT539SqDueRY
         4a6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521986; x=1709126786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoFhc6w6Or2jWzWThz9jNXXxehcO/WwM1R0QsjeWJp0=;
        b=xAus5rky4eP+Buxu79wXPAcxrYpvfWgjokzGiRDZUCWZ2iCDKqb4+fr28L0Yd02oM7
         FaHblEy54HDc21Xd+kHoFM1ZazpsTTFqgfVYw3xfi25QEDe+mBK65Cjw+x8AyhkGX3xu
         9hjZGB9LyVDqAD5puvXfsnipurE3HX06BZovf3dNXXhWK7Jow/mOLoD5ywEZ52nHivcz
         oO9CdAW1NKqznYcaOIaH6Bn6e2W8oW8QUpxsoTsIxq/piiE4FzAs5XKnGKuAqbarGake
         YzYBHRMAhKs/IKZjtO2LriQFxstleykGKyYVqvW6sq8C9QhFTZnBfd49KVzu7kojv+Ai
         ey2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUottvNQcK0f0YsrCLV65xa7DWxFJF99zMejWIcQ8dYQz9miBc3qkQucTBegVM79ZvFsBZR+Ds9eAe5j1SnkF2eJvI7XMNeDmzT+UA7DuW+kcZdt6G8GVwnRAAYPcCuNLk8F5nEXCCWaRxkJ72RJbltE6QwnFyMschUca0mQq/0VhKqyzh26llJaZ7EM24zTo9KVSOOnhPG5rltoDWBC+wc+pkRZpwnWUnCuwimf1luk7Siz97bBzvg2wVAvOqqhmPh
X-Gm-Message-State: AOJu0YxYAVpoQxL9MYQ5PVGQUNvf3z5uxwiJM9DPEq5buHVqIilfdZ+1
	Za5OxHdtyW5eG6aCl2kwmgYVpmFiO3N8pXq60aMw74/wyws+CDCr
X-Google-Smtp-Source: AGHT+IGILlX3H7ZZb/bgbEfnuywE1wmEzFeRcz3TrJiMVYakeY0hkv1MYe96t08ALc/iXo0i73KEAg==
X-Received: by 2002:a05:6a21:3409:b0:19e:4ed7:127a with SMTP id yn9-20020a056a21340900b0019e4ed7127amr22674991pzb.46.1708521985850;
        Wed, 21 Feb 2024 05:26:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9-20020a62b409000000b006e448fa3d93sm6999855pfn.174.2024.02.21.05.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:26:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 05:26:24 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>, Rae Moar <rmoar@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Kees Cook <keescook@chromium.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	Cassio Neri <cassio.neri@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arthur Grillo <arthur.grillo@usp.br>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Latypov <dlatypov@google.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 7/9] drm: tests: Fix invalid printf format specifiers in
 KUnit tests
Message-ID: <efda07ba-69e0-4544-9432-485036fce165@roeck-us.net>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-8-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-8-davidgow@google.com>

On Wed, Feb 21, 2024 at 05:27:20PM +0800, David Gow wrote:
> The drm_buddy_test's alloc_contiguous test used a u64 for the page size,
> which was then updated to be an 'unsigned long' to avoid 64-bit
> multiplication division helpers.
> 
> However, the variable is logged by some KUNIT_ASSERT_EQ_MSG() using the
> '%d' or '%llu' format specifiers, the former of which is always wrong,
> and the latter is no longer correct now that ps is no longer a u64. Fix
> these to all use '%lu'.
> 
> Also, drm_mm_test calls KUNIT_FAIL() with an empty string as the
> message. gcc warns if a printf format string is empty (apparently), so
> give these some more detailed error messages, which should be more
> useful anyway.
> 
> Fixes: a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test")
> Fixes: fca7526b7d89 ("drm/tests/drm_buddy: fix build failure on 32-bit targets")
> Fixes: fc8d29e298cf ("drm: selftest: convert drm_mm selftest to KUnit")
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/gpu/drm/tests/drm_buddy_test.c | 14 +++++++-------
>  drivers/gpu/drm/tests/drm_mm_test.c    |  6 +++---
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
> index 8a464f7f4c61..3dbfa3078449 100644
> --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> @@ -55,30 +55,30 @@ static void drm_test_buddy_alloc_contiguous(struct kunit *test)
>  		KUNIT_ASSERT_FALSE_MSG(test,
>  				       drm_buddy_alloc_blocks(&mm, 0, mm_size,
>  							      ps, ps, list, 0),
> -				       "buddy_alloc hit an error size=%d\n",
> +				       "buddy_alloc hit an error size=%lu\n",
>  				       ps);
>  	} while (++i < n_pages);
>  
>  	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>  							   3 * ps, ps, &allocated,
>  							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc didn't error size=%d\n", 3 * ps);
> +			       "buddy_alloc didn't error size=%lu\n", 3 * ps);
>  
>  	drm_buddy_free_list(&mm, &middle);
>  	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>  							   3 * ps, ps, &allocated,
>  							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc didn't error size=%llu\n", 3 * ps);
> +			       "buddy_alloc didn't error size=%lu\n", 3 * ps);
>  	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>  							   2 * ps, ps, &allocated,
>  							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc didn't error size=%llu\n", 2 * ps);
> +			       "buddy_alloc didn't error size=%lu\n", 2 * ps);
>  
>  	drm_buddy_free_list(&mm, &right);
>  	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>  							   3 * ps, ps, &allocated,
>  							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc didn't error size=%llu\n", 3 * ps);
> +			       "buddy_alloc didn't error size=%lu\n", 3 * ps);
>  	/*
>  	 * At this point we should have enough contiguous space for 2 blocks,
>  	 * however they are never buddies (since we freed middle and right) so
> @@ -87,13 +87,13 @@ static void drm_test_buddy_alloc_contiguous(struct kunit *test)
>  	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>  							    2 * ps, ps, &allocated,
>  							    DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc hit an error size=%d\n", 2 * ps);
> +			       "buddy_alloc hit an error size=%lu\n", 2 * ps);
>  
>  	drm_buddy_free_list(&mm, &left);
>  	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>  							    3 * ps, ps, &allocated,
>  							    DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc hit an error size=%d\n", 3 * ps);
> +			       "buddy_alloc hit an error size=%lu\n", 3 * ps);
>  
>  	total = 0;
>  	list_for_each_entry(block, &allocated, link)
> diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
> index 1eb0c304f960..f37c0d765865 100644
> --- a/drivers/gpu/drm/tests/drm_mm_test.c
> +++ b/drivers/gpu/drm/tests/drm_mm_test.c
> @@ -157,7 +157,7 @@ static void drm_test_mm_init(struct kunit *test)
>  
>  	/* After creation, it should all be one massive hole */
>  	if (!assert_one_hole(test, &mm, 0, size)) {
> -		KUNIT_FAIL(test, "");
> +		KUNIT_FAIL(test, "mm not one hole on creation");
>  		goto out;
>  	}
>  
> @@ -171,14 +171,14 @@ static void drm_test_mm_init(struct kunit *test)
>  
>  	/* After filling the range entirely, there should be no holes */
>  	if (!assert_no_holes(test, &mm)) {
> -		KUNIT_FAIL(test, "");
> +		KUNIT_FAIL(test, "mm has holes when filled");
>  		goto out;
>  	}
>  
>  	/* And then after emptying it again, the massive hole should be back */
>  	drm_mm_remove_node(&tmp);
>  	if (!assert_one_hole(test, &mm, 0, size)) {
> -		KUNIT_FAIL(test, "");
> +		KUNIT_FAIL(test, "mm does not have single hole after emptying");
>  		goto out;
>  	}
>  
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

