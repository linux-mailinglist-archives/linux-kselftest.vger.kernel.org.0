Return-Path: <linux-kselftest+bounces-16799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAEC9662E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3695B22A02
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 13:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FECA1ACDFD;
	Fri, 30 Aug 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MFu0Bp1v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F14152170
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024479; cv=none; b=tKm+Hm/UXbxLKAXupIU+j8yQQtWMlVg64wP1N0TlT0Xr/MjIT8PGESd0Vs2iWEO0IiiXeJjV22vrYXNam2vcAmhYSJM+p1alXA85NxKPXAciXSO+DwDIYWN1EZ/HgU2pwEv62TBsus455iW7We8VCDUYSxynz05YofKdOseoxh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024479; c=relaxed/simple;
	bh=p2wn1LNLdYfziJyiiWzFLiZ1Mse6IK/17b+3O1mznw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+f4gHUHXzLlqAtD43j8i//v86P8u5Fbi+waNVwQvvT0nIDeFHEjHbpJVplG9NR3wMvCfRkDNcOg15Alr0hHa9OmKQtUzBlhQ6/t7WxspjmDgd9cIeZXpoGgb4oQvF9lOb6jnOnc/YvJweKdKiIr1KZdvC570JrVgiPf2JuV8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MFu0Bp1v; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70cb1b959a6so1107936a34.3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 06:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725024477; x=1725629277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzO+G25f8saT1bkAkXCx9zRFYZu+Bejb/RnNLhu6+A0=;
        b=MFu0Bp1vppNVZJ33xA3Mw4ZxyDpitwESvs78VvBh0cHE/ac0VDes+AAbu5XaEjRWz0
         MBHPr6fsqwzz22JK5prUZd6FtnkMnnMn0fI5XURSb21RGSptnA8mx5VRC4D07g9nzPfs
         1Ti8LpfZit55kh5+NPVeN4POprtXy3HvJCnRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725024477; x=1725629277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzO+G25f8saT1bkAkXCx9zRFYZu+Bejb/RnNLhu6+A0=;
        b=PT+ksGL29ZQxrsVRbB4jWiJV3Lv0cqYSrkkDO5kYzhOMUBM1qLs3XAQWVXmRCxP+X+
         9Oofzbsx0mSKhJSVESFxVQgu145juUNxUX+Mwr/Wtd11RJC28yyAdDSftrroNqA7VTmv
         l+yvJSQkkoiqAIydJe7/DkWhTXC+rAKXfXMtsymNSUUkBtKa/BxBbYgvc4Plf5B+qbWd
         dmoZzNLAirm2YbgtktID/7Xt1f3GVtaZzgjfySEbCOft3UgZoM4mQgBcn1JG+ITzh/3+
         bwzXZWrnZHikIVja3jIdfyPxK18Ob2s974vGDiycGhlVEY5byGhDmV7RNTgkA9z1rP+P
         jhlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnm6GAx9cHLV8xK8rjzo1mCpyDpx8kOPYDnQbHHmUeI6W6DsRcA5IGTivnlpcQrGQ2a4UCrO1FqdaAAqSLa/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFPaddas0q8X1VnIbc2wjpZ+XEI+YNQPfQkMfH10xNbcPvnjj
	Y4XxHAU+VfG4UBWPwDeqTCbmyu5D8xaxz2eMHYUl8Gy+OwvyGh0mc5VEhwbfzMQ=
X-Google-Smtp-Source: AGHT+IH4Z4a4eNpdT6poNqlaMWEeHBVBQk0Fnx5t74ySm/SraCam6wS+xqO+N7CgMvBNJL63b68UJQ==
X-Received: by 2002:a05:6830:3c86:b0:709:4226:a61b with SMTP id 46e09a7af769-70f5c3973b9mr6402246a34.5.1725024476674;
        Fri, 30 Aug 2024 06:27:56 -0700 (PDT)
Received: from [172.19.248.149] ([205.220.129.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340dad4acsm14470176d6.132.2024.08.30.06.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 06:27:56 -0700 (PDT)
Message-ID: <e6027cfe-1a5e-424d-8ba8-f153d75b774e@linuxfoundation.org>
Date: Fri, 30 Aug 2024 07:27:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/arm64: Fix build warnings for ptrace
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 Catalin.Marinas@arm.com, will@kernel.org
Cc: broonie@kernel.org, ryan.roberts@arm.com, Anshuman.Khandual@arm.com,
 aneesh.kumar@kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240830052911.4040970-1-dev.jain@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240830052911.4040970-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 23:29, Dev Jain wrote:
> A "%s" is missing in ksft_exit_fail_msg(); instead, use the newly
> introduced ksft_exit_fail_perror().
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   tools/testing/selftests/arm64/abi/ptrace.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
> index e4fa507cbdd0..b51d21f78cf9 100644
> --- a/tools/testing/selftests/arm64/abi/ptrace.c
> +++ b/tools/testing/selftests/arm64/abi/ptrace.c
> @@ -163,10 +163,10 @@ static void test_hw_debug(pid_t child, int type, const char *type_name)
>   static int do_child(void)
>   {
>   	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
> -		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
> +		ksft_exit_fail_perror("PTRACE_TRACEME");
>   
>   	if (raise(SIGSTOP))
> -		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
> +		ksft_exit_fail_perror("raise(SIGSTOP)");
>   
>   	return EXIT_SUCCESS;
>   }

Thanks for doing this.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

