Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8DC6FB603
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 May 2023 19:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjEHRhv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjEHRht (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 13:37:49 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCEA194
        for <linux-kselftest@vger.kernel.org>; Mon,  8 May 2023 10:37:48 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-763740a7f31so26105639f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 May 2023 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683567467; x=1686159467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BT18Gf5nwhyEngZhDe8k3tgWx6qSJn3mcFYTsDGe+OQ=;
        b=TaoJ0RlfRDuZDdtYJ1yBPne0RMl7nV6wCU1oxUH3WIAT0vE51H3y37Ce4mC4O9Sr8/
         brA3Z+CwXmMCzWyi57TK570A4dnjyotGEQx529oEQT5NYhophQ1uU9UD4DeKFqQWovWc
         VOdRiwAWjhvu/qN51rEy1W0j5iABTfZJ4pHdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683567467; x=1686159467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BT18Gf5nwhyEngZhDe8k3tgWx6qSJn3mcFYTsDGe+OQ=;
        b=Sx0GV8kBUaNqtrHTlAvkkkwTq4oP+SdyhZMJmqiHeJro5NJfIfum/NvS6EEruEqRcx
         Hn5eaGyuyKSFus/JOECWDLot0zUOum9f1o3IlVLqroYB37+yt0eNaiCKGLOVZGCv+Lwr
         Yah7t5IWwurikbEmng9RJEjpo2GkkTcGGj+KAQQFzEOJHYdAHC48tLGGEY8/Ky2NGGFO
         9iUerjAv+s6Gz9VuPyZdpnH/AAxzzNrTlfONJQDMcm74vhbF3KXY0LtpsP2AYHlXjea+
         g1chVr2r/r0ZF0atJbJZHk0uEza7QlPhVKxFpmyd50+9kup74ayoVX518m9u3vVqOntx
         lJ9g==
X-Gm-Message-State: AC+VfDxyQ2EjGZlNMI2m1dEodAtYrXyihOmvWX9JVK5U860kfb12Nr/W
        zYcFSnmF5GCh8Dgg/IlVtlXnGQ==
X-Google-Smtp-Source: ACHHUZ76KjNl3Y/fkgFcbRHJzMkozNBw3nRD6kwkMe8nV7IKTdU6L3wxiidH8FpQehWmCwthwmhfbg==
X-Received: by 2002:a05:6602:2c8f:b0:760:dfd3:208d with SMTP id i15-20020a0566022c8f00b00760dfd3208dmr7445248iow.0.1683567467626;
        Mon, 08 May 2023 10:37:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h30-20020a056602131e00b0076373f90e46sm2410118iov.33.2023.05.08.10.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:37:47 -0700 (PDT)
Message-ID: <f06b953c-5bc2-f46a-581f-c2ff87d2bbd5@linuxfoundation.org>
Date:   Mon, 8 May 2023 11:37:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] kselftest: vDSO: Fix accumulation of uninitialized ret
 when CLOCK_REALTIME is undefined
Content-Language: en-US
To:     "Colin King (gmail)" <colin.i.king@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230417104743.30018-1-colin.i.king@gmail.com>
 <20487c94-7f81-cbf5-7136-c7f266eaf60d@arm.com>
 <530b12f1-b0d2-1183-c9a9-0f5f9d6e178d@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <530b12f1-b0d2-1183-c9a9-0f5f9d6e178d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/18/23 04:14, Colin King (gmail) wrote:
> On 18/04/2023 11:10, Vincenzo Frascino wrote:
>> Hi Colin,
>>
>> On 4/17/23 11:47, Colin Ian King wrote:
>>> In the unlikely case that CLOCK_REALTIME is not defined, variable ret is
>>> not initialized and further accumulation of return values to ret can leave
>>> ret in an undefined state. Fix this by initialized ret to zero and changing
>>> the assignment of ret to an accumulation for the CLOCK_REALTIME case.
>>>
>>
>> I was wondering how did you find this.
> 
> I used cppcheck --force --enable=all, this examines the #if defined() paths.
> 
>>
>> Apart that:
>>
>> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>

Applied to linux-kselftest next

thanks,
-- Shuah

