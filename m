Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0FF2AE1E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 22:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKJVg6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 16:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJVg6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 16:36:58 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F95C0613D1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 13:36:58 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id e17so517364ili.5
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 13:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7BM4+zzNWaE6TirCtLLYoQ9tppsE0QS4r3dvLHZsJ2Y=;
        b=TIJINkyMPlkffs9/+dOX6vGvoGglpDShCvG8w3RFc3lqyqbJ3NE9/t6GzJZHx3L6AT
         TUAbpyBqZ19xWo3q9M8uYllRuoQCEQyk1dwTRYUmQxltCH9oVKluHxyJpaGSulClCUfK
         w3Pu9Z8gjBZnbAL5eLXZrnejOMK0oxzqKND9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7BM4+zzNWaE6TirCtLLYoQ9tppsE0QS4r3dvLHZsJ2Y=;
        b=H41N9GvR3+u/l1CYbUJGeFYNtHmFoapDeTOVBOxMzQvMvPj/2E83FMYSLIs+OwnYI4
         t45QRrICiJP0uEUyvyvcDXaa/Yrhg3o7svm/F0UI4ePa/qL6XLqiy7OZwRtEhIYYyQbK
         WxBWaxzRAMu/q+ithCE7ursOB1a9WHeNID5KkwS785Hxswd8tqH4NRU4YV/LLif3UoL6
         n8aMbFN19X68yQBysnPfXvhcYsly4Y1VdSeL27QCiZLhmTtH0e2QUUDKR6TpXWiXFFLJ
         rRTQJUuBGkTLsPzXEQZBDkm3nPQoWZtRM0BcJvjJ3l3MSyeHgQVMLQhnZYTCUHNF3H3m
         iXHA==
X-Gm-Message-State: AOAM53229ExsyVBZfBWMpaQssXS5fhFQNYrpxhHxcZbH+27VG+4SKlWm
        JZCKOuWBAkUaYsUvKFQRrJg8jsIN6GWRQA==
X-Google-Smtp-Source: ABdhPJyqj8WvPEO1P5u7sS0mUX+V0R+C3ezUg05U2S8qWDrIq/NQa1vuEKLQOS+Srmek8japJaQj/A==
X-Received: by 2002:a92:5204:: with SMTP id g4mr15477146ilb.91.1605044217564;
        Tue, 10 Nov 2020 13:36:57 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c80sm10181792ill.20.2020.11.10.13.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 13:36:57 -0800 (PST)
Subject: Re: [PATCH] selftests/seccomp: Update kernel config
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201030121819.764395-1-mic@digikod.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d4723ea9-d561-fc0c-c4c5-24c6fd454064@linuxfoundation.org>
Date:   Tue, 10 Nov 2020 14:36:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201030121819.764395-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/30/20 6:18 AM, Mickaël Salaün wrote:
> seccomp_bpf.c uses unshare(CLONE_NEWPID), which requires CONFIG_PID_NS
> to be set.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Tycho Andersen <tycho@tycho.pizza>
> Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> ---
>   tools/testing/selftests/seccomp/config | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/seccomp/config b/tools/testing/selftests/seccomp/config
> index 64c19d8eba79..ad431a5178fb 100644
> --- a/tools/testing/selftests/seccomp/config
> +++ b/tools/testing/selftests/seccomp/config
> @@ -1,3 +1,4 @@
> +CONFIG_PID_NS=y
>   CONFIG_SECCOMP=y
>   CONFIG_SECCOMP_FILTER=y
>   CONFIG_USER_NS=y
> 
> base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
> 

Your from and Signed-off-by don't match. Please send the patch
from your igned-off-by address.

WARNING: From:/Signed-off-by: email address mismatch: 'From: "Mickaël 
Salaün" <mic@digikod.net>' != 'Signed-off-by: Mickaël Salaün 
<mic@linux.microsoft.com>'

thanks,
-- Shuah
