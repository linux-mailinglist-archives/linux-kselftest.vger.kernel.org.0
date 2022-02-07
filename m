Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF14AC84E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 19:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiBGSI5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 13:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbiBGSAw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 13:00:52 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9FC0401DC
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 10:00:51 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id p11so5625329ils.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 10:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vAANZBXJ7sjdB6HJV8mdniD7XEYfQ+ohI4e6g+PRzDA=;
        b=b7VXqSPJlQilf3OxElTU4ZKiyU9lyp6MPPkBwL3AuC4i1t/FNz/Jjp2J9pCnwsQOFh
         wn7MaGFgiAcqPlfAb36NLajsoEJnZh84xdKMn9a02dgLgIbq7gCaCCARpHEsjDz/hDRZ
         1NtPXaqXy+5I3ONdQazd/+U2JAUCjLtZfNiE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vAANZBXJ7sjdB6HJV8mdniD7XEYfQ+ohI4e6g+PRzDA=;
        b=2jXAPwBgM+FhDM8CwTTIw1viTxfn6ckaqNSa7TImjuRZZSOjy3yY5LJpQo6O7lHhup
         1U0M3qshthSxLWBvfVIoZ4hPYhHs7wxCN+W1BoA/vhq/r7gZ+CuN9f8R1shX7d56iJ0Q
         sJvz9cpYYrh0j8XZmdnOHAFfAqGtzS9v6S6ScDn3Eyy3wuO7nTPLk5JAXEiL9hIyWQ/H
         vYvDrSMYL/I1aA8jSxG0AT1mUg6hNPvQ6mPKYptvAy8ObPv1xxnJRlTozh/B/cCvj43C
         +G9TlqNTWDoCwbPVGsfQkVfOV7VIcjz+CI/GByAI3xndOiNcTYp3GriILwelLKaq70ZB
         QDFA==
X-Gm-Message-State: AOAM532YL96d+vWZGAVNYLeW70cG4QF2N0PNUrdltYdjkVEzE3T9/tI8
        breODBb38wiRfKZcNHbZtI/okw==
X-Google-Smtp-Source: ABdhPJzzZ8fAEThnEB/DDtjGPIUo2pX8YgD7f8HKp+5pMhwDSyFZtkChRxqswvlKelWm0bvvUUeRmQ==
X-Received: by 2002:a92:c5b1:: with SMTP id r17mr350950ilt.320.1644256850455;
        Mon, 07 Feb 2022 10:00:50 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c13sm2055151ilq.50.2022.02.07.10.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 10:00:50 -0800 (PST)
Subject: Re: [PATCH 0/3] selftests: Remove duplicate CPUID wrappers
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>, linux-mm@kvack.org,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1644000145.git.reinette.chatre@intel.com>
 <81df8c0e-fde6-f3b8-f988-b539f193635b@linuxfoundation.org>
 <c61a227e-e35e-55a8-3571-6e015e222d5f@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3787aee3-064a-dce7-1ab1-0dcabd56a100@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 11:00:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c61a227e-e35e-55a8-3571-6e015e222d5f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/4/22 5:11 PM, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 2/4/2022 3:39 PM, Shuah Khan wrote:
>> On 2/4/22 12:17 PM, Reinette Chatre wrote:
>>> A few tests that require running CPUID do so with a private
>>> implementation of a wrapper for CPUID. This duplication of
>>> the CPUID wrapper should be avoided but having one is also
>>> unnecessary because of the existence of a macro that can
>>> be used instead.
>>>
>>> This series replaces private CPUID wrappers with calls
>>> to the __cpuid_count() macro from cpuid.h as made available
>>> by gcc and clang/llvm.
>>>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: Ram Pai <linuxram@us.ibm.com>
>>> Cc: Sandipan Das <sandipan@linux.ibm.com>
>>> Cc: Florian Weimer <fweimer@redhat.com>
>>> Cc: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Michal Suchanek <msuchanek@suse.de>
>>> Cc: linux-mm@kvack.org
>>> Cc: Chang S. Bae <chang.seok.bae@intel.com>
>>> Cc: Borislav Petkov <bp@suse.de>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: x86@kernel.org
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>>
>>> Reinette Chatre (3):
>>>     selftests/vm/pkeys: Use existing __cpuid_count() macro
>>>     selftests/x86/amx: Use existing __cpuid_count() macro
>>>     selftests/x86/corrupt_xstate_header: Use existing __cpuid_count()
>>>       macro
>>>
>>>    tools/testing/selftests/vm/pkey-x86.h         | 22 +++---------------
>>>    tools/testing/selftests/x86/amx.c             | 23 +++++--------------
>>>    .../selftests/x86/corrupt_xstate_header.c     | 17 ++------------
>>>    3 files changed, 11 insertions(+), 51 deletions(-)
>>>
>>
>> I am all for this cleanup. However, I am not finding __cpuid_count()
>> marco on my system with gcc:
>>
>> gcc --version
>> gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0
>>
>> My concern is regression on older gcc versions.
> 
> Please see this message from our earlier thread where you were able
> to find it on your system:
> https://lore.kernel.org/linux-kselftest/63293c72-55ca-9446-35eb-74aff4c8ba5d@linuxfoundation.org/
> 

Right. After I sent off the response, I was thinking we discussed
this before. Thanks for the refresh.

> As mentioned in that thread, on my system it arrived via user space's
> libgcc-dev package. This does not seem to be the first time including
> files from this source - I did a quick check and from what I can tell
> existing kselftest includes like stdarg.h, stdbool.h, stdatomic.h,
> unwind.h, x86intrin.h ... arrive via libgcc-dev.
> 

This will work fine on newer versions of gcc/clang. However this could
fail when mainline kselftest is used on stable releases on test rings
and so on, especially if they have older versions of gcc/clang.

We will have to find a solution for this. Instead of deleting the local
define, let's keep it under ifndef __cpuid_count

/usr/lib/gcc/x86_64-linux-gnu/11/include/cpuid.h

#define __cpuid_count(level, count, a, b, c, d)                         \
   __asm__ __volatile__ ("cpuid\n\t"                                     \
                         : "=a" (a), "=b" (b), "=c" (c), "=d" (d)        \
                         : "0" (level), "2" (count))

thanks,
-- Shuah
