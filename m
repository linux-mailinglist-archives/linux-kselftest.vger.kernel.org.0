Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C040767D97
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 11:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjG2JSI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 05:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjG2JR6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 05:17:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BC4B9;
        Sat, 29 Jul 2023 02:17:55 -0700 (PDT)
X-QQ-mid: bizesmtp83t1690621918tkx4axzb
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jul 2023 17:11:57 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: EJtdqDMr2mfNbWI4Qk5Biktzy8MsAgY2Q3fc62lN7n1thYUlQh5Erk7CVGbPp
        BwFDxDaj+pB+dfeCrKJ1Ih1PV5oNkt9coTiC1SEZudjDYxoFh+TGTV4iVqBYtEc/cb7bD++
        k4BM70OqBpObuIge0f3TpHmVN/g38/XbAQyOIgKEJiYShvCMYfCNwn9yxCzrEx1I+Dw7506
        R25FerlydWBlDbe/bDv+M9d4ojfqbmKO1uYfBle4Y45/A234Vbzr3OyJhvIICFsaUsBPBqn
        AQFyShBny130Vn9zWy2pE+sM6aXO1simO8Jn+Q+3Y1zizHkzhQFlVPRsqo4+mw3fWYelOSx
        eJHRdOz8FYdfPyeKS8XeEsmHWoijQ4o1biuGBVGGl5j1Hfm/reugfK8bevPQw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6310378489681304004
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 12/12] selftests/nolibc: speed up some targets with multiple jobs
Date:   Sat, 29 Jul 2023 17:11:56 +0800
Message-Id: <20230729091156.8761-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729083128.GM956@1wt.eu>
References: <20230729083128.GM956@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sat, Jul 29, 2023 at 08:44:32AM +0200, Thomas Weißschuh wrote:
> > On 2023-07-28 04:35:01+0800, Zhangjin Wu wrote:
> > > The sysroot install and kernel build targets are time cost, let's use
> > > -j<N> to parallelize them with multiple jobs.
> > > 
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/testing/selftests/nolibc/Makefile | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > index ad2538ec5eb0..1b45c22f9a94 100644
> > > --- a/tools/testing/selftests/nolibc/Makefile
> > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > @@ -171,7 +171,7 @@ PHONY = sysroot/$(ARCH)/include
> > >  sysroot/$(ARCH)/include:
> > >  	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
> > >  	$(QUIET_MKDIR)mkdir -p sysroot
> > > -	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
> > > +	$(Q)$(MAKE) -j$$(nproc) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
> > 
> > This should already work when the users specify -j on the make command
> > line themselves.
> > I'm not a fan of force-enabling it here.
> 
> Indeed, we must not do that, because some users might for instance
> prefer to build multiple archs in parallel and benefit from a better
> parallelism and now they'd end up with too many processes.

Ok, let users do what they want.

Zhangjin

> 
> Willy
