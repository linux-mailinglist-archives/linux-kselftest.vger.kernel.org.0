Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C14C77568E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 11:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjHIJjs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 05:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIJjr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 05:39:47 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF61CE5F;
        Wed,  9 Aug 2023 02:39:46 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3799QrUN006884;
        Wed, 9 Aug 2023 04:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=tL17/6iyipsOU59e0c5UNfl2W0eyYBu+2pEFX/ofQYc=; b=
        XasJT4v0Wsi59u4hY4lqtUfmhpW3wquLI/89RtVTzdfewFtHYSSrMTTqeLQaTNg5
        BFG6/ms9Q2ByxPufh6Q4cDeWlvA+3AhqV4Q6JMtMrUCEURyri0kOLoogMSbWHBrt
        1aHn7MuBMB5SafWql42rppxM0Ps5NfydD4c5uOEjfY5pHGQxuCleJbfraT8323At
        PEGl0BDW3l/R5xQBDx/cLeLHuJUAM5i8iz6PN5jbxYgiEBKeLI03pB/dJ9oV8G2+
        6dDEmhqew/w1cgjk6QwqjTOFYzxm+muV3m6ZSQu2+osS8ji19a/pedbTXLRP1MOO
        r4blrHJnoSvVb/QLQ55LQA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhuhgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 04:39:41 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 10:39:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 10:39:40 +0100
Received: from [198.61.64.220] (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AE239475;
        Wed,  9 Aug 2023 09:39:39 +0000 (UTC)
Message-ID: <371a6ba0-c076-8e44-ae2f-32429de507da@opensource.cirrus.com>
Date:   Wed, 9 Aug 2023 10:39:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/6] kunit: kunit-test: Add test cases for extending
 log buffer
To:     Rae Moar <rmoar@google.com>
CC:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230808123529.4725-1-rf@opensource.cirrus.com>
 <20230808123529.4725-3-rf@opensource.cirrus.com>
 <CA+GJov79EJLbdptX+hhTqa90C7A0aJ-wzjxF1LDn++jWHeNXFA@mail.gmail.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CA+GJov79EJLbdptX+hhTqa90C7A0aJ-wzjxF1LDn++jWHeNXFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8gc6zDVdOhxj4Nv9tbtffi6NqOn_-TiD
X-Proofpoint-ORIG-GUID: 8gc6zDVdOhxj4Nv9tbtffi6NqOn_-TiD
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/23 22:16, Rae Moar wrote:
> On Tue, Aug 8, 2023 at 8:35 AM Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> Add test cases for the dynamically-extending log buffer.
>>
>> kunit_log_extend_test_1() logs a series of numbered lines then tests
>> that the resulting log contains all the lines.
>>
>> kunit_log_extend_test_2() logs a large number of lines of varying length
>> to create many fragments, then tests that all lines are present.
>>
>> kunit_log_frag_sized_line_test() logs a line that exactly fills a
>> fragment. This should not cause an extension of the log or truncation
>> of the line.
>>
>> kunit_log_newline_test() has a new test to append a line that is exactly
>> the length of the available space in the current fragment and check that
>> the resulting log has a trailing '\n'.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> Hello!
> 
> I am happy to see so many tests in this patch series. I've been
> working with these patches and the debugfs logs seem to be working
> well.
> 
> However, when I ran the new kunit-log-test tests three of the tests
> failed: kunit_log_extend_test_1(), kunit_log_extend_test_2(), and
> kunit_log_newline_test().
> 
> The diagnostic info for kunit_log_extend_test_1() reports:
> 
> [20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
> lib/kunit/kunit-test.c:705
> [20:55:27] Expected p == line, but
> [20:55:27]     p == "xxxxxx…xxxx12345678"
> [20:55:27]     line == "The quick brown fox jumps over the lazy penguin 0"
> …
> [20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
> lib/kunit/kunit-test.c:705
> [20:55:27] Expected p == line, but
> [20:55:27]     p == "The quick brown fox jumps over the lazy penguin 1"
> [20:55:27]     line == "The quick brown fox jumps over the lazy penguin 4"
> [20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
> lib/kunit/kunit-test.c:705
> [20:55:27] Expected p == line, but
> [20:55:27]     p == "The quick brown fox jumps over the lazy penguin 2"
> [20:55:27]     line == "The quick brown fox jumps over the lazy penguin 5"
> …
> [20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
> lib/kunit/kunit-test.c:709
> [20:55:27] Expected i == num_lines, but
> [20:55:27]     i == 64 (0x40)
> [20:55:27]     num_lines == 141 (0x8d)
> 
> So it looks like the log contains a different number of lines than
> expected which is causing the difference of 3 between expected and
> what was obtained. Potentially the log is not getting cleared/freed
> properly in between test cases?
> 
> The diagnostic info for kunit_log_extend_test_2() reports:
> 
> [20:55:27]     # kunit_log_extend_test_2: EXPECTATION FAILED at
> lib/kunit/kunit-test.c:776
> [20:55:27]     Expected p == &line[i], but
> [20:55:27]         p ==
> "xxxxx...xxxxx123456780123456789abcdef101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f30313233343536373839"
> [20:55:27]         &line[i] ==
> "0123456789abcdef101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f30313233343536373839"
> [20:55:27]     # kunit_log_extend_test_2: EXPECTATION FAILED at
> lib/kunit/kunit-test.c:781
> [20:55:27]     Expected n == num_lines, but
> [20:55:27]         n == 147 (0x93)
> [20:55:27]         num_lines == 155 (0x9b)
> [20:55:27] Not enough lines.
> 
> Similar difference in the number of lines here.
> 
> The diagnostic info for kunit_log_newline_test() reports that the test
> fails on this line:
> 
> KUNIT_EXPECT_EQ(test, p[strlen(p) - 1], '\n');
> 
> Let me know if you are seeing similar errors. I can post the full log
> if that would be helpful.
> 
> -Rae
> 

Ah, I see a bug in get_concatenated_log().
Does this change fix it for you?

	len++; /* for terminating '\0' */
-	p = kunit_kmalloc(test, len, GFP_KERNEL);
+	p = kunit_kzalloc(test, len, GFP_KERNEL);
