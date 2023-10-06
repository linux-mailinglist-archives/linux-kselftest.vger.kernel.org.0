Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB1B7BB4DF
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 12:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjJFKJP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 06:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjJFKJN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 06:09:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F8FD6;
        Fri,  6 Oct 2023 03:09:10 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.184.141])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 18EB86612212;
        Fri,  6 Oct 2023 11:09:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696586949;
        bh=TzX85ikGFiA+2MMrjYo1iLdJ7uy0EZdxUXB9E/ajsGk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=WN7ek4hwJWyvJFwkBjKVWGSSuG4rb9/mqTBzz2Gst0QshDrFX8MVC84O9jo+HJ+mR
         qOz3mvu203NDMo1+TCGJhdi2kuU5+1s9mdvJuuRuwWQZ9KwsS69il3i5+GkY4Dpo6r
         E6J/V9+499f/Po5A4fg7784Z9cZAT6T+POWIvI1E5FT8zDEwzXGyGesViWFRKRCCbg
         gWlsseGRjRBEX+LTNl74g8yvlzz6TmEbDYSi6zBW1vHNai+8k7ujNBZ67NfYgKj9gY
         iWOmMKXWtMu56DjgZb1ApLqDjkaczwAOCZtY0OfGyooIR6UOJqCyrqg+fItFobAjLo
         FAI/V8LtLGCHg==
Message-ID: <369f876c-be07-41d9-b2fb-ec7d629f2d9b@collabora.com>
Date:   Fri, 6 Oct 2023 15:09:04 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] selftests: capabilities: remove duplicate unneeded
 defines
Content-Language: en-US
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
 <95fc0e92-79ed-4748-a565-a82469d087f6@collabora.com>
 <9c0dae5b-a7ee-4399-abf3-883a5946f2f6@collabora.com>
 <1c0ce608-20a4-4b72-8d5e-5308e119959b@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <1c0ce608-20a4-4b72-8d5e-5308e119959b@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/6/23 1:33 PM, Muhammad Usama Anjum wrote:
> On 9/4/23 3:48 PM, Muhammad Usama Anjum wrote:
>> On 8/22/23 1:57 PM, Muhammad Usama Anjum wrote:
>>> Hi Shuah,
>>>
>>> Christian Brauner had picked [PATCH 4/6]. Others are still not picked.
>>> Please have a look.
> Shuah, I thought you had picked up these patches. But I'm unable to find
> them in the linux-next. I'll be re-sending 6th patch separately. Can you
> please pick up patch number 1, 2, 3 and 5 to your tree?
Sent v2 for your ease. It has same patches.
https://lore.kernel.org/all/20231006100743.1631334-1-usama.anjum@collabora.com

> 
> Thanks
> 
>> Soft reminder
>>
>>>
>>> Thanks,
>>> Usama
>>>
>>> On 8/5/23 12:37 PM, Muhammad Usama Anjum wrote:
>>>> These duplicate defines should automatically be picked up from kernel
>>>> headers. Use KHDR_INCLUDES to add kernel header files.
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>>  tools/testing/selftests/capabilities/Makefile       | 2 +-
>>>>  tools/testing/selftests/capabilities/test_execve.c  | 8 --------
>>>>  tools/testing/selftests/capabilities/validate_cap.c | 8 --------
>>>>  3 files changed, 1 insertion(+), 17 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/capabilities/Makefile b/tools/testing/selftests/capabilities/Makefile
>>>> index 6e9d98d457d5b..411ac098308f1 100644
>>>> --- a/tools/testing/selftests/capabilities/Makefile
>>>> +++ b/tools/testing/selftests/capabilities/Makefile
>>>> @@ -2,7 +2,7 @@
>>>>  TEST_GEN_FILES := validate_cap
>>>>  TEST_GEN_PROGS := test_execve
>>>>  
>>>> -CFLAGS += -O2 -g -std=gnu99 -Wall
>>>> +CFLAGS += -O2 -g -std=gnu99 -Wall $(KHDR_INCLUDES)
>>>>  LDLIBS += -lcap-ng -lrt -ldl
>>>>  
>>>>  include ../lib.mk
>>>> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
>>>> index df0ef02b40367..e3a352b020a79 100644
>>>> --- a/tools/testing/selftests/capabilities/test_execve.c
>>>> +++ b/tools/testing/selftests/capabilities/test_execve.c
>>>> @@ -20,14 +20,6 @@
>>>>  
>>>>  #include "../kselftest.h"
>>>>  
>>>> -#ifndef PR_CAP_AMBIENT
>>>> -#define PR_CAP_AMBIENT			47
>>>> -# define PR_CAP_AMBIENT_IS_SET		1
>>>> -# define PR_CAP_AMBIENT_RAISE		2
>>>> -# define PR_CAP_AMBIENT_LOWER		3
>>>> -# define PR_CAP_AMBIENT_CLEAR_ALL	4
>>>> -#endif
>>>> -
>>>>  static int nerrs;
>>>>  static pid_t mpid;	/*  main() pid is used to avoid duplicate test counts */
>>>>  
>>>> diff --git a/tools/testing/selftests/capabilities/validate_cap.c b/tools/testing/selftests/capabilities/validate_cap.c
>>>> index cdfc94268fe6e..60b4e7b716a75 100644
>>>> --- a/tools/testing/selftests/capabilities/validate_cap.c
>>>> +++ b/tools/testing/selftests/capabilities/validate_cap.c
>>>> @@ -9,14 +9,6 @@
>>>>  
>>>>  #include "../kselftest.h"
>>>>  
>>>> -#ifndef PR_CAP_AMBIENT
>>>> -#define PR_CAP_AMBIENT			47
>>>> -# define PR_CAP_AMBIENT_IS_SET		1
>>>> -# define PR_CAP_AMBIENT_RAISE		2
>>>> -# define PR_CAP_AMBIENT_LOWER		3
>>>> -# define PR_CAP_AMBIENT_CLEAR_ALL	4
>>>> -#endif
>>>> -
>>>>  #if __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 19)
>>>>  # define HAVE_GETAUXVAL
>>>>  #endif
>>>
>>
> 

-- 
BR,
Muhammad Usama Anjum
