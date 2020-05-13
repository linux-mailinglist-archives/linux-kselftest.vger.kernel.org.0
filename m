Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5D1D1DA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 May 2020 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390195AbgEMSjj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 May 2020 14:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389392AbgEMSjj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 May 2020 14:39:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC784C061A0C
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 11:39:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so752965wru.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QevyPaB54vabz1NgQweuhMZ/4PP5dMX078Hx9aqjxfc=;
        b=ewIInpz3Jv/IrkCkWkGiBC6UAat93L2zYEJfVB/67p9YtVYuw3NEVn0LJQPhSBnoBR
         pZUumCJ55i5Nmpq7zEeDDK+k0WKMCo5B9vDp02gV9BZTg4fT1dN/flqFNi79peEEs67R
         mFiPZ7/V5n0/0I8UIXjKTwwVnG1krpdxHa9WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QevyPaB54vabz1NgQweuhMZ/4PP5dMX078Hx9aqjxfc=;
        b=jBm6r1ytR/jH8UwYyZRj4YwMZZwxnle6nOfCCsox3Fxw8jYhIZbtoeOn+K8Uwd4WYf
         8eYplh2j9YggxCWX+YncHjnIdJrrQw0+tXVeRelVxWByf0OODxQVYigsbJOigmEXki+D
         lq3r8ipRiPdjWBz13prHe+eyS5xxxTNoGMYz1mqh6W8/0iLmAZQNaypt7R1OQIvqzZne
         LLQYHZbh0VQg1/Gt1p/8uKHQzBTAz98Q3LE+LRqQ0tCxyi/9F0etDJrMxLE6gBt4HuxY
         hK3taZ3fNqFbwzCVbTBhofOkKWbnpzA2QEtJCNcygC0p6peVxTT/KM+HcCEmHQgHzjqB
         2MQQ==
X-Gm-Message-State: AOAM530lcFVJBtI5u8KvZBK5JWH5OtIck4OP2pH+0ebQwv6FfQTxJ3qE
        vGwn1IgH/NOCS6LXcrV43+Qt2g==
X-Google-Smtp-Source: ABdhPJzhf+mYsAycvYoLOXU1WHfMH8XPnenYApwbY7dPsUsGlZ8N8UGzdao3+8+YZVroo8SME6sfvg==
X-Received: by 2002:adf:e38b:: with SMTP id e11mr706640wrm.343.1589395177524;
        Wed, 13 May 2020 11:39:37 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x24sm501774wrd.51.2020.05.13.11.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 11:39:36 -0700 (PDT)
Subject: Re: [PATCH v5 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Brown <david.brown@linaro.org>,
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
 <60372b2f-c03d-6384-43a7-8b97413b6672@broadcom.com>
 <20200513065046.GA764247@kroah.com>
 <20200513123033.GL11244@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <2eaa3047-4833-8d1c-d8c7-fc602468eae3@broadcom.com>
Date:   Wed, 13 May 2020 11:39:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513123033.GL11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks for link.

On 2020-05-13 5:30 a.m., Luis Chamberlain wrote:
> On Wed, May 13, 2020 at 08:50:46AM +0200, Greg Kroah-Hartman wrote:
>> On Tue, May 12, 2020 at 11:31:28PM -0700, Scott Branden wrote:
>>
>> That's not how kernel drivers in the tree work, sorry.  They do not
>> contain "older kernel support" in them, they work as a whole with the
>> rest of the kernel they ship with only.
>>
>> Otherwise all drivers would be a total mess over time, can you imagine
>> doing this for the next 20+ years?  Not maintainable.
> Scott, now imagine the amount of cleanup you'd need to do to your driver
> to get it to a state where it doesn't depend on any old kernel. That's
> the exact shape of the driver we want.
>
> To backport, you can look into the backports project which strives to
> backport drivers automatically [0] to older kernels.
>
> [0] https://backports.wiki.kernel.org/index.php/Main_Page
>
>    Luis
Will drop legacy support from patch and look closer at this.

Thanks,
  Scott
