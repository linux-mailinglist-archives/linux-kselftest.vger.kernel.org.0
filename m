Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB9672B4EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 02:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjFLAMI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 11 Jun 2023 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLAMI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Jun 2023 20:12:08 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1299EB8;
        Sun, 11 Jun 2023 17:12:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B1CE960161;
        Mon, 12 Jun 2023 02:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686528712; bh=J+LxLsYNe9+MQixJ9S8fEV+WIm5vUBkxw/4ZmHH4Cys=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HuEUu4XSSvXt9QT/kjvtws8LUgDOjhp+LxTofdBruk1jOH8Izp5Ir3uXi+amHe3v4
         iZD1ePzT2VI+NZLQoWe8UR7VMWNkwkruKo+fD5RasljCXBc4ba6Y02ejVOTlZPzRDj
         iZonxq2lKA9kwZa6t/MwJ+qkP8+rFtsqXa2GB4sBPpM5kyYw9Xb1k66amtrF1Tv5ak
         PdRt/Nyz8JNzGLOZwuNfyVPwHQbZMt/otXd+9085uWv2MK2pmdlbTDZc85m9pO/j/S
         +goZemIYOLYn4iq3Ros4/uuYlL1KC55QvQ2WbgdzJ9LflIkZy6O4CiIImeBJgAd4mv
         /zURFyYXEN6kg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5qrJgMNOROOU; Mon, 12 Jun 2023 02:11:50 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id F0FB86015F;
        Mon, 12 Jun 2023 02:11:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686528710; bh=J+LxLsYNe9+MQixJ9S8fEV+WIm5vUBkxw/4ZmHH4Cys=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rppk12DfYRXTRe2hymowdjRWTQcHPgrL/p4Iw/PFOpAT4dcX3rplQeeMLspxHYrQw
         rr/3jomcIDhyUqz+dIMKkgbbC0JWKx8xFNMG+fherShRpvKMMzxfqKskhnNxwlTKyp
         MKaoXam7VJPJCyRRBilBjSiFyX93RbQgzdHGv6JXAlz2t4B9I15E4m5RHtfG//JXdy
         5ICZLsw3mavUMHrvpWwpQjlrIb6TJY500YYe3ISNCzsBXNT7tqdFLG2mu29SaLJuTT
         60Qn3jfq2ryUWhjFW9G8aWVIuQ4K1zul8EljqT8flJ1dqw6riafCEdiqeGfFHgIUht
         stMapo8M686Hg==
Message-ID: <138905be-3963-cd67-c217-7aa561372293@alu.unizg.hr>
Date:   Mon, 12 Jun 2023 02:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/1] selftests: mm: uufd-unit-tests: remove a format
 warning in printf
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230610235016.438460-1-mirsad.todorovac@alu.unizg.hr>
 <109d9c47-9c0e-e8ca-2bc1-cb741bc45a1b@collabora.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <109d9c47-9c0e-e8ca-2bc1-cb741bc45a1b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Apologies Muhammad then, didn't follow that branch.

Regards,
Mirsad

On 6/11/23 14:30, Muhammad Usama Anjum wrote:
> The fix has already been picked up by Andew in mm unstable:
> 
> https://lore.kernel.org/all/20230607023727.0E011C433D2@smtp.kernel.org
> 
> On 6/11/23 4:50 AM, Mirsad Todorovac wrote:
>> GCC 11.3.0 issued warnings about macros and types of arguments [edited]:
>>
>> gcc -Wall -I ../tools/testing/selftests/../../.. \
>> 	-I ../tools/testing/selftests/../../../tools/include/uapi \
>> 	-isystem ../usr/include -no-pie uffd-unit-tests.c vm_util.c \
>> 	uffd-common.c -lrt -lpthread -o \
>> 	../tools/testing/selftests/mm/uffd-unit-tests
>> uffd-unit-tests.c: In function ‘main’:
>> uffd-unit-tests.c:1198:41: warning: format not a string literal and no \
>> 	format arguments [-Wformat-security]
>>   1198 |                         uffd_test_start(test_name);
>>        |                                         ^~~~~~~~~
>> uffd-unit-tests.c:100:24: note: in definition of macro ‘uffd_test_start’
>>    100 |                 printf(__VA_ARGS__);            \
>>        |                        ^~~~~~~~~~~
>> uffd-unit-tests.c:1205:33: warning: format not a string literal and no \
>> 	format arguments [-Wformat-security]
>>   1205 |                                 uffd_test_skip(errmsg);
>>        |                                 ^~~~~~~~~~~~~~
>>
>> The macros are defined as:
>>
>>   #define  uffd_test_start(...)  do {             \
>>                  printf("Testing ");             \
>>                  printf(__VA_ARGS__);            \
>>                  printf("... ");                 \
>>                  fflush(stdout);                 \
>>          } while (0)
>>
>>   #define  uffd_test_skip(...)  do {              \
>>                  printf("skipped [reason: ");    \
>>                  printf(__VA_ARGS__);            \
>>                  printf("]\n");                  \
>>                  ksft_inc_xskip_cnt();           \
>>          } while (0)
>>
>> Minor workaround, adding "%s" first argument to macro expansion calls seems
>> to be the easiest way to eliminate the warnings.
>>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kselftest@vger.kernel.org
>> Fixes: 43759d44dc34 ("selftests/mm: add uffdio register ioctls test")
>> Fixes: 16a45b57cbf2 ("selftests/mm: add framework for uffd-unit-test")
>> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>> ---
>>   tools/testing/selftests/mm/uffd-unit-tests.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
>> index 269c86768a02..d356dd271c84 100644
>> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
>> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
>> @@ -1195,14 +1195,14 @@ int main(int argc, char *argv[])
>>   			snprintf(test_name, sizeof(test_name),
>>   				 "%s on %s", test->name, mem_type->name);
>>   
>> -			uffd_test_start(test_name);
>> +			uffd_test_start("%s", test_name);
>>   			if (!uffd_feature_supported(test)) {
>>   				uffd_test_skip("feature missing");
>>   				continue;
>>   			}
>>   			if (uffd_setup_environment(&args, test, mem_type,
>>   						   &errmsg)) {
>> -				uffd_test_skip(errmsg);
>> +				uffd_test_skip("%s", errmsg);
>>   				continue;
>>   			}
>>   			test->uffd_fn(&args);
> 
