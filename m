Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBD150EC5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 01:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiDYXDk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbiDYXDj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 19:03:39 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB13D3D1FA
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 16:00:33 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i8so10343555ila.5
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 16:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ia87REFG0AYraSTeAkYZRVYwp6MdRMp9URsVCkFU7RU=;
        b=X62cc21UcM8gAmCg5EiadF8tgHOLnAI+GvexRgJCkpAo88iCOInrAGuRMuA+Dao8WB
         Wr3NafYftBnEyB/9ia3alKH9XUay7vI4Z2GzlFd6CbufbFamGwKSIhIa7765i+Q1Iv8L
         raCl2rtZjdtQs/UncUjVlRE/9M82O55aBIbc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ia87REFG0AYraSTeAkYZRVYwp6MdRMp9URsVCkFU7RU=;
        b=CtRim0rKFP30FgYUh4toW4f7hconX/bR1pLLS7pDILOVLttmsRsJbVvayVgk35jV/u
         +mt49mHvYgfKeZd/7SrnREx78XbGa8pap7oXOZJfRgY0PGDmJphXkQEyTz1CnRkP75kB
         FxuUKCaJsIDZaCfavGc6vQUUxJ5g2q5dYFSqu22qAvyoBsGBqgsuYX2Va3tI19FTMCVs
         vT8yNvKZL2IAcalxLE25LuErB2rePew9Hts6P0FeTf0srcnV+LqhIf+JapF71Rt/4upq
         KwFFEzlssz8VAcsmCh+6uJrM48jW7bmFdpwGhug0SVCDlso365oaNlrxDULoyS+vNhCQ
         etEw==
X-Gm-Message-State: AOAM530gjK8sZz0nAHeEltTUlxL3rEr/uh3I8g7a1jdYthUTRSzP7g73
        xFKPaUDSp+X+XzchHGB5a1I17g==
X-Google-Smtp-Source: ABdhPJyH5ffWuC4e3FNfgLxcYhuhqH84NGmqCX23Plb6skBV6q3k5vdx9m+QEzaOQeKJl79MymaLYA==
X-Received: by 2002:a05:6e02:1e08:b0:2cc:4b66:1984 with SMTP id g8-20020a056e021e0800b002cc4b661984mr7907887ila.266.1650927633083;
        Mon, 25 Apr 2022 16:00:33 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p184-20020a6b8dc1000000b00650b95043e8sm8351137iod.33.2022.04.25.16.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 16:00:32 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] selftests/resctrl: Print a message if the result
 of MBM&CMT tests is failed on Intel CPU
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220323080928.1586408-1-tan.shaopeng@jp.fujitsu.com>
 <1920a6b6-bc1b-31db-4c1b-efccc189daa5@linuxfoundation.org>
 <9a1d0420-d99a-e4a8-c6de-729b56e9c1f0@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <488995ee-2a00-321c-126f-8ed7f8b82635@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 17:00:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9a1d0420-d99a-e4a8-c6de-729b56e9c1f0@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/25/22 3:19 PM, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 3/29/2022 8:37 AM, Shuah Khan wrote:
>> On 3/23/22 2:09 AM, Shaopeng Tan wrote:
>>> Hello,
>>>
>>> The aim of this series is to print a message to let users know a possible
>>> cause of failure, if the result of MBM&CMT tests is failed on Intel CPU.
>>> In order to detect Intel vendor, I extended AMD vendor detect function.
>>>
>>> Difference from v4:
>>> - Fixed the typos.
>>> - Changed "get_vendor() != ARCH_AMD" to "get_vendor() == ARCH_INTEL".
>>> - Reorder the declarations based on line length from longest to shortest.
>>> https://lore.kernel.org/lkml/20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com/ [PATCH v4]
>>>
>>> This patch series is based on v5.17.
>>>
>>> Shaopeng Tan (2):
>>>     selftests/resctrl: Extend CPU vendor detection
>>>     selftests/resctrl: Print a message if the result of MBM&CMT tests is
>>>       failed on Intel CPU
>>>
>>>    tools/testing/selftests/resctrl/cat_test.c    |  2 +-
>>>    tools/testing/selftests/resctrl/resctrl.h     |  5 ++-
>>>    .../testing/selftests/resctrl/resctrl_tests.c | 45 +++++++++++++------
>>>    tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
>>>    4 files changed, 37 insertions(+), 17 deletions(-)
>>>
>>
>> I can queue this up for Linux 5.18-rc2. Thanks for fixing the error
>> path with clear messages for failures.
> 
> Is this perhaps still in your queue for consideration? I peeked at the
> branches within the kselftest repo but could not find it merged yet.
> If things are tightened for fixes it would be welcome as v5.19 material
> also.
> 
> Thank you very much
> 

Thanks for the ping. The changes are a bit more extensive for a fix based
on my review comments. I queued these two in linux-kselftest next branch
for 5.19-rc1.

thanks,
-- Shuah
