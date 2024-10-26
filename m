Return-Path: <linux-kselftest+bounces-20761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872D29B1B62
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Oct 2024 01:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A5B1F21B79
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 23:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B211D79B8;
	Sat, 26 Oct 2024 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gz8PY4Yb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1959F9CF
	for <linux-kselftest@vger.kernel.org>; Sat, 26 Oct 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729985531; cv=none; b=DEICerLtUWowaV5VXl83ENKl90WAadHMcgLWSoI/AQWrWOhFwvkn5sloF3fIse+GojER/BN+FOZTRrSVsI+LH+HDSKjvfVvvap1+0Ewe4WBqrWmxucdIcAwxkjiQoc/3aKJebOUXVqf4WoD1YHaalCSukKR6+qtgz4DQbrqwDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729985531; c=relaxed/simple;
	bh=A8zjttDJbtwZs5JGIefLrJLAzMWQ2XBwhd4ODpsue3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elD+hqV+fm9makpJu1tsny2LayT1gsByYtpQjU/eu8jAU73//lf55MoEItllX8/d2OJ5BOGTGqYRt449pIoPsKZ9CROLylyyp3oRRy7FRYzD0UemOjxBDCO2RjQsclEDM1dx6d3W0yZnZluUWCi8PQAWlVloq1L6dxIk+1jEN1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gz8PY4Yb; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460ad98b043so27321581cf.1
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Oct 2024 16:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729985527; x=1730590327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2pzTDkHgM5H320SIcVgLwbioTva8Y/3QBZN2C+npNqs=;
        b=gz8PY4Yb3H2rUSFZH/055tpFuDo1UFXhw4SI0fHmUZXy2o3ZuEGwJIzpnSoammIpkr
         0xoILsSCRBJFsjGbEKoQWvahgqdJ3rVCQKFgrdyfoUjN+KWUyo0Yl04hhBMPhI13rYi2
         nRP4oe7krtXInhg/EIIKlFYxeRU1q81lhqqM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729985527; x=1730590327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pzTDkHgM5H320SIcVgLwbioTva8Y/3QBZN2C+npNqs=;
        b=rzOk5DXdPgYTpJpBNmN/xlMkioD+hKaHaqnZG/jCDFgLEL7xtp9O7/3ffQglDzvlSo
         4wee5RDHKATMcW751X/YRvCI2fg8kre0xcKwqtpfZ+xOy+kWPeCtwhcYVIBMwpe3QAHn
         EIem57PNV2MZJ8qou1Fte/CCbhiSD7DXQSDTse9vfA06iFAJgG89Vxe0TMvWMqxzWoA+
         4avYiQpIlHEF5qgI9aPF6+PNINQ2uUzjew7pMGrJ9kfAYk3SVZemynklkDqQE0ENAZfI
         JdeoWE8H1XZjiks7dvNUS04mGF7YGR0CwISHqaItoYg0dvvzmUPJvvmsATlWI1c9/PXR
         xdIw==
X-Gm-Message-State: AOJu0Yyb48eI1rvA5l3dTXC76rHV3Dg4m1m7JMxMvAaRnDsnnhiBfbkC
	0B8POE90Ud4jd1QbrObxEmwzbeMww2X2rRX7wdwQvtmOdkuKjnM7AO8DxHjLktY=
X-Google-Smtp-Source: AGHT+IFg5sZ3T0vHZWwv6gpgQOgLw+o4zUjDP87LErJtuZUQvXdrJLJrZBqhycxX3QOeNoMPLeF9ww==
X-Received: by 2002:a05:622a:150:b0:461:1593:9234 with SMTP id d75a77b69052e-4613b4052b6mr86981751cf.1.1729985526626;
        Sat, 26 Oct 2024 16:32:06 -0700 (PDT)
Received: from [172.19.248.149] ([205.220.129.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613213326bsm20464131cf.23.2024.10.26.16.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 16:32:05 -0700 (PDT)
Message-ID: <98fa9d54-a2db-4c31-a0e7-ee4ecb59a172@linuxfoundation.org>
Date: Sat, 26 Oct 2024 17:31:46 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: tmpfs: Add kselftest support to tmpfs
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241026191621.2860376-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241026191621.2860376-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/24 13:16, Shivam Chaudhary wrote:
> Add kselftest support for open, linkat, unshare, mount tests
> 
> - Replace direct error handling with
>   `ksft_test_result_*` macros for better reporting
>    of test outcomes.
> 
> - Add `ksft_print_header()` and `ksft_set_plan()`
>   to structure test outputs more effectively.
> 
> - Introduce the helper function `is_unshare()` to
>    handle unshare() related checks.
> 
> - Improve the test flow by adding more detailed pass/fail
>    reporting for unshare, mounting, file opening, and linking
>    operations.
> 
> - Skip the test if it's not run as root, providing an
>    appropriate Warning.
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
>   ok 1 # SKIP This test needs root to run
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
> Notes:
> 	Changes in v2:
>    		- Make the commit message more clear.
>      
> 	link to v1: https://lore.kernel.org/all/20241024200228.1075840-1-cvam0000@gmail.com/T/#u
> 
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

Why do you need a new routine for this? Looks at
other tests that do root check. You can use getuid
in the main*( before trying unshare.

> +{
> +	if (unshare(flag) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
> -			fprintf(stderr, "error: unshare, errno %d\n", errno);
> -			return 4;
> +			ksft_test_result_fail("error: unshare, errno %d\n", errno);
> +			return -1; // Return -1 for failure

Match the comment style in the file which /*

>   		}
>   		fprintf(stderr, "error: unshare, errno %d\n", errno);
> +		return -1;
> +	}
> +
> +	return 0; // Return 0 for success

Same comment here.

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

Move set_plan up to the top

> +
> +	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1) {
> +		ksft_test_result_fail("mount(): Root filesystem private mount: Fail %d\n", errno);
> +		return 1;
> +	} else {
> +		ksft_test_result_pass("mount(): Root filesystem private mount: Success\n");
> +	}
> +
> +	ksft_set_plan(3);

Hmm. Why add another set_plan - one plan for all tests is sufficient.

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

Too many set_plans - check the usage in other tests.

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

Again.

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

This is a small test and there is no need to add these may set_plan() calls.

thanks,
-- Shuah

