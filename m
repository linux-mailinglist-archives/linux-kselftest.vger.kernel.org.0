Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B60352FEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 21:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhDBTsH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 15:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBTsH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 15:48:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3314EC0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 12:48:06 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h7so5408998ilj.8
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iHLXeOgoJJwmSWdDXV69tzMVoLXBDndScOXkQMnjrV0=;
        b=doTIYLPGjaNwJWg0K4FVYoKIThZXXlTnrOdWyT6niRVVA1mwj+zdMm+nvUtCCUQ79h
         y7uXKv1ARjZ+OHKF8ra7+X0IlgHtNWXCwKSvhSEztTezgo7UN7GXq+mbctTRDdFeZ604
         TzFIqRUGw7c2MzttnuyFN2hMPjlnovSROTrnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iHLXeOgoJJwmSWdDXV69tzMVoLXBDndScOXkQMnjrV0=;
        b=TVcxK2rDGolB8Y060lEWZkcL5F612B1qsxbbdqECVE5YznFREnIjL+sB2VSCLrk916
         wtWoZxpCEc9wDlsQQQ5HQYlU9/U5VrzVJGbxzTkf2T0kzNQ6UzqkL6QbQC8AARnHJAuG
         wFjWaCtLOmv2+A8d1o8Y8dnLtWRh08vSYYrOxtECTs1I8EmA1Fa52JaAXAODCkMus5bL
         wCgJwv86k9udi5JgZBdUrb6/nhECnGzJgGmKPgCUZEOznr3/pPEw23u3wQPJaALCc8Su
         GeqSf7UVuKpMgFqPwV7Q/3NY1PxovqHXfQrOMdIHZphPMiS+svYhLUou0GObBYTkx3oW
         600g==
X-Gm-Message-State: AOAM530kTR3O5NiHfc6t0u85iZEAdIpCnMU4/4+OuLaKjyzVBklBkXJd
        k5GMPjXWiDOihFQaFT+MSAQO8A==
X-Google-Smtp-Source: ABdhPJzN3wsWL0RIK0m4BvHNYZy4gx6aSrgSJtQkhLgrH403uNNurZ0odS2hjHg5ZUG3tCPgAVgeqQ==
X-Received: by 2002:a05:6e02:13e8:: with SMTP id w8mr12164264ilj.237.1617392885666;
        Fri, 02 Apr 2021 12:48:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h6sm3077512ilr.24.2021.04.02.12.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 12:48:05 -0700 (PDT)
Subject: Re: [PATCH v6 12/21] selftests/resctrl: Check for resctrl mount point
 only if resctrl FS is supported
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
 <20210317022255.2536745-13-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b25fa4eb-803c-dc44-421a-080668c54aff@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 13:48:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210317022255.2536745-13-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/16/21 8:22 PM, Fenghua Yu wrote:
> check_resctrlfs_support() does the following
> 1. Checks if the platform supports resctrl file system or not by looking
>     for resctrl in /proc/filesystems
> 2. Calls opendir() on default resctrl file system path
>     (i.e. /sys/fs/resctrl)
> 3. Checks if resctrl file system is mounted or not by looking at
>     /proc/mounts
> 
> Steps 2 and 3 will fail if the platform does not support resctrl file
> system. So, there is no need to check for them if step 1 fails.
> 
> Fix this by returning immediately if the platform does not support
> resctrl file system.
> 
> Tested-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/resctrlfs.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 6b22a186790a..87195eb78356 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -570,6 +570,9 @@ bool check_resctrlfs_support(void)
>   	ksft_print_msg("%s kernel supports resctrl filesystem\n",
>   		       ret ? "Pass:" : "Fail:");
>   

This message is a bit confusing. Please change this to read
and send a follow-on patch on top of linux-kselftest next

"Check kernel support for resctrl filesystem"

thanks,
-- Shuah
