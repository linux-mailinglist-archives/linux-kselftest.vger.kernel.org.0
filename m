Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CA1771445
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 11:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjHFJ7D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 05:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFJ7C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 05:59:02 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 096A011D;
        Sun,  6 Aug 2023 02:59:00 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3769wk4o012323;
        Sun, 6 Aug 2023 11:58:46 +0200
Date:   Sun, 6 Aug 2023 11:58:46 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v6 06/15] tools/nolibc: __sysret: support syscalls who
 return a pointer
Message-ID: <20230806095846.GB10627@1wt.eu>
References: <cover.1688739492.git.falcon@tinylab.org>
 <11fd815773f7d202d329ac2c64cd6980b32e4fcf.1688739492.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11fd815773f7d202d329ac2c64cd6980b32e4fcf.1688739492.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Fri, Jul 07, 2023 at 10:56:59PM +0800, Zhangjin Wu wrote:
> No official reference states the errno range, here aligns with musl and
> glibc and uses [-MAX_ERRNO, -1] instead of all negative ones.
> 
> - musl: src/internal/syscall_ret.c
> - glibc: sysdeps/unix/sysv/linux/sysdep.h
> 
> The MAX_ERRNO used by musl and glibc is 4095, just like the one nolibc
> defined in tools/include/nolibc/errno.h.
> 
> Suggested-by: Willy Tarreau <w@1wt.eu>
> Link: https://lore.kernel.org/lkml/ZKKdD%2Fp4UkEavru6@1wt.eu/
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> Link: https://lore.kernel.org/linux-riscv/94dd5170929f454fbc0a10a2eb3b108d@AcuMS.aculab.com/
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/sys.h | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 53bc3ad6593e..3479f54d7957 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -28,13 +28,20 @@
>  #include "errno.h"
>  #include "types.h"
>  
> -/* Syscall return helper, set errno as -ret when ret < 0 */
> +
> +/* Syscall return helper for library routines, set errno as -ret when ret is in
> + * range of [-MAX_ERRNO, -1]
> + *
> + * Note, No official reference states the errno range here aligns with musl
> + * (src/internal/syscall_ret.c) and glibc (sysdeps/unix/sysv/linux/sysdep.h)
> + */
> +
>  static __inline__ __attribute__((unused, always_inline))
> -long __sysret(long ret)
> +long __sysret(unsigned long ret)
>  {
> -	if (ret < 0) {
> -		SET_ERRNO(-ret);
> -		ret = -1;
> +	if (ret >= (unsigned long)-MAX_ERRNO) {
> +		SET_ERRNO(-(long)ret);
> +		return -1;
>  	}
>  	return ret;
>  }

While running some regression tests, I found that my programs increased
in size by 3-4% overall, which was solely attributed to this helper that
significantly increased the size of many syscalls (particularly those
returning ints). Let's consider this simple function:

  void unlink_exit(const char *name)
  {
        int ret = unlink(name);
        exit(ret < 0 ? errno : 0);
  }

Before:
  $ nm --size unlink.o | grep unli
  0000000000000030 T unlink_exit

  $ objdump -d -j .text --disassemble=unlink_exit unlink.o
  000000000000003b <unlink_exit>:
    3b:   48 89 fe                mov    %rdi,%rsi
    3e:   b8 07 01 00 00          mov    $0x107,%eax
    43:   31 d2                   xor    %edx,%edx
    45:   48 c7 c7 9c ff ff ff    mov    $0xffffffffffffff9c,%rdi
    4c:   0f 05                   syscall 
    4e:   31 ff                   xor    %edi,%edi
    50:   85 c0                   test   %eax,%eax
    52:   79 0a                   jns    5e <unlink_exit+0x23>
    54:   89 c7                   mov    %eax,%edi
    56:   f7 df                   neg    %edi
    58:   89 3d 00 00 00 00       mov    %edi,0x0(%rip)        # 5e <unlink_exit+0x23>
    5e:   b8 3c 00 00 00          mov    $0x3c,%eax
    63:   40 0f b6 ff             movzbl %dil,%edi
    67:   0f 05                   syscall 
    69:   eb fe                   jmp    69 <unlink_exit+0x2e>

After:
  $ nm --size unlink.o | grep unli
  0000000000000042 T unlink_exit

  $ objdump -d -j .text --disassemble=unlink_exit unlink.o
  0000000000000051 <unlink_exit>:
    51:   48 89 fe                mov    %rdi,%rsi
    54:   b8 07 01 00 00          mov    $0x107,%eax
    59:   31 d2                   xor    %edx,%edx
    5b:   48 c7 c7 9c ff ff ff    mov    $0xffffffffffffff9c,%rdi
    62:   0f 05                   syscall 
    64:   48 63 d0                movslq %eax,%rdx
    67:   48 81 fa 00 f0 ff ff    cmp    $0xfffffffffffff000,%rdx
    6e:   76 0a                   jbe    7a <unlink_exit+0x29>
    70:   f7 da                   neg    %edx
    72:   89 15 00 00 00 00       mov    %edx,0x0(%rip)        # 78 <unlink_exit+0x27>
    78:   eb 06                   jmp    80 <unlink_exit+0x2f>
    7a:   31 ff                   xor    %edi,%edi
    7c:   85 c0                   test   %eax,%eax
    7e:   79 06                   jns    86 <unlink_exit+0x35>
    80:   8b 3d 00 00 00 00       mov    0x0(%rip),%edi        # 86 <unlink_exit+0x35>
    86:   b8 3c 00 00 00          mov    $0x3c,%eax
    8b:   40 0f b6 ff             movzbl %dil,%edi
    8f:   0f 05                   syscall 
    91:   eb fe                   jmp    91 <unlink_exit+0x40>

=> that's 18 bytes added to retrieve the result of a syscall.

There are several reasons involved:
  - the "unsigned long" argument to __sysret() forces a sign extension
    from all sys_* functions that used to return int (the movslq above).

  - the comparison with the error range now has to be performed on a
    long instead of an int

  - the return value from __sysret() is a long (note, a signed long)
    which then has to be turned back to an int before being returned
    by the caller to satisfy the caller's prototype.

I could recover a part of it by replacing the __sysret() function with
a macro that preserves the input type and avoids these useless
conversions:

  #define __sysret(arg) ({ \
		typeof(arg) __sysret_arg = (arg);				\
		if ((unsigned long)__sysret_arg >= (unsigned long)-MAX_ERRNO) { \
			SET_ERRNO(-(int)__sysret_arg);				\
			__sysret_arg = -1L;					\
		}								\
		__sysret_arg;							\
	  })

