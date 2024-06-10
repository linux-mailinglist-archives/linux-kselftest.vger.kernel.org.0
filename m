Return-Path: <linux-kselftest+bounces-11593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FAB902904
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1145286104
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 19:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB69139578;
	Mon, 10 Jun 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlrJ56iY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C11B5A4;
	Mon, 10 Jun 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046672; cv=none; b=W+7/5RdrYUTwflGWOAWQwSUkKOEy8kMl0I5JNHiBNA74s1dX7wVt1BkkeMorfqcVvEflUYxykQY6m61cCeU13YXGRW4LC+HJYE5TP8stwlghIfJrUMyXFPxaDotTq4gKzcG3fa0JQfIcmu7W5Dar+6l3pbX5fi4HdMbdI4YVuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046672; c=relaxed/simple;
	bh=Am+1VRHQSbf2WAYS4raTblVDlWJa42B8soubx3hgfgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPAboRfI0HV5oY9Pdkc1JJi+clVKdbWD/MwSQ3cxza2umyzK0vhr28pyBma7Au26HaJi/psjjacf20h4alW6Rt5OKy1Rhi8wMx8DS2K55NUlGVai9EYahqCJTybIQEW0U2KRv2kgIcXzRM93sVoSf2fM5uxJfhtZK6bW5mrUp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlrJ56iY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8362C2BBFC;
	Mon, 10 Jun 2024 19:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718046671;
	bh=Am+1VRHQSbf2WAYS4raTblVDlWJa42B8soubx3hgfgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlrJ56iYRD3BNCRQ3tLeSdx9Lvmr1Hh2+tTudfGTi68y24n6xNLkfgQ/k9ABPHxd5
	 rE6DE8+ACD4bPJuawyiKNzrrkC+DMEgMQ+Ptu21S1FiBpqnKYdB4RbI+fcVyP912Te
	 pFUy0rHhnmyaAlq4hgtfSE0zHmbqN/iKC+HMMdFjYcf/3vJXpb/hetxyG3G7rqNj/5
	 dvcoV+gFFKEqxSgSU+bV226TdSRewBND1jWv4+P0qMX5zXRI4REGuyNCdutRD53hcX
	 pnTbRQkwuvYuVTcGL/qi6905RVhDD7Z2Uxlkb7MmW1oATOC29XIQ7IJHumVbuGT9zx
	 8ukAIvECUDmcw==
Date: Mon, 10 Jun 2024 12:11:11 -0700
From: Kees Cook <kees@kernel.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] usercopy: Convert test_user_copy to KUnit test
Message-ID: <202406101209.1B76564DC@keescook>
References: <20240519190422.work.715-kees@kernel.org>
 <20240519191254.651865-2-keescook@chromium.org>
 <e384af13-ca63-4847-a84d-5957abd5d903@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e384af13-ca63-4847-a84d-5957abd5d903@gmail.com>

On Wed, May 29, 2024 at 01:17:35PM +0100, Ivan Orlov wrote:
> On 5/19/24 20:12, Kees Cook wrote:
> >   #define test(condition, msg, ...)					\
> >   ({									\
> >   	int cond = (condition);						\
> >   	if (cond)							\
> > -		pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);	\
> > +		KUNIT_EXPECT_FALSE_MSG(test, cond, msg, ##__VA_ARGS__);	\
> >   	cond;								\
> >   })
> It looks like the 'test' macro is not used anymore, so probably it should be
> removed.

Oops, yes. Thanks!

> > +static int usercopy_test_init(struct kunit *test)
> > +{
> > +	struct usercopy_test_priv *priv;
> > +	unsigned long user_addr;
> > -	if (ret == 0) {
> > -		pr_info("tests passed.\n");
> > -		return 0;
> > -	}
> > +	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> 
> Should the check be done with KUNIT_ASSERT_NOT_ERR_OR_NULL here as well, as
> it is done with priv->kmem?

Yes, that's much more idiomatic. I'll adjust this too.

> Other than that,
> 
> Tested-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Thanks!

-- 
Kees Cook

