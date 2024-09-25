Return-Path: <linux-kselftest+bounces-18356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EBC986412
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 17:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E7BB36F6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD6E1A702;
	Wed, 25 Sep 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iijq9vdQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2438FA6
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277196; cv=none; b=lfEyZOBBECrYDRJAq59xioU/Y2u8Cr4sdCNLxmxDAb510LNfEIDYj/iWcuXzB/9Uqdpek5Vy1g6F8vCWL5tkF9UBB5SvpIOhp5IIHeKEFAcgRwIabjs1QNRREZzBp0JZ6wMl/8RcI+K2tJ7+T4LVkBSLVaZ4AvqyADCKiYJRlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277196; c=relaxed/simple;
	bh=orysemYIOAAOVmrSgXc7YbMIId2a4I9QLWaG6kwa1MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9xExcjpLj76BZSIlX3lAixN2yMmW4fz/2bN6vd0stNSDM6o7qzC87BZXj6jVetFoOq99ROcoR3ELA8kAJLLUhLZ57mfGOgSbyCelV2V1h5rH0/JLEOnozmFkB30oTVYyc/RLqKlEICzFPRbXT+Xm+dOJwGBZkG/D2PC3kUq6Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iijq9vdQ; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a1a4870713so7974915ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 08:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727277194; x=1727881994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeDepfrVJjJS1L25dHRrhNZeV7uLqen0lw2mzfoTy1U=;
        b=iijq9vdQvHavrU7hGstFuCbmExaBuLKBWr+blnCUK+Ow5i1Tuo3Mi4x8eNXiLhhG5e
         gYwsKsa5LrdEztGSL0TNFMHtKH/2oB15GGcI8f/mAsA4xFFtJtgYq+TXWIFzoC08WEHV
         Xg+bh0Yf5qc7bnuS+soKe7ipsh4hlsMCMOM+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727277194; x=1727881994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeDepfrVJjJS1L25dHRrhNZeV7uLqen0lw2mzfoTy1U=;
        b=dA2xr6/ubUI/0bNVqcD3Qp0cgo/of+TElFtnhbhVcjD1FEHgg4wHR4xsU0wqqqa7J0
         TqzuI7v1aYUVs8JZB9Zu9oAq1SGM5vEPhQr/HT05gYVj65oUQCAiDKRPRIf5/MR6QUjL
         Ix2md6YuMhlYs1T51uDpRyOVrba3DJFGP/9WmPXX4nPXEbcgzMh3JgAvboG6oWXr7z5q
         dkREcaT5YFsvjoTvhtq7is37nR2yCkXlMS0/vAZiZvlZHQ0Eegb0CBGE0XmfO+lmHYN4
         tf78eGZaMJsKFk043FCtXWAI+AtAGh0bZ2RN0qWToVmIt6v2MoNUNlDkDPRdLVBNUtm+
         ti0w==
X-Forwarded-Encrypted: i=1; AJvYcCXynwN0IjlxKBKXgA1bGa+QiCbxY3kTpeUYc6OD8rjOtgYx27y5cVvuyXE57HQiOeXqys6Ep8kUe2fzY2Ph/iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqMulIHwQklnjVcyzgTP1mKM7vymaQsydyWl6mTvsMvgqTNRM8
	Jluos2TJPux/H4+uHX2/gWpOyzKFxrmwh+T//pThmiAA/nsSG8Z6hOGrvvXmDQk=
X-Google-Smtp-Source: AGHT+IExjTKCbzt3SJ+TM0c/1itzBbHKZtRJG/mDo+qsHf6ISOkO2mVQLVf5/Yg9HENFYHgYMbPTKQ==
X-Received: by 2002:a05:6e02:160f:b0:3a0:ac0d:22b9 with SMTP id e9e14a558f8ab-3a26d745c5emr36059565ab.6.1727277193698;
        Wed, 25 Sep 2024 08:13:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a57247a5sm11239805ab.72.2024.09.25.08.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 08:13:13 -0700 (PDT)
Message-ID: <07999b46-ec31-4284-8869-1ecbdc0c7104@linuxfoundation.org>
Date: Wed, 25 Sep 2024 09:13:12 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests:timers: posix_timers: Fix
 warn_unused_result in __fatal_error()
To: jstultz@google.com
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 tglx@linutronix.de, shuah@kernel.org, sboyd@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1727191485.git.skhan@linuxfoundation.org>
 <4f3a0acd903aeee52fb71acaec1106d513a2e88b.1727191485.git.skhan@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4f3a0acd903aeee52fb71acaec1106d513a2e88b.1727191485.git.skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/24 09:56, Shuah Khan wrote:
> __fatal_error routine doesn't check strerror_r() return value,
> which results in the following compile time warning:
> 
> posix_timers.c: In function ‘__fatal_error’:
> posix_timers.c:31:9: warning: ignoring return value of ‘strerror_r’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>     31 |         strerror_r(errno, buf, sizeof(buf));
> 
> Fix this by adding a check for return value and error handling appropriate
> for the GNU-specific strerror_r() in use in __fatal_error(). Check if
> return string is null and handle accordingly.
> 
>  From Linux strerror_r() manual page:
> 
> "The GNU-specific strerror_r() returns a pointer to a string containing
> the error message. This may be either a pointer to a string that the
> function stores in buf, or a pointer to some (immutable) static string
> (in which case buf is unused). If the function stores a string in buf,
> then at most buflen bytes are stored (the string may be truncated if
> buflen is too small and errnum is unknown). The string always includes
> a terminating null byte."
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/testing/selftests/timers/posix_timers.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
> index 16bd49492efa..ddb1cebc844e 100644
> --- a/tools/testing/selftests/timers/posix_timers.c
> +++ b/tools/testing/selftests/timers/posix_timers.c
> @@ -26,13 +26,17 @@
>   static void __fatal_error(const char *test, const char *name, const char *what)
>   {
>   	char buf[64];
> +	char *ret_str = NULL;
>   
> -	strerror_r(errno, buf, sizeof(buf));
> +	ret_str = strerror_r(errno, buf, sizeof(buf));
>   
> -	if (name && strlen(name))
> -		ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, buf);
> +	if (name && strlen(name) && ret_str)
> +		ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, ret_str);
> +	else if (ret_str)
> +		ksft_exit_fail_msg("%s %s %s\n", test, what, ret_str);
>   	else
> -		ksft_exit_fail_msg("%s %s %s\n", test, what, buf);
> +		ksft_exit_fail_msg("%s %s\n", test, what);
> +
>   }
>   
>   #define fatal_error(name, what)	__fatal_error(__func__, name, what)

Any comments on this patch John?

thanks,
-- Shuah

