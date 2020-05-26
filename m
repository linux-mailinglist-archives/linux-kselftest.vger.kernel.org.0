Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3251D5CBD
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 May 2020 01:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgEOX2O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 May 2020 19:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgEOX2N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 May 2020 19:28:13 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4CCC05BD09
        for <linux-kselftest@vger.kernel.org>; Fri, 15 May 2020 16:28:13 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f6so1728209pgm.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 May 2020 16:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=E8j1zsP3t9Db9IDf/V9aE8nyZ2/Ryf+TXAxn3gqfEkQ=;
        b=UnQQdzA2k7WTu3soGTuHp6WGTD+qiK8qSJb8mk1Pn9H2eum+E9Ts+BBJn73fEbeHhn
         RCvwsXpvTKZDN9nf0ieSFsKQIBNAAhSy3JGMSLqfTBgCWzn69SZ6AjRrdwRptGXc6OxA
         GMwQn9MzvTX7QqrnZx+alQ0//TqjxC7Ikw4bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E8j1zsP3t9Db9IDf/V9aE8nyZ2/Ryf+TXAxn3gqfEkQ=;
        b=roC8CDMLGqcUHitohdvV87btms7YWLhv0g2qEgP98akiVJwUvU3dirOmF8W4OoSz11
         kyCxtgH+sUNu4qwjenZQ6AcPbMEv3wcpr+YTHqcBqe3FxXG04Ew/n3yO0orU04h87f2/
         9i6UYvlO44u8OViL2qF68XMrc4K7wb2eSf2W+6ZK1sLe8dxVFwScEmhrtrD91986WZ3F
         jUvpTmUWsLpsGyR2u/TFu4Km62AopOF8ASQHxnpjKJJP+wKVmyygRI1WVzptpyY3th3N
         I5p5j93K8nsyGYOnPYUYkmDV1sf9zVtvcU9ZahBdjGmWbw3aIjtMQUa+oNrZZMzCaTx7
         3sdQ==
X-Gm-Message-State: AOAM532xD0dGrIjvKM/cdiTd4u8s/XbJR6lnuvgJ4c2q1o9vS2ln5s72
        i+uauHQrE9ehh//6Isq8I8eIZQ==
X-Google-Smtp-Source: ABdhPJzDjdFyP0pP2LVm3Q8vARDClgR1ApLEZE6gM2tCxeAVs7H8OmgkHRMJ22dzucxwh+mZ6qJIdA==
X-Received: by 2002:aa7:9302:: with SMTP id 2mr6259587pfj.256.1589585292833;
        Fri, 15 May 2020 16:28:12 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b13sm2543954pgi.58.2020.05.15.16.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 16:28:11 -0700 (PDT)
Subject: Re: [PATCH v5 0/7] firmware: add partial read support in
 request_firmware_into_buf
To:     Luis Chamberlain <mcgrof@kernel.org>, Mimi Zohar <zohar@kernel.org>
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
 <1589387039.5098.147.camel@kernel.org>
 <20200515204700.GC11244@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <1e75c270-eae5-8f1d-ecc6-1fd2fb248f29@broadcom.com>
Date:   Fri, 15 May 2020 16:28:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515204700.GC11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Luis,

On 2020-05-15 1:47 p.m., Luis Chamberlain wrote:
> On Wed, May 13, 2020 at 12:23:59PM -0400, Mimi Zohar wrote:
>> Hi Scott,
>>
>> On Thu, 2020-05-07 at 17:27 -0700, Scott Branden wrote:
>>> Please consider this version series ready for upstream acceptance.
>>>
>>> This patch series adds partial read support in request_firmware_into_buf.
>>> In order to accept the enhanced API it has been requested that kernel
>>> selftests and upstreamed driver utilize the API enhancement and so
>>> are included in this patch series.
>>>
>>> Also in this patch series is the addition of a new Broadcom VK driver
>>> utilizing the new request_firmware_into_buf enhanced API.
>> Up to now, the firmware blob was read into memory allowing IMA to
>> verify the file signature.  With this change, ima_post_read_file()
>> will not be able to verify the file signature.
>>
>> (I don't think any of the other LSMs are on this hook, but you might
>> want to Cc the LSM or integrity mailing list.)
> Scott, so it sounds we need a resolution for pread for IMA for file
> signature verification. It seems that can be addressed though. Feel
> free to submit the u32 flag changes which you picked up on though in
> the meantime.
Sure, I can submit a new patch to change the existing enum to
a u32.  For the new pread flags I am adding I could also leave as
a u32 or change from a u32 to an enum since there is currently only
one flag in use.  Then, in the future if another flag was added we would 
need
to change it back to a u32.

Please let me know what you prefer for the pread_flags.
>
>    Luis
Thanks,
  Scott
