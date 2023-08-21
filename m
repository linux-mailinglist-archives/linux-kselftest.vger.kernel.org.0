Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF1782DF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 18:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjHUQLK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 12:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjHUQLJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 12:11:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1E91BD;
        Mon, 21 Aug 2023 09:10:31 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37LDXE4c021949;
        Mon, 21 Aug 2023 11:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=daAm8nYc/MlFTPQHoO2+LlahLDiH/l9JMNn68PlbW10=; b=
        aLf8dbET2liRhgakxWdGBYEVI9H0KFWy+BcNh47WLu4hdE3CbJ/lWc/4QVVMJctz
        By+CncIDhJ4XBAA0wTHcGoMj4fWwPk82TmC971LC6vdbI+7Y+YM7tMoyXDih/FzX
        uVDJGbw6v9tB6rxa5mOZAXdEEWV+/8TilQ0z8XOrgQF7QzKxMoVmB+WKXBPtakU/
        DNFeRBEXEbKq2xpbM+bl/8jLpj35Cg3AZj8KMOLys97S4bKevcJTv/0kKblgMWw6
        8bsvJzggtQPB1jfPFC/E2xjwwJnr0rSr/CKG5h2/RwKldRK2b+TQrs+mCbX+J4Bb
        mkJW2qDD1LoQNk3mhz4Wgg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sktt5rs5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 11:10:18 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 21 Aug
 2023 17:10:16 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 21 Aug 2023 17:10:16 +0100
Received: from [198.90.251.75] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 686303560;
        Mon, 21 Aug 2023 16:10:16 +0000 (UTC)
Message-ID: <0b780ce7-66a4-1a36-2a8a-a69c95f73d8a@opensource.cirrus.com>
Date:   Mon, 21 Aug 2023 17:10:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 06/10] kunit: string-stream: Pass struct kunit to
 string_stream_get_string()
To:     David Gow <davidgow@google.com>
CC:     <brendan.higgins@linux.dev>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
 <20230814132309.32641-7-rf@opensource.cirrus.com>
 <CABVgOS=WoKEpPU=0f=mSfdx1g6AkEtx6QJTiNru1XSTev3sGaQ@mail.gmail.com>
 <a8804709-ee00-d2ea-d55d-f8138bd3a500@opensource.cirrus.com>
 <CABVgOSmPqM_zt9jGzYcJN-=AQW3z62cC7dzPJkV-jx6rCcMy=g@mail.gmail.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CABVgOSmPqM_zt9jGzYcJN-=AQW3z62cC7dzPJkV-jx6rCcMy=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5MUIGkWS4uW8tNCta8On_OtB1Na3c--j
X-Proofpoint-ORIG-GUID: 5MUIGkWS4uW8tNCta8On_OtB1Na3c--j
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/08/2023 07:26, David Gow wrote:
> On Tue, 15 Aug 2023 at 17:57, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> On 15/8/23 10:16, David Gow wrote:
>>> On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
>>> <rf@opensource.cirrus.com> wrote:
>>>>
>>>> Pass a struct kunit* and gfp_t to string_stream_get_string(). Allocate
>>>> the returned buffer using these instead of using the stream->test and
>>>> stream->gfp.
>>>>
>>>> This is preparation for removing the dependence of string_stream on
>>>> struct kunit, so that string_stream can be used for the debugfs log.
>>>>
>>>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>>>> ---
>>>
>>> Makes sense to me.
>>>
>>> I think that, if we weren't going to remove the struct kunit
>>> dependency, we'd want to either keep a version of
>>> string_stream_get_string() which uses it, or, e.g., fall back to it if
>>> the struct passed in is NULL.
>>>
>>
>> That was my first thought. But I thought that was open to subtle
>> accidental bugs in calling code - it might return you a managed
>> allocation, or it might return you an unmanaged allocation that you
>> must free.
>>
>> As there weren't many callers of string_stream_get_string() I decided
>> to go with changing the API to pass in test and gfp like other managed
>> allocations. This makes it more generalized, since the returned buffer
>> is not part of the stream itself, it's a temporary buffer owned by the
>> caller. It also makes it clearer that what you are getting back is
>> likely to be a managed allocation.
>>
>> If you'd prefer to leave string_stream_get_string() as it was, or make
>> it return an unmanged buffer, I can send a new version.
>>
>>> The other option is to have a version which doesn't manage the string
>>> at all, so just takes a gfp and requires the caller to free it (or
>>
>> I didn't add a companion function to get a raw unmanaged string buffer
>> because there's nothing that needs it. It could be added later if
>> it's needed.
>>
> 
> Fair enough.
> 
>>> register an action to do so). If we did that, we could get rid of the
>>> struct kunit pointer totally (though it may be better to keep it and
>>> have both versions).
>>>
>>
>> Another option is to make string_stream_get_string() return a raw
>> buffer and add a kunit_string_stream_geT_string() that returns a
>> managed buffer. This follows some consistency with the normal mallocs
>> where kunit_xxxx() is the managed version.
>>
> 
> Ooh... I like this best. Let's go with that.
> 

I was busy last week with other things and have only got back to looking
at this.

I'm trying to decide what to do with string_stream_get_string() and I'd
value an opinion.

The only use for a test-managed get_string() is the string_stream test.
So I've thought of 4 options:

1) Add a kunit_string_stream_get_string() anyway. But only the test code
uses it.

2) Change the tests to have a local function to do the same thing, and
add an explicit test case for the (unmanaged)
string_stream_get_string() that ensures it's freed.

3) Change the tests to have a local function to get the string, which
calls string_stream_get_string() then copies it to a test-managed buffer
and frees the unmanaged buffer.

4) Implement a kunit_kfree_on_exit() function that takes an already-
allocated buffer and kfree()s it when the test exists, so that we can
do:

    // on success kunit_kfree_on_exit() returns the buffer it was given
    str = kunit_kfree_on_exit(test, string_stream_get_string(stream));
    KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);

I'm leaning towards (2) but open to going with any of the other options.
