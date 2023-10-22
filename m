Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04E87D220E
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Oct 2023 11:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjJVJVP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Oct 2023 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVJVP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Oct 2023 05:21:15 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A162BF4;
        Sun, 22 Oct 2023 02:21:10 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 39M9KkTY003523;
        Sun, 22 Oct 2023 11:20:46 +0200
Date:   Sun, 22 Oct 2023 11:20:46 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] selftests/nolibc: use EFI -bios for LoongArch qemu
Message-ID: <20231022092046.GC2669@1wt.eu>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
 <20231010-nolibc-out-of-tree-v1-2-b6a263859596@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010-nolibc-out-of-tree-v1-2-b6a263859596@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Tue, Oct 10, 2023 at 02:33:57PM +0200, Thomas Weiﬂschuh wrote:
> qemu for LoongArch does not work properly with direct kernel boot.
> The kernel will panic during initialization and hang without any output.
> 
> When booting in EFI mode everything work correctly.
> 
> While users most likely don't have the LoongArch EFI binary installed at
> least an explicit error about 'file not found' is better than a hanging
> test without output that can never succeed.

Agreed. Let's hope at least users will be able to figure what's
missing depending on the message. There's one thing, though, you
hard-coded the path to the file system, and it's unlikely to be
located at the same place for everyone:

   -bios /usr/share/edk2/loongarch64/OVMF_CODE.fd

Sure, it's also possible to force QEMU_ARGS but it's becoming complicated
due to the numerous arguments. Maybe use a QEMU_BIOS_loongarch variable
for this ? This way if this starts to generalize to other archs, we can
later simplify it and automatically append -bios when needed.

> Link: https://lore.kernel.org/loongarch/1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de/
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> ---
> Note: I'm wondering how this worked for anybody else.

Not much surprised. As I mentioned, my qemu currently doesn't support
loongarch so I didn't boot that one. Maybe Zhangjin had this one as
part of his other patches.

Overall, on the principle, Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy
