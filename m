Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CCA74D15B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 11:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjGJJ1E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 05:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjGJJ1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 05:27:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF6DE;
        Mon, 10 Jul 2023 02:26:54 -0700 (PDT)
X-QQ-mid: bizesmtp62t1688981204tbzgy2xs
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Jul 2023 17:26:43 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 7jw2iSiCazqxq3E3wy6hPfZykE4hfVfZrfCIOKArw7wYmcU4+BoqWp9HKmgk7
        wtfJK5c90JapD/8HXtqF6haLoeg1mantn37OTtQTMKn811C9NTP+wdunitG2jEzpDoCSzNw
        93tP5FXP+is4Vt8ms9gcvutiMPIvTcYbRQP8qRes+yJZd1jSqDEO6Q2oP4INdif7ZPq9nRG
        Vkcu9XfdnL038D/nJ4mQv0BVwZGlbLIAlYNKRlZpweBUCH8QBHy+959/0QVg7dTCV309kiN
        QXcPAXag+XudxgcSMRqSqnMoJACaIHBPiuu3Bst9SKBAj2kVRxa7RVFtPdMpccy9/dlWjCy
        U/+wR3aw0EhIPjp0i3uiYE1IOgioaVQUgqrXhCXkKdAg7Cs2E5T2kO1tCJoEnzotxwE0J7k
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7862484930145351786
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v2 04/12] tools/nolibc: crt.h: add _start_c
Date:   Mon, 10 Jul 2023 17:26:43 +0800
Message-Id: <20230710092643.19310-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4e23cc1c-2fe0-413e-9fe1-a9428c0861b9@t-8ch.de>
References: <4e23cc1c-2fe0-413e-9fe1-a9428c0861b9@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> 
> On 2023-07-08 23:29:58+0800, Zhangjin Wu wrote:
> > As the environ and _auxv support added for nolibc, the assembly _start
> > function becomes more and more complex and therefore makes the porting
> > of nolibc to new architectures harder and harder.
> > 
> > To simplify portability, this c version of _start_c() is added to do
> > most of the assembly start operations in C, which reduces the complexity
> > a lot and will eventually simplify the porting of nolibc to the new
> > architectures.
> > 
> > The new _start_c() only requires a stack pointer argument, it will find
> > argv, envp and _auxv for us, and then call main(), finally, it exit()
> > with main's return status. With this new _start_c(), the future new
> > architectures only require to add very few assembly instructions.
> 
> I like it!
> 
> A quick test indicates that the initialization of the stackprotectors
> could also be moved into the C function.
>

Cool, do you mean directly call __stack_chk_init() at the beginning of
_start_c()?

> It also seems like a good opportunity to add some tests for
> argv/environment variable passing.

Yes, and even further, we can do more on auxv, just like musl does in
src/env/__libc_start_main.c, not that urgent currently:

    libc.auxv = auxv = (void *)(envp+i+1);
    ...
    __hwcap = aux[AT_HWCAP];
    if (aux[AT_SYSINFO]) __sysinfo = aux[AT_SYSINFO];
    ...
    libc.page_size = aux[AT_PAGESZ];

    if (!pn) pn = (void*)aux[AT_EXECFN];
    if (!pn) pn = "";
    __progname = __progname_full = pn;
    for (i=0; pn[i]; i++) if (pn[i]=='/') __progname = pn+i+1;

    __init_tls(aux);
    __init_ssp((void *)aux[AT_RANDOM]);

    if (aux[AT_UID]==aux[AT_EUID] && aux[AT_GID]==aux[AT_EGID]
            && !aux[AT_SECURE]) return;

    ...
    libc.secure = 1;

> 
> And as general note to the full series I think that splitting the arch
> files is not necessary and confusing.
>

Ok, welcome to discuss more in this thread:

    https://lore.kernel.org/lkml/20230710072340.10798-1-falcon@tinylab.org/

and let's choose a better method as possible as we can, Just replied Willy to
explain more.

> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/include/nolibc/crt.h | 44 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> > index 221b7c5346ca..b269294e9664 100644
> > --- a/tools/include/nolibc/crt.h
> > +++ b/tools/include/nolibc/crt.h
> > @@ -13,4 +13,48 @@
> >  char **environ __attribute__((weak));
> 
> The old code seems to avoid putting "environ" into the global symbol
> namespace. Could this declaration be moved into the function like in
> getenv()?
>

ok, do you mean just move it to stdlib.h like this? I moved _auxv (used
by getauxv()) to stdlib.h too:

        tools/nolibc: move environ and _auxv from crt.h to stdlib.h
        
        Move the definitions of environ and _auxv from crt.h to stdlib.h, where
        the place who uses those definitions.
        
        - getenv uses environ
        - getauxv uses _auxcv
        
        Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
    
    diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
    index b269294e9664..d2f84cbe73d0 100644
    --- a/tools/include/nolibc/crt.h
    +++ b/tools/include/nolibc/crt.h
    @@ -10,14 +10,13 @@
     #include "compiler.h"
     #include "crt_arch.h"
     
    -char **environ __attribute__((weak));
    -const unsigned long *_auxv __attribute__((weak));
    -
     int main(int argc, char *argv[], char **envp);
     static void exit(int);
     
     void _start_c(long *sp)
     {
    +       extern char **environ;
    +       extern const unsigned long *_auxv;
            int argc, i;
            char **argv;
            char **envp;
    diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
    index 2f9b4b3c6d26..5eadadc2d0f5 100644
    --- a/tools/include/nolibc/stdlib.h
    +++ b/tools/include/nolibc/stdlib.h
    @@ -14,6 +14,9 @@
     #include "string.h"
     #include <linux/auxvec.h>
     
    +char **environ __attribute__((weak));
    +const unsigned long *_auxv __attribute__((weak));
    +
     struct nolibc_heap {
            size_t  len;
            char    user_p[] __attribute__((__aligned__));

> >  const unsigned long *_auxv __attribute__((weak));
> >  
> > +int main(int argc, char *argv[], char **envp);
> 
> This will lead to conflicting declarations if the users use a different
> signature. I'm not (yet?) sure how to work around this.
>

Ah yes, I forgot this critical case, people may use something like:

    int main(void)
    int main(int argc, char *argv[])

Just applied the method suggested by you in anothe reply [1]:

    diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
    index d2f84cbe73d0..8fe38ef8c5b2 100644
    --- a/tools/include/nolibc/crt.h
    +++ b/tools/include/nolibc/crt.h
    @@ -10,7 +10,7 @@
     #include "compiler.h"
     #include "crt_arch.h"

    -int main(int argc, char *argv[], char **envp);
    +typedef int (_nolibc_main_fn)(int, char **, char **);
     static void exit(int);

     void _start_c(long *sp)
    @@ -20,6 +20,7 @@ void _start_c(long *sp)
            int argc, i;
            char **argv;
            char **envp;
    +       _nolibc_main_fn _nolibc_main __asm__ ("main");

            /*
             * sp  :  argc          <-- argument count, required by main()
    @@ -53,7 +54,7 @@ void _start_c(long *sp)
            _auxv = (void *)(envp + i + 1);

            /* go to application */
    -       exit(main(argc, argv, envp));
    +       exit(_nolibc_main(argc, argv, envp));
     }
 
     #endif /* _NOLIBC_CRT_H */

It works as expected, thanks very much!

> Also how is the case handled where main() returns "void"?

Do you mean the main() without an explicit "return 0"?

    int main(int argc, char *argv[], char **envp)
    {
        printf("Hello\n");
    }

Tested c89, c99, c2x, c23, gnu11, the same result as yours:

    std       | return value
    ----------|------------
    c89       | 6 /* return value of printf() */
    c99       | 0 /* set by compiler with: xorl    %eax, %eax */
    c2x       | 0
    gnu11     | 0

> I'm not sure how this is currently handled or if the compiler takes care
> of returning 0 in this case.

    void main(void)
    {
        printf("Hello\n");
    }

Tested c89, c99, c2x, c23, gnu11, the same result as yours, the return
value is 6, the return value is the return status of the last called
functon.

Thanks,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/90fdd255-32f4-4caf-90ff-06456b53dac3@t-8ch.de/
