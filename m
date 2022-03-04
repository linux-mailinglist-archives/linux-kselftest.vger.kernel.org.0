Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E104CD6C2
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 15:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbiCDOvf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 09:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbiCDOve (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 09:51:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6DF76646
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Mar 2022 06:50:46 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so7026280pju.2
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Mar 2022 06:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qGajYq/2Y8cBdDlqrjorvnqnZd0B5kqCZ5qkXRiChPc=;
        b=LoKymxMnUUd4Qg39UfUGbaGqi+9wFch08Xhwa4MiFfU34YUWHwInABhQbdzbKCViwD
         Gs5QT18FOd33txjBj2qHeIbU+MO+F3mgnnY23mjTk9n/seq5ITaqC4pW01PBl61EsYG0
         wPKey6Pmg5+nWxN2qcrQDEY0KLt8MONsgAyOjhPnM9J9mda87YUGpcpQBduSKtFFd8Y1
         +CeGLWR8OFy0fVq4ttuxxyzHmqmvkjGsdWFZBnJW3RCKn9ain2xDCEs8f0p93Rf3uIVi
         hQujSsxi+UVZ1aE35BtKU2aoRi4mOc8UJ8Yjm9FVv86wvT22sDcRjSyJWhOMXJwbI6Hu
         A0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qGajYq/2Y8cBdDlqrjorvnqnZd0B5kqCZ5qkXRiChPc=;
        b=HAz4vjFlfjXkjEXemuVMFAjT6OuKvkab67WZpgfFajApDmUoq0saBAib2KUneu9KUH
         39p9wxiJfnbBPi/gO0aoNMy6zJuJgiGJPA0Ar8VY6qJjGktxG6Dl2bjpg3dE5zhUacp9
         87NbfFAXWvpHYr3dOdvBfixIaKmAZSILqgo+Z98xu42iOlo4AGM0vmzNlZPSQyM7Bq0J
         zwCgzWDzuWyVkwt0F1WppWzW6Ylng5ZrqV429kYtqZuOYle00+fWxHaFdfrywjujaVHz
         IjO9nYyEuYj6U4Px3RlaaUCq4MfjB6m1rg30RduqMdVDENQeQqEtbCK0JWOxluvVtRcc
         rUTA==
X-Gm-Message-State: AOAM532em+KyyF6uUDBQ+aSFiPzL2I1GslZ5dQLr163ZxBSodmLS1Rhj
        8q61FeAY804WwSYsI3tzer/VqQ==
X-Google-Smtp-Source: ABdhPJwZaTifOscR/tZC+QEj0ArP9SQ5w03IwxALm43ULQDKIqMbnxqU4MINzWjzl2KhNzJK/4pPVg==
X-Received: by 2002:a17:902:b60f:b0:14f:ee29:5ef7 with SMTP id b15-20020a170902b60f00b0014fee295ef7mr41377789pls.106.1646405446441;
        Fri, 04 Mar 2022 06:50:46 -0800 (PST)
Received: from ?IPV6:2409:8a28:e6d:cc00:d089:89fd:5c33:f12? ([2409:8a28:e6d:cc00:d089:89fd:5c33:f12])
        by smtp.gmail.com with ESMTPSA id a11-20020a056a001d0b00b004f4057fafe2sm5885040pfx.94.2022.03.04.06.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 06:50:46 -0800 (PST)
Message-ID: <f57550a9-f3d7-9a04-a51a-6224b352af7b@bytedance.com>
Date:   Fri, 4 Mar 2022 22:50:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [External] Re: [PATCH 1/2] kselftest/vm: override TARGETS from
 arguments
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, akpm@linux-foundation.org,
        shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220227055330.43087-1-zhouchengming@bytedance.com>
 <b29de093-72dd-1dc5-b591-2a75f49cdb2a@linuxfoundation.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <b29de093-72dd-1dc5-b591-2a75f49cdb2a@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/3/4 3:17 上午, Shuah Khan wrote:
> On 2/26/22 10:53 PM, Chengming Zhou wrote:
>> We can specify which testcases to build using TARGETS argument,
>> for example: make -C tools/testing/selftests TARGETS=vm, cause
>> the ordinary assignment of TARGETS in Makefile will be ignored.
>> So we need to use override directive to change that.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>   tools/testing/selftests/vm/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
>> index 1607322a112c..0b330a5b1840 100644
>> --- a/tools/testing/selftests/vm/Makefile
>> +++ b/tools/testing/selftests/vm/Makefile
>> @@ -53,7 +53,7 @@ CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_progra
>>   CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_64bit_program.c)
>>   CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_program.c -no-pie)
>>   -TARGETS := protection_keys
>> +override TARGETS := protection_keys
>>   BINARIES_32 := $(TARGETS:%=%_32)
>>   BINARIES_64 := $(TARGETS:%=%_64)
>>  
> 
> Let's not override TARGETS - rename TARGETS in this file.
> VM_TARGETS?

Looks like Andrew has already added this patch to the -mm tree. I think
both way is ok to solve this problem. Should I rename to VM_TARGETS and
send another patch?

Thanks.

> 
> thanks,
> -- Shuah
