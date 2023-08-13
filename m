Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0489D77A691
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjHMNkE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 09:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjHMNkE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 09:40:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE341716;
        Sun, 13 Aug 2023 06:40:04 -0700 (PDT)
X-QQ-mid: bizesmtp90t1691933986tefh5sq6
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 13 Aug 2023 21:39:45 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: zT6n3Y95oi0Q9hAETwfPAxtGrdKT0h1uUdtny0v5TrbKn15q9s7V0vFt3QvnX
        rw6l9vZA97AA72YrP8HV22bA1aB5XmPuNYgg9F2Bpaivu82xl4azth3CHHbr2JqvsgoC0gF
        F24dXZdt4rMZZieT3QFmTJbzZ1H30JG018hOwW2AnxbzawC/e6iy+S+IU91NoCD0Mz/qZjy
        qlm2SwphK3F8DohC1Y797WBpE8sEtz4SW5Fv36NjNXCD1YTV2c3CJt4j7VEqC+sZ7SHDsH8
        qmmxZAhmA+huuUlxFwUqlxK6pQ0xCLfYYkELy2ttiV9zJK0bMTOssVhAaBzLRvneeHTrqJh
        qJBoTQOBWcQjgbAMXZIj+P7tF+nDMSJJvf4whR44nExggVYZfBjZqJ/wzHjdF2yiFxFkrck
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9377767443625054959
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v6 2/2] tools/nolibc: fix up size inflate regression
Date:   Sun, 13 Aug 2023 21:39:44 +0800
Message-Id: <20230813133944.19604-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230813090037.GE8237@1wt.eu>
References: <20230813090037.GE8237@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Sat, Aug 12, 2023 at 05:51:53AM +0800, Zhangjin Wu wrote:
> > As reported and suggested by Willy, the inline __sysret() helper
> > introduces three types of conversions and increases the size:
> > 
> > (1) the "unsigned long" argument to __sysret() forces a sign extension
> > from all sys_* functions that used to return 'int'
> > 
> > (2) the comparison with the error range now has to be performed on a
> > 'unsigned long' instead of an 'int'
> > 
> > (3) the return value from __sysret() is a 'long' (note, a signed long)
> > which then has to be turned back to an 'int' before being returned by the
> > caller to satisfy the caller's prototype.
> > 
> > To fix up this, firstly, let's use macro instead of inline function to
> > preserves the input type and avoids these useless conversions (1), (3).
> > 
> > Secondly, since all of the sys_* functions have been converted to return
> > integer, now, it is able to remove comparison to a 'unsigned long'
> > -MAX_ERRNO (2) and restore the simple sign comparison as before.
> > 
> (...)
> > +/* Syscall return helper, set errno as -ret when ret < 0 */
> > +#define __sysret(arg)                        \
> > +({                                           \
> > +	__typeof__(arg) __ret = (arg);       \
> > +	if (__ret < 0) {                     \
> > +		SET_ERRNO(-__ret);           \
> > +		__ret = -1L;                 \
> > +	}                                    \
> > +	__ret;                               \
> > +})
> 
> Except that this now breaks brk(), mmap() and sbrk() by taking any value
> with MSB set as an error. Also you've re-introduced the problem you've
> faced with const. See my simplification in the other thread by using "?:"
> which does avoids any assignment.
>

Yeah, thanks for your explanation in this reply [1], the 'const' flag
only triggers build error on the second 'assign' (__ret == -1L), the
first 'assign' is a definition, it is not problematic. so, your "?:"
method is a great idea to simply return without the second 'assign'.

> Let's just roll brk(), mmap() and sbrk() to their original, working,
> definition:
> 
>  static __attribute__((unused))
>  void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
>  {
>         void *ret = sys_mmap(addr, length, prot, flags, fd, offset);
>  
>         if ((unsigned long)ret >= -MAX_ERRNO) {
>                 SET_ERRNO(-(long)ret);
>                 ret = MAP_FAILED;
>         }
>         return ret;
>  }
>

Agree, only left a suggestion here [2] about whether we can apply the 2nd patch
instead of rolling them back, let's discuss it in [2] thread.

> And we're done, you can then keep the simplified __sysret() macro for all
> other call places.
> 

Now, this issue is near to the end ;-)

Thanks!
Zhangjin
---

[1]: https://lore.kernel.org/lkml/20230813085140.GD8237@1wt.eu/#R
[2]: https://lore.kernel.org/lkml/20230813132620.19411-1-falcon@tinylab.org/

> Willy
