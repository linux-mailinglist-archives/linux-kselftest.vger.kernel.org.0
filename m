Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FBD7A70BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 04:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjITC5f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 22:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITC5e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 22:57:34 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF42C9
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 19:57:27 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rr3596whYzMlLZ;
        Wed, 20 Sep 2023 10:53:49 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 20 Sep 2023 10:57:24 +0800
Message-ID: <fa0bd5fa-88b6-c7af-7004-08978ae52dfa@huawei.com>
Date:   Wed, 20 Sep 2023 10:57:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 4/4] kunit: test: Fix the possible memory leak in
 executor_test
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
CC:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <janusz.krzysztofik@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
References: <20230914114629.1517650-1-ruanjinjie@huawei.com>
 <20230914114629.1517650-5-ruanjinjie@huawei.com>
 <CA+GJov7Uya8r4T6EtQQ03KQ7BPRsCb8N3y687eDxDitnJ3Aifw@mail.gmail.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <CA+GJov7Uya8r4T6EtQQ03KQ7BPRsCb8N3y687eDxDitnJ3Aifw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/9/20 5:19, Rae Moar wrote:
> On Thu, Sep 14, 2023 at 7:47 AM 'Jinjie Ruan' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
>>
>> If kunit_filter_suites() succeeds, not only copy but also filtered_suite
>> and filtered_suite->test_cases should be freed.
>>
>> So use kunit_free_suite_set() to free the filtered_suite,
>> filtered_suite->test_cases and copy as kunit_module_exit() and
>> kunit_run_all_tests() do it.
>>
>> Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Hello!
> 
> This looks mostly good to me. But I have one notable comment. See below.
> 
> Thanks!
> -Rae
> 
>> ---
>>  lib/kunit/executor_test.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
>> index b4f6f96b2844..987b81dce01e 100644
>> --- a/lib/kunit/executor_test.c
>> +++ b/lib/kunit/executor_test.c
>> @@ -56,7 +56,6 @@ static void filter_suites_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we just have suite2 */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
>> @@ -64,6 +63,9 @@ static void filter_suites_test(struct kunit *test)
>>
>>         /* Contains one element (end is 1 past end) */
>>         KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
> 
> I definitely appreciate the change to free all of "got" rather than
> just "got.start".
> 
> However, kfree_at_end used deferred actions to ensure the kfree would
> occur at the end of the test. With this change, if the test fails the
> suite set could not be freed.

Only when suite_set.start != NULL which is equivalent to err == 0 the
suite set will be freed in kunit_module_exit(), and
kunit_free_suite_set() will be called only when kunit_filter_suites()
succeeds with err == 0. So judging from the use of kunit_filter_suites()
in kunit_module_exit() and kunit_run_all_tests(), it only wants to free
the suite set when kunit_filter_suites() succeeds with err == 0. So in
kunit_filter_suites() , we free
copy, filtered_suite and filtered_suite->test_cases if (*err) is true.

So if the test fails the suite set will be freed also. And there's a
double free problem in kfree_at_end(test, got.start) if the test fails.
So only free the suite set when err == 0.


737 static void kunit_module_init(struct module *mod)
738 {
739         struct kunit_suite_set suite_set = {
740                 mod->kunit_suites, mod->kunit_suites +
mod->num_kunit_suites,
741         };
742         const char *action = kunit_action();
743         int err = 0;
744
745         suite_set = kunit_filter_suites(&suite_set,
746                                         kunit_filter_glob() ?: "*.*",
747                                         kunit_filter(),
kunit_filter_action(),
748                                         &err);

765 static void kunit_module_exit(struct module *mod)
766 {
767         struct kunit_suite_set suite_set = {
768                 mod->kunit_suites, mod->kunit_suites +
mod->num_kunit_suites,
769         };
770         const char *action = kunit_action();
771
772         if (!action)
773                 __kunit_test_suites_exit(mod->kunit_suites,
774                                          mod->num_kunit_suites);
775
776         if (suite_set.start)
777                 kunit_free_suite_set(suite_set);
778 }



314 int kunit_run_all_tests(void)
315 {
           ......
325         if (filter_glob_param || filter_param) {
326                 suite_set = kunit_filter_suites(&suite_set,
filter_glob_param,
327                                 filter_param, filter_action_param,
&err);
328                 if (err) {
329                         pr_err("kunit executor: error filtering
suites: %d\n", err);
330                         goto out;
331                 }
332         }
......
342
343         if (filter_glob_param || filter_param) { /* a copy was made
of each suite */
344                 kunit_free_suite_set(suite_set);
345         }
346
347 out:
348         kunit_handle_shutdown();
349         return err;
350 }


> 
> Intead, is there any way to alter the function kfree_at_end (could be
> renamed) to take in "got" and then use deferred actions to ensure
> kunit_free_suite_set is called at the end of the test?

It is good iead. And it may be fine to call kfree_at_end(test, got) if
err == 0 to avoid double free issue.

> 
> Let me know what you think about this.
> 
> 
>>  }
>>
>>  static void filter_suites_test_glob_test(struct kunit *test)
>> @@ -82,7 +84,6 @@ static void filter_suites_test_glob_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, "suite2.test2", NULL, NULL, &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we just have suite2 */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
>> @@ -93,6 +94,9 @@ static void filter_suites_test_glob_test(struct kunit *test)
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>>         KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0].name, "test2");
>>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
>>  }
>>
>>  static void filter_suites_to_empty_test(struct kunit *test)
>> @@ -109,10 +113,12 @@ static void filter_suites_to_empty_test(struct kunit *test)
>>
>>         got = kunit_filter_suites(&suite_set, "not_found", NULL, NULL, &err);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start); /* just in case */
>>
>>         KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
>>                                 "should be empty to indicate no match");
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
>>  }
>>
>>  static void parse_filter_attr_test(struct kunit *test)
>> @@ -172,7 +178,6 @@ static void filter_attr_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we just have normal_suite */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
>> @@ -183,6 +188,9 @@ static void filter_attr_test(struct kunit *test)
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>>         KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[0].name, "normal");
>>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
>>  }
>>
>>  static void filter_attr_empty_test(struct kunit *test)
>> @@ -200,10 +208,12 @@ static void filter_attr_empty_test(struct kunit *test)
>>
>>         got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start); /* just in case */
>>
>>         KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
>>                                 "should be empty to indicate no match");
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
>>  }
>>
>>  static void filter_attr_skip_test(struct kunit *test)
>> @@ -222,7 +232,6 @@ static void filter_attr_skip_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, NULL, filter, "skip", &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we have both the slow and normal test */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>> @@ -233,6 +242,9 @@ static void filter_attr_skip_test(struct kunit *test)
>>         /* Now ensure slow is skipped and normal is not */
>>         KUNIT_EXPECT_EQ(test, got.start[0]->test_cases[0].status, KUNIT_SKIPPED);
>>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].status);
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
>>  }
>>
>>  static struct kunit_case executor_test_cases[] = {
>> --
>> 2.34.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230914114629.1517650-5-ruanjinjie%40huawei.com.
> 
