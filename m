Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EFB712492
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbjEZKZo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 06:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbjEZKZn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 06:25:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ED3E46;
        Fri, 26 May 2023 03:25:25 -0700 (PDT)
X-QQ-mid: bizesmtp85t1685096719te1p3ayz
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 26 May 2023 18:25:18 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: +ynUkgUhZJk/BOqp0oA9cBg1YsH89tL5W5qI5R9skNk3ZDlWFZ9Rn3nuDLHs6
        r+jdJjJ6RsVhmT4f02tw/MUiR95J8ZHDs3wLyf7AK1WOAA4EIeTLghnosNldvidGC0l67Gg
        2wYkd1Z5Tp0KBw74IMW4oY64DEXTsLZTXdoOMnfzfQfg3GspMKUW0w+aX/PB1XNeHKCJ7ki
        rKwLr5llWwScHgLl/T/iRZLUbfPOilCzMWy+UioDCh9PuWaWLKFbQ7RhzPSDtCYJ0tJYlnv
        QcwgLYeEKtu0tr1zpA4GKs/VRufTXnJiYTkUJXcC2xgJq1V6qzS/+WgbkejKpVxpTvwS0AE
        pTyFJWz+eWpelE0SrSj+8C6mQRZa5VcSQVR8AnV0Hdew0584nkZshTSqBqhgn8mgsYKynPR
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12828852806642903950
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, w@1wt.eu
Subject: Re: [PATCH 06/13] selftests/nolibc: allow specify a bios for qemu
Date:   Fri, 26 May 2023 18:25:18 +0800
Message-Id: <20230526102518.150058-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2ab94136-d341-4a26-964e-6d6c32e66c9b@t-8ch.de>
References: <2ab94136-d341-4a26-964e-6d6c32e66c9b@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> On 2023-05-25 01:52:29+0800, Zhangjin Wu wrote:
> > riscv qemu has a builtin bios (opensbi), but it may not match the latest
> > kernel and some old versions may hang during boot, let's allow user pass
> > a newer version to qemu via the -bios option.
> 
> Nitpick:
> 
> This seems very specific and hopefully only necessary temporarily.
>

RISC-V is such a new ISA and the Spec (especially the SBI) changes very
frequently ;-)

> Instead it could be changed to some generic mechanim like
> "QEMU_ARGS_EXTRA"?
>

Good point, will apply it.

Thanks,
Zhangjin

> > we can use it like this:
> > 
> >     $ make run BIOS=/path/to/new-bios ...
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 9adc8944dd80..9213763ab3b6 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -70,7 +70,8 @@ QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> >  QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> >  QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> >  QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> > -QEMU_ARGS            = $(QEMU_ARGS_$(ARCH))
> > +QEMU_ARGS_BIOS       = $(if $(BIOS),-bios $(BIOS))
> > +QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_BIOS)
> >  
> >  # OUTPUT is only set when run from the main makefile, otherwise
> >  # it defaults to this nolibc directory.
