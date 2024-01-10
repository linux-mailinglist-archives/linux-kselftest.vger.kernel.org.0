Return-Path: <linux-kselftest+bounces-2807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52228829FBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 18:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2061B26F31
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0606A4D100;
	Wed, 10 Jan 2024 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uvW7lai1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CFA4CE1B
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T9FZx5gjZzMq8qY;
	Wed, 10 Jan 2024 17:46:01 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4T9FZx1ybDzMpp9p;
	Wed, 10 Jan 2024 18:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1704908761;
	bh=fJI3lJ2trbNpt/lcevdQJPfwM2WNzCMZ8/35WyMDJ40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvW7lai1GHZRi2Ov4YWFTFkw9oDpg+qfJyiGyobyAfsGGs/pr0EYY1+OCokZhwrhF
	 lj+wwmzVVN5Y3r6gwwWs2bUarbQAu+Wtj23o4s4HErVP9T+3V4W/A1VJJBXmQ03vwM
	 RNoTALmfK868PzUl/NxLJNAhn0TbG94cBwG86cSo=
Date: Wed, 10 Jan 2024 18:45:59 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 514118380@qq.com, 
	berlin@h3c.com
Subject: Re: [PATCH v2] selftests/move_mount_set_group:Make tests build with
 old libc
Message-ID: <20240110.Yap9Aw9aeghu@digikod.net>
References: <20240110072901.5873-1-hu.yadi@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240110072901.5873-1-hu.yadi@h3c.com>
X-Infomaniak-Routing: alpha

On Wed, Jan 10, 2024 at 03:29:01PM +0800, Hu Yadi wrote:
> From: "Hu.Yadi" <hu.yadi@h3c.com>
> 
> Replace SYS_<syscall> with __NR_<syscall>.  Using the __NR_<syscall>
> notation, provided by UAPI, is useful to build tests on systems without
> the SYS_<syscall> definitions.

This looks a lot like that...
https://git.kernel.org/stable/c/87129ef13603ae46c82bcd09eed948acf0506dbb

> 
> Replace SYS_move_mount with __NR_move_mount
> 
> Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
> Suggested-by:Jiao <jiaoxupo@h3c.com>
> Reviewed-by:Berlin <berlin@h3c.com>
> ---
> Changes v1 -> v2:
>  - Fix mail of Suggested-by and Reviewed-by
> 
>  .../move_mount_set_group/move_mount_set_group_test.c          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> index 50ed5d475dd1..bcf51d785a37 100644
> --- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> +++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> @@ -218,7 +218,7 @@ static bool move_mount_set_group_supported(void)
>  	if (mount(NULL, SET_GROUP_FROM, NULL, MS_SHARED, 0))
>  		return -1;
>  
> -	ret = syscall(SYS_move_mount, AT_FDCWD, SET_GROUP_FROM,
> +	ret = syscall(__NR_move_mount, AT_FDCWD, SET_GROUP_FROM,
>  		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
>  	umount2("/tmp", MNT_DETACH);
>  
> @@ -363,7 +363,7 @@ TEST_F(move_mount_set_group, complex_sharing_copying)
>  		       CLONE_VM | CLONE_FILES); ASSERT_GT(pid, 0);
>  	ASSERT_EQ(wait_for_pid(pid), 0);
>  
> -	ASSERT_EQ(syscall(SYS_move_mount, ca_from.mntfd, "",
> +	ASSERT_EQ(syscall(__NR_move_mount, ca_from.mntfd, "",
>  			  ca_to.mntfd, "", MOVE_MOUNT_SET_GROUP
>  			  | MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH),
>  		  0);
> -- 
> 2.23.0
> 

