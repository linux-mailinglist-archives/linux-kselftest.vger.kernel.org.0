Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0EA3F62E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 18:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhHXQnK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhHXQnJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 12:43:09 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4700AC061757
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 09:42:21 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id j18so27093976ioj.8
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 09:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nIgXchQzkQhDuuxzVmoHtjc1x93MwuM62GG3/htVnnc=;
        b=KBiJ2SXhXbplYkTDTlgBKn+GW+K2v1LLz+EFVixmgw6vRoIIIsEbnEpVq3wEFG7LJ4
         fvKH5uG5E2XcfDDTBIguvTuzzA4ljDGsD+YD35BNEkHHS5OAldRXYV1GS5NGRpajpnzW
         klTsgpCugR+REOLminT46oURTG4xCKeUzMtxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIgXchQzkQhDuuxzVmoHtjc1x93MwuM62GG3/htVnnc=;
        b=tIFV6wVuNsrbNRlUFhPvolPGlpAQE+ZFSe56YwBxnkWb9g53VSOjz52CrTQjNkABuV
         66cI9tXFRne3EuGiTPWY+dlOn3Qw4E1H19inX5RYj5ZrOmBIuWxXdk/T2LFpUscej+ey
         YSr3dU0FVdaLhO1++gVCTa5PELAw9nyONIoV+rfezJaUrgiy2Y0M14HElkWEkzhBhbX1
         yGLDr9845qnIc8BETqUUO1jpwCMl2bQ0JT8DAfP54zrmiC7bVF/CT3wQ7fghgmRNAkLg
         N0KnQACHR47qUdsqL9SavnB106xMJWuL1leci5r2gYSl8WNiG+k/uRA7XAZ1L5FO5s3o
         uVCA==
X-Gm-Message-State: AOAM530FK0GFOTq7xI7XZI315j421A4eRLhqgaLMANuK3Bu1gov1jCGg
        wKf+WM9YIIoiPkQNaupSToqnFw==
X-Google-Smtp-Source: ABdhPJzMw5fmv+XMCK8ylBh9MKFCODi5eD0DzaIc7+CibHXe9LdxjQ8fqrYMknxdF7urKjq5vCuB2g==
X-Received: by 2002:a5d:9bcf:: with SMTP id d15mr31669482ion.88.1629823340657;
        Tue, 24 Aug 2021 09:42:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m13sm9743492ilh.43.2021.08.24.09.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:42:20 -0700 (PDT)
Subject: Re: [PATCH linux-next] selftests/powerpc: remove duplicate include
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        CGEL <cgel.zte@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc:     Zeal Robot <zealci@zte.com.cn>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linux-kselftest@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210824030550.57467-1-deng.changcheng@zte.com.cn>
 <9096738b-7e57-418d-6253-16a107789dac@linuxfoundation.org>
 <e59721c8-fe59-cafe-01a3-8c7d74f2583d@csgroup.eu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7f9f3bf4-646c-b8ab-8d46-7e87cf8e9af3@linuxfoundation.org>
Date:   Tue, 24 Aug 2021 10:42:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e59721c8-fe59-cafe-01a3-8c7d74f2583d@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/24/21 10:35 AM, Christophe Leroy wrote:
> 
> 
> Le 24/08/2021 à 16:41, Shuah Khan a écrit :
>> On 8/23/21 9:05 PM, CGEL wrote:
>>> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>>>
>>> Clean up the following includecheck warning:
>>>
>>> ./tools/testing/selftests/powerpc/tm/tm-poison.c: inttypes.h is included
>>> more than once.
>>>
>>> No functional change.
>>>
>>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>>> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
>>> ---
>>>   tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c b/tools/testing/selftests/powerpc/tm/tm-poison.c
>>> index 29e5f26..27c083a 100644
>>> --- a/tools/testing/selftests/powerpc/tm/tm-poison.c
>>> +++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
>>> @@ -20,7 +20,6 @@
>>>   #include <sched.h>
>>>   #include <sys/types.h>
>>>   #include <signal.h>
>>> -#include <inttypes.h>
>>>   #include "tm.h"
>>>
>>
>> We can't accept this patch. The from and Signed-off-by don't match.
> 
> As far as I can see they match:
> 
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> 

Yeah. My bad.

thanks,
-- Shuah

