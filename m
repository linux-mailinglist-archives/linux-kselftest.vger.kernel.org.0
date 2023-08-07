Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33916772D60
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 19:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjHGR6a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 13:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjHGR63 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 13:58:29 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2A8170B;
        Mon,  7 Aug 2023 10:58:28 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 377F140Q011181;
        Mon, 7 Aug 2023 12:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=VkFnQsZNlDqBq06hekSB15FFoglrgZ3jS+q8nHiG8Bs=; b=
        XRP8EGUajQsR7m0Fg5/D1vjIWgEI1RTTBnBuc870JuYKnQmKpQdP4/Ovf7sA5oCb
        PTd52cDEjTYgYuHMe82luGWg9Q/K65YPySzaBP/dG0knxFR1Y17odjyhaWGY2iD5
        CcKStTdr6PHIhFR+s8+J/CJabQHC/9oZGUjdcPdVT+Yu+yGgczAOkQgz9VNXH5u7
        LSTmWdN3vVko9F1inOKBy9eNSRnTREaPAA5NePYW+seAsfeKOWyIJ9o6WI5SzS7x
        RkD2DsW+cDaYQloMuLqpgkKjqJOuVABpbCpYNYU9Rs8MlyK9Ier/ko3fhJNmpvAj
        hLeTIXyHZApAtgSnu3ZXnQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhsv9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 12:58:17 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 18:58:16 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 7 Aug 2023 18:58:16 +0100
Received: from [198.61.64.220] (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9E42015B7;
        Mon,  7 Aug 2023 17:58:15 +0000 (UTC)
Message-ID: <b0bf7b45-5d63-5dbf-e529-9c3a3f6ac6dd@opensource.cirrus.com>
Date:   Mon, 7 Aug 2023 18:58:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] kunit: Replace fixed-size log with dynamically-extending
 buffer
To:     David Gow <davidgow@google.com>
CC:     <brendan.higgins@linux.dev>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, Rae Moar <rmoar@google.com>
References: <20230804141446.21068-1-rf@opensource.cirrus.com>
 <CABVgOSmhj_Qu+NCCzCmVx9Z0n-pAD-s2UekbVv1Y-2kOnNN_NA@mail.gmail.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CABVgOSmhj_Qu+NCCzCmVx9Z0n-pAD-s2UekbVv1Y-2kOnNN_NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HAuCc9EXEAWGvfYF1Do2V0iu-EQUtQTX
X-Proofpoint-ORIG-GUID: HAuCc9EXEAWGvfYF1Do2V0iu-EQUtQTX
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/8/23 10:17, David Gow wrote:
> On Fri, 4 Aug 2023 at 22:14, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> Re-implement the log buffer as a list of buffer fragments that can
>> be extended as the size of the log info grows.
>>
>> When using parameterization the test case can run many times and create
>> a large amount of log. It's not really practical to keep increasing the
>> size of the fixed buffer every time a test needs more space. And a big
>> fixed buffer wastes memory.
>>
>> The original char *log pointer is replaced by a pointer to a list of
>> struct kunit_log_frag, each containing a fixed-size buffer.
>>
>> kunit_log_append() now attempts to append to that last kunit_log_frag in
>> the list. If there isn't enough space it will append a new kunit_log_frag
>> to the list. This simple implementation does not attempt to completely
>> fill the buffer in every kunit_log_frag.
>>
>> The 'log' member of kunit_suite, kunit_test_case and kunit_suite must be a
>> pointer because the API of kunit_log() requires that is the same type in
>> all  three structs. As kunit.log is a pointer to the 'log' of the current
>> kunit_case, it must be a pointer in the other two structs.
>>
>> The existing kunit-test.c log tests have been updated for the new log
>> buffer and a new kunit_log_extend_test() case to test extending the buffer.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
> 
> +Rae, since she's the last person to touch the log code.
> 
> Thanks a bunch. Some way of handling longer logs has been on the to-do
> list for a while, and this is probably better than the other options
> of allowing per-test log sizes or using krealloc().
> 
> This mostly works okay here, but the test fails when running:
> ./tools/testing/kunit/kunit.py run --alltests
> [17:05:12]     # kunit_log_extend_test: EXPECTATION FAILED at
> lib/kunit/kunit-test.c:624
> [17:05:12]     Expected sscanf(p, "The quick brown fox jumps over the
> lazy penguin %d", &q) == 1, but
> [17:05:12]         sscanf(p, "The quick brown fox jumps over the lazy
> penguin %d", &q) == 0 (0x0)
> 
> I haven't found the cause of it, yet, but it happens both on UML and
> QEMU x86_64.
>

Strange, I haven't been able to reproduce this. But sscanf() isn't the
best function to use here because of how it treats whitespace.
'\n' doesn't match a newline, it mtaches any whitespace.
I'm working on a V2 chain, and one change I've made is to replace the
sscanf() with an exact match of what the string should be. I've also
added some test cases.

>>   include/kunit/test.h   | 25 +++++++++----
>>   lib/kunit/debugfs.c    | 65 ++++++++++++++++++++++++++-------
>>   lib/kunit/kunit-test.c | 82 +++++++++++++++++++++++++++++++++++++-----
>>   lib/kunit/test.c       | 51 ++++++++++++++++----------
>>   4 files changed, 177 insertions(+), 46 deletions(-)
>>
>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>> index 011e0d6bb506..907b30401669 100644
>> --- a/include/kunit/test.h
>> +++ b/include/kunit/test.h
>> @@ -33,8 +33,8 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
>>
>>   struct kunit;
>>
>> -/* Size of log associated with test. */
>> -#define KUNIT_LOG_SIZE 2048
>> +/* Initial size of log associated with test. */
>> +#define KUNIT_DEFAULT_LOG_SIZE 500
> 
> Would it make more sense to call this KUNIT_LOG_FRAGMENT_SIZE or
> similar, as not only is this the default size, but also the amount by
> which the size is incremented.
> 
> Also, there's plenty of scope for bikeshedding the exact value of
> this, two considerations being:
> - Most tests have very small logs: we possibly should look into what
> the average log size is.
> - It may make sense to tweak the log size to fit nicely within common
> allocation/page sizes. e.g., PAGE_SIZE-sizeof(struct list_head) or
> something. Though that is probably too big by default.
> 

This initial implementation doesn't support splitting the log line over
multiple fragments (I like to avoid rewirting the whole world in one
patch.) So the fragment size also limits the maximum log line.

I've done some work in supporting long lines and will include it in
my V2 chain.

...

>> +       i = 0;
>> +       while ((pn = strchr(p, '\n')) != NULL) {
>> +               *pn = '\0';
>> +               KUNIT_ASSERT_EQ(test, sscanf(p,
>> +                                            "The quick brown fox jumps over the lazy penguin %d\n",
> 
> Do we want the '\n' at the end of this if we're overwriting it above?
> 

Oh, that's an embarrassing error. But see my comment above about
sscanf().

>> +                                            &q), 1);
>> +               KUNIT_ASSERT_EQ(test, q, i);
> 
> Could we make these KUNIT_EXPECT_EQ? I'd rather not have this kill the
> test thread.
> 

Yes, that's a typo.
Personally, I find the choice of ASSERT/EXPECT confusing. Since people
are so used to _asserting_ the condition to be checked, the brain tends
to go for ASSERT out of habit. IMO it would have been better to use
ASSERT for the thing the test is checking (for consistency with normal
usage) and maybe KUNIT_NEEDS_xxx() for things that are prerequisites of
the test code itself.
