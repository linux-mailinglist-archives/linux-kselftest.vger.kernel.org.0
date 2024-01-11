Return-Path: <linux-kselftest+bounces-2843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144DA82AD25
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 12:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF283281BE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 11:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7F15483;
	Thu, 11 Jan 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cKmWR6dd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B414F88
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T9hqx0cJqzMq1bb;
	Thu, 11 Jan 2024 11:13:49 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4T9hqv3yjdzr0;
	Thu, 11 Jan 2024 12:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1704971628;
	bh=+Dx1y3NlPG0Oz8roNtugh3aPtZh2p+5yMmqeI1QIBEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKmWR6dd9MEc0f1sWvXvwPne86uMgX6Rg0KeJVVsscclRS1cSJCPmDmTNkT/1XtcZ
	 M9CkaQ17CndY2CFXQa2yAo/NkWO74ADRLKDwND8coyTVI9ArZiO6sunp1VX8yJVUIp
	 eaoribqixdWDGKshebZ45tTsKaao8crTDJDZXE9U=
Date: Thu, 11 Jan 2024 12:13:46 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Huyadi <hu.yadi@h3c.com>
Cc: "jmorris@namei.org" <jmorris@namei.org>, 
	"serge@hallyn.com" <serge@hallyn.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "514118380@qq.com" <514118380@qq.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIHNlbGZ0ZXN0cy9tb3ZlX21v?=
 =?utf-8?Q?unt=5Fset=5Fgroup=3AMake?= tests build with old libc
Message-ID: <20240111.aeth4shoo0Oo@digikod.net>
References: <20240110072901.5873-1-hu.yadi@h3c.com>
 <20240110.Yap9Aw9aeghu@digikod.net>
 <6c398076d4624691a97766bad168d975@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c398076d4624691a97766bad168d975@h3c.com>
X-Infomaniak-Routing: alpha

On Thu, Jan 11, 2024 at 02:25:03AM +0000, Huyadi wrote:
> 
> >On Wed, Jan 10, 2024 at 03:29:01PM +0800, Hu Yadi wrote:
> >> From: "Hu.Yadi" <hu.yadi@h3c.com>
> >> 
> >> Replace SYS_<syscall> with __NR_<syscall>.  Using the __NR_<syscall> 
> >> notation, provided by UAPI, is useful to build tests on systems 
> >> without the SYS_<syscall> definitions.
> >
> >This looks a lot like that...
> >https://git.kernel.org/stable/c/87129ef13603ae46c82bcd09eed948acf0506dbb
> 
> Yes, I picked up comments from above commit in order for consistent,
> I would send v3 patch if it is inappropriate. 

This is not an issue at all to use the same wording if it makes sense.
Actually, the description of v3 is less explanatory.  It might just be
appropriate to reference past similar work. That would justify your
work, add a precedent, and if there is any issue we could fix both
changes.

You can append this to the commit message (with the v2 description):

Similar changes: commit 87129ef13603 ("selftests/landlock: Make tests
build with old libc")

Acked-by: Mickaël Salaün <mic@digikod.net>

> 
> >> 
> >> Replace SYS_move_mount with __NR_move_mount
> >> 
> >> Signed-off-by: Hu.Yadi <hu.yadi@h3c.com> Suggested-by:Jiao 
> >> <jiaoxupo@h3c.com> Reviewed-by:Berlin <berlin@h3c.com>
> >> ---
> >> Changes v1 -> v2:
> >>  - Fix mail of Suggested-by and Reviewed-by
> >> 
> >>  .../move_mount_set_group/move_mount_set_group_test.c          | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git 
> >> a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_te
> >> st.c 
> >> b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_te
> >> st.c index 50ed5d475dd1..bcf51d785a37 100644
> >> --- 
> >> a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_te
> >> st.c
> >> +++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_grou
> >> +++ p_test.c
> >> @@ -218,7 +218,7 @@ static bool move_mount_set_group_supported(void)
> >>  	if (mount(NULL, SET_GROUP_FROM, NULL, MS_SHARED, 0))
> >>  		return -1;
> >>  
> >> -	ret = syscall(SYS_move_mount, AT_FDCWD, SET_GROUP_FROM,
> >> +	ret = syscall(__NR_move_mount, AT_FDCWD, SET_GROUP_FROM,
> >>  		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
> >>  	umount2("/tmp", MNT_DETACH);
> >>  
> >> @@ -363,7 +363,7 @@ TEST_F(move_mount_set_group, complex_sharing_copying)
> >>  		       CLONE_VM | CLONE_FILES); ASSERT_GT(pid, 0);
> >>  	ASSERT_EQ(wait_for_pid(pid), 0);
> >>  
> >> -	ASSERT_EQ(syscall(SYS_move_mount, ca_from.mntfd, "",
> >> +	ASSERT_EQ(syscall(__NR_move_mount, ca_from.mntfd, "",
> >>  			  ca_to.mntfd, "", MOVE_MOUNT_SET_GROUP
> >>  			  | MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH),
> >>  		  0);
> >> --
> >> 2.23.0
> >>  

