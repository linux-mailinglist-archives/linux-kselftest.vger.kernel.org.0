Return-Path: <linux-kselftest+bounces-12873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D66991AE0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 19:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE03E283365
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 17:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF91F19A295;
	Thu, 27 Jun 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LTDrlDZb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD74199225
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509395; cv=none; b=Fl8OopMkBONRYTyuuCPKVYI6n8inEBR2Y6yU0dhv5bxkoau/yCrHnzppDQIiHwa2u0cm/Sa8UZz0ITVCIooO1tzpi8f9Ovo8cm5MpLtIdXfm2ZiDvbmaAzAp9jDSHABMTEhVBHAcnZ5Ow1u9+PiV6sOq1+HHpmztA9gUNdIzCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509395; c=relaxed/simple;
	bh=zWsElhqpj4fMB+iLijGBpbu+QyUcM22M9Gs8UsyVQ+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfQ/mtnvqNzO23hy3djtQt2WkqWRwF0jM/D2PG1m+encsNuv42QTTWFfdOA3fVY+Md8BQqgq+DDiU+1jMrcxeK9G9wo9vQlOaxPWCQ7GjXbUHnMbQtLhnFks2I4HINEYcmr1apk9RXr1indtU/Zd2sBto0KyOOf3CF29ZDnWV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LTDrlDZb; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-37a80cb5c94so269685ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719509393; x=1720114193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TE7XfWBRNZhzVuyF1wDQxkJAMsIzL6P4kt13AjBK80I=;
        b=LTDrlDZbYAUGwe0++UQvffpkWM2BTpjWdp2i7Y/GzEdHk+EQUTT3lnv7hEwXE4OWI4
         br7xEs4erwWPXVaCBFZ1mD2MVFKf7bOtbhHi58HHLupWL/XxXfS/BF7LUhOvdj2Vy1uI
         htMGZBx0l15VJMLG1Er4xdEPcsSMDF3je2Xr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509393; x=1720114193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TE7XfWBRNZhzVuyF1wDQxkJAMsIzL6P4kt13AjBK80I=;
        b=RlXNuCAHCm9KlK6xFpUcweisn6YfdxkNQecSJimmz7glatsu2ORHLhidVk7VwqI8BA
         G3YHZ5Kbf4XUWc30Kqj7/Xg/jYjmVrtwToDPIPfmjw0F9gRjhrhUoKeUPWrB4f+gNyxx
         j72yHHuzcdm5q1ZuVUlbijnsCwVc/n8dHM9WbQyBA/aCrYTEUt3R6X7raAaUCUlxM7Sm
         Pg2X+wV94pgMvs1DL25t190bAThYqrC7tJmhmIN8ehToEXnqNmVbxrUpkOkl2dQ8mbCS
         zGoDF74cLf6L81AqoNkFRSlTVaUfifNMr6WdUwvU0o9qAo0q7SWVOxRjX29av7F3pEBw
         XJsQ==
X-Gm-Message-State: AOJu0YxD4DZAFooVYq4193Ssv33JvKD5JNgk5/MlQW+LQsuwHlP7+DvN
	rzX23zGIzdaRn/Jdx3oPGMhzdFTvyhqotAYVFn3RqdVbAWXFiCI3e/e+nA//xdc=
X-Google-Smtp-Source: AGHT+IGuv22TRRCkg0w93q8TXiGPUGSAq+F4m8yDrb26yLn3ifVMjUoHjcL8Je5l13wqAxyS4FmOOg==
X-Received: by 2002:a05:6e02:4b2:b0:379:2b4d:d5de with SMTP id e9e14a558f8ab-3792b4dd9cdmr38555345ab.2.1719509393382;
        Thu, 27 Jun 2024 10:29:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad4370c46sm10305ab.64.2024.06.27.10.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:29:53 -0700 (PDT)
Message-ID: <8b040e83-5eda-4b59-96a9-d76cb4f80d70@linuxfoundation.org>
Date: Thu, 27 Jun 2024 11:29:52 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/capabilities: Fix possible file leak in
 copy_fromat_to
To: Ma Ke <make24@iscas.ac.cn>, shuah@kernel.org, usama.anjum@collabora.com,
 swarupkotikalapudi@gmail.com, amer.shanawany@gmail.com, kees@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240627015732.2974078-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240627015732.2974078-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/24 19:57, Ma Ke wrote:
> The open() function returns -1 on error. openat() and open() initialize
> 'from' and 'to', and only 'from' validated with 'if' statement. If the
> initialization of variable 'to' fails, we should better check the value
> of 'to' and close 'from' to avoid possible file leak. Improve the checking
> of 'from' additionally.
> 
> Fixes: 32ae976ed3b5 ("selftests/capabilities: Add tests for capability evolution")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the patch according to suggestions;
> - found by customized static analysis tool.

Care to give more details on this customized static analysis
tool?

> ---
>   tools/testing/selftests/capabilities/test_execve.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
> index 47bad7ddc5bc..6406ab6aa1f5 100644
> --- a/tools/testing/selftests/capabilities/test_execve.c
> +++ b/tools/testing/selftests/capabilities/test_execve.c
> @@ -145,10 +145,14 @@ static void chdir_to_tmpfs(void)
>   static void copy_fromat_to(int fromfd, const char *fromname, const char *toname)
>   {
>   	int from = openat(fromfd, fromname, O_RDONLY);
> -	if (from == -1)
> +	if (from < 0)
>   		ksft_exit_fail_msg("open copy source - %s\n", strerror(errno));
>   
>   	int to = open(toname, O_CREAT | O_WRONLY | O_EXCL, 0700);
> +	if (to < 0) {
> +		close(from);
> +		ksft_exit_fail_msg("open copy destination - %s\n", strerror(errno));
> +	}
>   
>   	while (true) {
>   		char buf[4096];

thanks,
-- Shuah


