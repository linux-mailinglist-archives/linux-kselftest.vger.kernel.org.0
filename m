Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E229F72B93C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 09:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbjFLHxR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 03:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjFLHxC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 03:53:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B775A2717;
        Mon, 12 Jun 2023 00:51:57 -0700 (PDT)
Received: from [192.168.10.55] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C41066056AA;
        Mon, 12 Jun 2023 08:42:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686555747;
        bh=jaXgQtw+3VAkdUzI7Dmasonlno9daKl/YokJZ/nQOdQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=HmFlYt84rHySyKYTzkAvoEwDVJBcltGzygCAaH8aQEDBATyrzU8pKiWTrNTkmrM6i
         v4n4y/kp58PSf+LFZYxjlS+3RXrrNQk8i5uk8Ez+Bu6Z+IeT0N3eMKmwPyN62Z7G8w
         TT/4VK4c4bN0mMA1XyCMJ+LAmIzC0fnjy7uJh/KXJEyj5mVX8aGl2gi4NK/DTrjgka
         EeXPV1Vxdai9pAhvFnHTJNOD2Hw2BQ0zIiM7rBxj6vgAyT6PbPmod/w3O7RWH7bD9e
         5Fs1kRQPcMATzpCHT4LZqIHdAh2yRf6VwrdtlcYOqgjbEoNXGccK2Tb1fmqnc7TUe0
         X1P18g1Tsz/2w==
Message-ID: <e6ca3de5-fbd2-1d93-6011-5ae0765b826d@collabora.com>
Date:   Mon, 12 Jun 2023 12:42:21 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/1] selftests: mm: uufd-unit-tests: remove a format
 warning in printf
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
References: <20230610235016.438460-1-mirsad.todorovac@alu.unizg.hr>
 <109d9c47-9c0e-e8ca-2bc1-cb741bc45a1b@collabora.com>
 <138905be-3963-cd67-c217-7aa561372293@alu.unizg.hr>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <138905be-3963-cd67-c217-7aa561372293@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/12/23 5:11 AM, Mirsad Goran Todorovac wrote:
> Apologies Muhammad then, didn't follow that branch.
No problem.

> 
> Regards,
> Mirsad
> 
> On 6/11/23 14:30, Muhammad Usama Anjum wrote:
>> The fix has already been picked up by Andew in mm unstable:
>>
>> https://lore.kernel.org/all/20230607023727.0E011C433D2@smtp.kernel.org
>>
>> On 6/11/23 4:50 AM, Mirsad Todorovac wrote:
>>> GCC 11.3.0 issued warnings about macros and types of arguments [edited]:
>>>
>>> gcc -Wall -I ../tools/testing/selftests/../../.. \
>>>     -I ../tools/testing/selftests/../../../tools/include/uapi \
>>>     -isystem ../usr/include -no-pie uffd-unit-tests.c vm_util.c \
>>>     uffd-common.c -lrt -lpthread -o \
>>>     ../tools/testing/selftests/mm/uffd-unit-tests
>>> uffd-unit-tests.c: In function ‘main’:
>>> uffd-unit-tests.c:1198:41: warning: format not a string literal and no \
>>>     format arguments [-Wformat-security]
>>>   1198 |                         uffd_test_start(test_name);
>>>        |                                         ^~~~~~~~~
>>> uffd-unit-tests.c:100:24: note: in definition of macro ‘uffd_test_start’
>>>    100 |                 printf(__VA_ARGS__);            \
>>>        |                        ^~~~~~~~~~~
>>> uffd-unit-tests.c:1205:33: warning: format not a string literal and no \
>>>     format arguments [-Wformat-security]
>>>   1205 |                                 uffd_test_skip(errmsg);
>>>        |                                 ^~~~~~~~~~~~~~
>>>
>>> The macros are defined as:
>>>
>>>   #define  uffd_test_start(...)  do {             \
>>>                  printf("Testing ");             \
>>>                  printf(__VA_ARGS__);            \
>>>                  printf("... ");                 \
>>>                  fflush(stdout);                 \
>>>          } while (0)
>>>
>>>   #define  uffd_test_skip(...)  do {              \
>>>                  printf("skipped [reason: ");    \
>>>                  printf(__VA_ARGS__);            \
>>>                  printf("]\n");                  \
>>>                  ksft_inc_xskip_cnt();           \
>>>          } while (0)
>>>
>>> Minor workaround, adding "%s" first argument to macro expansion calls seems
>>> to be the easiest way to eliminate the warnings.
>>>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kselftest@vger.kernel.org
>>> Fixes: 43759d44dc34 ("selftests/mm: add uffdio register ioctls test")
>>> Fixes: 16a45b57cbf2 ("selftests/mm: add framework for uffd-unit-test")
>>> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>>> ---
>>>   tools/testing/selftests/mm/uffd-unit-tests.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c
>>> b/tools/testing/selftests/mm/uffd-unit-tests.c
>>> index 269c86768a02..d356dd271c84 100644
>>> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
>>> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
>>> @@ -1195,14 +1195,14 @@ int main(int argc, char *argv[])
>>>               snprintf(test_name, sizeof(test_name),
>>>                    "%s on %s", test->name, mem_type->name);
>>>   -            uffd_test_start(test_name);
>>> +            uffd_test_start("%s", test_name);
>>>               if (!uffd_feature_supported(test)) {
>>>                   uffd_test_skip("feature missing");
>>>                   continue;
>>>               }
>>>               if (uffd_setup_environment(&args, test, mem_type,
>>>                              &errmsg)) {
>>> -                uffd_test_skip(errmsg);
>>> +                uffd_test_skip("%s", errmsg);
>>>                   continue;
>>>               }
>>>               test->uffd_fn(&args);
>>

-- 
BR,
Muhammad Usama Anjum
