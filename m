Return-Path: <linux-kselftest+bounces-39687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB6CB31DFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6E4587DD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4381DE4C4;
	Fri, 22 Aug 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="TvcZ+Kjv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EC19CC11
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875416; cv=none; b=KEJOJ8vtMT+rhm/g33pwPooBztsKqDfBdZU4ez4VBijaF17vIPz09WJaGHi1Cp5TY7U0OMlR88jwTwlEt+PtTZR8l+5IQOTFWJIZCqf3E5rE00j0BdEp9k9fWAzsVGhc/QpHXwA+vmdkVpbR6uPLS1rFH7Y82OuRCbyK4V9MyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875416; c=relaxed/simple;
	bh=Hdq5Ry1Oo1i4/2GBD0dGqX7HHIwg6UOJzlHrNI7JCgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+xySuzosXy2qF8JJZ1W/R9tskKH+2JL1pJCox6tKlxz2HIyXpDojoqgKrFVUORw4/UTfApwhiky0O2TCfgdkJfhTaMLDXpxFUk4EGn1qeFm3qAnee7wl0xajGhpcRe51yN8IPb1fxeYjF5K68y/hdXkeESBLBEs+XgugK29wvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=TvcZ+Kjv; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c7jmv6Yzyz997;
	Fri, 22 Aug 2025 16:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1755874271;
	bh=zTTfmyqDupOjx6oqqavArctJ4iCrnJ+ZVQgZlvGbaKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TvcZ+Kjv3uiFSzBmD6CV25iFw47KiUlXV6COeYfUKWUrElaR53ZVWrCnbp9ydTekv
	 6UsvJuVk02SEcKusMSylawRGBOCGBi4Qv9BNyoTgDZPnVA7pj2yrujLWENWoohYZv6
	 yCsGRC0FUxE07oBZSN53cZxCMXLrRrgGZYhsCVak=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4c7jmt2VbwzFpN;
	Fri, 22 Aug 2025 16:51:10 +0200 (CEST)
Date: Fri, 22 Aug 2025 16:51:09 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, gnoack@google.com, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ming.lei@redhat.com, skhan@linuxfoundation.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] selftests: centralise maybe-unused definition in
 kselftest.h
Message-ID: <20250822.Ahno5pong1Ai@digikod.net>
References: <20250821101159.2238-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821101159.2238-1-reddybalavignesh9979@gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Aug 21, 2025 at 03:41:59PM +0530, Bala-Vignesh-Reddy wrote:
> Several selftests subdirectories duplicated the define __maybe_unused,
> leading to redundant code. Moved to kselftest.h header and removed
> other definition.
> 
> This addresses the duplication noted in the proc-pid-vm warning fix
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Link:https://lore.kernel.org/lkml/20250820143954.33d95635e504e94df01930d0@linux-foundation.org/
> 
> Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>

Looks good for Landlock:

Acked-by: Mickaël Salaün <mic@digikod.net>

