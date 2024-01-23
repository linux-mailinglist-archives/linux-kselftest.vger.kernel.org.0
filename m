Return-Path: <linux-kselftest+bounces-3400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0C2838CED
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 12:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDAC1C21C81
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7225D75B;
	Tue, 23 Jan 2024 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JvljyBDE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2365D751
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007967; cv=none; b=d805+ju/4Jcck9wrmHvx0RPOKVc4Jed07uv2Rq0ggkG9YCVtvOIsF09AvdG5iW5Qd6S6/Y7hEpNWk5gUQj42aD7EXEmnZ5ugRgJjks3VLhCbHQFA955wdUPIU3wNQQtTOGK+dbwPIaBTpy3XFnLKve+lfzHhnb+5cVL8bkMR9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007967; c=relaxed/simple;
	bh=7wANGkPvqc+OR36L/josux0TSfXeAjjxrHp0PPQm9Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4AytNG+woPEw9g0NoH5qqoKbOBFhtItkHBSVOUlEKoUS/2Ak98xJqAcWsF50ylkrF3UxvDUffkTgY1FA0YIX8PcdDK1YtSAedXQYZvfF+jChrZvOhfMOKufjAb3XpsTz70lQ19/GMRAW9Rw41Cm5udHQ+NTEMdK3mwqmJLTIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JvljyBDE; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TK45K38bnzMq6j2;
	Tue, 23 Jan 2024 12:05:57 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TK45J5Xd3z3c;
	Tue, 23 Jan 2024 12:05:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1706007957;
	bh=7wANGkPvqc+OR36L/josux0TSfXeAjjxrHp0PPQm9Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvljyBDEANid5jv8ERtVwSxpi1/sSEsRHoeQHYvn6ppPg13FyqlE/KAEnNljLlp33
	 /XJvdjnxXUfeWX96UxAfxgq7H8wjmBCmSiSTXEUseBwcrBTGqZbib3oHfGXv1oS2Ur
	 99i3ya/rLt1p3v0Qqohv3oj030dMsCYQGGjm6tCQ=
Date: Tue, 23 Jan 2024 12:05:53 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, amir73il@gmail.com, brauner@kernel.org, avagin@google.com, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 514118380@qq.com, 
	konstantin.meskhidze@huawei.com
Subject: Re: [PATCH] selftests/landlock:Fix net_test build issues with old
 libc
Message-ID: <20240123.Baiquie9Roh6@digikod.net>
References: <20240123062621.25082-1-hu.yadi@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240123062621.25082-1-hu.yadi@h3c.com>
X-Infomaniak-Routing: alpha

Thanks, I tweaked a bit and merged this patch in my next branch.

On Tue, Jan 23, 2024 at 02:26:21PM +0800, Hu Yadi wrote:
> From: "Hu.Yadi" <hu.yadi@h3c.com>

There is an extra "." here, I fixed it. You don't need to add this From
field if it matches your email's From one.

> 
> Fixes: a549d055a22e ("selftests/landlock: Add network tests")
> 
> one issues comes up while building selftest/landlock/net_test on my side
> (gcc 7.3/glibc-2.28/kernel-4.19)
> 
> net_test.c: In function ‘set_service’:
> net_test.c:91:45: warning: implicit declaration of function ‘gettid’; [-Wimplicit-function-declaration]
>     "_selftests-landlock-net-tid%d-index%d", gettid(),
>                                              ^~~~~~
>                                              getgid
> net_test.c:(.text+0x4e0): undefined reference to `gettid'
> 
> Signed-off-by: Hu Yadi <hu.yadi@h3c.com>
> Suggested-by: Jiao <jiaoxupo@h3c.com>
> Reviewed-by: Berlin <berlin@h3c.com>
> ---
>  tools/testing/selftests/landlock/net_test.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index 929e21c4db05..6cc1bb1a9166 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -18,9 +18,15 @@
>  #include <sys/prctl.h>
>  #include <sys/socket.h>
>  #include <sys/un.h>
> -
> +#include <sys/syscall.h>
>  #include "common.h"
> 
> +
> +static pid_t sys_gettid(void)
> +{
> +	return syscall(__NR_gettid);
> +}
> +
>  const short sock_port_start = (1 << 10);
> 
>  static const char loopback_ipv4[] = "127.0.0.1";
> @@ -88,7 +94,7 @@ static int set_service(struct service_fixture *const srv,
>  	case AF_UNIX:
>  		srv->unix_addr.sun_family = prot.domain;
>  		sprintf(srv->unix_addr.sun_path,
> -			"_selftests-landlock-net-tid%d-index%d", gettid(),
> +			"_selftests-landlock-net-tid%d-index%d", sys_gettid(),
>  			index);
>  		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
>  		srv->unix_addr.sun_path[0] = '\0';
> --
> 2.23.0
> 
> 

