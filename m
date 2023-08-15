Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BAE77CB56
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 12:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjHOKw1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 06:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjHOKv4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 06:51:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65BC10F0;
        Tue, 15 Aug 2023 03:51:53 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37F8NSYj026686;
        Tue, 15 Aug 2023 05:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=cwjELXmWJaPG9Bubpqfuifs7eeqE00Mk3Yoo/MKyZnk=; b=
        pw7v1mGYIBProBmyI6nOwQvgxWXEf8v7qWhPL+MHd1yMuMuZxvb1USzBPrav8iEa
        61melZ69OGhSMmB/JVEiwbOjXvivRqEgm6RGIgwLXKbQEICFoU6B9dU2TgnAE+sn
        yr49oLrO2TV5l4gr3e8wa9AwrtGh1YYzguPrv3lSyYBg+QqVFMj5wM59gv9KSw9Q
        899sM5T7Td1u9RGQCgXCP2o76Co+5DRaJ2pNh317YzFNs4bAeOmeSbfnOmvJhSsh
        qnkkqsmYSYLeixLHAYh1dz2zVTcq2Vr/8C/yJQw6TsksJlMQpszR+a+V5nZbwoht
        waG39zNCWeR4BarEcVh+2g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhjuxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 05:51:49 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 15 Aug
 2023 11:51:48 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 15 Aug 2023 11:51:48 +0100
Received: from [198.61.65.68] (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CC31111AA;
        Tue, 15 Aug 2023 10:51:47 +0000 (UTC)
Message-ID: <c787061d-b478-6ec4-9a7f-091baf2864a3@opensource.cirrus.com>
Date:   Tue, 15 Aug 2023 11:51:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 07/10] kunit: string-stream: Decouple string_stream
 from kunit
Content-Language: en-US
To:     David Gow <davidgow@google.com>
CC:     <brendan.higgins@linux.dev>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
 <20230814132309.32641-8-rf@opensource.cirrus.com>
 <CABVgOSmBD7zWjn5ovwUAv23r=O5Z6q8+k=vUD6Jh=MZ3prUuDg@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CABVgOSmBD7zWjn5ovwUAv23r=O5Z6q8+k=vUD6Jh=MZ3prUuDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hSw4x8P9tktT9v5pNtkzUiGdcTSfSdyp
X-Proofpoint-ORIG-GUID: hSw4x8P9tktT9v5pNtkzUiGdcTSfSdyp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15/8/23 10:16, David Gow wrote:
> On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> Re-work string_stream so that it is not tied to a struct kunit. This is
>> to allow using it for the log of struct kunit_suite.
>>
>> Instead of resource-managing individual allocations the whole string_stream
>> object can be resource-managed as a single object:
>>
>>      alloc_string_stream() API is unchanged and takes a pointer to a
>>      struct kunit but it now registers the returned string_stream object to
>>      be resource-managed.
>>
>>      raw_alloc_string_stream() is a new function that allocates a
>>      bare string_stream without any association to a struct kunit.
>>
>>      free_string_stream() is a new function that frees a resource-managed
>>      string_stream allocated by alloc_string_stream().
>>
>>      raw_free_string_stream() is a new function that frees a non-managed
>>      string_stream allocated by raw_alloc_string_stream().
>>
>> The confusing function string_stream_destroy() has been removed. This only
>> called string_stream_clear() but didn't free the struct string_stream.
>> Instead string_stream_clear() has been exported, and the new functions use
>> the more conventional naming of "free" as the opposite of "alloc".
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
> 
> I'm in favour of this. Should we go further and get rid of the struct
> kunit member from string_stream totally?
>

I can do that. I was worried about some hairy-looking code in assert.c
that used stream->test. But I've just looked at it again and it's
really quite simple, and doesn't even need ->test. is_literal()
allocates a temporary managed buffer, but it frees it before returning
so it doesn't need to be managed.

> Also, note that the kunit_action_t casting is causing warnings on some
> clang configs (and technically isn't valid C). Personally, I still
> like it, but expect more emails from the kernel test robot and others.
> 

I can send a new version to fix that.

