Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D225B3B1B5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 15:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhFWNoK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 09:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhFWNoJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 09:44:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C12CF61076;
        Wed, 23 Jun 2021 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624455712;
        bh=ahAIQzGeIV5bSA+izmWMgZyiMYHJ37sy5dm5nG35WsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2fs3xfj1k5ez23+zg+C8YgfDHiuth2aI+p7UqiOQwWK2sSAqUXxaqnpFRxiPL+Vu
         yrIX6Ii4gw63FUm9vIRgoLmKYmuxHFoLda7MqkRAbTnqhzc8v3FehQkcyzXhtl1rlC
         Vbk1eDjCtC15gwnY0osT+KmneZmHey/NlU4Kb5RG3t5fnUlFwxQ9Ybknkx4qBd74jn
         BLx467xAqWjRurwe/dOHVwf+46JGH25SbcJFgG0mKWWOQWaCgqezEYEFGPFPTNi4X1
         zIvAmd7tAe+ovpIG9dYW6RilEpCxGJiBD3U9PxvlYX2rh7w/At/AArTHZ1JuWpbVh6
         867z2BiQTgPkQ==
Date:   Wed, 23 Jun 2021 16:41:50 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.gardner@canonical.com, reinette.chatre@intel.com,
        shuah@kernel.org, linux-sgx@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/sgx: remove checks for file execute permissions
Message-ID: <20210623134150.j4qjhcepmtohsxdo@kernel.org>
References: <20210621190556.4B5DCBB1@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621190556.4B5DCBB1@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 21, 2021 at 12:05:56PM -0700, Dave Hansen wrote:
> 
> The SGX selftests can fail for a bunch of non-obvious reasons
> like 'noexec' permissions on /dev (which is the default *EVERYWHERE*
> it seems).
> 
> A new test mistakenly also looked for +x permission on the
> /dev/sgx_enclave.  File execute permissions really only apply to
> the ability of execve() to work on a file, *NOT* on the ability
> for an application to map the file with PROT_EXEC.  SGX needs to
> mmap(PROT_EXEC), but doesn't need to execve() the device file.
> 
> Remove the check.
> 
> Fixes: 4284f7acb78b ("selftests/sgx: Improve error detection and messages")
> Reported-by: Tim Gardner <tim.gardner@canonical.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-sgx@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> 
>  b/tools/testing/selftests/sgx/load.c |   16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff -puN tools/testing/selftests/sgx/load.c~sgx-no-file-exec tools/testing/selftests/sgx/load.c
> --- a/tools/testing/selftests/sgx/load.c~sgx-no-file-exec	2021-06-21 11:48:25.226294281 -0700
> +++ b/tools/testing/selftests/sgx/load.c	2021-06-21 12:03:28.023292029 -0700
> @@ -150,16 +150,6 @@ bool encl_load(const char *path, struct
>  		goto err;
>  	}
>  
> -	/*
> -	 * This just checks if the /dev file has these permission
> -	 * bits set.  It does not check that the current user is
> -	 * the owner or in the owning group.
> -	 */
> -	if (!(sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))) {
> -		fprintf(stderr, "no execute permissions on device file %s\n", device_path);
> -		goto err;
> -	}
> -
>  	ptr = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, 0);
>  	if (ptr == (void *)-1) {
>  		perror("mmap for read");
> @@ -169,13 +159,13 @@ bool encl_load(const char *path, struct
>  
>  #define ERR_MSG \
>  "mmap() succeeded for PROT_READ, but failed for PROT_EXEC.\n" \
> -" Check that current user has execute permissions on %s and \n" \
> -" that /dev does not have noexec set: mount | grep \"/dev .*noexec\"\n" \
> +" Check that /dev does not have noexec set:\n" \
> +" \tmount | grep \"/dev .*noexec\"\n" \
>  " If so, remount it executable: mount -o remount,exec /dev\n\n"
>  
>  	ptr = mmap(NULL, PAGE_SIZE, PROT_EXEC, MAP_SHARED, fd, 0);
>  	if (ptr == (void *)-1) {
> -		fprintf(stderr, ERR_MSG, device_path);
> +		fprintf(stderr, ERR_MSG);
>  		goto err;
>  	}
>  	munmap(ptr, PAGE_SIZE);
> _
> 



Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
