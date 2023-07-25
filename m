Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03C4761A8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGYNvX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 09:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGYNvW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 09:51:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C871BFF;
        Tue, 25 Jul 2023 06:51:19 -0700 (PDT)
X-QQ-mid: bizesmtp83t1690293068t9189ec4
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 21:51:07 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: XBN7tc9DADII+fP1EuPXpwvh6XPoiBBDHaqveq7Ufvo8BQskYzQWP06HshBZD
        rMIWC407aPQSJyKFUB3uANbaKCTPQYlU6e/toOnkkb5pNKRGTXFoV318EuJqKgSeVDGsCWe
        ZSTADpnaxn2LkkRNLhiNZBQxp7gBNsbOyYuCwRiDQqhD5wTW4TSkwpFwUqwKALvnwg+5Ebo
        9M1hOn2GqvUL7qQJgzFhXT0mBXpO4vaK2XtnmTC9WMPNnxWYD0L8v38rNoK+r50gwjBPaYU
        vinykyrq+ck3uI62bMefifuS4yZJF8qR9FajSzm0rayTqzpFyTs0ZZFbZfU8fKKCjRfiAeU
        +U3XuV2gdeVpvJJotMH5lKOkVlqjosxHOBbT5eOZJ2pbQ/y0P/hbBfn1OjvhMQruVS+qMqH
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16644163374968043209
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 05/14] selftests/nolibc: add menuconfig for development
Date:   Tue, 25 Jul 2023 21:51:06 +0800
Message-Id: <20230725135106.36543-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230722123527.GG17311@1wt.eu>
References: <20230722123527.GG17311@1wt.eu>
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

> On Wed, Jul 19, 2023 at 09:22:37PM +0800, Zhangjin Wu wrote:
> > The default DEFCONFIG_<ARCH> may not always work for all architectures,
> > let's allow users to tune some kernel config options with 'menuconfig'.
> > 
> > This is important when porting nolibc to a new architecture, it also
> > allows to speed up nolibc 'run' target testing via manually disabling
> > tons of unnecessary kernel config options.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 058e7be070ea..06954b4b3885 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -202,6 +202,9 @@ KERNEL_IMAGE  = $(objtree)/$(IMAGE)
> >  defconfig:
> >  	$(Q)$(MAKE_KERNEL) mrproper $(DEFCONFIG) prepare
> >  
> > +menuconfig:
> > +	$(Q)$(MAKE_KERNEL) menuconfig
> 
> What is the real benefit of this compared to just running the
> standard "make menuconfig" ? We should avoid adding makefile targets
> that do not bring value on top of that the top-level makefile does,
> because it will make the useful ones much harder to spot, and will
> tend to encourage users to use only that makefile during the tests,
> which is a bad practice since many targets will always be missing
> or work differently. It's important in my opinion that we strictly
> stick to what is useful to operate the tests themselves and this
> one doesn't make me feel like it qualifies as such.

Ok, get it.

I did like develop nolibc in tools/testing/selftests/nolibc/ without
changing directories frequently or specifying the "-C" option
unnecessary ;-) 

Since "make menuconfig" is only required during the first porting of a new
architecture, so, it is ok to drop this patch.

Thanks,
Zhangjin

> 
> Willy
