Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C6771350
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 05:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjHFDLr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 23:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHFDLq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 23:11:46 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3C21FE3;
        Sat,  5 Aug 2023 20:11:40 -0700 (PDT)
X-QQ-mid: bizesmtp84t1691291487tssduu4n
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 11:11:26 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: CR3LFp2JE4nboq28VJZElwwxerbkOQA/h6OX31e6jdysPA4Z72TbeYkM7Q4aw
        q9prSqgqwtPVqTpQjlGJ7/0y8cLdXg8ph4OdeOqnykkYP0ZSzivSKdx97Vypho+dxQw5kqq
        j/4g0lZhpv270TPFgyYLIsY1UgEG5u7/71CXvC8kErMF65yNU7+RZMJAhT9UiRlZzIA64sP
        WZ+o7irh9vX63y0vsa+DJU0Aeb/YmiMl0HSEz7IqwhxxIV2DDutP5qdJ/R8wqNp6hC+PXrY
        7z3q3cW3ZoJSqLpLIbulludgekYZxhlxynkbfRxBtQ5eeVXc9nUk7tCVvPy2gmn9yD+o9gz
        2t56BrgriflX1tiHo96K7UwwToy9iqkO36RG9by/iS3Qiwt1z1defyT/EzoP6U8A7F1eWtu
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13213960197169536215
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v6 8/8] selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc
Date:   Sun,  6 Aug 2023 11:11:25 +0800
Message-Id: <20230806031125.6800-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230805204845.GA7300@1wt.eu>
References: <20230805204845.GA7300@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Sun, Aug 06, 2023 at 02:47:09AM +0800, Zhangjin Wu wrote:
> > The little-endian powerpc64le compilers provided by Ubuntu and Fedora
> > are able to compile big endian kernel and big endian nolibc-test [1].
> 
> FWIW I'm wondering why focusing on these ones which have a different
> naming from the other ones, when I think that most users rely on the
> ones maintained by Arnd there:
> 
>    https://mirrors.edge.kernel.org/pub/tools/crosstool/
>

Arnd's toolchains may be a more distribution independent ones.

> Yours is called powerpc64le while the one above is "powerpc64", it
> requires to make an exception for this one, I find this a bit odd.
> 

Yes, one is little endian output by default, another may be big endian output
by default.

> If someone wants to use their distro's cross toolchain, that's fine,
> but I think that it will depend on distros anyway and some may not
> even be provided (like loongarch) so I think it would make more sense
> to adopt the canonical naming from Arnd's toolchains above.
>

Agree very much, let's switch to Arnd's toolchains.

> It's not critical, but as you showed below, it makes building for ppc
> a little bit cumbersome: those "export" lines could be dropped when
> using the default names, and that's what we should document as the
> recommended way to test:
> 
> > For example, it is able to build 64-bit nolibc-test with the big endian
> > powerpc64-linux-gcc crosstool from [2]:
> > 
> >     $ wget -c https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
> >     $ tar xvf x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
> >     $ export PATH=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/:$PATH
> > 
> >     $ export CROSS_COMPILE_ppc=powerpc64-linux-
> >     $ export CROSS_COMPILE_ppc64=powerpc64-linux-
> >     $ export CROSS_COMPILE_ppc64le=powerpc64-linux-
> >     $ for arch in ppc ppc64 ppc64le; do \
> >         make run-user XARCH=$arch | grep "status: "; \
> >       done
> 
> Any opinion on this ?
>

Ok, let's go this way, if the others are ok for you, could you please
drop the last two CROSS_COMPILE patches from this v6 ppc series? Thanks.

I will send v2 CROSS_COMPILE series with them, with Arnd's toolchains, the
whole CROSS_COMPILE series will be unified and become very simple, although
they need to download the toolchains manually one by one, but it is possible to
write a common script, but that is another requirement.

BR,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1691259983.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/lkml/cover.1691263493.git.falcon@tinylab.org/

> Thanks,
> Willy
