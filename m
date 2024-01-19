Return-Path: <linux-kselftest+bounces-3239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37928329B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 13:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A4DB22CCD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12764EB5B;
	Fri, 19 Jan 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gtndS8/Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88B524A2
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668625; cv=none; b=WI0U59gkPsxEpkVmpV4TilPfnpy9EiTErpzcMwhRCzf6xLOx1U2gUZupEFHyZBzGElxm4iZiV+ImAsUtOfWyYt0nr4XavenXSEXS47C5FHjlsl/xo6Feq+ntav8nzmIZ74+4ZIK6XX2T4Ob4mpLPcEKXFrUS7jbGM1HjVO3dz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668625; c=relaxed/simple;
	bh=/rHoGZTfUaI2731SCJ/Ui1obvUcWjbrYkcngo32s3NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRLbBDVqC/T5KXEUD9j1RGDhJjxD4EYacFFrLKKHfw+NM/1tMyrOjgNP1utQ+weypcpSayaURHGfZduxF5OhBKPx8Eys3Rr/NH0tB1Zkw5YUvRDp5xcUvIFlkISyn5WgEL6p5ZbrnhYktlQpX8AYT5EJ2hS4E6sQW/8OGp+PIRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gtndS8/Y; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TGfBW0CY9zMqsrp;
	Fri, 19 Jan 2024 13:32:03 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TGfBT3VQ1z3Y;
	Fri, 19 Jan 2024 13:32:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1705667522;
	bh=/rHoGZTfUaI2731SCJ/Ui1obvUcWjbrYkcngo32s3NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtndS8/YTII1IUBg6cxIKRVTqllpPrXuv0rGGy+ahVXJ838yhn0MQoFWwMWAOp352
	 jEpY9qgt/HNKEga06/it/vVXGcuGVm3dtgRLYXAqRXKDuh/4uXdRZdHnagnHv2r/sH
	 82UnU9NsMyFZT3lQQByOlyR2onA46Nqw3JDEd0rw=
Date: Fri, 19 Jan 2024 13:31:58 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, amir73il@gmail.com, brauner@kernel.org, avagin@google.com, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 514118380@qq.com, 
	konstantin.meskhidze@huawei.com
Subject: Re: [PATCH v4] selftests/landlock:Fix two build issues
Message-ID: <20240119.Ugaehae2ze5b@digikod.net>
References: <20240115102409.19799-1-hu.yadi@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115102409.19799-1-hu.yadi@h3c.com>
X-Infomaniak-Routing: alpha

On Mon, Jan 15, 2024 at 06:24:09PM +0800, Hu Yadi wrote:
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
> Fixes: 04f9070e99a4 ("selftests/landlock: Add tests for pseudo filesystems")
> Fixes: a549d055a22e ("selftests/landlock: Add network tests")

Could you please create two patches as requested for v3, one per fix?
This is useful because it enables to backport these fixes when
appropriate.

> 
> this patch is to fix them
> 
> Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
> Suggested-by: Jiao <jiaoxupo@h3c.com>
> Reviewed-by: Berlin <berlin@h3c.com>
> ---
> Changes v4 -> v3:
>   fix gettid error from kernel test robot
>   https://lore.kernel.org/oe-kbuild-all/202401151147.T1s11iHJ-lkp@intel.com/
> Changes v3 -> v2:
>  - add helper of gettid instead of __NR_gettid
>  - add gcc/glibc version info in comments
> Changes v1 -> v2:
>  - fix whitespace error
>  - replace SYS_gettid with _NR_gettid
> 
>  tools/testing/selftests/landlock/fs_test.c  | 5 ++++-
>  tools/testing/selftests/landlock/net_test.c | 7 ++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
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
> +	},

I requested some changes here.

>  	.file_path = file1_s1d1,
>  };
> 
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index 929e21c4db05..d50f2920ed82 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -21,6 +21,11 @@

We should include sys/syscall.h

> 
>  #include "common.h"
> 
> +static pid_t landlock_gettid(void)

Please rename to sys_gettid().

> +{
> +        return syscall(__NR_gettid);
> +}
> +
>  const short sock_port_start = (1 << 10);
> 
>  static const char loopback_ipv4[] = "127.0.0.1";
> @@ -88,7 +93,7 @@ static int set_service(struct service_fixture *const srv,
>  	case AF_UNIX:
>  		srv->unix_addr.sun_family = prot.domain;
>  		sprintf(srv->unix_addr.sun_path,
> -			"_selftests-landlock-net-tid%d-index%d", gettid(),
> +			"_selftests-landlock-net-tid%d-index%d", landlock_gettid(),
>  			index);
>  		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
>  		srv->unix_addr.sun_path[0] = '\0';
> --
> 2.23.0
> 

