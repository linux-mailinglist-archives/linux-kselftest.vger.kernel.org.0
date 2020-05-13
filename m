Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298AE1D1E0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 May 2020 20:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390337AbgEMSxd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 May 2020 14:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390295AbgEMSxc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 May 2020 14:53:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A4AC05BD0A
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 11:53:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so761746wrn.6
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pXu37DD6iE65dDGCF4WvK7cyvgiimEWOvvgpryvd52U=;
        b=IbEVDf1PZkcsC9qKSfRpq/TZXfimI98pReSCcaQgTPNl9HmndoODpa4MDeOulOvRz4
         yCi4Y0M//sK1fidl4u5Podrn0hGfzM9JzccG27h3Bum61GNrk5w9Z1sOClL7Gns6+5GF
         NnqDrlIux2oiU+oQESCrAfiMljk+vnBzT/ypM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pXu37DD6iE65dDGCF4WvK7cyvgiimEWOvvgpryvd52U=;
        b=rAsakO08rpVLIem8cQTVQl+nuCbzCuDNcT9Csec9YwD57nSLapA2c+cMd3OLUTL/55
         9+Rj95UcPBpSGkhS65Ifc6wIYpZI1+soHhvgNmYfKD0ufUHR8IvNr2MmgUdS63O6ZDOV
         i2g2aLVvi1hSEcnyedKjJFrEFd4v8qTZI6XF4ny7/fAUjlPtenJJomP9OSw9mLhtJTP4
         yXLa9tmdEsI5WFYVAC1IA6n2JS/7U/YPoVWsoJDtHTaH3IH7lFa5GzXYZK2H0lPRRlAT
         DSvIIdMJBv9Bn8eOIexRnSlAIHnGXK1L/bh6DEAcWze0+TYEw3P7ZDXIcl8uCIlqsSNP
         VCZg==
X-Gm-Message-State: AOAM531Y5fhKswnkdOXYYuj0XQ6PS2dB7eBV7sbzkE1FW3J9gTSnc9hG
        W50etdA8+Z9hn6Gzk+5DGczivg==
X-Google-Smtp-Source: ABdhPJyQTNm1BSKNK4nPH8PwhT168mr3Et0SlCcd67hBnuW+VdEO/ieVYFVuvkPPR1fp/Uk3isIZEg==
X-Received: by 2002:adf:a151:: with SMTP id r17mr761655wrr.161.1589396010916;
        Wed, 13 May 2020 11:53:30 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id i17sm37309331wml.23.2020.05.13.11.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 11:53:30 -0700 (PDT)
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
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
Date:   Wed, 13 May 2020 11:53:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589395153.5098.158.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mimi,

On 2020-05-13 11:39 a.m., Mimi Zohar wrote:
> [Cc'ing linux-security-module, linux-integrity]
>
> On Thu, 2020-05-07 at 17:27 -0700, Scott Branden wrote:
>> Add kernel_pread_file* support to kernel to allow for partial read
>> of files with an offset into the file.  Existing kernel_read_file
>> functions call new kernel_pread_file functions with offset=0 and
>> flags=KERNEL_PREAD_FLAG_WHOLE.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
> <snip>
>
>> @@ -941,14 +955,16 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
The checkpatch shows this as kernel_read_file when it is actually the 
new function kernel_pread_file.
Please see the call to kernel_pread_file from kernel_read_file in the 
complete patch rather this snippet.
>>   
>>   		if (bytes == 0)
>>   			break;
>> +
>> +		buf_pos += bytes;
>>   	}
>>   
>> -	if (pos != i_size) {
>> +	if (pos != read_end) {
>>   		ret = -EIO;
>>   		goto out_free;
>>   	}
>>   
>> -	ret = security_kernel_post_read_file(file, *buf, i_size, id);
>> +	ret = security_kernel_post_read_file(file, *buf, alloc_size, id);
>>   	if (!ret)
>>   		*size = pos;
> Prior to the patch set that introduced this security hook, firmware
> would be read twice, once for measuring/appraising the firmware and
> again reading the file contents into memory.  Partial reads will break
> both IMA's measuring the file and appraising the file signatures.
The partial file read support is needed for request_firmware_into_buf 
from drivers.  The EXPORT_SYMBOL_GPL is being removed so that
there can be no abuse of the partial file read support.  Such file 
integrity checks are not needed for this use case.  The partial file 
(firmware image) is actually downloaded in portions and verified on the 
device it is loaded to.

Regards,
  Scott
