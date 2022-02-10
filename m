Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21614B14A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 18:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245374AbiBJRyY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 12:54:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbiBJRyX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 12:54:23 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BB7192
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 09:54:24 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e8so4951862ilm.13
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q7i54cuBSiwNlIdMIpYwGxEyLKNC5y20RCD1s/+xbRU=;
        b=M0dItbRMeF8Ens4I4vSnXqDzqdY1K9MdmcE9dd75J+gyvv7L7PqsWd/0X8Y6Orvx7D
         STduJWFa+GAoayQ3lklOyAoN85kp45uSQkfR+VIsnp/zFybiUYYCmAd63oSEiE9PMFme
         iS77ebkpxDTzcDk8sqcN4NMtM5uA87iJMdJDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q7i54cuBSiwNlIdMIpYwGxEyLKNC5y20RCD1s/+xbRU=;
        b=ruHq58b0jNpr7q+XgXqYQvK6sI8yHnH1GKG+o0DxamPAMo8p2AWRoXfZJ/EBdaRCLp
         KSCy41PG+vXO7fFZOZfOyZD/GpwdmGd5UmroIVEm/hMjEuiWbm7U8JJF7LALjLbdquCa
         5/Bo7UxhOQUdoAVuFVE2lpOQCCaic7JTOHFnSo4SQlhb+jnFJplAKbenTB8KiMi787o/
         Mtoj8Ai2QYo0/M32Le1H9qlw8o+eU2WgB2zt3niV0aSegBPt6u0NaZJ9v07SoHqTLmCw
         gq+I1KIJ9T3QaWVqA2iKQoYo4cc+QJOqi8IXQ1HFhQmye2hYA3Bzcvbt635yZhHqR+xf
         FKXg==
X-Gm-Message-State: AOAM532cDvkfH6E+FK9ALUaVh7kj+BKz5c5voHT1KjBc2uIJCoqfgIcB
        Cy2p6ZxHylCZR0GC3y+vc3Z+Zg==
X-Google-Smtp-Source: ABdhPJzwR/BF0+ziFI8DTtWNT9QEsbNkTaB+PefUWDQVc9NBTjemiqd9um3/ZkBsdhrCtLmBFqhSpw==
X-Received: by 2002:a05:6e02:1846:: with SMTP id b6mr4498813ilv.104.1644515663336;
        Thu, 10 Feb 2022 09:54:23 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p5sm7528097ilq.71.2022.02.10.09.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 09:54:22 -0800 (PST)
Subject: Re: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
To:     Sherry Yang <sherry.yang@oracle.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220202201118.13933-1-sherry.yang@oracle.com>
 <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
 <A8A651FC-37A5-4716-888B-F141E7241003@oracle.com>
 <202202031219.792E9AFF@keescook>
 <C340461A-6FD2-440A-8EFC-D7E85BF48DB5@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b908237b-63ad-ff10-8d89-540d2cab842e@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 10:54:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <C340461A-6FD2-440A-8EFC-D7E85BF48DB5@oracle.com>
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

On 2/3/22 1:46 PM, Sherry Yang wrote:
> 
>> On Feb 3, 2022, at 12:20 PM, Kees Cook <keescook@chromium.org> wrote:
>>
>> On Thu, Feb 03, 2022 at 07:40:46PM +0000, Sherry Yang wrote:
>>>> This didn't look right to me. That's outside the build tree, yes?
>>>
>>> It’s inside the build tree. “../../../../usr/include“ may look a little confusing, it’s actually linux/usr/include (linux/ is top directory of the repo we git clone), i.e. https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/usr/include?h=v5.17-rc2__;!!ACWV5N9M2RV99hQ!cP8-SXVNX-k1LuWYjfUYvCYlrOJsInLi9l7hNsqLoXiFULd7xqRS9HRF9WnTno3nBg$
>>> The file tools/testing/sefltests/Makefile can install kernel headers in default path “usr/include”. “../../../../usr/include“ is also used in other Makefile of selftests, like https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/clone3/Makefile?h=v5.17-rc2__;!!ACWV5N9M2RV99hQ!cP8-SXVNX-k1LuWYjfUYvCYlrOJsInLi9l7hNsqLoXiFULd7xqRS9HRF9WmhyH6mcQ$
>>
>> Ah-ha, thanks. Following the other example, should it just be -I instead
>> of -isystem?
> 
> In this case, “-I” works but gcc gives warnings, shown below
> 
> ———Warning Begin———
> gcc -Wl,-no-as-needed -Wall -I../../../../usr/include/  -lpthread  seccomp_bpf.c  -o /home/opc/linux/tools/testing/selftests/seccomp/seccomp_bpf
> In file included from seccomp_bpf.c:29:
> ../../../../usr/include/linux/ptrace.h:50: warning: "PTRACE_GETREGSET" redefined
>   #define PTRACE_GETREGSET 0x4204
>   
> In file included from seccomp_bpf.c:26:
> /usr/include/sys/ptrace.h:153: note: this is the location of the previous definition
>   #define PTRACE_GETREGSET PTRACE_GETREGSET

> ———Warning End———
> 
> So there is redefinition problem between glibc and kernel headers. I tried updating kernel headers, the ptrace.h installed in /usr/include/linux/ptrace.h is the same as we installed in the sandbox ../../../../usr/include/linux/ptrace.h, however, gcc doesn’t throw these warnings if we compile seccomp_bpf.c using /usr/include/linux/ptrace.h. This is because system headers will automatically suppress these warnings (refer to https://gcc.gnu.org/onlinedocs/cpp/System-Headers.html). In my opinion, it’s fair to use “-isystem”, since they're actually generated kernel headers.
> 
> Sherry

Sounds like -i works - I will queue this up for Linux 5.17-rc5.

thanks,
-- Shuah

