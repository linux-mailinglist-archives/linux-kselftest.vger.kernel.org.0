Return-Path: <linux-kselftest+bounces-14560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC894351B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 19:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784AD1F22FBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE2F38F83;
	Wed, 31 Jul 2024 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fky8v2DZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC9200CD
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447853; cv=none; b=WiyCqAHRUENb6BMv48QZSSkR/JoNr0ihjBVR3XqS9aiK5Ija4rN0f58CqipEOJ9dIqLHhxP6unTx8jEup7yJKPS9tYSOcwDb5zaTDa6Pw6TydRwL2nzAcB5XLK9wVS6cYSxHhrD+W7syXwe5MNtP1eDRyetIp4JD206ZwIXAx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447853; c=relaxed/simple;
	bh=8kj4IaTGSnIoJ73AMoeqJoBXV3s476EBHK5JcoCuOf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/Oik2XgFE4lsduZT44MG+L5+G7sNPlA+bCr/lzXPn7yB4aFCJuLTJF5pNy8hStK8w9HJUwK+1eQ+XVpFInBnSvtLRP31FFzxMtWoxGxIfaAmu5MKsS9HfUSZtIJiGORQniJJMAJqxi4Hphs9JfXQB9LqKp6uECRz5bgdKVzJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fky8v2DZ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f86cebca3so37029839f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722447851; x=1723052651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6lecl9114nb1aO1eoXo+LK+IzPR8aY11XXCBjTQO6o=;
        b=fky8v2DZK0Dq/j9SVV97FaZze8JItkKN95HhMo1XvfrbZa83oKK5h648MhRvFrxviH
         xSwv7bxNgvKFQySXcZ01b7qejnd8xswHGQZfhJk8qM06QWzcIy4ok0VWZwli4vPiswC2
         dVOMu6roG97WEM0PXKDP9AYX527Z0A2oXSnAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722447851; x=1723052651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6lecl9114nb1aO1eoXo+LK+IzPR8aY11XXCBjTQO6o=;
        b=e6nmKGaA9dnKS5HkrUE+xbn6Jjjtz1B56eNhL72chErEm+u4KhO4vXXFY/wy1uv0dE
         jo1yQI7WcuZfjDov6K54ZZ4mOx7uwZAXPwAm7DTYRLQGiHtjrX6NnraoaV1r81ilcHJL
         qsiL12D+VggDfjHVEFAmc5KHoG2ltpT165bdt9pOAnMvgSnDF4AZ5davOTE17jHH2yNi
         WKs63Dj/Kp7jFoAXPtkeGXwZqyptIbQ11RlBRY6tHN+sgHsDAfMuBO7ZISLFPtI4MUdW
         GCFDDecYtXcPZH933VwNsHKudlmdJxznbuDe9yk/G23cy4uj/GY5hTCfCccyL57VJsM0
         YKqw==
X-Forwarded-Encrypted: i=1; AJvYcCUT0RrS1ofWflcmaUdblDaGMY9s1QedNtm3r7SHiKQZj8u+WwGbHs9CZ83KBkrR5qleoeLwsw4GayjAG3eU/q6lGoEzJh6N+ztcUVAdhoGg
X-Gm-Message-State: AOJu0Yzai/3QagxCIuylNY9heiaqoN6XQgHX1D5cwzbp4oHSSFTKc8TR
	L7x+v9ktw9oezXSWqNrkjFy7kKh+SfKtvyAbnXllvuYmbi+O9V63lDrNPQbsRwE=
X-Google-Smtp-Source: AGHT+IEApGy1keF/uYZ5p9Ukh/OxeXMECiYTn6y9QEOut1KFWNxFshaLHNDidYV4n+Wbi5Z+5sQw8Q==
X-Received: by 2002:a5e:c74a:0:b0:81f:8cd4:2015 with SMTP id ca18e2360f4ac-81fcc1598b7mr2618739f.2.1722447851158;
        Wed, 31 Jul 2024 10:44:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fbd9e64sm3331066173.107.2024.07.31.10.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 10:44:10 -0700 (PDT)
Message-ID: <71f31fb9-2ef4-4bbf-99fd-83e30d6e9422@linuxfoundation.org>
Date: Wed, 31 Jul 2024 11:44:10 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/exec: Fix grammar in an error message.
To: Chang Yu <marcus.yu.56@gmail.com>, ebiederm@xmission.com
Cc: kees@kernel.org, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 chang.yu.56@protonmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <ZqCBSPFfMeghhRGQ@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZqCBSPFfMeghhRGQ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 22:21, Chang Yu wrote:
> Replace "not ... nor" in the error message with "neither ... nor".
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
>   tools/testing/selftests/exec/execveat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
> index 6418ded40bdd..071e03532cba 100644
> --- a/tools/testing/selftests/exec/execveat.c
> +++ b/tools/testing/selftests/exec/execveat.c
> @@ -117,7 +117,7 @@ static int check_execveat_invoked_rc(int fd, const char *path, int flags,
>   	}
>   	if ((WEXITSTATUS(status) != expected_rc) &&
>   	    (WEXITSTATUS(status) != expected_rc2)) {
> -		ksft_print_msg("child %d exited with %d not %d nor %d\n",
> +		ksft_print_msg("child %d exited with %d neither %d nor %d\n",
>   			       child, WEXITSTATUS(status), expected_rc,
>   			       expected_rc2);
>   		ksft_test_result_fail("%s\n", test_name);


Applied to linux-kselftest next for Linux 6.12-rc1

thanks,
-- Shuah

