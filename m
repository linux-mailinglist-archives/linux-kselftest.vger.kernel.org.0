Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E9174C1BD
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 11:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGIJmF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGIJmE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 05:42:04 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 615F1D2;
        Sun,  9 Jul 2023 02:42:03 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3699fslL021029;
        Sun, 9 Jul 2023 11:41:54 +0200
Date:   Sun, 9 Jul 2023 11:41:54 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v4 00/18] selftests/nolibc: allow run with minimal kernel
 config
Message-ID: <20230709094154.GI9321@1wt.eu>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Sat, Jul 08, 2023 at 02:21:20AM +0800, Zhangjin Wu wrote:
> This patchset assumes the chmod_net removal patchset will be applied at
> first, if not, the chmod_argv0 added alphabetically will not be applied.
> Since our new chmod_argv0 is exactly added to replace chmod_net, so,
> Willy, is it ok for you to at least apply the chmod_net removal patch
> [5] before this patchset?

Sure, and thanks for the reminder, I had missed it in the middle of
the flood.

(...)
>     LOG: testing summary:
> 
>           arch/board | result
>          ------------|------------
>      arm/vexpress-a9 | 139 test(s) passed, 4 skipped, 0 failed.
>            x86_64/pc | 139 test(s) passed, 4 skipped, 0 failed.
>         mipsel/malta | 139 test(s) passed, 4 skipped, 0 failed.
>     loongarch64/virt | 139 test(s) passed, 4 skipped, 0 failed.

Great, I like this, thank you! That was precisely the purpose of the
"skipped" initially, not to be too strictly bound to a specific config.
Now it's indeed even more flexible and that's better.

Series queued as well, thank you!
Willy
