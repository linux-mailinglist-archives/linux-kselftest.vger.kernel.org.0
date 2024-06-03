Return-Path: <linux-kselftest+bounces-11150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 227108FA5E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BF2288B56
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84213D2AC;
	Mon,  3 Jun 2024 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoepBxpF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464A13D24F;
	Mon,  3 Jun 2024 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454379; cv=none; b=VH3na866c1goF+J0OkNDAZxQFZXTSCg7oYNCKrSdamwRLrvhlgVRAVS6y54kHVJwxEY7CKdTWIKfrzIGJG1ZPpxhZFcHVx8eujosdbc1DGXIMtgutRBLoZ97YYspbC8xQmD9hs9JxmHH+bRr534JUv1AYworB1FNOo7AiNhIN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454379; c=relaxed/simple;
	bh=0LLQ5lJZ6hnYFLe6WYRyFDFSE/8SfEOMOLofPf58dFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPCQ2kedPEV7ANqFSjqldetKMqFg8ANSxLaJwZcXgBH/bWM9/2t1dOFpDXU1GRyURr58GDaGgu8E6v9dD6wsdFQ4cdOgCZ4yuKNOm/BLhmiPmR5wAjAF3gRCjojr12crRTrGg5HXb091zgY9VlCoqDMJr0HHQTbWCczAExtMD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoepBxpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6542DC2BD10;
	Mon,  3 Jun 2024 22:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454379;
	bh=0LLQ5lJZ6hnYFLe6WYRyFDFSE/8SfEOMOLofPf58dFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aoepBxpFjr2LAhAoJKoYel6/6PvGXzK1S4ag/igyDvx9vH8rCGE7IIXvv73xV+uzp
	 78Kp9vASY84ZpXhgyxj2YjVTCJSiUnK0WHS0i4IsZZp9ch5KQN1dLdTTR2EGDVT5Ic
	 VM7xTk6hHPbWh0mUhNCk3ufK6IeeT3Xvc+okI/W+zTWpKVq51kaz6vI5LUAMGjg4VT
	 2KDFb3SQBZmUOZzKv+1sDOe8Cbu2kfgws9rpaHGKJuQv7RQPmAvdcEbrqWX15uxS2c
	 PPYC3f4dYDy3tecrIeaN0DgGoNsUxkKUZaRvXzTaXqqLyxarf6iXxqYQZNGxOtpJKW
	 7oup501SAYyog==
Date: Mon, 3 Jun 2024 15:39:36 -0700
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
Subject: Re: [PATCH v2 2/2] selftests/fchmodat2: fix clang build failure due
 to -static-libasan
Message-ID: <20240603223936.GF1802995@thelio-3990X>
References: <20240601014534.268360-1-jhubbard@nvidia.com>
 <20240601014534.268360-3-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601014534.268360-3-jhubbard@nvidia.com>

On Fri, May 31, 2024 at 06:45:34PM -0700, John Hubbard wrote:
> gcc requires -static-libasan in order to ensure that Address Sanitizer's
> library is the first one loaded. However, this leads to build failures
> on clang, when building via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> However, clang already does the right thing by default: it statically
> links the Address Sanitizer if -fsanitize is specified. Therefore,
> simply omit -static-libasan for clang builds. And leave behind a
> comment, because the whole reason for static linking might not be
> obvious.
> 
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Assuming that $(LLVM) is the correct conditional to test for:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  tools/testing/selftests/fchmodat2/Makefile | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
> index 71ec34bf1501..4373cea79b79 100644
> --- a/tools/testing/selftests/fchmodat2/Makefile
> +++ b/tools/testing/selftests/fchmodat2/Makefile
> @@ -1,6 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> -CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan $(KHDR_INCLUDES)
> +CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
> +
> +# gcc requires -static-libasan in order to ensure that Address Sanitizer's
> +# library is the first one loaded. However, clang already statically links the
> +# Address Sanitizer if -fsanitize is specified. Therefore, simply omit
> +# -static-libasan for clang builds.
> +ifeq ($(LLVM),)
> +    CFLAGS += -static-libasan
> +endif
> +
>  TEST_GEN_PROGS := fchmodat2_test
>  
>  include ../lib.mk
> -- 
> 2.45.1
> 
> 

