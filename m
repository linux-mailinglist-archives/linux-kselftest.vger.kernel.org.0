Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF54217DAA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jul 2020 05:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgGHDjl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 23:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbgGHDjk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 23:39:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1ADC08C5E1
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Jul 2020 20:39:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l17so1427182wmj.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jul 2020 20:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=b0MSJMdXbeUzupb6r6J9CAUvaKsjI0cyEb04d76sLig=;
        b=FQQtzi6pac89mpD8yPE44MbmGtJ0ORE4LYJxuPMmzpDJWXj0X8LHEiqANk+eASg7c8
         ng/jVO+ZvK3Ysf2i3PMvk1hBzAT+ZyBQ2Tqw+eVxuExQ6bmG4CMOoqzzxl2WxK8zpa1m
         es0R2Dv85+SCrQP2aHmxJKslvvxPqnvpkpuIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=b0MSJMdXbeUzupb6r6J9CAUvaKsjI0cyEb04d76sLig=;
        b=gKmxc9Gc/1w1Y8oFIu0m6ASUJWpDOjiAKp0nKjw/a1QzsPCJ42JDBoKpfnpBCC/ABk
         vgxlQ6TN4BP0AysEQHdHYmhQN62+BeoJBZrys/njwvUeuKbllhFrBzS9BtnZvuh3HMEp
         4sMWh98hJ7XgcVv7BC4Ww1w5UjjiMflUKkN1r4+XL5m/nYBxP5hKvsYP6b+2rb0Xwyc/
         SaRp/zSBHPS/cowquIoQykQydF30c2oBdXSPMg8pFChFp1YYLz/I6RhFHVDEkVL/o4sW
         hZfSQQu+RbVkt3c1RX9CK03cnjxPQah++gq/g56FciohpLGv6WBwfQ8mNAB0aWj9Q7gv
         BhYQ==
X-Gm-Message-State: AOAM530mKV1Cdn05rIPPyL5G9yB9q2u9S0CfMauDI8K1Iwgzl/Ks8mYt
        vOvkw38Cs36ZM7URvqQiMddJuQ==
X-Google-Smtp-Source: ABdhPJz2S9+QMAFIAx7Px3unr1ipJo9bqmjdbN368KnmW5gZno1/2MSNEHbx4ymeujbmKIvaZ51Mkw==
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr7000017wmj.152.1594179578758;
        Tue, 07 Jul 2020 20:39:38 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 69sm189961wma.16.2020.07.07.20.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 20:39:38 -0700 (PDT)
Subject: Re: [PATCH v10 1/9] fs: move kernel_read_file* to its own include
 file
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-2-scott.branden@broadcom.com>
 <202007071637.ABF914AB@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <0a3ab4c9-ee04-1cc9-6e1b-3911d58d3787@broadcom.com>
Date:   Tue, 7 Jul 2020 20:39:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007071637.ABF914AB@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2020-07-07 4:40 p.m., Kees Cook wrote:
> On Mon, Jul 06, 2020 at 04:23:01PM -0700, Scott Branden wrote:
>> Move kernel_read_file* out of linux/fs.h to its own linux/kernel_read_file.h
>> include file. That header gets pulled in just about everywhere
>> and doesn't really need functions not related to the general fs interface.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>   drivers/base/firmware_loader/main.c |  1 +
>>   fs/exec.c                           |  1 +
>>   include/linux/fs.h                  | 39 ----------------------
>>   include/linux/ima.h                 |  1 +
>>   include/linux/kernel_read_file.h    | 52 +++++++++++++++++++++++++++++
>>   include/linux/security.h            |  1 +
>>   kernel/kexec_file.c                 |  1 +
>>   kernel/module.c                     |  1 +
>>   security/integrity/digsig.c         |  1 +
>>   security/integrity/ima/ima_fs.c     |  1 +
>>   security/integrity/ima/ima_main.c   |  1 +
>>   security/integrity/ima/ima_policy.c |  1 +
>>   security/loadpin/loadpin.c          |  1 +
>>   security/security.c                 |  1 +
>>   security/selinux/hooks.c            |  1 +
>>   15 files changed, 65 insertions(+), 39 deletions(-)
>>   create mode 100644 include/linux/kernel_read_file.h
> This looks like too many files are getting touched. If it got added to
> security.h, very few of the above .c files will need it explicitly
> added (maybe none).
Some people want the header file added to each file that uses it,
others want it in a common header file.  I tried to add it to each file 
that uses it.
But if the other approach is to be followed that could be done.
> You can test future versions of this change with an
> allmodconfig build and make sure you have a matching .o for each .c
> file that calls kernel_read_file(). :)
>
> But otherwise, sure, seems good.
>

