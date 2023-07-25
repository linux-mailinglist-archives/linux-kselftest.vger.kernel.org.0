Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2AE7609F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 08:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjGYGDI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 02:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjGYGC6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 02:02:58 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE9CF19C;
        Mon, 24 Jul 2023 23:02:55 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36P62XYK025841;
        Tue, 25 Jul 2023 08:02:33 +0200
Date:   Tue, 25 Jul 2023 08:02:33 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 8/8] selftests/nolibc: add test support for powerpc64
Message-ID: <ZL9leVOI25S2+0+g@1wt.eu>
References: <20230722121019.GD17311@1wt.eu>
 <20230725055031.15203-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725055031.15203-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 25, 2023 at 01:50:31PM +0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> > 
> > On Wed, Jul 19, 2023 at 05:18:32AM +0800, Zhangjin Wu wrote:
> > >  # ARCH is supported by kernel
> > > +ARCH_powerpc64   = powerpc
> > >  ARCH_powerpc64le = powerpc
> > 
> > And similarly let's simply call this one ppc64.
> >
> 
> Well, I like these short ones too, what about also a ppc alias for
> powerpc?
> 
>     ARCH_ppc     = powerpc
>     ARCH_ppc64   = powerpc
>     ARCH_ppc64le = powerpc

I thought about it as well. It could avoid the confusion between the
arch name (powerpc) that's used for both 32/64 and the user-requested
one.

Willy
