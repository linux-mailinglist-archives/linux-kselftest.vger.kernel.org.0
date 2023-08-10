Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C50E777BB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 17:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjHJPJX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjHJPJW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 11:09:22 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53B42686;
        Thu, 10 Aug 2023 08:09:21 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37AEUdto023085;
        Thu, 10 Aug 2023 10:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=9/pp/DyC8r9jmrp7a4h7KMPULXDqOwVsMpDIlIYPj9Q=; b=
        Js2fJ1KWMAFMgsaAAVw9St6g+KK6Pi/y9E+dVjzw6qgs7lnjLHs091qTe01sMuVQ
        0IWcIx3zfk+wrch9Nd0B97Nh/rqFV68qMPGUHxJ/BDTsUBgc4kS+kIN16faVe6xw
        Q12qoSM1efwfNI7qYl9jE4IVEGSmV2SFCNmbKJzYOZJU8eQtG73pvSeu3SUUVqEv
        c6kYErktNTMg5fwz5UhZRPFMikawJpIQXzhFtt7crb9l5qAxmiaHEl6UV/bvxhAS
        wHylKRhX1SQ96fapwHviH99DNJbKY7ip0O/qDXnejIZ34vDqmdMbjrgdnt/lL9m6
        Hj9+PIEcUnl2X1mNQn57aw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhvyd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 10:09:17 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 16:09:16 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 10 Aug 2023 16:09:16 +0100
Received: from [198.61.64.220] (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E7B2F475;
        Thu, 10 Aug 2023 15:09:15 +0000 (UTC)
Message-ID: <1cba22b4-d8e2-e5bf-98b2-597dd1797304@opensource.cirrus.com>
Date:   Thu, 10 Aug 2023 16:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/7] kunit: Handle logging of lines longer than the
 fragment buffer size
Content-Language: en-US
To:     David Gow <davidgow@google.com>
CC:     <brendan.higgins@linux.dev>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
 <20230809155438.22470-4-rf@opensource.cirrus.com>
 <CABVgOSn4PWT6+TobiJd+ppmPXsL+0qtLdazgjuQmfymUfkYhnA@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CABVgOSn4PWT6+TobiJd+ppmPXsL+0qtLdazgjuQmfymUfkYhnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ft1UaSf3vx8su6TkTYP31EcRL1lMHV71
X-Proofpoint-ORIG-GUID: ft1UaSf3vx8su6TkTYP31EcRL1lMHV71
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/8/23 15:38, David Gow wrote:
> On Wed, 9 Aug 2023 at 23:54, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> Add handling to kunit_log_append() for log messages that are longer than
>> a single buffer fragment.
>>
>> The initial implementation of fragmented buffers did not change the logic
>> of the original kunit_log_append(). A consequence was that it still had
>> the original assumption that a log line will fit into one buffer.
>>
>> This patch checks for log messages that are larger than one fragment
>> buffer. In that case, kvasprintf() is used to format it into a temporary
>> buffer and that content is then split across as many fragments as
>> necessary.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
> 
> I think this looks good (and is a long-overdue addition to the logging
> functionality).
> 
> One thought I have (and I'm kicking myself for not thinking of it
> earlier) is that this is starting to get very similar to the "string
> stream" functionality in lib/kunit/string-stream.{h,c}. Now, I
> actually think this implementation is much more efficient (using
> larger fragments, whereas the string stream uses variable-sized ones).
> Particularly since there are a lot of cases where string streams are
> created, converted to a string, and then logged, there's almost
> certainly a bunch of redundant work being done here.
>
> My gut feeling is that we should stick with this as-is, and maybe try
> to either work out some better integration between string streams and
> logging (to avoid that extra string allocation) or find some way of
> combining them.
>

I completely failed to notice string_stream. I could re-implement this
to use string_stream. I wonder whether appending newlines gets
a bit inefficient with the current string_stream implementation.
Could add newline support to string_stream and alloc one extra byte for
each fragment just in case we need to add a newline.

The string_stream implementation would waste a lot a memory if you log
many short lines. My current code wastes memory if you log lots of lines
that don't fit in available space in the current fragment - though it's
simple to shuffle the formatted string backwards to fill up the previous
fragment (I just haven't done that yet).
