Return-Path: <linux-kselftest+bounces-20562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1A9AEE62
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 19:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BFF1F25A83
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 17:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144E1F9EB1;
	Thu, 24 Oct 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LyQzDTjp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21131FAC51
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791605; cv=none; b=chQ6a3XFOnUKLXuNX3YeYnNIIF/sV2vZfwbbWLocJUxqzFO9resCYYahhBvZAEJGKddMAOKuGn5BaLF7mZad166zzdG6G+zooj9y1pxf2IqKCVYH8A5qMOMSMUYOX+8LTwuJqjz6toP8/qw4hbYWkGZBwK+1LKrtnPuEsy47wtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791605; c=relaxed/simple;
	bh=m5BnLuZVxaHa2LzZTz2MjsgnwaJqgooy8CvhIhoEANg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ura/PZ2IRGnRwLf08l3VQivQGOtdtpI8wMU60vrCamsLVhI0WtPH/XKOd7q9DYwR9fZypvI5NK0yIK5TLH7RhpoUYmuNUp9FWKw5re6LEu/6TshhD5MZI2a0zdJWCRLs89x4vP/jxBGIFMU7N/63jVbphkFYC0xMCyLnMYsAhKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LyQzDTjp; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83ac05206f6so47322239f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729791601; x=1730396401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOy9fihu5RTfl+fM0Y788CNOP+6McDxVQH2YQDhwNnE=;
        b=LyQzDTjpGtZoaw6uN2b0KQBX/4hiNQvmAWdjw1un3d2kEMwo/z1e6rYb9S75nixl+G
         FIAP27vC7gJZ3QTi2psIPE2rFCUORB2vFMsgPicI2WgM2joFCbB4Lz8zl1BvnMzxpoIM
         vhUuQTi+g/avvjyImXt4aV8AICvKKsSPIGmKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729791601; x=1730396401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOy9fihu5RTfl+fM0Y788CNOP+6McDxVQH2YQDhwNnE=;
        b=kRx/DrAQ0h40+Is/bW3GKkpBNsNzzzoWg2znud7O+z3Vo3S0Uq1dl4gLu1QClLhkQQ
         tePb8W76TQyuhtjHDtqf7FmHcBwCOhJQ7LMUf5bijx803ra09xr5caG/9dgwSpXu6kgn
         Im40tEn3WTiiRT2ojlY8HEves9L7Y4iIZZ91evEn/MSE3tW43F6vsTNHMBi4Yy23wjKZ
         IhyLrYcEvxuofhibKy6l9nNVgVBClipkJyhG8Eh3oviyHFvZF3bAw02M0pZJn3IuY80G
         BDDCEM6ElzskLkTyKRSr4cugA5UUw0Euusdg39sQUq15riAouTQx5ywfsyBX5E31epQi
         iX0g==
X-Gm-Message-State: AOJu0Yy7io6WTEbZu6pNv3A2XfpmNIKqih0Bqun28OLxU53UTjEE0l1c
	Oo7FTVbWEX7qNdOwgs/Vkmb8gQkMc5u93YDCo7+9alt8mUoqNTOrn28ZUiP5wtbkGinnMYyMGoB
	r
X-Google-Smtp-Source: AGHT+IHv82b2cb65dwMRPzEl4Hs7BXMwM9DTwRrmmBEY97BhVAWgrkTf8wnMXOzHC9pMpTe9oIY2yQ==
X-Received: by 2002:a05:6e02:1e0d:b0:3a3:63c3:352e with SMTP id e9e14a558f8ab-3a4d59bbd73mr90960595ab.19.1729791601425;
        Thu, 24 Oct 2024 10:40:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a400a7b37esm31353845ab.13.2024.10.24.10.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 10:40:00 -0700 (PDT)
Message-ID: <15feeb54-5136-41e2-9d8a-10524efc92f2@linuxfoundation.org>
Date: Thu, 24 Oct 2024 11:39:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Add kselftest framework to the testfile
To: Shivam Chaudhary <cvam0000@gmail.com>
Cc: linux-kselftest@vger.kernel.org, selftests@ellerman.id.au,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241024165520.948936-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241024165520.948936-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 10:55, Shivam Chaudhary wrote:
> This patch updates the existing test that checks
> for `open(O_TMPFILE)` and `linkat()` behaviors in
> mount namespaces to use the kselftest framework.
> 
> This includes the following changes:
> 
> - Replaced direct error handling with
>   `ksft_test_result_*` macros for better reporting
>    of test outcomes.

Replace

> 
> - Added `ksft_print_header()` and `ksft_set_plan()`
>   to structure test outputs more effectively.
> 
> - Introduced the helper function `is_unshare()` to
>    handle unshare-related checks.
> 

