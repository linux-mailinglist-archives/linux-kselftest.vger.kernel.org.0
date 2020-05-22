Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453B81DF25F
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 May 2020 00:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgEVWtS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 18:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbgEVWtR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 18:49:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2AFC05BD43
        for <linux-kselftest@vger.kernel.org>; Fri, 22 May 2020 15:49:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci21so5630269pjb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 May 2020 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5Niesz+2MAyLragVp6DehMUQoLdj3CSU9Zt3Gj3FZgA=;
        b=clV4Tc1EUrpbmdlkOwp9Wqgo/P+RrtzAqyiBFRgmTC2+VaIklkFaWnVYOb9yytjlAB
         BulBPRmlvjlGei3ckNGeX2wlknWoMlQT+cyUkjqnYa5t+kqpJ2/0vmhYkNnIfzhTwXHN
         w4WMZhUpzH+IPlUgR8oEKOUisnTq7wpWMPPm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5Niesz+2MAyLragVp6DehMUQoLdj3CSU9Zt3Gj3FZgA=;
        b=WoWuiRNHvjxAYM0Vd19YdIMApBFZpXwM5XghUqroJ8r2BFUsUItGehi9JKuO6CkYkq
         1mcOk1EtFPZa52HsNK3uTX4Xz6Q3kUrBdonCfTqIRIgsV57yPXAGaEhALyASlrywxxkI
         RuXKvseNVRNvIT2gqqFCTfQ+mH56GsaS9yuJEA94j/4363HVBwy0i5CB965h0NDfho1W
         7Y6iCjImF7XvJEdHrsq9Y8gXxMjREAdW/OICpogJIiHS2nhazWBypCY+sDDZOcvffy+h
         e/SagFwjBqjvkavZvJnaoW5OI4x9kIjfU1tcjRPaIH1FMV0vi9cprV5g3ZWDm802kevZ
         K6Ow==
X-Gm-Message-State: AOAM530XTbkB9ijIXo+eCaRCjP3djN+TwpYm8p1IW1Gkzo8mZPuC2+1D
        zztkdYSX/goebDVMIuMr2v0z1g==
X-Google-Smtp-Source: ABdhPJy/3Z+8W3/h6QRK7NWHSKVeWfJ0+rwlb37Q0sp37fUTStq6KXecUdx34b/Znd6BtcfLNZMcvg==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr7433745pjt.170.1590187757163;
        Fri, 22 May 2020 15:49:17 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z18sm7049152pgi.68.2020.05.22.15.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 15:49:16 -0700 (PDT)
Subject: Re: [PATCH] firmware_loader: change enum fw_opt to u32
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
References: <20200522214658.12722-1-scott.branden@broadcom.com>
 <20200522224508.GE11244@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <d87aabd0-1195-64ae-d871-b0771be832a8@broadcom.com>
Date:   Fri, 22 May 2020 15:49:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522224508.GE11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Luis,

On 2020-05-22 3:45 p.m., Luis Chamberlain wrote:
> On Fri, May 22, 2020 at 02:46:58PM -0700, Scott Branden wrote:
>>   
>>   /**
>> - * enum fw_opt - options to control firmware loading behaviour
>> + * fw_opt - options to control firmware loading behaviour
>>    *
>>    * @FW_OPT_UEVENT: Enables the fallback mechanism to send a kobject uevent
>>    *	when the firmware is not found. Userspace is in charge to load the
>> @@ -33,15 +33,13 @@
>>    *	the platform's main firmware. If both this fallback and the sysfs
>>    *      fallback are enabled, then this fallback will be tried first.
>>    */
>> -enum fw_opt {
>> -	FW_OPT_UEVENT			= BIT(0),
>> -	FW_OPT_NOWAIT			= BIT(1),
>> -	FW_OPT_USERHELPER		= BIT(2),
>> -	FW_OPT_NO_WARN			= BIT(3),
>> -	FW_OPT_NOCACHE			= BIT(4),
>> -	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
>> -	FW_OPT_FALLBACK_PLATFORM	= BIT(6),
>> -};
>> +#define FW_OPT_UEVENT			BIT(0)
>> +#define FW_OPT_NOWAIT			BIT(1)
>> +#define FW_OPT_USERHELPER		BIT(2)
>> +#define FW_OPT_NO_WARN			BIT(3)
>> +#define FW_OPT_NOCACHE			BIT(4)
>> +#define FW_OPT_NOFALLBACK_SYSFS		BIT(5)
>> +#define FW_OPT_FALLBACK_PLATFORM	BIT(6)
> Everything looked good up to here. The enum defines each flag.
> We just want to use an enum for *one* flag represetnation, not
> a bundle.
I do not know exactly what you are looking for then.  The FW_OPT_* 
values are OR'd
together in the code.  You still want the fw_opt enum above left in 
place entirely
and then the values used in OR'd together?

>    Luis

