Return-Path: <linux-kselftest+bounces-2806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC38829F98
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 18:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09651C21B17
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC704D128;
	Wed, 10 Jan 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kBYpqGxV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B94D120
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T9FZf4l5gzMq2gW;
	Wed, 10 Jan 2024 17:45:46 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4T9FZd3ZfbzMpnPd;
	Wed, 10 Jan 2024 18:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1704908746;
	bh=G5UFwkuB9at7CXYuZiEPj276AzMRMHTS9mqXhp2SDFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBYpqGxVebuHel4FHnvPsz28PrmlgCi3JxwQpNy2iHj3KRecmruXXAw9DOGC790q3
	 bdTOUJSkAnnEQOt4iTnsKujEzPVKIQqFB3BFyFtSnFyxVyDhxBSajY9ipCjmvu/XAV
	 H32C7s/tbZ70huz87vT/mqmE3yshpVzy5zrgCdEI=
Date: Wed, 10 Jan 2024 18:45:43 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 514118380@qq.com, 
	berlin@h3c.com
Subject: Re: [PATCH] selftests/landlock:Fix two build issues
Message-ID: <20240110.ob2roh1Xai9y@digikod.net>
References: <20240110070854.7077-1-hu.yadi@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110070854.7077-1-hu.yadi@h3c.com>
X-Infomaniak-Routing: alpha

On Wed, Jan 10, 2024 at 03:08:54PM +0800, Hu Yadi wrote:
> From: "Hu.Yadi" <hu.yadi@h3c.com>
> 
> Two issues comes up  while building selftest/landlock:
> 
> the first one is as to gettid
> 
> net_test.c: In function ‘set_service’:
> net_test.c:91:45: warning: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Wimplicit-function-declaration]
>     "_selftests-landlock-net-tid%d-index%d", gettid(),
>                                              ^~~~~~
>                                              getgid
> net_test.c:(.text+0x4e0): undefined reference to `gettid'
> 
> the second is compiler error
> gcc -Wall -O2 -isystem   fs_test.c -lcap -o /home/linux/tools/testing/selftests/landlock/fs_test
> fs_test.c:4575:9: error: initializer element is not constant
>   .mnt = mnt_tmp,
>          ^~~~~~~

What is the version of GCC (and headers) and on which system (and
version) are you building these tests?

> 
> this patch is to fix them
> 
> Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
> Suggested-by: Jiao <jiaoxupo@h3c.com>
> Reviewed-by:Berlin <berlin@h3c.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c  | 5 ++++-
>  tools/testing/selftests/landlock/net_test.c | 3 +--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 18e1f86a6234..93eb40a09073 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4572,7 +4572,10 @@ FIXTURE_VARIANT(layout3_fs)
>  /* clang-format off */
>  FIXTURE_VARIANT_ADD(layout3_fs, tmpfs) {
>  	/* clang-format on */
> -	.mnt = mnt_tmp,
> +	.mnt = {
> +		.type = "tmpfs",
> +        	.data = "size=4m,mode=700",

When applying this patch we get: "space before tab in indent"

> +	},
>  	.file_path = file1_s1d1,
>  };
>  
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index 929e21c4db05..8fb357de8c55 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -18,7 +18,6 @@
>  #include <sys/prctl.h>
>  #include <sys/socket.h>
>  #include <sys/un.h>
> -
>  #include "common.h"
>  
>  const short sock_port_start = (1 << 10);
> @@ -88,7 +87,7 @@ static int set_service(struct service_fixture *const srv,
>  	case AF_UNIX:
>  		srv->unix_addr.sun_family = prot.domain;
>  		sprintf(srv->unix_addr.sun_path,
> -			"_selftests-landlock-net-tid%d-index%d", gettid(),
> +			"_selftests-landlock-net-tid%ld-index%d", syscall(SYS_gettid),

You sent another patch that "replace SYS_<syscall> with __NR_<syscall>".
Why not here?

Please follow the same approach:
https://git.kernel.org/stable/c/87129ef13603ae46c82bcd09eed948acf0506dbb

>  			index);
>  		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
>  		srv->unix_addr.sun_path[0] = '\0';
> -- 
> 2.23.0
> 
> 

