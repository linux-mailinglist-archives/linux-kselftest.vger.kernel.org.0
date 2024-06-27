Return-Path: <linux-kselftest+bounces-12877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A842391AF36
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606FE2825CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A519AD63;
	Thu, 27 Jun 2024 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/Z/TI4w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3276198A32
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513702; cv=none; b=bMVVu1myC39I36d9ldvhDa2y/AD7TDLVKBKuZPOBQ0VECm5FEn0O8RiGM8jJkkKikNNsBBJCyBhV+xx/5RXD/KAb5t3qFxHzg9Cef+4VaRlmdbY2gOupqjBmseNkoKcSgVAd/ujbCqUoh71rcRZNO2PNRCg/ju+fPmHw5p4or4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513702; c=relaxed/simple;
	bh=125TjForjEqo3vPkjAAt5+UZ3IBFofOTgy6dpGc67Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7dlKOUHUhPPX20lRqBheJFpZMZujprYETDw3y3nTo7HchDs29VlpnI4yFwb5SL2heme0Z3E/dCth1esL66wEf+OLYs0iSFHZEpFwB1hfZ8UiAFKVvZIuKJaFW4YywT+tVKyahIGlxhQkPKcZpxdGFe2aGZQcsahPzYHUeoZge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/Z/TI4w; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3762c172d94so3737035ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719513698; x=1720118498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBZrzd3l+QBB0qVF57NE+VuAbUtWDCM7+bdK0dPzz00=;
        b=f/Z/TI4wIdltGwSKSfbKe2Gsv+6dMwvL0M/xZ+ghUjTMcRiRcy3gdz9Pq6BA+IXpU5
         SSFPg3B6xnMNrXlMFXjJ/jzDcVLrfnzm4Y19LW99atwGakmzfD/dj1jgedghQfbz6Lbb
         6jlWomI088L/sHt0hDnCr+yWZXSNX07gAdtf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719513698; x=1720118498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBZrzd3l+QBB0qVF57NE+VuAbUtWDCM7+bdK0dPzz00=;
        b=EUm/7UediYdcLg53DUMGAzsBhio+TORJgaSXwcegO0U45TrnDcVS9cgo0JPjvV/Hwj
         DW3/k/8FXvb6+ufRsKjl1K7tLRyJbkhaRkvhy2OlVX7j6HbyfybB5QPbR9hoKusUL8jW
         q5UFeeeksSCF8jKA8qXVd1I3Tfeu4OMrLVn6zYk7rzMuG7NCaIPjIvoFi3UavzSUWiKd
         a+fMrYILqPnPDkqWTRDjLOCIaPaMhWLEp+Z/It6UZjsnLuVv2sLDUTnqXA27wfuzb/GM
         dgmTC9Ha0OCqPqtTcWUxzzdevuHx8vYdWknqjDdmNAll0T1ENAm+WTLT6/Xaa9XMTl0S
         BLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0UfCmnFHqk01QAlRMX81PtPhaP6gz5o4HScDqxSqg5xHLWZQf+9TUbjjdKxiWIW+o2Ih3cH0R0gL3WpMa/qqgwUSPgnLz5wSziaWYgKK3
X-Gm-Message-State: AOJu0YyUob9sIbdYudjy3elZpBxTNNiynxxDVys1FGg/FuS3i0Gppc1Y
	mp9Cv6knqG8W4lb5bgx58G66KJZmrtSIu42Ug5DrNXyjCjP42HfRD2jnqvqOMt/BjqaUO7n/Q1i
	m
X-Google-Smtp-Source: AGHT+IGlpypgBxWhaGGhaei1invqkWl/nU5w0Ksc4S6KUTcLPJ4fg2XtI2N2zdxQFFpO/N8qypPFWw==
X-Received: by 2002:a05:6e02:15ca:b0:376:4224:7611 with SMTP id e9e14a558f8ab-376422477a7mr156049795ab.3.1719513698699;
        Thu, 27 Jun 2024 11:41:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad4370d30sm272315ab.65.2024.06.27.11.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 11:41:37 -0700 (PDT)
Message-ID: <8facf491-3c4c-4efb-8a14-f34011ffe011@linuxfoundation.org>
Date: Thu, 27 Jun 2024 12:41:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/watchdog: convert the test output to KTAP
 format
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240506111359.224579-1-laura.nao@collabora.com>
 <20240506111359.224579-3-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240506111359.224579-3-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/24 05:13, Laura Nao wrote:
> Modify the script output to conform to the KTAP format standard. The

What is script here?

> number of tests executed is determined by the script arguments, and
> options such as -c, -f, -h, -i, and -p do not impact the total test
> count.
> 
> No functional change is intended.

There are functional changes - keep_alive() coupled with changes
tailored by a script that isn't in the kernel code which isn't
ideal.

Why not inlcude the script in this patch series to make it part
of the kernel?

> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   .../selftests/watchdog/watchdog-test.c        | 154 ++++++++++--------
>   1 file changed, 89 insertions(+), 65 deletions(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index 786cc5a26206..90f32de9e194 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -22,6 +22,7 @@
>   #include <sys/ioctl.h>
>   #include <linux/types.h>
>   #include <linux/watchdog.h>
> +#include "../kselftest.h"
>   
>   #define DEFAULT_PING_RATE	1
>   #define DEFAULT_PING_COUNT	5
> @@ -29,6 +30,7 @@
>   int fd;
>   const char v = 'V';
>   static const char sopts[] = "bdehp:c:st:Tn:NLf:i";
> +static const char topts[] = "bdeLn:Nst:T";
>   static const struct option lopts[] = {
>   	{"bootstatus",          no_argument, NULL, 'b'},
>   	{"disable",             no_argument, NULL, 'd'},
> @@ -52,7 +54,7 @@ static const struct option lopts[] = {
>    * the PC Watchdog card to reset its internal timer so it doesn't trigger
>    * a computer reset.
>    */
> -static void keep_alive(void)
> +static int keep_alive(void)
>   {
>   	int dummy;
>   	int ret;
> @@ -60,6 +62,8 @@ static void keep_alive(void)
>   	ret = ioctl(fd, WDIOC_KEEPALIVE, &dummy);
>   	if (!ret)
>   		printf(".");
> +
> +	return ret;
>   }

Are these changes driven by the script that isn't in the kernel code?
I don't want to see changes to keep_alive() bevator.

thanks,
-- Shuah


