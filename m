Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5A771652
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 19:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjHFRfl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 13:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHFRfk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 13:35:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0301C107;
        Sun,  6 Aug 2023 10:35:36 -0700 (PDT)
X-QQ-mid: bizesmtp84t1691343318tuni9m1q
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 07 Aug 2023 01:35:17 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: XBN7tc9DADJdp0LzmFQ4W9/XjsHtdlmMvejuqH/d5Er1Lpm1BQRlBSu9tTUQY
        pUCwURMVIGuCL4icN7qKNoYU3oyw94IHuVzg58Ii8DR20+zCb70nwa91tl0NVmdzhC+J0Pq
        GTCKMdy6mrgX22pvppDJAaYKWJFIeNRKfVXPMo0JdIN7PVbP/Dh3xs0jb5zza5iUZ6odNcK
        +sU7ENwd+MEV1lYWvTIczcLwXG13l4frI72ej1xDVwb3zS8svKDqUii0Wb/nRlniilS8StA
        4soId+KSj4ZUyA7V3mnvcA/hONzs8yWRffqJsPxOXwgWFDkIYnXw1BLZ2/H1sSYQshRZ9gr
        3oPVwPykfly+S/ZCjmv7VGHDzvU51fdrHeFhXwkm8H+xNp4PV0LfGbsrFtUMdKFEmEBMWv/
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3186474216457718583
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: [PATCH v2] tools/nolibc: fix up size inflate regression
Date:   Mon,  7 Aug 2023 01:35:12 +0800
Message-Id: <20230806173512.205928-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <95fe3e732f455fab653fe1427118d905e4d04257.1691339836.git.falcon@tinylab.org>
References: <95fe3e732f455fab653fe1427118d905e4d04257.1691339836.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> [...]
> before:
> 
>     // ppc64le
>     $ size nolibc-test
>        text	   data	    bss	    dec	    hex	filename
>       27916	      8	     80	  28004	   6d64	nolibc-test
> 
>     // mips
>     $ size nolibc-test
>        text	   data	    bss	    dec	    hex	filename
>       23276	     64	     64	  23404	   5b6c	nolibc-test
> 
> after:
> 
>     // ppc64le
>     $ size nolibc-test
>        text	   data	    bss	    dec	    hex	filename
>       27736	      8	     80	  27824	   6cb0	nolibc-test
> 
>     // mips
>     $ size nolibc-test
>        text	   data	    bss	    dec	    hex	filename
>       23036	     64	     64	  23164	   5a7c	nolibc-test
> 
> Suggested-by: Willy Tarreau <w@1wt.eu>
> Link: https://lore.kernel.org/lkml/20230806095846.GB10627@1wt.eu/
> Link: https://lore.kernel.org/lkml/20230806134348.GA19145@1wt.eu/
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
> 
> v2 here is further fix up argument with 'const' in the type and also
> support "void *" argument, v1 is [1].
> 
> Tested on many architectures (i386, x86_64, mips, ppc64) and gcc version
> (from gcc 4.8-13.1.0), compiles well without any warning and errors and
> also with smaller size.
> 
> [1]: https://lore.kernel.org/lkml/20230806131921.52453-1-falcon@tinylab.org/
> 
> ---
>  tools/include/nolibc/sys.h | 52 ++++++++++++++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 56f63eb48a1b..9c7448ae19e2 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -35,15 +35,45 @@
>   * (src/internal/syscall_ret.c) and glibc (sysdeps/unix/sysv/linux/sysdep.h)
>   */
>  
> -static __inline__ __attribute__((unused, always_inline))
> -long __sysret(unsigned long ret)
> -{
> -	if (ret >= (unsigned long)-MAX_ERRNO) {
> -		SET_ERRNO(-(long)ret);
> -		return -1;
> -	}
> -	return ret;
> -}
> +/*
> + * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
> + * bool and also pointer types. (from include/linux/compiler.h)
> + */
> +#define __is_signed_type(type) (((type)(-1)) < (type)1)
> +
> +/* __auto_type is used instead of __typeof__ to workaround the build error
> + * 'error: assignment of read-only variable' when the argument has 'const' in
> + * the type, but __auto_type is a new feature from newer version and it only
> + * work with 'const' from gcc 11.0 (__GXX_ABI_VERSION = 1016)
> + * https://gcc.gnu.org/legacy-ml/gcc-patches/2013-11/msg01378.html
> + */
> +
> +#if __GXX_ABI_VERSION < 1016
> +#define __typeofdecl(arg) long
> +#define __typeofconv1(arg) (long)
> +#define __typeofconv2(arg) (long)
> +#else
> +#define __typeofdecl(arg) __auto_type
> +#define __typeofconv1(arg)
> +#define __typeofconv2(arg) (__typeof__(arg))
> +#endif
>

