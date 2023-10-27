Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F257D8DD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 06:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjJ0EnK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 00:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJ0EnJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 00:43:09 -0400
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [IPv6:2001:41d0:203:375::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E41B2
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Oct 2023 21:43:04 -0700 (PDT)
Message-ID: <20d0c45e-8e1a-4bb9-93eb-8487d8d79651@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698381782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ik0PNz5cQTLwJ/kpyE4amSYtABFvL9Eg+IQVHIyZu+o=;
        b=xuO6J+luBKh/qkjLfM1f7YyvHtYZg2fzrXx/Mfa7uP5FIyXy7q9OzjT2JHf0bhwOQ48s6G
        n5vHaHdhAHx9J9+pBDVr2XV5Plqptkk8Y2RkgrFXyKvL5Ph0W+HIb0a/82jrwLWB6fV4ZU
        Tch04+73x7nPeBUo+UFt4ZP32wcfupM=
Date:   Thu, 26 Oct 2023 21:42:56 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Convert CHECK macros to
 ASSERT_* macros in bpf_iter
Content-Language: en-GB
To:     Kui-Feng Lee <sinquersw@gmail.com>,
        Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, brauner@kernel.org, iii@linux.ibm.com,
        kuifeng@meta.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026020319.1203600-1-yuran.pereira@hotmail.com>
 <DB3PR10MB68352B683F26EE9C342B71A9E8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <3739e65c-b86d-4c11-9cf5-7b76080400c2@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3739e65c-b86d-4c11-9cf5-7b76080400c2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 10/25/23 9:33 PM, Kui-Feng Lee wrote:
>
>
> On 10/25/23 19:03, Yuran Pereira wrote:
>> As it was pointed out by Yonghong Song [1], in the bpf selftests the use
>> of the ASSERT_* series of macros is preferred over the CHECK macro.
>> This patch replaces all CHECK calls in bpf_iter with the appropriate
>> ASSERT_* macros.
>>
>> [1] 
>> https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev
>>
>> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
>> ---
>>   .../selftests/bpf/prog_tests/bpf_iter.c       | 82 +++++++++----------
>>   1 file changed, 39 insertions(+), 43 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c 
>> b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>> index 1f02168103dd..7db6972ed952 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>> @@ -34,8 +34,6 @@
>>   #include "bpf_iter_ksym.skel.h"
>>   #include "bpf_iter_sockmap.skel.h"
>>   -static int duration;
>> -
>>   static void test_btf_id_or_null(void)
>>   {
>>       struct bpf_iter_test_kern3 *skel;
>> @@ -64,7 +62,7 @@ static void do_dummy_read_opts(struct bpf_program 
>> *prog, struct bpf_iter_attach_
>>       /* not check contents, but ensure read() ends without error */
>>       while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>>           ;
>> -    CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
>> +    ASSERT_GE(len, 0, "read");
>>         close(iter_fd);
>>   @@ -413,7 +411,7 @@ static int do_btf_read(struct bpf_iter_task_btf 
>> *skel)
>>           goto free_link;
>>       }
>>   -    if (CHECK(err < 0, "read", "read failed: %s\n", strerror(errno)))
>> +    if (!ASSERT_GE(err, 0, "read"))
>>           goto free_link;
>>         ASSERT_HAS_SUBSTR(taskbuf, "(struct task_struct)",
>> @@ -526,11 +524,11 @@ static int do_read_with_fd(int iter_fd, const 
>> char *expected,
>>       start = 0;
>>       while ((len = read(iter_fd, buf + start, read_buf_len)) > 0) {
>>           start += len;
>> -        if (CHECK(start >= 16, "read", "read len %d\n", len))
>> +        if (!ASSERT_LT(start, 16, "read"))
>>               return -1;
>>           read_buf_len = read_one_char ? 1 : 16 - start;
>>       }
>> -    if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
>> +    if (!ASSERT_GE(len, 0, "read"))
>>           return -1;
>>         if (!ASSERT_STREQ(buf, expected, "read"))
>> @@ -571,8 +569,7 @@ static int do_read(const char *path, const char 
>> *expected)
>>       int err, iter_fd;
>>         iter_fd = open(path, O_RDONLY);
>> -    if (CHECK(iter_fd < 0, "open", "open %s failed: %s\n",
>> -          path, strerror(errno)))
>> +    if (!ASSERT_GE(iter_fd, 0, "open"))
>>           return -1;
>>         err = do_read_with_fd(iter_fd, expected, false);
>> @@ -600,7 +597,7 @@ static void test_file_iter(void)
>>       unlink(path);
>>         err = bpf_link__pin(link, path);
>> -    if (CHECK(err, "pin_iter", "pin_iter to %s failed: %d\n", path, 
>> err))
>> +    if (!ASSERT_OK(err, "pin_iter"))
>>           goto free_link;
>>         err = do_read(path, "abcd");
>> @@ -651,12 +648,10 @@ static void test_overflow(bool 
>> test_e2big_overflow, bool ret1)
>>        * overflow and needs restart.
>>        */
>>       map1_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 8, 1, NULL);
>> -    if (CHECK(map1_fd < 0, "bpf_map_create",
>> -          "map_creation failed: %s\n", strerror(errno)))
>> +    if (!ASSERT_GE(map1_fd, 0, "bpf_map_create"))
>>           goto out;
>>       map2_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 8, 1, NULL);
>> -    if (CHECK(map2_fd < 0, "bpf_map_create",
>> -          "map_creation failed: %s\n", strerror(errno)))
>> +    if (!ASSERT_GE(map2_fd, 0, "bpf_map_create"))
>>           goto free_map1;
>>         /* bpf_seq_printf kernel buffer is 8 pages, so one map
>> @@ -685,14 +680,12 @@ static void test_overflow(bool 
>> test_e2big_overflow, bool ret1)
>>       /* setup filtering map_id in bpf program */
>>       map_info_len = sizeof(map_info);
>>       err = bpf_map_get_info_by_fd(map1_fd, &map_info, &map_info_len);
>> -    if (CHECK(err, "get_map_info", "get map info failed: %s\n",
>> -          strerror(errno)))
>> +    if (!ASSERT_OK(err, "get_map_info"))
>>           goto free_map2;
>>       skel->bss->map1_id = map_info.id;
>>         err = bpf_map_get_info_by_fd(map2_fd, &map_info, &map_info_len);
>> -    if (CHECK(err, "get_map_info", "get map info failed: %s\n",
>> -          strerror(errno)))
>> +    if (!ASSERT_OK(err, "get_map_info"))
>>           goto free_map2;
>>       skel->bss->map2_id = map_info.id;
>>   @@ -714,16 +707,15 @@ static void test_overflow(bool 
>> test_e2big_overflow, bool ret1)
>>           while ((len = read(iter_fd, buf, expected_read_len)) > 0)
>>               total_read_len += len;
>>   -        CHECK(len != -1 || errno != E2BIG, "read",
>> -              "expected ret -1, errno E2BIG, but get ret %d, error 
>> %s\n",
>> -              len, strerror(errno));
>> +        if (!ASSERT_EQ(len, -1, "read"))
>> +            goto free_buf;
>> +        ASSERT_EQ(errno, E2BIG, "read");
>
> I think you can just do
>
>   ASSERT_EQ(len, -1, "read");
>   ASSERT_EQ(errno, E2BG, "read");
>
> without a check here.
> WDYT?

Many recent selftests have ASSERT_* similar to what Kui-Feng is suggested.
So I think it is okay to do adjustment like it. The same for some other suggestions
below.

But since this patch intends to convert CHECK to ASSERT_*, so other possible
'optimizations' like above ASSERT_EQ can stay as is since they do not really
affect functionality.

In the next revision, please put three patches 0/2, 1/2 and 2/2 together as a single
patch set. Thanks.

>
>>           goto free_buf;
>>       } else if (!ret1) {
>>           while ((len = read(iter_fd, buf, expected_read_len)) > 0)
>>               total_read_len += len;
>>   -        if (CHECK(len < 0, "read", "read failed: %s\n",
>> -              strerror(errno)))
>> +        if (!ASSERT_GE(len, 0, "read"))
>>               goto free_buf;
>>       } else {
>>           do {
>> @@ -732,8 +724,7 @@ static void test_overflow(bool 
>> test_e2big_overflow, bool ret1)
>>                   total_read_len += len;
>>           } while (len > 0 || len == -EAGAIN);
>>   -        if (CHECK(len < 0, "read", "read failed: %s\n",
>> -              strerror(errno)))
>> +        if (!ASSERT_GE(len, 0, "read"))
>>               goto free_buf;
>>       }
>>   @@ -836,7 +827,7 @@ static void test_bpf_hash_map(void)
>>       /* do some tests */
>>       while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>>           ;
>> -    if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
>> +    if (!ASSERT_GE(len, 0, "read"))
>>           goto close_iter;
>>         /* test results */
>> @@ -917,7 +908,7 @@ static void test_bpf_percpu_hash_map(void)
>>       /* do some tests */
>>       while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>>           ;
>> -    if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
>> +    if (!ASSERT_GE(len, 0, "read"))
>>           goto close_iter;
>>         /* test results */
>> @@ -983,17 +974,15 @@ static void test_bpf_array_map(void)
>>       start = 0;
>>       while ((len = read(iter_fd, buf + start, sizeof(buf) - start)) 
>> > 0)
>>           start += len;
>> -    if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
>> +    if (!ASSERT_GE(len, 0, "read"))
>>           goto close_iter;
>>         /* test results */
>>       res_first_key = *(__u32 *)buf;
>>       res_first_val = *(__u64 *)(buf + sizeof(__u32));
>> -    if (CHECK(res_first_key != 0 || res_first_val != first_val,
>> -          "bpf_seq_write",
>> -          "seq_write failure: first key %u vs expected 0, "
>> -          " first value %llu vs expected %llu\n",
>> -          res_first_key, res_first_val, first_val))
>> +    if (!ASSERT_EQ(res_first_key, 0, "bpf_seq_write"))
>> +        goto close_iter;
>> +    else if (!ASSERT_EQ(res_first_val, first_val, "bpf_seq_write"))
>>           goto close_iter;
>
> Similiar here!
>
>  if (!ASSERT_EQ(...) ||
>      !ASSERT_EQ(...))
>       goto close_iter;
>
> [...]
