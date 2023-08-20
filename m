Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8F2781F86
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Aug 2023 21:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjHTTcd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Aug 2023 15:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjHTTc0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Aug 2023 15:32:26 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EE931A2;
        Sun, 20 Aug 2023 12:28:09 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D870472C981;
        Sun, 20 Aug 2023 22:28:08 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D0C0E36D0165;
        Sun, 20 Aug 2023 22:28:08 +0300 (MSK)
Date:   Sun, 20 Aug 2023 22:28:08 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC] tools/nolibc: x86_64: Make it compile with -pie
Message-ID: <20230820192808.dm65aenmbrton6vy@altlinux.org>
References: <20230820181900.3786107-1-vt@altlinux.org>
 <76af26a2-bf31-4397-8e9c-f15a8c9dac18@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76af26a2-bf31-4397-8e9c-f15a8c9dac18@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thomas,

On Sun, Aug 20, 2023 at 09:13:51PM +0200, Thomas Weißschuh wrote:
> On 2023-08-20 21:19:00+0300, Vitaly Chikunov wrote:
> > Use RIP-relative addressing when setting `environ` and `_auxv` in
> > startup code.
> > 
> > Some toolchains have `-pie` enabled by default. On them or when -pie is
> > specified manually gcc produces error like this:
> > 
> >   ld: /tmp/cci0uPcR.o: relocation R_X86_64_32S against symbol `environ' can not be used when making a PIE object; recompile with -fPIE
> >   ld: failed to set dynamic section sizes: bad value
> > 
> > This is because asm() startup code accesses there pointers with absolute
> > addressing.
> > 
> > This may inspire others to fix the problem for other architectures too.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> >  tools/include/nolibc/arch-x86_64.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
> > index 6fc4d8392742..a6be44b333ce 100644
> > --- a/tools/include/nolibc/arch-x86_64.h
> > +++ b/tools/include/nolibc/arch-x86_64.h
> > @@ -199,14 +199,14 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
> >  		"pop %rdi\n"                /* argc   (first arg, %rdi)                            */
> >  		"mov %rsp, %rsi\n"          /* argv[] (second arg, %rsi)                           */
> >  		"lea 8(%rsi,%rdi,8),%rdx\n" /* then a NULL then envp (third arg, %rdx)             */
> > -		"mov %rdx, environ\n"       /* save environ                                        */
> > +		"mov %rdx, environ(%rip)\n" /* save environ                                        */
> >  		"xor %ebp, %ebp\n"          /* zero the stack frame                                */
> >  		"mov %rdx, %rax\n"          /* search for auxv (follows NULL after last env)       */
> >  		"0:\n"
> >  		"add $8, %rax\n"            /* search for auxv using rax, it follows the           */
> >  		"cmp -8(%rax), %rbp\n"      /* ... NULL after last env (rbp is zero here)          */
> >  		"jnz 0b\n"
> > -		"mov %rax, _auxv\n"         /* save it into _auxv                                  */
> > +		"mov %rax, _auxv(%rip)\n"   /* save it into _auxv                                  */
> >  		"and $-16, %rsp\n"          /* x86 ABI : esp must be 16-byte aligned before call   */
> >  		"call main\n"               /* main() returns the status code, we'll exit with it. */
> >  		"mov %eax, %edi\n"          /* retrieve exit code (32 bit)                         */
> > -- 
> > 2.33.8
> > 
> 
> nolibc recently switched to startup code that is mostly implemented in C
> instead of assembly.
> See the current linux-next tree.
> 
> That should make this change unnecessary I guess.

Yes seems so! Zhangjin Wu done a fine job.

Thanks,

> 
> 
> Thomas
