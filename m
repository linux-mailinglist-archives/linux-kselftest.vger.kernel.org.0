Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB6777A07
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjHJOAu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjHJOAt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 10:00:49 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6037710C7;
        Thu, 10 Aug 2023 07:00:48 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37ACi1Jh013810;
        Thu, 10 Aug 2023 09:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=dRcZc1Gj9UrouhcCf0I9abiYLdhHElG2ZpYhe849j8E=; b=
        G+8115/uOn2RHoUl8M9VXRG07/0eq/VAD+WssytSXnrYoqCule/nbKZ+nEMc9Wiz
        IVRSNTxIdLqGt7jMXiEFFt+k3+fxzmlgELyoC2KeWl9W7u5Y6YfApxcduJSq7Xz9
        23vAo9TRmD6NlkN5NvdozHHDLOTJywyRT/IEdxUU7ICGjaNWbQJWfKhgFmofU81i
        W9Rw4X0FW3k69W/qvXgJ4RrvrkcD7RIzo09nV3i7b/WBP1WAEroeqoEfy/rj/0Qu
        Db3km67HsjeyhW9jQlWkeePywdaatx/tn0iN1IxDSC/VYn5smBQXAbqWreiCHg6N
        3WlWH/DUPAYpjB0jEldgpA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhvv7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 09:00:42 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 15:00:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 10 Aug 2023 15:00:40 +0100
Received: from [198.61.64.220] (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D2078475;
        Thu, 10 Aug 2023 14:00:39 +0000 (UTC)
Message-ID: <2ba15574-2bdd-5b79-bf3f-c57fd5920165@opensource.cirrus.com>
Date:   Thu, 10 Aug 2023 15:00:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/7] kunit: Replace fixed-size log with
 dynamically-extending buffer
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
CC:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
 <20230809155438.22470-2-rf@opensource.cirrus.com>
 <CA+GJov78V_8OE7Pveik-hv8+HRFSFzaWejoZLY32GCWg2gNOPA@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CA+GJov78V_8OE7Pveik-hv8+HRFSFzaWejoZLY32GCWg2gNOPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8i_rjuequLcY_YZPcuJcqXy7KD5UyDZB
X-Proofpoint-ORIG-GUID: 8i_rjuequLcY_YZPcuJcqXy7KD5UyDZB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/8/23 22:10, Rae Moar wrote:
> On Wed, Aug 9, 2023 at 11:54 AM Richard Fitzgerald
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
>> new fragmented log implementation. If the test fails the new function
>> get_concatenated_log() constructs a single contiguous string from the
>> log fragments so that the whole log can be emitted in the failure
>> message.
> 
> Hello!
> 
> All the tests now pass for me and this patch now looks good to me. I
> have tested it and it seems to be working well.
> 
> I just have a few nits below. But I am overall happy with this patch.
> 
> Reviewed-by: Rae Moar <rmoar@google.com>
> 
> -Rae
> 

...

>> +static char *get_concatenated_log(struct kunit *test, const struct list_head *log)
>> +{
>> +       struct kunit_log_frag *frag;
>> +       size_t len = 0;
>> +       char *p;
> 
> I wonder if we could change the name of p to be a bit more
> descriptive. Maybe concat_log?

I'll do that.

>> +
>> +       list_for_each_entry(frag, log, list)
>> +               len += strlen(frag->buf);
>> +
>> +       len++; /* for terminating '\0' */
>> +       p = kunit_kzalloc(test, len, GFP_KERNEL);
>> +
>> +       list_for_each_entry(frag, log, list)
>> +               strlcat(p, frag->buf, len);
>> +
>> +       return p;
>> +}
>> +
>>   static void kunit_log_test(struct kunit *test)
>>   {
>>          struct kunit_suite suite;
>> +       struct kunit_log_frag *frag;
>>
>> -       suite.log = kunit_kzalloc(test, KUNIT_LOG_SIZE, GFP_KERNEL);
>> +       suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
>>          KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
>> +       INIT_LIST_HEAD(suite.log);
> 
> This section of the test is pretty dense. I would love to see at least
> one comment in this section. Maybe it could be here and say something
> like:
> "/* Allocate, initialize, and then add the first fragment of log */"

Good. You like comments. So do I.
But many people hate them so when I'm starting on a new subsystem I go
with however the existing code looks. And the bits of kunit I've looked
at are light on comments.

...

>> @@ -543,14 +568,17 @@ static void kunit_log_test(struct kunit *test)
>>          kunit_log(KERN_INFO, &suite, "along with this.");
>>
>>   #ifdef CONFIG_KUNIT_DEBUGFS
>> +       frag = list_first_entry(test->log, struct kunit_log_frag, list);
>>          KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
>> -                                    strstr(test->log, "put this in log."));
>> +                                    strstr(frag->buf, "put this in log."));
>>          KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
>> -                                    strstr(test->log, "this too."));
>> +                                    strstr(frag->buf, "this too."));
>> +
>> +       frag = list_first_entry(suite.log, struct kunit_log_frag, list);
>>          KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
>> -                                    strstr(suite.log, "add to suite log."));
>> +                                    strstr(frag->buf, "add to suite log."));
>>          KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
>> -                                    strstr(suite.log, "along with this."));
>> +                                    strstr(frag->buf, "along with this."));
>>   #else
>>          KUNIT_EXPECT_NULL(test, test->log);
> 
> This test passes when CONFIG_KUNIT_DEBUGFS=n while most of the other
> tests are skipped. Should this test be skipped instead?
> 
> I'm assuming since the assert/expect statements at the beginning are
> run even if CONFIG_KUNIT_DEBUGFS=n, this test should not be skipped
> but I just wanted to check.

That the existing code, which I didn't change.
I think the best thing here would be to move the fragment testing into a
new test case.

>>   #endif
>> @@ -558,11 +586,15 @@ static void kunit_log_test(struct kunit *test)
>>
>>   static void kunit_log_newline_test(struct kunit *test)
>>   {
>> +       struct kunit_log_frag *frag;
>> +
>>          kunit_info(test, "Add newline\n");
>>          if (test->log) {
> 
> This is a small nit but I would prefer that the if statements to
> decide whether CONFIG_KUNIT_DEBUGFS is enabled were uniform. So I
> would prefer that we choose between if (test->log) and #ifdef
> CONFIG_KUNIT_DEBUGFS. I think we originally chose to use if
> (test->log) here to avoid the compile-time #ifdef.

Actually the existing code did it both ways. The newline test used
if (test->log) - but this makes sense because it actually does testing
on test->log.

The original kunit_log_test() used #ifdef CONFIG_KUNIT_DEBUGFS. I based
my new functions on kunit_log_test(). But I can change them. Would you
prefer

	if (!test->log)
		skip

or
	if (!IS_ENABLED(CONFIG_KUNIT_DEBUGFS))
		skip

