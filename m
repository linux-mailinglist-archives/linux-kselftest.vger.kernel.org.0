Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9502B74CE46
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 09:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGJHYA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 03:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjGJHX5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 03:23:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F41412E;
        Mon, 10 Jul 2023 00:23:53 -0700 (PDT)
X-QQ-mid: bizesmtp64t1688973821tb5j9ohz
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Jul 2023 15:23:40 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: TlxLMsIUBW4EcbxcC2LrQW1GRsfJ71Cpszt5psKYudU+C2lalrZoHaW2LhFZq
        f6swelsiYuDfx8ruTcZwZLT1KwkYDr/53LPRrYcQ2gzsAIm1XwXQf3LQ3NCLSUdY/LXHAls
        L/s/lm5ifgBYmnXAspofEXODu9enxqXEDQNIDXqphgcPuc90MEwRkI77D1Oo5rYgtTHF+1F
        xPmtGfSxoUYyb2xMCtO81/2qy3RdYnzokuyfF45Syfz1q+GnOZ54GkB1PljubvNP1wqc4AU
        LFxrRT2E6VdhJFsIe9fMWmocpZ3dV+4LoPSGXJz/6TEr0U72m2gMt49jVVaFvUK7Mtiatv8
        a1ysgh9G2a7Fqe+n1hxB5ReziTEjamE8/JgcY10MFEjjaZljRXM+S0uq4wWVNaU+kmFrX7F
        PI4GWkCoGEQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16682302212617775636
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 01/12] tools/nolibc: rename arch-<ARCH>.h to <ARCH>/arch.h
Date:   Mon, 10 Jul 2023 15:23:40 +0800
Message-Id: <20230710072340.10798-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230709095657.GJ9321@1wt.eu>
References: <20230709095657.GJ9321@1wt.eu>
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

Hi, Willy

> 
> On Sat, Jul 08, 2023 at 11:26:42PM +0800, Zhangjin Wu wrote:
> > Currently, the architecture specific arch.h has two parts, one is the
> > syscall declarations for sys.h, another is the _start code definition
> > for startup support.
> > 
> > The coming crt.h will provide the startup support with a new common
> > _start_c(), it will replace most of the assembly _start code and shrink
> > the original _start code to be minimal, as a result, _start_c() and the
> > left minimal _start code will work together to provide the startup
> > support, therefore, the left _start code will be only required by crt.h.
> > 
> > So, the syscall declarations part of arch.h can be split to sys_arch.h
> > and the _start code part of arch.h can be split to crt_arch.h and then,
> > they should only be included in sys.h and crt.h respectively.
> > 
> > At the same time, the architecture specific arch-<ARCH>.h should be
> > split to <ARCH>/crt.h and <ARCH>/sys.h.
> > 
> > As a preparation, this creates the architecture specific directory and
> > moves tools/include/nolibc/arch-<ARCH>.h to
> > tools/include/nolibc/<ARCH>/arch.h.
> 
> I'm sorry but I still don't understand what it *provides*. I'm reading
> it as "we *can* do this so let's do it". But what is the specific
> purpose of adding this extra directory structure ? It's really unclear
> to me and worries me that it'll only result in complicating maintenance
> by adding even more files, thus even more "include" lines and cross
> dependencies.

Willy, I was assuming you had a look at the discussion between Thomas
and me, so, I didn't add the link to our discussion, it is more about
the 'clarity' of code "include" [1].

I have proposed the idea in the discussion but got no response yet, so,
sent this revision for more discussion, obviously, it is better to
discuss more there and get more feedback from Thomas and you.

The v0 included "crt.h" before "arch.h", Thomas suggested me include
"crt.h" in arch_<ARCH>.h, just like the "compiler.h" did. His suggestion
did inspire me to think about how to treat the relationship among crt.h,
sys.h and arch.h.

The idea behind is we have many directions to divide nolibc to different
parts/modules:

- one is arch specific (arch.h) and non-arch specific (the others)

  This method is used by us currently, It is very good to put all of the
  arch specific parts together to simplify (in the files to be
  added/maintained) the porting of a new architecture.

  But to be honest, It also confuse the modularity a little, for
  example, like sys.h, crt.h should be a core function/feature of
  nolibc, arch.h is not so. arch.h only provides the necessary minimal
  assembly "pieces".

  both sys.h and crt.h are not a sub modules of arch.h (although they
  have minimal arch specific code), so, like sys.h, crt.h should be
  included in the top-level headers, not in arch.h, reversely, the
  minimal arch specific should be included in crt.h. To do so and to
  avoid include the non-crt part, the split of arch.h is required, and
  therefore, the <ARCH>/ is created to put the divided <ARCH>/sys.h and
  <ARCH>/crt.h, otherwise, there will be many sys-<ARCH>.h and
  crt-<ARCH>.h in the top-level directory of nolibc.

