Return-Path: <linux-kselftest+bounces-14182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64593B80C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 22:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2311C214AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 20:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB591130A58;
	Wed, 24 Jul 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DXRD21sY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5B136658
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853151; cv=none; b=iYXODohf6JfrP/jvXgp7C9HpGGnpfXWKOgFQ03OOHIG4/ACL9iBG/pVhqEDOxeNF0PBJZ2KTOZ4vuLe1uqamb8CjWiIbt8ieWAac5+2IBmHwMNMhK5mzWsb9jjnMXn4vC0099aP5SuPBclWNHoCc9KRwYhj4yBu0ZpzVPfyGvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853151; c=relaxed/simple;
	bh=N7tzuBatwvbK0zk6wfxUl2xqOQ/0ckqDXNdjnTzy7rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3SgXO+3xhweFYIvBMYQb2Xvx6+ObL9COP9f8ZbtoMZW36uV9iep6Fi/tXVUivngFF9Qwt+xJPdjeg/eMBVQHc/7t58FOXS3WgoWOguLEYdPpCnziQWWTXNDveaCnu2ERO7eHpzsS3yUjNYcbuR1XGCts3u1KbUuXBQnxv3UrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DXRD21sY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-72703dd2b86so27161a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721853148; x=1722457948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfRUOZyU0ZZeZz6fU57bDtE2iUjP+Q9MDjhZaXIO9S8=;
        b=DXRD21sYe0f/v6q+9NcnK6W58g/FnqXUKsJb+qil6aY92iqovQqKUi2w3h1FRIcCcz
         ZrfvUqF9rjX6HmHqtBmSQ8Ke40Pu1P9YrmvVBqAc4E5z+DRCZ6oOwiWtwj2LVCWbIx5y
         qWa7Byx5BfXayNZVdhA2JAOyLoUr0YXaG5sIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853148; x=1722457948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfRUOZyU0ZZeZz6fU57bDtE2iUjP+Q9MDjhZaXIO9S8=;
        b=RaX9OPEDmm9dN9TfNP45BjFjqOcIrrgNay9YU9viqeurpjD77D6dKsl7a5+0VDTWdW
         fNXlf2e5Z9xojtKjYV987tlmWJcaefcNRMsJEGTJn6dlz1SAYEe8P4akEH6TsYwk7FVf
         Y/bpnv2f537ZeNnAiv3lHd2UHrMPLx88RuAOW3bCTFHxJzNvErgKGTDhEYe+dZkROi5F
         R1skVgXHB16OV1FdfGYnEdpJ68cCUqYEezKb3myPJOIvxEGC8v6QsI4k2Qd8GXadJruT
         0SA5/Nx6c4/gkETqpWQcYcWbyuJqTQehA2Sv2kygwyfCjl32sFAB8FsgjjQU7NbMvYDj
         LbFw==
X-Forwarded-Encrypted: i=1; AJvYcCVBSpPZbjtZC+bwY01k0ZCG5PkJsN58Ic/pHlyXJKjEL7wWTdSGijybxFDf8EOEd4Rb+qA4aQwml+DKLCKAF+iCI4Qx0rhh3lZwsOKqKmAz
X-Gm-Message-State: AOJu0Yx+9QMF3NFWWJVfs9xm6gSXd4PXrtG7Iw8H7ncUy8uJLHiBV+Bh
	jZGg9ebTlelPQAFHwQfuOfJgpEQRRH6iOaR32e2UE5MaoHCAmmf6mU79YpQzkiU=
X-Google-Smtp-Source: AGHT+IGCLZQwtPr52EaaK/1NDYoQBJLK4J6naJ4aMGWh77k+3IqF5nWwdqZBk6aLPMYn9FKHeej9Sw==
X-Received: by 2002:a05:6a00:8598:b0:70d:18e1:441d with SMTP id d2e1a72fcca58-70eac7b28b2mr224470b3a.0.1721853148048;
        Wed, 24 Jul 2024 13:32:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2208ce12sm6082637b3a.174.2024.07.24.13.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 13:32:27 -0700 (PDT)
Message-ID: <d7601a03-ba82-4a7e-bdd8-6cc23dec812c@linuxfoundation.org>
Date: Wed, 24 Jul 2024 14:32:26 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests:Fix printf format string in
 kselftest_harness.h
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, zhang.lyra@gmail.com
Cc: shuah@kernel.org, kees@kernel.org, luto@amacapital.net, wad@chromium.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240724062624.5157-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240724062624.5157-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/24 00:26, Zhu Jun wrote:
> '%u' in format string requires 'unsigned int' in __wait_for_test()
> but the argument type is 'signed int' that this problem was discovered
> by reading code.use macro WTERMSIG like those above usage to
> fix the wrong format specifier.
> 

Now the commit summary doesn't match the change you are making.
Also WTERMSIG() is incorrect for this conditional code path.
See comments below in the code path.

I would leave the v2 code intact. How are you testing this change?
Please include the details in the change log.

Reformat the message to too imperative mood.


Check Documentation/process/submitting-patches.rst for details
on how to write commit messages.

> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> Changes
> v1->v2:
> 	modify commit info add how to find the problem in the log
> v2->v3:
> 	Seems this can use macro WTERMSIG like those above usage, rather than
> 	changing the print format.
> 
>   tools/testing/selftests/kselftest_harness.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index dbbbcc6c04ee..f41f4435e9a4 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -1086,7 +1086,7 @@ void __wait_for_test(struct __test_metadata *t)
>   		fprintf(TH_LOG_STREAM,
>   			"# %s: Test ended in some other way [%d]\n",>   			t->name,
> -			status);
> +			WTERMSIG(status));

WTERMSIG() is not the correct call to use since it is not a
WIFSIGNALED conditional.

thanks,
-- Shuah


