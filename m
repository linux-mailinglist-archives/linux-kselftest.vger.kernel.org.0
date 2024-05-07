Return-Path: <linux-kselftest+bounces-9578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262338BDCA1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 09:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68F6285A64
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 07:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992CF13C3E2;
	Tue,  7 May 2024 07:45:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D935813BC39;
	Tue,  7 May 2024 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067936; cv=none; b=LoaNLRVADUNX3Vo3PZKMPI5GFdqtiaiSCab8NnN0nfP4zpB9eScW8XDdLMxzbQEIhH5XAVvUnvUoaqL27T42arX01mLas0qHo6drQZMRpxyuqpgAxbExa1o5fCFm3JVflF/IRA2aSZwCOBxKrtO5xr4RuIgFeNSH9JHQaM1IUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067936; c=relaxed/simple;
	bh=lVju8t74Z+z4Q0tbilEYLbe3G8jbkqVvp9HTVSKSQ40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHwV/v9XqI08S/8NW4rKFZrTNpTBMnqUhJKcXNNxlQ2zAqQDhT8JOvBOdlR7db14TQV9Atw7YNk6awA7WzyoeqqLjGTg8DVKUY4QR0ptioqNjMSWgoNIimRuJlcU8kK+3N1XNzdx9fH4iJOtx18XteDOQhdXVh1mmLpVSA/50HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BADB106F;
	Tue,  7 May 2024 00:46:00 -0700 (PDT)
Received: from [10.57.67.145] (unknown [10.57.67.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96B843F762;
	Tue,  7 May 2024 00:45:32 -0700 (PDT)
Message-ID: <8fdefaa9-675e-4b37-9456-896b9989d18f@arm.com>
Date: Tue, 7 May 2024 08:45:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/openat2: fix clang build failures:
 -static-libasan, LOCAL_HDRS
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Alexey Gladkov <legion@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240504044336.14411-1-jhubbard@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240504044336.14411-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/05/2024 05:43, John Hubbard wrote:
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
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Hi John,

I sent out a similar fix a couple of weeks ago, see [1]. I don't think it got
picked up though. It takes a slightly different approach, explicitly adding
-static-libsan (note no 'a') for clang, instead of relying on its default.

And it just drops helpers.h from the makefile altogether, on the assumption that
it was a mistake; its just a header and shouldn't be compiled directly. I'm not
exactly sure what the benefit of adding it to LOCAL_HDRS is?

[1]
https://lore.kernel.org/linux-kselftest/20240417160740.2019530-1-ryan.roberts@arm.com/

Thanks,
Ryan


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
> 
> base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27


