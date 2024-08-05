Return-Path: <linux-kselftest+bounces-14816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A35F9484E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 23:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728B3B2247A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 21:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89C1741DA;
	Mon,  5 Aug 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IR0gQkiL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CA16F0D2
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Aug 2024 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893390; cv=none; b=fAMkXs2NNfn8XXtRJs07GdJjBi2uW4BhxJV3zdb5w+7lopmpxAL3nNdCFN+5DsQFKRMtV221q7aDKI07kcbF8bPLzSy+rwemVh7gQkDfh40ZNHNpyZLnLPIbpRol6hcua2sIcDBIy7dg7CHgblnGC94dEFO35ikbmtAIACk86nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893390; c=relaxed/simple;
	bh=f4gATws6BsDpnv+whFd/nT2RtFoVIT7P8QJCgccSmgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnRAYDGKn5lSadaoLjUDGL/j2v4YWPFKn3WVuoDq3ElaeDIehzx0/Wptp+fmdrvJYh1HprLdzCEZNymu44SM0n+ysP/mdzCnwVfBTh5lLm3DH+RoKhYl3DOrXbfQpXJ599eQgKtCGzoGEZwLSScXMFaPU1jyU11JbLH1K8xJkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IR0gQkiL; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39b3c36d429so225195ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Aug 2024 14:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722893388; x=1723498188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77vUSIhEXolQ7LP/swg34WCGlFiT86L+fvCS5JakSjE=;
        b=IR0gQkiLIwzJeXxqZpk8+ykB5oDvFy9axQnXufnJUqqks8bPwfoqZoCElb+tRtONUM
         N3fsAyRu3bHTTjYSHOyICnpmJXEctI2PBZUnSj8MzkV+O9yxC2yA6uhX3Ut/kq6m1xBl
         N1ASuKdrrjXHiPvDf9URhJ6jfnXq7v7p/TzH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893388; x=1723498188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77vUSIhEXolQ7LP/swg34WCGlFiT86L+fvCS5JakSjE=;
        b=pD5/gyF75Xi2B8UPlLozwFk/df9n6xWCz1RH5Npxi5udxhdvRxO9J31v2vQvGZvKpq
         mYkqaeCJ2dDjDt/DQzJL29bJxgm4sMOkd8f3zIzTAErwx6nQBYqn0d7I2W+vMtPo44OJ
         bEX9WC7e044BGPr9w0HiToDPLu5m3EJSAh/j5taCo/39t/UPyCMKmJFZ1t24e03nBr2R
         BrhGz/HHX3Jrd4UI0Y2NlNn8jxw8fH1UcxngZE78cdFYj+xIi+ALYmUEmo+okIm0io3K
         fXEVhII5mChtkzj/K4q95kZWFgCUu+RUx4pz/htMJrsb/k8ltA74p7dkXMzOrJd3n2KL
         aQNw==
X-Forwarded-Encrypted: i=1; AJvYcCUp/2ki//XNx4HlFELsAmQzAplMh4Kz1tsbnvTlk88XEP2ChRGV1HgGtumZk7zsUnoknOEx4gHL/fBj8w/PsrvyYr1aIB1ahB7qictdtxyO
X-Gm-Message-State: AOJu0YwAU9X5DdSGxfMgcT9X639upvOri7ZNLtG5x+mLN2Lvj+zPV++C
	N3L29QHN31P0dwvDAPQ+34AvyDL9UDUhTGBglCAUCxGykbE9pg7orXQvcHhaayU=
X-Google-Smtp-Source: AGHT+IHaD5F3UB86KedRRHTA+tJQV3ceKsNfMpZP7mnoDYE8YjQUmsCzQ3zy37i0Pc0NnOXGdSO4eA==
X-Received: by 2002:a92:ca47:0:b0:376:3918:c50 with SMTP id e9e14a558f8ab-39b1f780a14mr81387545ab.0.1722893387639;
        Mon, 05 Aug 2024 14:29:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6987eaesm1925178173.20.2024.08.05.14.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 14:29:47 -0700 (PDT)
