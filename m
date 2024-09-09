Return-Path: <linux-kselftest+bounces-17551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A81972425
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 23:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD261C22584
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 21:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7028118A933;
	Mon,  9 Sep 2024 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqqv7jRW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D19178CC8;
	Mon,  9 Sep 2024 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915863; cv=none; b=OciO7EMdDxOQiXSPJ5SjDjjc5X+lYJD3Gt6hDGyDil9g7M51vydV4Nsszzzr5S293dYMGC6tPuOuiR0YM7socSUFGlLiTg5d5bDb5rMgkQFZPnDNJJpSdqSUDLVz2PeOyXGpq/t8HzhEPA/YpGg0fMyMonGCELkquvzzDMcFHj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915863; c=relaxed/simple;
	bh=heUAk1a1fx2rsZaVsWkJwe3HXU/Na7t6hpJo9YjAEZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBg/M3eRS42pdFp0Geo7dLyl1mFoybgb1XSWIfn2eq89OLZiQjKVxpT43VxrA2HMJjo/Dmsgroe9Fh9z5JVomnnTUVWgSXGyDZXIzI4pR0ZcFg5tE4QQZ9/4EMAVccNinoR14ISGCK9xuFBP4m+7muhkIcygCyjhKKSRCUrh8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqqv7jRW; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-456757d8871so28667361cf.0;
        Mon, 09 Sep 2024 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725915860; x=1726520660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKZo3hDvPTf5bX42ISESb2ErHLFM/RcvcofoDXXLCRY=;
        b=Rqqv7jRWudk1CMQYHw9Q5wqm8HEu41HnK4aqoubbXv0iqFIGgCNoh4coA5lOkZIhcF
         YnWHjjnresfxXiYN89gJqluewQMttkR1kKQldF7BUxAM6vdKFRQOq/7Ul6zX8SYJt2aq
         VO5J4RQGr7G/VJDBM3CIktKLELJDz09vdS/mbXpDpx8QHYyOKYMy2OWIvlZiPb6JvKe5
         FO/J8n8eSeGPtzfNyo/YjlzW7YiV1MHk8a/+yosMlcVOib+dDkR4YlzOrmt4HO5y6qSt
         oHhzWgtoiVoWnf3WmH6lG2T8oX2Xie6xBJwBW6bx2FXD/SDH5KHjMfxcptc6Hh+meIWb
         uh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725915860; x=1726520660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKZo3hDvPTf5bX42ISESb2ErHLFM/RcvcofoDXXLCRY=;
        b=de6N2fi0ns4PbPF5p48gLD+HtUAVQFQBvCUJWYllPNwZCy2XEemTkzeTxuEX4JYEUC
         p1llT/3Edb9jwpB+2g4oaBBnjmplAtHp8vtdb/nmnjFpZzbddXoK23Egkf2vCcPJoCjL
         AtWt5UkPB08CBqG5V7CbaWpcVNZybcVkZRtgSTO9DZ02ZnDqyvI6XkFOYQhP3yXMIGUD
         xkStbI5ogg5iIZRB4xNQyDDWgYDnnG89w/P+/kPcDz003m/q1lCkNaiouYdEirzPK4K5
         oQM9Zh/CQqoaXl/HtwUrpz+R2Ei7BvAtt00kQ4lsd67xfmqqBjoLw5Y8Kknyi/oqdNe/
         OJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCUKF9H4qfXHYQ6+SPvzKH4oFcFp5sGYEML6tvRd5ooR62tqCz7iDYxXV0LGSGgT9iLEVLeV+jkW9g1ZB3d8LLo0@vger.kernel.org, AJvYcCXZldqoY0kYHb88BOmm6sKcM+akAo8FvrBLry9t1P7NFaOT9rZl0u2zxfkzUdfHZ4SW2qjTwWAu0Rc2Ib4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNOOrO0aBDijrp3nDj4WzWzb9gQM4ufvljL6XBZx97quxKP0r
	4l4MPBPePdpHjyPtSmPv7ESz8Rxg+FfrVquB6LbBx6HreWt9UCdp
