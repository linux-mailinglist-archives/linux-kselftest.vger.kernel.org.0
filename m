Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE59B775
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2019 21:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391274AbfHWTzf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Aug 2019 15:55:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39610 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391038AbfHWTze (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Aug 2019 15:55:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so6315993pgi.6
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2019 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XSuUd9OEGM9MvHYqOjSgFcq1+jiet00ohcphBFN2Ku8=;
        b=dWgkEgDhmeOPeVMVxyU16XbDSKz71EbP3utlMhzj6QfaQGskBbniwQYN+sBfh3k0xb
         0PmQLGTCDY0XpXU+vDBLhhb5yU46oI93m+K4FlVEYGQjPSMutR0JTTQmnhdR1X2NSPMy
         u0FnEFgr4h7tUOan2G5M2Hdu5n0p9wSKMXE1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XSuUd9OEGM9MvHYqOjSgFcq1+jiet00ohcphBFN2Ku8=;
        b=NDBsLII3KhDp8QkaKK9aofDim9HRRqCpJhBrTQUtoQl/NXujbIcR84F2AP3KVrhwCX
         tLgzb/D2/efdkraacpuspVm7rrGk/q1GulUTbht4wG29NEFRneMaJ5g2J72Zzx2M3V8/
         3YipBZ12/JNZkvGXYvgHJVNMcD4s/AE3AwoQDYAGYabCdAYrMh+6naOAFdgvRDwzoOuO
         XO41GnE/jjxCfaBWQNqCjTrRX3q/tXiWe0/mw88lyqlrW5mXRwptUTOTFNjyO5J9x4bI
         K4kK6o4M/Nt8vY9qjo/JjWhnGD4OdPOp4GaMvViy9DBIH3kTVbq0WmUGda6Y8ABjGEJ0
         mv+g==
X-Gm-Message-State: APjAAAU3kHvuQ98J4qtiRIxyKkQ7kU5XQZRj9AHHFmtdPcEa0E/K12+b
        xnjPBHqgwVNM4obunr8pCK5vGw==
X-Google-Smtp-Source: APXvYqyq8jAYcKixRslluX5x4YdzavP7W/24Hgq4J76S4aAIIp+mnMo1+VzRsYdY/OZPgDmD6B+xKg==
X-Received: by 2002:aa7:9907:: with SMTP id z7mr6952346pff.13.1566590133824;
        Fri, 23 Aug 2019 12:55:33 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a1sm2550230pgh.61.2019.08.23.12.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 12:55:33 -0700 (PDT)
Subject: Re: [PATCH 1/7] fs: introduce kernel_pread_file* support
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-2-scott.branden@broadcom.com>
 <s5hsgpsqd49.wl-tiwai@suse.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <5227a1bb-52e5-d547-2650-b06bee259012@broadcom.com>
Date:   Fri, 23 Aug 2019 12:55:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5hsgpsqd49.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Takashi

On 2019-08-23 5:29 a.m., Takashi Iwai wrote:
> On Thu, 22 Aug 2019 21:24:45 +0200,
> Scott Branden wrote:
>> Add kernel_pread_file* support to kernel to allow for partial read
>> of files with an offset into the file.  Existing kernel_read_file
>> functions call new kernel_pread_file functions with offset=0 and
>> flags=KERNEL_PREAD_FLAG_WHOLE.
> Would this change passes the security check like ima?
> I thought security_kernel_post_read_file() checks the whole content
> for calculating the hash...

It passes the fw_run_tests.sh.  How do you test the firmware loader 
passes this security check?


What exactly does this ima do?  How do you enable/disable using it?

Any reasonable device would check the integrity of the firmware image 
being loaded to it.

And, if part of a security model, authenticate the image.

Whatever security check you are referring to is not needed by 
request_firmware_into_buf when loading

a partial file into a buffer.


>
>
> thanks,
>
> Takashi
