Return-Path: <linux-kselftest+bounces-21544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5210D9BF3D6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 18:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742A51C23125
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC9205E33;
	Wed,  6 Nov 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y1Z5JiAh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CED200CB7
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912524; cv=none; b=afg6Jcxn/LV48rVEq0BEih+ro3eQqipd+5ANJf22GrjvLQKm9Rnw3Ba9/Z+DQNYKEPf/B5zf7OYt4KdwDhyXVb5Uq7/inP7O91nd8Wc/OXAtPJwUR3be+tSESrTz7mHbLVZdNVUKm9tgT0kBNMJeBgYlChmnY7fAxMQweoP9XG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912524; c=relaxed/simple;
	bh=q1WeBHGD5h1tHIzQJ3J0B4q74CaQ/9M3+/9g556AVjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LE6ybMjn9Zws2DyWtvJiAGLlYTujLB8VdSy/JIDITuXNPRgGEupUSKHwr3fRxVIIE7ljJIWM2Wi2CzTXs6cscvkD6FWKjyMU8vVXimHPg8XpW1FyIZtwPVOgztI0k9l8GR8yodMYrQyguuu+J5Xodm1QMJ1wJERgtTM2HNsuYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y1Z5JiAh; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a394418442so339715ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Nov 2024 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730912521; x=1731517321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGwC2Hl3MxKojtjjrNlDFREWkdarOnfG+IIyc3QOx0E=;
        b=Y1Z5JiAhxUTxhmEZ2RQy+weWn8XXMrhpdctCJMcd5GMVOl0rhEurvIpqIlOv+DDaox
         ls2t/UaRZ0Vwuez2eJv3MWkgtj4htC4v3T4ky/LqcdCwb7B2Y7SIgNrDs3xRVvPRt77v
         l8AXsofuhgPVW9oV82cQdi67Fxrnzb5eNqozU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912521; x=1731517321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGwC2Hl3MxKojtjjrNlDFREWkdarOnfG+IIyc3QOx0E=;
        b=T+C+WODVFbwZaTQTNuBVLzZIn7KzEMtg/0V0pzDeXgaYAW6ZGeDmqbzyoWTU26dEXL
         RE68IwK0Iew7g+tP7RPdxa93RancR8IGk2+cOzoT+gCPbt3dnyOg6xiF8TbweVCoC+fp
         MFpOMoSjj1PaBbyhNPi57IvzwKG/n0szRvbqaktom9/Y6Ct8GfSyfJTlCmShgUy52BAK
         5jkhOIQrYaTzt7Vxgt0kMhjT5htWyz1dnCX3KY2cpptlkC59gSE9yytyCjKMsmwS9wg6
         GrZkGhVXSRglcVpZtFOuYViiOh4PNfpUCdH2P/VQdTL0H5B8p0Yq7xzTP4ACsVpVkK1h
         DIsA==
X-Gm-Message-State: AOJu0YzK2hItlOYswSUsKGDuYeH3s7eowbdYiAhcyug+14ivJO94vIwb
	SsjhOQJUtp2JPBCdZs3FLv32kPucj7x07CjeXXb3Dq26RVfmSjDH2w2bcSstkd0=
X-Google-Smtp-Source: AGHT+IGpeyiohwTOy3CiKjinzWrPekKa3XkMj9Vgkkbqp5ZVCiUarzkfx8daEIGTgTOBqI7LMwudKg==
X-Received: by 2002:a05:6e02:1946:b0:3a3:b527:e809 with SMTP id e9e14a558f8ab-3a6b0327357mr188862495ab.14.1730912520864;
        Wed, 06 Nov 2024 09:02:00 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6bd2da409sm26213575ab.57.2024.11.06.09.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 09:02:00 -0800 (PST)
Message-ID: <920c61a8-4c5b-4386-a072-7c4e0f3a48c8@linuxfoundation.org>
Date: Wed, 6 Nov 2024 10:01:59 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] selftests: tmpfs: Add kselftest support to tmpfs
To: Shivam Chaudhary <cvam0000@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org
References: <20241105202639.1977356-1-cvam0000@gmail.com>
 <20241105202639.1977356-3-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241105202639.1977356-3-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/24 13:26, Shivam Chaudhary wrote:
