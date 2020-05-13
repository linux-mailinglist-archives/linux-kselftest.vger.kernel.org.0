Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D21D1F7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 May 2020 21:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403776AbgEMTlL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 May 2020 15:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390742AbgEMTlK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 May 2020 15:41:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364CDC05BD0A
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 12:41:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 50so909994wrc.11
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=m9izSOZDzA62EkVIVJaM9RQB78HtwGR7Vc4fH0Cr3MY=;
        b=LatWmSXjR+eXddCxx4Fpk4fo9igRHLhD0wdivRc/eNsLlnnZs5nWsT8gJG8meyHtw4
         UUQkcffYPMX4wdRgrMtJsNtJX3jUTj4ye3jBgUQduaGLLcqEOsJSw4CXVNHD0b8AxF3i
         nGGoOxnAcHym+F6QKUhTXu1sRVeypKEn8nPbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=m9izSOZDzA62EkVIVJaM9RQB78HtwGR7Vc4fH0Cr3MY=;
        b=lIDZ6Z/hxiSgDL6J5i/l63A3QuCaiQ7gu2sPDVLqhN8KThPK8dhk7h/PK2+Jg7nLOt
         TwMC3NkEemkEHVKVE4QQVNrCm2EQDnG2sZOjOPSb4UXx/Ue0rsJFAjetu6aSzF5fNu1s
         kB9oeTLnpF2hyqPYwzF6SNeGWtLizUSeuzsBBh6O9U1JWnkeERCdjzJZnWI43LWhHDEE
         hbYu4GwbfrF1nWOS3TalSG6kIcmG/S1EFetNcQhdgCqkvbi6JEuTnmOPTKjcNqhudMEd
         oZ5owHhNbKMRAUbECLV28CLzppDg8rVjm7uWXBuS/8aZLxZEhP0lJdYAVBatLYpX8HNt
         4Elg==
X-Gm-Message-State: AOAM532IggvBLLPK0Fcm4GhJh/GzpYqokc9F8N4ReDPQ71MfkiF5IQSf
        OP6FSlQ0UM/w01ovOJxt03UpTQ==
X-Google-Smtp-Source: ABdhPJwAFFVlJnMtr4CXEiXONgk4Jd3OlSsLP62BuGb86vDdhyyIRrvNuimetMcYerb/TfC75/UB2g==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr1048168wrs.350.1589398868576;
        Wed, 13 May 2020 12:41:08 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id n9sm15165510wmj.5.2020.05.13.12.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:41:07 -0700 (PDT)
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
To:     Mimi Zohar <zohar@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-2-scott.branden@broadcom.com>
 <1589395153.5098.158.camel@kernel.org>
 <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
 <1589396593.5098.166.camel@kernel.org>
 <e1b92047-7003-0615-3d58-1388ec27c78a@broadcom.com>
 <1589398747.5098.178.camel@kernel.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <a228ae0f-d551-e0e8-446e-5ae63462c520@broadcom.com>
Date:   Wed, 13 May 2020 12:41:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589398747.5098.178.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2020-05-13 12:39 p.m., Mimi Zohar wrote:
> On Wed, 2020-05-13 at 12:18 -0700, Scott Branden wrote:
>> On 2020-05-13 12:03 p.m., Mimi Zohar wrote:
>>> On Wed, 2020-05-13 at 11:53 -0700, Scott Branden wrote:
>> Even if the kernel successfully verified the firmware file signature it
>> would just be wasting its time.  The kernel in these use cases is not always
>> trusted.  The device needs to authenticate the firmware image itself.
> There are also environments where the kernel is trusted and limits the
> firmware being provided to the device to one which they signed.
>
>>> The device firmware is being downloaded piecemeal from somewhere and
>>> won't be measured?
>> It doesn't need to be measured for current driver needs.
> Sure the device doesn't need the kernel measuring the firmware, but
> hardened environments do measure firmware.
>
>> If someone has such need the infrastructure could be added to the kernel
>> at a later date.  Existing functionality is not broken in any way by
>> this patch series.
> Wow!  You're saying that your patch set takes precedence over the
> existing expectations and can break them.
Huh? I said existing functionality is NOT broken by this patch series.
>
> Mimi

