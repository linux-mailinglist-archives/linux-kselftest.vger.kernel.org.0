Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA511E889F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 22:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgE2UKO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 16:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgE2UKN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 16:10:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5AFC03E969
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 13:10:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k2so1979463pjs.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7qHvXfcLPRZW70K7Ww/JQ6soXN2aoKEcSnKsZaACQ8=;
        b=rA1iDF4cxWswt0lv0uHlY+uj0PwqyydW9Hl5I7McjaeNHZJKz0ZygAaboXj/U2ht30
         y2ULlnvIxq6MDVNsTjDkNOFjR1JSA5d5SBfoPXABzylMSTthpT7+q9N3HPGz9PgPwGyZ
         CQoPKryj/6EDRYpQB9Cpf11oPsTZ3w7wERmEPav8OzvOOGmxzdorJMEixMoE+CPh9pkz
         syG6gr+MXyy0Da16pEbd8wlay8tQs0K781mdz01Vdv6/cw4tDvJjzoR6HBCpESBy8O91
         Sy8MKKumihPyI7/7J9ZaDHgIuuWMV6AfmKVUM1Sjf/Skt15oJXKdfCFhBSDnn99tyaZZ
         FPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7qHvXfcLPRZW70K7Ww/JQ6soXN2aoKEcSnKsZaACQ8=;
        b=oZn4XyIL64IsLnnVxKAQq6Bqja8bXQ5AMaZg+lx5EtNHn/c1gI9AXlUPnw0ZXJmeXB
         GA6TA7Lv8g0Ifi6uaxNlfyZ6KvS4cEFLHReX0rE7PbQ4KMmVFfOsBURNq5SsruEYYkKK
         9+anRPtQyA+Csrg92LsnRfiEU/ZJ9hj6hZMvWkrVl8ABcztdhMgFPcso9aTDBLm+E32s
         T8o3LcxasBOiHfHdm8b+w6PZqcO4XD6rAttS/U+nKHFN3O3qg9H9gqPONFWTV9phf6Qu
         XRK1jJtAy8BNCgjKul2WcNSjoDuL4SpnvsGNdjwBqTfeyyY1Mup+4pbpGF5vVVdv7bgA
         V/6g==
X-Gm-Message-State: AOAM532S0yHqdSFH8DCPTVPPNZhQ4SMGzxvH+Se/cIBu4UjeLaLMkgsr
        mlYdspTpauY2Bc25H8fF9/Ax91wZBOJkl6upnzJPsA==
X-Google-Smtp-Source: ABdhPJy30fvJvxwOhhkKSQc9ffBy+TdLVAL9sT6NZV9vZ2l2Hs9OoasuCB9wOwp5cBkDAKJV8S4bHPrLYKexH5C/g/g=
X-Received: by 2002:a17:90a:4e8c:: with SMTP id o12mr10331146pjh.25.1590783012476;
 Fri, 29 May 2020 13:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200529200347.2464284-1-keescook@chromium.org> <20200529200347.2464284-2-keescook@chromium.org>
In-Reply-To: <20200529200347.2464284-2-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 May 2020 13:10:01 -0700
Message-ID: <CAKwvOdn_gFaBbvdMDu9WuuzOyjZXxv4kJMGdO-71r-0Nz0wi5Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] lkdtm: Avoid more compiler optimizations for bad writes
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 29, 2020 at 1:03 PM Kees Cook <keescook@chromium.org> wrote:
>
> It seems at least Clang is able to throw away writes it knows are
> destined for read-only memory, which makes things like the WRITE_RO test
> fail, as the write gets elided. Instead, force the variable to be

Heh, yep.  I recall the exact patch in LLVM causing build breakages
for kernels and various parts of Android userspace within the past
year, for code that tried to write to variables declared const through
casts that removed the const. (Was the last patch for us to build MIPS
IIRC).  Doing so is explicitly UB.  I did feel that that particular
"optimization" was very specific to C/C++, and should not have been
performed in LLVM (which should be more agnostic to the front end
language's wacky rules, IMO) but rather Clang (which doesn't do much
C/C++ language specific optimizations currently, though there are
rough plans forming to change that).

