Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92566E79E
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 21:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAQUTi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 15:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjAQUQ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 15:16:26 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CED538657
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 11:11:33 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n85so7705586iod.7
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7KqTypsImNZmniW91zYe1yhsSZXhDDo+Q5hJ0Ux/67g=;
        b=UJm5J0133XcPj/n9gOAm6r3L7ghjKGThYDwcs+Zgq7sNkIMIcxWhaNZzVuL50g4xll
         axzO/2NBWRKO+Z0p4Dtg2gqYPioHnM1gdkcm2UrgwvuSHatKZ6+h4jIoNA5wP4301xq8
         bX8YgqaO+YX60wmJoloHl/jpzC+5HvvMpLLUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KqTypsImNZmniW91zYe1yhsSZXhDDo+Q5hJ0Ux/67g=;
        b=c5cShOkMA7hQ2lrQACxEE55+huzWj2Jmt2E/Znh5C8gNZVcBAyE3Zl+jeqICsO04lv
         KnI9spRAREuT0BGWbvAUX/RumVzBRTMG3n+F5gpvrQPHe25beXoKiVhv379y0ahSyUav
         KVnkzeIK5/SOzDu/IBVtfM7avsL2BpKd7PPuIrawnh0uPNHh5Xw0CdxP2yaxCggDBMG6
         5+oEkALNA+5lzma8z7sY0kh7OD/yK6Ra8uReegj0fLpauzEtOZsd+6dh3XgCso6wyxXa
         QNwVxLjh8gOk6yeUin7urE73qhP3gzgTkwfBWjaVU3QufNMMeGM6MuM4q5sT5V7QHcC8
         0NZQ==
X-Gm-Message-State: AFqh2koKOZu4gW6iTwyMhEmqqOQ8/golF8GpmTzU9VYX68Vj6okbZKUh
        qjn/IW5CmXBoRN9vCEnAQYpWlQ==
X-Google-Smtp-Source: AMrXdXv06uyeDWiXTa4ZqSisvQmjvagEnrIOsILeZlEu05Jt0IeZXrEA56J9nzCM0i6dIo4ZkDaupA==
X-Received: by 2002:a6b:8fcd:0:b0:704:d16d:4a59 with SMTP id r196-20020a6b8fcd000000b00704d16d4a59mr422934iod.2.1673982692512;
        Tue, 17 Jan 2023 11:11:32 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a7-20020a927f07000000b002eb1137a774sm9328008ild.59.2023.01.17.11.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 11:11:31 -0800 (PST)
Message-ID: <1eed08d1-c100-6ca5-63f3-73487970b08e@linuxfoundation.org>
Date:   Tue, 17 Jan 2023 12:11:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [tip:sched/core 7/28] rseq.c:139:37: error: 'AT_RSEQ_ALIGN'
 undeclared; did you mean 'R_SH_ALIGN'?
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, Shuah Khan <shuah@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <202301170348.7WLKH1pl-lkp@intel.com>
 <bfa719c3-bd1f-5fc4-40ab-6dc6822b7628@efficios.com>
 <4449d8b5-b7a5-0f09-5b42-7b70ba00f8f6@linuxfoundation.org>
 <Y8ZlKOsN1wGk9tTc@gmail.com>
 <37625f31-6ac2-1f90-d864-e4644820bba3@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <37625f31-6ac2-1f90-d864-e4644820bba3@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/17/23 10:44, Mathieu Desnoyers wrote:
> On 2023-01-17 04:06, Ingo Molnar wrote:
>>
>> * Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>> On 1/16/23 13:18, Mathieu Desnoyers wrote:
>>>> On 2023-01-16 14:40, kernel test robot wrote:
>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
>>>>> head:   79ba1e607d68178db7d3fe4f6a4aa38f06805e7b
>>>>> commit: 03f5c0272d1b59343144e199becc911dae52c37e [7/28] selftests/rseq: Use ELF auxiliary vector for extensible rseq
>>>>> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>>>>> reproduce:
>>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=03f5c0272d1b59343144e199becc911dae52c37e
>>>>>           git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>>>>>           git fetch --no-tags tip sched/core
>>>>>           git checkout 03f5c0272d1b59343144e199becc911dae52c37e
>>>>>           make O=/tmp/kselftest headers
>>>>>           make O=/tmp/kselftest -C tools/testing/selftests
>>>>>
>>>>> If you fix the issue, kindly add following tag where applicable
>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> In order to fix this, I need to change -I../../../../usr/include/ for $(KHDR_INCLUDES) in tools/testing/selftests/rseq/Makefile
>>>>
>>>> I can find 25 odd uses of the same pattern in the kernel selftests. Should I fix them all in one go ?
>>>
>>> kselftest build depends on headers installed in the root directory.
> 
> By "root directory", do you mean kernel sources root directory or build output root directory ?
> 
>>> The main makefile enforces this dependency.
> 
> How ? I figure that tools/testing/selftests/lib.mk overrides KHDR_INCLUDES if it is not defined yet:
> 
> ifeq ($(KHDR_INCLUDES),)
> KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
> endif
> 
> and selftests makefiles include ../lib.mk.
> 
> This KHDR_INCLUDES can be modified by O=... when built from the kernel top level, thus using tools/testing/selftests/Makefile:
> 
> ifneq ($(KBUILD_OUTPUT),)
> [...]
>    KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
> else
> [...]
>    KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
> endif
> 
> But it's up to the individual selftests to actually use $(KHDR_INCLUDES). In many cases, they hardcode -I../../../../usr/include/ which is bogus when the build root (O=...) differs from the source root.
> 
>   If this test is being
>>> built without installing headers by itself, I think the scripts that
>>> build individual tests have to makes sure headers are installed first.
> 
> The headers were previously built by "make O=/tmp/kselftest headers", as it should, it's just that the selftest makefile uses a hardcoded path that is relative to the source directory, and it appears that this pattern is repeated all across the selftests.
> 

selftests Makefile used to install headers and there has been a recent
change to have mani Makefile (root) to install it. As a result individual
test builds (running make in the test directory) requires header install
now.

I think the hard-coded includes are a problem and we have to fix them for
all cases i.e make O=, individual test builds.

If you are still up for it, please send patch.

thanks,
-- Shuah

