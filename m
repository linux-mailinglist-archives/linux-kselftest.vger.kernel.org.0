Return-Path: <linux-kselftest+bounces-14482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE4B941F00
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 19:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A5E282032
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 17:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CB2168490;
	Tue, 30 Jul 2024 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoDDn/YW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8101A76C9;
	Tue, 30 Jul 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361775; cv=none; b=irNScWsjVMNJ0yPjhMuhcRGBvCAYvv2nH9Y7JKtenCyUMlLOWsz1BK8E48DVPOJhASdXTDixuAxy+oEyEjVGQ3TL9AHd3jtvg2mAyuTrwAGxYyVIvdPRzW4qvPoFhEHxkIL4+gfj2Dhm+f2FXM2k2hD0QxDnsICZKhvSQnDM6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361775; c=relaxed/simple;
	bh=Fn4z+815jWHioWvHS12w8D6Yphs9Q/IfS4FGbgNzIxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6GMFY2uH+IlCm1A20eLvykCch0HEuOdqN2FmWTPhxYF4eLlMwZKuqYCHwDVJKsRkVw+y9BWxuZxQ5R1sFhi2c/UjUKScOXFu0rMguxLNsmTwxx5+DXb4Cc4K2I5uY4VVyMqoBOwsxvO/4Vl1O9wp3ObZ2EVz2AoTZEpkLtL4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoDDn/YW; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-260fed6c380so3014794fac.1;
        Tue, 30 Jul 2024 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722361773; x=1722966573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex1H/xzAdd49vlk/q9ZizhE1/pl7nx/BYqL/g/8aPbE=;
        b=KoDDn/YWOauvwQj4mSqmXlJ+if/V3h5BFxmBdcBdhrDgQ1fFwy8TjTZaKGq3DEg+Ik
         09QvvJ0Xo4EXHyaigTNEhqzqv48VjBU343tgjFI6DuPO7lKiw2eCrAd4ZPHIJU2juQGl
         RHjfCsgWtEb9mtrnuZwffHJvhz0dp2ASsl6u3Qtl7Q9DExgrLbamWgyKsyPTk4EnQYvd
         UApZ8ABPQUKXpn+YU1EptWNsHU1qwOrisKVNmD360Yv7R2CC00Y0/jD63m8PtUmBjjGo
         h3QS5b/9MWHe8aZ5caVAtPHDdsm4SIdFrOpxazgR9hoJC2uvKeGdNJ81+4LyS8CoPM/7
         Yhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722361773; x=1722966573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex1H/xzAdd49vlk/q9ZizhE1/pl7nx/BYqL/g/8aPbE=;
        b=qoO5NIKmjl7IMCeKW6OEXq6OE1ixVopxWXoVtCYbKeuEDqYuxCOU86Km9D16IY3/1Y
         aH6ZkiVVN0+XY60NBjnNa/Q+psqeVqlj5JkfZXxeb+9XluFDFRpEl9C+guOUoSZYk5Ek
         tenIJHeksCiCwuDSefiXMio8KTuOxNjtvoeZ0ysg7CP5yvQ4/he84ZXbi+YgWq0i/CV6
         Rn1mb+5Ozd0iKu5eH1MOqDdKyBMMUbybXaQeY2cGMPAvKm19IBJCzoAXu7PdpGDVLfWu
         Vkg1PThmNwKFomdX/zGBkCVju4xYOjZEFJi/BYtoT574hmvimDzSdlr6ASOliYOA017V
         7kPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsB9yIyr0JLYlpvkJkAZ5jtJQAbQoXzxcFO5ILnDYxkTgHQpY8RZBcxPmYJW7NUrtRMNylg/t5uaI+tcGUyRbY6l/cTR52gcCrLkKnXhZOQzBoai2nCYOrLxFGZCqTLkd/4hD3yFWP9IdX2Kmd
X-Gm-Message-State: AOJu0YztiVGwAbJsmtugxNq+OfnKStv2RAql9R8nH7bXfIjOr9AfiB2f
	GiEbTAYZGt2RQenjO9kgNkKKSyat/jXbzebXMuIfebCChA3UvCFo
