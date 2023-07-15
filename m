Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649B8754818
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 12:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGOKB7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 06:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGOKB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 06:01:58 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D3B8CE;
        Sat, 15 Jul 2023 03:01:54 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36FA1YHU025601;
        Sat, 15 Jul 2023 12:01:34 +0200
Date:   Sat, 15 Jul 2023 12:01:34 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 00/11] tools/nolibc: shrink arch support
Message-ID: <20230715100134.GD24086@1wt.eu>
References: <cover.1689150149.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689150149.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 12, 2023 at 05:15:28PM +0800, Zhangjin Wu wrote:
> Hi, Willy, Thomas
> 
> Here is the revision of the v2 arch support shrink patchset [1], it
> mainly applies suggestions from you.
> 
> It is based on the 20230710-nolibc-ser2-tom-syscall-configv4-report
> branch of nolibc repo.
> 
> Tested for all of the supported archs:
> 
>            arch/board | result
>           ------------|------------
>       arm/versatilepb | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
>       arm/vexpress-a9 | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
>              arm/virt | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
>          aarch64/virt | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
>               i386/pc | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
>             x86_64/pc | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
>          mipsel/malta | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
>      loongarch64/virt | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
>          riscv64/virt | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
>          riscv32/virt | 151 test(s): 122 passed,   7 skipped,  22 failed => status: failure.
> s390x/s390-ccw-virtio | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.

Thanks for all this work. So I've checked a few random archs and trust
your tests above to confirm they're correct ;-)  I'd just like to get
your confirmation regarding statx() support in 4.14 and 4.19, and likely
adjust _start_c() according to the last few tests. Also please do prepend
to the list the patch that adds the optimize("-Os") to fix _start, and we
should be good.

Thanks!
Willy
