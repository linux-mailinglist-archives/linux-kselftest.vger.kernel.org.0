Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1049677CADC
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbjHOJ6B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbjHOJ5n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:57:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094DEF7;
        Tue, 15 Aug 2023 02:57:40 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37F8tg3B001809;
        Tue, 15 Aug 2023 04:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=ZNPjAeE5YnECSaUt9zbIIpoKxn8nKOtX2VZRGmkqxe0=; b=
        debtOuoF2aEkWgMJv39U3lVnw8ubGEQfidXErCQeVhjgjaLEpFLZzXex9wwzOp2T
        NeLna6x4mzxJoQfHbxUtAcB9D8vpkGbmJGuI+MV73lNRMFC9vjnkNgTWLrjCyhbK
        rwHORsJm9opCKGssexOtQDIViA7ex2WqTBGxeqHdyFl0qPIAxGTsd2IBXnd3N0Yo
        gc1qNrIi3jCeneRgrBOZrzD99PkGNzXrrgzhvMDbDqbNdd9pxxA7t503WVFBWSC1
        NJr4/ZLZQLULlzQNTNF9A9qoLbdqZt/Iqvc0vJueyTJ0Fo+4FTUSluOoB71l5LVW
        q9VTpgD4gUrihNFCZMFDFQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhjtkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 04:57:36 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 15 Aug
 2023 10:57:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 15 Aug 2023 10:57:34 +0100
Received: from [198.61.65.68] (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3EAED11AA;
        Tue, 15 Aug 2023 09:57:34 +0000 (UTC)
Message-ID: <a8804709-ee00-d2ea-d55d-f8138bd3a500@opensource.cirrus.com>
Date:   Tue, 15 Aug 2023 10:57:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 06/10] kunit: string-stream: Pass struct kunit to
 string_stream_get_string()
Content-Language: en-US
To:     David Gow <davidgow@google.com>
CC:     <brendan.higgins@linux.dev>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
 <20230814132309.32641-7-rf@opensource.cirrus.com>
 <CABVgOS=WoKEpPU=0f=mSfdx1g6AkEtx6QJTiNru1XSTev3sGaQ@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CABVgOS=WoKEpPU=0f=mSfdx1g6AkEtx6QJTiNru1XSTev3sGaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xcIhC68AuyMZUnLZfqYBQ4kvndF3OPNm
X-Proofpoint-ORIG-GUID: xcIhC68AuyMZUnLZfqYBQ4kvndF3OPNm
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
>> Pass a struct kunit* and gfp_t to string_stream_get_string(). Allocate
>> the returned buffer using these instead of using the stream->test and
>> stream->gfp.
>>
>> This is preparation for removing the dependence of string_stream on
>> struct kunit, so that string_stream can be used for the debugfs log.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
> 
> Makes sense to me.
> 
> I think that, if we weren't going to remove the struct kunit
> dependency, we'd want to either keep a version of
> string_stream_get_string() which uses it, or, e.g., fall back to it if
> the struct passed in is NULL.
>

That was my first thought. But I thought that was open to subtle
accidental bugs in calling code - it might return you a managed
allocation, or it might return you an unmanaged allocation that you
must free.

As there weren't many callers of string_stream_get_string() I decided
to go with changing the API to pass in test and gfp like other managed
allocations. This makes it more generalized, since the returned buffer
is not part of the stream itself, it's a temporary buffer owned by the
caller. It also makes it clearer that what you are getting back is
likely to be a managed allocation.

If you'd prefer to leave string_stream_get_string() as it was, or make
it return an unmanged buffer, I can send a new version.

> The other option is to have a version which doesn't manage the string
> at all, so just takes a gfp and requires the caller to free it (or

I didn't add a companion function to get a raw unmanaged string buffer
because there's nothing that needs it. It could be added later if
it's needed.

> register an action to do so). If we did that, we could get rid of the
> struct kunit pointer totally (though it may be better to keep it and
> have both versions).
> 

Another option is to make string_stream_get_string() return a raw
buffer and add a kunit_string_stream_geT_string() that returns a
managed buffer. This follows some consistency with the normal mallocs
where kunit_xxxx() is the managed version.

