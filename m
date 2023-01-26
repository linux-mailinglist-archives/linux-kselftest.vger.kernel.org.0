Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6EF67D5F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 21:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjAZUJB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 15:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjAZUIu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 15:08:50 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A747166B;
        Thu, 26 Jan 2023 12:08:43 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 5FF2082F37;
        Thu, 26 Jan 2023 20:08:37 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674763722;
        bh=2uK4PjvwK03HI9Z+rE8QjRWxVNSJBr+QdWaWqL0x9cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9aZGjdfHpodIG9EaE0S7ixL3e/iR4Hr+sYIC1sUq4qzwhhjDmj0pG32tpGRNfoOv
         Wg8yaXBchbgTmPx6/ur8qr6g5HsOBFEca/beD3gGIVscG035d6rFZDWldJFWMPdU3x
         ypP+R45NYS+7QGDOp2zzXuLC3W1vm6UxCrwRDdRErvuA1U62fGgN/DUXVd/NHg3gvv
         wO4dqMVGVMlMAZ/40uVuPGmm1RTgj3WC7OPPdheclkiUpHypXD5eV7lN+T3UBVskFQ
         M3vfF4ZfWiyMWKmegqPs6oZMfRSVIf7OYiLW5JoO1H0+oTk0ozQBSDNdzl1hrigdlE
         Z7+ZiAHD7mEMw==
Date:   Fri, 27 Jan 2023 03:08:33 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/2] selftests/x86: sysret_rip: Handle syscall in
 a FRED system
Message-ID: <Y9LdwVX9BaZA7zmA@biznet-home.integral.gnuweeb.org>
References: <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com>
 <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org>
 <509443c8-e0fd-935f-63d8-7264f5dd3c05@zytor.com>
 <20230124002625.581323-1-ammarfaizi2@gnuweeb.org>
 <20230124002625.581323-2-ammarfaizi2@gnuweeb.org>
 <8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 05:40:23PM -0800, H. Peter Anvin wrote:
> So as per Andrew's comment, add:
> 
> register void * rsp asm("%rsp");
> 
> ...
> 
> "+r" (rsp)	/* clobber the redzone */
> 
> ... as the right way to avoid redzone problems.

I played with this more. I found something wrong with this. This doesn't
work for me. The compiler still uses red zone despite I use "+r" (rsp).

What did I do wrong?

-----

ammarfaizi2@integral2:/tmp$ gcc -fno-stack-protector -O2 -Wall -Wextra test.c -o test
ammarfaizi2@integral2:/tmp$ objdump --no-show-raw-insn -d test | grep "a_leaf_func_with_red_zone>:" -A8
0000000000001180 <a_leaf_func_with_red_zone>:
    1180:  endbr64 
    1184:  mov    $0x1,%eax
    1189:  mov    %rax,-0x8(%rsp)   ## BUG!!!
    118e:  pushf  
    118f:  pop    %rax
    1190:  mov    -0x8(%rsp),%rax   ## BUG!!!
    1195:  ret


ammarfaizi2@integral2:/tmp$ clang -O2 -Wall -Wextra test.c -o test
ammarfaizi2@integral2:/tmp$ objdump --no-show-raw-insn -d test | grep "a_leaf_func_with_red_zone>:" -A6
0000000000001140 <a_leaf_func_with_red_zone>:
    1140:  mov    $0x1,%eax
    1145:  mov    %rax,-0x8(%rsp)   ## BUG!!!
    114a:  pushf  
    114b:  pop    %rax
    114c:  mov    -0x8(%rsp),%rax   ## BUG!!!
    1151:  ret


-----
ammarfaizi2@integral2:~$ gcc --version
gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

ammarfaizi2@integral2:~$ clang --version
Ubuntu clang version 16.0.0 (++20230124031324+d63e492562f2-1~exp1~20230124151444.705)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin


-----
test.c:

#include <stdio.h>
static inline void clobber_redzone(void)
{
        register void *rsp __asm__("%rsp");
        unsigned long rflags;

        __asm__ volatile ("pushf; popq %1"
                          : "+r" (rsp), "=r" (rflags));
}

static inline void set_red_zone(long *mem, long val)
{
        __asm__ volatile ("movq %[val], %[mem]"
                           : [mem] "=m" (*mem)
                           : [val] "r" (val));
}

static inline long get_red_zone(long *mem)
{
        long ret;

        __asm__ volatile ("movq %[in], %[out]"
                           : [out] "=r" (ret)
                           : [in] "m" (*mem));
        return ret;
}

__attribute__((__noinline__))
long a_leaf_func_with_red_zone(void)
{
        long x;

        set_red_zone(&x, 1);
        clobber_redzone();
        /* The correct retval is 1 */
        return get_red_zone(&x);
}

int main(void)
{
        printf("ret = %ld\n", a_leaf_func_with_red_zone());
        return 0;
}

-- 
Ammar Faizi

