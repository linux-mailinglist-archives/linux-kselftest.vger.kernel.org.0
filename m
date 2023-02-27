Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799236A47DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 18:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjB0RYm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 12:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjB0RYl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 12:24:41 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FF23A9D;
        Mon, 27 Feb 2023 09:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1677518676;
        bh=kqedls7n+o6QG8VejTM8JnAG+1eSNSyby6S4US6Cpfs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tES/6QtoQl83J5Rr0jOIRyKljECGrMDBYIyDuDnHUPhhMLdzQvDuhoJDT78ftlEyt
         33QIlmgPMWq+ln5tl3z2JT2pZnZHZn8QyPRHLRx1XwZIvpvqqUDU2ZjLPZ8FgHe/DQ
         L8+bb0kLAhFfdbkLajx4LRXZIyc6VpXvrDRttDBnwB9slP3zlS6+wMgmUf0SDGMRiW
         cPZ4j1WdJ+OtZGNJsFBhpMZvcZAYoaGe7D5K4xjUIgsAzhBrB3RX43714OPf3UhGlh
         P9F/rXOaERw4ns2bmkM+EBRYIHlBZB56lLjrtXCPnE48xx16jxJLUVERYScdp08DAA
         +UK2DuOgqTH3A==
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PQS6X4YZYznNt;
        Mon, 27 Feb 2023 12:24:36 -0500 (EST)
Message-ID: <e2132ff7-51de-b91f-37b5-b0c182ea86fb@efficios.com>
Date:   Mon, 27 Feb 2023 12:24:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 3/3] selftests/mm: add new selftests for KSM
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, hannes@cmpxchg.org
References: <20230224044000.3084046-1-shr@devkernel.io>
 <20230224044000.3084046-4-shr@devkernel.io>
 <20230225213027.69c27e7790898c32e66312ea@linux-foundation.org>
 <qvqwa60zhvpw.fsf@dev0134.prn3.facebook.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <qvqwa60zhvpw.fsf@dev0134.prn3.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-02-27 12:19, Stefan Roesch wrote:
> 
> Andrew Morton <akpm@linux-foundation.org> writes:
> 
>> On Thu, 23 Feb 2023 20:40:00 -0800 Stefan Roesch <shr@devkernel.io> wrote:
>>
>>> This adds three new tests to the selftests for KSM. These tests use the
>>> new prctl API's to enable and disable KSM.
>>>
>>> ...
>>>
>>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>>> index d90cdc06aa59..507cb22bdebd 100644
>>> --- a/tools/testing/selftests/mm/Makefile
>>> +++ b/tools/testing/selftests/mm/Makefile
>>> @@ -29,7 +29,8 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>>>   # LDLIBS.
>>>   MAKEFLAGS += --no-builtin-rules
>>>
>>> -CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>>> +CFLAGS = -Wall -I $(top_srcdir)/tools/include/uapi
>>> +CFLAGS += -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>>>   LDLIBS = -lrt -lpthread
>>>   TEST_GEN_FILES = cow
>>>   TEST_GEN_FILES += compaction_test
>>
>> This change runs afoul of the recently merged 8eb3751c73bec
>> ("selftests: vm: Fix incorrect kernel headers search path").
>>
>> I did this:
>>
>> --- a/tools/testing/selftests/mm/Makefile~selftests-mm-add-new-selftests-for-ksm
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -29,7 +29,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>>   # LDLIBS.
>>   MAKEFLAGS += --no-builtin-rules
>>
>> -CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>> +CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>>   LDLIBS = -lrt -lpthread
>>   TEST_GEN_FILES = cow
>>   TEST_GEN_FILES += compaction_test
>> _
>>
>> But I expect it's a bit wrong.  Please check?
> This change looks good.

As the content of tools/include/uapi is indeed part of the kernel 
sources and not generated as the result of 'make headers' in an output 
directory which can be overridden by O=<...>, referring to it from 
$(top_srcdir) seems appropriate.

lgtm

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

