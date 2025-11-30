Return-Path: <linux-kselftest+bounces-46750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76997C94EAB
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 11:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71A854E1AC9
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C1272E6E;
	Sun, 30 Nov 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="O8/38oOt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED0927055D;
	Sun, 30 Nov 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764500327; cv=none; b=VQ1jjrYwz3g0XS9onJMCeUiZyPi9AN5D5jWfQM5qkYsgYyt2D5wLlWweJUW0Hg1o7iVs8bzCHdSesMEptnsFPXIjVrTHwOF/rc5BqtWXyCD2G0Gl65zY2aLVpSIAe2IBHAfkkeB1OYRZ5rtgSQFMy5wMdetj9HZVNkjEGe80JcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764500327; c=relaxed/simple;
	bh=piifx6gXhNIz4sFzfgw3JFkXgqT/wKj5eH7wKXoE1hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mer4nUzngSJRytBVmZ64IrA0x5hmwbZVaIIzXN4RATchwFZK/wB7c5rYKt6XMk6n0MjjcbYM7Zs+X50gCqiVFsFrbvwICRrpjt3paMGW6jsTUzdSHp9ThaQ9NmOE7Gj4KphYO3inmr/IK+hf1ZY2hRErAv8lW4VdoNIKKUqUbDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=O8/38oOt; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1764500322; bh=O/MX2VfGDaLyEW8CkuZktfYTDS9k+pzIGvxkndbk5ik=;
	h=From:Message-ID:From;
	b=O8/38oOti9D5ovNgNC/VOFoJpuatgXW7WJGGF9ii2KBgSV6lv75VZZxiKCAJCP/ZL
	 qSnjl1oVzsNCZ4rtf/dYOwUgXREm7HTlBUKcfKcrQq10qncR5PzjA5RKoSln+85BOQ
	 EGob9iID95IXt5Y1gdpYzpxUfb4o4nxF/YPclxnA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 8402DC04AB;
	Sun, 30 Nov 2025 11:58:42 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5AUAwg7X000498;
	Sun, 30 Nov 2025 11:58:42 +0100
Date: Sun, 30 Nov 2025 11:58:42 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 09/13] tools/nolibc: always use 64-bit time types
Message-ID: <20251130105842.GD31522@1wt.eu>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
 <20251122-nolibc-uapi-types-v2-9-b814a43654f5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122-nolibc-uapi-types-v2-9-b814a43654f5@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Sat, Nov 22, 2025 at 05:59:15PM +0100, Thomas Weiﬂschuh wrote:
> 32-bit time types will stop working in 2038.
> 
> Switch to 64-bit time types everywhere.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/cec27d94-c99d-4c57-9a12-275ea663dda8@app.fastmail.com/
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/std.h   | 2 +-
>  tools/include/nolibc/types.h | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
> index 392f4dd94158..b9a116123902 100644
> --- a/tools/include/nolibc/std.h
> +++ b/tools/include/nolibc/std.h
> @@ -29,6 +29,6 @@ typedef unsigned long       nlink_t;
>  typedef  int64_t              off_t;
>  typedef   signed long     blksize_t;
>  typedef   signed long      blkcnt_t;
> -typedef __kernel_time_t      time_t;
> +typedef __kernel_time64_t    time_t;
>  
>  #endif /* _NOLIBC_STD_H */
> diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
> index 5d180ffabcb6..8f3cb18df7f1 100644
> --- a/tools/include/nolibc/types.h
> +++ b/tools/include/nolibc/types.h
> @@ -17,14 +17,15 @@
>  #include <linux/wait.h>
>  
>  struct timespec {
> -	__kernel_old_time_t	tv_sec;
> -	long			tv_nsec;
> +	time_t	tv_sec;
> +	int64_t	tv_nsec;
>  };
>  #define _STRUCT_TIMESPEC
>  
> +/* Never use with system calls */
>  struct timeval {
> -	__kernel_old_time_t	tv_sec;
> -	__kernel_suseconds_t	tv_usec;
> +	time_t	tv_sec;
> +	int64_t	tv_usec;
>  };

It seems to me that glibc continues to make the effort of using a long
for tv_usec and tv_nsec. At least I'm seeing how that can make a
difference for application code given that these fields are constantly
multiplied or divided, forcing them to 64-bit when we know they'll never
be larger than 1 billion is extra burden for the application. Another
reason might be that the definition really changed from long to suseconds_t
in timeval a while ago, it's possible that it's used as a long in various
APIs (or even just printf formats).

IMHO it would be cleaner to keep it as a long here, or do you have a
particular reason for wanting int64_t (which BTW already forced a cast
in sys_gettimeofday()) ?

Thanks,
Willy

