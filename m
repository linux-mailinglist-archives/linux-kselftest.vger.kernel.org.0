Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4365A721E27
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 08:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjFEGc5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 02:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFEGc4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 02:32:56 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46D30DC;
        Sun,  4 Jun 2023 23:32:55 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3556WbUV005965;
        Mon, 5 Jun 2023 08:32:37 +0200
Date:   Mon, 5 Jun 2023 08:32:37 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     thomas@t-8ch.de, Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 0/4] selftests/nolibc: fix up and improve test report
Message-ID: <ZH2BhWcRzvmvjzn8@1wt.eu>
References: <cover.1685936428.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685936428.git.falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 05, 2023 at 11:47:41AM +0800, Zhangjin Wu wrote:
> Thanks very much for your merge of the v3 generic part1 of rv32, just
> tested your latest 20230604-nolibc-rv32+stkp6 branch, everything work
> well except a trivial test report regression on the 'run' target.
(...)

I've squashed your fix into the pending patch and pushed branch
20230605-nolibc-rv32+stkp7. I have only tested userland (I really
need to leave now, no time for a kernel build).

Zhangjin and Thomas, now that your last two fixes are merged, I'm
assuming that Paul can take the branch any time. If you're seeing a
showstopper that needs to be fixed, please let him know, and I'll
deal with it once I'm connected again, but please no more attempts
to further improve that branch for now (i.e. consider it merged for
any future work so that we can finally settle on something).

Thanks!
Willy
