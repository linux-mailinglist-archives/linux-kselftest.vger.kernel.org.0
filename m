Return-Path: <linux-kselftest+bounces-23830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA5A0006B
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 22:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923783A2655
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B7E1A9B53;
	Thu,  2 Jan 2025 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VX1AHgyP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050038F91
	for <linux-kselftest@vger.kernel.org>; Thu,  2 Jan 2025 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735852249; cv=none; b=jTXvL2G/riKq2Wr0BsDknU0725WWqj5LYzsO8AYycivjl/CHZ2Fx7lXBWLQHk4du0f+YChxvWWr6wMwpsUYvZpOqKl5TvkBK7xh/1D8tSlrHIJaAOcQoYEzLHPmlhjmhMzxIhRKP514Ac17UeyFTm7LrMWGcDWC2FYROk5/UkOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735852249; c=relaxed/simple;
	bh=Eq5W+nlVIBj2dLigCJUlkzCAbLsA03Jc6vtkqAg52Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQgqPPQbnBtegNf2oEgDJFvdNBOjqnovKyrchICLEcu1QSkxh+xVlvzJWrwMysfj0kKEqQmXtcOHjM/1fM5I3uDjfYRROazpsTvtvUa8oNG6h0qFVwb6GfPysijwcfaezMTcQNQIEumvPCbdYc9Cb7yxqo643gZi6wJvSp8WD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VX1AHgyP; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844ef6275c5so409834139f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Jan 2025 13:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735852246; x=1736457046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=deBZWtBO2Rql5MGEECC7BVBsZ9SXSslOvwjRAQYiN8I=;
        b=VX1AHgyPTPOb8O2cjT/o/alnN8h8V3wFgabfU6oVrWvEnS89LYuM2K1V//dsIrI4vN
         4zHWmveYkCAJdAou11+QUalFcyY2CzHd5V+eMN9xGZte3JNhf/JUD/3pPx9J29L32NjC
         UGQbvy5+jbrV0fsForD9bD+VNhqZAJt5iKPto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735852246; x=1736457046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deBZWtBO2Rql5MGEECC7BVBsZ9SXSslOvwjRAQYiN8I=;
        b=QE6KZd3JRQlBGAEmA2ZA2MVLyp4dDf5baODesXl9xR8nBy1t0Yv0K6+GmOPDgsz8/h
         j2O29bb34edBFFD5So6Hf4GXo2MBtg9uoEqvbT4gzCutwDkE5BrLv7/EzyoHRP03uyzr
         EtxvVfcYpvqecPDbs7mfde36QYI9axs9XLSTMC65hcyyD+wPRns29R6pccnKNGAgOdU4
         BTsBMByv5LTM01AGGb3vrjjrzohL99j5eFS0ZXHzNRGI3Tm3uXeMHBn14AdznvgLVJkR
         jMPX46hXKLPiJoK1Fiua2E9q1jo2dWtbBy/a3CKj/8r4gNu027PhPmtOYKyQLma/WTuW
         BLsg==
X-Gm-Message-State: AOJu0Yw6iXUAnsRwc8D1N9VSkwwlhMNIiPLM0Ej5dc/KPsCf0Zzhrr52
	aWvVpObblX1X236Qxwpele62GtsZ18J1N8uF/kTTlXO4GI+SwTuKWEbcdNQ6JeBgs+TGljhDgOO
	L
X-Gm-Gg: ASbGnct6IBqwFTJ811aVnsHt9LsJwS5A9xMSEIPh7LxT/OMLe+AjFMhnMpCtdmpz6AV
	sNSmXfbggfaKkTN0um7ndwO3QxdsySDR3LoNwYTq/3CnIMlBotZrsaX6EPSgZ9gal6cNyTAq7l9
	bpiB6GSO4XfIRlFJznSDgWsL4sLWEbUOBWalFt+gQbDNqjruDPz2O8IwCV4lpVTbc1dZDvPu6uf
	/vO8FOTieg7Z9s++tnT0szXBzzdxTrk/zCZeU6StyiaCeDDYNmJqxL7M2hvHeX59SXT
X-Google-Smtp-Source: AGHT+IFczBG3Zmz4pta4ydTwyFuZbPoCtqR/zmSfDX+fnZp2HVVoA8aMFQQGitPh8lFBDiQ/xnmKdQ==
X-Received: by 2002:a05:6602:641c:b0:82d:9b0:ecb7 with SMTP id ca18e2360f4ac-8499e499299mr4092284739f.3.1735852246236;
        Thu, 02 Jan 2025 13:10:46 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf50f75sm6987880173.5.2025.01.02.13.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 13:10:45 -0800 (PST)
Message-ID: <7b2e2d2e-6ba8-490e-ad80-229982cdd6d8@linuxfoundation.org>
Date: Thu, 2 Jan 2025 14:10:45 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] selftests: tmpfs: Add kselftest support to tmpfs
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250102100459.1291426-1-cvam0000@gmail.com>
 <20250102100459.1291426-3-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250102100459.1291426-3-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/2/25 03:04, Shivam Chaudhary wrote:
> Replace direct error handling with 'ksft_test_result_*'
> macros for better reporting.
> 
> Test logs:
> 
> Before change:
> - Without root
>   error: unshare, errno 1
> 
> - With root
>   No, output
> 
> After change:
> - Without root
> TAP version 13
> 1..1
> ok 2 # SKIP This test needs root to run!
> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> - With root
> TAP version 13
> 1..1
> ok 1 Test : Success
> Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>   .../selftests/tmpfs/bug-link-o-tmpfile.c      | 28 +++++++++----------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> index 657b64857e82..290f11a81d2b 100644
> --- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> +++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> @@ -41,39 +41,39 @@ int main(void)
>   
>   	if (unshare(CLONE_NEWNS) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
> -			fprintf(stderr, "error: unshare, errno %d\n", errno);
> -			return 4;
> +			ksft_exit_skip("unshare() error: unshare, errno %d\n", errno);
> +		} else {
> +			ksft_exit_fail_msg("unshare() error: unshare, errno %d\n", errno);
>   		}
> -		fprintf(stderr, "error: unshare, errno %d\n", errno);
> -		return 1;
>   	}
> +
>   	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
> -		fprintf(stderr, "error: mount '/', errno %d\n", errno);
> -		return 1;
> +		ksft_exit_fail_msg("mount() error: Root filesystem private mount: Fail %d\n", errno);
>   	}
>   
>   	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
>   	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
> -		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
> -		return 1;
> +		ksft_exit_fail_msg("mount() error: Mounting tmpfs on /tmp: Fail %d\n", errno);
>   	}
>   
>   	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 1, errno %d\n", errno);
> -		return 1;
> +		ksft_exit_fail_msg("openat() error: Open first temporary file: Fail %d\n", errno);
>   	}
> +
>   	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
> -		fprintf(stderr, "error: linkat, errno %d\n", errno);
> -		return 1;
> +		ksft_exit_fail_msg("linkat() error: Linking the temporary file: Fail %d\n", errno);
> +		/* Ensure fd is closed on failure */
> +		close(fd);
>   	}
>   	close(fd);
>   
>   	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 2, errno %d\n", errno);
> -		return 1;
> +		ksft_exit_fail_msg("openat() error: Opening the second temporary file: Fail %d\n", errno);
>   	}
>   
> +	ksft_test_result_pass("Test : Success\n");

There is no need to print success here.

> +	ksft_exit_pass();
>   	return 0;
>   }

thanks,
-- Shuah

