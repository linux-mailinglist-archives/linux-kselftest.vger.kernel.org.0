Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38947915D9
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 12:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbjIDKtC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 06:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjIDKtC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 06:49:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384513E;
        Mon,  4 Sep 2023 03:48:58 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.185.243])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CDCB866071DF;
        Mon,  4 Sep 2023 11:48:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693824536;
        bh=k8kliKdo4+iIHRLqSKtbjBxDArE5A5ZN/aNGBF/7xOQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=aWYbEFN6Ey6zDENOv+2zxoLamc2uBbbohXXPHSCRTTbLzuIR0aQ3vmPibzl9+W5z/
         T0pS+1TsE23oSfRaoLDEH34Z9gQs4Lugk3uFYAacoHKYLV33MxLa3m0/Z+Wwt33/bp
         +aKIZ7KYMIeSJa88rMf0gfxauFwRXWUyacGAqAiFrRIQixUR4/9HiejOwDAEZZh1vI
         LluVgj+O1MxJJeKNKhO44tzy0vxufvJcBaA68B7ZmM80pt4b9ly78W8jMVQKDA0RAR
         7LttAzjzHBdwUl7RRu5gR8XhfGkvxckvvu3C5XbfbL+cpCCfpN/MFvM3qy5bhjxw3F
         wwa41rMKceJ5Q==
Message-ID: <9c0dae5b-a7ee-4399-abf3-883a5946f2f6@collabora.com>
Date:   Mon, 4 Sep 2023 15:48:50 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] selftests: capabilities: remove duplicate unneeded
 defines
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
 <95fc0e92-79ed-4748-a565-a82469d087f6@collabora.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <95fc0e92-79ed-4748-a565-a82469d087f6@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/22/23 1:57 PM, Muhammad Usama Anjum wrote:
> Hi Shuah,
> 
> Christian Brauner had picked [PATCH 4/6]. Others are still not picked.
> Please have a look.
Soft reminder

> 
> Thanks,
> Usama
> 
> On 8/5/23 12:37 PM, Muhammad Usama Anjum wrote:
>> These duplicate defines should automatically be picked up from kernel
>> headers. Use KHDR_INCLUDES to add kernel header files.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/capabilities/Makefile       | 2 +-
>>  tools/testing/selftests/capabilities/test_execve.c  | 8 --------
>>  tools/testing/selftests/capabilities/validate_cap.c | 8 --------
>>  3 files changed, 1 insertion(+), 17 deletions(-)
>>
>> diff --git a/tools/testing/selftests/capabilities/Makefile b/tools/testing/selftests/capabilities/Makefile
>> index 6e9d98d457d5b..411ac098308f1 100644
>> --- a/tools/testing/selftests/capabilities/Makefile
>> +++ b/tools/testing/selftests/capabilities/Makefile
>> @@ -2,7 +2,7 @@
>>  TEST_GEN_FILES := validate_cap
>>  TEST_GEN_PROGS := test_execve
>>  
>> -CFLAGS += -O2 -g -std=gnu99 -Wall
>> +CFLAGS += -O2 -g -std=gnu99 -Wall $(KHDR_INCLUDES)
>>  LDLIBS += -lcap-ng -lrt -ldl
>>  
>>  include ../lib.mk
>> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
>> index df0ef02b40367..e3a352b020a79 100644
>> --- a/tools/testing/selftests/capabilities/test_execve.c
>> +++ b/tools/testing/selftests/capabilities/test_execve.c
>> @@ -20,14 +20,6 @@
>>  
>>  #include "../kselftest.h"
>>  
>> -#ifndef PR_CAP_AMBIENT
>> -#define PR_CAP_AMBIENT			47
>> -# define PR_CAP_AMBIENT_IS_SET		1
>> -# define PR_CAP_AMBIENT_RAISE		2
>> -# define PR_CAP_AMBIENT_LOWER		3
>> -# define PR_CAP_AMBIENT_CLEAR_ALL	4
>> -#endif
>> -
>>  static int nerrs;
>>  static pid_t mpid;	/*  main() pid is used to avoid duplicate test counts */
>>  
>> diff --git a/tools/testing/selftests/capabilities/validate_cap.c b/tools/testing/selftests/capabilities/validate_cap.c
>> index cdfc94268fe6e..60b4e7b716a75 100644
>> --- a/tools/testing/selftests/capabilities/validate_cap.c
>> +++ b/tools/testing/selftests/capabilities/validate_cap.c
>> @@ -9,14 +9,6 @@
>>  
>>  #include "../kselftest.h"
>>  
>> -#ifndef PR_CAP_AMBIENT
>> -#define PR_CAP_AMBIENT			47
>> -# define PR_CAP_AMBIENT_IS_SET		1
>> -# define PR_CAP_AMBIENT_RAISE		2
>> -# define PR_CAP_AMBIENT_LOWER		3
>> -# define PR_CAP_AMBIENT_CLEAR_ALL	4
>> -#endif
>> -
>>  #if __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 19)
>>  # define HAVE_GETAUXVAL
>>  #endif
> 

-- 
BR,
Muhammad Usama Anjum
