Return-Path: <linux-kselftest+bounces-11152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C773F8FA602
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECC5B214E2
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD0513CA87;
	Mon,  3 Jun 2024 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fibaACtf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5D13B791;
	Mon,  3 Jun 2024 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454831; cv=none; b=kr91nHR806BI7E97zHE4jAtv4KDMXKxpzAIOPeNGANzkvBZheQwq7yk/l/ztODnm33mKJjE1wmHrWVYSiFZjq3kWbvtVVeaqJ9dTsXfvgIYzB5GP54vtfS+ZJ1ooDMkp9UdJ9zABQO7KiefKHo+DRgwjVpetNB6Dqbl0Yg8ELTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454831; c=relaxed/simple;
	bh=viU1XXBpM47eqpx2+Q22SLTf97RsegF6lP9ebaCxH3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlOOVUsFrSMu2NGEQ3Ji3qqEMLrCPkWdKn7RDnZ6/3gyjjqn1USqLMpE5l2aPdVxUYbhMPKJLsHkRCYDH3o1vNeh2Kxwa0W6/7JyFeMDGLD7rgsNFvS9m2W+QDMo6nEJxbdZqhC/kCgj1NzsfF9mETrn/doy0GAEs+azAEyKoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fibaACtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6FEC2BD10;
	Mon,  3 Jun 2024 22:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454829;
	bh=viU1XXBpM47eqpx2+Q22SLTf97RsegF6lP9ebaCxH3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fibaACtfiFsAyDwOQ8T4iWHN6EJUe1UdfAOBceRjSifasIW0VkEXocDArEp3L55OF
	 F5M7HInrIYVfen/XSGHB1Z0h7pLUD9yumTMpjLDYbfOko9bH0uanfSpARwi5pW9hBa
	 EBnHNOr54fmrk9YNfq2Um7YB0mtrBcQZB/FO68+MPXvGdaWyXBrUzfbPP9UR4yNwCh
	 N/mEJe0f75f8DB8G5dez4l0Z9c8pQzg1G6hbsLYdJ8MBcSsRJ1SIgSmqALWobgVokT
	 p2aK5BDkEAW04ieNySDTH861kjrIWFzcT01e/P3zcy3wu6vzzefvwHwcj9lMTxo5DT
	 ph7xhvmetK5zA==
Date: Mon, 3 Jun 2024 15:47:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>, sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v2 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang
 builds
Message-ID: <20240603224706.GA245774@thelio-3990X>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-2-jhubbard@nvidia.com>
 <306eebf8-bb5d-4e1a-9fa3-ad3f4ea11b9c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <306eebf8-bb5d-4e1a-9fa3-ad3f4ea11b9c@sirena.org.uk>

On Mon, Jun 03, 2024 at 04:32:30PM +0100, Mark Brown wrote:
> On Fri, May 31, 2024 at 11:37:50AM -0700, John Hubbard wrote:
> > The kselftests may be built in a couple different ways:
> >     make LLVM=1
> >     make CC=clang
> > 
> > In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest
> > of lib.mk, and any Makefiles that include lib.mk, can base decisions
> > solely on whether or not LLVM is set.
> 
> ICBW but I believe there are still some architectures with clang but not
> lld support where there's a use case for using CC=clang.

Does CC=clang even work for the selftests? lib.mk here uses 'CC :=' so
won't CC=clang get overridden to CC=$(CROSS_COMPILE)gcc?

Cheers,
Nathan

