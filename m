Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46174A90D2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Feb 2022 23:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355863AbiBCWs1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Feb 2022 17:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355861AbiBCWs0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Feb 2022 17:48:26 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94745C06173B
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Feb 2022 14:48:26 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o10so3431589ilh.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Feb 2022 14:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MLeChxYmYY5CUkxIxxVQrUV/lZd8hpfLh1+m+EJdz0A=;
        b=XLOhNwHh+boGaAV3W7r97PDAFTDcLi4JGFZLgJc2Qd/1FU9gvyg3Fcw9m0X+fIXQKk
         zBvIYQTU5X3EB/zOf2yGC4FhcznkTvthPIgpIBLZlKE8zG24NOmZadIzqOQgfot4Diii
         HT+qY7Pzd7GjUX37pD7Zywo7der0xmyNRyMCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MLeChxYmYY5CUkxIxxVQrUV/lZd8hpfLh1+m+EJdz0A=;
        b=2VWuFoGVYZaO/Sg2NHFiMX6wPuWjtsQMKN9mhNvBP9LHKjxAj1EDQxDIw0lTB35V0R
         ZWA1sHESuZIAc6I32Pn+cz/3q8JGyahg+H5CrhNE0IOe+UTcO2Go7keExe/mjxIPlpz8
         u+jbq6kexdlFsA9m++gR9BRO0EdGrlqMLqiGupvXBzghYrfJ3CWPyku2AvDK5Oka4qlj
         gFICs6v2nxFNCg9f+k2oIS3DaSdw18+a9DGxI6OxX/qJtFZh6fF7pHO/Ss9W/pBqswH+
         QniCbVdpiWJvi+8pseOXZYjbmkjZlkHMjOdq72nTEKRvnYHkrtydM5b2n1qCSP22XqXu
         Gk2A==
X-Gm-Message-State: AOAM530vn8EGt/YtJiDwFH2Jx5ljBwmb4cpQHQVrG9/d8yOWRIcX9cjS
        mRRH/M8MpDdOa0sSJTWbRye7Cg==
X-Google-Smtp-Source: ABdhPJwG0qE6zCH0vXbQKCtjs5jTysF5RevrnOV/ZHA12Y76M1wQ67IBTPApS+cF1n/5neNLjk1w8w==
X-Received: by 2002:a92:d387:: with SMTP id o7mr139128ilo.26.1643928505787;
        Thu, 03 Feb 2022 14:48:25 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id x4sm127153ilv.2.2022.02.03.14.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 14:48:25 -0800 (PST)
Subject: Re: kselftest tree on kernelci.org
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <5fd1a35c-f84e-1c6a-4a3a-be76dda97ca3@collabora.com>
 <ece6ea91-c44b-0bea-c4a2-ec099fa94881@linuxfoundation.org>
 <bc705b2c-b2d7-c80f-7020-ee52a2aeb061@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8813e862-c280-c6c6-abc5-b62b372ff34a@linuxfoundation.org>
Date:   Thu, 3 Feb 2022 15:48:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bc705b2c-b2d7-c80f-7020-ee52a2aeb061@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/3/22 11:19 AM, Guillaume Tucker wrote:
> On 02/02/2022 15:23, Shuah Khan wrote:
>> Hi Guillaume,
>>

> 
> I see these 4 branches (fixes, next, kunit, kunit-fixes) are all
> merged into linux-next.  So it seems like the best thing to do
> would be to cover them with a very lightweight number of builds and
> tests focused on what they are about: only run kselftest on the
> fixes and next branches, and only KUnit on kunit and kunit-fixes.
> At the moment, KUnit is not run by kernelci.org (coming soon) so I
> think we could just add the next branch for kselftest.  Then
> linux-next will be tested with maximum coverage anyway so if
> something subtle gets missed with the early tests it should get
> caught the following day at the latest with linux-next.
> 
>>> Many things could potentially be done with arbitrary builds and
>>> tests etc.  These are some initial suggestions.  How does this
>>> sound?
>>

Sounds good to me. The things that tend to break are:

- test builds at times due to seemingly innocuous changes to fix
   static analysis warnings. build test is good for catching these
-

>> Sounds great to me. Since selftest patches flow through various
>> subsystem trees, having kernelci keep an eye is great. This would
>> be another pair of eyes in addition to occasional tests I run and
>> Linaro (LKTP) monitoring next.
>>
>> How often do you send reports - I will watch out for them. Thanks
>> again for taking the initiative to add kselftest to kernelci.
> 
> Builds and tests are run every time a new revision is detected on
> the branches being monitored.  Then when they complete, a report
> is sent.  It can take a while, but with a small number of builds
> you could get results within an hour.  We could get the reports
> sent to the linux-kselftest mailing list and your own address if
> you want.
> 

Please send it to my email address as well.

> Also this configuration is all under source control on GitHub so
> feel free to make changes to it in the future as you see fit.
> 

Will do.

thanks,
-- Shuah

