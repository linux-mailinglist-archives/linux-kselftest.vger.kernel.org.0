Return-Path: <linux-kselftest+bounces-117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAAB7EBAFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 02:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7704328131D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 01:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32920630;
	Wed, 15 Nov 2023 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712539B
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 01:43:29 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Nov 2023 17:43:28 PST
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF96E4
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Nov 2023 17:43:28 -0800 (PST)
Received: from localhost (88-113-24-34.elisa-laajakaista.fi [88.113.24.34])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 38a819f9-8358-11ee-b3cf-005056bd6ce9;
	Wed, 15 Nov 2023 03:42:24 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Wed, 15 Nov 2023 03:42:22 +0200
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pengfei Xu <pengfei.xu@intel.com>, yi1.lai@intel.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: selftests: gpio: crash on arm64
Message-ID: <ZVQh_nvgqMkd3tN6@surfacebook.localdomain>
References: <CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com>
 <ZAocZRZh4FQRH3lc@smile.fi.intel.com>
 <CA+G9fYsOttth+k3Ki8LK_ZiayvXa0bAg-DmQAaFHZeEyR=6Lrw@mail.gmail.com>
 <CACRpkdbUYWcFiRh+Y=MOekv2RjSP4sB2t5tVrSsz54Eez6wmVg@mail.gmail.com>
 <ZJHWdcP+PDaNrw07@smile.fi.intel.com>
 <CA+G9fYvReHr+ofJAW4yfA5EWT6-MRpR2+fOQG24hROjSd+dY0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvReHr+ofJAW4yfA5EWT6-MRpR2+fOQG24hROjSd+dY0g@mail.gmail.com>

Tue, Nov 07, 2023 at 07:21:32PM +0530, Naresh Kamboju kirjoitti:
> On Tue, 20 Jun 2023 at 22:11, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Apr 11, 2023 at 10:57:28AM +0200, Linus Walleij wrote:
> > > On Mon, Apr 10, 2023 at 11:16 AM Naresh Kamboju
> > > <naresh.kamboju@linaro.org> wrote:

...

> > > Add a pr_info() devm_gpio_chip_release() in drivers/gpio/gpiolib-devres.c
> > > and see if the callback is even called. I think this could be the
> > > problem: if that isn't cleaned up, there will be dangling references.
> >
> > Side note: Since we have devres tracepoints, your patch seems an overkill :-)
> > Just enable devres tracepoints and filter out by the function name. I believe
> > that should work.
> 
> Since I have been tracking open issues on the stable-rc kernel,
> The reported problem on stable-rc linux.6.3.y has been solved
> on the stable-rc linux.6.6.y branch.
> 
> Thanks for fixing this reported issue.
> 
> Upstream links about this fix and discussion,

I'm a bit lost. Is the [3] fixed? Is the fix the below mentioned commit?

> Commit daecca4b8433
> gpiolib: Do not alter GPIO chip fwnode member
> 
> [1] https://lore.kernel.org/linux-gpio/20230703142308.5772-4-andriy.shevchenko@linux.intel.com/
> [2] https://lore.kernel.org/linux-gpio/CAMRc=MfFEBSeJ78NO7XeuzAMJ0KezEPAYWsWnFXXaRyQPAf3dA@mail.gmail.com/
> [3] https://lore.kernel.org/linux-gpio/CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com/

-- 
With Best Regards,
Andy Shevchenko



