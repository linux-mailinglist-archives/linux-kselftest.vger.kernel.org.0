Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E679A3414EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 06:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhCSFih (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 01:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233730AbhCSFiZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 01:38:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA7F264EED;
        Fri, 19 Mar 2021 05:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616132304;
        bh=+1+vehoUYf3q5B5TrXV7HK7m6+TRZqh8slDFYWBYvuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1oAhqd46/hwRR/NseERrqSDDYXmaZiuDzK7pP1XZRJ/XqI6jVXWe4j2Y2OfQSjPK
         ZuhUv4E5N1dJCWF0Gh5DYzX7Qtr8dbsSLX/gtoIuaZpxv644KpNX2SJm90DO7UUOBU
         S7mP3a6BNLSmVGU882RGUaY6Ukat5R29by1dtvIDVf2uyyLq8BMjcII9/tRIXCeLaE
         9xWF+o6QbycCPzhlAbNSrnhtpkFN9da67nX7vwAPGXGqZ1d8Ky/2c05GnXXFH3Dwip
         OdlZ2hkAKj7aCQrojIylu5kBQaQmRuqoFxUHv8xYYaPwYvlj/i5OujWyzpXitB0/Iz
         bvLeq+ZrSSGMg==
Date:   Fri, 19 Mar 2021 07:37:57 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org, bp@alien8.de,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/sgx: improve error detection and messages
Message-ID: <YFQ4tdjXH6AZvIGm@kernel.org>
References: <20210318194301.11D9A984@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318194301.11D9A984@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 18, 2021 at 12:43:01PM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The SGX device file (/dev/sgx_enclave) is unusual in that it requires
> execute permissions.  It has to be both "chmod +x" *and* be on a
> filesystem without 'noexec'.
> 
> In the future, udev and systemd should get updates to set up systems
> automatically.  But, for now, nobody's systems do this automatically,
> and everybody gets error messages like this when running ./test_sgx:
> 
> 	0x0000000000000000 0x0000000000002000 0x03
> 	0x0000000000002000 0x0000000000001000 0x05
> 	0x0000000000003000 0x0000000000003000 0x03
> 	mmap() failed, errno=1.
> 
> That isn't very user friendly, even for forgetful kernel developers.
> 
> Further, the test case is rather haphazard about its use of fprintf()
> versus perror().
> 
> Improve the error messages.  Use perror() where possible.  Lastly,
> do some sanity checks on opening and mmap()ing the device file so
> that we can get a decent error message out to the user.
> 
> Now, if your user doesn't have permission, you'll get the following:
> 
> 	$ ls -l /dev/sgx_enclave
> 	crw------- 1 root root 10, 126 Mar 18 11:29 /dev/sgx_enclave
> 	$ ./test_sgx
> 	Unable to open /dev/sgx_enclave: Permission denied
> 
> If you then 'chown dave:dave /dev/sgx_enclave' (or whatever), but
> you leave execute permissions off, you'll get:
> 
> 	$ ls -l /dev/sgx_enclave
> 	crw------- 1 dave dave 10, 126 Mar 18 11:29 /dev/sgx_enclave
> 	$ ./test_sgx
> 	no execute permissions on device file
> 
> If you fix that with "chmod ug+x /dev/sgx" but you leave /dev as
> noexec, you'll get this:
> 
> 	$ mount | grep "/dev .*noexec"
> 	udev on /dev type devtmpfs (rw,nosuid,noexec,...)
> 	$ ./test_sgx
> 	ERROR: mmap for exec: Operation not permitted
> 	mmap() succeeded for PROT_READ, but failed for PROT_EXEC
> 	check that user has execute permissions on /dev/sgx_enclave and
> 	that /dev does not have noexec set: 'mount | grep "/dev .*noexec"'
> 
> That can be fixed with:
> 
> 	mount -o remount,noexec /devESC
> 
> Hopefully, the combination of better error messages and the search
> engines indexing this message will help people fix their systems
> until we do this properly.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: linux-sgx@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
> 
>  b/tools/testing/selftests/sgx/load.c |   66 +++++++++++++++++++++++++++--------
>  b/tools/testing/selftests/sgx/main.c |    2 -
>  2 files changed, 53 insertions(+), 15 deletions(-)
> 
> diff -puN tools/testing/selftests/sgx/load.c~sgx-selftest-err-rework tools/testing/selftests/sgx/load.c
> --- a/tools/testing/selftests/sgx/load.c~sgx-selftest-err-rework	2021-03-18 12:18:38.649828215 -0700
> +++ b/tools/testing/selftests/sgx/load.c	2021-03-18 12:40:46.388824904 -0700
> @@ -45,19 +45,19 @@ static bool encl_map_bin(const char *pat
>  
>  	fd = open(path, O_RDONLY);
>  	if (fd == -1)  {
> -		perror("open()");
> +		perror("enclave executable open()");
>  		return false;
>  	}
>  
>  	ret = stat(path, &sb);
>  	if (ret) {
> -		perror("stat()");
> +		perror("enclave executable stat()");
>  		goto err;
>  	}
>  
>  	bin = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
>  	if (bin == MAP_FAILED) {
> -		perror("mmap()");
> +		perror("enclave executable mmap()");
>  		goto err;
>  	}
>  
> @@ -90,8 +90,7 @@ static bool encl_ioc_create(struct encl
>  	ioc.src = (unsigned long)secs;
>  	rc = ioctl(encl->fd, SGX_IOC_ENCLAVE_CREATE, &ioc);
>  	if (rc) {
> -		fprintf(stderr, "SGX_IOC_ENCLAVE_CREATE failed: errno=%d\n",
> -			errno);
> +		perror("SGX_IOC_ENCLAVE_CREATE failed");
>  		munmap((void *)secs->base, encl->encl_size);
>  		return false;
>  	}
> @@ -116,31 +115,69 @@ static bool encl_ioc_add_pages(struct en
>  
>  	rc = ioctl(encl->fd, SGX_IOC_ENCLAVE_ADD_PAGES, &ioc);
>  	if (rc < 0) {
> -		fprintf(stderr, "SGX_IOC_ENCLAVE_ADD_PAGES failed: errno=%d.\n",
> -			errno);
> +		perror("SGX_IOC_ENCLAVE_ADD_PAGES failed");
>  		return false;
>  	}
>  
>  	return true;
>  }
>  
> +
> +
>  bool encl_load(const char *path, struct encl *encl)
>  {
> +	const char device_path[] = "/dev/sgx_enclave";
>  	Elf64_Phdr *phdr_tbl;
>  	off_t src_offset;
>  	Elf64_Ehdr *ehdr;
> +	struct stat sb;
> +	void *ptr;
>  	int i, j;
>  	int ret;
> +	int fd = -1;
>  
>  	memset(encl, 0, sizeof(*encl));
>  
> -	ret = open("/dev/sgx_enclave", O_RDWR);
> -	if (ret < 0) {
> -		fprintf(stderr, "Unable to open /dev/sgx_enclave\n");
> +	fd = open(device_path, O_RDWR);
> +	if (fd < 0) {
> +		perror("Unable to open /dev/sgx_enclave");
> +		goto err;
> +	}
> +
> +	ret = stat(device_path, &sb);
> +	if (ret) {
> +		perror("device file stat()");
> +		goto err;
> +	}
> +
> +	/*
> +	 * This just checks if the /dev file has these permission
> +	 * bits set.  It does not check that the current user is
> +	 * the owner or in the owning group.
> +	 */
> +	if (!(sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))) {
> +		fprintf(stderr, "no execute permissions on device file\n");
> +		goto err;
> +	}
> +
> +	ptr = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, 0);
> +	if (ptr == (void *)-1) {
> +		perror("mmap for read");
> +		goto err;
> +	}
> +	munmap(ptr, PAGE_SIZE);
> +
> +	ptr = mmap(NULL, PAGE_SIZE, PROT_EXEC, MAP_SHARED, fd, 0);
> +	if (ptr == (void *)-1) {
> +		perror("ERROR: mmap for exec");
> +		fprintf(stderr, "mmap() succeeded for PROT_READ, but failed for PROT_EXEC\n");
> +		fprintf(stderr, "check that user has execute permissions on %s and\n", device_path);
> +		fprintf(stderr, "that /dev does not have noexec set: 'mount | grep \"/dev .*noexec\"'\n");
>  		goto err;
>  	}
> +	munmap(ptr, PAGE_SIZE);
>  
> -	encl->fd = ret;
> +	encl->fd = fd;
>  
>  	if (!encl_map_bin(path, encl))
>  		goto err;
> @@ -217,6 +254,8 @@ bool encl_load(const char *path, struct
>  	return true;
>  
>  err:
> +	if (fd != -1)
> +		close(fd);
>  	encl_delete(encl);
>  	return false;
>  }
> @@ -229,7 +268,7 @@ static bool encl_map_area(struct encl *e
>  	area = mmap(NULL, encl_size * 2, PROT_NONE,
>  		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  	if (area == MAP_FAILED) {
> -		perror("mmap");
> +		perror("reservation mmap()");
>  		return false;
>  	}
>  
> @@ -268,8 +307,7 @@ bool encl_build(struct encl *encl)
>  	ioc.sigstruct = (uint64_t)&encl->sigstruct;
>  	ret = ioctl(encl->fd, SGX_IOC_ENCLAVE_INIT, &ioc);
>  	if (ret) {
> -		fprintf(stderr, "SGX_IOC_ENCLAVE_INIT failed: errno=%d\n",
> -			errno);
> +		perror("SGX_IOC_ENCLAVE_INIT failed");
>  		return false;
>  	}
>  
> diff -puN tools/testing/selftests/sgx/main.c~sgx-selftest-err-rework tools/testing/selftests/sgx/main.c
> --- a/tools/testing/selftests/sgx/main.c~sgx-selftest-err-rework	2021-03-18 12:18:38.652828215 -0700
> +++ b/tools/testing/selftests/sgx/main.c	2021-03-18 12:18:38.657828215 -0700
> @@ -195,7 +195,7 @@ int main(int argc, char *argv[], char *e
>  		addr = mmap((void *)encl.encl_base + seg->offset, seg->size,
>  			    seg->prot, MAP_SHARED | MAP_FIXED, encl.fd, 0);
>  		if (addr == MAP_FAILED) {
> -			fprintf(stderr, "mmap() failed, errno=%d.\n", errno);
> +			perror("mmap() segment failed");
>  			exit(KSFT_FAIL);
>  		}
>  	}
> _
> 
