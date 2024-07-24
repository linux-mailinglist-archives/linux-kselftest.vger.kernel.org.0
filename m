Return-Path: <linux-kselftest+bounces-14164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7EA93B5D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 19:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DD11F2181A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 17:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F8B15F3F9;
	Wed, 24 Jul 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw4j2Wlk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F015B14C;
	Wed, 24 Jul 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841802; cv=none; b=kaGaki8IcmAbVq2jFWDi40Rfj1ZIOuEpRa2FVKXU81J8cLnLLFp3QvDYlqWVHF+EHjD3WcznPme8GvEs8B4HPRF91NvBorSxhK2wVPRG4FGZNyhbVbbn/cr7VFWvlRTFCrGt70bHi69CHHjInD9KCXqeSBIXTs8F9S5uph4F9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841802; c=relaxed/simple;
	bh=HtaYanDI9QSAj+Q/1e0tx4hNbNfHrEbaegfKgGBVggU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0xPbYGDZqe0AhVwseCqx0Uq43NS49SIsK3dM4JVM5wR9+1+oeyILyMU3iCjebZJjykXaow+KCmsKX2zfc/Nw0QRdzlen19RPy3uyujEoozoWcrOWZSKfLTLDVfDJX3qtLXKUpzeAEkbeiZJOYZMm/l871TwMl5vaVmn1O4yTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw4j2Wlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06B8C32781;
	Wed, 24 Jul 2024 17:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721841802;
	bh=HtaYanDI9QSAj+Q/1e0tx4hNbNfHrEbaegfKgGBVggU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cw4j2Wlk8s5iY0wgXmyGUV6Jmhbdfa79dYmNGXSbmiwyxEIShYDs40i425dpG2eY6
	 5a/+nFe1+G7Vuy//Iwpta0nHr1/ABtogVo3NMwth+ypZpC0OsNHsuZXutt79Vg6iiw
	 jaU1gHeWUA9GIuFUE7GDyLN23ZZUZgV+/Wl2ZIJbUrAGSWMBA6aX4mcLyITc5kr/8K
	 f+Zl725GQeWB+uzOgUUX9Q+MMI4qkw1lUs+3rlE2kFap7aSCQn00hjOmuXM1HmURWi
	 i4igJ/Nfxx4PnOiR5cZh3MD8DqLv37FqOFN04ETPfJjjcZ1DKk5xrUGgbgcveEiWFs
	 UHxUynT39Ue8Q==
Date: Wed, 24 Jul 2024 10:23:21 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Latypov <dlatypov@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	David Howells <dhowells@redhat.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Fangrui Song <maskray@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: Move KUnit tests into tests/ subdirectory
Message-ID: <202407241013.A810920@keescook>
References: <20240720181025.work.002-kees@kernel.org>
 <CABVgOSnz1nvVQBmcZrTsUp3RStBYwk5_VN5-heOSHq3aYMsXTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSnz1nvVQBmcZrTsUp3RStBYwk5_VN5-heOSHq3aYMsXTQ@mail.gmail.com>

On Wed, Jul 24, 2024 at 02:43:15PM +0800, David Gow wrote:
> On Sun, 21 Jul 2024 at 02:10, Kees Cook <kees@kernel.org> wrote:
> >
> > Following from the recent KUnit file naming discussion[1], move all
> > KUnit tests in lib/ into lib/tests/.
> >
> > Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > I can carry this in the hardening tree. To disrupt people as little as
> > possible, I'm hoping to send this either at the end of -rc1 or early
> > in -rc2.
> 
> Thanks.
> 
> I'm happy if you want to rename list-test.c -> list_kunit.c, too.

Sure! I was thinking about doing some separate follow-up changes for
individual tests.

-Kees

-- 
Kees Cook

