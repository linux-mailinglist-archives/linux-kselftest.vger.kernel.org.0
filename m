Return-Path: <linux-kselftest+bounces-23191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE78B9ED636
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 20:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E528413B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 19:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312B2210E9;
	Wed, 11 Dec 2024 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kfs3XOsj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3020A5F1
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943917; cv=none; b=SFxa+chH/tJGre5N/hX/9usEZaxb/oA9zhrHqfS8PmwrW9vzwciD+1P+0zkXfUao2vUppvxbq992PzEJL51KmEzTIbcFJY6T3BVwwFqNxEJbId0/TJt8xXKWZrFQxTPBYc4CHIO9TKGVNsFyNXKTPR2869fU2xe6wTd19okGT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943917; c=relaxed/simple;
	bh=zme2gExMIa8O0aULrlIuYHrrv6pTHmTlZfhZlsNBZLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVtzN/dsNPRSzxgTNvIdD4kuPcK8TrU2rT9qxjXB8uiGXW1qg2n5PQjvhy3INJKK7jbLecoH10ATZUNXbmQ+BPX1hBy6LKF0ZqRVirc+bpg/XGcEbLXwsvlZhfWYROWfxFqYeNk/FPcUmBaZgcKAKoNqyeg3GKkINBwBeGqFVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kfs3XOsj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728f1e66418so865575b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733943915; x=1734548715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pai2zwXnYb/yjLCpN+r5F2zZS5epTVdTJfIgHCAfO00=;
        b=kfs3XOsj4VXdMejVP9AYaH/CO1FnDa71G8HckHwz8HS7X346+O7BQdk9CA99Oxgo5g
         miaprk4LG0AZG8ufOQpNHa/G/Phkoryv5pr3HHs7t6qD2yUfofTrRyTfz6y9TkCzaQ//
         8EeyWVUZsDdoqyYsbTpGAYgomGB75GSBNXeyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733943915; x=1734548715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pai2zwXnYb/yjLCpN+r5F2zZS5epTVdTJfIgHCAfO00=;
        b=Hj1aeuIJ5BAHoUhP7EapaTtCKo6vxgAzSM4KA9fapHKxhQhiS+cSmNevRV/dioz7kM
         mCgRc5yDkV/pnPmW8CeTs6tHRoeFVBbBe3lQVeJR8OFeBRAJq95TfdhrbLURk9hehCNm
         Nd6tDFktIGrnfZN6tbt71dDvWhBq5dnk6Sb4FjHP6v/Agxim6sWMFtSoSgMPxsj6yZ05
         9m0QFejt3jAnG161PikhNgfeIqNWrk9l8VGvjWrd9EZFJXnluzVv0zHSAV3+FphcGUOW
         cSJyNf9jj4/7XO7vdKjCbt+cyZ1L+Ptbfb03X+eFsXVa35dsc0A0H9+7lt5zhPjoTjxR
         WStA==
X-Forwarded-Encrypted: i=1; AJvYcCV9CXF4DFLrk8sD6zB54wPe95XuSHhHRAGGLYoVFE8jjdsk0vs8HZL+7YdQkZy92NCHxh7benx0cHLAzePIYsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvI0Jx4Lq/JyUsKzvmxLTf9fQGf+SKe0cK61d8yeEWT3qCGK6u
	k1lXBT6ME9TaezzXuyleB1NRdenmjhvRYZrmYg5qVgCSvD8Eg7Nd0j+iLzbVnjaBYqx9Q7ueqjQ
	=
X-Gm-Gg: ASbGncvhRr8Ec1zuEnj7MvlGRx85I6EVsgEVgsfqu6PqrGfHurPssGxUSXCTB+Dd4KD
	W/gszz5iYQy1ySQu2A5jIheJIx0bVIuONQjnPyp7v9fsBCnq4NAhmmlgh4hT7doCU49OqzTAeQY
	nmZw/WoPjTOIcnwynh0/qTiRQuXbiiWSTPKMKot011RNSyXq3XM1Q9RVXf1nNTyi2eFCclFZsj/
	OHkQuO5dKYf77WgeRo8XgPd0VHGCzdAqFw+8wkqkXZOedzHYh8XoJD+M99BNsyTVCqIBZmYMOtZ
	g0xrKqGyKgJx1YYB
X-Google-Smtp-Source: AGHT+IFdyWYx2G4cnbwA4oAxj0NmbbLvxDbwmi5Togy5gLT2zNlutIoYnOMD9+84fGHVxbzA+APUCg==
X-Received: by 2002:a05:6a21:3395:b0:1e0:d380:fe66 with SMTP id adf61e73a8af0-1e1ce902bf2mr676714637.0.1733943915162;
        Wed, 11 Dec 2024 11:05:15 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:b1a5:9c72:5742:89e0])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-725e77b9a21sm6653260b3a.21.2024.12.11.11.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 11:05:14 -0800 (PST)
Date: Wed, 11 Dec 2024 11:05:12 -0800
From: Brian Norris <briannorris@chromium.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Rob Herring <robh@kernel.org>, David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/4] drivers: base: test: Drop "devm" from
 platform-device-test names
Message-ID: <Z1niaC9Z5hCHxszZ@google.com>
References: <20241210191353.533801-1-briannorris@chromium.org>
 <20241210191353.533801-4-briannorris@chromium.org>
 <uxpnt2u2vnoh2ienawlz5e2gbwseacb5eyldnomz2sal6u2224@wjwrfgicoez7>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uxpnt2u2vnoh2ienawlz5e2gbwseacb5eyldnomz2sal6u2224@wjwrfgicoez7>

Hi Maxime,

On Wed, Dec 11, 2024 at 06:05:49PM +0100, Maxime Ripard wrote:
> On Tue, Dec 10, 2024 at 11:13:32AM -0800, Brian Norris wrote:
> > This is a reasonably-helpful base for generic platform_device tests, and
> > I'd like to add more tests that aren't specifically about "devm"
> > functions. Drop the devm namings for the suite, for clarity.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> >  drivers/base/test/platform-device-test.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
> > index ea05b8785743..fd871bb9e143 100644
> > --- a/drivers/base/test/platform-device-test.c
> > +++ b/drivers/base/test/platform-device-test.c

> > @@ -211,13 +211,13 @@ static struct kunit_case platform_device_devm_tests[] = {
> >  	{}
> >  };
> >  
> > -static struct kunit_suite platform_device_devm_test_suite = {
> > -	.name = "platform-device-devm",
> > -	.init = platform_device_devm_init,
> > -	.test_cases = platform_device_devm_tests,
> > +static struct kunit_suite platform_device_test_suite = {
> > +	.name = "platform-device",
> > +	.init = platform_device_init,
> > +	.test_cases = platform_device_tests,
> >  };
> 
> The rest of the patches look ok to me, but it still seems like it tests
> something different (ie, devm actions) so I don't see why we should
> group them in the same test suite.

My goal was to avoid adding a new test file for every sub-topic of "test
platform devices". Would adding a second suite in this file make more
sense, then? If so, I'll just drop this patch, and do that when adding
the test.

(I'm not that familiar with kunit conventions yet.)

Brian

