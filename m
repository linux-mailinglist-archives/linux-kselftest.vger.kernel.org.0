Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6270534A254
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Mar 2021 08:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhCZHFX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Mar 2021 03:05:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21150 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhCZHE6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Mar 2021 03:04:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6Cdz4fhSz9tykG;
        Fri, 26 Mar 2021 08:04:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Z58WxS2xMeos; Fri, 26 Mar 2021 08:04:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6Cdz3Dg6z9tykF;
        Fri, 26 Mar 2021 08:04:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29E918B834;
        Fri, 26 Mar 2021 08:04:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id p6eUKttqYihi; Fri, 26 Mar 2021 08:04:56 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8ACC78B766;
        Fri, 26 Mar 2021 08:04:54 +0100 (CET)
Subject: Re: [PATCH -next] treewide: Remove duplicated include from
 tm-vmx-unavail.c
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210326064812.3262659-1-zhengyongjun3@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <05c34150-1a30-0abe-87c1-5b9a2aa82f0b@csgroup.eu>
Date:   Fri, 26 Mar 2021 08:04:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210326064812.3262659-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Le 26/03/2021 à 07:48, Zheng Yongjun a écrit :
> Remove duplicated include.
> 

Why is that flagged "treewide" ?

Can you please combine all similar changes to tools/testing/selftests/powerpc/ into a single patch 
please ?

Thanks
Christophe

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>   tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
> index e2a0c07e8362..9ef37a9836ac 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
> @@ -17,7 +17,6 @@
>   #include <pthread.h>
>   #include <sys/mman.h>
>   #include <unistd.h>
> -#include <pthread.h>
>   
>   #include "tm.h"
>   #include "utils.h"
> 
