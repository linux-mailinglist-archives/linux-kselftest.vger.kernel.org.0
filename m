Return-Path: <linux-kselftest+bounces-10876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFC28D413F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 00:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D901286CEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F0516A387;
	Wed, 29 May 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IVvMYp6A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAC2837F
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021156; cv=none; b=aghd04aYxNyxLg0eFNe2rHRuyyDi5IeD0ZylCEd6coJ9Y9akS294ALf5W6oexI/msjHslaxg1TXqkdOiwbvw9G+0fTgCV4x2zQmeSsKwVNqOdxUVKJsff2/BlLV6PD3NPgxiC6KPdMgWVgd4Ws/UpCvzoHkwL3qiXfkPMjsLUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021156; c=relaxed/simple;
	bh=P15Xc0XyTPFvoCXfmrMxrFhFsyfQkEO7hmX8PLu1Xtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEpRGeeFqplC63ASWxbVk0diN+6ju7Hkk6cC1NHwcuXoA97JJ9f+TdInA2q6jbfqJfBRGZdfbKYovRJfje9b5c60heTkhbcz8d+LcyDK+RSjTH0gIYYu3AbzqKqaTus//KaVk6rSrx9Av98qnDZjh2u37j6NIXAHnarVEYc7ql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IVvMYp6A; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so129765ab.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717021153; x=1717625953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIQsNObstWkWgKnY1UZsOrj0Wfr/JVGgFuTZShWQ62k=;
        b=IVvMYp6Ayi1TfYHVt/th2r4xneI5dfgrjM3hn1bakEPDdJqh/wKzx4Dhm9+3RDkFzo
         vAXnQBiqgU0NM9jF3YeoN4kYJ2qcaXyT3mlT7yZvg7FWWCjlcdFKbdW814LCiBdkaA38
         JF/GCCUgIoABz8n7sL7iOmZw9y0quszELsS/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021153; x=1717625953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIQsNObstWkWgKnY1UZsOrj0Wfr/JVGgFuTZShWQ62k=;
        b=bJOLjVi1yeNd0ALxspNzcFq3H/nrI9pjNWE7gwyOUFYCA0NSlhbBKPWPcuEG6jXsBI
         eHVYfGpzZ0dNpsjY6MxJSunGqohL7Q4XdtAplF/lS/84AYZnySS4ew4h4w9KRnqKmg9/
         YOZdzrtG/tzfEzWxLBzrW4n0RAaZ8Ht6B/P9sKgxOghxMbON2DMdOsfeW4p6zRJdE17O
         0lseDiwcmLCAr0mM98ux6uSjWQvLN1udP0DZFkl3JHryw3rZ3mJUDDIxScM2wb1brdX7
         ZsJwryvOU+awY4fXJkbgjAqdBncCtCJ4wAUyME21cjacWf44noEld6bvI51/RYygD+s8
         4atA==
X-Forwarded-Encrypted: i=1; AJvYcCWcpXp/qTqI16JqHN0fId/KyFwPem2xVcims4VfHswPseAKl7gkRAJycL6xYw1qak8HfV7fDc6mXRuSdij5gaUYWM5fC83FKxfYM7S0x64j
X-Gm-Message-State: AOJu0YxhySpykUY8bvT4+385Ysu0fNNnh7PCqGc84EzbccCJPmrlDBj+
	pr7D51JTuFKcMAub0YV623RFSK9nkuduIkpnoTjSYKYLenh0LCA2cGn1/P11va0=
X-Google-Smtp-Source: AGHT+IGX3vM7AirEhD0z1TjIJ73Jy0G+hX175YByeN8PNH6Y8OAF4RTa4RM3+I+p92DV9/6KWiuc1Q==
X-Received: by 2002:a05:6602:1d41:b0:7de:e495:42bf with SMTP id ca18e2360f4ac-7eaf5d79567mr28209339f.1.1717021152820;
        Wed, 29 May 2024 15:19:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b0e80c3b6fsm1483913173.135.2024.05.29.15.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 15:19:12 -0700 (PDT)
Message-ID: <3f3a70ba-40d2-4624-b8c5-7c3ae2a025fb@linuxfoundation.org>
Date: Wed, 29 May 2024 16:19:11 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/overlayfs: Fix build error on ppc64
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>
References: <20240521022616.45240-1-mpe@ellerman.id.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240521022616.45240-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/24 20:26, Michael Ellerman wrote:
> Fix build error on ppc64:
>    dev_in_maps.c: In function ‘get_file_dev_and_inode’:
>    dev_in_maps.c:60:59: error: format ‘%llu’ expects argument of type
>    ‘long long unsigned int *’, but argument 7 has type ‘__u64 *’ {aka ‘long
>    unsigned int *’} [-Werror=format=]
> 
> By switching to unsigned long long for u64 for ppc64 builds.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> index 759f86e7d263..2862aae58b79 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> +++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #define _GNU_SOURCE
> +#define __SANE_USERSPACE_TYPES__ // Use ll64
>   
>   #include <inttypes.h>
>   #include <unistd.h>

Applied to linux-kselftest fixes for the next rc.

Michael, If you want to take this through, let me know, I can drop this.

thanks,
-- Shuah

