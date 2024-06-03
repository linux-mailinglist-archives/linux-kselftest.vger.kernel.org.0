Return-Path: <linux-kselftest+bounces-11149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618168FA5E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080401F2264A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450FB13D2BC;
	Mon,  3 Jun 2024 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVXHcW9P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D23513D2B7;
	Mon,  3 Jun 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454353; cv=none; b=rvrU9weeZUtrtFa8euDLrvbl6JHcFWwkPmVQ8JhZLdjPpc9nZ1Yjujye66AItcMBsPP0I20FKKS/z8ixgMwMBiFmAdGP1rgxC+vIBDKa3pjsXDscOHWuIG4konnLvfjQYu9pFXbk2Y8hhyRnQPs5WcSJOW/igoR+2IeODKJT9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454353; c=relaxed/simple;
	bh=Z+G2URdAE+kmdHSr/8skjh3bJVro0KDIDCAh486xYiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHAM+Xor2dg9jzn75KY8KU+8hSP/vZrDnQ1ZnUP/0Rzwt/YHayT/+7T9rhPiDco+Pt+W1yXf2TcsEV0lCZzwKiXH4DQ6mVwagHXFt2eRl9a3Ugtyi6iCDu5HGDdLrDE13NavrjE9qBSh8gEuSI7s7GeHHswQP7W/SaO9aF5TvC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVXHcW9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA255C2BD10;
	Mon,  3 Jun 2024 22:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454352;
	bh=Z+G2URdAE+kmdHSr/8skjh3bJVro0KDIDCAh486xYiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVXHcW9PiJf7iVxSRzDLRDlGTQwU4kajjnu8dPUyQZpyTJBLzIW9ezi2O3FbRbk+4
	 hw8NIo8kMpfXPObWG1hHq+9lK9a4kGFVN2tIpOStiunijT4tHmvRu8ctyLxVSZi+ou
	 oDwOCyx4v/r+/dhPWAUBq6ngKoO6tIU/zQRyv5ZIyqQoO8/7Z/tTMWfzlmjD6ghoBH
	 JKftMwiW3iUFNRs/cidHwashUXC1f5szjZ5Eq+20nSsPrku86AzQhpgSwV/I4lpT1y
	 Cni7ogH8KozMS8+xL3jMJne3JWcf4qBiCtAqhbqsqiiiYWeO2bz61+ThuawOCS9jUt
	 x8ioO7qqHMxUg==
Date: Mon, 3 Jun 2024 15:39:10 -0700
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
Message-ID: <20240603223910.GE1802995@thelio-3990X>
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