X-Google-Smtp-Source: AGHT+IGBXSdeplHdOpRXtOSDnMPS1uJ4e9TyAq7pYZ8I7qYM9cBEvWv4l7MGGzOxlridp550cHP24Q==
X-Received: by 2002:a05:6214:54c9:b0:6b0:7f36:8ae3 with SMTP id 6a1803df08f44-6c52850b9f6mr159990426d6.32.1725915860003;
        Mon, 09 Sep 2024 14:04:20 -0700 (PDT)
Received: from [10.0.3.130] (recod-gw.ic.unicamp.br. [143.106.7.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53433b68bsm24209526d6.30.2024.09.09.14.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 14:04:19 -0700 (PDT)
Message-ID: <bb1abb10-fd52-4dac-8455-42f8f4c9c96e@gmail.com>
Date: Mon, 9 Sep 2024 18:04:11 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] lib/llist_kunit.c: add KUnit tests for llist
To: Rae Moar <rmoar@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, n@nfraprado.net, andrealmeid@riseup.net,
 vinicius@nukelet.com, diego.daniel.professional@gmail.com
References: <20240903214027.77533-1-arturacb@gmail.com>
 <20240903214027.77533-2-arturacb@gmail.com>
 <CA+GJov4cAdvmVCHh4xcSVWKg0e3Drs7GB7jMW0btciwCUEJFgg@mail.gmail.com>
Content-Language: en-US
From: Artur Alves Cavalcante de Barros <arturacb@gmail.com>
In-Reply-To: <CA+GJov4cAdvmVCHh4xcSVWKg0e3Drs7GB7jMW0btciwCUEJFgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/5/24 5:51 PM, Rae Moar wrote:
> On Tue, Sep 3, 2024 at 5:40 PM Artur Alves <arturacb@gmail.com> wrote:
>>
>> Add KUnit tests for the llist data structure. They test the vast
>> majority of methods and macros defined in include/linux/llist.h.
>>
>> These are inspired by the existing tests for the 'list' doubly
>> linked in lib/list-test.c [1]. Each test case (llist_test_x)
>> tests the behaviour of the llist function/macro 'x'.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/list-test.c?h=v6.11-rc6
>>
>> Signed-off-by: Artur Alves <arturacb@gmail.com>
> 
> Hello!
> 
> Thanks for creating this new test! It looks really good and is passing
> all the tests.
> 
> My main comment is that this patch is causing some checkpatch warnings:
> 
>    WARNING: Prefer a maximum 75 chars per line (possible unwrapped
> commit description?)
>    #13:
>    [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/list-test.c?h=v6.11-rc6
> 
> It's probably fine to ignore this warning as it is a link. But I might
> remove the link because it is not absolutely necessary in this case.
> 
>    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>    #58:
>    new file mode 100644
> 
>    ERROR: that open brace { should be on the previous line
>    #306: FILE: lib/llist_kunit.c:249:
>    +static void llist_test_for_each_safe(struct kunit *test)
>    +{
> 
>    ERROR: that open brace { should be on the previous line
>    #325: FILE: lib/llist_kunit.c:268:
>    +static void llist_test_for_each_entry(struct kunit *test)
>    +{
> 
>    ERROR: that open brace { should be on the previous line
>    #346: FILE: lib/llist_kunit.c:289:
>    +static void llist_test_for_each_entry_safe(struct kunit *test)
>    +{
> 
> These checkpatch errors are mistaken since the open brace should be
> where it is. I believe this is getting picked up because of the
> "for_each" in the test name. This was fixed for me by rewriting the
> test names: from "llist_test_for_each_safe" -> to
> "llist_test_safe_for_each", and so on for the other tests with errors.
> Sorry it's a pain to change this but I think it is a better fix than
> changing the checkpatch script.
> 
>> ---
>>   lib/Kconfig.debug       |  11 ++
>>   lib/tests/Makefile      |   1 +
>>   lib/tests/llist_kunit.c | 361 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 373 insertions(+)
>>   create mode 100644 lib/tests/llist_kunit.c
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index a30c03a66172..b2725daccc52 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -2813,6 +2813,17 @@ config USERCOPY_KUNIT_TEST
>>            on the copy_to/from_user infrastructure, making sure basic
>>            user/kernel boundary testing is working.
>>
>> +config LLIST_KUNIT_TEST
>> +       tristate "KUnit tests for lib/llist" if !KUNIT_ALL_TESTS
>> +       depends on KUNIT
>> +       default KUNIT_ALL_TESTS
>> +       help
>> +         This option builds the "llist_kunit" test module that
>> +         helps to verify the correctness of the functions and
>> +         macros defined in (<linux/llist.h>).
> 
> Also, I think I would prefer if this description was a bit tweaked.
> Saying it builds the "module" is confusing since this test might be
> run built-in instead. So maybe something more similar to :
> 
> This builds the llist (lock-less list) KUnit test suite. It tests the
> API and basic functionality of the macros and functions defined in
> <linux/llish.h>.
> 
>> +
>> +         If unsure, say N.
>> +
>>   config TEST_UDELAY
>>          tristate "udelay test driver"
>>          help
>> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
>> index c6a14cc8663e..8d7c40a73110 100644
>> --- a/lib/tests/Makefile
>> +++ b/lib/tests/Makefile
>> @@ -34,4 +34,5 @@ CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
>>   obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
>>   obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
>>   obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
>> +obj-$(CONFIG_LLIST_KUNIT_TEST) += llist_kunit.o
>>
>> diff --git a/lib/tests/llist_kunit.c b/lib/tests/llist_kunit.c
>> new file mode 100644
>> index 000000000000..f273c0d175c7
>> --- /dev/null
>> +++ b/lib/tests/llist_kunit.c
>> @@ -0,0 +1,361 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * KUnit test for the Kernel lock-less linked-list structure.
>> + *
>> + * Author: Artur Alves <arturacb@gmail.com>
>> + */
>> +
>> +#include <kunit/test.h>
>> +#include <linux/llist.h>
>> +
>> +#define ENTRIES_SIZE 3
>> +
>> +struct llist_test_struct {
>> +       int data;
>> +       struct llist_node node;
>> +};
>> +
>> +static void llist_test_init_llist(struct kunit *test)
>> +{
>> +       /* test if the llist is correctly initialized */
>> +       struct llist_head llist1 = LLIST_HEAD_INIT(llist1);
>> +       LLIST_HEAD(llist2);
>> +       struct llist_head llist3, *llist4, *llist5;
>> +
>> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist1));
>> +
>> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist2));
>> +
>> +       init_llist_head(&llist3);
>> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist3));
>> +
>> +       llist4 = kzalloc(sizeof(*llist4), GFP_KERNEL | __GFP_NOFAIL);
>> +       init_llist_head(llist4);
>> +       KUNIT_EXPECT_TRUE(test, llist_empty(llist4));
>> +       kfree(llist4);
>> +
>> +       llist5 = kmalloc(sizeof(*llist5), GFP_KERNEL | __GFP_NOFAIL);
>> +       memset(llist5, 0xFF, sizeof(*llist5));
>> +       init_llist_head(llist5);
>> +       KUNIT_EXPECT_TRUE(test, llist_empty(llist5));
>> +       kfree(llist5);
>> +}
>> +
>> +static void llist_test_init_llist_node(struct kunit *test)
>> +{
>> +       struct llist_node a;
>> +
>> +       init_llist_node(&a);
>> +
>> +       KUNIT_EXPECT_PTR_EQ(test, a.next, &a);
>> +}
>> +
>> +static void llist_test_llist_entry(struct kunit *test)
>> +{
>> +       struct llist_test_struct test_struct, *aux;
>> +       struct llist_node *llist = &test_struct.node;
>> +
>> +       aux = llist_entry(llist, struct llist_test_struct, node);
>> +       KUNIT_EXPECT_PTR_EQ(test, &test_struct, aux);
>> +}
>> +
>> +static void llist_test_add(struct kunit *test)
>> +{
>> +       struct llist_node a, b;
>> +       LLIST_HEAD(llist);
>> +
>> +       init_llist_node(&a);
>> +       init_llist_node(&b);
>> +
>> +       /* The first assertion must be true, given that llist is empty */
>> +       KUNIT_EXPECT_TRUE(test, llist_add(&a, &llist));
>> +       KUNIT_EXPECT_FALSE(test, llist_add(&b, &llist));
>> +
>> +       /* Should be [List] -> b -> a */
>> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &b);
>> +       KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
>> +}
>> +
>> +static void llist_test_add_batch(struct kunit *test)
>> +{
>> +       struct llist_node a, b, c;
>> +       LLIST_HEAD(llist);
>> +       LLIST_HEAD(llist2);
>> +
>> +       init_llist_node(&a);
>> +       init_llist_node(&b);
>> +       init_llist_node(&c);
>> +
>> +       llist_add(&a, &llist2);
>> +       llist_add(&b, &llist2);
>> +       llist_add(&c, &llist2);
>> +
>> +       /* This assertion must be true, given that llist is empty */
>> +       KUNIT_EXPECT_TRUE(test, llist_add_batch(&c, &a, &llist));
>> +
>> +       /* should be [List] -> c -> b -> a */
>> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &c);
>> +       KUNIT_EXPECT_PTR_EQ(test, c.next, &b);
>> +       KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
>> +}
>> +
>> +static void llist_test_llist_next(struct kunit *test)
>> +{
>> +       struct llist_node a, b;
>> +       LLIST_HEAD(llist);
>> +
>> +       init_llist_node(&a);
>> +       init_llist_node(&b);
>> +
>> +       llist_add(&a, &llist);
>> +       llist_add(&b, &llist);
>> +
>> +       /* should be [List] -> b -> a */
>> +       KUNIT_EXPECT_PTR_EQ(test, llist_next(&b), &a);
>> +       KUNIT_EXPECT_NULL(test, llist_next(&a));
>> +}
>> +
>> +static void llist_test_empty_llist(struct kunit *test)
>> +{
>> +       struct llist_head llist = LLIST_HEAD_INIT(llist);
>> +       struct llist_node a;
>> +
>> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
>> +
>> +       llist_add(&a, &llist);
>> +
>> +       KUNIT_EXPECT_FALSE(test, llist_empty(&llist));
>> +}
>> +
>> +static void llist_test_llist_on_list(struct kunit *test)
>> +{
>> +       struct llist_node a, b;
>> +       LLIST_HEAD(llist);
>> +
>> +       init_llist_node(&a);
>> +       init_llist_node(&b);
>> +
>> +       llist_add(&a, &llist);
>> +
>> +       /* should be [List] -> a */
>> +       KUNIT_EXPECT_TRUE(test, llist_on_list(&a));
>> +       KUNIT_EXPECT_FALSE(test, llist_on_list(&b));
>> +}
>> +
>> +static void llist_test_del_first(struct kunit *test)
>> +{
>> +       struct llist_node a, b, *c;
>> +       LLIST_HEAD(llist);
>> +
>> +       llist_add(&a, &llist);
>> +       llist_add(&b, &llist);
>> +
>> +       /* before: [List] -> b -> a */
>> +       c = llist_del_first(&llist);
>> +
>> +       /* should be [List] -> a */
>> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &a);
>> +
>> +       /* del must return a pointer to llist_node b
>> +        * the returned pointer must be marked on list
>> +        */
>> +       KUNIT_EXPECT_PTR_EQ(test, c, &b);
>> +       KUNIT_EXPECT_TRUE(test, llist_on_list(c));
>> +}
>> +
>> +static void llist_test_del_first_init(struct kunit *test)
>> +{
>> +       struct llist_node a, *b;
>> +       LLIST_HEAD(llist);
>> +
>> +       llist_add(&a, &llist);
>> +
>> +       b = llist_del_first_init(&llist);
>> +
>> +       /* should be [List] */
>> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
>> +
>> +       /* the returned pointer must be marked out of the list */
>> +       KUNIT_EXPECT_FALSE(test, llist_on_list(b));
>> +}
>> +
>> +static void llist_test_del_first_this(struct kunit *test)
>> +{
>> +       struct llist_node a, b;
>> +       LLIST_HEAD(llist);
>> +
>> +       llist_add(&a, &llist);
>> +       llist_add(&b, &llist);
>> +
>> +       llist_del_first_this(&llist, &a);
>> +
>> +       /* before: [List] -> b -> a */
>> +
>> +       // should remove only if is the first node in the llist
>> +       KUNIT_EXPECT_FALSE(test, llist_del_first_this(&llist, &a));
>> +
>> +       KUNIT_EXPECT_TRUE(test, llist_del_first_this(&llist, &b));
>> +
>> +       /* should be [List] -> a */
>> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &a);
>> +}
>> +
>> +static void llist_test_del_all(struct kunit *test)
>> +{
>> +       struct llist_node a, b;
>> +       LLIST_HEAD(llist);
>> +       LLIST_HEAD(empty_llist);
>> +
>> +       llist_add(&a, &llist);
>> +       llist_add(&b, &llist);
>> +
>> +       /* deleting from a empty llist should return NULL */
>> +       KUNIT_EXPECT_NULL(test, llist_del_all(&empty_llist));
>> +
>> +       llist_del_all(&llist);
>> +
>> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
>> +}
>> +
>> +static void llist_test_for_each(struct kunit *test)
>> +{
>> +       struct llist_node entries[ENTRIES_SIZE] = { 0 };
>> +       struct llist_node *pos, *deleted_nodes;
>> +       LLIST_HEAD(llist);
>> +       int i = 0;
>> +
>> +       for (int i = ENTRIES_SIZE - 1; i >= 0; i--)
>> +               llist_add(&entries[i], &llist);
>> +
>> +       /* before [List] -> entries[0] -> ... -> entries[ENTRIES_SIZE - 1] */
>> +       llist_for_each(pos, llist.first) {
>> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
>> +       }
>> +
>> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
>> +
>> +       i = 0;
> 
> This is super nitpicky but I think I would prefer if you set two
> variables to zero at the beginning rather than reusing "i". So: int i
> = 0, j = 0;
> 
>> +
>> +       /* traversing deleted nodes */
>> +       deleted_nodes = llist_del_all(&llist);
>> +
>> +       llist_for_each(pos, deleted_nodes) {
>> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
>> +       }
>> +
>> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
>> +}
>> +
>> +static void llist_test_for_each_safe(struct kunit *test)
>> +{
>> +       struct llist_node entries[ENTRIES_SIZE] = { 0 };
> 
> I'm not sure if it is necessary to initialize this to be zeros.
> 
>> +       struct llist_node *pos, *n;
>> +       LLIST_HEAD(llist);
>> +       int i = 0;
>> +
>> +       for (int i = ENTRIES_SIZE - 1; i >= 0; i--)
>> +               llist_add(&entries[i], &llist);
>> +
>> +       llist_for_each_safe(pos, n, llist.first) {
>> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
>> +               llist_del_first(&llist);
>> +       }
>> +
>> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
>> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
>> +}
>> +
>> +static void llist_test_for_each_entry(struct kunit *test)
>> +{
>> +       struct llist_test_struct entries[ENTRIES_SIZE], *pos;
>> +       LLIST_HEAD(llist);
>> +       int i = 0;
>> +
>> +       for (int i = ENTRIES_SIZE - 1; i >= 0; --i) {
>> +               entries[i].data = i;
>> +               llist_add(&entries[i].node, &llist);
>> +       }
>> +
>> +       i = 0;
>> +
>> +       llist_for_each_entry(pos, llist.first, node) {
>> +               KUNIT_EXPECT_EQ(test, pos->data, i);
>> +               i++;
>> +       }
>> +
>> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
>> +}
>> +
>> +static void llist_test_for_each_entry_safe(struct kunit *test)
>> +{
>> +       struct llist_test_struct entries[ENTRIES_SIZE], *pos, *n;
>> +       LLIST_HEAD(llist);
>> +       int i = 0;
>> +
>> +       for (int i = ENTRIES_SIZE - 1; i >= 0; --i) {
>> +               entries[i].data = i;
>> +               llist_add(&entries[i].node, &llist);
>> +       }
>> +
>> +       i = 0;
>> +
>> +       llist_for_each_entry_safe(pos, n, llist.first, node) {
>> +               KUNIT_EXPECT_EQ(test, pos->data, i++);
>> +               llist_del_first(&llist);
>> +       }
>> +
>> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
>> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
>> +}
>> +
>> +static void llist_test_reverse_order(struct kunit *test)
>> +{
>> +       struct llist_node entries[3], *pos, *reversed_llist;
> 
> Rather than using the "3" here I would prefer using the ENTRIES_SIZE.
> 
>> +       LLIST_HEAD(llist);
>> +       int i = 0;
>> +
>> +       llist_add(&entries[0], &llist);
>> +       llist_add(&entries[1], &llist);
>> +       llist_add(&entries[2], &llist);
>> +
>> +       /* before [List] -> entries[2] -> entries[1] -> entries[0] */
>> +       reversed_llist = llist_reverse_order(llist_del_first(&llist));
>> +
>> +       /* should be [List] -> entries[0] -> entries[1] -> entrires[2] */
> 
> Small typo in this comment: "entries"
> 
>> +       llist_for_each(pos, reversed_llist) {
>> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
>> +       }
>> +
>> +       KUNIT_EXPECT_EQ(test, 3, i);
> 
> Same here with the use of the "3".
> 
>> +}
>> +
>> +static struct kunit_case llist_test_cases[] = {
>> +       KUNIT_CASE(llist_test_init_llist),
>> +       KUNIT_CASE(llist_test_init_llist_node),
>> +       KUNIT_CASE(llist_test_llist_entry),
>> +       KUNIT_CASE(llist_test_add),
>> +       KUNIT_CASE(llist_test_add_batch),
>> +       KUNIT_CASE(llist_test_llist_next),
>> +       KUNIT_CASE(llist_test_empty_llist),
>> +       KUNIT_CASE(llist_test_llist_on_list),
>> +       KUNIT_CASE(llist_test_del_first),
>> +       KUNIT_CASE(llist_test_del_first_init),
>> +       KUNIT_CASE(llist_test_del_first_this),
>> +       KUNIT_CASE(llist_test_del_all),
>> +       KUNIT_CASE(llist_test_for_each),
>> +       KUNIT_CASE(llist_test_for_each_safe),
>> +       KUNIT_CASE(llist_test_for_each_entry),
>> +       KUNIT_CASE(llist_test_for_each_entry_safe),
>> +       KUNIT_CASE(llist_test_reverse_order),
>> +       {}
>> +};
>> +
>> +static struct kunit_suite llist_test_suite = {
>> +       .name = "llist",
>> +       .test_cases = llist_test_cases,
>> +};
>> +
>> +kunit_test_suite(llist_test_suite);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("KUnit tests for the llist data structure.");
>> --
>> 2.46.0
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240903214027.77533-2-arturacb%40gmail.com.

Hi!

Thanks for the reply! I'm going to address these issues ASAP :)

