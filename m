Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D53745E18
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 16:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGCOC2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 10:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGCOC1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 10:02:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0B7106;
        Mon,  3 Jul 2023 07:02:23 -0700 (PDT)
X-QQ-mid: bizesmtp66t1688392922tdq088by
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 22:02:00 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: ILHsT53NKPhCMmoSN0mc34nVN2tnvUayvI7MBzxx9zHYJyKQV9kkg57EgKUt6
        GZxsvMMNxRk+hppQv+Ccai8JrA53fYikH0nzWzLw9W2Oe2OE3mTkXcYVJmycpa2A5v2IEZl
        zr6Gq/Uh/PqcXof015OmnqK0s0OThKUf8SWSCzIxMg5V3kgkVzSxe0v2KP+o0cNiGApqcQR
        poIvP6Qeq3+eD6I18peAL8xDBg9t6cXFJwnRj00HSPrWJZfebEZQi+VufEIF7tpIR+wOnsM
        f78VG+JZKiq3roX8r1RChbNM4+6/Lpm0SmkWGM8zQ+nyitI10KUouywQTTwFgd37WmB1Um5
        X3aP0k3/O4ARQ1M0eR01OWKWSiFZoUPgj4mvbwu8WzmWc9bI7RrkKs+GJpLiQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15298407468080028086
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: Re: [PATCH v5 06/14] tools/nolibc: arch-*.h: clean up multiple whitespaces
Date:   Mon,  3 Jul 2023 22:02:00 +0800
Message-Id: <20230703140200.499769-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230702184453.GF16233@1wt.eu>
References: <20230702184453.GF16233@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> Hi Zhangjin,
> 
> On Wed, Jun 28, 2023 at 09:19:33PM +0800, Zhangjin Wu wrote:
> > To align with Linux code style and let scripts/checkpatch.pl happy, the
> > multiple whitespaces in arch-<ARCH>.h files are cleaned up.
> > 
> > Most of them are modified by these commands automatically:
> > 
> >     $ sed -i -e '/#define my_syscall/,/})/{s/        /\t/g}' tools/include/nolibc/arch-*.h
> >     $ sed -i -e '/#define my_syscall/,/})/{s/ *\\$/\t\\/g}' tools/include/nolibc/arch-*.h
> > 
> > And checked with:
> > 
> >     $ grep '  *\\$' tools/include/nolibc/arch-*.h
> 
> I'm surprised by this one, I never saw checkpatch complain here. For me,
> putting a tab after a non-tab is an error. It makes the code harder to
> edit and re-align, and diffs are harder to read on lines whose lengths
> varies by +/-1 around a multiple of 8 as it makes the post-tab stuff
> zigzag. You made me recheck the coding style file, and there's nothing
> about alignment there, only about indent (and indent uses tabs here).
> There are also other parts which use spaces for alignment (albeit not
> that many), so unless there is a solid reason for changing that, I'd
> rather not do it, as for me it's the exact opposite of a cleanup as it
> will cause me quite some discomfort.
>

Willy, it is not about alignment, just rechecked it, it is code indent
related:

    #32: FILE: tools/include/nolibc/arch-mips.h:160:
    +^I                                                                      \$
    
    ERROR: code indent should use tabs where possible
    #44: FILE: tools/include/nolibc/arch-mips.h:172:
    +^I          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \$

The first one is here:

	register long _arg6 = (long)(arg6);                                   \
	<--     whitespaces                                                -->\
	__asm__  volatile (                                                   \

And the second one:

		: "memory", "cc", "at", "v1", "hi", "lo",                     \
	<-spaces->"t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \

These two lines indent with "one tab + more than 8 whitespaces", the
other lines also have whitespaces code indent, but not more than 8, so,
not reported.

I have tried to replace whitespaces with tabs in the first one, but the first
one can not align with the other lines, so, the current modify method is
applied.

To only touch minimal lines, this may work (reserve the post-whitespaces):

    $ sed -i -e '/^\t*        /{s/        /\t/g}' tools/include/nolibc/arch-*.h

It will only fix up the lines the reported. The cleanup of the post-whitespaces
is not necessary and it does touch too many lines.

Sorry to disturb you with such cleanups, since I have seen the similar
reports when we added the arch-arm.h (for my_syscall6), because the code
style aligns with the others, so, I did touch it, but again encounter
the same issues with arch-mips.h and to avoid the future reports, I
checked the whole arch-xxx.h, and found more such reports, so, we
prepared such a patch.

To be honest, I do prefer post-tabs to whitespaces (less key press, less code
size ;-)), but as you pointed out, post-tabs have more side-effects, we
shouldn't touch them, Thanks.

> > Besides, more multiple whitespaces are cleaned up:
> > 
> > - convert "__asm__  volatile" to "__asm__ volatile"
> 
> I totally agree on this one, it's very likely the result of a mechanical
> change.

Ok, will split it to a standalone patch, one error report one patch.

> 
> > - "foo _num  bar" should be "foo _num bar"
> 
> In theory yes, except that for those where it appears it was only to
> keep all declarations aligned given that this _num was shorter by one
> char than all other local names. Especially when it comes to enumerating
> register names, you definitely want to keep them aligned. It's sufficiently
> difficult to avoid mistakes there, any help for visual check counts.
>

Agree, let's keep it as before.

Thanks,
Zhangjin

> Willy
