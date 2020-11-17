Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009572B71E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 23:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgKQW5X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 17:57:23 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:39207 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729434AbgKQW5X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 17:57:23 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kf9ub-003JCJ-Ca; Tue, 17 Nov 2020 23:57:21 +0100
Received: from p5b13ac4a.dip0.t-ipconnect.de ([91.19.172.74] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kf9ub-003Fux-5w; Tue, 17 Nov 2020 23:57:21 +0100
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kselftest@vger.kernel.org
References: <20201117205656.1000223-1-keescook@chromium.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] selftests/seccomp: sh: Fix register names
Message-ID: <a36d7b48-6598-1642-e403-0c77a86f416d@physik.fu-berlin.de>
Date:   Tue, 17 Nov 2020 23:57:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117205656.1000223-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.172.74
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/17/20 9:56 PM, Kees Cook wrote:
> It looks like the seccomp selftests were never actually built for sh.
> This fixes it, though I don't have an environment to do a runtime test
> of it yet.
> 
> Fixes: 0bb605c2c7f2b4b3 ("sh: Add SECCOMP_FILTER")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 7f7ecfcd66db..26c72f2b61b1 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1804,8 +1804,8 @@ TEST_F(TRACE_poke, getpid_runs_normally)
>  #define SYSCALL_RET(_regs)	(_regs).a[(_regs).windowbase * 4 + 2]
>  #elif defined(__sh__)
>  # define ARCH_REGS		struct pt_regs
> -# define SYSCALL_NUM(_regs)	(_regs).gpr[3]
> -# define SYSCALL_RET(_regs)	(_regs).gpr[0]
> +# define SYSCALL_NUM(_regs)	(_regs).regs[3]
> +# define SYSCALL_RET(_regs)	(_regs).regs[0]
>  #else
>  # error "Do not know how to find your architecture's registers and syscalls"
>  #endif

Yes, this fix is indeed necessary. However, there is another build issue that I ran into
and I'm not sure why it happens, but commenting out "#include <linux/sched.h>" in
../clone3/clone3_selftests.h fixes it.

root@tirpitz:..selftests/seccomp> make
gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_bpf.c /usr/src/linux-5.9.8/tools/testing/selftests/kselftest_harness.h /usr/src/linux-5.9.8/tools/testing/selftests/kselftest.h  -o /usr/src/linux-5.9.8/tools/testing/selftests/seccomp/seccomp_bpf
In file included from seccomp_bpf.c:55:
../clone3/clone3_selftests.h:28:8: error: redefinition of ‘struct clone_args’
   28 | struct clone_args {
      |        ^~~~~~~~~~
In file included from ../clone3/clone3_selftests.h:8,
                 from seccomp_bpf.c:55:
/usr/include/linux/sched.h:92:8: note: originally defined here
   92 | struct clone_args {
      |        ^~~~~~~~~~
make: *** [../lib.mk:140: /usr/src/linux-5.9.8/tools/testing/selftests/seccomp/seccomp_bpf] Error 1
root@tirpitz:..selftests/seccomp>

Your actual register naming fix is correct in any case as without your patch, building the seccomp
selftest fails with:

seccomp_bpf.c: In function ‘get_syscall’:
seccomp_bpf.c:1741:37: error: ‘struct pt_regs’ has no member named ‘gpr’; did you mean ‘pr’?
 1741 | # define SYSCALL_NUM(_regs) (_regs).gpr[3]
      |                                     ^~~
seccomp_bpf.c:1794:9: note: in expansion of macro ‘SYSCALL_NUM’
 1794 |  return SYSCALL_NUM(regs);
      |         ^~~~~~~~~~~
seccomp_bpf.c: In function ‘change_syscall’:
seccomp_bpf.c:1741:37: error: ‘struct pt_regs’ has no member named ‘gpr’; did you mean ‘pr’?
 1741 | # define SYSCALL_NUM(_regs) (_regs).gpr[3]
      |                                     ^~~
seccomp_bpf.c:1817:3: note: in expansion of macro ‘SYSCALL_NUM’
 1817 |   SYSCALL_NUM(regs) = syscall;
      |   ^~~~~~~~~~~
seccomp_bpf.c:1742:37: error: ‘struct pt_regs’ has no member named ‘gpr’; did you mean ‘pr’?
 1742 | # define SYSCALL_RET(_regs) (_regs).gpr[0]
      |                                     ^~~
seccomp_bpf.c:1859:3: note: in expansion of macro ‘SYSCALL_RET’
 1859 |   SYSCALL_RET(regs) = result;
      |   ^~~~~~~~~~~
seccomp_bpf.c: In function ‘get_syscall’:
seccomp_bpf.c:1795:1: warning: control reaches end of non-void function [-Wreturn-type]
 1795 | }
      | ^
make: *** [../lib.mk:140: /usr/src/linux-5.9.8/tools/testing/selftests/seccomp/seccomp_bpf] Error 1

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

