Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F31777A51
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjHJOTK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjHJOTJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 10:19:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59C6120;
        Thu, 10 Aug 2023 07:19:08 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37AAuBfb003726;
        Thu, 10 Aug 2023 09:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=j14lLmQLwmVqhVLGorAS8MSfFswqpC7V1Nc/1O8c57U=; b=
        J0Hp3HSgEIVSIVzN3hRDWu7vXdDHdkTcPH5m+WKUgApe3A8Po+05jNXfrTh4diI6
        Vq+BdJ+sUFGxIp8qh5PjacAfXpygr9qzuhTy3A1dKUETjxHQWlpzN97OZ/ULzkV3
        zZEAzBfqxWPw6z5tLlZWUj4DIbdngDGJwMlFTyyb3XeQ/dfOk4mfNIXnQCl7RLHm
        cPecGhGBi6JQvKt8tf990YlRcOZetzhuKiAU2qL+cf7UkNKYRlohDd8nCaBDDXC5
        fd8uDfqpHVr8+Os5Bful4KOSyJBAinYwOIgzJsbd4V8XaqcpNWTdQgkUXAv1KPzY
        QV0hgCATke8VTXehjtmQ5w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sb7vtc2x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 09:18:53 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 15:18:51 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 10 Aug 2023 15:18:51 +0100
Received: from [198.61.64.220] (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F248811AA;
        Thu, 10 Aug 2023 14:18:50 +0000 (UTC)
Message-ID: <7576597d-9b7f-063c-d17a-1d572ecb5043@opensource.cirrus.com>
Date:   Thu, 10 Aug 2023 15:18:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/7] kunit: kunit-test: Add test cases for extending
 log buffer
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
CC:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
 <20230809155438.22470-3-rf@opensource.cirrus.com>
 <CA+GJov5Txxq=V2_N8LNM3gHtP6sjS5CKhj-pzpYqN8mVm-a3ww@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CA+GJov5Txxq=V2_N8LNM3gHtP6sjS5CKhj-pzpYqN8mVm-a3ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: H4caD9UawGDTHx_L-dOrEYLJoZABQMmq
X-Proofpoint-ORIG-GUID: H4caD9UawGDTHx_L-dOrEYLJoZABQMmq
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/8/23 22:10, Rae Moar wrote:
> On Wed, Aug 9, 2023 at 11:54 AM Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> Add test cases for the dynamically-extending log buffer.
>>
>> kunit_log_init_frag_test() tests that kunit_init_log_frag() correctly
>> initializes new struct kunit_log_frag.
>>
>> kunit_log_extend_test_1() logs a series of numbered lines then tests
>> that the resulting log contains all the lines.
>>
>> kunit_log_extend_test_2() logs a large number of lines of varying length
>> to create many fragments, then tests that all lines are present.
>>
>> kunit_log_newline_test() has a new test to append a line that is exactly
>> the length of the available space in the current fragment and check that
>> the resulting log has a trailing '\n'.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> Hello!
> 
> These tests now pass for me. Thanks!
> 
> I do have a few comments below mostly regarding comments and a few
> clarifying questions.
> 
> -Rae

...

>> +static void kunit_log_init_frag_test(struct kunit *test)
>>   {
>> -       struct kunit_suite suite;
>>          struct kunit_log_frag *frag;
>>
>> -       suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
>> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
>> -       INIT_LIST_HEAD(suite.log);
>>          frag = kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
>>          KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
>> +       memset(frag, 0x5a, sizeof(*frag));
>> +
> 
> Why is the fragment getting filled here with memset? Should this be
> tested? Feel free to let me know, I'm just uncertain.

I'll add a comment in V4. It's to prove that kunit_init_log_frag()
really did change something. kzalloc() is no good for this because we
want to see that kunit_log_frag() zeroed buf[0].

...

>>          kunit_info(test, "Add newline\n");
>>          if (test->log) {
>>                  frag = list_first_entry(test->log, struct kunit_log_frag, list);
>>                  KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(frag->buf, "Add newline\n"),
>>                          "Missing log line, full log:\n%s",
>> -                       get_concatenated_log(test, test->log));
>> +                       get_concatenated_log(test, test->log, NULL));
>>                  KUNIT_EXPECT_NULL(test, strstr(frag->buf, "Add newline\n\n"));
>> +
> 
> Should this section of kunit_log_newline_test be separated into a new
> test? This test seems a bit long and seems to have two distinct
> sections?

Yes, it makes sense to add a separate test case for when newlines cause
the log to extend.

...

> Another potential idea is to rename these two tests to be
> kunit_log_extend_test() and kunit_log_rand_extend_test() instead to be
> more descriptive?

TBH I had trouble thinking of a short description. But I'll spend some
time thinking about naming.

...

>> +       do {
>> +               n = snprintf(line, sizeof(line),
>> +                            "The quick brown fox jumps over the lazy penguin %d\n", i);
>> +               KUNIT_ASSERT_LT(test, n, sizeof(line));
>> +               kunit_log_append(suite.log, line);
>> +               ++i;
>> +               len += n;
>> +       }  while (len < (sizeof(frag->buf) * 30));
> 
> Are we trying to restrict the num_frags to less than 30? And then we
> could check that with a KUNIT_EXPECT? Currently, the num_frags are
> just above 30. That is ok too. I just was wondering if this was
> intentional? (Same as kunit_log_extend_test_2)

I'll comment on this in V4.
It's just trying to create "a lot" of data without assuming exactly
how kunit_log_append() breaks up the lines across fragments. I don't
want to have to keep changing this code if the fragmenting algorithm
changes slightly. So the idea is to generate "about 30" buffers worth.
I don't mind if it's a bit more, or a bit less. It's done this way,
instead of just counting how many fragments were created, to prevent
getting into an infinite loop if for some reason kunit_log_append()
fails to add fragments.

...

>> +       /* Build log line of varying content */
>> +       line[0] = '\0';
>> +       i = 0;
>> +       do {
>> +               char tmp[9];
>> +
>> +               snprintf(tmp, sizeof(tmp), "%x", i++);
>> +               len = strlcat(line, tmp, sizeof(line));
>> +       } while (len < sizeof(line) - 1);
> 
> Could there be an expectation statement here to check the line has
> been properly filled. Maybe checking the length?

Yes

>> +       prandom_seed_state(&rnd, 3141592653589793238ULL);
>> +       i = 0;
>> +       n = 0;
>> +       while ((pn = strchr(p, '\n')) != NULL) {
>> +               *pn = '\0';
>> +               KUNIT_EXPECT_STREQ(test, p, &line[i]);
>> +               p = pn + 1;
>> +               n++;
>> +               i = prandom_u32_state(&rnd) % (sizeof(line) - 1);
>> +       }
>> +       KUNIT_EXPECT_EQ_MSG(test, n, num_lines, "Not enough lines.");
> 
> Is it possible for this to be too many lines instead? Should this
> comment instead be "Unexpected number of lines". Also could we have a
> similar message for the test above for this expectation regarding the
> number of lines.

Fair point. It's only found that the number of lines is wrong, it
could be less or more.
