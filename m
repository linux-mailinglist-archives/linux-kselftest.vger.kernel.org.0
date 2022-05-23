Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80637530D77
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 May 2022 12:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiEWJmY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 May 2022 05:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiEWJk5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 May 2022 05:40:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA84F2F01E;
        Mon, 23 May 2022 02:40:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id A46991F42DD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653298845;
        bh=V0M8DYvWpS0+hFL3tgf2bcMHWIfVb8jn4R+BMUFe68g=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=O9ZVdiVM5v1oBXV+1BXIVW0M2VmQ+HfXjC+3XBYXhMWGwaziMJJ0rG9DRsseuYSV9
         JzSbS7XMPnN3G/5WICA/JK/ENZgqOa62BTrOOrdanpuDbTSi+CvKIkPr8Wf5jPzmF+
         J/UeZSQk8xU0UnqqOeJkM6uKTVrIY74HR1R0QL7ybH2mdi+l/VoX6myQ23BrhtwIRv
         jU8cQmVLVfVaAXvL9aG1dZ+WBxMnAUL+sq+U/OdhgFpwSh9dFeElK4o63xCRpwsyzf
         8lEtJdPgLftM0NesautwPWh+7McBB8olXPES6CyqmP2GL+qmwM/2KuD0gL9v2gvrae
         iyiQoCHn9GjDA==
Message-ID: <19f72a58-b80e-f6a8-842f-a924c4b94eeb@collabora.com>
Date:   Mon, 23 May 2022 14:40:39 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Cc:     usama.anjum@collabora.com, Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernelci@groups.io" <kernelci@groups.io>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [Bug Report] - kselftest build fails if output directory is first
 level sub-directory
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <c25d7ea7-4f72-4a2b-d8c3-d317e64fcbbb@collabora.com>
 <CAK7LNATL4nMmKgrjS8meavnpn=HisD30QxuPUKDqtWWgbGcSZw@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAK7LNATL4nMmKgrjS8meavnpn=HisD30QxuPUKDqtWWgbGcSZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/22/22 10:15 PM, Masahiro Yamada wrote:
> On Sat, May 21, 2022 at 3:44 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Hello,
>>
>> kselftest can be built using the kernel's top most Makefile without
>> using kselftest's Makefile directly. But there is bug in the top most
>> Makefile. The build fails if the specified output directory is first
>> level sub-directory. Here is a example to reproduce this bug:
>>
>> make kselftest-all O=build
>>
>> "The Make is working in a wrong directory, that is why the relative path
>> does not work." Masahiro Yamada. Feel free to fix it if someone pin the bug.
>>
>> It should be noted that the build works in some other combinations:
>> make kselftest-all (works)
>> make kselftest-all O=/tmp (works)
>> make kselftest-all O=build/build2 (works)
>>
>> My unsuccessful attempt to fix this bug can be found here:
>> https://lore.kernel.org/lkml/20220223191016.1658728-1-usama.anjum@collabora.com/
>>
>> Thanks,
>> Muhammad Usama Anjum
> 
> 
> This problem starts from the bad design of the kselftest framework.
> I did some research before. I think I can fix the root cause but
> currently I do not have enough time to do it.
> 
> 
> KBUILD_ABS_SRCTREE is a user-interface to request
> Kbuild to use the absolute path.
> If it is forced in the top Makefile, users have no way to
> negate it.
> It is true that using the absolute path is a quick work-around
> because you do not need to care about the current working directory.
> 
> If you insist on it,  just go ahead.  It is just two line changes.
> Once the issue is fixed in a better way, your patch can be reverted easily.
Thank you for replying. Lets merge it Shuah?

> 
> 
> 

-- 
Muhammad Usama Anjum
