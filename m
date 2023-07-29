Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CED767CC4
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 09:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjG2HdC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 03:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjG2HdC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 03:33:02 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03B91DE;
        Sat, 29 Jul 2023 00:33:00 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36T7WtGi004247;
        Sat, 29 Jul 2023 09:32:55 +0200
Date:   Sat, 29 Jul 2023 09:32:55 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: mmap_munmap_good: fix up return value
Message-ID: <20230729073255.GG956@1wt.eu>
References: <20230725164336.57767-1-falcon@tinylab.org>
 <22a7d455-347b-4435-a494-428edab771e3@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22a7d455-347b-4435-a494-428edab771e3@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 26, 2023 at 08:16:02AM +0200, Thomas Weiﬂschuh wrote:
> On 2023-07-26 00:43:36+0800, Zhangjin Wu wrote:
> > The other tests use 1 as failure, mmap_munmap_good uses -1 as failure,
> > let's fix up this.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> 
> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied, thanks to you both.
Willy
