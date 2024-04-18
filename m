Return-Path: <linux-kselftest+bounces-8328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B88A9A6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 14:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC25D282D2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1912880F;
	Thu, 18 Apr 2024 12:53:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF681EA8F;
	Thu, 18 Apr 2024 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444781; cv=none; b=QtYwkf0Ve5JoW9bDwJZf56UlBdgazkVSksmf64gL6FRu+ZTK+kVEFjV1SM59eIBY2zwbPtBSKvB+EGhNWngrtrEhV58B1BzrA+ZnHP1B144fiLBdliTQrn9OLM0lSYKIpWcPZeTIazhAB4XBIVlJHsCaZ8JGHhFx6FrOmUIBO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444781; c=relaxed/simple;
	bh=chR6ij2HPD0n94HeheQrXEw9wvJW6PqsAZOmneyaWdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwHKPtggErIQ8cwCGDlH265axapOTveBY5ZUR3774BySH82+RROZn0Y8AOpY9Hd4LJYmlVa4VTWOnXAA33qiJvMCFyFpB+x3od0HHkVpjyRqvooco/P3ZE6LpyedisQUDyhWP8KLyfpYYQ5LCFWZJDowRezU78lkAvxa8Cpo8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F6E0339;
	Thu, 18 Apr 2024 05:53:26 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73FFF3F738;
	Thu, 18 Apr 2024 05:52:57 -0700 (PDT)
Date: Thu, 18 Apr 2024 13:52:50 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: mm: restore settings from only parent process
Message-ID: <20240418125250.GA2941398@e124191.cambridge.arm.com>
References: <20240314094045.157149-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314094045.157149-1-usama.anjum@collabora.com>

Hi again,

On Thu, Mar 14, 2024 at 02:40:45PM +0500, Muhammad Usama Anjum wrote:
> The atexit() is called from parent process as well as forked processes.
> Hence the child restores the settings at exit while the parent is still
> executing. Fix this by checking pid of atexit() calling process and only
> restore THP number from parent process.
> 
> Fixes: c23ea61726d5 ("selftests/mm: protection_keys: save/restore nr_hugepages settings")
> Tested-by: Joey Gouly <joey.gouly@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/protection_keys.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
> index f822ae31af22e..374a308174d2b 100644
> --- a/tools/testing/selftests/mm/protection_keys.c
> +++ b/tools/testing/selftests/mm/protection_keys.c
> @@ -1745,9 +1745,12 @@ void pkey_setup_shadow(void)
>  	shadow_pkey_reg = __read_pkey_reg();
>  }
>  
> +pid_t parent_pid;
> +
>  void restore_settings_atexit(void)
>  {
> -	cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
> +	if (parent_pid == getpid())
> +		cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
>  }
>  
>  void save_settings(void)
> @@ -1773,6 +1776,7 @@ void save_settings(void)
>  		exit(__LINE__);
>  	}
>  
> +	parent_pid = getpid();
>  	atexit(restore_settings_atexit);
>  	close(fd);
>  }

After more testing, this is not actually enough. It passes sometimes, which is
why I gave my Tested-by, but it can still fail the same way as I originally
said.

assert() at protection_keys.c::812 test_nr: 19 iteration: 1
running abort_hooks()...
errno at assert: 12

I think the parent process needs to wait for all it's child processes (recursively).
This is due to the test_pkey_alloc_exhaust() calling become_child(), where it
exits, and that exit may be from the original PID.

Thanks,
Joey

