Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E580767D48
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 10:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjG2IrS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 04:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2IrP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 04:47:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0EE44B0;
        Sat, 29 Jul 2023 01:47:11 -0700 (PDT)
X-QQ-mid: bizesmtp89t1690620419toqqujxk
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jul 2023 16:46:58 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: LE7C6P2vL8R+bFTy2nwPvrMMRc/Epw5PWdpL/W4zti+NsWrjvDwO8POY0y7hP
        cLoj07+RQoDWStbWvXLEzymREWbuZo5E9/e1iSEAg8Tf2LFHJZfqaJR8dIN7cnch3qclzJd
        Ps1NV1t4btmWIFQRmDdxPYNR/PJK2SLVMwECJ3hcR3zr5+LJd4LaXgL3/I+Vx2JE6QxokRJ
        C/bqxZw9CL3p55q3dKc9/kuqisSytn0GhXf91j/0jNz3p0AVHutQ4MYzTp5jyMo2rXH5mt0
        sOBO03+q5BM7HN8NEWLnyLFu+EdkJYWPhzKvt7jMjnbRV/sCZbWxs3EEiGnfw3XzN+1xnW4
        2YTF5AbhDoq7ysC5frC/pQBQtqfd6j0+mYmdj4boqkZjXL0PQxyVT0r8KyMnyCnO9o1S7Fe
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 610877963677456600
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 06/12] selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc
Date:   Sat, 29 Jul 2023 16:46:58 +0800
Message-Id: <20230729084658.7710-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729083530.GN956@1wt.eu>
References: <20230729083530.GN956@1wt.eu>
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

> On Fri, Jul 28, 2023 at 04:28:17AM +0800, Zhangjin Wu wrote:
> > The little-endian powerpc64le compilers provided by Ubuntu and Fedora
> > are able to compile big endian kernel and big endian nolibc-test [1].
> > 
> > These default CROSS_COMPILE settings allow to test target architectures
> > with:
> > 
> >     $ cd /path/to/tools/testing/selftests/nolibc/
> > 
> >     $ for arch in ppc ppc64 ppc64le; do \
> >         make run-user ARCH=$arch | grep "status: "; \
> >       done
> > 
> > If want to use another cross compiler, please simply pass CROSS_COMPILE
> > or CC as before.
> > 
> > For example, it is able to build 64-bit nolibc-test with the big endian
> > powerpc64-linux-gcc crosstool from [2]:
> > 
> >     $ wget -c https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
> >     $ tar xvf x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
> >     $ export PATH=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/:$PATH
> > 
> >     $ export CROSS_COMPILE_ppc64=powerpc64-linux-
> >     $ export CROSS_COMPILE_ppc64le=powerpc64-linux-
> >     $ for arch in ppc64 ppc64le; do \
> >         make run-user ARCH=$arch | grep "status: "; \
> >       done
> > 
> > Or specify CC directly with full path:
> > 
> >     $ export CC=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc
> >     $ for arch in ppc64 ppc64le; do \
> >         make run-user ARCH=$arch | grep "status: "; \
> >       done
> > 
> > [1]: https://github.com/open-power/skiboot
> > [2]: https://mirrors.edge.kernel.org/pub/tools/crosstool/
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 3f15c7f7ef76..6385915d16c9 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -46,6 +46,9 @@ IMAGE            = $(IMAGE_$(XARCH))
> >  IMAGE_NAME       = $(notdir $(IMAGE))
> >  
> >  # CROSS_COMPILE: cross toolchain prefix by architecture
> > +CROSS_COMPILE_ppc       ?= powerpc-linux-gnu-
> > +CROSS_COMPILE_ppc64     ?= powerpc64le-linux-gnu-
> > +CROSS_COMPILE_ppc64le   ?= powerpc64le-linux-gnu-
> >  CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
> 
> It seems to me that this patch and the previous one were rather
> for the PPC series as I'm not seeing the relation with the tiny
> config here.
>

Yes, it is also ok for the powerpc series, they mainly aim to the fast
build and test goal of 'tinyconfig', and the other default
CROSS_COMPILE's will be added together with the left tinyconfig support
by architecture.

I'm ok if you are happy to merge it into the powerpc series, then, we can focus
on the left ones ;-)

Thanks,
Zhangjin


> Willy
