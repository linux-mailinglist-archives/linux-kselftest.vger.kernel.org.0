Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4773345777
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 06:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCWFpA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 01:45:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64508 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhCWFoh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 01:44:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F4L0g1BgSz9ty3k;
        Tue, 23 Mar 2021 06:44:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xbkvXfPDcdXX; Tue, 23 Mar 2021 06:44:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F4L0g02wbz9ty3M;
        Tue, 23 Mar 2021 06:44:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B43258B7AE;
        Tue, 23 Mar 2021 06:44:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id C10NKDQba7Ie; Tue, 23 Mar 2021 06:44:35 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3AFE38B75F;
        Tue, 23 Mar 2021 06:44:35 +0100 (CET)
Subject: Re: [PATCH] tools: testing: Remove duplicate include of sched.h
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20210323033413.284420-1-wanjiabing@vivo.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <218e9c09-e245-9565-a233-a210c49ae590@csgroup.eu>
Date:   Tue, 23 Mar 2021 06:44:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323033413.284420-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Le 23/03/2021 à 04:34, Wan Jiabing a écrit :
> sched.h has been included at line 33.
> So we remove the duplicate one at line 36.

Can you please send a single patch for all files in tools/testing/selftests/powerpc/

Thanks
Christophe

> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   tools/testing/selftests/powerpc/mm/tlbie_test.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
> index f85a0938ab25..48344a74b212 100644
> --- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
> +++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
> @@ -33,7 +33,6 @@
>   #include <sched.h>
>   #include <time.h>
>   #include <stdarg.h>
> -#include <sched.h>
>   #include <pthread.h>
>   #include <signal.h>
>   #include <sys/prctl.h>
> 
