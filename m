Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA11745B0B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGCL3H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGCL3G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 07:29:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59EB3;
        Mon,  3 Jul 2023 04:29:04 -0700 (PDT)
X-QQ-mid: bizesmtp78t1688383727tcbqoirx
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 19:28:46 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: swyrzWPvyR0UF0RO9+D2wKkvOWwFtkwl5DbE4LbGBf6If03/ShndINMpFKE+a
        udSsbo4MUKAc3KJozprcWG+at+NMo/aSGhyvZ//plSDKbOZcWuff5E2LQzRL9Ahrn9Bb1pu
        ECzZloNOKR7611vzCgMDcq18z0eaVH+f9FT1FUMS5KMN2JntvKbbsRTTDHCMo1U3wqZACja
        FklZZ2+IrurPCNYAZ+IhbTZFJRbYGzJcKJd884oDtvFzjDseOXnKdGGcWQlspLjMIi3/U7l
        pYA313TZldkNJtxDU1zLApOz0/sbcC4X+xVOe/wjHrgRahJrfK3T+ykWD+nvIo+pLgbbyVX
        JYIrPcxbR9cx+oB0iF9pBaWBMwxyK3dABc6yAltnmWtq83h49RvpFbYUKADMg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17462509331709393259
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: Re: [PATCH v5 07/14] tools/nolibc: arch-loongarch.h: shrink with SYSCALL_CLOBBERLIST
Date:   Mon,  3 Jul 2023 19:28:46 +0800
Message-Id: <20230703112846.497090-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230702185059.GG16233@1wt.eu>
References: <20230702185059.GG16233@1wt.eu>
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

> On Wed, Jun 28, 2023 at 09:22:21PM +0800, Zhangjin Wu wrote:
> > my_syscall<N> share a same long clobber list, define a macro for them.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/include/nolibc/arch-loongarch.h | 25 +++++++++++--------------
> >  1 file changed, 11 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
> > index 292d6a58dc87..fbb4844f7993 100644
> > --- a/tools/include/nolibc/arch-loongarch.h
> > +++ b/tools/include/nolibc/arch-loongarch.h
> > @@ -23,6 +23,10 @@
> >   */
> >  #define __ARCH_WANT_SYS_PSELECT6
> >  
> > +#define SYSCALL_CLOBBERLIST			\
> > +	"memory", "$t0", "$t1", "$t2", "$t3",	\
> > +	"$t4", "$t5", "$t6", "$t7", "$t8"
> > +
> 
> That's a good idea, but please be careful when adding macro definitions,
> we're in code that is used by user space we have no control on, and we're
> polluting the end user's macro namespace with plenty of names. While one
> could argue that it's unlikely that some program already defines and uses
> SYSCALL_CLOBBERLIST, actually with low-level code it's fairly possible.
> 
> Till now most of the definitions were for stuff that user-space really
> needs (e.g. STDIN_FILENO, various integer limits). If we start to declare
> random macros for internal use, at least we should probably prefix them
> with _NOLIBC_ or something like this to avoid the risk of collision.
>

Ok, _NOLIBC_ prefix will be applied, Thanks.

Best regards,
Zhangjin

> Willy