> Replace direct error handling with 'ksft_test_result_*',
> 'ksft_print_msg' and KSFT_SKIP  macros for better reporting.
> 
> Test logs:
> 
> Before change:
> 
> - Without root
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
>    ok 1 # SKIP This test needs root to run
> 
> - With root
>   TAP version 13
> 1..1
>    unshare(): Creat new mount namespace: Success.
>    mount(): Root filesystem private mount: Success
>    mount(): Mounting tmpfs on /tmp: Success
>    openat(): Open first temporary file: Success
>    linkat(): Linking the temporary file: Success
>    openat(): Opening the second temporary file: Success

This is too noisy - there is no need to add message in
every single conditional. Errors make sense, bot don't
add unnecessary messages.

>    ok 1 Test : Success
>    Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
> 
>   .../selftests/tmpfs/bug-link-o-tmpfile.c      | 66 ++++++++++++++-----
>   1 file changed, 49 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> index cdab1e8c0392..f2e6a5b20698 100644
> --- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> +++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> @@ -42,39 +42,71 @@ int main(void)
>   
>   	if (unshare(CLONE_NEWNS) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
> -			fprintf(stderr, "error: unshare, errno %d\n", errno);
> -			return 4;
> +			ksft_print_msg("unshare() error: unshare, errno %d\n", errno);
> +			exit(KSFT_SKIP);

Same comment - you can simply use approrpiare ksft_exit_*() routine.

> +
> +		}
> +		else{
> +			fprintf(stderr, "unshare() error: unshare, errno %d\n", errno);
> +			return 1;

Since you are converting the test to use KSFT_ codes,
why not change this one? Shound't this ksft_exit_fail_msg()


> +
>   		}
> -		fprintf(stderr, "error: unshare, errno %d\n", errno);
> -		return 1;

Since you are converting the test to use KSFT_ codes,
why not change this one? Shound't this ksft_exit_fail_msg()

> +	}
> +	
> +	else {
> +		ksft_print_msg("unshare(): Creat new mount namespace: Success.\n");

Spelling - did you tun checkpatch on this?

> +
>   	}
> -	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
> -		fprintf(stderr, "error: mount '/', errno %d\n", errno);
> -		return 1;

Since you are converting the test to use KSFT_ codes,
why not change this one? Shound't this ksft_exit_fail_msg()

Same comment on using KSFT_ codes consistently.

> +
> +
> +
> +	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1) {
> +		ksft_print_msg("mount() error: Root filesystem private mount: Fail %d\n", errno);
> +		exit(KSFT_SKIP);

Why is this a skip?

Don't need two calls - ksft_exit_* calls

Since you are converting the test to use KSFT_ codes,
why not change this one? Shound't this ksft_exit_fail_msg()

> +	} else {
> +		ksft_print_msg("mount(): Root filesystem private mount: Success\n");

Is this message necessary?

>   	}
>   
> +
>   	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
>   	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
> -		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
> -		return 1;
> +		ksft_print_msg("mount() error: Mounting tmpfs on /tmp: Fail %d\n", errno);
> +		exit(KSFT_SKIP);
> +	} else {
> +		ksft_print_msg("mount(): Mounting tmpfs on /tmp: Success\n");
>   	}
>   
> -	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
> +
> +	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 1, errno %d\n", errno);
> -		return 1;
> +		ksft_print_msg("openat() error: Open first temporary file: Fail %d\n", errno);
> +		exit(KSFT_SKIP);
> +	} else {
> +		ksft_print_msg("openat(): Open first temporary file: Success\n");
>   	}
> +
> +
>   	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
> -		fprintf(stderr, "error: linkat, errno %d\n", errno);
> -		return 1;
> +		ksft_print_msg("linkat() error: Linking the temporary file: Fail %d\n", errno);
> +		/* Ensure fd is closed on failure */
> +		close(fd);
> +		exit(KSFT_SKIP);
> +	} else {
> +		ksft_print_msg("linkat(): Linking the temporary file: Success\n");
>   	}
>   	close(fd);
>   
> -	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
> +
> +	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 2, errno %d\n", errno);
> -		return 1;
> +		ksft_print_msg("openat() error: Opening the second temporary file: Fail %d\n", errno);
> +		exit(KSFT_SKIP);
> +	} else {
> +		ksft_print_msg("openat(): Opening the second temporary file: Success\n");
>   	}
>   
> +    ksft_test_result_pass("Test : Success\n");

Why do you need a message additional message here.

> +	ksft_exit_pass();
>   	return 0;
>   }
> +


I didn't call out every single error path. Same comments apply
to all. Please get rid of unnecessary success path messages.

If the output is too noisy it is hard to read and understand.

thanks,
-- Shuah

