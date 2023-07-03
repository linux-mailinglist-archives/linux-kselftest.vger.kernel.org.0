Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3CC745F32
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 16:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjGCOze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 10:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCOzT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 10:55:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787B8E60;
        Mon,  3 Jul 2023 07:55:16 -0700 (PDT)
X-QQ-mid: bizesmtp91t1688396105toirk3qq
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 22:55:04 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: wF64VgvUy+XW25I0Wt/l4ClCmQe+EcewDJAv2OzfTTi1/Kqk/exL/s/rgKMIW
        7enRh87YMrErrt6GxFYbLCbURLdcXBq3YM5IZBc0yJlpq1xkQJAhMAbSsHbBu3FbxTc/77w
        xYNDnfsHlH9m1hqqGp6sjqp72HxCGvSx5l9mFmxPUeJF2lNI2U8UkjPmYQ0AMFrDD/M+aqf
        creE7SXPGgWcgDWP1o1OzC9/Xhlqka+E46ZTWcTd5oo9scK+UI8GzPjkIM2S27VUoHQ+4ZP
        AMOrO0AUPU2SseunmD1MuqKx7Kf2bDB2/o/W5GrX/AD4mdaRsDdmjeEGAcUVE9iRQu9VQiz
        6ZWSYUmk2gT5UsSmtW6hxxsFUeG+ZQLBfr/NlfPcdRUwsFW+9lZfFWICrW1JQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7014001186347428389
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH v1 03/11] tools/nolibc: include crt.h before arch.h
Date:   Mon,  3 Jul 2023 22:55:00 +0800
Message-Id: <20230703145500.500460-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8efbbfe5-1c3f-46df-9bc3-2ba62015f17e@t-8ch.de>
References: <8efbbfe5-1c3f-46df-9bc3-2ba62015f17e@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 2023-07-03 17:58:32+0800, Zhangjin Wu wrote:
> > Hi, Thomas
> > 
> > > 
> > > On 2023-06-29 02:54:35+0800, Zhangjin Wu wrote:
> > > > The crt.h provides a new _start_c() function, which is required by the
> > > > new assembly _start entry of arch-<ARCH>.h (included by arch.h), let's
> > > > include crt.h before arch.h.
> > > > 
> > > > This '#include "crt.h"' doesn't let the new _start_c() work immediately,
> > > > but it is a base of the coming patches to move most of the assembly
> > > > _start operations to the _start_c() function for every supported
> > > > architecture.
> > > 
> > > Why don't the arch-*.h files include this new header?
> > > They are the users of the new symbol.
> > >
> > 
> > I have tried so, but since crt.h itself is not architecture specific, add it
> > before arch.h will avoid every new arch porting add the same thing again and
> > again, currently, we only need to add once. I have even planned to move
> > compiler.h out of arch-*.h, but not yet ;-)
> 
> While this saves a few lines of code in my opinion it hurts clarity to
> rely on implicitly pre-included things.
>

To be clearer, what about split the arch.h to sys_arch.h (my_syscall*)
and crt_arch.h? (_start part) and then, we can include crt_arch.h in
crt.h and at the same time, include sys_arch.h in sys.h, and at last
we need to create a <ARCH> directory for the them.

    crt.h:
        #include "crt_arch.h"

	_start_c ()

    sys.h:
        #include "sys_arch.h"

	sys_xxx()
	{
            my_syscall<N>(...)
	}

    crt_arch.h:

        #ifdef ARCH
        #include "<ARCH>/crt_arch.h"
	#endif

    sys_arch.h:

        #ifdef ARCH
        #inculde "<ARCH>/sys_arch.h"
	#endif

I just found musl uses such structure ;-)

> > every new arch porting
> 
> That doesn't seem like a very frequent occurrence :-)
>

Yes, it is not often.

> > And also, crt.h may require more features in the future, like init/fini
> > support, it may be not only used by arch-*.h files.
> 
> Do you have a mechanism in mind that supports init/fini without needing
> an ELF parser at runtime? I guess an ELF parser would make it a complete
> no-go.
>

I didn't really think about this yet ;-)

> Also the value added by init/fini seems fairly limited for a statically
> linked (tiny) application.
>

Yeah.

Thanks,
Zhangjin

> > [..]
