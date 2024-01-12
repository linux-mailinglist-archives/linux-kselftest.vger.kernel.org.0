Return-Path: <linux-kselftest+bounces-2913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FC682BEB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 11:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125B11C24686
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71558234;
	Fri, 12 Jan 2024 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="B5Q4g6J+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6AA58225;
	Fri, 12 Jan 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TBJ9H14c2zMrVlh;
	Fri, 12 Jan 2024 10:45:55 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TBJ9F6wTHzMpnPg;
	Fri, 12 Jan 2024 11:45:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1705056355;
	bh=0Xtl3exMkr4Vgw7Wdk8vaxK8FVOPw6r5Xm7224/uacI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5Q4g6J+O2tyneb1iQmU5aC28ekvXJiODUBdbxXp+reDFQO06bkLNdDqy1wvR8lKA
	 1rp03Ctp7sl++jxkF95VZibIwOecuro7KatD9sJFp3vjMqfmAJKLNu5sfw2rZ9T7im
	 gdFDZizKF9Xmyeah3V0Utlwp7/5nodNRDU0gk5bI=
Date: Fri, 12 Jan 2024 11:45:52 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 514118380@qq.com, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v3] selftests/landlock:Fix two build issues
Message-ID: <20240112.mixei4sei0Pi@digikod.net>
References: <20240112071245.669-1-hu.yadi@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112071245.669-1-hu.yadi@h3c.com>
X-Infomaniak-Routing: alpha

On Fri, Jan 12, 2024 at 03:12:45PM +0800, Hu Yadi wrote:
> From: "Hu.Yadi" <hu.yadi@h3c.com>
> 
> Two issues comes up while building selftest/landlock on my side
> (gcc 7.3/glibc-2.28/kernel-4.19)
> 
> the first one is as to gettid
> 
> net_test.c: In function ‘set_service’:
> net_test.c:91:45: warning: implicit declaration of function ‘gettid’; [-Wimplicit-function-declaration]
>     "_selftests-landlock-net-tid%d-index%d", gettid(),
>                                              ^~~~~~
>                                              getgid
> net_test.c:(.text+0x4e0): undefined reference to `gettid'
> 
> the second is compiler error
> gcc -Wall -O2 -isystem   fs_test.c -lcap -o selftests/landlock/fs_test
> fs_test.c:4575:9: error: initializer element is not constant
>   .mnt = mnt_tmp,
>          ^~~~~~~
> 
> this patch is to fix them
> 
> Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
> Suggested-by: Jiao <jiaoxupo@h3c.com>
> Reviewed-by: Berlin <berlin@h3c.com>
> ---
> Changes v3 -> v2:
>  - add helper of gettid instead of __NR_gettid
>  - add gcc/glibc version info in comments
> Changes v1 -> v2:
>  - fix whitespace error
>  - replace SYS_gettid with _NR_gettid
> 
>  tools/testing/selftests/landlock/fs_test.c  | 5 ++++-
>  tools/testing/selftests/landlock/net_test.c | 9 +++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 18e1f86a6234..a992cf7c0ad1 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4572,7 +4572,10 @@ FIXTURE_VARIANT(layout3_fs)
>  /* clang-format off */
>  FIXTURE_VARIANT_ADD(layout3_fs, tmpfs) {
>  	/* clang-format on */
> -	.mnt = mnt_tmp,
> +	.mnt = {
> +		.type = "tmpfs",
> +		.data = "size=4m,mode=700",

OK, C doesn't play nice with constants. A better approach would be to
define MNT_TMP_DATA, and use it with this fixture variant and the
mnt_tmp variable.  No need for a MNT_TMP_TYPE though.  While you're at
it, you can also make the mnt_tmp variable static const.

You can create two patches from this one. This first hunk with:

Fixes: 04f9070e99a4 ("selftests/landlock: Add tests for pseudo filesystems")

> +	},
>  	.file_path = file1_s1d1,
>  };
>  
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index 929e21c4db05..12a6744568e2 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -21,6 +21,15 @@
>  
>  #include "common.h"

...and this second hunk for another patch with:

Fixes: a549d055a22e ("selftests/landlock: Add network tests")
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>

>  
> +#ifndef gettid
> +static pid_t gettid(void)
> +{
> +        return syscall(__NR_gettid);
> +}
> +

Please remove this newline.

> +#endif

You can move this gettid hunk to common.h, under the
landlock_restrict_self block.

> +
> +
>  const short sock_port_start = (1 << 10);
>  
>  static const char loopback_ipv4[] = "127.0.0.1";
> -- 
> 2.23.0
> 

