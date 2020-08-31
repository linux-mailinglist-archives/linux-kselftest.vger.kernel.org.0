Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D8A2583C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 23:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgHaVrU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 17:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgHaVrT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 17:47:19 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7A7C061573
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 14:47:19 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w3so2506189ilh.5
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 14:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qvz/CMJG9nHfpZS80MxVIQpGJna6lnztPKG1hZSN3NY=;
        b=PHJwMJHijFYAekG54vhbkWa4+b3SegE+3IJp4IP903Ke7WI6w5X4CgzSA1cl0PMOBi
         0FcF9Y1W9dCjqBc7R/KUaD+tNiJ+GDLBlumv8c5TL15KqyDckJQPVtZ3tPuJs1WkgX5y
         JFI0HxEOFV9gtQTG35V7TyI5aTywUiBwNK4fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qvz/CMJG9nHfpZS80MxVIQpGJna6lnztPKG1hZSN3NY=;
        b=NqjWYzOH7W31Frdq3cl2xtcN/MzAZwRR4PolZvt/8NLXOt+kF6CaJT+Ut2TV8Ka83B
         JaBAkONQl0xH4QN5b2fmR7DaAcbmSUYG7trH4Z9BKqxOSrIfJaqviE5bXcfd8/VRiC2/
         h4Vm3nGKf4iBVd1g2yrxOdZ3UGJNP/S3mvKwkuJgaAg/Ua/O0m2lqYx7qoXqsn5EivZI
         IJtxeO2DQcCUsq0iYpcAoJZlTkyonK+JsCv9esnhwb+TAfw4Qf7K3HolnMFmSrO94M3j
         w0GVfH16ifr8YCrnzngmpApHY9UMj9ywzjVIfTEAuLDofcIB+nOmgczhrYvkUWVvytgc
         yqbQ==
X-Gm-Message-State: AOAM530PJ+7Bg8k31Wut5kEobteQG5dGlvTeqxBY4oh4cW7hGnSCN0Co
        Kfm6L6yUkY7sjkT/L0uY5JHJPQ==
X-Google-Smtp-Source: ABdhPJy1Q3XmzIjTF+EDlFRykZhvKRG/Z3ESnsl75oOdm2JRjF2KzjD/RySQX8tSyvFbiInBiHDJWg==
X-Received: by 2002:a92:4f:: with SMTP id 76mr2978653ila.11.1598910438274;
        Mon, 31 Aug 2020 14:47:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i73sm2986454ild.61.2020.08.31.14.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 14:47:17 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] arm64: vdso: getcpu() support
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20200819121318.52158-1-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <315d97af-715a-9942-a731-11de2fbbbded@linuxfoundation.org>
Date:   Mon, 31 Aug 2020 15:47:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819121318.52158-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/19/20 6:13 AM, Mark Brown wrote:
> Some applications, especially tracing ones, benefit from avoiding the
> syscall overhead for getcpu() so it is common for architectures to have
> vDSO implementations. Add one for arm64, using TPIDRRO_EL0 to pass a
> pointer to per-CPU data rather than just store the immediate value in
> order to allow for future extensibility.
> 
> It is questionable if something TPIDRRO_EL0 based is worthwhile at all
> on current kernels, since v4.18 we have had support for restartable
> sequences which can be used to provide a sched_getcpu() implementation
> with generally better performance than the vDSO approach on
> architectures which have that[1]. Work is ongoing to implement this for
> glibc:
> 
>      https://lore.kernel.org/lkml/20200527185130.5604-3-mathieu.desnoyers@efficios.com/
> 
> but is not yet merged and will need similar work for other userspaces.
> The main advantages for the vDSO implementation are the node parameter
> (though this is a static mapping to CPU number so could be looked up
> separately when processing data if it's needed, it shouldn't need to be
> in the hot path) and ease of implementation for users.
> 
> This is currently not compatible with KPTI due to the use of TPIDRRO_EL0
> by the KPTI trampoline, this could be addressed by reinitializing that
> system register in the return path but I have found it hard to justify
> adding that overhead for all users for something that is essentially a
> profiling optimization which is likely to get superceeded by a more
> modern implementation - if there are other uses for the per-CPU data
> then the balance might change here.
> 
> This builds on work done by Kristina Martsenko some time ago but is a
> new implementation.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7822b1e24f2df5df98c76f0e94a5416349ff759
> 
> v3:
>   - Rebase on v5.9-rc1.
>   - Drop in progress portions of the series.
> v2:
>   - Rebase on v5.8-rc3.
>   - Add further cleanup patches & a first draft of multi-page support.
> 
> Mark Brown (5):
>    arm64: vdso: Provide a define when building the vDSO
>    arm64: vdso: Add per-CPU data
>    arm64: vdso: Initialise the per-CPU vDSO data
>    arm64: vdso: Add getcpu() implementation
>    selftests: vdso: Support arm64 in getcpu() test
> 
>   arch/arm64/include/asm/processor.h            | 12 +----
>   arch/arm64/include/asm/vdso/datapage.h        | 54 +++++++++++++++++++
>   arch/arm64/kernel/process.c                   | 26 ++++++++-
>   arch/arm64/kernel/vdso.c                      | 33 +++++++++++-
>   arch/arm64/kernel/vdso/Makefile               |  4 +-
>   arch/arm64/kernel/vdso/vdso.lds.S             |  1 +
>   arch/arm64/kernel/vdso/vgetcpu.c              | 48 +++++++++++++++++
>   .../testing/selftests/vDSO/vdso_test_getcpu.c | 10 ++++
>   8 files changed, 172 insertions(+), 16 deletions(-)
>   create mode 100644 arch/arm64/include/asm/vdso/datapage.h
>   create mode 100644 arch/arm64/kernel/vdso/vgetcpu.c
> 

Patches look good to me from selftests perspective. My acked by
for these patches to go through arm64.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

If you would like me to take these through kselftest tree, give
me your Acks. I can queue these up for 5.10-rc1

thanks,
-- Shuah