X-Google-Smtp-Source: AGHT+IGGBPRPxd4a+DeBcOOBTDnu5Fv32O7QwKsb+/8kvYdyY+fC1e06owSHASLbAYj8yz0rxVWqcQ==
X-Received: by 2002:a05:6870:4205:b0:25b:6d53:d294 with SMTP id 586e51a60fabf-267d4dd3f45mr15932587fac.23.1722361772717;
        Tue, 30 Jul 2024 10:49:32 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817da8bsm9150580a12.27.2024.07.30.10.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 10:49:31 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:49:28 -0700
From: Yury Norov <yury.norov@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kees@kernel.org,
	John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com
Subject: Re: [PATCH 2/3] bitmap: Rename module
Message-ID: <ZqknqJiz2YAGtzkc@yury-ThinkPad>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
 <ZqUvy_h4YblYkIXU@yury-ThinkPad>
 <85f575b4-4842-4189-9bba-9ee1085a5e80@collabora.com>
 <c0e5978b-7c11-4657-bd07-9962cd04bf9a@infradead.org>
 <CABVgOSnkxgeXXXm9xp5_PvBxtMGbyFN-Jmd6YJ1u6g81MF_fyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSnkxgeXXXm9xp5_PvBxtMGbyFN-Jmd6YJ1u6g81MF_fyw@mail.gmail.com>

On Tue, Jul 30, 2024 at 06:10:55PM +0800, David Gow wrote:
> On Mon, 29 Jul 2024 at 22:09, Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> >
> >
> > On 7/29/24 1:07 AM, Muhammad Usama Anjum wrote:
> > > On 7/27/24 10:35 PM, Yury Norov wrote:
> > >> On Fri, Jul 26, 2024 at 04:06:57PM +0500, Muhammad Usama Anjum wrote:
> > >>> Rename module to bitmap_kunit and rename the configuration option
> > >>> compliant with kunit framework.
> > >>
> > >> ... , so those enabling bitmaps testing in their configs by setting
> > >> "CONFIG_TEST_BITMAP=y" will suddenly get it broken, and will likely
> > >> not realize it until something nasty will happen.
> > > CONFIG_TEST_BITMAP was being enabled by the kselftest suite lib. The bitmap
> > > test and its config option would disappear. The same test can be run by
> > > just enabling KUNIT default config option:
> > >
> > > KUNIT_ALL_TESTS=y enables this bitmap config by default.
> > >
> > >>
> > >> Sorry, NAK for config rename.
> > >>
> >
> > I agree with Yury. Using KUNIT takes away test coverage for people who
> > are willing to run selftests but not use KUNIT.
> 
> I can see the point that renaming the config option is just churn, but
> is there a reason people would run the bitmap selftest but be unable
> or unwilling to use KUnit?
> 
> Beyond a brief period of adjustment (which could probably be made
> quite minimal with a wrapper script or something), there shouldn't
> really be any fundamental difference: KUnit tests can already run at
> boot, be configured with a config option, and write output to the
> kernel log. There's nothing really being taken away here, and the
> bonus of having easier access to run the tests with KUnit's tooling
> (or have them automatically run by systems which run KUnit tests)
> would seem worthwhile to me, especially since it's optional. And
> CONFIG_KUNIT shouldn't be heavy enough to cause problems.
> 
> Obviously I can't force people to use KUnit, but this is exactly the
> sort of test which would fit KUnit well, and -- forgive me if I'm
> missing something -- the only real argument against it I'm hearing is
> "it's different". And while that's valid (as I said, churn for churn's
> sake isn't great), none of the "people who are willing to run
> selftests but not use KUnit" have given reasons why. Especially since
> this is the sort of test (testing in-kernel functions) we're
> encouraging people to write with KUnit in
> Documentation/dev-tools/testing-overview.rst -- if there are good
> reasons people are refusing to run these, maybe we need to fix those
> or change the recommendation.

This doesn't work like this, and never did. Against every change of
that sort there's always a strong, valid and self-contained argument:
don't touch something that works. 

However, reviewers provided more than one reason against this rework.
Every person has their own reasoning. For me it's history wipe and
change of a method how we enable the test. For John, Shuah, Randy and
others there's a bunch of other reasons.

And my question is still unanswered: what exactly is getting better
with this switch to KUNIT, comparing to the old behavior?

From KUNIT development perspective, I'd look at this situation as an
opportunity to improve the framework. If people don't like such things,
I'd leave them alone with their habits and write some sort of
compatibility layer for KUNIT, such that you can integrate the test
that you like into your framework with no or minimal changes to the
original code.

Thanks,
Yury

