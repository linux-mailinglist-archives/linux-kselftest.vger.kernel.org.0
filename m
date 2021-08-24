Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1BD3F62B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhHXQfR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 12:35:17 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:41451 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhHXQfQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 12:35:16 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GvF7V49s9z9sVj;
        Tue, 24 Aug 2021 18:34:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NNE9R10_fWol; Tue, 24 Aug 2021 18:34:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GvF7V39gHz9sV8;
        Tue, 24 Aug 2021 18:34:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F08B8B828;
        Tue, 24 Aug 2021 18:34:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1icTG244R3t1; Tue, 24 Aug 2021 18:34:30 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C25C8B80A;
        Tue, 24 Aug 2021 18:34:29 +0200 (CEST)
Subject: Re: [PATCH linux-next] powerpc/tm: remove duplicate include in
 tm-poison.c
To:     Shuah Khan <skhan@linuxfoundation.org>, cgel.zte@gmail.com,
        mpe@ellerman.id.au
Cc:     yong.yiran@zte.com.cn, Zeal Robot <zealci@zte.com.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <20210805065255.628170-1-yong.yiran@zte.com.cn>
 <c5e9900b-1c2d-8e72-ad83-a6024b876fd2@linuxfoundation.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4bc97c33-7fc0-ff9d-041b-e773f682c5d2@csgroup.eu>
Date:   Tue, 24 Aug 2021 18:34:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c5e9900b-1c2d-8e72-ad83-a6024b876fd2@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Le 24/08/2021 à 16:40, Shuah Khan a écrit :
> On 8/5/21 12:52 AM, cgel.zte@gmail.com wrote:
>> From: yong yiran <yong.yiran@zte.com.cn>
>>
>> 'inttypes.h' included in 'tm-poison.c' is duplicated.
>> Remove all but the first include of inttypes.h from tm-poison.c.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
>> ---
>>   tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c 
>> b/tools/testing/selftests/powerpc/tm/tm-poison.c
>> index 29e5f26af7b9..27c083a03d1f 100644
>> --- a/tools/testing/selftests/powerpc/tm/tm-poison.c
>> +++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
>> @@ -20,7 +20,6 @@
>>   #include <sched.h>
>>   #include <sys/types.h>
>>   #include <signal.h>
>> -#include <inttypes.h>
>>   #include "tm.h"
>>
> 
> We can't accept this patch. The from and Signed-off-by don't match.
> 

As far as I can see they match. You have:

From: yong yiran <yong.yiran@zte.com.cn>
Signed-off-by: yong yiran <yong.yiran@zte.com.cn>

