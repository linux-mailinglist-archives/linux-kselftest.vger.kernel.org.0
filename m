Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C211854A35F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 03:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiFNBC6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 21:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243576AbiFNBCz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 21:02:55 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03891275D6
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jun 2022 18:02:55 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id z11so5540070ilq.6
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jun 2022 18:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U3JKGYdmDlTw2F6x4avaOz6AUUg72m8v/vKLi53Y55o=;
        b=XPZgm7k4Cr+yPljAMD4+l1gO8xn+qimmbENRm+RaANbnTnLnnT5pKGzGk8PgG32Khc
         iAkDtoPCQ/wON3/pUPsTgNmtdbXG0wwTvBs57F0uvqxPeZFlIQQOCgLJa5LQadT01GAZ
         I7Nf/wsGY2tQWr515zVi6wd2yLpGX4NCnvI+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U3JKGYdmDlTw2F6x4avaOz6AUUg72m8v/vKLi53Y55o=;
        b=QQtAoVbR98i67YUn7JnOyEnOCKNRJSsUzNoSVz0rmyYZDI50iCitfqKKZFTAJri280
         uDS04NtSOUuXLaeYMy/dzc+ciXw1W2juzprqMDEj1BbHGn5vpZHEJRn5elrL7xf+uRkS
         V8Q7h+lh3/YkfULUjz681FqCVuVr4E7izHOsKOQoy24M5i9WhwLxyykJkc9L2UoqbtHL
         +J5PNAlWuEaFtie7r41fBIToS5gIqsWsrckeTLVQp1sMAxfw5BQ/1tRjzfnFHSAzNEhu
         pm/VZVUOwK2g+H7hawRd8bkTcglwNKKuzgKSkB3EYQ/3Md3NnPbyhUSkq/Ec2E9UcPd/
         H8jw==
X-Gm-Message-State: AJIora+sAnRdFyd9FD0XlCUSf+2jBFiX9Nhv1cP+vrHcHyhSnJFB9MoC
        7XLdJYuMeC45KWs44e306g6NAQ==
X-Google-Smtp-Source: AGRyM1tiRrBBCbPwtYpv2ZRItmEb/a9UGRnjSmhR0oelcDd+j7k6iVl1VwFTfEx6eRJBxnEqUrVWnA==
X-Received: by 2002:a92:da4c:0:b0:2d5:4942:151c with SMTP id p12-20020a92da4c000000b002d54942151cmr1462803ilq.54.1655168573945;
        Mon, 13 Jun 2022 18:02:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v19-20020a02cbb3000000b0032e3b0933c6sm4176608jap.162.2022.06.13.18.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 18:02:53 -0700 (PDT)
Subject: Re: [PATCH 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
To:     Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220603143242.870-1-mpdesouza@suse.com>
 <c5dc436e-2e3f-db2c-5cd5-215a9af19152@linuxfoundation.org>
 <5966397b-5577-8075-ffdd-f32e5e4ca75a@redhat.com> <YqNZwBWJmi5E/Nvo@alley>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a45df8ff-ce6b-e7c8-323d-6c37ad38f5ae@linuxfoundation.org>
Date:   Mon, 13 Jun 2022 19:02:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YqNZwBWJmi5E/Nvo@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/10/22 8:48 AM, Petr Mladek wrote:
> On Fri 2022-06-10 09:06:16, Joe Lawrence wrote:
>> On 6/9/22 4:16 PM, Shuah Khan wrote:
>>> On 6/3/22 8:32 AM, Marcos Paulo de Souza wrote:
>>>> Hi there,
>>>>
>>>> The first patch moves the current livepatch tests to selftests,
>>>> allowing it
>>>> be better suited to contain more complex tests, like using userspace C
>>>> code
>>>> to use the livepatched kernel code. As a bonus it allows to use
>>>> "gen_tar" to export the livepatch selftests, rebuild the modules by
>>>> running make in selftests/livepatch directory and simplifies the process
>>>> of creating and debugging new selftests.
>>>>
>>>
>>> In general selftests don't include modules. We keep test modules under lib.
>>> One of the reasons is that modules have dependencies on the kernel and
>>> should
>>> be built when kernel is built.
>>>
>>> I don't fully buy the argument that moving modules under selftest would
>>> simplify
>>> the process.
>>>
>>
>> Hi Shuah,
>>
>> I see that there is tools/testing/selftests/bpf/bpf_testmod/ which
>> claims to be a "conceptually out-of-tree module".  Would similarly
>> moving livepatch test modules under tools/ give us flexibility to write
>> them build for multiple kernel versions?  Then one could theoretically
>> build and run the latest, greatest selftests against older kernels
>> (assuming the associate script/module/kernel supports the idea)?
> 
> +1
> 
> Another motivation is that the new selftest also needs
> an executable binary. It would be nice to handle both modules
> and binaries the same way.
> 
> Honestly, lib/* is a mess. It mixes real functionality and test
> modules. The relation between the modules and tools/testing/*
> is far from clear. IMHO, it would be more clean to have the related
> stuff together.
> 
> Of course, we could not move all test modules from lib/* easily.
> Some of them might be used on its own or even as built-in
> tests. But preventing the move looks like a step in
> the wrong direction to me.
> 

As such bpf_testmod is the only one that is currently under kselftests.
I don't have an objection to it from technical stand point. My concern
is more from the standpoint of people writing modules that can't be built
out of tree. We would add another requirement to kselftest that the out
of tree modules should build successfully.

As long as that concern is addressed and also test gracefully fails if the
module fails to build, we can move on that direction. I would hesitate to
extend this to modules dependent on hardware and architecture features
such as cpufreq test drivers for example.

thanks,
-- Shuah
