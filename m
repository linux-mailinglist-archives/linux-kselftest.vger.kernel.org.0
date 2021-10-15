Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256F742F710
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Oct 2021 17:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhJOPkd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhJOPkd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 11:40:33 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102BC061570
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Oct 2021 08:38:26 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 188so8172095iou.12
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Oct 2021 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K3e3fPc7t2heMZulUyPXuSYTrB88WAMaLXw51fmC8FI=;
        b=GwmgesfT4HkmXK0wRnLzI8Byt0N60D5PL8+cgcMIf+AHXxyISkp0pPGNX4KIRpncv1
         WrMtVkt4aLnr1E1A5J9vBXSiF4VcdBOBbwBzFeewoOtuRgaI0v3TC4t7yDhrajLM3DeO
         p//CWbSkmbzfyDg3MghT0eKiTPkk9FdrqvEqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K3e3fPc7t2heMZulUyPXuSYTrB88WAMaLXw51fmC8FI=;
        b=qdXCxxvzoNSpSX5yNkI/APL3SAfmIzvy+YURxQ5c1wRSYnR4wXJV508EH9Rw0CfyU1
         4CDnz6wpQi1H7ly8Pgib5ITwlGPfDBB65Lq3l3nX7+Lj/uJoXCZM4zyw02bPGTjv3nep
         K6jQsiq5aQDdZyg8+WyMxHWpOf9sL8JBw5qZA+LyjJxDfQ8PbhIBK48ktQZGYTY7EFRn
         EYq7RzlrR27p181YZlGWZm9s3Imxx9TPPGppxhVdmStE8794agN0rwmZghb1yGCyoZxC
         oRQDnX/KodF1VEY5KL4F+rGg+jpbFNm3MaRq0hbapvEuvbxRZksQ/YI3aok9AyR5Rapl
         PUUQ==
X-Gm-Message-State: AOAM532sQr8MgqWM1rmbQbU2yUi/5JuUegMJ/jf0/Nf7kzwjCCmsujbW
        RAPTnWRNvSLMhOItXEXBPKsHkyfGlY6CHA==
X-Google-Smtp-Source: ABdhPJxJL8c5vZdOxZB4JmZkMR0dRtCWu8QDLxF3hfT5HnDc8N/180h61DAt/qfE86UGaWjPelwE6Q==
X-Received: by 2002:a5e:c018:: with SMTP id u24mr4159426iol.197.1634312306057;
        Fri, 15 Oct 2021 08:38:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v26sm1980979iox.35.2021.10.15.08.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 08:38:25 -0700 (PDT)
Subject: Re: [RFC][PATCH] selftests/vm/transhuge-stress: fix ram size thinko
To:     "George G. Davis" <george_davis@mentor.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <davis.george@siemens.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210825135843.29052-1-george_davis@mentor.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <41be8425-761b-fa55-40c5-687b397e8ad2@linuxfoundation.org>
Date:   Fri, 15 Oct 2021 09:38:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210825135843.29052-1-george_davis@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/25/21 7:58 AM, George G. Davis wrote:
> From: "George G. Davis" <davis.george@siemens.com>
> 
> When executing transhuge-stress with an argument to specify the virtual
> memory size for testing, the ram size is reported as 0, e.g.
> 
> transhuge-stress 384
> thp-mmap: allocate 192 transhuge pages, using 384 MiB virtual memory and 0 MiB of ram
> thp-mmap: 0.184 s/loop, 0.957 ms/page,   2090.265 MiB/s  192 succeed,    0 failed
> 
> This appears to be due to a thinko in commit 0085d61fe05e
> ("selftests/vm/transhuge-stress: stress test for memory compaction"),
> where, at a guess, the intent was to base "xyz MiB of ram" on `ram`
> size. Here are results after using `ram` size:
> 
> thp-mmap: allocate 192 transhuge pages, using 384 MiB virtual memory and 14 MiB of ram
> 
> Fixes: 0085d61fe05e ("selftests/vm/transhuge-stress: stress test for memory compaction")
> Signed-off-by: George G. Davis <davis.george@siemens.com>
> ---
>   tools/testing/selftests/vm/transhuge-stress.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
> index fd7f1b4a96f9..5e4c036f6ad3 100644
> --- a/tools/testing/selftests/vm/transhuge-stress.c
> +++ b/tools/testing/selftests/vm/transhuge-stress.c
> @@ -79,7 +79,7 @@ int main(int argc, char **argv)
>   
>   	warnx("allocate %zd transhuge pages, using %zd MiB virtual memory"
>   	      " and %zd MiB of ram", len >> HPAGE_SHIFT, len >> 20,
> -	      len >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));
> +	      ram >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));
>   
>   	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
>   	if (pagemap_fd < 0)
> 

Sorry for the delay on this. The change looks good to me.

Andrew! Would you like me to take this through kselftest tree?

thanks,
-- Shuah
