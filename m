Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8231686AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2020 19:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgBUSaa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Feb 2020 13:30:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33089 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgBUSaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Feb 2020 13:30:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so1679659pfn.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2020 10:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ViDmi6LANQiHZ9fbuRb7b9SQvH9otsi+PGHBtwaKrQM=;
        b=XickjLfbcjz4i5DfLBgvrvSjCgGrYe7fBppOOqIqcLJS5jW2sco8qVSMZUR9+Vdt/q
         R4qO7WFK50yG2U2oF8jIL+9AC7MO+gv00zJ4Te7OMHx0BOPYVhklWm8HQ5F4mO2cqK13
         vzER9mPVBhRipa54AiuDIzW2CpLKq+IFlCab4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ViDmi6LANQiHZ9fbuRb7b9SQvH9otsi+PGHBtwaKrQM=;
        b=tHfXDjvJAsyRYygmVRyLfhXIqy9vVsvENyZW8h0Bf+ZMBWW+TBhuESs0+NVOwA/7Sz
         vX57K42bJHdnfOlQQp17zy/P053vtIaQC90GWex1kgDDArRfOJJpjRR6VChuB0Pp2X0n
         aZ8u1+WYwXvFr679nTn/w9a9Iub5OCh07c4j9jXykhNiESUFbESRuOF5wv+CBDfqDs9z
         UvmQGCmSBnA4upqDhNfjPp3T8wMMqT+FRrheUdcSQeMASFGRCn1s7uq44pg5J4HCQUxc
         3r5TZ3t8GNDmTQJn9a6TvBp1xFcmkhq2Te0SPPns3EZTTKMaSfXduNYFGsP0fe4xh4Vp
         zrWQ==
X-Gm-Message-State: APjAAAWMLiTe1uWXxU9Kc0K3iXiPOHaXo8Se+PThlJZQxBZ316HYcOHy
        ATOP2PURg1zZ5YywsKDJvUDwMA==
X-Google-Smtp-Source: APXvYqyo9nEvkqt/D9QeY7GO9t6Wbt7JpPLDlJgQzH/6aHvn9HigxRbtbwXnIcRQ8StTZHRoC3sI7A==
X-Received: by 2002:a63:5561:: with SMTP id f33mr39995141pgm.14.1582309829947;
        Fri, 21 Feb 2020 10:30:29 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id s130sm3743993pfc.62.2020.02.21.10.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:30:28 -0800 (PST)
Subject: Re: [PATCH v2 3/7] test_firmware: add partial read support for
 request_firmware_into_buf
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
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <9afab7f8-1b5f-a7bb-6b76-f7b19efb2979@broadcom.com>
Date:   Fri, 21 Feb 2020 10:30:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220084255.GW7838@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dan,

Thanks for your review and valuable comments.
Will have to investigate fully and correct anything wrong.

On 2020-02-20 12:42 a.m., Dan Carpenter wrote:
> On Wed, Feb 19, 2020 at 04:48:21PM -0800, Scott Branden wrote:
>> +static int test_dev_config_update_size_t(const char *buf,
>> +					 size_t size,
>> +					 size_t *cfg)
>> +{
>> +	int ret;
>> +	long new;
>> +
>> +	ret = kstrtol(buf, 10, &new);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (new > SIZE_MAX)
> This "new" variable is long and SIZE_MAX is ULONG_MAX so the condition
> can't be true.
>
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&test_fw_mutex);
>> +	*(size_t *)cfg = new;
>> +	mutex_unlock(&test_fw_mutex);
>> +
>> +	/* Always return full write size even if we didn't consume all */
>> +	return size;
>> +}
>> +
>> +static ssize_t test_dev_config_show_size_t(char *buf, int cfg)
>> +{
>> +	size_t val;
>> +
>> +	mutex_lock(&test_fw_mutex);
>> +	val = cfg;
>> +	mutex_unlock(&test_fw_mutex);
> Both val and cfg are stack variables so there is no need for locking.
> Probably you meant to pass a pointer to cfg?
>
>> +
>> +	return snprintf(buf, PAGE_SIZE, "%zu\n", val);
>> +}
>> +
>>   static ssize_t test_dev_config_show_int(char *buf, int cfg)
>>   {
>>   	int val;
> regards,
> dan carpenter
>
>

