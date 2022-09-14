Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2F5B8AE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 16:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiINOnt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiINOnp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 10:43:45 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2742E5B063
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 07:43:44 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MSNPS1c3VzMqCSd;
        Wed, 14 Sep 2022 16:43:40 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MSNPR46r3zxZ;
        Wed, 14 Sep 2022 16:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663166620;
        bh=QQtoUc8WzlrPBk4MhC3cJKztSDSpUNv0pZwEBuRqO/8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=TPUJlFttfPlzosXg3tKhlFHLXtqe3cLY4I5iBL+ELlMeQ5i0N3u15hBY+GWf9/9hW
         ykg0wNiQD3G+p0tETLqrNDtbdESe0BHG4vUoLQPaBJW+83kRhZOSunUFH3Rn9w/eDb
         4bXO1xLX5EbS4w8IUsyi1nhM6odzrdKzFYK7Kwno=
Message-ID: <21feac5f-27d1-60ca-0c06-6605f3f27474@digikod.net>
Date:   Wed, 14 Sep 2022 16:43:38 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1] selftests/landlock: Fix out-of-tree builds
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20220909103402.1501802-1-mic@digikod.net>
 <5e288153-ca6b-a91d-a3fd-cd2b1e102b3e@digikod.net>
In-Reply-To: <5e288153-ca6b-a91d-a3fd-cd2b1e102b3e@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I took the liberty to pushed it in -next with my tree: 
https://git.kernel.org/mic/c/a52540522c9541bfa3e499d2edba7bc0ca73a4ca

Please let me know when you can take it in your tree to include it in 
the next -rc.

Regards,
  Mickaël

On 12/09/2022 21:48, Mickaël Salaün wrote:
> Shuah, could you please merge this patch (and the USERCFLAGS/USERLDFLAGS
> one if that's OK) to -next? This is fixing an issue in the current 6.0-rc5 .
> 
> Anders, can you please check that this fixes your issue?
> https://lore.kernel.org/r/CADYN=9JM1nnjC9LypHqrz7JJjbZLpm8rArDUy4zgYYrajErBnA@mail.gmail.com
> 
> 
> On 09/09/2022 12:34, Mickaël Salaün wrote:
>> These changes simplify the Makefile and handle these 5 ways to build
>> Landlock tests:
>> - make -C tools/testing/selftests/landlock
>> - make -C tools/testing/selftests TARGETS=landlock gen_tar
>> - make TARGETS=landlock kselftest-gen_tar
>> - make TARGETS=landlock O=build kselftest-gen_tar
>> - make -C /tmp/linux TARGETS=landlock O=/tmp/build kselftest-gen_tar
>>
>> This also makes $(KHDR_INCLUDES) available to other test collections
>> when building in their directory.
>>
>> Fixes: f1227dc7d041 ("selftests/landlock: fix broken include of linux/landlock.h")
>> Fixes: 3bb267a36185 ("selftests: drop khdr make target")
>> Cc: Anders Roxell <anders.roxell@linaro.org>
>> Cc: Guillaume Tucker <guillaume.tucker@collabora.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Link: https://lore.kernel.org/r/20220909103402.1501802-1-mic@digikod.net
>> ---
>>    tools/testing/selftests/landlock/Makefile | 19 ++++++++++---------
>>    tools/testing/selftests/lib.mk            |  4 ++++
>>    2 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
>> index 02868ac3bc71..6632bfff486b 100644
>> --- a/tools/testing/selftests/landlock/Makefile
>> +++ b/tools/testing/selftests/landlock/Makefile
>> @@ -1,6 +1,11 @@
>>    # SPDX-License-Identifier: GPL-2.0
>> +#
>> +# First run: make -C ../../../.. headers_install
>>    
>>    CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
>> +LDLIBS += -lcap
>> +
>> +LOCAL_HDRS += common.h
>>    
>>    src_test := $(wildcard *_test.c)
>>    
>> @@ -8,14 +13,10 @@ TEST_GEN_PROGS := $(src_test:.c=)
>>    
>>    TEST_GEN_PROGS_EXTENDED := true
>>    
>> -OVERRIDE_TARGETS := 1
>> -top_srcdir := ../../../..
>> -include ../lib.mk
>> -
>> -khdr_dir = $(top_srcdir)/usr/include
>> +# Static linking for short targets:
>> +$(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
>>    
>> -$(OUTPUT)/true: true.c
>> -	$(LINK.c) $< $(LDLIBS) -o $@ -static
>> +include ../lib.mk
>>    
>> -$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
>> -	$(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
>> +# Static linking for targets with $(OUTPUT)/ prefix:
>> +$(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
>> index d44c72b3abe3..9d4cb94cf437 100644
>> --- a/tools/testing/selftests/lib.mk
>> +++ b/tools/testing/selftests/lib.mk
>> @@ -42,6 +42,10 @@ endif
>>    selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
>>    top_srcdir = $(selfdir)/../../..
>>    
>> +ifeq ($(KHDR_INCLUDES),)
>> +KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
>> +endif
>> +
>>    # The following are built by lib.mk common compile rules.
>>    # TEST_CUSTOM_PROGS should be used by tests that require
>>    # custom build rule and prevent common build rule use.
>>
>> base-commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
