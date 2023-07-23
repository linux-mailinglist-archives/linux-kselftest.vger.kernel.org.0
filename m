Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E575E071
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jul 2023 10:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjGWIPl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Jul 2023 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWIPl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Jul 2023 04:15:41 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25AAEE41;
        Sun, 23 Jul 2023 01:15:37 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36N8FK17019773;
        Sun, 23 Jul 2023 10:15:20 +0200
Date:   Sun, 23 Jul 2023 10:15:20 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Message-ID: <20230723081520.GA19768@1wt.eu>
References: <cover.1689713175.git.falcon@tinylab.org>
 <f733876f6e711c37afc3c34a71b241c9f734d62e.1689713175.git.falcon@tinylab.org>
 <64a95595-9716-4276-a747-0c985997c1ab@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64a95595-9716-4276-a747-0c985997c1ab@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 23, 2023 at 09:32:37AM +0200, Thomas Weißschuh wrote:
> On 2023-07-19 05:10:48+0800, Zhangjin Wu wrote:
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

In fact it depends. If code was taken there, not only the copyright is
needed, but the license' compatibility must be verified. If, however,
the code was only disassembled to be understood and reimplemented (as
it seems to me), then no code was taken there and it's not needed.

Thanks,
Willy
