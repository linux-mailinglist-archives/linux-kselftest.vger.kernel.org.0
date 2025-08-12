Return-Path: <linux-kselftest+bounces-38802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E8CB238CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 21:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8972A127B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327982D663D;
	Tue, 12 Aug 2025 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MKw5MZi3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7081E47AD
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026879; cv=none; b=Nxxh/XUuCy6kH6JVC/wIJmcdORUWW29sK7dlmzn/nSqfhUu01ZmP80r3PaIetExAzXTW5Js5Kfnlz5VBOwEB2FMZGEldJ+UmjQSTIyC7e3yom8phH6ELbzZd/WLaVWDU0d1G2Sv+myKVdnNJAiZ3Y0ACf4k55vlPopE6ljkeqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026879; c=relaxed/simple;
	bh=y0y2N5LIeyP8xsy0Qa63fgrKE/mH0tt08exbUT5h0jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9wATamclzkZ/F54gyXkYViDFe4xCAL3nXMFA8rM0VLzntq9e8yVtSVo6so0vIjcm9ZDUNR8ISqcwdUkhGiUusg1nQ41/gKEXUkOyocO4YDsiPAsiFIKzmdNIOpehx9Jl5PjEqTo2HtqU9v9l0WVAdrK+W5j22OGIxNqHhqzFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MKw5MZi3; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e54f4ca0dfso21215925ab.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755026876; x=1755631676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RNO+JaaEkY/OEdHDihqn21pputuGs/yjSpDhvuKLeI=;
        b=MKw5MZi3KtfJao50CyvdDDxaC1iTr9aQBbAxreZa5wqvXsnrufo+0bv785xkygUEKK
         MvxfAMbgbqRc6dKLUkOQCzN8cwqn3DJ2/4XwfqbhBLHaiJDsvEw1iF07CgXn0gAoBXdU
         cJRVZKvScZtLLZ/+moSJAQ1/ZTY7z17FUw7i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755026876; x=1755631676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RNO+JaaEkY/OEdHDihqn21pputuGs/yjSpDhvuKLeI=;
        b=UvtwAADbXEZtSWPAxFbo4byx/JtsebKrKWM1MR2P0abDOHaqvQyUKlCiFz3P231FAY
         9w+jaQKAieeEakc0hitOeDjxdo/46yHqy1jOQrsvh5cbbolQH/kMZ9a4FWBM52e4T/Hb
         xS47oEeP0SCEd4iQLWr0QkZAObpmHawPXHQAtRPsfhZeIwyEb0kX7Sp9eUuaMxAyN578
         FvyeiZRKjiYud7bSeIbVqD9TsChvPbCkItRArN1DCtvMUAYR5vKc6lvuohJxloYpYnrQ
         Lvo0Zm5i68rD4Jryk+pxeIj1bDunISHLJ40jTx7/Imr5u9emwcpkjk6YxG+NzbYViJIl
         6eiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXcmdxdoeBgUp9DIgFhF+56CzD6TAMNtE8G3A7Bxp0Z+vscrbaUSMbi8z2F9eaEsnLGbTo69sCQLq30rj12VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSUH1s0rg6TjStQbi1xwr0JH7I9aZNTNguvo7RxPREV26HhuP
	fpI0517kEv8CbXM0XM1S3EID+JiRYx5gkMuB+mW8T+zDDj3/6CLJBsLZpHEznuUmTPEobA1ypKY
	2pi2p
X-Gm-Gg: ASbGnctS3zNxKiXWr2/ubXigioQfOpbp/727sTmsEuNyC8S80nkfNVlhfXuTEJYvyiJ
	07LebpimYxoCrVU7ndOFTc85D0ou3Qepv+p0DdRvPVsHdtoe6a/jwgbhQUDQk/07SmHXQR7J6BR
	iyyWbMINUYRqFCvS8iNg4i5s15Hwh+69Me/JW4KiBLBpcdJ1/BaAuRc3QvgRNTa+MNmHXLgq4Gc
	w+HGiVW0z29GomqBvce6x1/kYI2xldGFXZJdqBQkUo3l1sBk/B52fErJoQ4BgJTqrd4tacOaFbC
	tpY68pWp/d2aEQui14uG4SkIXVFviCPxgvKXNeBN6PUDdIi8UBq1kR+D0oosBj9+SzvwiaONwca
	hxtJi8GnmyHxEijk3vuM4IQGvXW45fB7mGw==
X-Google-Smtp-Source: AGHT+IEUCGZnLw63tW0KNVTQOiNtoNzl7gbeEHojoAK0DgCBv29G2cLC+KWOONDi4CrPrrCxgtRIBw==
X-Received: by 2002:a05:6e02:2147:b0:3e5:3520:4a76 with SMTP id e9e14a558f8ab-3e5674e77f6mr4612365ab.24.1755026876188;
        Tue, 12 Aug 2025 12:27:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e546358251sm31477615ab.54.2025.08.12.12.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 12:27:55 -0700 (PDT)
Message-ID: <ba9f7752-ceb2-4fcd-acaa-b5afa77eecda@linuxfoundation.org>
Date: Tue, 12 Aug 2025 13:27:55 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog-test.c: Remove unused variable in main
To: bajing <bajing@cmss.chinamobile.com>, shuah@kernel.org
Cc: lizhijian@fujitsu.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812075345.872-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812075345.872-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 01:53, bajing wrote:
> Since $optind is not used in the subsequent code, the variable
> should be removed.
> 
> Signed-off-by: bajing <bajing@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index a1f506ba5578..837001a9e3a0 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -209,8 +209,6 @@ int main(int argc, char *argv[])
>   		exit(ret);
>   	}
>   
> -	optind = 0;

Removing the assignment soles based on looking at the subsequent
is incorrect.

Explain why this needs to be removed? Did you happen to check
getopt_long() and how it uses optind before making this change?

> -
>   	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
>   		switch (c) {
>   		case 'b':

thanks,
-- Shuah

