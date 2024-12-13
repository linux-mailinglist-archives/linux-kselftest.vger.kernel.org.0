Return-Path: <linux-kselftest+bounces-23370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E489F174B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 21:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E787A028F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AFE190057;
	Fri, 13 Dec 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hnh+Iyph"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22318D649
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120840; cv=none; b=lizyiQ+6KPYbN9fGa4Jt1X9UkU3C/up1wTFvCyS5UGuTGo5pKZhABbtlL8fXVWloZGbsCs6kSsMLVxxDRcUJ0nh91TJXDICorNhyH/LwagDYHBZMifY7ZURyvhY+yGgngu5hHrvQKPdxf1cJepZX5+IhiDJ2dz/KWGw5B6V5gR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120840; c=relaxed/simple;
	bh=f2jyOe+lg8F1rPmqbu6chfwX4anYDD0i5ra/as4BSA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBVUXbjE/6UPHP/hoq2rTQz0NL010qrQ7S1e4qW6L2Bp2mW7hJY3Zj5qWF1tVZAqnsUMRuliGFJG6PQas8U7wh9+oceD2vRq9fVzUDMPj09mUir5GU/E+VSW6nMCsu3nV+NvKtJYU8Rhj00jUwXtCKhhO/io+IkbGAOPE+kNiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hnh+Iyph; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee76929a98so1657679a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 12:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734120838; x=1734725638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EA2vp+0Q4hjfylA+aN4ZK1qWmF0cLRB2spMI6XM8wUI=;
        b=hnh+IyphpXPI/UfAnVsow7vFiYny3cbbkGxQnLbht3pRATm31pL7PJCbHV2kIajQ1B
         mLLNxjG/AihUqqAabp/naZqykHbM25RTv4WtWXQK1aj6J0T3B0y9o4TtAprV5rxnX3vC
         n7vXlVW71bAaK+UKh7dpjPJjR+FcAaIhID6XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120838; x=1734725638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA2vp+0Q4hjfylA+aN4ZK1qWmF0cLRB2spMI6XM8wUI=;
        b=A1d4mZAU6mRX6C9lofuHVuJkgnMrr/ofqpoS1FTKhc9D2wkeYnYc6BZDuPr597MHP7
         eBjA5EAljGB4CaVTS3ZzxuDKXJr1WA+F89qOOa/hFQDUGNVIZ18/3dQsfXL89bnxFxnn
         4TUFg2x49z0qqQPwn4IhGUnRLXxycNI1K76AwVIKeroK/Z1h+pkYmZJMcY6qq8UwxQiW
         5sQ6+ZfIMPNH1oJZc0RF/5lK86jiQW0M9h4wVSgdiGeUuQXCtruuVjzgM1I42PHZHIEW
         6UaF1EicH/6F6ZbAemBlvqy8HSd0oJZElI8NXe3lAIy0SDNclGd6Ns6xOvF5jI9Tgm4T
         Ol7w==
X-Forwarded-Encrypted: i=1; AJvYcCVcfkdylAlDD8KicDWum2oJ93n/VmIyI+prijuxEKv7eI8AJFONxkReD3lFypPllwSomBi65SLi6TqTRVEeF0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5bmVSG05dns8dCp6o/kl8k+FhG7Mxos5MfzHJiKkyVCvQcYs
	o30U1U63TJcxeVPRSNNCIhcBXaL1X9BuciZ8CIC9K/Gc1MkKbdFjqZNEE998pA==
X-Gm-Gg: ASbGnct8/TyfDpI//UKfjGkSJ94zZFz9suKWJZJT12C2P3/aSaQamy0ZsQTV38myKVN
	zmHACaNITyMTZC1cCj+OScz2J78keIeuofZ9Bx3YWgSSsFMPQ8kCeq9sRzy7OjekRCi143bBrH+
	0Z+7XzdKPyv7d2dWB0qOd9x/TG5W4TZOBmjMfb9hsUMuellIr+q9rWR5YLkk/totcq3/VbzFTpg
	CmvGQi5oDU4aU5R4i7y9WFTMuEjvAHQqxkvGDq5xAlLfJQ1nRFbqsA7Wnjm40rLSenkJuiO6jS0
	CZ1JEtQU86gwb/VT5Q==
X-Google-Smtp-Source: AGHT+IE2v3SR/KU8sT1pXTDInylE09uN/fwe8e1DJVZHqAxSyKPgCbB080FVuQIdjxru6cGbzDWahg==
X-Received: by 2002:a17:90b:1c03:b0:2ee:9229:e4bd with SMTP id 98e67ed59e1d1-2f29153af6bmr5376411a91.2.1734120838389;
        Fri, 13 Dec 2024 12:13:58 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:356a:489a:83c:f7d9])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f2a1e9c561sm177437a91.14.2024.12.13.12.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 12:13:58 -0800 (PST)
Date: Fri, 13 Dec 2024 12:13:56 -0800
From: Brian Norris <briannorris@chromium.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com, David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] drivers: base: test: Add ...find_device_by...(...
 NULL) tests
Message-ID: <Z1yVhPJjxKhsc7VE@google.com>
References: <20241212003201.2098123-1-briannorris@chromium.org>
 <20241212003201.2098123-4-briannorris@chromium.org>
 <20241213-athletic-strong-bumblebee-bfabf1@houat>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-athletic-strong-bumblebee-bfabf1@houat>

Hi Maxime,

On Fri, Dec 13, 2024 at 12:59:57PM +0100, Maxime Ripard wrote:
> On Wed, Dec 11, 2024 at 04:31:41PM -0800, Brian Norris wrote:
> > --- a/drivers/base/test/platform-device-test.c
> > +++ b/drivers/base/test/platform-device-test.c

> > @@ -217,7 +219,45 @@ static struct kunit_suite platform_device_devm_test_suite = {
> >  	.test_cases = platform_device_devm_tests,
> >  };
> >  
> > -kunit_test_suite(platform_device_devm_test_suite);
> > +static void platform_device_find_by_null_test(struct kunit *test)
> > +{
> > +	struct platform_device *pdev;
> > +	int ret;
> > +
> > +	pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> > +
> > +	ret = platform_device_add(pdev);
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> 
> I *think* you have a bug there: if platform_device_add fails,
> KUNIT_ASSERT will stop the test execution and thus you will leak the
> platform_device you just allocated.
> 
> You need to call platform_device_put in such a case, but if
> platform_device_add succeeds then you need to call
> platform_device_unregister instead.

Hehe, well I'm imitating the existing leaks in the other tests in this
file, then ;) But admittedly, those are a little more complex, because
the unregistration is actually part of the test flow.

> It would be better to use kunit_platform_device_alloc and
> kunit_platform_device_add that already deal with this.

Cool, thanks, I'll use those in v3 for my new test.

> The rest looks good to me, once fixed:
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks for the tips and review.

Brian

