Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B002C7BA048
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjJEOex (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 10:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjJEOcq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 10:32:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE1C2618F;
        Thu,  5 Oct 2023 05:06:32 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.184.141])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 71FB1660731C;
        Thu,  5 Oct 2023 13:06:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696507590;
        bh=LdOVFJ/CYTynGHR1c4xxHz9cnN943FYHgYIwv7MK744=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=WnsEjPQ9UUsfCljQpV2ZUWJ8LvLt69qmKb9NmZ9h8SL8ElBPu5mRSLIeqkcgU0f2x
         T0rDPNS28EGIvhBrDIhF5wFRYljOiTewRM1+mb50uzpSQ2BwJ47OQsiDI242g5sFNg
         gznE4hhq9z/LZJFXToBgRUPbC3aK7+WHOGkk0Ym9tTQG2R2OvaMWQjbeZjzYPBQQx3
         lol1SSOkU/oXzE8YVJvZ0aqDsUVJUWul5JpjBUIC2qfz9ecmfto4tyno6MTeGfWIZJ
         t30gk02uaYhQKZ47GIhN/v3V1iMSqpH3ALW0ES0AHbODQ81G8BcxFvHARSuTP174/1
         UBslRlbgTpryg==
Message-ID: <51273ffa-e323-44e8-8a93-bc04ee356df0@collabora.com>
Date:   Thu, 5 Oct 2023 17:06:21 +0500
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
To:     Ingo Molnar <mingo@kernel.org>
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
 <20230805073809.1753462-6-usama.anjum@collabora.com>
 <ZRvU8DXRWL9sgKug@gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZRvU8DXRWL9sgKug@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/3/23 1:46 PM, Ingo Molnar wrote:
> 
> * Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> 
>> Kselftests are kernel tests and must be build with kernel headers from
>> same source version. These duplicate defines should automatically
>> picked up from kernel headers. Use KHDR_INCLUDES to add kernel header
>> files.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  .../selftests/futex/include/futextest.h       | 22 -------------------
>>  1 file changed, 22 deletions(-)
>>
>> diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
>> index ddbcfc9b7bac4..59f66af3a6d10 100644
>> --- a/tools/testing/selftests/futex/include/futextest.h
>> +++ b/tools/testing/selftests/futex/include/futextest.h
>> @@ -25,28 +25,6 @@
>>  typedef volatile u_int32_t futex_t;
>>  #define FUTEX_INITIALIZER 0
>>  
>> -/* Define the newer op codes if the system header file is not up to date. */
>> -#ifndef FUTEX_WAIT_BITSET
>> -#define FUTEX_WAIT_BITSET		9
>> -#endif
>> -#ifndef FUTEX_WAKE_BITSET
>> -#define FUTEX_WAKE_BITSET		10
>> -#endif
>> -#ifndef FUTEX_WAIT_REQUEUE_PI
>> -#define FUTEX_WAIT_REQUEUE_PI		11
>> -#endif
>> -#ifndef FUTEX_CMP_REQUEUE_PI
>> -#define FUTEX_CMP_REQUEUE_PI		12
>> -#endif
>> -#ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
>> -#define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
>> -					 FUTEX_PRIVATE_FLAG)
>> -#endif
>> -#ifndef FUTEX_REQUEUE_PI_PRIVATE
>> -#define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
>> -					 FUTEX_PRIVATE_FLAG)
>> -#endif
> 
> AFAICT I cannot really pick this up into the locking tree as-is, as this patch
> relies on the KHDR_INCLUDES change in patch #1, so that all self-tests get the
> kernel headers included, correct?
No this patch is self contained and doesn't depend on the patch #1.
KHDR_INCLUDES was included several releases back in kselftest's Makefile
and in kselftests of futex. Correct headers are being included already. In
this patch, I'm removing just the un-needed dead code. Other patches were
already picked up by other maintainers.

> 
> Thanks,
> 
> 	Ingo

-- 
BR,
Muhammad Usama Anjum
