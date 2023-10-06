Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7E7BB326
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 10:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjJFI1v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 04:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjJFI1u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 04:27:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1664983;
        Fri,  6 Oct 2023 01:27:49 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.184.141])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B364E6607328;
        Fri,  6 Oct 2023 09:27:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696580867;
        bh=+Ey03HI15N0Ln/6zDu0UdYMqi8eS+Mq55B6eCM6aGUs=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=eUwRk7hHA0Y4xP9R1VvAcOdZRrYt9j01JL66N/jHl7jRxAajsyxZVkl4KOVKMjTpP
         CQJXDx8Chr1/syaCBv5ETuV9w7xSzPafaAdkpg+O7oxyjXl6fFBu9O/BQ+eh4I84U+
         FDq9oSoh3aUpdka7rhADpbxasrRkEv/vmgn6vrQtEe6ATfkOC3/lLPbtzWaJoAdE8b
         giWEs/cxMfy7mEjh4SGXjqE+YlYy41+HLSUOUy8/Z0pxoOolM84KJBtVxjAQl0l4Gf
         B9b/F6zYkOEVB6SnFbAhdvkti4WpHpAnYmnFStIJ+Z+Pi+/JdS0QLjOI6aEHTQeolH
         LBcSWT+BtiVWA==
Message-ID: <b017f3e0-6682-401e-b20c-8264cd788d6f@collabora.com>
Date:   Fri, 6 Oct 2023 13:27:22 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 6/6] selftests: futex: remove duplicate unneeded defines
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
 <20230805073809.1753462-6-usama.anjum@collabora.com>
 <ZRvU8DXRWL9sgKug@gmail.com>
 <51273ffa-e323-44e8-8a93-bc04ee356df0@collabora.com>
 <ZR8bn/UDLypbUhJT@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZR8bn/UDLypbUhJT@gmail.com>
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

On 10/6/23 1:25 AM, Ingo Molnar wrote:
> 
> * Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> 
>> On 10/3/23 1:46 PM, Ingo Molnar wrote:
>>>
>>> * Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
>>>
>>>> Kselftests are kernel tests and must be build with kernel headers from
>>>> same source version. These duplicate defines should automatically
>>>> picked up from kernel headers. Use KHDR_INCLUDES to add kernel header
>>>> files.
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>>  .../selftests/futex/include/futextest.h       | 22 -------------------
>>>>  1 file changed, 22 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
>>>> index ddbcfc9b7bac4..59f66af3a6d10 100644
>>>> --- a/tools/testing/selftests/futex/include/futextest.h
>>>> +++ b/tools/testing/selftests/futex/include/futextest.h
>>>> @@ -25,28 +25,6 @@
>>>>  typedef volatile u_int32_t futex_t;
>>>>  #define FUTEX_INITIALIZER 0
>>>>  
>>>> -/* Define the newer op codes if the system header file is not up to date. */
>>>> -#ifndef FUTEX_WAIT_BITSET
>>>> -#define FUTEX_WAIT_BITSET		9
>>>> -#endif
>>>> -#ifndef FUTEX_WAKE_BITSET
>>>> -#define FUTEX_WAKE_BITSET		10
>>>> -#endif
>>>> -#ifndef FUTEX_WAIT_REQUEUE_PI
>>>> -#define FUTEX_WAIT_REQUEUE_PI		11
>>>> -#endif
>>>> -#ifndef FUTEX_CMP_REQUEUE_PI
>>>> -#define FUTEX_CMP_REQUEUE_PI		12
>>>> -#endif
>>>> -#ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
>>>> -#define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
>>>> -					 FUTEX_PRIVATE_FLAG)
>>>> -#endif
>>>> -#ifndef FUTEX_REQUEUE_PI_PRIVATE
>>>> -#define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
>>>> -					 FUTEX_PRIVATE_FLAG)
>>>> -#endif
>>>
>>> AFAICT I cannot really pick this up into the locking tree as-is, as this patch
>>> relies on the KHDR_INCLUDES change in patch #1, so that all self-tests get the
>>> kernel headers included, correct?
>> No this patch is self contained and doesn't depend on the patch #1.
>> KHDR_INCLUDES was included several releases back in kselftest's Makefile
>> and in kselftests of futex. Correct headers are being included already. In
>> this patch, I'm removing just the un-needed dead code. Other patches were
>> already picked up by other maintainers.
> 
> So the changelog does not match that characterization, it talks about 
> KHDR_INCLUDES in the present tense, and patch #1 adds the KHDR_INCLUDES, 
> which further suggested a dependency to me:
Sorry, so the working of the change-log isn't clear enough. I'll send the
patch separately and with better wording.

> 
>>>> Kselftests are kernel tests and must be build with kernel headers from
>>>> same source version. These duplicate defines should automatically
>>>> picked up from kernel headers. Use KHDR_INCLUDES to add kernel header
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> files.
>      ^^^^^^
> 
> Could you please re-send it with the changelog updated that makes it clear 
> that this patch works fine standalone against current mainline kernels?
> 
> Thanks,
> 
> 	Ingo

-- 
BR,
Muhammad Usama Anjum
