Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA967162B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjE3Nyw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 09:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjE3Nys (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 09:54:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A08E;
        Tue, 30 May 2023 06:54:45 -0700 (PDT)
X-QQ-mid: bizesmtp67t1685454874tcbczm6n
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 21:54:33 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: xwvWJGGFd7M6Lf9NrCrasfk6SUbNPheOBSL8ua9DdJsxRZlXQL39nTjnTvL+d
        XLdpGp9SJk9zYuni6DU/NAh7tFSEqaWm7zDN6JJbcoR9OmNKi9eEzB8kiWo06NR4+QJwJek
        E07Tsl/YYyT5/LMOIPqhsXJaey7sesek4fBbqIZJjUpPPCWiF/nyzN5OQFsNv0/EVNAfKEA
        tiOsJO2gCV132ZfqipSRr17DV49vHO0GcMmZsXh1r1ok7mw8jjufV6jL00g3s1kawQ4aCMd
        JRF+DFJ8gSGzm9bI0ZTGRTuepiJIUBs7L+9IWBple5DQXdVqYQmTgbjkgNEHBXU4JMXKFpn
        AIEZI3yhqlGyRoKT96g9LDL1yqF719Sphr20qfdQ1JWK1TbhJm0kAwMwj5wUf1heIRNNMOT
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9011537490340992174
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v2 07/13] tools/nolibc: sys_lseek: add pure 64bit lseek
Date:   Tue, 30 May 2023 21:54:33 +0800
Message-Id: <20230530135433.405051-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5e7d2adf-e96f-41ca-a4c6-5c87a25d4c9c@app.fastmail.com>
References: <5e7d2adf-e96f-41ca-a4c6-5c87a25d4c9c@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Arnd, Willy

> On Mon, May 29, 2023, at 21:54, Zhangjin Wu wrote:
> > use sys_llseek instead of sys_lseek to add 64bit seek even in 32bit
> > platforms.
> >
> > This code is based on sysdeps/unix/sysv/linux/lseek.c of glibc and
> > src/unistd/lseek.c of musl.
> >
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> > ---
> >  tools/include/nolibc/sys.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index 98cfa2f6d021..d0720af84b6d 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -672,7 +672,17 @@ int link(const char *old, const char *new)
> >  static __attribute__((unused))
> >  off_t sys_lseek(int fd, off_t offset, int whence)
> >  {
> > +#if defined(__NR_llseek) || defined(__NR__llseek)
> > +#ifndef __NR__llseek
> > +#define __NR__llseek __NR_llseek
> > +#endif
> > +	off_t result;
> > +	return my_syscall5(__NR__llseek, fd, offset >> 32, offset, &result, 
> > whence) ?: result;
> > +#elif defined(__NR_lseek)
> >  	return my_syscall3(__NR_lseek, fd, offset, whence);
> > +#else
> > +#error None of __NR_lseek, __NR_llseek nor __NR__llseek defined, 
> > cannot implement sys_lseek()
> > +#endif
> >  }
> 
> This is not technically wrong, but I think a different approach
> would be clearer: Instead of having a sys_lseek() that works
> differently depending on the macros, why not define the low-level
> helpers to match the kernel arguments like
> 
> static inline __attribute__((unused))
> __kernel_loff_t sys_lseek(int fd, __kernel_loff_t offset, int whence)
> {
> #ifdef __NR__llseek
> 	__kernel_loff_t result;
> 	return my_syscall5(__NR__llseek, fd, offset >> 32, offset, &result,  whence) ?: result;
> #else
>         
> #endif
> }
> 
> static inline __attribute__((unused))
> __kernel_off_t sys_lseek(int fd, __kernel_off_t offset, int whence)
> {
> #ifdef __NR_lseek
> 	return my_syscall3(__NR_lseek, fd, offset, whence);
> #else
>         return -ENOSYS;
> #endif
> }
> 
> And then do the selection inside of the actual lseek,
> something like
> 
> static __attribute__((unused))
> off_t lseek(int fd, off_t offset, int whence)
> {
>         off_t ret = -ENOSYS;
> 
>         if (BITS_PER_LONG == 32)
>                ret = sys_llseek(fd, offset, whence);
> 
>         if (ret == -ENOSYS)
>                ret = sys_lseek(fd, offset, whence);
> 
>         if (ret < 0) {
>                 SET_ERRNO(-ret);
>                 ret = -1;
>         }
>         return ret;
>        
> }

Yes, It is clearer, thanks. will learn carefully about the kernel types.

> 
> For the loff_t selection, there is no real need to handle the
> fallback, so this could just be an if()/else to select 32-bit
> or 64-bit, but for the time_t ones the fallback is required
> for pre-5.6 kernels.
>

Ok, will test it on the pre-5.6 versions too.

Hi, Willy, what's your suggestion about the oldest kernel versions we plan to support? ;-)

Best regards,
Zhangjin

>        Arnd