With nolibc-test, we did more tests.

for ppc64le (long better):

    // __auto_type
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      27736	      8	     80	  27824	   6cb0	nolibc-test

    // long
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      27612	      8	     80	  27700	   6c34	nolibc-test

for ppc64 (long better):

    // __auto_type
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      27136	   1880	     80	  29096	   71a8	nolibc-test

    // long
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      27012	   1880	     80	  28972	   712c	nolibc-test

A further test on x86_64 (__auto_type better):

     // __auto_type
     $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      22206	      8	     88	  22302	   571e	nolibc-test

     // long
     $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      22347	      8	     88	  22443	   57ab	nolibc-test

And i386 (almost the same):

     // __auto_type
     $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      19718	      4	     52	  19774	   4d3e	nolibc-test

     // long
     $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      19717	      4	     52	  19773	   4d3d	nolibc-test

arm64 (__auto_type better):
    // __auto_type
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      25764	      8	     80	  25852	   64fc	nolibc-test

    // long
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      26004	      8	     80	  26092	   65ec	nolibc-test

arm (the same):

    // __auto_type
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      19595	      0	     52	  19647	   4cbf	nolibc-test

    // long
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      19595	      0	     52	  19647	   4cbf	nolibc-test


riscv64 (__auto_type better):

    // __auto_type
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      21814	      8	     80	  21902	   558e	nolibc-test

    // long
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      21912	      8	     80	  22000	   55f0	nolibc-test

s390 (__auto_type better):

    // __auto_type
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      22302	      0	     80	  22382	   576e	nolibc-test

    // long
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      22438	      0	     80	  22518	   57f6	nolibc-test

As a summary, in nolibc-test, for 32-bit architectures, __auto_type has the
same as long, for 64-bit architecture, __auto_type has less size than long,
only ppc64/ppc64le has reverse result.

BR,
Zhangjin

> +#define __sysret(arg)                                                           \
> +({                                                                              \
> +	__typeofdecl(arg) __sysret_arg = __typeofconv1(arg)(arg);               \
> +	if (__is_signed_type(__typeof__(arg))) {                                \
> +		if (__sysret_arg < 0) {                                         \
> +			SET_ERRNO(-(long)__sysret_arg);                         \
> +			__sysret_arg = __typeofconv2(arg)(-1L);                 \
> +		}                                                               \
> +	} else {                                                                \
> +		if ((unsigned long)__sysret_arg >= (unsigned long)-MAX_ERRNO) { \
> +			SET_ERRNO(-(long)__sysret_arg);                         \
> +			__sysret_arg = __typeofconv2(arg)(-1L);                 \
> +		}                                                               \
> +	}                                                                       \
> +	(__typeof__(arg))__sysret_arg;                                          \
> +})
>  
>  /* Functions in this file only describe syscalls. They're declared static so
>   * that the compiler usually decides to inline them while still being allowed
> @@ -94,7 +124,7 @@ void *sbrk(intptr_t inc)
>  	if (ret && sys_brk(ret + inc) == ret + inc)
>  		return ret + inc;
>  
> -	return (void *)__sysret(-ENOMEM);
> +	return __sysret((void *)-ENOMEM);
>  }
>  
>  
> @@ -682,7 +712,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
>  static __attribute__((unused))
>  void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
>  {
> -	return (void *)__sysret((unsigned long)sys_mmap(addr, length, prot, flags, fd, offset));
> +	return __sysret(sys_mmap(addr, length, prot, flags, fd, offset));
>  }
>  
>  static __attribute__((unused))
> -- 
> 2.25.1
> 
> 
