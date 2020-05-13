Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C75B1D0893
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 May 2020 08:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbgEMGbf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 May 2020 02:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732390AbgEMGbd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 May 2020 02:31:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF213C05BD09
        for <linux-kselftest@vger.kernel.org>; Tue, 12 May 2020 23:31:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so10660292pjb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 May 2020 23:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2csGsD+au94C9xmTiACbfUOMQ7XhAMYTWeJo+alYFFI=;
        b=ZSVlgXkkpJtSfN7qkaqSe1HuEAcdJz+206DgqQ9a8bBTg1j86M/AV1JMXsfvt6a2jG
         yj/qedw70QPli6gaJfIS7IWASeacoIDxNbSyu9WdaQPEBjWsWQcEo5g5MJrVhANXE2rX
         0zouj2RZsoJ6qnQ2ByQjeFr7YxZ7NE5uAypGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2csGsD+au94C9xmTiACbfUOMQ7XhAMYTWeJo+alYFFI=;
        b=X6IygfXljTIDlwtEmoIZD6OqRE9QY5WcSjGO9kAHIwMJVDWPMOKeArBNt0r1jjsVP2
         GnPc2FV8To9BQKMM03YygYgbXGdNYglAF1QCR22cvvFMdi764m44X2yA2T5YMkD/PxMe
         ZqBnBKl7gX6lZOOaKUn2zJZ1PKBBTqexfBPuGZqWL6G2zi3MfZNmP7bVaRPxaaGH/pG1
         X2u2vvr1FTrgh5nnq4tq+WSgNsxAY3UT5HNBF280d8FzzQB5Ms7bPsI39IRwf1OG8Ahi
         sSOMuL0JsJ/sLA5oO2REHeEdrelF3p9NVqdT08cTQUnNOJ/lvB3Mcw8Cj+r5x/XGRITY
         PILQ==
X-Gm-Message-State: AOAM53049i4taWVy006JlE7CGMi/hndnS6/rONuhpeYcFvDhrCaTzYld
        BMy0LsI5SI7f4HIWPLvzBNcHo1S0o6YJXg==
X-Google-Smtp-Source: ABdhPJzun7l0BGdVwIAv5LpJTCZ51XWx8WkOrhjqdl2WVdRNTqaM1ew0r90ShpQV04nRKtPQ735vBg==
X-Received: by 2002:a17:902:8505:: with SMTP id bj5mr7220884plb.192.1589351492246;
        Tue, 12 May 2020 23:31:32 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c1sm13716735pfo.152.2020.05.12.23.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 23:31:31 -0700 (PDT)
Subject: Re: [PATCH v5 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-7-scott.branden@broadcom.com>
 <20200513003830.GJ11244@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <60372b2f-c03d-6384-43a7-8b97413b6672@broadcom.com>
Date:   Tue, 12 May 2020 23:31:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513003830.GJ11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Luis,

On 2020-05-12 5:38 p.m., Luis Chamberlain wrote:
> On Thu, May 07, 2020 at 05:27:38PM -0700, Scott Branden wrote:
>> +#if defined(CONFIG_REQ_FW_INTO_BUF_PRIV)
>> +
>> +#define KERNEL_PREAD_FLAG_PART	0x0001 /* Allow reading part of file */
>> +#define REQUEST_FIRMWARE_INTO_BUF request_firmware_into_buf_priv
>> +int request_firmware_into_buf_priv(const struct firmware **firmware_p,
>> +				   const char *name, struct device *device,
>> +				   void *buf, size_t size,
>> +				   size_t offset, unsigned int pread_flags);
>> +
>> +#else
>> +
>> +#define REQUEST_FIRMWARE_INTO_BUF request_firmware_into_buf
>> +
>> +#endif
>> +
>> +#endif
> Please clean this up, the code must reflect only the code upstream. No
> config stuff like this should be used on the driver. I had to stop my
> review here.
The CONFIG_ prefix shouldn't have been there as there is no Kconfig 
option to select this.
Would like to just change it to a normal define without CONFIG_ prefix 
instead?
This code is here to allow a limited version of the driver to run on 
older kernels which do not have the necessary partial file read support.
By having it in the upstream codebase we don't need to maintain an 
internal version of the driver.  User can take the upstream kernel 
module and compile it against an old version of the kernel by via the 
define.
>    Luis
Regards,
Scott
