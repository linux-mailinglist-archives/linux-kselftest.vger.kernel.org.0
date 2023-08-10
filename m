Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63468777A95
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjHJOY0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 10:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjHJOYW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 10:24:22 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A4D2698;
        Thu, 10 Aug 2023 07:24:22 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37ACi1nw013806;
        Thu, 10 Aug 2023 09:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=FriU4c2Lao1c9g+S/b4Cgqkvi5bccIniaoSIMdpiGL4=; b=
        Ju13FzT+U0mpl0cJbuM5tDngRZ+u0Lf7/sc2iPeTyzOshd3ibjwU3xL0wVL81gQ/
        5BLC7SyXqeKket+sBq2pLmuqlDIPYDcnF9Xz4RM+zz0l8L7YhPhQeffudzEaOY1L
        dqcO60JPdLJz/rLVJvkm5lp5+QSCOb/ktDhsJVGyKh7mW9dSnAiZ71NChZpmVtYj
        dB8IrEbwNHfiTNkLSWnjmi+8uOqGsD+z85ELmVa2o4+7FXCmKqcENoDpl/XkPDgQ
        x9ZZUAD7+RkE+3iuCTs4MRWfKmahnylWbKCtrJfVDxmIklLLQbjUiz5eH8ZFivNl
        te52eHjj1UBebOV9vJRcQg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhvwbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 09:24:16 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 15:24:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 10 Aug 2023 15:24:14 +0100
Received: from [198.61.64.220] (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1C0CC11AA;
        Thu, 10 Aug 2023 14:24:14 +0000 (UTC)
Message-ID: <08e1bba0-5ccc-dac1-28c9-81e69c996337@opensource.cirrus.com>
Date:   Thu, 10 Aug 2023 15:24:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4/7] kunit: kunit-test: Test logging a line that
 exactly fills a fragment
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
CC:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
 <20230809155438.22470-5-rf@opensource.cirrus.com>
 <CA+GJov5tw2kCmy=Qrnw4EK9Dr91MXAsOmai0XFz-2tfgZ724vg@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CA+GJov5tw2kCmy=Qrnw4EK9Dr91MXAsOmai0XFz-2tfgZ724vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qXFC28PgDJ3irGmoQL1J25lZ-SAKqkcd
X-Proofpoint-ORIG-GUID: qXFC28PgDJ3irGmoQL1J25lZ-SAKqkcd
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/8/23 22:22, Rae Moar wrote:
> On Wed, Aug 9, 2023 at 11:54 AM Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> If a log string is the exact length of a log fragment buffer
>> kunit_log_append() should now exactly fill that fragment without
>> extending the log.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> Hello!
> 
> This test looks good to me. I have tested it and it seems to be working well.
> 
> I appreciate all of the assert and expect statements. I do have one
> comment below.
> 
> Although, I would be happy to set this as reviewed by me after that
> comment is responded to.
> 
> Thanks!
> -Rae
> 
>> ---
>>   lib/kunit/kunit-test.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
>> index c0ee33a8031e..9ac81828d018 100644
>> --- a/lib/kunit/kunit-test.c
>> +++ b/lib/kunit/kunit-test.c
>> @@ -763,12 +763,49 @@ static void kunit_log_extend_test_2(struct kunit *test)
>>   #endif
>>   }
>>
>> +static void kunit_log_frag_sized_line_test(struct kunit *test)
>> +{
>> +#ifdef CONFIG_KUNIT_DEBUGFS
>> +       struct kunit_suite suite;
>> +       struct kunit_log_frag *frag, *src;
>> +
>> +       suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
>> +       INIT_LIST_HEAD(suite.log);
>> +       frag = kunit_kzalloc(test, sizeof(*frag), GFP_KERNEL);
>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
>> +       kunit_init_log_frag(frag);
>> +       list_add_tail(&frag->list, suite.log);
>> +
>> +       src = kunit_kzalloc(test, sizeof(*src), GFP_KERNEL);
>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, src);
>> +       memset(src->buf, 'x', sizeof(src->buf) - 2);
>> +       KUNIT_ASSERT_EQ(test, strlen(src->buf), sizeof(src->buf) - 2);
> 
> Should this be an EXPECT instead? It doesn't seem like the test needs
> to fail immediately if this fails. Let me know what you think.

I think ASSERT is appropriate here. This isn't testing anything
(unless you don't trust memset). It's ensuring that the test data
I generate is what I expect otherwise the following testing is
invalid.

This is redundant because the first 3 lines must produce the expected
string, but I put it in to prove to myself that I can do math and
decided to leave it in.