Message-ID: <f7ffadc4-16ed-4d11-8baf-ea2887305d18@linuxfoundation.org>
Date: Mon, 5 Aug 2024 15:29:45 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v7 0/9] fork: Support shadow stacks in clone3()
To: Mark Brown <broonie@kernel.org>,
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, jannh@google.com,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 06:14, Mark Brown wrote:
> The kernel has recently added support for shadow stacks, currently
> x86 only using their CET feature but both arm64 and RISC-V have
> equivalent features (GCS and Zicfiss respectively), I am actively
> working on GCS[1].  With shadow stacks the hardware maintains an
> additional stack containing only the return addresses for branch
> instructions which is not generally writeable by userspace and ensures
> that any returns are to the recorded addresses.  This provides some
> protection against ROP attacks and making it easier to collect call
> stacks.  These shadow stacks are allocated in the address space of the
> userspace process.
> 
> Our API for shadow stacks does not currently offer userspace any
> flexiblity for managing the allocation of shadow stacks for newly
> created threads, instead the kernel allocates a new shadow stack with
> the same size as the normal stack whenever a thread is created with the
> feature enabled.  The stacks allocated in this way are freed by the
> kernel when the thread exits or shadow stacks are disabled for the
> thread.  This lack of flexibility and control isn't ideal, in the vast
> majority of cases the shadow stack will be over allocated and the
> implicit allocation and deallocation is not consistent with other
> interfaces.  As far as I can tell the interface is done in this manner
> mainly because the shadow stack patches were in development since before
> clone3() was implemented.
> 
> Since clone3() is readily extensible let's add support for specifying a
> shadow stack when creating a new thread or process in a similar manner
> to how the normal stack is specified, keeping the current implicit
> allocation behaviour if one is not specified either with clone3() or
> through the use of clone().  The user must provide a shadow stack
> address and size, this must point to memory mapped for use as a shadow
> stackby map_shadow_stack() with a shadow stack token at the top of the
> stack.
> 
> Please note that the x86 portions of this code are build tested only, I
> don't appear to have a system that can run CET avaible to me, I have
> done testing with an integration into my pending work for GCS.  There is
> some possibility that the arm64 implementation may require the use of
> clone3() and explicit userspace allocation of shadow stacks, this is
> still under discussion.
> 
> Please further note that the token consumption done by clone3() is not
> currently implemented in an atomic fashion, Rick indicated that he would
> look into fixing this if people are OK with the implementation.
> 
> A new architecture feature Kconfig option for shadow stacks is added as
> here, this was suggested as part of the review comments for the arm64
> GCS series and since we need to detect if shadow stacks are supported it
> seemed sensible to roll it in here.
> 
> [1] https://lore.kernel.org/r/20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org/
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v7:
> - Rebase onto v6.11-rc1.
> - Typo fixes.
> - Link to v6: https://lore.kernel.org/r/20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org
> 
> Changes in v6:
> - Rebase onto v6.10-rc3.
> - Ensure we don't try to free the parent shadow stack in error paths of
>    x86 arch code.
> - Spelling fixes in userspace API document.
> - Additional cleanups and improvements to the clone3() tests to support
>    the shadow stack tests.
> - Link to v5: https://lore.kernel.org/r/20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org
> 
> Changes in v5:
> - Rebase onto v6.8-rc2.
> - Rework ABI to have the user allocate the shadow stack memory with
>    map_shadow_stack() and a token.
> - Force inlining of the x86 shadow stack enablement.
> - Move shadow stack enablement out into a shared header for reuse by
>    other tests.
> - Link to v4: https://lore.kernel.org/r/20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org
> 
> Changes in v4:
> - Formatting changes.
> - Use a define for minimum shadow stack size and move some basic
>    validation to fork.c.
> - Link to v3: https://lore.kernel.org/r/20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org
> 
> Changes in v3:
> - Rebase onto v6.7-rc2.
> - Remove stale shadow_stack in internal kargs.
> - If a shadow stack is specified unconditionally use it regardless of
>    CLONE_ parameters.
> - Force enable shadow stacks in the selftest.
> - Update changelogs for RISC-V feature rename.
> - Link to v2: https://lore.kernel.org/r/20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org
> 
> Changes in v2:
> - Rebase onto v6.7-rc1.
> - Remove ability to provide preallocated shadow stack, just specify the
>    desired size.
> - Link to v1: https://lore.kernel.org/r/20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org
> 
> ---
> Mark Brown (9):
>        Documentation: userspace-api: Add shadow stack API documentation
>        selftests: Provide helper header for shadow stack testing
>        mm: Introduce ARCH_HAS_USER_SHADOW_STACK
>        fork: Add shadow stack support to clone3()
>        selftests/clone3: Remove redundant flushes of output streams
>        selftests/clone3: Factor more of main loop into test_clone3()
>        selftests/clone3: Explicitly handle child exits due to signals
>        selftests/clone3: Allow tests to flag if -E2BIG is a valid error code
>        selftests/clone3: Test shadow stack support
> 
>   Documentation/userspace-api/index.rst             |   1 +
>   Documentation/userspace-api/shadow_stack.rst      |  41 ++++
>   arch/x86/Kconfig                                  |   1 +
>   arch/x86/include/asm/shstk.h                      |  11 +-
>   arch/x86/kernel/process.c                         |   2 +-
>   arch/x86/kernel/shstk.c                           | 104 +++++++---
>   fs/proc/task_mmu.c                                |   2 +-
>   include/linux/mm.h                                |   2 +-
>   include/linux/sched/task.h                        |  13 ++
>   include/uapi/linux/sched.h                        |  13 +-
>   kernel/fork.c                                     |  76 ++++++--
>   mm/Kconfig                                        |   6 +
>   tools/testing/selftests/clone3/clone3.c           | 224 ++++++++++++++++++----
>   tools/testing/selftests/clone3/clone3_selftests.h |  40 +++-
>   tools/testing/selftests/ksft_shstk.h              |  63 ++++++
>   15 files changed, 511 insertions(+), 88 deletions(-)
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20231019-clone3-shadow-stack-15d40d2bf536
> 
> Best regards,


For selftests:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



