Return-Path: <linux-kselftest+bounces-5099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3C85CCAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91921C2179B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2361384;
	Wed, 21 Feb 2024 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bdJIQrr5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534BF1FA2
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708475077; cv=none; b=T+KWCuQim/YMRpkvjpcmpsUS3Tbc3bHt1AXEom5oAvF2Px21pgjeWvPpLcbhHeQJziffE/u2rLqkMfsDxr8NM/1iE8iI+U7wLZXRjhtw8b7fCtuLCMtbb3X+hUkjhdkc0RcPLM2USqXZTMIiHY9MiEZDwYzNSZRharcNThg9jcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708475077; c=relaxed/simple;
	bh=zsiqJVD8oee1LKgxlDnHQs9RnisiRpL2ecY5NmMQxOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCIwodDNajSw52CKfR3fgQj67E8pZOEf83X0POO41ov9Vfv9Ynlg2EEYMDEfPhdua7QuXB26FzF6Ij1YMK5ZZFS+/NgYVqdyKIg9BOL5HjtEeymwm1nlzR0KoqfyuwsP0NUPETJZfn7M/UWgn6Qq4hY2c38EkJhdCKucIP69JC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bdJIQrr5; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-365306a6455so2720935ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 16:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708475075; x=1709079875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOLRAEsEthL2VkcOa5sVWiNqOGf453ZXNU0bFPj6SWs=;
        b=bdJIQrr5yR0VtuRNOGu3RlXAI0YFw2K0YKF/2JH1slb0K6b7i/HBf2LigUvdICJlWb
         ZgHi1PogfebfF6Ooc8YQy13rbtZl3kf/WJp6+UQRattiaOnxKsJxeSVDF2/O8ORv0Qou
         xoX7lI/0jn8Zwa2mz/EgUY511hPEV/3aEZa74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708475075; x=1709079875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOLRAEsEthL2VkcOa5sVWiNqOGf453ZXNU0bFPj6SWs=;
        b=i8ID5z/dyGr2ZHLbLVP0iI5PQLn9cWX1I0Km9AxKB2arqU0HnDsqlGh+5uwC9WDef0
         lGQPSrpU2TFLObaERvBNapiryyTWkIpK/msJOEefrbVmlv7a6J7ui82Mg9MqfCsi7kqE
         3luKzUoeOR6rB1RsZcwecBu9ZaCUhpmL34FMy+ZkFXZCxZoZDl5xyNf8rSShEY7hG7wE
         gSztEyB1BbvJdZTLkgwmqK43xV3UvJe0KSZHPLDKL+zVxa07lGuf/Ln6G1wmgEiIYtu0
         Ef5YvdKmdMJRLVrTRav0/dcjVtP2OqU4YwCePPPOMFOtlnmb5VCyidIY60XC2RAsWpNx
         OMJw==
X-Forwarded-Encrypted: i=1; AJvYcCWFjT8z0diSDhHQp5713md3SN08DQrVZrA2kMZmYLf9CxDVByfXAeY2V7FNxw9j1cSN+rjyRuGsaTBGBj/SlAjkwCYc3NNrR1k6UZ8h5bLm
X-Gm-Message-State: AOJu0Yw8VRRddNxK76sPWhkaaiMMG5Nw8ZCicsYX9LqFB1BqMCUiJvNl
	rLDZgaqDM0wCcIW5xStgbdb4Q/zKpZpbfAFfHdcjNlYXhJZQobf6fxU+eQnlGos=
X-Google-Smtp-Source: AGHT+IElgvmFms2RUxC0f+WggghxFIAH9xb37cmGwTuvln1obru77PAXe5n3hv/3FSNOhGNNjOkskA==
X-Received: by 2002:a6b:c844:0:b0:7c7:224e:ae90 with SMTP id y65-20020a6bc844000000b007c7224eae90mr12520260iof.0.1708475075513;
        Tue, 20 Feb 2024 16:24:35 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u25-20020a02cb99000000b0047158a50c8csm2402736jap.133.2024.02.20.16.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 16:24:35 -0800 (PST)
Message-ID: <ab3e1d41-f3e7-406c-8de5-426bcd2ba602@linuxfoundation.org>
Date: Tue, 20 Feb 2024 17:24:34 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] selftests: sched: Fix spelling mistake "hiearchy"
 -> "hierarchy"
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240220092323.2677156-1-colin.i.king@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240220092323.2677156-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 02:23, Colin Ian King wrote:
> There is a spelling mistake in a printed message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   tools/testing/selftests/sched/cs_prctl_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
> index 7ba057154343..62fba7356af2 100644
> --- a/tools/testing/selftests/sched/cs_prctl_test.c
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
> @@ -276,7 +276,7 @@ int main(int argc, char *argv[])
>   	if (setpgid(0, 0) != 0)
>   		handle_error("process group");
>   
> -	printf("\n## Create a thread/process/process group hiearchy\n");
> +	printf("\n## Create a thread/process/process group hierarchy\n");
>   	create_processes(num_processes, num_threads, procs);
>   	need_cleanup = 1;
>   	disp_processes(num_processes, procs);

Applied to linux-kselftest next for Linux 6.9-rc1

thanks,
-- Shuah