> volatile, and make similar changes through-out other tests in an effort
> to avoid needing to repeat fixing these kinds of problems. Also includes
> pr_err() calls in failure paths so that kernel logs are more clear in
> the failure case.
>
> Reported-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/misc/lkdtm/bugs.c     | 11 +++++------
>  drivers/misc/lkdtm/perms.c    | 22 +++++++++++++++-------
>  drivers/misc/lkdtm/usercopy.c |  7 +++++--
>  3 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 886459e0ddd9..e1b43f615549 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -118,9 +118,8 @@ noinline void lkdtm_CORRUPT_STACK(void)
>         /* Use default char array length that triggers stack protection. */
>         char data[8] __aligned(sizeof(void *));
>
> -       __lkdtm_CORRUPT_STACK(&data);
> -
> -       pr_info("Corrupted stack containing char array ...\n");
> +       pr_info("Corrupting stack containing char array ...\n");
> +       __lkdtm_CORRUPT_STACK((void *)&data);
>  }
>
>  /* Same as above but will only get a canary with -fstack-protector-strong */
> @@ -131,9 +130,8 @@ noinline void lkdtm_CORRUPT_STACK_STRONG(void)
>                 unsigned long *ptr;
>         } data __aligned(sizeof(void *));
>
> -       __lkdtm_CORRUPT_STACK(&data);
> -
> -       pr_info("Corrupted stack containing union ...\n");
> +       pr_info("Corrupting stack containing union ...\n");
> +       __lkdtm_CORRUPT_STACK((void *)&data);
>  }
>
>  void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
> @@ -248,6 +246,7 @@ void lkdtm_ARRAY_BOUNDS(void)
>
>         kfree(not_checked);
>         kfree(checked);
> +       pr_err("FAIL: survived array bounds overflow!\n");
>  }
>
>  void lkdtm_CORRUPT_LIST_ADD(void)
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 62f76d506f04..2dede2ef658f 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -57,6 +57,7 @@ static noinline void execute_location(void *dst, bool write)
>         }
>         pr_info("attempting bad execution at %px\n", func);
>         func();
> +       pr_err("FAIL: func returned\n");
>  }
>
>  static void execute_user_location(void *dst)
> @@ -75,20 +76,22 @@ static void execute_user_location(void *dst)
>                 return;
>         pr_info("attempting bad execution at %px\n", func);
>         func();
> +       pr_err("FAIL: func returned\n");
>  }
>
>  void lkdtm_WRITE_RO(void)
>  {
> -       /* Explicitly cast away "const" for the test. */
> -       unsigned long *ptr = (unsigned long *)&rodata;
> +       /* Explicitly cast away "const" for the test and make volatile. */
> +       volatile unsigned long *ptr = (unsigned long *)&rodata;
>
>         pr_info("attempting bad rodata write at %px\n", ptr);
>         *ptr ^= 0xabcd1234;
> +       pr_err("FAIL: survived bad write\n");
>  }
>
>  void lkdtm_WRITE_RO_AFTER_INIT(void)
>  {
> -       unsigned long *ptr = &ro_after_init;
> +       volatile unsigned long *ptr = &ro_after_init;
>
>         /*
>          * Verify we were written to during init. Since an Oops
> @@ -102,19 +105,21 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
>
>         pr_info("attempting bad ro_after_init write at %px\n", ptr);
>         *ptr ^= 0xabcd1234;
> +       pr_err("FAIL: survived bad write\n");
>  }
>
>  void lkdtm_WRITE_KERN(void)
>  {
>         size_t size;
> -       unsigned char *ptr;
> +       volatile unsigned char *ptr;
>
>         size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
>         ptr = (unsigned char *)do_overwritten;
>
>         pr_info("attempting bad %zu byte write at %px\n", size, ptr);
> -       memcpy(ptr, (unsigned char *)do_nothing, size);
> +       memcpy((void *)ptr, (unsigned char *)do_nothing, size);
>         flush_icache_range((unsigned long)ptr, (unsigned long)(ptr + size));
> +       pr_err("FAIL: survived bad write\n");
>
>         do_overwritten();
>  }
> @@ -193,9 +198,11 @@ void lkdtm_ACCESS_USERSPACE(void)
>         pr_info("attempting bad read at %px\n", ptr);
>         tmp = *ptr;
>         tmp += 0xc0dec0de;
> +       pr_err("FAIL: survived bad read\n");
>
>         pr_info("attempting bad write at %px\n", ptr);
>         *ptr = tmp;
> +       pr_err("FAIL: survived bad write\n");
>
>         vm_munmap(user_addr, PAGE_SIZE);
>  }
> @@ -203,19 +210,20 @@ void lkdtm_ACCESS_USERSPACE(void)
>  void lkdtm_ACCESS_NULL(void)
>  {
>         unsigned long tmp;
> -       unsigned long *ptr = (unsigned long *)NULL;
> +       volatile unsigned long *ptr = (unsigned long *)NULL;
>
>         pr_info("attempting bad read at %px\n", ptr);
>         tmp = *ptr;
>         tmp += 0xc0dec0de;
> +       pr_err("FAIL: survived bad read\n");
>
>         pr_info("attempting bad write at %px\n", ptr);
>         *ptr = tmp;
> +       pr_err("FAIL: survived bad write\n");
>  }
>
>  void __init lkdtm_perms_init(void)
>  {
>         /* Make sure we can write to __ro_after_init values during __init */
>         ro_after_init |= 0xAA;
> -
>  }
> diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
> index e172719dd86d..b833367a45d0 100644
> --- a/drivers/misc/lkdtm/usercopy.c
> +++ b/drivers/misc/lkdtm/usercopy.c
> @@ -304,19 +304,22 @@ void lkdtm_USERCOPY_KERNEL(void)
>                 return;
>         }
>
> -       pr_info("attempting good copy_to_user from kernel rodata\n");
> +       pr_info("attempting good copy_to_user from kernel rodata: %px\n",
> +               test_text);
>         if (copy_to_user((void __user *)user_addr, test_text,
>                          unconst + sizeof(test_text))) {
>                 pr_warn("copy_to_user failed unexpectedly?!\n");
>                 goto free_user;
>         }
>
> -       pr_info("attempting bad copy_to_user from kernel text\n");
> +       pr_info("attempting bad copy_to_user from kernel text: %px\n",
> +               vm_mmap);
>         if (copy_to_user((void __user *)user_addr, vm_mmap,
>                          unconst + PAGE_SIZE)) {
>                 pr_warn("copy_to_user failed, but lacked Oops\n");
>                 goto free_user;
>         }
> +       pr_err("FAIL: survived bad copy_to_user()\n");
>
>  free_user:
>         vm_munmap(user_addr, PAGE_SIZE);
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200529200347.2464284-2-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
