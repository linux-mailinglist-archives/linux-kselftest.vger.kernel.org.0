Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D1760A17
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 08:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGYGO1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 02:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGYGO0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 02:14:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B566173F;
        Mon, 24 Jul 2023 23:14:23 -0700 (PDT)
X-QQ-mid: bizesmtp91t1690265652t0kk5fjv
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 14:14:11 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3jg2U2V57q1XRrz+rfT0OKy4F0qemDz2c+HpO10L1OXgGmMgjwLd
        eSaF0Af04DD1+z+S18+z41Ner1wY2hsQV6e8yo7lsUc6Jm4QOZhxB2NzUlwVF51rZufjqS1
        euzmdwAn1lCAlPkzfsqkNLEi+KCRM87ngBVx5YciofSILPc8j8n9kmSOyFlDtYOh33z2TTf
        o2KsTKT5BG3xtwKYnUcH40cYJOEK/U9fzfr4i2maBdxtBMGRSUmAkd/cQh1z9S2ImOOvTOo
        WbVYKbdc2qjxAYtuvZaDCQ3F+VgEz4Q81+rbHwWDPppZ8GVGfQS/G0rQxsPV8M8oAVzqM8+
        a2iH6PeO+4Ne3+Rg8/rxU/QM22yh5ntFpcNc1TPAawjzAjD/+6nAXC3j5CqiQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 674923569547464683
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Date:   Tue, 25 Jul 2023 14:14:11 +0800
Message-Id: <20230725061411.15500-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <64a95595-9716-4276-a747-0c985997c1ab@t-8ch.de>
References: <64a95595-9716-4276-a747-0c985997c1ab@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> 
> On 2023-07-19 05:10:48+0800, Zhangjin Wu wrote:
> > Both syscall declarations and _start code definition are added for
> > powerpc to nolibc.
> > 
[...]
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/include/nolibc/arch-powerpc.h | 156 ++++++++++++++++++++++++++++
> 
> This also should be added to nolibc/arch.h.
>

Thanks, it should be.

> >  1 file changed, 156 insertions(+)
> >  create mode 100644 tools/include/nolibc/arch-powerpc.h
> > 
> > diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
> > new file mode 100644
> > index 000000000000..100ec0f412dc
> > --- /dev/null
> > +++ b/tools/include/nolibc/arch-powerpc.h
> > @@ -0,0 +1,156 @@
> > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > +/*
> > + * PowerPC specific definitions for NOLIBC
> > + * Copyright (C) 2023 Zhangjin Wu <falcon@tinylab.org>
> 
> If it is taken from musl, shouldn't there also be a musl copyright?
>

For this copyright issue, I have prepared two new versions without a line from
musl. even in our old version, most of them are different except the 'sc; bns+
1f; neg %1, %1; 1:' line and the register variables.

Seems 'sc; bns+ 1f; neg %1, %1; 1:' is also used in linux kernel:
arch/powerpc/include/asm/vdso/gettimeofday.h, so, it should be ok enough to
apply it.

The register varibles have been changed and aligned with othe arch-<ARCH>.h
locally, they are completely different now, and even further with the new
syscall.h mentioned in this reply [1], the file will be completely different.

Thomas, Have added your Reviewed-by lines too, thanks a lot!

Best regards,
Zhangjin
----
[1]: https://lore.kernel.org/lkml/20230725054414.15055-1-falcon@tinylab.org/

