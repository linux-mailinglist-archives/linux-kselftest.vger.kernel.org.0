Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900204CCF18
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 08:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbiCDHe6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 02:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiCDHe5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 02:34:57 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5F392D3D;
        Thu,  3 Mar 2022 23:34:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 489941F462F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646379247;
        bh=Np/FlMv0LvagWUomxrVN4lRvmbAry2baTlXCyY/V+0c=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=HcyOm/SsCuCpUsUrYY68ePamUb0QyNBDl9yFhEX7nZ8KCmGvFHygh400Kh8aPKhZX
         P8Zpga8/MFWVKwf3Jlp68FfPM+xYHN76sYxNaY68PkkkUgBHdLNsmMse5/L0MH1uNA
         GBkyAAR/xhdLNTK+G8H5fY3h4XWf8KQJ1XEivnq0YMlbFljKyxkY54dyuxTQleKEVt
         v/qzu+uaI9HuvtdBQWsLXG2R529jx1/kDdj7xRxtViDQ18QyXUhbgvA434b7bY0cEg
         msR49/PABocTbJMKgVJxnyv0dRGFKrnkQSlv6MCw3cVYAipHRA9fMiKQhTgjneQX1U
         3bj2HILMQp2+Q==
Message-ID: <660ad768-2437-92bb-d5ef-0ca8561499d4@collabora.com>
Date:   Fri, 4 Mar 2022 12:34:00 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        mic@digikod.net, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/interpreter: fix separate directory build
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20220303110629.2072927-1-usama.anjum@collabora.com>
 <b97fe611-0a2d-6907-b924-a9132e2d427f@linuxfoundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <b97fe611-0a2d-6907-b924-a9132e2d427f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/4/22 2:39 AM, Shuah Khan wrote:
> On 3/3/22 4:06 AM, Muhammad Usama Anjum wrote:
>> Separate directory build fails of this test as headers include path isn't
>> set correctly in that case. Fix it by including KHDR_INCLUDES.
>>
>> make -C tools/testing/selftests O=build1
>> gcc -Wall -O2 -I../../../../usr/include    trust_policy_test.c -lcap
>> -o /linux_mainline/build1/kselftest/interpreter/trust_policy_test
>> trust_policy_test.c:14:10: fatal error: linux/trusted-for.h: No such
>> file or directory
>>     14 | #include <linux/trusted-for.h>
>>        |          ^~~~~~~~~~~~~~~~~~~~~
>> compilation terminated.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   tools/testing/selftests/interpreter/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/interpreter/Makefile
>> b/tools/testing/selftests/interpreter/Makefile
>> index 7402fdb6533f..51dde8e01e32 100644
>> --- a/tools/testing/selftests/interpreter/Makefile
>> +++ b/tools/testing/selftests/interpreter/Makefile
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   -CFLAGS += -Wall -O2 -I$(khdr_dir)
>> +CFLAGS += -Wall -O2 -I$(khdr_dir) $(KHDR_INCLUDES)
>>   LDLIBS += -lcap
>>   
> 
> Change looks fine to me.
> 
>>   src_test := $(wildcard *_test.c)
>>
> 
> I am not seeing this test in linux-kselftest next for sure. Which tree is
> this patch based on? Please  add the repo info to the patch subject line
> in the future.
> 
This patch is in linux-next and its build is failing from quite some time:
https://storage.staging.kernelci.org/kernelci/staging-next/staging-next-20220301.0/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/logs/kselftest.log

I'm not sure in which tree selftests/interpreter is present. It was sent
here:
https://lore.kernel.org/lkml/20220104155024.48023-5-mic@digikod.net/

How can I find the tree from which this patch is coming?

> Either way I don't have the patch that added in liunx-kselftest repo:
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> thanks,
> -- Shuah

I forgot to add the tag:
Reported-by: "kernelci.org bot" <bot@kernelci.org>

--
Muhammad Usama Anjum
