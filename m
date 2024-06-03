Return-Path: <linux-kselftest+bounces-11135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D38FA595
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042E5282E7C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55EB13C9CD;
	Mon,  3 Jun 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG1flP+i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8957333;
	Mon,  3 Jun 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454172; cv=none; b=upjrUhR82IhvP9ddvqWgeg/SSnXcHNdSsFpOLQj0xnFxX1HAqYCy4xQNLmlp6IbMG1lN50GrUjfSH/ZBIFwzkG/UiwQQz9Q66gQknaghaoqQM3cf/XIVutwHoy0PXzOcW4ZukXEZ8cca8pa0vm39etX4mq2uHB+vkWLkYOcnyTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454172; c=relaxed/simple;
	bh=6UM2Nce1Tbntl44YOC4QXxHzVvN1clyiYgBnLClREvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejXeteRWQkZNaZoItHzLbIDnpgBA98Q6RjXP6z41rlj8PKGqzNjLuIlL0IhwRaMxOFXNZ50bZdrqQY0WbfwGm7wfK+ldATpip7QZwZvKTsgodjums6vX8m6cYkfLD6KK9zYrfvt81feFS0LpQG13l5k+1tMHyF91hcPK7ooErcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG1flP+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20013C2BD10;
	Mon,  3 Jun 2024 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454172;
	bh=6UM2Nce1Tbntl44YOC4QXxHzVvN1clyiYgBnLClREvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EG1flP+ilEsMuPF/rVS9CNrlnDAdQ3gLzR79WeL3zWSWfzI1Mm0aUaYpx/uOoS/v5
	 mEC8ysuzei6MS4XXuc36FhEgMB8m3Me94ABpFPlh3BMBm6Zi70V1+fwpeVPMCt7XX1
	 jNC/dQ82UfHY0V+vvuYeK/hJ/u9/Y/V3cfudZw1EikhjhzDMMen48uUHhCgm8zjt9C
	 VG5hH2NS69N23nUZzm0+oz63u5EIQgS83nA0VY6/Y75Bs5RvcC1BA68K8NBUyhBLey
	 7nqhVy/Q16VgpmjJpe/I4ujf2Ik16fcRJMY9umvkljdwbeT+yhaelvKE456MCly87e
	 NyO9mjkXlrIRg==
Date: Mon, 3 Jun 2024 15:36:09 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>, sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] selftests/lib.mk: silence some clang warnings
 that gcc already ignores
Message-ID: <20240603223609.GC1802995@thelio-3990X>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-3-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531183751.100541-3-jhubbard@nvidia.com>

On Fri, May 31, 2024 at 11:37:51AM -0700, John Hubbard wrote:
> gcc defaults to silence (off) for the following warnings, but clang
> defaults to the opposite. The warnings are not useful for the kernel
> itself, which is why they have remained disabled in gcc for the main
> kernel build. And it is only due to including kernel data structures in
> the selftests, that we get the warnings from clang.
> 
>     -Waddress-of-packed-member
>     -Wgnu-variable-sized-type-not-at-end
> 
> In other words, the warnings are not unique to the selftests: there is
> nothing that the selftests' code does that triggers these warnings,
> other than the act of including the kernel's data structures. Therefore,
> silence them for the clang builds as well.
> 
> This eliminates warnings for the net/ and user_events/ kselftest
> subsystems, in these files:
> 
>     ./net/af_unix/scm_rights.c
>     ./net/timestamping.c
>     ./net/ipsec.c
>     ./user_events/perf_test.c
> 
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

This seems reasonable to me.

Acked-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  tools/testing/selftests/lib.mk | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 2902787b89b2..c179c02281e9 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -50,6 +50,14 @@ else
>  CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
>  endif # CROSS_COMPILE
>  
> +# gcc defaults to silence (off) for the following warnings, but clang defaults
> +# to the opposite. The warnings are not useful for the kernel itself, which is
> +# why they have remained disabled in gcc for the main kernel build. And it is
> +# only due to including kernel data structures in the selftests, that we get the
> +# warnings from clang. Therefore, disable the warnings for clang builds.
> +CFLAGS += -Wno-address-of-packed-member
> +CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
> +
>  CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
>  else
>  CC := $(CROSS_COMPILE)gcc
> -- 
> 2.45.1
> 
> 

