Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1452788C03
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 17:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244749AbjHYO7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245416AbjHYO7P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 10:59:15 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE852126;
        Fri, 25 Aug 2023 07:59:13 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37PBOr4f027978;
        Fri, 25 Aug 2023 09:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=ZD8FKKTtU7kQcPRoe6eLXy9fe9a6900/QF8tmKBGP7Q=; b=
        Nf8KRQnWUf/IIm5sLcIrtiUhoZfSIzw/W2A+ryy5nXxPjruFnsnrr2IvhVgGHhqe
        aa4+gvcoPAXmA4W1+Y6vYOKUem8CTmf1WBbXOdHNxUyUwGrMWuuW1BmYZM0aGd/a
        lJuRhEKaMXF1F7zWclAsJY1JFcRJrMOHZCgPmMVQ0UFdaeE0SVWb5xXtds/i4dRE
        3sA7y0L+WIplqKhe7JSvHJxxCQxHIfHiqSrO2ed9/vja9N0yQ7Te1wPly3LaG9T/
        sxNUzYurURt2ZsxwgHv2A3qRLXxNu4pRIp0aX88j0/9FP2/0XfhhSx+YoOrdqp8l
        G8jLWZPWJOG6MihsPsN6aA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sp1rbj6cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 09:58:56 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 25 Aug
 2023 15:58:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Fri, 25 Aug 2023 15:58:54 +0100
Received: from [198.90.251.75] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0636F11AB;
        Fri, 25 Aug 2023 14:58:54 +0000 (UTC)
Message-ID: <b0c2e85f-fcc1-55fb-cef2-2e2d0fe56747@opensource.cirrus.com>
Date:   Fri, 25 Aug 2023 15:58:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 02/10] kunit: string-stream: Improve testing of
 string_stream
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
CC:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230824143129.1957914-1-rf@opensource.cirrus.com>
 <20230824143129.1957914-3-rf@opensource.cirrus.com>
 <CA+GJov7nzgmGmMooAj9BpQ267W6atcsZJ=tULQQJYjbuQL4E0w@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CA+GJov7nzgmGmMooAj9BpQ267W6atcsZJ=tULQQJYjbuQL4E0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pnBpKmozqCv9uvz0RTk876WHbUF_Q49e
X-Proofpoint-GUID: pnBpKmozqCv9uvz0RTk876WHbUF_Q49e
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24/08/2023 23:42, Rae Moar wrote:
> On Thu, Aug 24, 2023 at 10:31 AM Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> Replace the minimal tests with more-thorough testing.
>>

<SNIP>

>> +       KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
> 
> As mentioned in the last version, if this causes a warning we will
> look into it on the KUnit side.
>

It does. I left it because you said you'd do a fix.
But maybe it's better to change it to

KUNIT_EXPECT_TRUE(test, stream_gfp == GFP_KERNEL);

to avoid the warning for now.
