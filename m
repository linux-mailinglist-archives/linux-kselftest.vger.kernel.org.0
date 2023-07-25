Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65E1761D0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjGYPNt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjGYPNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 11:13:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448E419A0;
        Tue, 25 Jul 2023 08:13:44 -0700 (PDT)
X-QQ-mid: bizesmtp87t1690298014tleezm63
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 23:13:33 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3hIZ7n4l5sajWN0x3ZQQGFKpGON0fD5ygebOvoAYIXLchYVcPAEn
        bIuj+cZpfwuPYUGMT5gVwX+xuHc8DmEUBTA1WzIM2p2r6tjBPLnv4yuQbcwmF/sQDPQcALq
        d+q/hENcrbutUxStmEpP4mnegTi9mn2LqMcwj30ymVvhlsj40vKWjpViLIP0vuArZLeRGpn
        g3fBVr+1R0sMvrIv5gkdOzmS/9VqE2VJ/zetHVnUUkgGhs+KiUnERkm0o5VuYtam/Zho0/p
        nvCjR4t9GQSvIvudEKH4arMzpi/QL/46mKimCpTeLdkLcpbMtyLXbYGMtYtRiNzk63X2bNz
        biSoZqBCi9xEgJA+QQuKkiBZ12QL9u16UX4+JARG9EezXKbAA6/PUv+YU4ltA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9699696357936062444
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 12/14] selftests/nolibc: add tinyconfig target
Date:   Tue, 25 Jul 2023 23:13:33 +0800
Message-Id: <20230725151333.37939-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230722130759.GL17311@1wt.eu>
References: <20230722130759.GL17311@1wt.eu>
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

> On Wed, Jul 19, 2023 at 09:30:30PM +0800, Zhangjin Wu wrote:
> > The original tinyconfig target only enables minimal kernel config
> > options, it can speed up the kernel build and nolibc test a lot and also
> > brings us with smaller kernel image size.
> > 
> > But the default enabled options are not enough for qemu boot and console
> > print, some additional config options should be added for every
> > architecture individually.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index eec2935672ad..f42782fa78a9 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -218,6 +218,9 @@ mrproper:
> >  defconfig:
> >  	$(Q)$(MAKE_KERNEL) $(DEFCONFIG) prepare
> >  
> > +tinyconfig:
> > +	$(Q)$(MAKE_KERNEL) tinyconfig prepare
> 
> So for the same reasons as defconfig above, I'd actually keep mrproper
> here.

Ok, let's add mrproper back here, since tinyconfig is fast enough, so, a
mrproper is not that time cost and a cleanup is really good prepare.

> And if we figure that tinyconfig is never called by the user
> directly but as a dependency from the makefile itself or scripts,
> then we likely don't even need to create a visible entry for it.
>

Great idea,

At first, tinyconfig can be triggered by something like:

    $ make run defconfig DEFCONFIG=tinyconfig

Perhaps we can let $(KERNEL_CONFIG) depends on the top-level
'tinyconfig' and trigger it by default:

    $(KERNEL_CONFIG):
	$(Q)if [ ! -f "$(KERNEL_CONFIG)" ]; then $(MAKE_KERNEL) --no-print-directory mrproper tinyconfig prepare; fi

Of course, we should triger the extra config above.

But this change must delay after we add tinyconfig support for all of
the nolibc supported architectures. before that, we should use
'defconfig' as we do currently.

So, it may be ok for us to drop this patch, but we also need to update
some commit messages who uses tinyconfig target directly.

Thanks,
Zhangjin

> Willy
