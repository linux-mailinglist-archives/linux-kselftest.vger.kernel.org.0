Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6CD516864E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2020 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgBUST5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Feb 2020 13:19:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40713 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBUST5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Feb 2020 13:19:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so2891380wmi.5
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2020 10:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wDHwJafHUYO4eJUK4woQfDUsS2PWqX2xUsdpzcXqvFo=;
        b=B/Bxn87ldHGPpmiTejB0PK8srG8CJRhgFVKn9I55oBbSoCzibcaXDBEHoNaolzi0Mt
         ofSZAF5YXhhDTxrcXv/eWWGU6G6/l/ES+cdyBP2XSvO03A7ZAulAFAhqGCg/mucLRFo6
         FQfnU/k2JlRY2372nKHUW5GEwaCh6dlpk5b9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wDHwJafHUYO4eJUK4woQfDUsS2PWqX2xUsdpzcXqvFo=;
        b=AmrLQA3LdA692knFlFnkTa60raKlga6BOz1y820KiHtTQngnRWe5nGYWL17AsEh0St
         63lp6YS3EOxUaDzwm5oWsan9QKgPQYeKx8lkFYiWhN59wXqHxSZ37ayCFCbCiHeayLvh
         tnca4Lw4C6bWLU/NKmCzRv7m+QkIE7F0qaPR4ygcFAyg7kBz5p09LDGACqukY2crjp79
         98KPR71CfRZ47dnePfxRg+Z7KvSZXLWoUbwJWb3c2WbWiXFYqxm76cXu6Hh5XF9R2Z2n
         vnG8SiE7rPNwcgR8dFseXI5YSpnYcIORG6xJfxKBfRaVVJalK0g100FNIOuw3mHqmP9K
         p36A==
X-Gm-Message-State: APjAAAW2PE3k+JH0tw1mmeUL+i/0lp8oI4oKpYMmoRgndiL3xE6VK5hd
        1QysmJGVvfMPBX6M5Hp3AIEFiA==
X-Google-Smtp-Source: APXvYqzQllr5uOwYGgFCk0oHK40yf7h67oQJx51bljL82rI3X++tkuZFqlo3TgkHXjrZ1TXYNvDhLg==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr5182272wmk.160.1582309195576;
        Fri, 21 Feb 2020 10:19:55 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p5sm4789500wrt.79.2020.02.21.10.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:19:51 -0800 (PST)
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com>
 <20200220074711.GA3261162@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <ee53fe6f-53de-87c0-db16-989cc15abbce@broadcom.com>
Date:   Fri, 21 Feb 2020 10:19:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220074711.GA3261162@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2020-02-19 11:47 p.m., Greg Kroah-Hartman wrote:
> On Wed, Feb 19, 2020 at 04:48:24PM -0800, Scott Branden wrote:
>> Add Broadcom VK driver offload engine.
>> This driver interfaces to the VK PCIe offload engine to perform
>> should offload functions as video transcoding on multiple streams
>> in parallel.  VK device is booted from files loaded using
>> request_firmware_into_buf mechanism.  After booted card status is updated
>> and messages can then be sent to the card.
>> Such messages contain scatter gather list of addresses
>> to pull data from the host to perform operations on.
> Why is this a tty driver?
We have a tty driver here as there are (multiple) console interfaces to 
the card.
The only viable interface to the card is through the PCIe bus.  We can't 
hook up cables to the card to get at the consoles.
As such we implemented a tty driver to access the console via a circular 
buffer in PCIe BAR space.

It is extremely useful.  You get console access to virtual serial ports 
connected to each processor inside the VK SoC.
Future enhancement is to connect the tty driver to use an MSIX interrupt 
rather than polling.
Once that is done lrz/sz transfers will be much quicker.  I'd also look 
at if I could use ser2net to get network access
for the processors on the VK SoC over this interface as well.
>
> Have you worked with the V4L developers to tie this into the proper
> in-kernel apis for this type of functionality?
We looked at the V4L model doesn't have any support for anything we are 
doing in this driver.
We also want a driver that doesn't care about video.  It could be 
offloading crypto or other operations.
We talked with Olof about all of this previously and he said leave it as 
a misc driver for now.
He was going to discuss at linux plumbers conference that we need some 
sort of offload engine model that such devices could fit into.
> Using a tty driver seems like the totally incorrect way to do this, what
> am I missing?
tty driver is used to provide console access to the processors running 
on vk.
Data is sent using the bcm_vk_msg interface by read/write operations 
from user space.
VK then gets the messages and DMA's the data to/from host memory when 
needed to process.
>
> Also, do not make up random error values, you return "-1" a lot here,
> that is not ok.  Please fix up to return the correct -Ewhatever values
> instead.
OK.
>
> thanks,
>
> greg k-h