But the remaining part is the comparison to -MAX_ERRNO inflicted on all
integer returns where we could previously keep a simple sign comparison:

    51:   48 89 fe                mov    %rdi,%rsi
    54:   b8 07 01 00 00          mov    $0x107,%eax
    59:   31 d2                   xor    %edx,%edx
    5b:   48 c7 c7 9c ff ff ff    mov    $0xffffffffffffff9c,%rdi
    62:   0f 05                   syscall 
    64:   3d 00 f0 ff ff          cmp    $0xfffff000,%eax
    69:   76 0a                   jbe    75 <unlink_exit+0x24>
    6b:   f7 d8                   neg    %eax
    6d:   89 05 00 00 00 00       mov    %eax,0x0(%rip)        # 73 <unlink_exit+0x22>
    73:   eb 06                   jmp    7b <unlink_exit+0x2a>
    75:   31 ff                   xor    %edi,%edi
    77:   85 c0                   test   %eax,%eax
    79:   79 06                   jns    81 <unlink_exit+0x30>
    7b:   8b 3d 00 00 00 00       mov    0x0(%rip),%edi        # 81 <unlink_exit+0x30>
    81:   b8 3c 00 00 00          mov    $0x3c,%eax
    86:   40 0f b6 ff             movzbl %dil,%edi
    8a:   0f 05                   syscall 
    8c:   eb fe                   jmp    8c <unlink_exit+0x3b>

And given that the vast majority of the syscalls return integers, I think
we should specialize these sysret functions so that we don't add needless
complexity for all those for which we know they're returning ints (it's
written in the caller's prototype anyway). I.e. we can have __sysret_int()
that is the low-overhead version and keep __sysret() the expensive one
doing the comparison (and possibly through the macro like above if needed
in order to avoid multiple casts).

I'm not going to change all that now, that's too late, but I'm a bit sad
to see my binaries inflate just because of this, so I hope we can get back
to this later after the current queue is flushed.

Regards,
Willy
