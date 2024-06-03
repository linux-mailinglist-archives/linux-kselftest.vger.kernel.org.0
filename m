Return-Path: <linux-kselftest+bounces-11148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C828B8FA5DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F97F1F23EF5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD3B13D257;
	Mon,  3 Jun 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKdXUaQR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233913CF8C;
	Mon,  3 Jun 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454325; cv=none; b=kh05UyleZED1bcakYbpTGI09zn/F3EXipnJqFnd2a9kw8Lls2fr89mPOMmyG08vMBeDuSwdCFr5qaRiqSFDZtAvhvJLdpTmHlzPSua64Jy60usIcJA2frL1bvTZ/qBWEZ3ykjZ3DXlyB1rvSFJn7rGvjWxZtg2lCVL+5nEcWSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454325; c=relaxed/simple;
	bh=Z+G2URdAE+kmdHSr/8skjh3bJVro0KDIDCAh486xYiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIcDdytHajxim/hwb7g4Zr6ptQgLw1y+ZwC5hzBWnkibiQeMr5+fLRw3YxIzP750cBN8Mrd9OjacTRKW1b7Sz4PgQxEts9sMhzvtT6fndlCOMQ34jCAW3xDjBrk/bR4wdlFB2o/32EXY0loYeT0yU1aR4kqW3r3QYqAZbCAlSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKdXUaQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA92C32782;
	Mon,  3 Jun 2024 22:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454325;
	bh=Z+G2URdAE+kmdHSr/8skjh3bJVro0KDIDCAh486xYiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKdXUaQRJ3opA5KUc8AATNQzmSia68LZJ5y/27WyX08yfghsqDAfTq7x/bMjBviF/
	 3l/pCxxqTgoIRtFBkoNR7aXnhy2/v4xllFaIiuwlpQX70EI2JfAwXcbr9iAq1VeTRg
	 Yu/z6Rb5hopIbWWBX1/+DK1cb0dQOpHoeOX7IUzQmS0VRwyyeQW+DzCVmTP64DTfy2
	 fJ5MjC5QIyqk0fea1D80PttExxpEahpl5e102vbfi2oPZT2XNgA7qfUh/DxlCBAvrb
	 Se8S/NHlnnkB1s4kESGDJn6PE6NPdYRNfTtinGMCC4KDws5eTjGct0yHwodGNBcXi7
	 +oEEqUxEMgCMw==
Date: Mon, 3 Jun 2024 15:38:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Alexey Gladkov <legion@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 1/2] selftests/openat2: fix clang build failures:
 -static-libasan, LOCAL_HDRS
Message-ID: <20240603223843.GD1802995@thelio-3990X>
References: <20240601014534.268360-1-jhubbard@nvidia.com>
 <20240601014534.268360-2-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601014534.268360-2-jhubbard@nvidia.com>

On Fri, May 31, 2024 at 06:45:33PM -0700, John Hubbard wrote:
> When building with clang via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> two distinct failures occur:
> 
> 1) gcc requires -static-libasan in order to ensure that Address
> Sanitizer's library is the first one loaded. However, this leads to
> build failures on clang, when building via:
> 
>        make LLVM=1 -C tools/testing/selftests
> 
> However, clang already does the right thing by default: it statically
> links the Address Sanitizer if -fsanitize is specified. Therefore, fix
> this by simply omitting -static-libasan for clang builds. And leave
> behind a comment, because the whole reason for static linking might not
> be obvious.
> 
> 2) clang won't accept invocations of this form, but gcc will:
> 
>     $(CC) file1.c header2.h
> 
> Fix this by using selftests/lib.mk facilities for tracking local header
> file dependencies: add them to LOCAL_HDRS, leaving only the .c files to
> be passed to the compiler.
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Assuming that $(LLVM) is the correct conditional to test for:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  tools/testing/selftests/openat2/Makefile | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
> index 254d676a2689..185dc76ebb5f 100644
> --- a/tools/testing/selftests/openat2/Makefile
> +++ b/tools/testing/selftests/openat2/Makefile
> @@ -1,8 +1,18 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> -CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan
> +CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
>  TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
>  
> +# gcc requires -static-libasan in order to ensure that Address Sanitizer's
> +# library is the first one loaded. However, clang already statically links the
> +# Address Sanitizer if -fsanitize is specified. Therefore, simply omit
> +# -static-libasan for clang builds.
> +ifeq ($(LLVM),)
> +    CFLAGS += -static-libasan
> +endif
> +
> +LOCAL_HDRS += helpers.h
> +
>  include ../lib.mk
>  
> -$(TEST_GEN_PROGS): helpers.c helpers.h
> +$(TEST_GEN_PROGS): helpers.c
> -- 
> 2.45.1
> 
> 

