Return-Path: <linux-kselftest+bounces-2858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21AF82B047
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 15:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499DFB23357
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 14:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192E23B782;
	Thu, 11 Jan 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1kIR6WKm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A68E3B19C
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T9mfW3Q2jzMrF30;
	Thu, 11 Jan 2024 14:05:55 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4T9mfV6yPSzMppBF;
	Thu, 11 Jan 2024 15:05:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1704981955;
	bh=aI1+49gT1ZojrVUKrGP+osTMmA2ZTIqr1RprKbXCN+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1kIR6WKm8uQMHswlhMP2gSeP//iC+OYFm+Thxm4kVJ3s8CqFvXp7wc7Hio9u3ONlJ
	 efuLO72RQB/RIELTZX5fivqOJRiCiOburHK1q3wLJY14iOkgVCnOdE1wrr8cCSuT7r
	 jOaLcO+lhyCQVJQxkXIWSX7Dgd8ukt7OCBauaDkk=
Date: Thu, 11 Jan 2024 15:05:53 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Huyadi <hu.yadi@h3c.com>
Cc: "jmorris@namei.org" <jmorris@namei.org>, 
	"serge@hallyn.com" <serge@hallyn.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "514118380@qq.com" <514118380@qq.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH]
 selftests/landlock:Fix two build issues
Message-ID: <20240111.Ooraegolah6n@digikod.net>
References: <20240110070854.7077-1-hu.yadi@h3c.com>
 <20240110.ob2roh1Xai9y@digikod.net>
 <9820400d6083428bbab2dfe5d5682d19@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9820400d6083428bbab2dfe5d5682d19@h3c.com>
X-Infomaniak-Routing: alpha

On Thu, Jan 11, 2024 at 02:34:08AM +0000, Huyadi wrote:
> 
> ->On Wed, Jan 10, 2024 at 03:08:54PM +0800, Hu Yadi wrote:
> >> From: "Hu.Yadi" <hu.yadi@h3c.com>
> >> 
> >> Two issues comes up  while building selftest/landlock:
> >> 
> >> the first one is as to gettid
> >> 
> >> net_test.c: In function ‘set_service’:
> >> net_test.c:91:45: warning: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Wimplicit-function-declaration]
> >>     "_selftests-landlock-net-tid%d-index%d", gettid(),
> >>                                              ^~~~~~
> >>                                              getgid
> >> net_test.c:(.text+0x4e0): undefined reference to `gettid'
> >> 
> >> the second is compiler error
> >> gcc -Wall -O2 -isystem   fs_test.c -lcap -o /home/linux/tools/testing/selftests/landlock/fs_test
> >> fs_test.c:4575:9: error: initializer element is not constant
> >>   .mnt = mnt_tmp,
> >>          ^~~~~~~
> >
> >What is the version of GCC (and headers) and on which system (and
> >version) are you building these tests?
> 
> gcc 7.3 / glibc-2.28/ kernel 4.19/ OpenEulor20.03

These are old versions. You should mention in the commit message which
version of glibc added gettid().

> 
> >> 
> >> this patch is to fix them
> >> 
> >> Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
> >> Suggested-by: Jiao <jiaoxupo@h3c.com>
> >> Reviewed-by:Berlin <berlin@h3c.com>
> >> ---
> >>  tools/testing/selftests/landlock/fs_test.c  | 5 ++++-  
> >> tools/testing/selftests/landlock/net_test.c | 3 +--
> >>  2 files changed, 5 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/tools/testing/selftests/landlock/fs_test.c 
> >> b/tools/testing/selftests/landlock/fs_test.c
> >> index 18e1f86a6234..93eb40a09073 100644
> >> --- a/tools/testing/selftests/landlock/fs_test.c
> >> +++ b/tools/testing/selftests/landlock/fs_test.c
> >> @@ -4572,7 +4572,10 @@ FIXTURE_VARIANT(layout3_fs)
> >>  /* clang-format off */
> >>  FIXTURE_VARIANT_ADD(layout3_fs, tmpfs) {
> >>  	/* clang-format on */
> >> -	.mnt = mnt_tmp,

Can you just cast mnt_tmp? It exists to avoid such duplicate code.

> >> +	.mnt = {
> >> +		.type = "tmpfs",
> >> +        	.data = "size=4m,mode=700",
> >
> >When applying this patch we get: "space before tab in indent"
> 
> Sorry for inconvenient, I'll resend it v2 after checkpatch.pl shows no error.
> 
> >> +	},
> >>  	.file_path = file1_s1d1,
> >>  };
> >>  
> >> diff --git a/tools/testing/selftests/landlock/net_test.c 
> >> b/tools/testing/selftests/landlock/net_test.c
> >> index 929e21c4db05..8fb357de8c55 100644
> >> --- a/tools/testing/selftests/landlock/net_test.c
> >> +++ b/tools/testing/selftests/landlock/net_test.c
> >> @@ -18,7 +18,6 @@
> >>  #include <sys/prctl.h>
> >>  #include <sys/socket.h>
> >>  #include <sys/un.h>
> >> -
> >>  #include "common.h"
> >>  
> >>  const short sock_port_start = (1 << 10); @@ -88,7 +87,7 @@ static int 
> >> set_service(struct service_fixture *const srv,
> >>  	case AF_UNIX:
> >>  		srv->unix_addr.sun_family = prot.domain;
> >>  		sprintf(srv->unix_addr.sun_path,
> >> -			"_selftests-landlock-net-tid%d-index%d", gettid(),
> >> +			"_selftests-landlock-net-tid%ld-index%d", syscall(SYS_gettid),
> >
> >You sent another patch that "replace SYS_<syscall> with __NR_<syscall>".
> >Why not here?
> >
> >Please follow the same approach:
> >https://git.kernel.org/stable/c/87129ef13603ae46c82bcd09eed948acf0506dbb

Can you please add a getpid() helper like for renameat2() in this
commit?

Also, all Landlock-related code is formatted with clang-format. You can
do it with clang-format -i tools/testing/selftests/landlock/*.[ch]

> 
> Got it, I'll resend it v2 including the fix 
> 
> >>  			index);
> >>  		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
> >>  		srv->unix_addr.sun_path[0] = '\0';
> >> --
> >> 2.23.0
> >> 
> >> 
> 
>  

