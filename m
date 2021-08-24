Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8789B3F60BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 16:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhHXOmf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbhHXOmd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 10:42:33 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF1C061757
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:41:49 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q3so9233090iot.3
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R4sYf/rlvV8BhzPPdioEXkPuJURRz5oo6OShBjBno4A=;
        b=J3cKzkSZLG5+Jlxd5R1kmYkfVivtcSeU9aN1Wo0RIgBDtD+XJIgw3iIsCE62Z173IY
         vmw85CJvjFLV3zemN9Czo15vKZCpXmMX7jJoiYu8O9Rob2/+I95we24z7V6oXTiqyruc
         ZAb9jsCuTEQR8tonDWOkriUWJUINLJDr3fszA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R4sYf/rlvV8BhzPPdioEXkPuJURRz5oo6OShBjBno4A=;
        b=p3ylDLYSpov2Bgpf+s4JDFAILsLsPol2X5jDEQP7+5q/dscT+gGgjdPA6G7BjuScXR
         uiX82fNBH9Vpcf8/4KkMvptE5HVP4AZb4jee8P2QSAIP4qjiY0STWxagl0/5vOJ9lEx+
         qGoBV+aURsr4d2shsTqLrQDZkqac5ctOwFDNt3gLVoN5+6efpYtMhzY51tGms7jx1tfX
         9mnfc7p7RZF0E4rc3r+4l0/SI6DUugw37r90PSQrS4DydnNV4aiSOzndYnzyFUGWC8Nh
         0CnQWMVvoUGHFx6dheSrQUmyK7CTosI9a33eC3tlScrCJsgS214yPLYgYW0adD4KBgu5
         Jfrg==
X-Gm-Message-State: AOAM530WZZ+0hFj9fNPXBdqELM3X/ztT13KzHNnyGB9zTpY5Yy7AstVR
        zmsh7NRkxCf1XQ77HjnI8Q2nsA==
X-Google-Smtp-Source: ABdhPJwz5TxZkECr6N1SrMAlQvdgJ2sMTH9JWZGMdbIvLLOQ872P317kjoNNEoVPAU0Qn/JHdk5s/Q==
X-Received: by 2002:a5d:824e:: with SMTP id n14mr31134832ioo.134.1629816109044;
        Tue, 24 Aug 2021 07:41:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s6sm10046526iow.1.2021.08.24.07.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:41:48 -0700 (PDT)
Subject: Re: [PATCH linux-next] selftests/powerpc: remove duplicate include
To:     CGEL <cgel.zte@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210824030550.57467-1-deng.changcheng@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9096738b-7e57-418d-6253-16a107789dac@linuxfoundation.org>
Date:   Tue, 24 Aug 2021 08:41:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210824030550.57467-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/23/21 9:05 PM, CGEL wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Clean up the following includecheck warning:
> 
> ./tools/testing/selftests/powerpc/tm/tm-poison.c: inttypes.h is included
> more than once.
> 
> No functional change.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>   tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c b/tools/testing/selftests/powerpc/tm/tm-poison.c
> index 29e5f26..27c083a 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-poison.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
> @@ -20,7 +20,6 @@
>   #include <sched.h>
>   #include <sys/types.h>
>   #include <signal.h>
> -#include <inttypes.h>
>   
>   #include "tm.h"
>   
> 

We can't accept this patch. The from and Signed-off-by don't match.

thanks,
-- Shuah
