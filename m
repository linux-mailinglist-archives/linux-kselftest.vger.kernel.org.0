Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F06453FF90
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jun 2022 14:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbiFGM7U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jun 2022 08:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbiFGM7U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jun 2022 08:59:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F07E1E5;
        Tue,  7 Jun 2022 05:59:16 -0700 (PDT)
Received: from [192.168.10.2] (unknown [39.45.211.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 109BB6601A93;
        Tue,  7 Jun 2022 13:59:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654606753;
        bh=9JJBYEJ8zgWRS0TkuTNuviAp0OHZJFNQgrUOzPFMb/Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=j80nrx+i/tivfcroiApdGKj7zraPe7Ge+S3DP8EupDQyWr+/pd+gDCeqyXK225kFi
         W9K5+n1PKMBZ0/7zhb0rIh13ygzCDwbqedPX8zktd3RO2+ubU7gzztkbvMWGQP9WPO
         saPRkZiQU2WY8Kz42yM5vSDj/+BBqbH3bvwzr6HX6lLFWw+5xaAkb2fN3GMaWHDU11
         q/zG2NjD9LOXZNaCKMVMHRil0dyThUBD/eoFueFbjdPgrZ+Wrhd8wwbu8VPI5cHFkp
         pLsBy6BX1Hz6m1la7ukbqLWZyr9/4wE7w2PJgY+nDRX5ifTjORCXFxHZO37ByScS9M
         9lzNbbISMthQQ==
Message-ID: <d4c131b3-7a40-f6fb-9d7d-424c849659fb@collabora.com>
Date:   Tue, 7 Jun 2022 17:59:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Cc:     usama.anjum@collabora.com, Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernelci@groups.io" <kernelci@groups.io>,
        Collabora Kernel ML <kernel@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [Bug Report] - kselftest build fails if output directory is first
 level sub-directory
Content-Language: en-US
To:     Shuah Khan <shuah@kernel.org>
References: <c25d7ea7-4f72-4a2b-d8c3-d317e64fcbbb@collabora.com>
 <CAK7LNATL4nMmKgrjS8meavnpn=HisD30QxuPUKDqtWWgbGcSZw@mail.gmail.com>
 <19f72a58-b80e-f6a8-842f-a924c4b94eeb@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <19f72a58-b80e-f6a8-842f-a924c4b94eeb@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Should we merge this?

Thanks,
Usama

On 5/23/22 2:40 PM, Muhammad Usama Anjum wrote:
> On 5/22/22 10:15 PM, Masahiro Yamada wrote:
>> On Sat, May 21, 2022 at 3:44 PM Muhammad Usama Anjum
>> <usama.anjum@collabora.com> wrote:
>>>
>>> Hello,
>>>
>>> kselftest can be built using the kernel's top most Makefile without
>>> using kselftest's Makefile directly. But there is bug in the top most
>>> Makefile. The build fails if the specified output directory is first
>>> level sub-directory. Here is a example to reproduce this bug:
>>>
>>> make kselftest-all O=build
>>>
>>> "The Make is working in a wrong directory, that is why the relative path
>>> does not work." Masahiro Yamada. Feel free to fix it if someone pin the bug.
>>>
>>> It should be noted that the build works in some other combinations:
>>> make kselftest-all (works)
>>> make kselftest-all O=/tmp (works)
>>> make kselftest-all O=build/build2 (works)
>>>
>>> My unsuccessful attempt to fix this bug can be found here:
>>> https://lore.kernel.org/lkml/20220223191016.1658728-1-usama.anjum@collabora.com/
>>>
>>> Thanks,
>>> Muhammad Usama Anjum
>>
>>
>> This problem starts from the bad design of the kselftest framework.
>> I did some research before. I think I can fix the root cause but
>> currently I do not have enough time to do it.
>>
>>
>> KBUILD_ABS_SRCTREE is a user-interface to request
>> Kbuild to use the absolute path.
>> If it is forced in the top Makefile, users have no way to
>> negate it.
>> It is true that using the absolute path is a quick work-around
>> because you do not need to care about the current working directory.
>>
>> If you insist on it,  just go ahead.  It is just two line changes.
>> Once the issue is fixed in a better way, your patch can be reverted easily.
> Thank you for replying. Lets merge it Shuah?
> 
>>
>>
>>
> 

-- 
Muhammad Usama Anjum
