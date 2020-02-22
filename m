Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE41C168B80
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2020 02:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBVBNT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Feb 2020 20:13:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39035 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgBVBNR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Feb 2020 20:13:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so3984315wrt.6
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2020 17:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3OKaYIHAkscSICnojjLFVcfWriWY1zhvs1Wig+8n2u0=;
        b=YuZBob4gmx9BoVF20MxUMC4n/O2CRqr7f4PfEbgIjSUOmHRoUON6ioN3lQAp+XaXsc
         YnYlGLs9XUL5tqmnh9TRTJpQR9PkRpU7GY0fmQqqqDpcTwhwfmm1AeAHh63DYxj94wDt
         /6xbAUPlaRkR7P/ddUn1r3McPYwTMEWRdXBmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3OKaYIHAkscSICnojjLFVcfWriWY1zhvs1Wig+8n2u0=;
        b=UQSbxj1bBK1L3npol8w9CuJgqxl6jvrdDUCAf+WcoGvs3CQSgey9TdJDRcfUsela1B
         T71R+Yk3/+g913e7UETjkH1lcMo9Cao/Cn1u7dtIjxvix4erS2G/Xv2YwUf1yJiIPYUA
         rwbF8I4vK85z5gifCt+W8PZycj53I0skB0bhyGQ7n+qgdjheTN8/BIsU15rT3I5iun3n
         CHUpCKuKxQyflI6CD0cwM2j2Q/YLzfIDZ4qoh96CB9x0I4LCS5qLlMvdQHcxkfmkjR4t
         NJU0Cogi8xbD4AW8atnNL+d+GobEQj66SmIukPPBLEuZwt6RUEE+o9xIH3UNDbauUvTq
         9MDQ==
X-Gm-Message-State: APjAAAVM/LPNJZkld8pKZ70WbtykbNelPPVs31UA6fFz6dykq20PyJov
        uEbuXt813WFUgbX7TDenyQuFEQ==
X-Google-Smtp-Source: APXvYqz8IRZ8DqHhpRydE7w0DX5vQbJ06y2qjkNLAGTp9MyxwoZhTc6cNxB8geMHSuyuUmtCGGdTAQ==
X-Received: by 2002:adf:e683:: with SMTP id r3mr54339138wrm.38.1582333995403;
        Fri, 21 Feb 2020 17:13:15 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d4sm6275870wra.14.2020.02.21.17.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 17:13:14 -0800 (PST)
Subject: Re: [PATCH v2 3/7] test_firmware: add partial read support for
 request_firmware_into_buf
From:   Scott Branden <scott.branden@broadcom.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
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
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-4-scott.branden@broadcom.com>
 <20200220084255.GW7838@kadam>
 <9afab7f8-1b5f-a7bb-6b76-f7b19efb2979@broadcom.com>
Message-ID: <4a666590-461d-17f9-5580-31a41869383f@broadcom.com>
Date:   Fri, 21 Feb 2020 17:13:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9afab7f8-1b5f-a7bb-6b76-f7b19efb2979@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reponses inline.

Luis - please have a look as well.

On 2020-02-21 10:30 a.m., Scott Branden wrote:
> Hi Dan,
>
> Thanks for your review and valuable comments.
> Will have to investigate fully and correct anything wrong.
>
> On 2020-02-20 12:42 a.m., Dan Carpenter wrote:
>> On Wed, Feb 19, 2020 at 04:48:21PM -0800, Scott Branden wrote:
>>> +static int test_dev_config_update_size_t(const char *buf,
>>> +                     size_t size,
>>> +                     size_t *cfg)
>>> +{
>>> +    int ret;
>>> +    long new;
>>> +
>>> +    ret = kstrtol(buf, 10, &new);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (new > SIZE_MAX)
>> This "new" variable is long and SIZE_MAX is ULONG_MAX so the condition
>> can't be true.
Removed the check.
>>
>>> +        return -EINVAL;
>>> +
>>> +    mutex_lock(&test_fw_mutex);
>>> +    *(size_t *)cfg = new;
>>> +    mutex_unlock(&test_fw_mutex);
>>> +
>>> +    /* Always return full write size even if we didn't consume all */
>>> +    return size;
>>> +}
>>> +
>>> +static ssize_t test_dev_config_show_size_t(char *buf, int cfg)
>>> +{
>>> +    size_t val;
>>> +
>>> +    mutex_lock(&test_fw_mutex);
>>> +    val = cfg;
>>> +    mutex_unlock(&test_fw_mutex);
>> Both val and cfg are stack variables so there is no need for locking.
>> Probably you meant to pass a pointer to cfg?
I am following the existing code as was done for
test_dev_config_show_bool(),
test_dev_config_show_int(),
test_dev_config_show_u8()

Mutex probably not needed but I don't think I need to deviate from the 
rest of the test code.

Luis, could you please explain what the rest of your code is doing?
>>
>>> +
>>> +    return snprintf(buf, PAGE_SIZE, "%zu\n", val);
>>> +}
>>> +
>>>   static ssize_t test_dev_config_show_int(char *buf, int cfg)
>>>   {
>>>       int val;
>> regards,
>> dan carpenter
>>
>>
>

