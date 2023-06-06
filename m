Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941D972367B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 06:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjFFEu6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 00:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFFEu6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 00:50:58 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4235C109;
        Mon,  5 Jun 2023 21:50:55 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3564od2B017477;
        Tue, 6 Jun 2023 06:50:39 +0200
Date:   Tue, 6 Jun 2023 06:50:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        paulmck@kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH 0/4] selftests/nolibc: fix up and improve test report
Message-ID: <ZH67HwwLe89OPmuj@1wt.eu>
References: <ZH2BhWcRzvmvjzn8@1wt.eu>
 <20230605105332.245553-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605105332.245553-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 05, 2023 at 06:53:32PM +0800, Zhangjin Wu wrote:
> > On Mon, Jun 05, 2023 at 11:47:41AM +0800, Zhangjin Wu wrote:
> > > Thanks very much for your merge of the v3 generic part1 of rv32, just
> > > tested your latest 20230604-nolibc-rv32+stkp6 branch, everything work
> > > well except a trivial test report regression on the 'run' target.
> > (...)
> > 
> > I've squashed your fix into the pending patch and pushed branch
> > 20230605-nolibc-rv32+stkp7. I have only tested userland (I really
> > need to leave now, no time for a kernel build).
> >
> 
> Just did kernel build + nolibc test for arm, aarch64 and rv64, no regressions
> found.

Much appreciated, thank you. This evening I'll try the remaining
archs as I already have the cross-compilers, then will give Paul
the go.

Cheers,
Willy
