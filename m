Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFF17D60C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 06:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjJYEST (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 00:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJYESS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 00:18:18 -0400
X-Greylist: delayed 232 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 21:18:16 PDT
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE5D122
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Oct 2023 21:18:16 -0700 (PDT)
Message-ID: <59d468e5-767e-4ab1-a88f-8e51d6243798@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698207494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3ntzb2E9SkW4Xecvck/YzPz0S9snygsjgNkEfyN7n8=;
        b=j+xsP/qBiyNJxLkAp8ZHUGULjldBp1l/9M6Q1UyW8ob6lzSDYpfoR0mqwKl1WTUgTUm2Xi
        Lf2sOMjnyrcoZ4AU7/mFuefTCyq5elZ8oXdbGfxXFXAnY71ND/wcuH+D2564RvfQFyyDbN
        VOt0hUTZ1nsqj4rpKXhxCpshERaRiio=
Date:   Tue, 24 Oct 2023 21:18:08 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Add malloc failure checks in
 bpf_iter
Content-Language: en-GB
To:     Kui-Feng Lee <sinquersw@gmail.com>,
        Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        brauner@kernel.org, iii@linux.ibm.com, kuifeng@meta.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <DB3PR10MB68356D7CDF6005480BE5876CE8DEA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <7d703c4c-1a24-4806-a483-c02efb666059@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7d703c4c-1a24-4806-a483-c02efb666059@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 10/24/23 7:28 PM, Kui-Feng Lee wrote:
> Thank you for the patches.
>
> I found you have two patches in this set.
> You can generate both patch at once with git format-patch.
> format-patch will give each patch a number in their order.
> For example, the subject of this message will be
>
>   [PATCH bpf-next 2/2] selftest/bpf: Add malloc ....
>
> And, you put both patches in the same directory.  And sent them at once
> by giving the path of the directory. For example,
>
>   git send-email --to=bpf@vger.kernel.org path/to/the/directory/
>
> These patches will be sent in a thread instead of two independent
> messages.


Yuran, second to Kui-Feng's suggestion which is also my original
suggestion although I forgot to explicitly mention that two
patches should be in the same patch set.
I found one issue with the CHECK->ASSERT patch, so please
respin with patch v2 with two patches as the same set.


>
> On 10/24/23 18:52, Yuran Pereira wrote:
>> Since some malloc calls in bpf_iter may at times fail,
>> this patch adds the appropriate fail checks, and ensures that
>> any previously allocated resource is appropriately destroyed
>> before returning the function.
>>
>> This is patch 2 in the sequence should be applied after d1a88d37cecc
>> "selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter"
>>
>> Patch 1:
>> https://lore.kernel.org/lkml/DB3PR10MB683589A5F705C6CA5BE0D325E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM 
>>
>>
>> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c 
>> b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>> index 526ac4e741ee..c6cf42c64af3 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>> @@ -700,7 +700,7 @@ static void test_overflow(bool 
>> test_e2big_overflow, bool ret1)
>>           goto free_link;
>>         buf = malloc(expected_read_len);
>> -    if (!buf)
>> +    if (!ASSERT_OK_PTR(buf, "malloc"))
>>           goto close_iter;
>>         /* do read */
>> @@ -871,6 +871,10 @@ static void test_bpf_percpu_hash_map(void)
>>         skel->rodata->num_cpus = bpf_num_possible_cpus();
>>       val = malloc(8 * bpf_num_possible_cpus());
>> +    if (!ASSERT_OK_PTR(val, "malloc")) {
>> +        bpf_iter_bpf_percpu_hash_map__destroy(skel);
>> +        return;
>> +    }
>
> You can just do "goto out;" here.
>
>
>>         err = bpf_iter_bpf_percpu_hash_map__load(skel);
>>       if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__load"))
>> @@ -1048,6 +1052,10 @@ static void test_bpf_percpu_array_map(void)
>>         skel->rodata->num_cpus = bpf_num_possible_cpus();
>>       val = malloc(8 * bpf_num_possible_cpus());
>> +    if (!ASSERT_OK_PTR(val, "malloc")) {
>> +        bpf_iter_bpf_percpu_array_map__destroy(skel);
>> +        return;
>> +    }
>
> Same here, even it will call free(val), free(val) will do nothing when
> val is NULL.
>
>>         err = bpf_iter_bpf_percpu_array_map__load(skel);
>>       if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__load"))