Introduce

> - Improved the test flow by adding more detailed pass/fail
>    reporting for unshare, mounting, file opening, and linking
>    operations.

Improve

> 
> - Skips the test if it's not run as root, providing an
>    appropriate Warning.

Check submitting patches document for details how to write
short log and change log that hep reviewers.

Also - you haven't cc'ed the right mailing lists. Send v2
cc'ing kselftest mailing list and correcting the short
log and change log problems.


> 
> Test logs:
> 
> Before change:
> 
> - Withou root
>   error: unshare, errno 1
> 
> - With root
>   No, output
> 
> After change:
> 
> - Without root
>   TAP version 13
>   1..1
>   ok 1 # SKIP This test needs root to ru
> 
> - With root
>   TAP version 13
>   1..1
>   ok 1 unshare(): we have a new mount namespace.
>   1..2
>   ok 2 mount(): Root filesystem private mount: Success
>   1..3
>   ok 3 mount(): Mounting tmpfs on /tmp: Success
>   1..4
>   ok 4 openat(): Open first temporary file: Success
>   1..5
>   ok 5 linkat(): Linking the temporary file: Success
>   1..6
>   ok 6 openat(): Opening the second temporary file: Success
>   # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>   .../selftests/tmpfs/bug-link-o-tmpfile.c      | 72 +++++++++++++++----
>   1 file changed, 58 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> index b5c3ddb90942..26dea19c1614 100644
> --- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> +++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> @@ -23,45 +23,89 @@
>   #include <sys/mount.h>
>   #include <unistd.h>
>   
> -int main(void)
> -{
> -	int fd;
> +#include "../kselftest.h"
>   
> -	if (unshare(CLONE_NEWNS) == -1) {
> +static int is_unshare(int flag)
> +{
> +	if (unshare(flag) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
> -			fprintf(stderr, "error: unshare, errno %d\n", errno);
> -			return 4;
> +			ksft_test_result_fail("error: unshare, errno %d\n", errno);
> +			return -1; // Return -1 for failure
>   		}
>   		fprintf(stderr, "error: unshare, errno %d\n", errno);
> +		return -1;
> +	}
> +
> +	return 0; // Return 0 for success
> +}
> +
> +int main(void)
> +{
> +	int fd;
> +
> +	// Setting up kselftest framework
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	// Check if test is run as root
> +	if (geteuid()) {
> +		ksft_test_result_skip("This test needs root to run!\n");
>   		return 1;
>   	}
> -	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
> -		fprintf(stderr, "error: mount '/', errno %d\n", errno);
> +
> +	if (is_unshare(CLONE_NEWNS) == 0) {
> +		ksft_test_result_pass("unshare(): we have a new mount namespace.\n");
> +	} else {
> +		ksft_test_result_fail("unshare(): failed\n");
>   		return 1;
>   	}
>   
> +	ksft_set_plan(2);
> +
> +	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1) {
> +		ksft_test_result_fail("mount(): Root filesystem private mount: Fail %d\n", errno);
> +		return 1;
> +	} else {
> +		ksft_test_result_pass("mount(): Root filesystem private mount: Success\n");
> +	}
> +
> +	ksft_set_plan(3);
>   	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
>   	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
> -		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
> +		ksft_test_result_fail("mount(): Mounting tmpfs on /tmp: Fail %d\n", errno);
>   		return 1;
> +	} else {
> +		ksft_test_result_pass("mount(): Mounting tmpfs on /tmp: Success\n");
>   	}
>   
> -	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
> +	ksft_set_plan(4);
> +	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 1, errno %d\n", errno);
> +		ksft_test_result_fail("openat(): Open first temporary file: Fail %d\n", errno);
>   		return 1;
> +	} else {
> +		ksft_test_result_pass("openat(): Open first temporary file: Success\n");
>   	}
> +
> +	ksft_set_plan(5);
>   	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
> -		fprintf(stderr, "error: linkat, errno %d\n", errno);
> +		ksft_test_result_fail("linkat(): Linking the temporary file: Fail %d\n", errno);
> +		close(fd); // Ensure fd is closed on failure
>   		return 1;
> +	} else {
> +		ksft_test_result_pass("linkat(): Linking the temporary file: Success\n");
>   	}
>   	close(fd);
>   
> -	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
> +	ksft_set_plan(6);
> +	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 2, errno %d\n", errno);
> +		ksft_test_result_fail("openat(): Opening the second temporary file: Fail %d\n", errno);
>   		return 1;
> +	} else {
> +		ksft_test_result_pass("openat(): Opening the second temporary file: Success\n");
>   	}
>   
> +	ksft_exit_pass();
>   	return 0;
>   }


