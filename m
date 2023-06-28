Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA6E74103F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 13:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjF1LnM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjF1LnL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 07:43:11 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AC51FE0;
        Wed, 28 Jun 2023 04:43:08 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 14827C020; Wed, 28 Jun 2023 13:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1687952587; bh=0WN8XsDGTRKDo6/ITLTj6m/cxiiek/G6u+FK4mhH5tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gx4AJQyPcZtb7aI/TykWXoADzXo4bdOvVJjyQ+Cb7zPtfJwZrSDLZM/q7usRdrtog
         FGQX2XjDpmyFls+QpV1tjeFplk/f8Mv2PypH+kgQmluS++wWM1Jk4xsG910vpF0ZHb
         xfyxxB9Z51Yf4vzbEc5VpkGfigeF4+jr6nxREoQHxJJZFxpjkqAsLaHlkgm6Taefk3
         05a9qf1lIsr0F9cQ+whwGIEyGAArCfDuQ2P2wRagOTsl2P2GEVE+7mLi78tGHI45XZ
         kyhynML2tCWVqI7OKmGe+VDvEJlBRMR1LKHmoJXqT+9CZtBGCmtFHeAmY7YZlf3LW/
         sBrJCnU4VSiGg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 28BC5C009;
        Wed, 28 Jun 2023 13:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1687952585; bh=0WN8XsDGTRKDo6/ITLTj6m/cxiiek/G6u+FK4mhH5tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvZ0TWI1KCV5Hc+MvIv/ZKAp0wL4fpBdccuM0cFUe0TFf+X6gYr9CDJd7QsRqmqG4
         4YgnIfYF0sW7oFSn/jDjP6Uxo6MeXPqmEfiA1NPx2a4J4w2yM8x7NuuoZflv9h/9Y4
         7p7dxCWhVcETdtOmMvlK7vbu32Umo3+ITlWpJzuvDeOmVrp+gAI/H2+RyVb8DbqCvN
         e2BI3hh2HsD88feDgPMaHDYDcp+8hf6rETpXY9DD5JU77lb88PlAYN9u9cSjhLD0xb
         RpjCi4BTEZ8N3Hkf8CmGuIOm7SEN6m26emULCkRXfrotBmD9pC5dBc1IYAax/a0P6V
         aGEE7u5dhH38Q==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id f3a75d01;
        Wed, 28 Jun 2023 11:42:56 +0000 (UTC)
Date:   Wed, 28 Jun 2023 20:42:41 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 3/5] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <ZJwcsU0vI-nzgOB_@codewreck.org>
References: <20221215001205.51969-1-jeffxu@google.com>
 <20221215001205.51969-4-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221215001205.51969-4-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

jeffxu@chromium.org wrote on Thu, Dec 15, 2022 at 12:12:03AM +0000:
> From: Jeff Xu <jeffxu@google.com>
> 
> The new MFD_NOEXEC_SEAL and MFD_EXEC flags allows application to
> set executable bit at creation time (memfd_create).
> 
> When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
> (mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
> be executable (mode: 0777) after creation.
> 
> when MFD_EXEC flag is set, memfd is created with executable bit
> (mode:0777), this is the same as the old behavior of memfd_create.
> 
> The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
>         MFD_EXEC was set.
> 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
>         MFD_NOEXEC_SEAL was set.
> 2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.

So, erm, I'm a bit late to the party but I was just looking at a way of
blocking memfd_create+exec in a container and this sounded perfect: my
reading is that this is a security feature meant to be set for
container's namespaces that'd totally disable something like
memfd_create followed by fexecve (because we don't want weird binaries
coming from who knows where to be executed on a shiny secure system),
but. . . is this actually supposed to work?
(see below)

> [...]
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -263,12 +264,14 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
>  #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
>  #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
>  
> -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
> +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
>  
>  SYSCALL_DEFINE2(memfd_create,
>  		const char __user *, uname,
>  		unsigned int, flags)
>  {
> +	char comm[TASK_COMM_LEN];
> +	struct pid_namespace *ns;
>  	unsigned int *file_seals;
>  	struct file *file;
>  	int fd, error;
> @@ -285,6 +288,39 @@ SYSCALL_DEFINE2(memfd_create,
>  			return -EINVAL;
>  	}
>  
> +	/* Invalid if both EXEC and NOEXEC_SEAL are set.*/
> +	if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC_SEAL))
> +		return -EINVAL;
> +
> +	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
> +		[code that checks the sysctl]

If flags already has either MFD_EXEC or MFD_NOEXEC_SEAL, you don't check
the sysctl at all.

This can be verified easily:
-----
$ cat > memfd_exec.c <<'EOF'
#define _GNU_SOURCE

#include <errno.h>
#include <stdio.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>

#ifndef MFD_EXEC
#define MFD_EXEC                0x0010U
#endif

int main() { 
    int fd = memfd_create("script", MFD_EXEC);
    if (fd == -1)l
        perror("memfd");
    
    char prog[] = "#!/bin/sh\necho Ran script\n";
    if (write(fd, prog, sizeof(prog)-1) != sizeof(prog)-1)
            perror("write");
    
    char *const argv[] = { "script", NULL };
    char *const envp[] = { NULL };
    fexecve(fd, argv, envp);
    perror("fexecve");
}   
EOF
$ gcc -o memfd_exec memfd_exec.c
$ ./memfd_exec
Ran script
$ sysctl vm.memfd_noexec
vm.memfd_noexec = 2
-----
(as opposed to failing hard on memfd_create if flag unset on sysctl=2,
and failing on fexecve with flag unset and sysctl=1)

What am I missing?



BTW I find the current behaviour rather hard to use: setting this to 2
should still set NOEXEC by default in my opinion, just refuse anything
that explicitly requested EXEC.

Sure there's a warn_once that memfd_create was used without seal, but
right now on my system it's "used up" 5 seconds after boot by systemd:
[    5.854378] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=1 'systemd'

And anyway, older kernels will barf up EINVAL when calling memfd_create
with MFD_NOEXEC_SEAL, so even if userspace will want to adapt they'll
need to try calling memfd_create with the flag once and retry on EINVAL,
which let's face it is going to take a while to happen.
(Also, the flag has been added to glibc, but not in any release yet)

Making calls default to noexec AND refuse exec does what you want
(forbid use of exec in an app that wasn't in a namespace that allows
exec) while allowing apps that require it to work; that sounds better
than making all applications that haven't taken the pain of adding the
new flag to me.
Well, I guess an app that did require exec without setting the flag will
fail in a weird place instead of failing at memfd_create and having a
chance to fallback, so it's not like it doesn't make any sense;
I don't have such strong feelings about this if the sysctl works, but
for my use case I'm more likely to want to take a chance at memfd_create
not needing exec than having the flag set. Perhaps a third value if I
cared enough...

-- 
Dominique Martinet | Asmadeus