> ---
>  tools/testing/selftests/kselftest.h                    | 4 ++++
>  tools/testing/selftests/landlock/audit.h               | 6 ++----
>  tools/testing/selftests/landlock/common.h              | 4 ----
>  tools/testing/selftests/mm/pkey-helpers.h              | 3 ---
>  tools/testing/selftests/net/psock_lib.h                | 4 ----
>  tools/testing/selftests/perf_events/watermark_signal.c | 2 --
>  tools/testing/selftests/proc/proc-pid-vm.c             | 4 ----
>  tools/testing/selftests/ublk/utils.h                   | 2 --
>  8 files changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index c3b6d2604b1e..661d31c4b558 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -92,6 +92,10 @@
>  #endif
>  #define __printf(a, b)   __attribute__((format(printf, a, b)))
>  
> +#ifndef __maybe_unused
> +#define __maybe_unused __attribute__((__unused__))
> +#endif
> +
>  /* counters */
>  struct ksft_count {
>  	unsigned int ksft_pass;
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index b16986aa6442..02fd1393947a 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -20,14 +20,12 @@
>  #include <sys/time.h>
>  #include <unistd.h>
>  
> +#include "../kselftest.h"
> +
>  #ifndef ARRAY_SIZE
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>  #endif
>  
> -#ifndef __maybe_unused
> -#define __maybe_unused __attribute__((__unused__))
> -#endif
> -
>  #define REGEX_LANDLOCK_PREFIX "^audit([0-9.:]\\+): domain=\\([0-9a-f]\\+\\)"
>  
>  struct audit_filter {
> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
> index 88a3c78f5d98..9acecae36f51 100644
> --- a/tools/testing/selftests/landlock/common.h
> +++ b/tools/testing/selftests/landlock/common.h
> @@ -22,10 +22,6 @@
>  
>  #define TMP_DIR "tmp"
>  
> -#ifndef __maybe_unused
> -#define __maybe_unused __attribute__((__unused__))
> -#endif
> -

We could explicitly include kselftest.h in this file, but it's already
included by kselftest_harness.h, so that's OK.

>  /* TEST_F_FORK() should not be used for new tests. */
>  #define TEST_F_FORK(fixture_name, test_name) TEST_F(fixture_name, test_name)
>  
> diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
> index ea404f80e6cb..fa15f006fa68 100644
> --- a/tools/testing/selftests/mm/pkey-helpers.h
> +++ b/tools/testing/selftests/mm/pkey-helpers.h
> @@ -84,9 +84,6 @@ extern void abort_hooks(void);
>  #ifndef noinline
>  # define noinline __attribute__((noinline))
>  #endif
> -#ifndef __maybe_unused
> -# define __maybe_unused __attribute__((__unused__))
> -#endif
>  
>  int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
>  int sys_pkey_free(unsigned long pkey);
> diff --git a/tools/testing/selftests/net/psock_lib.h b/tools/testing/selftests/net/psock_lib.h
> index 6e4fef560873..067265b0a554 100644
> --- a/tools/testing/selftests/net/psock_lib.h
> +++ b/tools/testing/selftests/net/psock_lib.h
> @@ -22,10 +22,6 @@
>  
>  #define PORT_BASE			8000
>  
> -#ifndef __maybe_unused
> -# define __maybe_unused		__attribute__ ((__unused__))
> -#endif
> -
>  static __maybe_unused void pair_udp_setfilter(int fd)
>  {
>  	/* the filter below checks for all of the following conditions that
> diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
> index e03fe1b9bba2..b3a72f0ac522 100644
> --- a/tools/testing/selftests/perf_events/watermark_signal.c
> +++ b/tools/testing/selftests/perf_events/watermark_signal.c
> @@ -17,8 +17,6 @@
>  
>  #include "../kselftest_harness.h"
>  
> -#define __maybe_unused __attribute__((__unused__))
> -
>  static int sigio_count;
>  
>  static void handle_sigio(int signum __maybe_unused,
> diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
> index 978cbcb3eb11..2a72d37ad008 100644
> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> @@ -47,10 +47,6 @@
>  #include <sys/resource.h>
>  #include <linux/fs.h>
>  
> -#ifndef __maybe_unused
> -#define __maybe_unused __attribute__((__unused__))
> -#endif
> -
>  #include "../kselftest.h"
>  
>  static inline long sys_execveat(int dirfd, const char *pathname, char **argv, char **envp, int flags)
> diff --git a/tools/testing/selftests/ublk/utils.h b/tools/testing/selftests/ublk/utils.h
> index 36545d1567f1..a852e0b7153e 100644
> --- a/tools/testing/selftests/ublk/utils.h
> +++ b/tools/testing/selftests/ublk/utils.h
> @@ -2,8 +2,6 @@
>  #ifndef KUBLK_UTILS_H
>  #define KUBLK_UTILS_H
>  
> -#define __maybe_unused __attribute__((unused))
> -
>  #ifndef min
>  #define min(a, b) ((a) < (b) ? (a) : (b))
>  #endif
> -- 
> 2.43.0
> 
> 

