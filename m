Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B53788400
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 11:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbjHYJmT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 05:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbjHYJl5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 05:41:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84592130;
        Fri, 25 Aug 2023 02:41:53 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37P7NEM2031680;
        Fri, 25 Aug 2023 04:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=hRUTXcpiXskPP197fpOdADi5JmQ/F7ahv8AvgqgLzYA=; b=
        n2L/mW+QrbMojX2fMDehYpM4RZBeJT3jewpHt+Y/0m1U8DAvP17K+xHDbCQej9lb
        JvuA0iTSlmoJmENsFVE0dRRIeKW/lLg1/7MHhcxON/XSvl+Xmb5lAGBKRa+iR2c8
        iejeMAjclmw5fHkTs9yB71uCPYb/ZfMNN+c/8ftubOjwE5HUwBoValINWGWd+pgO
        xGR65N/nKbQrNRhHzq+gMEpxKbpLY4giMRXrh0TxL8Tie1/U/BKiYctE9RGquux+
        dahdt+hDzusjABYqsWN4j+zlHNY6+yIdGErU1w9mNhCcgyozqjmNFIyZFq/XHt9+
        RIhV95oP5p6cLwJZUjGCnA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sp1rbhuvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 04:41:41 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 25 Aug
 2023 10:41:39 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 25 Aug 2023 10:41:38 +0100
Received: from [198.90.251.75] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BCBC111CD;
        Fri, 25 Aug 2023 09:41:38 +0000 (UTC)
Message-ID: <3ce4262e-729c-932e-cee7-db07305550d1@opensource.cirrus.com>
Date:   Fri, 25 Aug 2023 10:41:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 08/10] kunit: string-stream: Add tests for freeing
 resource-managed string_stream
Content-Language: en-US
To:     David Gow <davidgow@google.com>
CC:     <brendan.higgins@linux.dev>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230824143129.1957914-1-rf@opensource.cirrus.com>
 <20230824143129.1957914-9-rf@opensource.cirrus.com>
 <CABVgOSnG8epucY52ppNW7-vC_-QL3Lau9zsaw20dXgWTC0GV+Q@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CABVgOSnG8epucY52ppNW7-vC_-QL3Lau9zsaw20dXgWTC0GV+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: whNjsOMf7bL3tuLC9Ni1JJxBRlaUCwku
X-Proofpoint-GUID: whNjsOMf7bL3tuLC9Ni1JJxBRlaUCwku
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25/08/2023 07:49, David Gow wrote:
> On Thu, 24 Aug 2023 at 22:32, 'Richard Fitzgerald' via KUnit
> Development <kunit-dev@googlegroups.com> wrote:
>>
>> string_stream_managed_free_test() allocates a resource-managed
>> string_stream and tests that kunit_free_string_stream() calls
>> string_stream_destroy().
>>
>> string_stream_resource_free_test() allocates a resource-managed
>> string_stream and tests that string_stream_destroy() is called
>> when the test resources are cleaned up.
>>
>> The old string_stream_init_test() has been split into two tests,
>> one for kunit_alloc_string_stream() and the other for
>> alloc_string_stream().
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>> Changes since V4:
>> - Added test case for kunit_free_string_stream().
>> - Split the initialization test into separate tests for managed and
>>    unmanaged allocations.
>> ---
> 
> Looking over this again, I'm not convinced the streams are actually
> getting freed. Once the stub has finished, the stream is removed from
> the list of deferred actions / resources.
> 

Argh, I think you're right. My original version stashed the stream into
the private data and freed it in a test exit() function so that it was
guaranteed to be freed even if the resource cleanup wasn't called and
the test function aborted before it could do a manual cleanup.
I decided to simplify that but actually that original implementation was
better.

