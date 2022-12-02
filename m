Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20813640ED7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 21:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiLBUDa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 15:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiLBUD2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 15:03:28 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337FDEF8B4
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 12:03:27 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id d18so3760813iof.6
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 12:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jvpL3d+3i6oicL+h7HQix4Yaw7Cn50/kfwWim4WAx4=;
        b=EKqvlP5TDqfwdjIEAV0O9aLp+toCj/R3WgcihYoPcLIl/kshQNw1GrvEh755YxPHeT
         J61R9ehE7y2EBc0aRHiHpw+nM50F4e1JpTEyoAGYZZZJkAA74TELilRleBynECsUINNo
         N0dxmVYMCcFXHZIEhH64UYxmJtHkf9LMoWCU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jvpL3d+3i6oicL+h7HQix4Yaw7Cn50/kfwWim4WAx4=;
        b=LXiq/rWYKQbbsjBWj232wjSubajHa3lIW17r5PF8yIHbSKpUIdhNQB+ptBxEoFxSG4
         dglrhd0YuysJbmzPzIJbak8XJtUZF8Yqr5yl4dT1Xld9BrmeC/5yei65jPNvjM9SIotI
         04yqE2A9om304756z50/4agB5WQNY8hWZrSlLju3Toxe50ofYqB0pmtCNTjVGO20CUtW
         pEXNhemNjocaB65/xL+2nEU8qDPWck+6wmQKO80oGJpMJT0m7kBhV38b2axk3yIxHpfs
         V685XWpV5lYH+NrW2Rps/MhY+uDq8T7icqc0ysGZZNKJiDPJSkCUv5m02TUFRuAYVWZ+
         zzuA==
X-Gm-Message-State: ANoB5pnK2EeXly/tda6FmZwQ+Ucf7V1dc1R5lXkfVJZCBhlAYmXYA6kI
        2R7BRmy8BQQxiisXRH/QCPZqAA==
X-Google-Smtp-Source: AA0mqf6gxjHMFxVoF9R0pH2vy2/dwrh+r3ebO+QQNF/RP4RLBonyu4KSy6VqZXOE2KBWVtI3Ceav1g==
X-Received: by 2002:a02:a0c9:0:b0:376:21a3:969c with SMTP id i9-20020a02a0c9000000b0037621a3969cmr33176213jah.318.1670011406503;
        Fri, 02 Dec 2022 12:03:26 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y5-20020a5d94c5000000b006c05ff4cd91sm2989437ior.35.2022.12.02.12.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 12:03:25 -0800 (PST)
Message-ID: <21025073-0ed6-427e-219e-99e9731f6688@linuxfoundation.org>
Date:   Fri, 2 Dec 2022 13:03:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
 <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz>
 <8ff95ef5-db76-171d-4c4c-a84d9981290d@linuxfoundation.org>
 <20220715144526.GF2737@pathway.suse.cz>
 <aae71b0b-74e3-5874-b12f-bf0d42d851e4@redhat.com>
 <c5a6cb8a-7b99-249e-5ba4-732fc0ed2e30@linuxfoundation.org>
 <Y4nEhb7yPK5l54IX@alley>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y4nEhb7yPK5l54IX@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/2/22 02:25, Petr Mladek wrote:
> On Thu 2022-12-01 16:58:38, Shuah Khan wrote:
>> On 11/30/22 15:22, Joe Lawrence wrote:
>>> On 7/15/22 10:45 AM, Petr Mladek wrote:
>>>> On Fri 2022-07-01 16:13:50, Shuah Khan wrote:
>>>>> On 7/1/22 1:48 AM, Miroslav Benes wrote:
>>>>>> On Thu, 30 Jun 2022, Shuah Khan wrote:
>>>>>>>
>>>>>>> Sorry Nack on this. Let's not add modules under selftests. Any usage of
>>>>>>> module_init()
>>>>>>> doesn't belong under selftests.
>>>>>
>>>>> Yes I did and after reviewing and thinking about it some more, I decided this
>>>>> is the right direction go down on.
>>>>
>>>> Do you have some particular reason why building modules in selftests
>>>> directory might cause problems, please?
>>>>
>>
>> My reasons are that with this change module_init() propagates out of
>> strictly kernel space and now is in selftests which are user-space.
>> Any changes to this interface will be tied to user-space change.
> 
> I am sorry but I do not understand the meaning here. module_init() is
> called when module is loaded. It is not called in userspace.
> 
> Maybe, you mean that modules under lib/ are clearly in-tree
> modules. If we move then under tools/ then they will be build
> like out-of-tree modules. Except that they will be maintained in-tree
> so that it will be easy to keep them in sync.
> 

Yes. That is what I mean.

> And I am sure that they will be actively maintained. The fixes are
> there to make sure that livepatching still works as expected.
> They must pass when any change is done in the livepatch subsystem.
> And they must pass when any kernel is released.
> 

In other words, livepatch and kernel are revision matched.

> The only concern might be how build failure is handled. IMHO, we
> need to handle it the same way and test failure.
> 
> 

Yes. This is another concern - build failures. Let's experiment with
modules under selftests and see if this becomes a problem.

>> In general, newer tests offer the best coverage, hence the recommendation
>> to run newer tests on older kernels assuming that the tests are built
>> on a newer kernel and backwards should run in a backwards compatible
>> way on older kernels.
> 
> This works for the userspace interface that should always be backward
> compatible. But it does not work for kABI.
> 

This is broader than revision matching. Tests should gracefully exit
with skip when a config option they depend on is disabled. The same
gets extended to older kernel versions.

> 
>> Do you have a requirement that livepatch test has to be revision
>> matched with the kernel? Even if that is the case, there is no real
>> reason to move modules under selftests other than keeping them in
>> one location.
> 
> Yes, kABI is not backward compatible. But building the tests
> modules out-of-tree way would allow to build test modules with
> different kABI from the same sources.
> 

Okay. This is a solid reason for livepatch modules to live under
sefltests. Let's capture this in README and the other updates that
need to be made to it in v3.

thanks,
-- Shuah
