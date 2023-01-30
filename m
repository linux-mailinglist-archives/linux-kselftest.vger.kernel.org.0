Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA204681FEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 00:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjA3Xs6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 18:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjA3Xs4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 18:48:56 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADF52CFCB
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 15:48:55 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q6so2402720ior.12
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 15:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sv9LM6FCsX+XLQLlczZJ3ogJ6u9sp27c4JRuQ8D9oio=;
        b=SN109vrWZf9cxs6KFGl4MAL63j0Sl4/U5xFRXrWW8hFN+MDbBNYUHS6JsHQKPh7tMu
         k4uCwm241mGFmPLuj2uZfBQUZBN35tdzdp9nirS8ZOpiGdXpN0PUcm/QOaIqg9oZqeFP
         7EBjChBZzZVqmdRgWmVcyJSdMTCqTqAuz9tbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv9LM6FCsX+XLQLlczZJ3ogJ6u9sp27c4JRuQ8D9oio=;
        b=gQ/JbANuwprci2tmaQ64Ct7ws/uVys6sUWBV1m7ZBs969MoxqHQ5TpvcnhiohO2J/C
         4j6Gu/A46ovG5/gZ9sZCoJ/N4jKC+MzijFNCs022b/ZptKEVTLmX0ChpvofFwHbPqx3B
         WaBgjInZRvJSBIlD+gp8BGrcSe6ZaDhA1NWyrU7ip3Ah6o5+Irw5pwL21LxWIotFVE8F
         14cLTQQ8ts6hPSkzfniNac3Hp6o/sEpngMwH4NOxGY4mwuoYtkJ4lEKhsgYJmY373zN+
         clsPweccIiR78ekQ4iprDgiTukoDfnrzQBhkYR5v6MRECTm6YTwNlcozZUfI5rmDfU9k
         I4Qw==
X-Gm-Message-State: AO0yUKWSNuKSR3wZV+FXFPEufdq+1IQuy8uOXX2scaXLLl4z/Y8EICX3
        YZfD3X1EH8o8rpl9WE3lVwNjaw==
X-Google-Smtp-Source: AK7set/3JVSpyoClMsRL6+JQvwoSOPsVcasMV+N0EMQk0vrkc2ryYm7TK2SH7HJjWKS8ryISa7yKXw==
X-Received: by 2002:a6b:bb05:0:b0:716:8f6a:f480 with SMTP id l5-20020a6bbb05000000b007168f6af480mr1706523iof.0.1675122534791;
        Mon, 30 Jan 2023 15:48:54 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u23-20020a02aa97000000b0039d71c46577sm5308375jai.21.2023.01.30.15.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 15:48:54 -0800 (PST)
Message-ID: <ae22eee7-eb91-427b-a90a-a5a5e1dc4166@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 16:48:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/34] selftests: Fix incorrect kernel headers search path
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <560824bd-da2d-044c-4f71-578fc34a47cd@linuxfoundation.org>
 <CAADnVQLV+BERfHNUeii=sZfU+z4WF-jsWUN8aMtzv0tYxh9Rcw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAADnVQLV+BERfHNUeii=sZfU+z4WF-jsWUN8aMtzv0tYxh9Rcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/30/23 16:45, Alexei Starovoitov wrote:
> On Mon, Jan 30, 2023 at 2:46 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 1/27/23 06:57, Mathieu Desnoyers wrote:
>>> Hi,
>>>
>>> This series fixes incorrect kernel header search path in kernel
>>> selftests.
>>>
>>> Near the end of the series, a few changes are not tagged as "Fixes"
>>> because the current behavior is to rely on the kernel sources uapi files
>>> rather than on the installed kernel header files. Nevertheless, those
>>> are updated for consistency.
>>>
>>> There are situations where "../../../../include/" was added to -I search
>>> path, which is bogus for userspace tests and caused issues with types.h.
>>> Those are removed.
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>> Mathieu Desnoyers (34):
>>
>> The below patches are now applied to linux-kselftest next for Linux 6.3-rc1
>>
>>>     selftests: arm64: Fix incorrect kernel headers search path
>>>     selftests: clone3: Fix incorrect kernel headers search path
>>>     selftests: core: Fix incorrect kernel headers search path
>>>     selftests: dma: Fix incorrect kernel headers search path
>>>     selftests: dmabuf-heaps: Fix incorrect kernel headers search path
>>>     selftests: drivers: Fix incorrect kernel headers search path
>>>     selftests: filesystems: Fix incorrect kernel headers search path
>>>     selftests: futex: Fix incorrect kernel headers search path
>>>     selftests: gpio: Fix incorrect kernel headers search path
>>>     selftests: ipc: Fix incorrect kernel headers search path
>>>     selftests: kcmp: Fix incorrect kernel headers search path
>>>     selftests: media_tests: Fix incorrect kernel headers search path
>>>     selftests: membarrier: Fix incorrect kernel headers search path
>>>     selftests: mount_setattr: Fix incorrect kernel headers search path
>>>     selftests: move_mount_set_group: Fix incorrect kernel headers search
>>>       path
>>>     selftests: perf_events: Fix incorrect kernel headers search path
>>>     selftests: pid_namespace: Fix incorrect kernel headers search path
>>>     selftests: pidfd: Fix incorrect kernel headers search path
>>>     selftests: ptp: Fix incorrect kernel headers search path
>>>     selftests: rseq: Fix incorrect kernel headers search path
>>>     selftests: sched: Fix incorrect kernel headers search path
>>>     selftests: seccomp: Fix incorrect kernel headers search path
>>>     selftests: sync: Fix incorrect kernel headers search path
>>>     selftests: user_events: Fix incorrect kernel headers search path
>>>     selftests: vm: Fix incorrect kernel headers search path
>>>     selftests: x86: Fix incorrect kernel headers search path
>>>     selftests: iommu: Use installed kernel headers search path
>>>     selftests: memfd: Use installed kernel headers search path
>>>     selftests: ptrace: Use installed kernel headers search path
>>>     selftests: tdx: Use installed kernel headers search path
>>>
>>
>> These will be applied by maintainers to their trees.
> 
> Not in this form. They break the build.

Mathieu is sending you the patches in the format you requested in
the thread on this patch.

thanks,
-- Shuah
