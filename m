Return-Path: <linux-kselftest+bounces-11599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35C990297D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3641C22F3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC13A149C43;
	Mon, 10 Jun 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFtiEEE1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3DB1BC39;
	Mon, 10 Jun 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048903; cv=none; b=g+5dsVNVQ/lviQFuZ5agDpc4ba2OE6eXwpy2XaICtSUHP6UYWVTj64eowUs9XdvJ7hLdYcXUd7VP+XYk5zoSJuWTKGV02DBoIzGm+PP4EbYMLdhQC7Rv9ZIK/R5OeAJUAu3KwlBWiXt+yhmjNYLXbrUBryKRT8B0f4k9INyU2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048903; c=relaxed/simple;
	bh=y4yr6XQlhvTeATPlaR4oANDTI7XUzBVLj7I//aVWdn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeDeK5CDJb+dKzKFtUhR1TvGDnu4eDCttK4oM/PWGyo3ua1oxBbV4b+Wixq92YgCAudU6CM4Ov29I4D9Gtn6THTwja+fDcCfxSGk3MaDtm9S7xi6rA7FQhzOvI9IGbwFDG8wRapWOuP4ldZTkJDj5Yir27qSEwhgYFVbc3r6D1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFtiEEE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BF7C32789;
	Mon, 10 Jun 2024 19:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718048903;
	bh=y4yr6XQlhvTeATPlaR4oANDTI7XUzBVLj7I//aVWdn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFtiEEE1zUJXk3fX31cc3rHmSr28aVw4I/cB2DTrltE5wkAUhQecNFnRr60qiJ/6Y
	 SydztAwniQvMUZzK3/rV7bh09ehTEOV+sXA4txhM3EFYvUkTEvZuqM7ecwNR8hHksB
	 76Es7DjlnYIfxED6BxS1uwg/sQ6JUC9ns6ZPutfZxcRZ1CFKN3RH4sFoU3oeN9LvGV
	 Xt3hJSnF/bLqNJj11S6uJ9nrQpKXRW7zS2eHpqnOS8R5IoV95myRSbStvOvt2Y8vy3
	 jgSzBjLqj2Or2Hs3l37JJm9H2eSXZNoBS2tdrSOc0cpM+3eiYHbSwsIe1OwOySJ9X0
	 hk6EkUpxJNqmw==
Date: Mon, 10 Jun 2024 12:48:22 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] usercopy: Convert test_user_copy to KUnit test
Message-ID: <202406101241.C1BE6791@keescook>
References: <20240519190422.work.715-kees@kernel.org>
 <20240519191254.651865-2-keescook@chromium.org>
 <CABVgOSn=tb=Lj9SxHuT4_9MTjjKVxsq-ikdXC4kGHO4CfKVmGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSn=tb=Lj9SxHuT4_9MTjjKVxsq-ikdXC4kGHO4CfKVmGQ@mail.gmail.com>

On Sat, Jun 08, 2024 at 04:44:10PM +0800, David Gow wrote:
> On Mon, 20 May 2024 at 03:12, Kees Cook <keescook@chromium.org> wrote:
> >
> > Convert the runtime tests of hardened usercopy to standard KUnit tests.
> >
> > Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Link: https://lore.kernel.org/r/20200721174654.72132-1-vitor@massaru.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> This fails here on i386:
> >      # usercopy_test_invalid: EXPECTATION FAILED at lib/usercopy_kunit.c:278
> >      Expected val_u64 == 0, but
> >          val_u64 == -60129542144 (0xfffffff200000000)

Hunh. I can reproduce this with "--arch=i386" but not under UML with
SUBARCH=i386. But perhaps it's a difference in the get_user()
implementations between the two.

And this looks like a bug in the get_user() failure path on i386. I will
investigate...

> It also seems to be hanging somewhere in usercopy_test_invalid on my
> m68k/qemu setup:
> ./tools/testing/kunit/kunit.py run --build_dir=.kunit-m68k --arch m68k usercopy

Oh, that's weird. I'll need to get an m68k environment set up...

> Otherwise, it looks fine. Maybe it'd make sense to split some of the
> tests up a bit more, but it's a matter of taste (and only really an
> advantage for debugging hangs where more detailed progress is nice).

Yeah. I can do this in follow-up patches, perhaps.

> With those architecture-specific hangs either fixed, or documented (if
> they're actual problems, not issues with the test), this is:
> 
> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

-- 
Kees Cook

