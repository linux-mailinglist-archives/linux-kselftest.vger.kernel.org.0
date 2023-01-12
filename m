Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D106684BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 21:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjALU44 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 15:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbjALUxm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 15:53:42 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDB61EAE5
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 12:36:55 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id o13so9913500ilc.7
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 12:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KeK4mXHfx2/sVPkcx7rO2e+6I+Iv6ezw8FJDgQnyG3M=;
        b=btgsd0yjxZ05R/XKk+8ZYp1ZdSw6JrCgpdhvOMXtXv4gMW97uCzkA80hSlizvH9pd3
         JVlZ/78KjZ1S0kECoKY/YQeXeEDdACgWj9W8JG/r7SkU0dObYdcfZAaHQzT0JCjccSE2
         Znq00aRYtAvlJ+udUIjoYGhMt3YwrHPUjKZzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeK4mXHfx2/sVPkcx7rO2e+6I+Iv6ezw8FJDgQnyG3M=;
        b=sztBX8xkJTRlDPdq9b9oDFXouqJrMvVsAl8SKDcoRJgIEZfUVLPqyPpx/RT2iv78mf
         fCYOI5kG9aC6jSFYitox6Cgs9B1XsZ7jbveh1wkouf7Vby90uv93FLn0+pJnu70cLhB/
         NO+COymQJucci+FZ1wH7sQM1/K+lycp3Rk9Vyo29lgayk6BVYoBXyZ50RaZ3ZtX5anSj
         feP7zK1Hd+GxdaT7b821HnWsg8uTWceYr+N3wkAx+7PIwjKjxQ8SH4FZf3IDJTRvjonV
         3e2j3RO8c1mBX/Eq/Be0PtqSEcytvZ50xw+kQQerCYhPI+4TufmqIBUrjDUl3Np/ZFdi
         KtQg==
X-Gm-Message-State: AFqh2krHxW6EIV8KfBrg93X6LoGf3x24HuKuw/PESoOjTrDdhqFRjpZN
        B6KU47lsipLJxUxvue3/xI8ZSQ==
X-Google-Smtp-Source: AMrXdXvLIALi+VAlQRvBFU39GylrVZ7tLSlS73fZH9+4b89AHb9Pq5xgaqT+TZU+au9GwpgKslLcVw==
X-Received: by 2002:a05:6e02:20e7:b0:30d:9eea:e51 with SMTP id q7-20020a056e0220e700b0030d9eea0e51mr4163579ilv.1.1673555814974;
        Thu, 12 Jan 2023 12:36:54 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t17-20020a92c911000000b002fa9a1fc421sm5418532ilp.45.2023.01.12.12.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 12:36:54 -0800 (PST)
Message-ID: <a01b5643-3373-d5a0-a3d7-4fa845725dbd@linuxfoundation.org>
Date:   Thu, 12 Jan 2023 13:36:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests:dma: Fix compile error in user-space tool
Content-Language: en-US
To:     Gerd Bayer <gbayer@linux.ibm.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230109180721.187324-1-gbayer@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230109180721.187324-1-gbayer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/9/23 11:07, Gerd Bayer wrote:
> Since [1] the user-space program dma_map_benchmark shares the header file
> linux/map_benchmark.h with the kernel driver in kernel/dma/map_benchmark.c.
> With latest kernel version this does not compile anymore.
> 
> While https://kernelnewbies.org/KernelHeaders suggests otherwise, allow it
> to use kernel headers through the uapi/ include directory. I assume we can
> do so safely, since the controlling user-space program is distributed with
> the kernel.
> 
> With this change dma_map_benchmark compiles with just the obvious warning
> about uapi usage on ARCH=x86, arm64, and s390 and runs on ARCH=s390.
> 
> [1] commit 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header
> file for map_benchmark definition")
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Acked-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>   tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 5c997f17fcbd..d49d7ea6a63e 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -10,7 +10,7 @@
>   #include <unistd.h>
>   #include <sys/ioctl.h>
>   #include <sys/mman.h>
> -#include <linux/types.h>
> +#include <uapi/linux/types.h>
>   #include <linux/map_benchmark.h>
>   
>   #define NSEC_PER_MSEC	1000000L
> 
> base-commit: 1fe4fd6f5cad346e598593af36caeadc4f5d4fa9

On Linux 6.2-rc3, dma_map_benchmark compiles just fine. You do
have to do "make headers_install" first as kselftest depends
on headers being installed in the repo.

Please let me know if you are seeing compile problems even after
installing headers.

thanks,
-- Shuah


