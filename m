Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566DD72244D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 13:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjFELMk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 07:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjFELMi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 07:12:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3587FF9;
        Mon,  5 Jun 2023 04:12:32 -0700 (PDT)
X-QQ-mid: bizesmtp73t1685963542tue2ikmf
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Jun 2023 19:12:20 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: OFQdrTmJ2CTPW1rKDCObcDNnOiZf5G7OS3ydy8gWgcFCDkj+ygtkUgsn400hH
        XcSUWjIUNzPtaf8xdx7SFAnkqm4qlz8q1TNpP2NF7JMWaqIsoZlribWjxH/w1NEo7SbyC5b
        F92p0FGK7JG8wnYKGctbxx6aeT4sz7bKph2fDS5AZpiMLMwk24QctEz8nrwFI6Q1E6Pib2U
        jt5K73G2WlUJGRP5WBbIheVih803jE07C36L5wdUjHC/1cpE/7qTPuGiphDybYWA+244CtI
        jRzwIlx9YqZfIlDJqF99mh2vl/FSgqnL3nxqsgmq1plH+Gxcjh4nrk1izDcpUc34YW5KdsJ
        KLxbUW52+5Oc0+lMblXBmrdRMNdM1huR0Axg8p3D0BBu+d+7gxM6YL82yirIg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5716039531870868684
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v3 11/12] selftests/nolibc: add new gettimeofday test cases
Date:   Mon,  5 Jun 2023 19:12:20 +0800
Message-Id: <20230605111220.252069-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZHx1OliMqHx9U1Lw@1wt.eu>
References: <ZHx1OliMqHx9U1Lw@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sun, Jun 04, 2023 at 11:24:39AM +0200, Arnd Bergmann wrote:
> > On Sun, Jun 4, 2023, at 10:29, ??? wrote:
> > >
> > > Sorry for missing part of your feedbacks, I will check if -nostdlib 
> > > stops the linking of libgcc_s or my own separated test script forgot 
> > > linking the libgcc_s manually.
> > 
> > According to the gcc documentation, -nostdlib drops libgcc.a, but
> > adding -lgcc is the recommended way to bring it back.
> > 
> > > And as suggestion from Thomas' reply,
> > >
> > >>> Perhaps we really need to add the missing __divdi3 and __aeabi_ldivmod and the
> > >>> ones for the other architectures, or get one from lib/math/div64.c.
> > >
> > >>No, these ones come from the compiler via libgcc_s, we must not try to
> > > reimplement them. And we should do our best to avoid depending on them
> > > to avoid the error you got above.
> > >
> > > So, the explicit conversion is used instead in the patch.
> > 
> > I think a cast to a 32-bit type is ideal when converting the
> > clock_gettime() result into microseconds, since the kernel guarantees
> > that the timespec value is normalized, with all zeroes in the
> > upper 34 bits. Going through __aeabi_ldivmod would make the
> > conversion much slower.
> > 

Perfectly, this message is really required to be added to the coming
clock_gettime/time64 patches, I did worry about the (unsigned int)
conversion may lose the upper bits, thanks Arnd.

> > For user supplied non-normalized timeval values, it's not obvious
> > whether we need the full 64-bit division
> 
> We don't have to care about these here for the microsecond part,
> because for decades these were exclusively 32-bit. Also the only
> one consuming this field would have been settimeofday() and it's
> already documented as returning EINVAL if tv_usec is not within
> the expected 0..999999 range.
> 

And this one, thanks Willy.

> And when in doubt we should keep in mind that nolibc's purpose is not
> to become a yet-another full-blown libc alternative but just a small
> piece of software allowing to produce portable and compact binaries
> for testing or booting. Being a bit stricter than other libcs for the
> sake of code compactness is better here. Originally for example it was
> necessary to always pass the 3 arguments to open(). Over time we managed
> to make simple code compile with both glibc and nolibc, but when it
> comes at the cost of adding size and burden for the developers, such
> as forcing them to add libgcc, I prefer that we slightly limit the
> domain of application instead.

This explains why it is 'no' libc ;-)

Best regards,
Zhangjin

> 
> Thanks!
> Willy