> So -- to switch to some stream-of-consciousness thoughts about this --
> basically there are three possible variants of
> string_stream_get_string():
> - Current version: uses the stream's struct kunit. Useless if this is
> NULL, but very convenient otherwise.
> - This patch: manage the string using the struct kunit passed as an
> argument. Still can't be used directly outside a test, but adds enough
> flexibility to get _append to work.
> - Totally unmanaged: the generated string is allocated separately, and
> must be freed (directly or in a deferred action) by the caller. Works
> well outside tests, but less convenient.
> 
> Personally, I feel that the design of string_stream is heading towards
> the third option. By the end of this series, everything uses
> _string_stream_concatenate_to_buf() anyway. There's only one call to
> string_stream_get_string() outside of the logging / string_stream
> tests, and all that does is log the results (and it has a fallback to
> log each fragment separately if the allocation fails).
> 
> Then again, if this is only really being used in tests, then we can
> probably just stick with string_stream_get_string() as-is, remove the
> string_stream->test member totally, and if we need it, we can make
> _string_stream_concatenate_to_buf() public, or add an unmanaged
> version anyway.
>

I didn't remove ->test because there's some existing code in assert.c
that uses it, and I didn't want to break that.

> So, after all that, I think this is probably good as-is. _Maybe_ we
> could rename string_stream_get_string() to something like
> string_stream_get_managed_string(), now that it's the only function
> which is "managed" as a KUnit resource, but we can equally put that
> off until we need to add an unmanaged version.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
> 
>>   lib/kunit/string-stream-test.c | 26 +++++++++++++++-----------
>>   lib/kunit/string-stream.c      |  8 ++++----
>>   lib/kunit/string-stream.h      |  3 ++-
>>   lib/kunit/test.c               |  2 +-
>>   4 files changed, 22 insertions(+), 17 deletions(-)
>>
>> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
>> index 46c2ac162fe8..8a30bb7d5fb7 100644
>> --- a/lib/kunit/string-stream-test.c
>> +++ b/lib/kunit/string-stream-test.c
>> @@ -57,7 +57,7 @@ static void string_stream_line_add_test(struct kunit *test)
>>          }
>>          num_lines = i;
>>
>> -       concat_string = string_stream_get_string(stream);
>> +       concat_string = string_stream_get_string(test, stream, GFP_KERNEL);
>>          KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
>>          KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
>>
>> @@ -113,7 +113,7 @@ static void string_stream_variable_length_line_test(struct kunit *test)
>>          }
>>          num_lines = i;
>>
>> -       concat_string = string_stream_get_string(stream);
>> +       concat_string = string_stream_get_string(test, stream, GFP_KERNEL);
>>          KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
>>          KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
>>
>> @@ -165,17 +165,18 @@ static void string_stream_append_test(struct kunit *test)
>>
>>          /* Append content of empty stream to empty stream */
>>          string_stream_append(stream_1, stream_2);
>> -       KUNIT_EXPECT_EQ(test, strlen(string_stream_get_string(stream_1)), 0);
>> +       KUNIT_EXPECT_EQ(test, strlen(string_stream_get_string(test, stream_1, GFP_KERNEL)), 0);
>>
>>          /* Add some data to stream_1 */
>>          for (i = 0; i < ARRAY_SIZE(strings_1); ++i)
>>                  string_stream_add(stream_1, "%s\n", strings_1[i]);
>>
>> -       original_content = string_stream_get_string(stream_1);
>> +       original_content = string_stream_get_string(test, stream_1, GFP_KERNEL);
>>
>>          /* Append content of empty stream to non-empty stream */
>>          string_stream_append(stream_1, stream_2);
>> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), original_content);
>> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
>> +                          original_content);
>>
>>          /* Add some data to stream_2 */
>>          for (i = 0; i < ARRAY_SIZE(strings_2); ++i)
>> @@ -188,14 +189,15 @@ static void string_stream_append_test(struct kunit *test)
>>           * End result should be the original content of stream_1 plus
>>           * the content of stream_2.
>>           */
>> -       stream_2_content = string_stream_get_string(stream_2);
>> +       stream_2_content = string_stream_get_string(test, stream_2, GFP_KERNEL);
>>          combined_length = strlen(original_content) + strlen(stream_2_content);
>>          combined_length++; /* for terminating \0 */
>>          combined_content = kunit_kmalloc(test, combined_length, GFP_KERNEL);
>>          KUNIT_ASSERT_NOT_ERR_OR_NULL(test, combined_content);
>>          snprintf(combined_content, combined_length, "%s%s", original_content, stream_2_content);
>>
>> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), combined_content);
>> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
>> +                          combined_content);
>>
>>          /* Append content of non-empty stream to empty stream */
>>          string_stream_destroy(stream_1);
>> @@ -204,7 +206,8 @@ static void string_stream_append_test(struct kunit *test)
>>          KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
>>
>>          string_stream_append(stream_1, stream_2);
>> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), stream_2_content);
>> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
>> +                          stream_2_content);
>>   }
>>
>>   /* Adding an empty string should not create a fragment. */
>> @@ -224,7 +227,8 @@ static void string_stream_append_empty_string_test(struct kunit *test)
>>          string_stream_add(stream, "Add this line");
>>          string_stream_add(stream, "%s", "");
>>          KUNIT_EXPECT_EQ(test, list_count_nodes(&stream->fragments), 1);
>> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream), "Add this line");
>> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
>> +                          "Add this line");
>>   }
>>
>>   /* Adding strings without automatic newline appending */
>> @@ -244,7 +248,7 @@ static void string_stream_no_auto_newline_test(struct kunit *test)
>>          string_stream_add(stream, "Two\n");
>>          string_stream_add(stream, "%s\n", "Three");
>>          string_stream_add(stream, "Four");
>> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
>> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
>>                             "OneTwo\nThree\nFour");
>>   }
>>
>> @@ -271,7 +275,7 @@ static void string_stream_auto_newline_test(struct kunit *test)
>>          string_stream_add(stream, "Five\n%s", "Six");
>>          string_stream_add(stream, "Seven\n\n");
>>          string_stream_add(stream, "Eight");
>> -       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
>> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
>>                             "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
>>   }
>>
>> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
>> index 1dcf6513b692..eb673d3ea3bd 100644
>> --- a/lib/kunit/string-stream.c
>> +++ b/lib/kunit/string-stream.c
>> @@ -117,13 +117,14 @@ static void string_stream_clear(struct string_stream *stream)
>>          spin_unlock(&stream->lock);
>>   }
>>
>> -char *string_stream_get_string(struct string_stream *stream)
>> +char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
>> +                              gfp_t gfp)
>>   {
>>          struct string_stream_fragment *frag_container;
>>          size_t buf_len = stream->length + 1; /* +1 for null byte. */
>>          char *buf;
>>
>> -       buf = kunit_kzalloc(stream->test, buf_len, stream->gfp);
>> +       buf = kunit_kzalloc(test, buf_len, gfp);
>>          if (!buf)
>>                  return NULL;
>>
>> @@ -140,8 +141,7 @@ int string_stream_append(struct string_stream *stream,
>>   {
>>          const char *other_content;
>>
>> -       other_content = string_stream_get_string(other);
>> -
>> +       other_content = string_stream_get_string(other->test, other, other->gfp);
>>          if (!other_content)
>>                  return -ENOMEM;
>>
>> diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
>> index 048930bf97f0..6b4a747881c5 100644
>> --- a/lib/kunit/string-stream.h
>> +++ b/lib/kunit/string-stream.h
>> @@ -39,7 +39,8 @@ int __printf(2, 0) string_stream_vadd(struct string_stream *stream,
>>                                        const char *fmt,
>>                                        va_list args);
>>
>> -char *string_stream_get_string(struct string_stream *stream);
>> +char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
>> +                              gfp_t gfp);
>>
>>   int string_stream_append(struct string_stream *stream,
>>                           struct string_stream *other);
>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>> index 49698a168437..520e15f49d0d 100644
>> --- a/lib/kunit/test.c
>> +++ b/lib/kunit/test.c
>> @@ -286,7 +286,7 @@ static void kunit_print_string_stream(struct kunit *test,
>>          if (string_stream_is_empty(stream))
>>                  return;
>>
>> -       buf = string_stream_get_string(stream);
>> +       buf = string_stream_get_string(test, stream, GFP_KERNEL);
>>          if (!buf) {
>>                  kunit_err(test,
>>                            "Could not allocate buffer, dumping stream:\n");
>> --
>> 2.30.2
>>
