Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA7728F0A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 06:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjFIEmu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 00:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFIEmt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 00:42:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8C430EC;
        Thu,  8 Jun 2023 21:42:46 -0700 (PDT)
X-QQ-mid: bizesmtp90t1686285752tgnkjaq2
Received: from linux-lab-host.localdomain ( [116.30.126.15])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 09 Jun 2023 12:42:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: D2GZf6M6C/gOTlUc2F+C9b5JD9lju6WjHbkZQeNA6SuuCIQBM/Z1XTkmnkXFi
        jC2ssgmlq0ICj8eaqmLB9lxuhVda1K2ZzKs+V6eBZCZRg+lkB/LJ2kiKyLQfgHQPAhCuLHG
        pveSUVvOoxqrfwjIqix8N2sihcBmvl4OPcUmBXsrGt1zGlsZpvUooDLoDAJLmnJIoc1Gzre
        k//xB5+LDz5OM0cS52fDVPyGFxV2tZQwlFnU/HcJj6tr0kFGlFkNdWTDNYcMltyjxKRqGhn
        f9tAQSHFfmkai/am52lbOjRRl7RKF1t5m+jq6XnbfVDDjvmlRYbz3O9Y6t776br4QoxbOLP
        GLGM4RPKMO73WdSxKHFDhuIZ0Ml5lxly5h9eImb
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17790068061707271583
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     David.Laight@aculab.com, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, w@1wt.eu
Subject: Re: [PATCH v2 1/4] tools/nolibc: sys.h: add __syscall() and __sysret() helpers
Date:   Fri,  9 Jun 2023 12:42:30 +0800
Message-Id: <20230609044230.165494-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9edb16b4-0d3f-4355-a7b1-684a28f9b4cb@t-8ch.de>
References: <9edb16b4-0d3f-4355-a7b1-684a28f9b4cb@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas, David, Willy

> Hi David,
> 
> On 2023-06-08 14:35:49+0000, David Laight wrote:
> > From: Zhangjin Wu
> > > Sent: 06 June 2023 09:10
> > > 
> > > most of the library routines share the same code model, let's add two
> > > helpers to simplify the coding and shrink the code lines too.
> > > 
> > ...
> > > +/* Syscall return helper, set errno as -ret when ret < 0 */
> > > +static inline __attribute__((always_inline)) long __sysret(long ret)
> > > +{
> > > +	if (ret < 0) {
> > > +		SET_ERRNO(-ret);
> > > +		ret = -1;
> > > +	}
> > > +	return ret;
> > > +}
> > 
> > If that right?
> > I thought that that only the first few (1024?) negative values
> > got used as errno values.
> >

Thanks David, this question did inspire me to think about the syscalls
who returns pointers, we didn't touch them yet:

    static __attribute__((unused))
    void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
    {
            void *ret = sys_mmap(addr, length, prot, flags, fd, offset);
    
            if ((unsigned long)ret >= -4095UL) {
                    SET_ERRNO(-(long)ret);
                    ret = MAP_FAILED;
            }
            return ret;
    }

If we convert the return value to 'unsigned long' for the pointers, this
compare may be compatible with the old 'long' ret compare 'ret < 0',

    /* Syscall return helper, set errno as -ret when ret is in [-4095, -1]
     */
    static __inline__ __attribute__((unused, always_inline))
    long __sysret(unsigned long ret)
    {
    	if (ret >= -4095UL) {
    		SET_ERRNO(-(long)ret);
    		ret = -1;
    	}
    	return ret;
    }

Or something like musl does:

    /* Syscall return helper, set errno as -ret when ret is in [-4095, -1] */
    static __inline__ __attribute__((unused, always_inline))
    long __sysret(unsigned long ret)
    {
    	if (ret > -4096UL) {
    		SET_ERRNO(-ret);
    		return -1;
    	}
    	return ret;
    }

So, it reserves 4095 error values (I'm not sure where documents this,
perhaps we need a stanard description in the coming commit message), the
others can be used as pointers or the other data.

If this is ok for you, we may need to renew the v3 series [1] or add
this as an additional patchset (which may be better for us to learn why
we do this) to add the support for the syscalls who return pointers, I
did prepare such a series yesterday, welcome more discussions.

[1]: https://lore.kernel.org/linux-riscv/cover.1686135913.git.falcon@tinylab.org/

> > Do all Linux architectures even use negatives for error?
> > I thought at least some used the carry flag.
> > (It is the historic method of indicating a system call failure.)
> 
> I guess you are thinking about the architectures native systemcall ABI.
> 
> In nolibc these are abstracted away in the architecture-specific
> assembly wrappers: my_syscall0 to my_syscall6.
> (A good example would be arch-mips.h)

Yes, thanks. mips may be the only arch nolibc currently supported who
has separated ret and errno.

The manpage of syscall lists more: alpha, ia64, sparc/32, sparc/64, tile.

https://man7.org/linux/man-pages/man2/syscall.2.html

> 
> These normalize the architecture systemcall ABI to negative errornumbers
> which then are returned from the sys_* wrapper functions.
> 

For mips, it is:

    #define my_syscall0(num)                                                      \
    ({                                                                            \
    	register long _num __asm__ ("v0") = (num);                            \
    	register long _arg4 __asm__ ("a3");                                   \
    	                                                                      \
    	__asm__  volatile (                                                   \
    		"addiu $sp, $sp, -32\n"                                       \
    		"syscall\n"                                                   \
    		"addiu $sp, $sp, 32\n"                                        \
    		: "=r"(_num), "=r"(_arg4)                                     \
    		: "r"(_num)                                                   \
    		: "memory", "cc", "at", "v1", "hi", "lo",                     \
    	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
    	);                                                                    \
    	_arg4 ? -_num : _num;                                                 \
    })

I did learn some difference from musl, it did this as following:

    static inline long __syscall0(long n)
    {
    	register long r7 __asm__("$7");
    	register long r2 __asm__("$2");
    	__asm__ __volatile__ (
    		"addu $2,$0,%2 ; syscall"
    		: "=&r"(r2), "=r"(r7)
    		: "ir"(n), "0"(r2)
    		: SYSCALL_CLOBBERLIST, "$8", "$9", "$10");
    	return r7 && r2>0 ? -r2 : r2;
    }

It checks "r2>0" to make sure only convert 'r2' to negated when r2 is
positive number, I'm wondering this checking may be about the big
pointers, when its first highest bit is 1, then, that may be an issue,
if this guess is true, perhaps we should update this together with the
revision of __sysret().

Thanks very much.

Best regards,
Zhangjin

> The sys_* wrapper functions in turn are used by the libc function which
> translate the negative error number to the libc-style
> "return -1 and set errno" mechanism.
> At this point the new __sysret function is used.
> 
> Returning negative error numbers in between has the advantage that it
> can be used without having to set up a global/threadlocal errno
> variable.
> 
> In hope this helped,
> Thomas
