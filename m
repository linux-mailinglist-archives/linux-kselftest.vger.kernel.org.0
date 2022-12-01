Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC91263FC68
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 00:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiLAX67 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 18:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiLAX6n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 18:58:43 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029FCC7242
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 15:58:42 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id d14so1455084ilq.11
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Dec 2022 15:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmr7G8WA4Q1Nw43pzIc6PULkeAuv/I4fA+tW++foTfg=;
        b=EHzcnH/SpQ9u5wDNpr658lLnobcH9ThK906nW6V5UAziYjE3IqoehgdsXhf4/oHooB
         IniFFCHmKDskeZ9KbnkM3Wrdsg/tMKWBkT0Q4MoOBWYfA1crDT+RvBxYnz78/4EIUQtw
         kE3blyd2cjvghEtPbmVGEpiSWRbSyF+5WiVvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmr7G8WA4Q1Nw43pzIc6PULkeAuv/I4fA+tW++foTfg=;
        b=P0Z8AG19qVJghP3moR2RNECJO/Y9SGKAE/6ObSa7wLKS1iyqRbijOiQy1HnG7FsFRv
         0V1k+qHwHsMkhXynXWcf9Lqhp/zwBL2J2KkumHDHjFHZW6f92XOY0ipmRnDTRJmWW5rG
         y6YuyFlQ0FBqaxBA8c0dmn2CsnpZbHidEBPTQRdbzhWo5BScaIjaFypY3ER2xWjttpjy
         pnme7cjdRq09jPiC+8VisE/EQczqqEuikl+hgHHCpNgfvVn7nRwbmSoMQciA2sZkLt4Q
         gqqbdqsNtbYL7x3fgctZFQe2Iu7cTNEQAEhS9ERUMkRGqw3ySQlLNWFI2K/bYSAyp6nU
         o06Q==
X-Gm-Message-State: ANoB5plEqYfF7QadwJznDbY6aEW+O3uO4E9xCgy3s6DVj45xylkLGll2
        rdr4hhvkqlj7oxFQD/l90gMfiw==
X-Google-Smtp-Source: AA0mqf7MJDJ2Yi3CnLvhd005w2bkmVeN+ouC0SBbUwS1dDkWyTppvgwklbIzvIWqXLFusAt2/M6gLA==
X-Received: by 2002:a05:6e02:586:b0:303:3119:420e with SMTP id c6-20020a056e02058600b003033119420emr3496685ils.320.1669939121189;
        Thu, 01 Dec 2022 15:58:41 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p134-20020a02298c000000b00363d6918540sm2104537jap.171.2022.12.01.15.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 15:58:40 -0800 (PST)
Message-ID: <c5a6cb8a-7b99-249e-5ba4-732fc0ed2e30@linuxfoundation.org>
Date:   Thu, 1 Dec 2022 16:58:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Content-Language: en-US
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com,
        Petr Mladek <pmladek@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
 <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz>
 <8ff95ef5-db76-171d-4c4c-a84d9981290d@linuxfoundation.org>
 <20220715144526.GF2737@pathway.suse.cz>
 <aae71b0b-74e3-5874-b12f-bf0d42d851e4@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aae71b0b-74e3-5874-b12f-bf0d42d851e4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/30/22 15:22, Joe Lawrence wrote:
> On 7/15/22 10:45 AM, Petr Mladek wrote:
>> On Fri 2022-07-01 16:13:50, Shuah Khan wrote:
>>> On 7/1/22 1:48 AM, Miroslav Benes wrote:
>>>> On Thu, 30 Jun 2022, Shuah Khan wrote:
>>>>>
>>>>> Sorry Nack on this. Let's not add modules under selftests. Any usage of
>>>>> module_init()
>>>>> doesn't belong under selftests.
>>>
>>> Yes I did and after reviewing and thinking about it some more, I decided this
>>> is the right direction go down on.
>>
>> Do you have some particular reason why building modules in selftests
>> directory might cause problems, please?
>>

My reasons are that with this change module_init() propagates out of
strictly kernel space and now is in selftests which are user-space.
Any changes to this interface will be tied to user-space change.

This is my main concern. That is reason why I still ask the question
about why is it necessary to make this change other than self-contained
sources?

>> IMHO, the reason that the test modules are in lib is because the
>> modules were there before selftests. Developers historically loaded them
>> manually or they were built-in. Selftest were added later and are just
>> another way how the module can be loaded. This is the case,
>> for example, for lib/test_printf.c.
>>
>> Otherwise, I do not see any big difference between building binaries
>> and modules under tools/tests/selftests. As I said, in the older
>> thread, IMHO, it makes more sense to have the selftest sources
>> self-contained.

Modules under lib are built when kernel gets built as opposed to when
tests are built. So there is the difference in build order. I do see
a difference from that point of view.

Yes, moving modules under selftests does make the tests self contained.

>>
>>
>> There actually seems to be a principal problem in the following use
>> case:
>>
>> --- cut Documentation/dev-tools/kselftest.rst ---
>> Kselftest from mainline can be run on older stable kernels. Running tests
>> from mainline offers the best coverage. Several test rings run mainline
>> kselftest suite on stable releases. The reason is that when a new test
>> gets added to test existing code to regression test a bug, we should be
>> able to run that test on an older kernel. Hence, it is important to keep
>> code that can still test an older kernel and make sure it skips the test
>> gracefully on newer releases.
>> --- cut Documentation/dev-tools/kselftest.rst ---
>>
>> together with
>>
>> --- cut Documentation/dev-tools/kselftest.rst ---
>>   * First use the headers inside the kernel source and/or git repo, and then the
>>     system headers.  Headers for the kernel release as opposed to headers
>>     installed by the distro on the system should be the primary focus to be able
>>     to find regressions.
>> --- cut Documentation/dev-tools/kselftest.rst ---
>>
>> It means that selftests should support running binaries built against
>> newer kernel sources on system running older kernel. But this might
>> be pretty hard to achieve and maintain.
>>
>> The normal kernel rules are exactly the opposite. Old binaries must
>> be able to run on newer kernels. The old binaries were built against
>> older headers.
>>

This case is applicable to when tests are built on a development system
and binaries are moved to run on a target system.

In general, newer tests offer the best coverage, hence the recommendation
to run newer tests on older kernels assuming that the tests are built
on a newer kernel and backwards should run in a backwards compatible
way on older kernels.

Your use-case might be different from this where you do build tests
on older kernels and run them on it in which case, you might have a
requirement to revision match the tests and kernel. You can still do
so.

>> IMHO, the testing of stable kernels makes perfect sense. And if we
>> want to support it seriously than we need to allow building new
>> selftests against headers from the old to-be-tested kernel. And
>> it will be possible only when the selftests sources are as much
>> selfcontained as possible.
>>

Do you have a requirement that livepatch test has to be revision
matched with the kernel? Even if that is the case, there is no real
reason to move modules under selftests other than keeping them in
one location.

Also I didn't see any changes to README that explains this move and
that this change now makes this test now depends on kernel only
interfaces and hence will have to follow modules built outside of
kernel build.

>> Does this makes any sense, please?
>>
> 
> Gentle bump.  Shuah, I believe that Marcos will be preparing a v3 based
> on review comments on the second patch.  We never resolved questions
> surrounding building modules selftests/ (the first patch) though.
> 

You can send patches again and I would like to hear good reasons other
than self-containing the sources.

thanks,
-- Shuah
