Return-Path: <linux-kselftest+bounces-13989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7688939082
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654D71F2228E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E416D9DE;
	Mon, 22 Jul 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO5V4H3D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176B166308;
	Mon, 22 Jul 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658035; cv=none; b=QtSn8+n/zlDoOqsFGWHpuxlthnecvggjFuJ1pdEVDg7EN3KtZuyGJm6zPPuhvR6S9FADZ/Ay2K4zoN1WPGBBwSDdghFsMFCFsXvuIpWmol2NVDppmtjWvwnkv2FgbvTCvuN2wwWFO01Uwnx8reT40HmBYnKvfAzk2yFyEjE57mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658035; c=relaxed/simple;
	bh=07OKVXPlL2k0nMN/FFjyw5zCAvkTGVa75D8oPfGpIV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiicngH+mWaZY9Wz7BzROvNwmXENhQOCtM78zPBU5ZTHV00UUNPK0qCeBUMLB66grmzpTkDx+ueONajrPvys/MtamaAlvw39V7CH1iE2Km5hlzZK6tT7HVZx/IR6Zke/SQFjbIGMUtgVxDU4Quk6Gwe/hazowBC9/ZsXVB9s+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO5V4H3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1674C116B1;
	Mon, 22 Jul 2024 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721658034;
	bh=07OKVXPlL2k0nMN/FFjyw5zCAvkTGVa75D8oPfGpIV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YO5V4H3DNBvnikJLtBZ0h2pojob4SemU3BvK9ZPA9+QevYemJ891Uqb1sQGemfT0I
	 le+gdZziLOUgVIXLYlLtMotXzFgjDRSoJJ9e1PvO4Nrs3HygKOxKr0kalSJG6kWf3t
	 uZwKy1VRlYvCwCPG2aQ1w6DgN2lczei3SUdUaxgNWQTuwgA7OLDMooYcBy/ZIqHU4y
	 VH5mxe3syD945lhmF3YklGKIMK7fD3qizbdUy3B56L+m8EmZoZ8uYfXF2DrCeQacZT
	 PpJU0mc229JKIty3rn+fnvHX8bmHphIjFJspDUf7qJRrNJWzZD2mG0nTVnblGm4QUq
	 6dBGg2opmpRnw==
Date: Mon, 22 Jul 2024 07:20:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, David
 Gow <davidgow@google.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Andy
 Shevchenko <andy@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Brown
 <broonie@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org, Palmer
 Dabbelt <palmer@rivosinc.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Charlie Jenkins <charlie@rivosinc.com>,
 Simon Horman <horms@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan
 <skhan@linuxfoundation.org>, Daniel Latypov <dlatypov@google.com>, Guenter
 Roeck <linux@roeck-us.net>, David Howells <dhowells@redhat.com>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, Marco Elver
 <elver@google.com>, Mark Rutland <mark.rutland@arm.com>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Nathan Chancellor <nathan@kernel.org>,
 Fangrui Song <maskray@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: Move KUnit tests into tests/ subdirectory
Message-ID: <20240722072032.6284c2c3@kernel.org>
In-Reply-To: <20240720181025.work.002-kees@kernel.org>
References: <20240720181025.work.002-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jul 2024 11:10:30 -0700 Kees Cook wrote:
> Following from the recent KUnit file naming discussion[1], move all
> KUnit tests in lib/ into lib/tests/.
> 
> Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Makes sense:

Acked-by: Jakub Kicinski <kuba@kernel.org>

BTW love the suggested guidelines hidden in the Link.

