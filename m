Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5EC624462
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 15:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKJOeM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 09:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiKJOeL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 09:34:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CCBFDD
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 06:34:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so2496819wrb.13
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 06:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFkJvxzDyOD+/g4BqrG+EdNY7BBRWgxbD/xVAB1He3Y=;
        b=pXS6F2+ZpLbrs9x2zrEtCa9vpJLRzCrUpxOrepE3+zqpqWJWqYCgORRklE47sTAce8
         AiMgQRHSRueP/KSqhE5JIrCH9gFP8CCCbpAv5QJOKOUcgakhGTFyyZ1BcMtti7+JYWk2
         fDFdYy6Or5LyXJq+jPE7QksHvM3I1N6LFC8gpvi72JmZxvTmFDh49lD8v+bSSZEao/J+
         QLpOUFKG2ik3AmF61TEn1i2rCpU+s0S2JOMgZ4+fAnQkO9sGDvQbawbd2i4Wxx4GUCt5
         cIYhPPVpHMASGDHN88brICjcjnWSlx1gaOJYcA4KD/OYc3dVBxoUhx8iV4YEe/7zLgXx
         uLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFkJvxzDyOD+/g4BqrG+EdNY7BBRWgxbD/xVAB1He3Y=;
        b=w2MyWyx0RR/nQnmBFdvSvxt6TOC3+HyV5HDmfzW3jYSWV6cGn+0gk2F8bj7VZkusO+
         OElnyAJq2znBiJWBuUheEuyq8bMZZugDczd/irKeTkv4X3/X5jETxbHdXiSfmJCsJ76S
         SEfm5xsbeyv/7fCPOnsP3VqQqZ+FUBvd9umAD+aSvC6udk73f4wY0LCGMgW/ZRo3hiVc
         xJtUyZVWUo9fuct9CVL+FRzXdTKlo+F2VP4qGxCFZuonV9+AGipoq8JtkZrRb+DXObbR
         BvmpO450W/uhSKoGZJkQVLqoVHnGeCuEUSubzsDJtZFHpGxTeO1INGmNBOkGEeulk0EV
         ujCQ==
X-Gm-Message-State: ACrzQf0zgfFhyfT/tZ7aUiNB2kn0+K/cc3plNC6XNodeHTVBKvDJFUwC
        vnymEYCno74XryibdYnNPcIfRw==
X-Google-Smtp-Source: AMsMyM7dCWg8TonEZqnjcJKIcaSNz+ZbAC5sH2YRN4ytwIMarla1ANqQ6QffOhSgQekipZYBEfOt+A==
X-Received: by 2002:adf:d1ec:0:b0:236:880f:2adf with SMTP id g12-20020adfd1ec000000b00236880f2adfmr42221342wrd.617.1668090848473;
        Thu, 10 Nov 2022 06:34:08 -0800 (PST)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c468900b003cf75213bb9sm5648477wmo.8.2022.11.10.06.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:34:07 -0800 (PST)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>, shuah@kernel.org,
        adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2 1/2] selftests: proc: Fix
 proc-empty-vm build error on non x86_64
References: <20221109221104.1797802-1-punit.agrawal@bytedance.com>
        <20221109160243.0db030ca1cbae5f180af3855@linux-foundation.org>
Date:   Thu, 10 Nov 2022 14:34:07 +0000
In-Reply-To: <20221109160243.0db030ca1cbae5f180af3855@linux-foundation.org>
        (Andrew Morton's message of "Wed, 9 Nov 2022 16:02:43 -0800")
Message-ID: <8735aq280w.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andrew,

Thanks for taking a look.

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed,  9 Nov 2022 22:11:03 +0000 Punit Agrawal <punit.agrawal@bytedance.com> wrote:
>
>> The proc-empty-vm test is implemented for x86_64 and fails to build
>> for other architectures. Rather then emitting a compiler error it
>> would be preferable to only build the test on supported architectures.
>
> Why does it fail?  What would be involved in making it available
> on other architectures?

The test is written to fail building on architectures other than
x86_64.

    #ifdef __amd64__
                    munmap(NULL, ((size_t)1 << 47) - 4096);
    #else
    #error "implement 'unmap everything'"
    #endif

I hit the build failure while semi-automating the running of tests on
internal infrastructure. 

I am not familiar with the issue being tested but after a bit of
staring, it looks like there are two architecture dependent components
to the tests -

    1. TASK_SIZE / application memory layout - the test unmaps the
       entire the user virtual address space. For this, it needs to know
       the length to pass to munmap().

       Although it's possible to add this per-architecture, I am not
       sure if there is a way to discover the length passed to munmap().

    2. How the vsyscall page (if implemented) is mapped - this
       influences the known good values used for comparison in the test.

       It doesn't look like vsyscall page is used on arm64 but I am not
       sure about the situation with other architectures.

(Alexey, please add if I've missed anything)

Thanks,
Punit
