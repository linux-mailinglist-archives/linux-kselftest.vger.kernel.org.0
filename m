Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764BA1F0380
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jun 2020 01:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgFEXbU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 19:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgFEXbT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 19:31:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B2C08C5C4
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Jun 2020 16:31:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b201so5681999pfb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jun 2020 16:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QT3TOfTZM7n8upLOBb9CoT35uLEYwP8QmqKQlYpotu8=;
        b=aRVd9mVasyOpi3qj6L+9LPZYEZeqaeUcati7cYFOWdqTeHQHVCYu1Mg3TZAEJ+Cemq
         dfXKAo+Q6UNAFsH/2ZXA/hLBkWgSa0nz4wSjsYb/wFS0rixfFi3JJfcl8n4oR6+Ps1Qy
         U+/FztKv09P0+eWToCYdTvhCeWQASBbcJYwWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QT3TOfTZM7n8upLOBb9CoT35uLEYwP8QmqKQlYpotu8=;
        b=Bpp6xfL0GAdUiub1SZBuHITvA+MAdEqA5U9swdzE9pPBfQzOCFyMmXdLukVNnz3LoU
         1hui+hnHjX7HruB3mvX2c2eLoQjMmEwjdWm+bqM2vJXMwQMtSQNHUGJx1KUqlWgYcMT/
         JCaBspsFnAAqpdC0/rrXvtQGcYIGMIkj9hl592uS2RQe3AWK6msbpbSc0Ce0KTBW7kv2
         kh++r6EAh0du8kgauM+hktlCk/bOyhN0a2zzEdlvwaMMH5TFEz1jylsIRNears51ayH/
         Xo0aktm/wb82gzwloSozqZOaTGHhcuxAsicCzHVY/vazqay1YqUBo3UCDMUr+kY5VMqf
         ePmg==
X-Gm-Message-State: AOAM532aEXxDHRsyf3rrhZiu3VN46+J0NgxfSsUFwophBMZnSwVJGfdc
        YUntNCYyxUSvYtDY7/PcIxiBhg==
X-Google-Smtp-Source: ABdhPJyjNvTuZNiXBWA+wu5gD204795YG4uT5HA5nAd7pQQKXRGvD9NKYFP7JEix9AMrHm3M2js3SQ==
X-Received: by 2002:a65:6715:: with SMTP id u21mr12073266pgf.365.1591399879036;
        Fri, 05 Jun 2020 16:31:19 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 125sm588134pff.130.2020.06.05.16.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 16:31:17 -0700 (PDT)
Subject: Re: [PATCH v6 8/8] ima: add FIRMWARE_PARTIAL_READ support
To:     Mimi Zohar <zohar@linux.ibm.com>,
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
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200605225959.12424-1-scott.branden@broadcom.com>
 <20200605225959.12424-9-scott.branden@broadcom.com>
 <1591399166.4615.37.camel@linux.ibm.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <824407ae-8ab8-0fe3-bd72-270fce960ac5@broadcom.com>
Date:   Fri, 5 Jun 2020 16:31:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591399166.4615.37.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mimi,

On 2020-06-05 4:19 p.m., Mimi Zohar wrote:
> Hi Scott,
>
> On Fri, 2020-06-05 at 15:59 -0700, Scott Branden wrote:
>> @@ -648,6 +667,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>>   	enum ima_hooks func;
>>   	u32 secid;
>>   
>> +	if (!file && read_id == READING_FIRMWARE_PARTIAL_READ)
>> +		return 0;
> The file should be measured on the pre security hook, not here on the
> post security hook.  Here, whether "file" is defined or not, is
> irrelevant.  The test should just check "read_id".
OK, will remove the !file from here.
>
> Have you tested measuring the firmware by booting a system with
> "ima_policy=tcb" specified on the boot command line and compared the
> measurement entry in the IMA measurement list with the file hash (eg.
> sha1sum, sha256sum)?
Yes, I enabled IMA in my kernel and added ima_policy=tsb to the boot 
command line,

Here are the entries from 
/sys/kernel/security/ima/ascii_runtime_measurements of the files I am 
accessing.
Please let me know if I am doing anything incorrectly.

10 4612bce355b2dbc45ecd95e17001636be8832c7f ima-ng 
sha1:fddd9a28c2b15acf3b0fc9ec0cf187cb2153d7f2 
/lib/firmware/vk-boot1-bcm958401m2.ecdsa.bin
10 4c0eb0fc30eb7ac3a30a27f05c1d2a8d28d6a9ec ima-ng 
sha1:b16d343dd63352d10309690c71b110762a9444c3 
/lib/firmware/vk-boot2-bcm958401m2_a72.ecdsn

The sha1 sum matches:
root@genericx86-64:/sys/kernel/security/ima# sha1sum 
/lib/firmware/vk-boot1-bcm958401m2.ecdsa.bin
fddd9a28c2b15acf3b0fc9ec0cf187cb2153d7f2 
/lib/firmware/vk-boot1-bcm958401m2.ecdsa.bin

root@genericx86-64:/sys/kernel/security/ima# sha1sum 
/lib/firmware/vk-boot2-bcm958401m2_a72.ecdsa.bin
b16d343dd63352d10309690c71b110762a9444c3 
/lib/firmware/vk-boot2-bcm958401m2_a72.ecdsa.bin


>
> Mimi
>
>> +
>>   	if (!file && read_id == READING_FIRMWARE) {
>>   		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
>>   		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {

