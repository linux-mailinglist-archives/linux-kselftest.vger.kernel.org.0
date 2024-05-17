Return-Path: <linux-kselftest+bounces-10365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F25F8C8C3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 20:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF88D1C22295
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010C0101CF;
	Fri, 17 May 2024 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XweNs9D3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B35A23;
	Fri, 17 May 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715970730; cv=none; b=un1HzapwBlYuMyNkhkxJH8yWUkoOl+QR9KH58BEpHm1Thy3ad23T58H4LiZaopBUKgbisOT3a2M8xqjwAlteLM3UicsJ5kl5yKO/xf+DCy4AyeHH6MsRt8lGQsoUpk6Cc3Wu3vD5ggU3xAWftyKlsinJqovOtKR+idgHZq30Y/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715970730; c=relaxed/simple;
	bh=LPdjY38JS7daA139bDVZZYDgoD5tLx+11TEOosNg/4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPfKSCb1CoK2pTY7c0hY0gvVUa4xbyn/8HB0AP6d4s9KtBufRlG8K2OEF8OH8hhQ3fXjDGiLFVathsuT9U1iHUI9w+JILjuQ9VuVYuMCzLzRRrbxndeHGg5Bf5KY+Gw+80lodEIrvIiEpzlN6L/1w5/U0KVq9TEOx+HR6uQod14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XweNs9D3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB42C2BD10;
	Fri, 17 May 2024 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715970730;
	bh=LPdjY38JS7daA139bDVZZYDgoD5tLx+11TEOosNg/4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XweNs9D36pUfQquUW5ankP2N1gE//qJoeFrOwZJEG5N8B7IM5Od7mo74SsqUwLdoZ
	 3319ybnlwnivN+0jT/XtGBcOPb3CGoXcYc1zpTy32HWXqD6FtUSxFU1CE5jasJvdzW
	 VXI9xKppZmtv21AvzNct2ONPK99sbmn6hwcUPC4MIu/A2/ee4pd1Hi8PeyBcvrKBy2
	 11H6hDeCuNYS6XKGZEe98Tx3iRFpfSYVOX/jWVye47Rg2ltoGGaQDyRUIZ+LCRvq9g
	 LNYwsYCzFR8Z6Icj1T7SyuLzg4pcbhpUOpaLPGl4Uv9RrykA9bype6tteHq1Wv0oJH
	 XdkBI3ii85C5A==
Date: Fri, 17 May 2024 11:32:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] kunit: tool: Build compile_commands.json
Message-ID: <20240517183208.GA3699823@thelio-3990X>
References: <20240516-kunit-compile-commands-v1-1-86e61857c820@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516-kunit-compile-commands-v1-1-86e61857c820@google.com>

Hi Brendan,

On Thu, May 16, 2024 at 07:40:53PM +0000, Brendan Jackman wrote:
> compile_commands.json is used by clangd[1] to provide code navigation
> and completion functionality to editors. See [2] for an example
> configuration that includes this functionality for VSCode.
> 
> It can currently be built manually when using kunit.py, by running:
> 
>   ./scripts/clang-tools/gen_compile_commands.py -d .kunit
> 
> With this change however, it's built automatically so you don't need to
> manually keep it up to date.
> 
> Unlike the manual approach, having make build the compile_commands.json
> means that it appears in the build output tree instead of at the root of
> the source tree, so you'll need to add --compile-commands-dir=.kunit to
> your clangd args for it to be found. This might turn out to be pretty
> annoying, I'm not sure yet. If so maybe we can later add some hackery to
> kunit.py to work around it.
> 
> [1] https://clangd.llvm.org/
> [2] https://github.com/FlorentRevest/linux-kernel-vscode
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

This makes sense to do automatically in my opinion, as Python will
already be available (which is the only dependency of
gen_compile_commands.py as far as I am aware) and it should not take
that long to generate.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  tools/testing/kunit/kunit_kernel.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 7254c110ff23..61931c4926fd 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -72,7 +72,8 @@ class LinuxSourceTreeOperations:
>  			raise ConfigError(e.output.decode())
>  
>  	def make(self, jobs: int, build_dir: str, make_options: Optional[List[str]]) -> None:
> -		command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, '--jobs=' + str(jobs)]
> +		command = ['make', 'all', 'compile_commands.json', 'ARCH=' + self._linux_arch,
> +			   'O=' + build_dir, '--jobs=' + str(jobs)]
>  		if make_options:
>  			command.extend(make_options)
>  		if self._cross_compile:
> 
> ---
> base-commit: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
> change-id: 20240516-kunit-compile-commands-d994074fc2be
> 
> Best regards,
> -- 
> Brendan Jackman <jackmanb@google.com>
> 
> 

