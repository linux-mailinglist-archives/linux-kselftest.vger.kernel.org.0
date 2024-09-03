Return-Path: <linux-kselftest+bounces-17075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307B996ABC3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 00:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE5EB261D5
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 22:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DBC1D9D77;
	Tue,  3 Sep 2024 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QABMHt+J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755741D9D74
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Sep 2024 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401277; cv=none; b=sJlcJfpEweuWE/Gop/Z80C75mp6V2H9195UTFbH8rVNy4QNGGn17ojnQbBYH0WP1UcIYotS58MDhjGXja1gDonWJ579mKlMnI202QolMEF8kIjXbHNlgpLJmf7F+kCHCxle1bCYyij06toQhKixvdZtneC0+dFBcsy0Z1h9Xvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401277; c=relaxed/simple;
	bh=IYU3OAd/bz3G+NVs5Qp6S1RQ33GKRTp+vDtFwpIA22s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzNiWz5ewh3roDp6BrAZoXNcwEA88ZwCUf3YpDrU7Ce7JWvugT2iLYPeiyPg3jkKSpMD9UuRgNMc0dfMDRQeNZa2HCjDuxUj2MrPbiSwczKHqzpKfa+llGgZKyZH7ji9WB9BrxloiDNVPye8PY2tg/c0Sj5gAQQGfbLFl8IP5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QABMHt+J; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82a3096ae9aso200761739f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Sep 2024 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725401274; x=1726006074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFRdhI2LkJxHnaOi7l8tehye5GVUcctO8UI43httEcw=;
        b=QABMHt+JiO0WHtj9M+u6YPCwuhDVmFkcixYyqRgNODjR0G6EP6pBCj09Jo7+/OmviJ
         hPLbKwBg0l6APfZwp0l0XcrZeHPGnnQvonbT3WQo70VDsTtRgU4hAGM4fhj+ZVkI3Vcq
         x9WT38hvcBnYXEGf5IzMYGx9o1uSr9iLI6oyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401274; x=1726006074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFRdhI2LkJxHnaOi7l8tehye5GVUcctO8UI43httEcw=;
        b=jAGClW48LGYJP2hakJpFoqciDvicCFywIga8kthLG/mebswLUE4TSOSnEdyycqSZE3
         8gUotApcdP7/yexhnBPBySzhidwXcfqph/qW5LzCo4eHw6E7tmmqKWqCh0xRaVkgfhs/
         GJD7Yjfmb3rESWNdh0ihAph9zLlC7Sv/X+isnOqHqnY6sAS0uiGGOdcJJaw2RkNkp6fC
         a0N3cNqQRTzPO3jbxFiau59Svf743ICe5y9OtK5az9YNRcW+K2qALeaeA176WMf7+iJx
         ZWxgQSTxribGA+whXvLbKa7uGUPvt8ieoKB1VyTPNEhfQHFxYiP9uhdZhSEg8JX87MsJ
         L73A==
X-Forwarded-Encrypted: i=1; AJvYcCUc7T3Uwm1M9DMvGgPlfkxO2Tkx6pu0D2ZgezrFlMmUQ4dzvlLHDSl14K6a7nhLesyOF1CGgb8Ar6EzW998Ksk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NRugrUl1PMV9shWWM02AMBxy/I3SIpm62IEOjrxE3SYcOnRY
	bjgN1F6BbfYFQDas7xtMsIEJjdqPcIvkzQL8ZnDiN0miPm2qtmUhGs0FFk2/sMc=
X-Google-Smtp-Source: AGHT+IFTQtThwwC/leZotSmM5t8ciwjzBTdIC6A534twT5TmyUqI2imfLa17eQgS5pJZFaROgPGUNw==
X-Received: by 2002:a05:6602:2ccc:b0:829:e6c5:cb0b with SMTP id ca18e2360f4ac-82a5ed0d2ffmr569688739f.13.1725401274391;
        Tue, 03 Sep 2024 15:07:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a2f0d9fsm328832439f.7.2024.09.03.15.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 15:07:54 -0700 (PDT)
Message-ID: <52a6d4ab-99a4-46b3-bd43-58054602d86b@linuxfoundation.org>
Date: Tue, 3 Sep 2024 16:07:53 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: splice: Add usage() to splice_read.c
To: Rong Tao <rtoax@foxmail.com>, shuah@kernel.org
Cc: rongtao@cestc.cn,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <tencent_0AEA8FB622DE1A740841643D5F36ABF8BD0A@qq.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <tencent_0AEA8FB622DE1A740841643D5F36ABF8BD0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 23:14, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Give the programmer more help information to inform the program on how to
> use it.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>   tools/testing/selftests/splice/splice_read.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/splice/splice_read.c b/tools/testing/selftests/splice/splice_read.c
> index 46dae6a25cfb..73a8bc146f97 100644
> --- a/tools/testing/selftests/splice/splice_read.c
> +++ b/tools/testing/selftests/splice/splice_read.c
> @@ -9,6 +9,12 @@
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   
> +void usage(const char *prog)
> +{
> +	fprintf(stderr, "Usage: %s INPUT [BYTES]\n", prog);
> +	fprintf(stderr, "       %s /etc/os-release | cat\n", prog);

How does replacing %s INPUT [BYTES]\n", prog with /etc/os-release | cat\n" do?
Also what happens on distros that don't have os-release file?

> +}
> +
>   int main(int argc, char *argv[])
>   {
>   	int fd;
> @@ -16,7 +22,7 @@ int main(int argc, char *argv[])
>   	ssize_t spliced;
>   
>   	if (argc < 2) {
> -		fprintf(stderr, "Usage: %s INPUT [BYTES]\n", argv[0]);
> +		usage(argv[0]);
>   		return EXIT_FAILURE;
>   	}
>   
> @@ -49,6 +55,7 @@ int main(int argc, char *argv[])
>   		      size, SPLICE_F_MOVE);
>   	if (spliced < 0) {
>   		perror("splice");
> +		usage(argv[0]);
>   		return EXIT_FAILURE;
>   	}
>   

I don't understand how this change helps user.

thanks,
-- Shuah

