Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2274598A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 12:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGCKB7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 06:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjGCKBR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 06:01:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74441723;
        Mon,  3 Jul 2023 02:58:45 -0700 (PDT)
X-QQ-mid: bizesmtp79t1688378314to1hdzr5
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 17:58:33 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: swyrzWPvyR2MHnEm0gEV1f52S7C1AsQZQ8BAWWwXSoI4RGVChMko0pt9DVKSn
        8hALMuPjl9kFUwWdtEjIlPuRYHSPZghjqqEaIvzXTdd9rwqgZwWZhRJ0GbLQDAlNB42qiqI
        Gcd24WBNFPRfXCwNAwNTXq6fMAmlUE4SgB+VlBwcczsRgD9sH9c6UN3WWMAxQSJ0WvF0AdH
        aO8Lijwo1OTGHcbjuRdyXxJzDs1ByHvoJwprheuyS+FQZDmdsvpoWCRELEyn+VhVfawYvw2
        ZtYl3euUkf8nLT0YgGvP8eaqjTYMe75UMPW8hGaGlxxH5LD/FuWRiN0WieEvAVcjaj5emKS
        hFS60sGyhllezb+ILTwLzm19IPjANH0XIS1292ny9aHMvvuMTycIKeeknMUww==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18250716996633539476
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH v1 03/11] tools/nolibc: include crt.h before arch.h
Date:   Mon,  3 Jul 2023 17:58:32 +0800
Message-Id: <20230703095832.493137-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e1cf8fd3-f8cd-4c3c-9f8c-24bbc0a7cde3@t-8ch.de>
References: <e1cf8fd3-f8cd-4c3c-9f8c-24bbc0a7cde3@t-8ch.de>
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

Hi, Thomas

> 
> On 2023-06-29 02:54:35+0800, Zhangjin Wu wrote:
> > The crt.h provides a new _start_c() function, which is required by the
> > new assembly _start entry of arch-<ARCH>.h (included by arch.h), let's
> > include crt.h before arch.h.
> > 
> > This '#include "crt.h"' doesn't let the new _start_c() work immediately,
> > but it is a base of the coming patches to move most of the assembly
> > _start operations to the _start_c() function for every supported
> > architecture.
> 
> Why don't the arch-*.h files include this new header?
> They are the users of the new symbol.
>

I have tried so, but since crt.h itself is not architecture specific, add it
before arch.h will avoid every new arch porting add the same thing again and
again, currently, we only need to add once. I have even planned to move
compiler.h out of arch-*.h, but not yet ;-)

And also, crt.h may require more features in the future, like init/fini
support, it may be not only used by arch-*.h files.

> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/include/nolibc/Makefile | 1 +
> >  tools/include/nolibc/nolibc.h | 1 +
> >  tools/include/nolibc/signal.h | 1 +
> >  tools/include/nolibc/stdio.h  | 1 +
> >  tools/include/nolibc/stdlib.h | 1 +
> >  tools/include/nolibc/sys.h    | 1 +
> >  tools/include/nolibc/time.h   | 1 +
> >  tools/include/nolibc/unistd.h | 1 +
> >  8 files changed, 8 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
> > index 875e13e3c851..00471e59b11e 100644
> > --- a/tools/include/nolibc/Makefile
> > +++ b/tools/include/nolibc/Makefile
> > @@ -37,6 +37,7 @@ NARCH            = $(or $(NARCH_$(ARCH)),$(ARCH))
> >  arch_file := arch-$(NARCH).h
> >  all_files := \
> >  		compiler.h \
> > +		crt.h \
> 
> This should be part of the patch adding the file.
>

Ok, thanks very much.

Best regards,
Zhangjin

> >  		ctype.h \
> >  		errno.h \
> >  		nolibc.h \
