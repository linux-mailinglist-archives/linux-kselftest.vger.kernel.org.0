Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B07AF561
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 22:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjIZUjh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 16:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjIZUjh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 16:39:37 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8BA11D
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 13:39:29 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-77dcff76e35so91628039f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 13:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695760769; x=1696365569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4itLyJE7Z8JfcB/+4kI9MY4phkDcuyoRTUlwxY85lCs=;
        b=O3/vlNOOI4kd2O/aG+G/S83J0WrYa0ppfpDsCrxlj8nAhMHTaUsKl10uVmA336CFwW
         vPnvQOyvyH6F6Nw2qCOoXy6ZdIL351uX0WQsIdq1QxuJcQzPxP1FzMaxc4LEqLiVD/Cp
         OY/XqdblLQ18uSAfdUU+EJlAruNwS0bUV1ZNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695760769; x=1696365569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4itLyJE7Z8JfcB/+4kI9MY4phkDcuyoRTUlwxY85lCs=;
        b=jdvScFURh/p02WMGumu59F7M7cP06gefE0gQARWUZesoh1bOteINmSzQXydkpt9WKg
         Mmpkw9/ddz+o1ZbOEf8t0Ix/tADRpYE7na1QhlyYTQtaOURpOaU7K/t54f1HItVCPO9h
         hXOdRtkxK6klwfg5KcqCT/F1qlVK2r08SWWZDf/9fu87ysQfupUpn3gJz3K5UTLkheBj
         NaH4YKJYDkXhWg+ftbnXqsxl5IIS6UtMa8iCJCBc42GOAvMazX8A8ppPIjkVCWfnIhkW
         1w4OdAxqyK7iUyMy+7S1rtJTl7dHUkl+aVszRQdYwzMoBSXOAXxf4WF3aJsESYDFVaeh
         K5ww==
X-Gm-Message-State: AOJu0YwcvsDiokJUQML3mnZCTzCAn435cNdAMtfr+1voJ7p5N7SfsF3s
        FZkw9NKh1f6FFprjHg9jt/kmmA==
X-Google-Smtp-Source: AGHT+IEqzEqSw0ZWhyREwjYY6mijjnwRBFBsNEXNhhBHdykUk4Sz+a6d3vEhXqu6krETVTustZ6gGg==
X-Received: by 2002:a6b:5d1d:0:b0:790:958e:a667 with SMTP id r29-20020a6b5d1d000000b00790958ea667mr10265245iob.2.1695760768958;
        Tue, 26 Sep 2023 13:39:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g17-20020a0566380bd100b00437a3c128dfsm3671118jad.108.2023.09.26.13.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 13:39:28 -0700 (PDT)
Message-ID: <63dd7222-99dc-8e11-3a51-b132e4115ac5@linuxfoundation.org>
Date:   Tue, 26 Sep 2023 14:39:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] selftests/rseq: fix kselftest Clang build warnings
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Justin Stitt <justinstitt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20230912-kselftest-param_test-c-v1-1-80a6cffc7374@google.com>
 <CAFhGd8on9_DJUZqT5uKgPzOtJNn99sY3TprcPzD5pm3GmYx8oQ@mail.gmail.com>
 <eabe9db0-c934-af2d-e5a9-9d644593851c@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <eabe9db0-c934-af2d-e5a9-9d644593851c@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/26/23 13:02, Mathieu Desnoyers wrote:
> On 9/26/23 08:20, Justin Stitt wrote:
>> Ping.
>>
>> Looking to get this patch and [1] slated for 6.7 which fixes some
>> kselftest builds on older kernels.
>>
>> On Wed, Sep 13, 2023 at 6:03 AM Justin Stitt <justinstitt@google.com> wrote:
>>>
>>> When building with Clang, I am getting many warnings from the selftests/rseq tree.
>>>
>>> Here's one such example from rseq tree:
>>> |  param_test.c:1234:10: error: address argument to atomic operation must be a pointer to _Atomic type ('intptr_t *' (aka 'long *') invalid)
>>> |   1234 |         while (!atomic_load(&args->percpu_list_ptr)) {}
>>> |        |                 ^           ~~~~~~~~~~~~~~~~~~~~~~
>>> |  /usr/local/google/home/justinstitt/repos/tc-build/build/llvm/final/lib/clang/18/include/stdatomic.h:140:29: note: expanded from macro 'atomic_load'
>>> |    140 | #define atomic_load(object) __c11_atomic_load(object, __ATOMIC_SEQ_CST)
>>> |        |                             ^                 ~~~~~~
>>>
>>> Use compiler builtins `__atomic_load_n()` and `__atomic_store_n()` with
>>> accompanying __ATOMIC_ACQUIRE and __ATOMIC_RELEASE, respectively. This
>>> will fix the warnings because the compiler builtins do not expect their
>>> arguments to have _Atomic type. This should also make TSAN happier.
>>>
>>> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
>>> Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/61
>>> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Peter, should this go through tip ?
> 
> Shuah, should to go through selftests ?
> 

I can take this through selftests and apply it - hoping there
are no conflicts with what's in Peter's tree.

thanks,
-- Shuah

