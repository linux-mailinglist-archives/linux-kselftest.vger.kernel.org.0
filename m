Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA657D57B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 18:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjJXQOQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 12:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXQOP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 12:14:15 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1286A1;
        Tue, 24 Oct 2023 09:14:13 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 39OGDsID004135;
        Tue, 24 Oct 2023 18:13:54 +0200
Date:   Tue, 24 Oct 2023 18:13:54 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] selftests/nolibc: use EFI -bios for LoongArch qemu
Message-ID: <ZTftQtrB0LL0nNK/@1wt.eu>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
 <20231010-nolibc-out-of-tree-v1-2-b6a263859596@weissschuh.net>
 <20231022092046.GC2669@1wt.eu>
 <74f121c7-5356-4e58-87ca-e93fe48ccc39@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74f121c7-5356-4e58-87ca-e93fe48ccc39@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 06:06:11PM +0200, Thomas Weißschuh  wrote:
> Oct 22, 2023 11:21:16 Willy Tarreau <w@1wt.eu>:
> 
> > On Tue, Oct 10, 2023 at 02:33:57PM +0200, Thomas Weißschuh wrote:
> >> qemu for LoongArch does not work properly with direct kernel boot.
> >> The kernel will panic during initialization and hang without any output.
> >>
> >> When booting in EFI mode everything work correctly.
> >>
> >> While users most likely don't have the LoongArch EFI binary installed at
> >> least an explicit error about 'file not found' is better than a hanging
> >> test without output that can never succeed.
> >
> > Agreed. Let's hope at least users will be able to figure what's
> > missing depending on the message. There's one thing, though, you
> > hard-coded the path to the file system, and it's unlikely to be
> > located at the same place for everyone:
> >
> >    -bios /usr/share/edk2/loongarch64/OVMF_CODE.fd
> >
> > Sure, it's also possible to force QEMU_ARGS but it's becoming complicated
> > due to the numerous arguments. Maybe use a QEMU_BIOS_loongarch variable
> > for this ? This way if this starts to generalize to other archs, we can
> > later simplify it and automatically append -bios when needed.
> 
> My hope was for it to be a purely temporary bandaid.
> But you are right, let's do it properly from the beginning.

The right way to think about temporary code is that if it's supposed to
be quick to address, you don't want to introduce a temporary way of
proceeding that will change later as the change will annoy some users.
And if the reason for the temporary step is a temporary difficulty, you
can be certain nobody will ever try to address it and that temporary
will be definitive. So thinking "temporary" should generally ring a
bell "am I going to annoy users for no reason or am I putting myself in
a wrong corner". That's why I really try to avoid anything "temporary".
(But there's no problem with making the wrong choice and regretting
later, of course ;-)).

Cheers,
Willy