- another is the parallel functions/features (like crt.h, sys.h, stack protector ...)

  This is used by musl and glibc, before sending this proposal, I have
  taken a look at both of them, musl is simpler and clearer, we apply
  the similar method:

  musl:
      crt/crt1.c
                 #include "crt_arch.h"  /* arch/<ARCH>/crt_arch.h */

                 void _start_c(long *p)
                 {
                        int argc = p[0];
                        char **argv = (void *)(p+1);
                        ...
                 }

      src/internal/syscall.h:
                 ##include "syscall_arch.h" /* arch/<ARCH>/syscall_arch.h */
     
                 ...

  glibc: (it is more complicated than musl)

     csu/libc-start.c, sysdeps/<ARCH>/start.S
     
     sysdeps/unix/sysv/linux/sysdep.h, sysdeps/unix/sysv/linux/<ARCH>/sysdep.h, 


  With this method, the "crt_arch.h + crt.h" together provide the C
  RunTime (startup code, stack protector, environ and _auxv currently)
  function, the "sys_arch.h + sys.h" together provide the syscall
  definitions. The arch specific parts are hidden behind, and only
  require to include the crt_arch.h in crt.h and sys_arch.h in sys.h, no
  need to include the whole arch.h for all.

As a summary, the core obvious reason here is, to this crt.h itself, it
is ok for us to include crt.h in arch.h in code side, but reversely, I
do prefer to include arch.h (and therefore the crt_arch.h) in crt.h,
crt.h is the core function should be exported, arch.h is not, it only
provide some low-level helpers for crt.h. If we treat sys.h as a core
function and crt.h as a arch specific thing, it does confuse a little.
This reorg may also help the similar future functions who require arch
specific support, but of course, it does require to add/maintain more
files for a new architecture, but it also allow to develop/debug at a
smaller fineness.

In current stage, include crt.h in arch.h is not that unacceptable, but
if reorg is a better direction, why not do it currently, because we do
have two functions (crt.h and sys.h) in <ARCH>/, if only one, it is not
urgent ;-)

Is this explanation better than before? welcome to discuss more ;-)

Like musl, if required, another top-level arch/ may be required to put
all of the <ARCH>/ directories together to clean up the top-level nolibc
directory.

> 
> Zhangjin, very often in your series, the justification for a change is
> missing, instead it's only explaining what is being changed, and I must
> confess that it makes it particularly difficult to figure the benefits.
> I'm only seeing this as an opportunity for a change ("can be split").
> I could have missed something of course, but I can't figure what problem
> it is trying to solve.

Willy, thanks very much for pointing out this and so sorry, "commit
message should tell why but not how" is in my mind, but sometimes, it
may be lost especially when the change list are 'huge' (must improve).

In reality, It is a little difficult to just explain it at the right
dimension for this change, so I have wrotten several versions of the
commit message for this change locally (and also for the other changes
too), at last, I choose the one currently used.

As explained in another reply, it is really hard to write a just ok
commit message for every change, sometimes, the justification is
'obvious' to some develoers who have the background information or who
have dicussed together, sometimes, it is not easy to just write
precisely about the core justification, to improve this, here is the
list I plan to do, hope it help the others too:

- discuss more before send new patches, especially for 'new' or 'big'
  change

- reword carefully about every change before sending patches (show
  benefits to let maintainer 'buy' (merge) them)

- send the patches not frequently, keep the mind conscious, not like a
  "flood"

> 
> As a general advice, I tend to remind people that when sending a patch
> series, they should consider they're trying to sell it, so they must
> emphasize the benefits of accepting the series for the maintainer(s).
>

Yeah, why maintainer want to 'buy' (merge) is the right direction.

> You very likely have a good reason for doing this but I can't see it
> here so I'm just seeing a change that will possibly add some extra
> cost (if at least because file locations change again) and nothing
> more. When you try to reorganize things, it's often much more
> efficient to try to discuss it before proposing patches, because
> reorg patches are generally unreadable and take time for you to
> create and for others to review.

Yes, reorg is really hard to do and also hard to review.

> Instead, just explaining what you
> think you can improve is faster for everyone, and others can chime in
> and propose alternate approaches (something which is very hard to do
> with a patch series).
>

Great suggestion, a ping on the discussion [1] would be better than just
reorg it and send the patches. Thanks a lot.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/20230703145500.500460-1-falcon@tinylab.org/

> Thanks!
> Willy
