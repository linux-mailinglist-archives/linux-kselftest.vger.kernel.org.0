Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD163759FA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 22:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjGSUZW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 16:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGSUZV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 16:25:21 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65D80171E;
        Wed, 19 Jul 2023 13:25:19 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36JKP5UU006864;
        Wed, 19 Jul 2023 22:25:05 +0200
Date:   Wed, 19 Jul 2023 22:25:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 3/8] selftests/nolibc: select_null: fix up for big
 endian powerpc64
Message-ID: <20230719202505.GA6842@1wt.eu>
References: <20230719043353.GC5331@1wt.eu>
 <20230719064912.59792-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719064912.59792-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Wed, Jul 19, 2023 at 02:49:12PM +0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> > Hi Zhangjin,
> > 
> > On Wed, Jul 19, 2023 at 07:56:37AM +0800, Zhangjin Wu wrote:
> > > It made me recalled I have at last disabled (not enabled for tinyconfig) the following options:
> > > 
> > >     CONFIG_ALTIVEC
> > >     CONFIG_VSX --> This option enables kernel support for the Vector Scaler extensions
> > > 
> > > Or we can disable the vsx instructions explicitly:
> > > 
> > >     -mno-vsx
> > > 
> > > Both of them work well, but I prefer -mno-vsx for to get a faster build, what about you?
> > > 
> > >     +CFLAGS_powerpc64 = -m64 -mbig-endian -Wl,-EB,-melf64ppc -mno-vsx
> > >     +CFLAGS_powerpc64le = -m64 -mlittle-endian -Wl,-EL,-melf64ppc -mno-vsx
> > > 
> > > So, this patch itself is wrong, let's drop it from the next revision.
> > 
> > Better explicitly disable it in the CFLAGS (2nd option) if we want to
> > make sure we don't want to rely on this, at least for portability
> > purposes.
> 
> Ok, thanks, have updated CFLAGS in these two patches locally:
> 
>     [PATCH v1 7/8] selftests/nolibc: add test support for powerpc64le
>     [PATCH v1 8/8] selftests/nolibc: add test support for powerpc64
> 
> what about the other ones? I'm ready to send v2 ;-)

I have not had the time to review them yet. Please just don't send
another series yet, that just adds more noise and makes it hard to
distinguish all of them. I hope to be able to check these and hopefully
the tinyconfig series by the week-end.

Thanks,
Willy
