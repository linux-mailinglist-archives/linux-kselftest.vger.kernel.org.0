Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B370877629D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjHIOho (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjHIOho (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 10:37:44 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9267EE;
        Wed,  9 Aug 2023 07:37:43 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379BTo3Y016955;
        Wed, 9 Aug 2023 09:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=gscSkCQwk0KkjxKaYGnY8JJLlDWP6PeBiYDmNdDiJ/s=; b=
        AC/rEOSpAbCmdIDuUA9sFGkEeCbouqR2fIc8EN8CJrffdRH2ewnXKkcztuSffpcA
        QziWGh2R0Y0fL7OzJC+ddAQnifBejj+blfMklyfVrTgbaKCFOg2gw6Uu+TEurZjE
        SKFiIIh8Gvs3B1Y54OtjZ5s0T0rsBE23iL+IFmA2GCzi6ExOFAJH29vo35kvvJf2
        4IKTj639euEQv5nTQXfw/AqpTp7BoCtxhpJCECPWOdAev1PGUYI26ZkDsArEkh4A
        YoWbaYrSPhN3Hf3GpBf1nll9JSK1YA/2YV80pHbMrtOCeZ82YKqNT0VDwM2mH+uL
        KelKP1/Xq2OxuL/EVaKFuQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sb7vtaja4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 09:37:22 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 15:37:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Wed, 9 Aug 2023 15:37:20 +0100
Received: from [198.61.64.220] (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5391F45D;
        Wed,  9 Aug 2023 14:37:20 +0000 (UTC)
Message-ID: <cdca5909-1484-ff07-3184-37d6b3463068@opensource.cirrus.com>
Date:   Wed, 9 Aug 2023 15:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/6] kunit: Replace fixed-size log with
 dynamically-extending buffer
Content-Language: en-US
To:     David Gow <davidgow@google.com>
CC:     <brendan.higgins@linux.dev>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230808123529.4725-1-rf@opensource.cirrus.com>
 <20230808123529.4725-2-rf@opensource.cirrus.com>
 <CABVgOS=BrJ82v3_O9wGxTGoPRjH-rSWiTMS6+S=x4yPng_-XFA@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CABVgOS=BrJ82v3_O9wGxTGoPRjH-rSWiTMS6+S=x4yPng_-XFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AkE4-HTogJzdmFBI5Cn_8W4WVp60XgQ9
X-Proofpoint-ORIG-GUID: AkE4-HTogJzdmFBI5Cn_8W4WVp60XgQ9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/8/23 13:11, David Gow wrote:
> On Tue, 8 Aug 2023 at 20:35, Richard Fitzgerald
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
>> kunit_log_append() now attempts to append to the last kunit_log_frag in
>> the list. If there isn't enough space it will append a new kunit_log_frag
>> to the list. This simple implementation does not attempt to completely
>> fill the buffer in every kunit_log_frag.
>>
>> The 'log' member of kunit_suite, kunit_test_case and kunit_suite must be a
>> pointer because the API of kunit_log() requires that is the same type in
>> all  three structs. As kunit.log is a pointer to the 'log' of the current
>> kunit_case, it must be a pointer in the other two structs.
>>
>> The existing kunit-test.c log tests have been updated to build against the
>> new fragmented log implementation.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
> 
> Looks good to me.
> 
> A few small notes inline below, mostly around the possibility of
> either embedding the list_head in the kunit_case struct directly
> (rather than using a pointer), or of pointing directly to the first
> fragment, rather than a separately-allocated struct list_head. Neither
> are showstoppers, though (and if it increases complexity at all, it's
> possibly premature optimization).
>

I did start out trying to use the first fragment as the list head.
Trouble with this is that the functions in list.h expect to have a
dummy list_head node that is only the head, but not an actual list
member. It's possible to workaround this but the shenanigans involved is
likely to trip someone up later so reverted to doing the list the way
the API intended.

For the pointers, I did consider embedding the list_head instead of
using a pointer. But then the struct kunit can't refer to the
kunit_case list, it can only take it over. There can only be one list
head because the ->prev and ->next pointers of the first and last
members in the list can only point to one head.

After playing around with it I decided that it wasn't worth trying to
avoid the pointers. At least... it wasn't worth spending a lot of time
trying to avoid them for an initial implementation.

Maybe some magic with typeof() in the kunit_log() would let us use
different types for the members of kunit_suite, kunit_case, kunit?
Then the list_head can be directly embedded in the first two but a
pointer in kunit?

> Otherwise, some test nitpicks and the fact that this will need a
> trivial rebase due to the module filtering stuff landing in
> kselftest/kunit.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 

...

>>   static void kunit_log_newline_test(struct kunit *test)
>>   {
>> +       struct kunit_log_frag *frag;
>> +
>>          kunit_info(test, "Add newline\n");
>>          if (test->log) {
>> -               KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add newline\n"),
>> -                       "Missing log line, full log:\n%s", test->log);
>> -               KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\n\n"));
>> +               frag = list_first_entry(test->log, struct kunit_log_frag, list);
>> +               KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(frag->buf, "Add newline\n"),
>> +                       "Missing log line, full log:\n%s", frag->buf);
> 
> I'm not super thrilled that this only operates on the first fragment.
> Could we at least note that this is not the "full log" in the
> assertion message here, and maybe also assert that the log hasn't
> grown to a second fragment?
> 

The only aim in this first patch is to make sure that kunit-test.c still
builds. I've added extra newline test cases in later patches.

...

> 
> I was going to wonder whether or not we should cache the length of the
> current fragment somewhere, but thinking about it, it's probably not
> worth it given we're only measuring a single fragment, and it's capped
> at 256 bytes.
> 
Yes, I had the same thought but decided to leave it as something that
can be done later. But as you say it's doubtful whether it's worth the
extra storage space when the buffer fragments are small. On x86_64
simply adding a length member could add 8 bytes per fragment (because of
rounding). If the size of the fragment buffer is capped at 256 we could
use single byte for the length and hope the compiler doesn't insert
padding between a char and a char[] array.

Take a look at what happens when you log a message to the kernel log and
by comparison this kunit logging is super-lightweight.

(I did look at whether we could re-use the existing kernel log
implementation but decided it was too heavily hardcoded to how the
kernel log works.)
