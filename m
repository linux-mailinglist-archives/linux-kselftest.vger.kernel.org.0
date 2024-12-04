Return-Path: <linux-kselftest+bounces-22844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E83319E484F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 00:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B826318803E9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 23:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4280E1A3AB9;
	Wed,  4 Dec 2024 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="El6aj0a4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42123918B
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353249; cv=none; b=nldgQKFhjnn3BkoA4ccgo4BxX42LDoNvWAbKS2Qcu7746C9F917o18G/RgRQlfXgYM419nn39lG6CqEy0mT/dw38XaBhSBhSxnUKAgKl0EK59WfidCGuQp6JTLjSrBqlyLmYgTZhLldkv5c1PP1fa5v/Vpg73DJLYAehCybnaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353249; c=relaxed/simple;
	bh=utYlGDElJuh7cwgqAPQiMQ/JryL/ykc++w0qj22g69Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfLAZFwiVi41S6qXYIXJJnmzM4Pczh5ASxh1gCF+z7Utr1MSETgAH5Q4RWWw3xQYFsj57TMPlelXV7dCD5SJkKYnmdalCECxFlsT7tOBngvwVjVTGtCEfXUTZL15MGPIVg0ZGPl5GiGDU7F90pm6pMuOmE3CcKx0JW8qjohHJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=El6aj0a4; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a7de25942bso752195ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2024 15:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733353246; x=1733958046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8MjONOCveuqKobe9hgyWba31JDPN2COa51czWRUjXQ=;
        b=El6aj0a4YWTO6Kabwotitl3GjBN5QszqBQ6SYS6i+Z+zPALrQyXdzgGf3mB3uYfTR9
         NeicOIcx1Qg4y/SxjONBmO6Dsen+TjiRKnTJb1BKcZ6thlMCfXJnkEj5TORmYaCoKeCy
         fbdnmtnK47QBxXi/9QJiEMZ5dHzg60bTs49eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733353246; x=1733958046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8MjONOCveuqKobe9hgyWba31JDPN2COa51czWRUjXQ=;
        b=OFVWNx6P9xbvHJktIZcKsQSAwC8dnw7f2HOHGuBJlbXDj6d3iKhTcJY0bttFWfoZmT
         qRE9WLraXXlHuPFPqnXkGYwUknJroRWF3AO7DiQq2iRg821QLEeQYrBk/oKm2ondKdth
         1yblRFJgohLYphaExDRR8bKY/eHmuzx8U6s4lZ35glATS3eE+NGB7m2JvarR2b8nd0So
         CtpI2lwf0hN/V+aTytQfOgZGjYsu9YFqNsYN8zb57nZhzTc01SjUe3xtfJCHTKkTbTEm
         DN5gI8pQ0D8ZY59JmGAf0MUGgCIa3l6CVmjmV8uqA3b8uleVXTzrjqSa/tXp2vrTq5Wl
         QvcQ==
X-Gm-Message-State: AOJu0YzmtbibhsDdU/SVVx7XSquJgAuTnrspJDXU1Kgf6lsuDGLQ7rRi
	a9XQzSg4apvAhugrjqfNwRTAbaEzDRZmIaWeGIumhPxUW8wZTKOH8vLwZx4qkTQ=
X-Gm-Gg: ASbGnctI29UiC/VOYX4qMA0ae/YUboRE0Q3LsTeMBTjZLp1vqYBk9DtIleKlNbuiAbb
	xDHzEFhcCBDwmSXKAHXKTlUoBm6o7IE1B9F+1rVDRMlFejlJJunBCGFf6O+wQPbTKkkVzxNCLUN
	xZZUgF4od9GzXro7s3jTkADgKwEMTCZEZ5amocmC5dAauno2Rtxleeipar/1gba3wt45Al6pV7S
	5euS+ceqmDCMKybktrmfGDrgYiNsgMJaThFOItPKAWYGzzZQwH6RFLY+fKzLw==
X-Google-Smtp-Source: AGHT+IFUgmhlOoSihcP/nqxkjyWw10Hk/UBc2m9j6X81IuSx2AXGwM+0j3uEXoKmJvc8OaldrCUQ/w==
X-Received: by 2002:a05:6e02:164f:b0:3a6:ac4e:264a with SMTP id e9e14a558f8ab-3a7f9a46431mr98377155ab.10.1733353245600;
        Wed, 04 Dec 2024 15:00:45 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e28611b614sm35076173.38.2024.12.04.15.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 15:00:45 -0800 (PST)
Message-ID: <f0fc34fa-d208-4bd2-8e0d-bfba60b06b90@linuxfoundation.org>
Date: Wed, 4 Dec 2024 16:00:44 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: prctl: Fix resource leaks
To: liujing <liujing@cmss.chinamobile.com>, shuah@kernel.org,
 osmtendev@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241128061827.4165-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241128061827.4165-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 23:18, liujing wrote:
> After using the fopen function successfully, you need to call
> fclose to close the file before finally returning.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
> index 562f707ba771..7be7afff0cd2 100644
> --- a/tools/testing/selftests/prctl/set-process-name.c
> +++ b/tools/testing/selftests/prctl/set-process-name.c
> @@ -66,9 +66,12 @@ int check_name(void)
>   		return -EIO;
>   
>   	fscanf(fptr, "%s", output);
> -	if (ferror(fptr))
> +	if (ferror(fptr)) {
> +		fclose(fptr);
>   		return -EIO;
> +	}
>   
> +	fclose(fptr);
>   	int res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
>   
>   	if (res < 0)

How did you find this problem? This file will be closed when
the test exits - do you need this fclose()?

thanks,
-- Shuah

