Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2263F62BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhHXQgG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 12:36:06 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:48443 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhHXQgG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 12:36:06 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GvF8S4byJz9sVj;
        Tue, 24 Aug 2021 18:35:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D1LQstLI5zhQ; Tue, 24 Aug 2021 18:35:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GvF8S3cQSz9sV8;
        Tue, 24 Aug 2021 18:35:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 58B8A8B828;
        Tue, 24 Aug 2021 18:35:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R1botbm034Qo; Tue, 24 Aug 2021 18:35:20 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7482C8B80A;
        Tue, 24 Aug 2021 18:35:19 +0200 (CEST)
Subject: Re: [PATCH linux-next] selftests/powerpc: remove duplicate include
To:     Shuah Khan <skhan@linuxfoundation.org>, CGEL <cgel.zte@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Zeal Robot <zealci@zte.com.cn>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linux-kselftest@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Shuah Khan <shuah@kernel.org>
References: <20210824030550.57467-1-deng.changcheng@zte.com.cn>
 <9096738b-7e57-418d-6253-16a107789dac@linuxfoundation.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <e59721c8-fe59-cafe-01a3-8c7d74f2583d@csgroup.eu>
Date:   Tue, 24 Aug 2021 18:35:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9096738b-7e57-418d-6253-16a107789dac@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Le 24/08/2021 à 16:41, Shuah Khan a écrit :
> On 8/23/21 9:05 PM, CGEL wrote:
>> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>>
>> Clean up the following includecheck warning:
>>
>> ./tools/testing/selftests/powerpc/tm/tm-poison.c: inttypes.h is included
>> more than once.
>>
>> No functional change.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
>> ---
>>   tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c 
>> b/tools/testing/selftests/powerpc/tm/tm-poison.c
>> index 29e5f26..27c083a 100644
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

As far as I can see they match:

From: Changcheng Deng <deng.changcheng@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Christophe
