Return-Path: <linux-kselftest+bounces-10012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08908C2403
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A798D1F22F44
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C2A16D9A1;
	Fri, 10 May 2024 11:52:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C05A16F0C6;
	Fri, 10 May 2024 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341949; cv=none; b=OvE6e6+UB5Av39hsZm1IzPe6ep6849FJYIcEh9IJg/kO3IGOW+eew3BHkZ5BS/S6LbxeYqUI0CV/kdUc8eSv9mz0KooF1vFD6lUUJeR2FXVqSnYH/DZFxSCYhXJoMNzpitHlHgv4HMFE0PICR3SvEP7+OoNSUdnDnXcusx3nFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341949; c=relaxed/simple;
	bh=4L0SL06v1cpIz5eQUAyvbTAjNvRgK+vbaYhy/1joG/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YULHi4TNITrUwPWUN8OSDtdYmi51atHQMjrl9m5QMFT7BF1QWlNI4pggFquH61HcSgJ3I7Y3Gq/+gLOLOT9msLRwI8fxSqEP+TJ4tTaDWz9rMAiUGYSo8lGJHMjy4z3LMBCjw14rZoHnYpz8Qn0bQqlVJSA6PvkoaRrRjbKHriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE4F6106F;
	Fri, 10 May 2024 04:52:46 -0700 (PDT)
Received: from [10.57.65.1] (unknown [10.57.65.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92B2F3F6A8;
	Fri, 10 May 2024 04:52:19 -0700 (PDT)
Message-ID: <c406383d-e08a-4a12-9e25-1c987b0d678f@arm.com>
Date: Fri, 10 May 2024 12:52:18 +0100
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

It just occured to me that the bug report I was fixing with my attempt was
invoking make like this (see [1]):

# tools/testing/selftests/fchmodat2$ make CC=clang
# tools/testing/selftests/openat2$ make CC=clang

So LLVM is not set in this case. Perhaps my approach [2] (suggested by Arnd) of
using cc-option is more robust? (cc-option is alredy used by other selftests).


[1] https://lore.kernel.org/all/202404141807.LgsqXPY5-lkp@intel.com/
[2]
https://lore.kernel.org/linux-kselftest/20240417160740.2019530-1-ryan.roberts@arm.com/


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


