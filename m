Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DED454FFEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jun 2022 00:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353125AbiFQW3d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jun 2022 18:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348824AbiFQW3c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jun 2022 18:29:32 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F37762106
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jun 2022 15:29:31 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-fe32122311so7158780fac.7
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jun 2022 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S9l9aGJ8OWlkPL90OX67eL3mtz7dIUCfETgWKj+djr0=;
        b=dTe/NxZQBPQAy1F7WnL23okeDwPy38Noiw8RFQrcizVeGg3jD9pD69ShC7xavkNH4l
         Hj9JhgoSpeDHNfyt6SFU6z4BMaCPgD8wfiDIficii6RRXnUdpr4X8TMkBCcZOCGOomdv
         l5kkHr4OAgQLl8oP+tZ19yjKHd4uHxaKJjVLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S9l9aGJ8OWlkPL90OX67eL3mtz7dIUCfETgWKj+djr0=;
        b=qrVWfdNshRr1GA9gdncvI1/J4rqQ7atG8y0MCWDnFMRY0b+DeDeeYGEtKdMTfXB6pN
         /OBgfM01BY1wSxhCPyx99xFS0TZBAKCea3I1ES5It0mBjTFJI5RS68w2gIjSGFa4iJxv
         aLqEGGudDv+ogIzCtXXhnmLavZzEoq/Gr0vCae8gnA5OqO8Tj792Zt5zE0QO5GmjvV06
         2XrNCGyIL6ROabv+2Q4CR2r5Z/QS8wIGeL8br7iWdaPbEyrrT1821gZDXxQ8v3dqWT5K
         lj1dG/pnDYaeEsVbQgbwyIOFrG45U/dshDB6tcyQxtU8P3H5bPZR4mzGWTOdKxDcXGxG
         h0oA==
X-Gm-Message-State: AJIora8GYfiU4BeQifk/Y6LismFpKOfN3iHO/H+kEcY8S3c5YNOhZf6J
        mcg0RstwpDLfZVRqvO5sZpeciA==
X-Google-Smtp-Source: AGRyM1scSMtgPqx2X4Uo4L2udxcp1XJ6fjTLMu6AaI0BKuQTxtkoRuARdlmR4tjh2Rm+0QhKu/60Sg==
X-Received: by 2002:a05:6870:434d:b0:e5:9115:cb15 with SMTP id x13-20020a056870434d00b000e59115cb15mr12253484oah.53.1655504970747;
        Fri, 17 Jun 2022 15:29:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 125-20020a4a1183000000b0035f6cf71391sm3339452ooc.43.2022.06.17.15.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 15:29:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] selftests/x86/amx: Fix the test to avoid failure when
 AMX is unavailable
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220401221014.13556-1-chang.seok.bae@intel.com>
 <20220401221014.13556-3-chang.seok.bae@intel.com>
 <aaab50d2-592c-69e4-58a6-0a0926669de3@linuxfoundation.org>
 <327cde12-daea-84ba-4b24-64fe12e89dea@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <de61ffdb-638a-ca84-31b5-55f6a8616597@linuxfoundation.org>
Date:   Fri, 17 Jun 2022 16:29:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <327cde12-daea-84ba-4b24-64fe12e89dea@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/17/22 4:21 PM, Chang S. Bae wrote:
> On 6/16/2022 3:54 PM, Shuah Khan wrote:
>> On 4/1/22 4:10 PM, Chang S. Bae wrote:
>>>

>>
>> This should KSFT_SKIP for this to be reported as a skip. Returning 0
>> will be reported as a Pass.
> 
> I think that's a good point, thanks.
> 
> Now, along with the on-going documentation [1], this test code can be simplified like the below changes, instead of having those cpuid functions:
> 

Simplifying is always good. Send me v2 and I will review it.

thanks,
-- Shuah
