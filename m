Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B646788390
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbjHYJcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 05:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjHYJcm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 05:32:42 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23244E78;
        Fri, 25 Aug 2023 02:32:40 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37P62Jgq024160;
        Fri, 25 Aug 2023 04:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=e90jr+4DwGo0wstBMc+/6tHfgYm3n0aiQvuAcvF/gY4=; b=
        kKh+ErKFYv7GNsnzf9cR2OjwgJjq9yOlDWB7+vhozQYibwSVTFpVJjG1fp+DR62Q
        gxzhglrShwQUazHmgms4q8t4/IbnAUKT6+Po2aSgZw1/CvqGns3P8PqiCo05Ppnj
        leZCjjpOA5aQJGgZU6MCTOAxIahShp+kag35kLL+19/HeY2KME9m8al726OVHIC4
        ZZXR2ud5cBeOS5IunnR19sseWi0AhxRiAAfyGqmPAVzKCREXh/KGn9IlO+bH09Rz
        +IxAgAhnUgo04cITzKa0K7sx9tk//Q53BplCHNSseKNBCGswbJWwqpICxYZDCce0
        2kHtOlnRNtM8NiLXirXXpg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sp1w8hhtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 04:32:30 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 25 Aug
 2023 10:32:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 25 Aug 2023 10:32:28 +0100
Received: from [198.90.251.75] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5D65D11AB;
        Fri, 25 Aug 2023 09:32:28 +0000 (UTC)
Message-ID: <b37dfc5c-8cd6-8d99-e0ec-6f0e5a30d68e@opensource.cirrus.com>
Date:   Fri, 25 Aug 2023 10:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 02/10] kunit: string-stream: Improve testing of
 string_stream
Content-Language: en-US
To:     David Gow <davidgow@google.com>
CC:     <brendan.higgins@linux.dev>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230824143129.1957914-1-rf@opensource.cirrus.com>
 <20230824143129.1957914-3-rf@opensource.cirrus.com>
 <CABVgOSn4H7HAbn2ZR0KFBwLT6GfBteaGVJa8KT8Q4fjhM7nUQw@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CABVgOSn4H7HAbn2ZR0KFBwLT6GfBteaGVJa8KT8Q4fjhM7nUQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DBtV1umGZVBCzoeGMESnnD49jAGOFHJK
X-Proofpoint-ORIG-GUID: DBtV1umGZVBCzoeGMESnnD49jAGOFHJK
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25/08/2023 07:49, David Gow wrote:
> On Thu, 24 Aug 2023 at 22:33, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> Replace the minimal tests with more-thorough testing.
>>
>> string_stream_init_test() tests that struct string_stream is
>> initialized correctly.
>>
>> string_stream_line_add_test() adds a series of numbered lines and
>> checks that the resulting string contains all the lines.
>>
>> string_stream_variable_length_line_test() adds a large number of
>> lines of varying length to create many fragments, then tests that all
>> lines are present.
>>
>> string_stream_append_test() tests various cases of using
>> string_stream_append() to append the content of one stream to another.
>>
>> Adds string_stream_append_empty_string_test() to test that adding an
>> empty string to a string_stream doesn't create a new empty fragment.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>> Changes since V4:
>> - Test cases for appending empty strings have been squashed into this
>>    patch.
>> - Call to string_stream_get_string() is wrapped in a local function
>>    get_concatenated_string(). This is to avoid a lot of code churn later
>>    when string_stream_get_string() is changed to return an unmanaged buffer.
>> ---
> 
> This looks good to me. I'm not 100% sold on the
> 'get_concatenated_string()' function long-term (despite its obvious
> benefits during the refactoring), but that's just personal taste. This
> version is fine regardless.
> 

Yes, we can remove it later. I just wanted to avoid having one enormous
patch that changes everything all over the place.

