Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7A74CDE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 09:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGJHE0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 03:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGJHEZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 03:04:25 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2A1AE9;
        Mon, 10 Jul 2023 00:04:23 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36A747rJ018067;
        Mon, 10 Jul 2023 09:04:07 +0200
Date:   Mon, 10 Jul 2023 09:04:07 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: Re: [PATCH v6 13/15] selftests/nolibc: add mmap_bad test case
Message-ID: <ZKutZwIOfy5MqedG@1wt.eu>
References: <20230709091547.GD9321@1wt.eu>
 <20230709183322.96859-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709183322.96859-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Mon, Jul 10, 2023 at 02:33:22AM +0800, Zhangjin Wu wrote:
> For qemu-user, I have rechecked the following version:
> 
>     $ qemu-x86_64 --version
>     qemu-x86_64 version 4.2.1 (Debian 1:4.2-3ubuntu6.18)
> 
>     $ qemu-x86_64 --version
>     qemu-x86_64 version 7.0.0 (Debian 1:7.0+dfsg-7ubuntu2.6~backport20.04.202306190332~ubuntu20.04.1)
> 
>     $ build/x86_64/pc/qemu/v8.0.2/qemu-x86_64 --version
>     qemu-x86_64 version 8.0.2 (v8.0.2-dirty)
> 
> all of them work well, as a comparison, what's your qemu-user version?

Spot on! I ran it remotely and had a different qemu in my default path:

  $ qemu-x86_64 --version
  qemu-x86_64 version 2.7.0, Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers

I didn't notice but it yells at me during the test:

  qemu: Unsupported syscall: 332

Locally with this version it's much cleaner:

  $ qemu-x86_64 --version
  qemu-x86_64 version 6.2.0
  Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers
  $ make run-user | grep status:
  143 test(s): 141 passed,   2 skipped,   0 failed => status: warning

So we can keep it and blame my environment for that failure.

Thanks for checking,
Willy
