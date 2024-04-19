Return-Path: <linux-kselftest+bounces-8469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D048AB395
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61FC1F22E55
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09571369BA;
	Fri, 19 Apr 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BABU4UIT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A5136678
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545240; cv=none; b=IZf+HgV/I2wElaW28VYYK++GSJRl1uc4wfsmcm/K7OfsZd1gGhjwTpG+6iqWejdVwEGBTjTxDOj/k5MIg/bDxUT+vTm/wGHRVptSjqNAfvg/7yTcwUlIAQm8OFpvGLlcXLgGIHFv0kOrSaaG2hWMg1HVlDsUtMNbuPst+R3FTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545240; c=relaxed/simple;
	bh=/cWriL0gpomcNV4/dkArYyL2fH82NBZljvxafQI6YEw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XxsgDIzFYdY8eVEjgHxQG2T/ZLarQVJZxo9cTd4pokFxbRU1ixQnnUfyNqd8405HKyyqEq7KsS3LefBU2OHD8sBe9g5qmRuXIzg6bBS/RRIi+Ru37tiYJMdd9af+JnF/CEtF6zPnKgSFDe8oWKpRiEmRXdXJiXJuK2mZdoNwndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BABU4UIT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713545237;
	bh=/cWriL0gpomcNV4/dkArYyL2fH82NBZljvxafQI6YEw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BABU4UITtYORljBaZHuAEXOvOyUUWjNWYCNOfkEO2wrw5VIWeEyd7fiiOG67YNej8
	 TnoV0TKEcEnWoqf+TgRnZfbjtLyl+RnAGYQ72ko9BcpWUWuruqlfvh/ShrsHhfQ5oc
	 gqpUp6AzfLUw89Xx/nquyarXQbngnUeZoaqH1A8IjoBfnfFYfqyJfyaQPL35vVJiN+
	 DXT9AYbB2Y0PbXV4zkU39/97g7Vb8bmnHWJ9gXkp63A2U44DdUxKs59h1C7OQLtNyd
	 7IeExC6QvZOZpkhcDK0vbnk0qGfYYUec+UiE5KMJc1CfQKjlbc/R+KqiOjBNe99Nwp
	 jzxeHkELyAdtQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 17FB73782153;
	Fri, 19 Apr 2024 16:47:11 +0000 (UTC)
Message-ID: <536650e2-62f4-40a7-8667-6e303e3a9828@collabora.com>
Date: Fri, 19 Apr 2024 21:47:26 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 kernel test robot <yujie.liu@intel.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] selftests: Fix asan linkage to work with clang
To: Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20240417160740.2019530-1-ryan.roberts@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240417160740.2019530-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the fix.

On 4/17/24 9:07 PM, Ryan Roberts wrote:
> Both fchmodat2 and openat2 statically link against libasan (for
> explanation of why, look at the fixes commit). This is done using
> `-static-libasan`. However, it turns out that clang uses a different
> option, `-static-libsan`. This caused clang to fail to compile the
> tests.
> 
> Fix this by using cc-option to figure out which variant to use.
> 
> While we are at it, stop passing helpers.h as a compilation unit. This
> was causing another clang error due to name conflict with helpers.c's
> object file. This header shouldn't be directly compiled anyway.
> 
> Fixes: c652df8a4a9d ("selftests: link libasan statically for tests with -fsanitize=address")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/r/202404141807.LgsqXPY5-lkp@intel.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> 
> Applies on v6.9-rc4.
> 
> Thanks,
> Ryan
> 
>  tools/testing/selftests/fchmodat2/Makefile | 5 ++++-
>  tools/testing/selftests/openat2/Makefile   | 7 +++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
> index 71ec34bf1501..a68bb5a00797 100644
> --- a/tools/testing/selftests/fchmodat2/Makefile
> +++ b/tools/testing/selftests/fchmodat2/Makefile
> @@ -1,6 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +# We need this for the "cc-option" macro.
> +include ../../../build/Build.include
> 
> -CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan $(KHDR_INCLUDES)
> +CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
> +CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, -static-libsan)
>  TEST_GEN_PROGS := fchmodat2_test
> 
>  include ../lib.mk
> diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
> index 254d676a2689..02af9b6ca5eb 100644
> --- a/tools/testing/selftests/openat2/Makefile
> +++ b/tools/testing/selftests/openat2/Makefile
> @@ -1,8 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +# We need this for the "cc-option" macro.
> +include ../../../build/Build.include
> 
> -CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan
> +CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
> +CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, -static-libsan)
>  TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
> 
>  include ../lib.mk
> 
> -$(TEST_GEN_PROGS): helpers.c helpers.h
> +$(TEST_GEN_PROGS): helpers.c
> --
> 2.25.1
> 
> 

-- 
BR,
Muhammad Usama Anjum

