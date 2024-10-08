Return-Path: <linux-kselftest+bounces-19265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DBF995973
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 23:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF4E1F24667
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 21:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA341E0E11;
	Tue,  8 Oct 2024 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bUkvS+aX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ABF185923
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424237; cv=none; b=Vtmh95TYM5SbEUjuFj/s2ADjZi3hlaeQ37t+JxMkJmdECw0/hIjHofrnCBttQUpGX9DI9G74qlFuoF3kov1U86qVwCBS88wEyDbzjf21barrBK1mEnFh/wQH5c5g8cVmU8Dno/51qO1kO3sQ2Y7qTWvB7zFYsvqOWAlSBquJx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424237; c=relaxed/simple;
	bh=Iqje6EWpPEn8D42gRQnfAepziD04Y5SoxxzHbH/QF6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpzYGarw05qT3F32lBr7XJmU4CHBH7ipT1xPbEA7Qw5vyZCyRRbbO9x0NgGy3uqMrBWgbeh7/t0jRYTcYAeIA1PCxpabLojxp+OfoPvJYlVBKzm0jXL7ywWUGXjffpJlUuC6GAscykseFUWSUl/UH/fPVBn/MQBeTmMU9xkGt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bUkvS+aX; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a367da1f8cso21020155ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728424235; x=1729029035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4kIYoVybwY5oCfCX6nUbuZCgO9vStiTi85PSAC7K80=;
        b=bUkvS+aX7m1xeimPuMsyta7hkDBQ6C6RzhIrginZfT4BqQIHTtYzM6BeSX0SmmjVQk
         eOYZFp+5k9OztigGbXiGJsNUq5HFLWAtp2AWPnI4Cv5bmDoC2c8VJjeE+hGBCl0rqUiP
         WF0FCFO1Dyw3Peo2QesX4gi5XWflo00Q2nAVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424235; x=1729029035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4kIYoVybwY5oCfCX6nUbuZCgO9vStiTi85PSAC7K80=;
        b=QLqZzNvyisTDQ01cPdcak4GTf8ba0qE4u5Mq2fNNT7dAuWog4jTRTs/QcWwLdrJF5Z
         GEP87KzKv8Nzrn46K0lrXALShAfDDP1bJ3uaa+qRBSQaYam9G9hgAJgnhPeGIYIEvQTi
         Y4+sqm1UMZVxThKRUkmSSe2sBuTAw6UVUtHCpk8d38vAv8J9KphcDgCuR5Xlz9SFr4Ba
         f09Rn6cisfF3sOK3Ud2LlPxGcm7tdBW2JOAJEpdMi/9mGreICmcDMJp6xKtXXMOg7ekl
         ue0nsggl3NL6SOW5Vv3nkc9sA76GTY205i4hRGfjfJOdxDTmmMaxGs7BSy1FPKV3UZNg
         lEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnPqKMyFfiar+os206rDueJ0lKSlgPmoVOxZS82THjJmL7rQuLU2IFzKzVK30GPU2OawwQHOc69gJ8Qxy9xaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTcjWFYHeqkf8ioUk4A9CaOG4PRInnO9wbm5clnZ1MyjHCi0yE
	jglAQtU4LYgumB3Yq5XeTPDdLkqo7c+AYm+0I6WsXHYWetmuY2Gff8adr6AlmH4=
X-Google-Smtp-Source: AGHT+IE4mDv9oOLC+DbOrP4btguo7lo7rD5XZ/nuEUQcWCy7kUVGwLTqx0VDDeSxhqPYY7SA34Asyw==
X-Received: by 2002:a05:6e02:b47:b0:3a0:beb4:e402 with SMTP id e9e14a558f8ab-3a397cd8bcemr2852325ab.1.1728424234956;
        Tue, 08 Oct 2024 14:50:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a396975214sm1204025ab.9.2024.10.08.14.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 14:50:34 -0700 (PDT)
Message-ID: <4564d4e0-6384-4b84-a330-fdd6a026c9d6@linuxfoundation.org>
Date: Tue, 8 Oct 2024 15:50:33 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: vDSO: Explicitly include sched.h
To: Yu Liao <liaoyu15@huawei.com>, shuah@kernel.org
Cc: xiexiuqi@huawei.com, Jason@zx2c4.com, christophe.leroy@csgroup.eu,
 broonie@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241008023332.19902-1-liaoyu15@huawei.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008023332.19902-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 20:33, Yu Liao wrote:
> The previous commit introduced the use of CLONE_NEWTIME without including
> <sched.h> which contains its definition.
> 
> Add an explicit include of <sched.h> to ensure that CLONE_NEWTIME
> is correctly defined before it is used.
> 
> Fixes: 2aec90036dcd ("selftests: vDSO: ensure vgetrandom works in a time namespace")
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
> Changes in v2:
> - Include <sched.h> instead of <linux/sched.h>
> 
> v1: https://lore.kernel.org/all/20240919111841.20226-1-liaoyu15@huawei.com/
> 
>   tools/testing/selftests/vDSO/vdso_test_getrandom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> index 72a1d9b43a84..ddf37e3ab18b 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> @@ -11,6 +11,7 @@
>   #include <string.h>
>   #include <time.h>
>   #include <unistd.h>
> +#include <sched.h>
>   #include <signal.h>
>   #include <sys/auxv.h>
>   #include <sys/mman.h>

Thank you. Applied to linux-kselftest fixes for next rc.

thanks,
-- Shuah

