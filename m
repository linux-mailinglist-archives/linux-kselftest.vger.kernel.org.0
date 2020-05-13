Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579FB1D1D91
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 May 2020 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389724AbgEMSfP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 May 2020 14:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389685AbgEMSfP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 May 2020 14:35:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E054FC061A0F
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 11:35:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so674587wrt.9
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4NRUEwBv0hh5NmFQitciKePSud4mpRvDSod4tAi2ARI=;
        b=aPuSshmqSoIgqVXQB8odJAt3Lou092w2FSbg1Q5rRmarfYXvVNY3pZDsLyIDCgPlGr
         iLZ9T7CumGM8Czfm6OQ1DMdx97s5ONMSNT+ovPZJHc9HX7mabkWYX2h4FS4CN3ex3ead
         /NFVPON5wmU3xu8b2EvKOkq54yxQprdkZfUlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4NRUEwBv0hh5NmFQitciKePSud4mpRvDSod4tAi2ARI=;
        b=K/NFKwX0X3UdtcTpzkabvpjI6G/aVcXHygPVlYCbv+Ll6MHTZf537ulNC4jvvuyY/U
         Z01/ouEVcFkAcU5drDuw4YgIpxD3pJQV3Cd8aj4BVk+/wvwooCVmHN6ggA7dVDAmkOVC
         oDm4IyTW3nOJ6cZkYF8sDzKM48MLn5JFuxERxpmbkmW1KMfRtAADSkjINKfhxOqp5q+h
         e31VJM4vM3vmbihp2NYbK/ioy00wsOVCbvFAwPfFB/JByAwOpT5QUs1V044qeWg5jwsF
         qB94WyhV/EtOzb4+LCGemw2ma2JdZKpvNxygdw7E1lLy4yy8w9gDslQhy44OSWkxkUkv
         fAww==
X-Gm-Message-State: AOAM530k7VqH5JSV2+eBAF3sdtNwD7Y2liZQRfDWKSPOqmF9DNvfKSGO
        yu1XMQYTKScdhj6J0D6NOt6yJg==
X-Google-Smtp-Source: ABdhPJxyZnlEGJCWWLbqHTUJCe4IWnvQ/tnq1amI7LL6LFRolfM/IB4ZYkBZbe8W9cXd+L98Lkuqqg==
X-Received: by 2002:adf:ea90:: with SMTP id s16mr717842wrm.19.1589394913448;
        Wed, 13 May 2020 11:35:13 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g10sm433792wrx.4.2020.05.13.11.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 11:35:12 -0700 (PDT)
Subject: Re: [PATCH v5 2/7] firmware: add offset to request_firmware_into_buf
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
        Andy Gross <agross@kernel.org>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-3-scott.branden@broadcom.com>
 <20200513003301.GH11244@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <3919bb12-522d-11fd-302b-91dc0fcff363@broadcom.com>
Date:   Wed, 13 May 2020 11:35:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513003301.GH11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Luis,

Another question.

On 2020-05-12 5:33 p.m., Luis Chamberlain wrote:
> On Thu, May 07, 2020 at 05:27:34PM -0700, Scott Branden wrote:
>> Add offset to request_firmware_into_buf to allow for portions
>> of firmware file to be read into a buffer.  Necessary where firmware
>> needs to be loaded in portions from file in memory constrained systems.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/base/firmware_loader/firmware.h |  5 +++
>>   drivers/base/firmware_loader/main.c     | 52 +++++++++++++++++--------
>>   drivers/soc/qcom/mdt_loader.c           |  7 +++-
>>   include/linux/firmware.h                |  8 +++-
>>   lib/test_firmware.c                     |  4 +-
>>   5 files changed, 55 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
>> index 25836a6afc9f..1147dae01148 100644
>> --- a/drivers/base/firmware_loader/firmware.h
>> +++ b/drivers/base/firmware_loader/firmware.h
>> @@ -32,6 +32,8 @@
>>    * @FW_OPT_FALLBACK_PLATFORM: Enable fallback to device fw copy embedded in
>>    *	the platform's main firmware. If both this fallback and the sysfs
>>    *      fallback are enabled, then this fallback will be tried first.
>> + * @FW_OPT_PARTIAL: Allow partial read of firmware instead of needing to read
>> + *	entire file.
> See, this allows us use kdoc to document his nicely. Do that with the
> kernel pread stuff.
>
>> @@ -68,6 +71,8 @@ struct fw_priv {
>>   	void *data;
>>   	size_t size;
>>   	size_t allocated_size;
>> +	size_t offset;
>> +	unsigned int flags;
> But flags is a misnomer, you just do two operations, just juse an enum
> here to classify the read operation.
>
>> index 76f79913916d..4552b7bb819f 100644
>> --- a/drivers/base/firmware_loader/main.c
>> +++ b/drivers/base/firmware_loader/main.c
>> @@ -167,7 +167,8 @@ static int fw_cache_piggyback_on_request(const char *name);
>>   
>>   static struct fw_priv *__allocate_fw_priv(const char *fw_name,
>>   					  struct firmware_cache *fwc,
>> -					  void *dbuf, size_t size)
>> +					  void *dbuf, size_t size,
>> +					  size_t offset, unsigned int flags)
> And likewise just use an enum here too.
>
>> @@ -210,9 +213,11 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
>>   static int alloc_lookup_fw_priv(const char *fw_name,
>>   				struct firmware_cache *fwc,
>>   				struct fw_priv **fw_priv, void *dbuf,
>> -				size_t size, enum fw_opt opt_flags)
>> +				size_t size, enum fw_opt opt_flags,
>> +				size_t offset)
> flags? But its a single variable enum!
fw_opt is an existing enum which doesn't really act like an enum.
It is a series of BIT defines in an enum that are then OR'd together in 
the (existing) code?
>
>>   {
>>   	struct fw_priv *tmp;
>> +	unsigned int pread_flags;
>>   
>>   	spin_lock(&fwc->lock);
>>   	if (!(opt_flags & FW_OPT_NOCACHE)) {
Have a look here - enum used as series of flags.
>> @@ -226,7 +231,12 @@ static int alloc_lookup_fw_priv(const char *fw_name,
>>   		}
>>   	}
>>   
>> -	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
>> +	if (opt_flags & FW_OPT_PARTIAL)
>> +		pread_flags = KERNEL_PREAD_FLAG_PART;
>> +	else
>> +		pread_flags = KERNEL_PREAD_FLAG_WHOLE;
>> +
>> +	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, offset, pread_flags);
> One of the advantages of using an enum is that you can then use a switch
> here, and the compiler will warn if you haven't handled all the cases.
pread_flags is currently such.  I will change to enum pread_opt.
>
>>   		/* load firmware files from the mount namespace of init */
>> -		rc = kernel_read_file_from_path_initns(path, &buffer,
>> -						       &size, msize, id);
>> +		rc = kernel_pread_file_from_path_initns(path, &buffer,
>> +							&size, fw_priv->offset,
>> +							msize,
>> +							fw_priv->flags, id);
> And here you'd just pass the kernel enum.
Yes, will change to fw_priv->opt and use enum for this one.
>
> You get the idea, I stopped reviewing after this.
>
>    Luis

