Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58B62016D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 22:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiKGVrk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 16:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiKGVrj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 16:47:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EC927FF5;
        Mon,  7 Nov 2022 13:47:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72B141F889;
        Mon,  7 Nov 2022 21:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667857656;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlVbo42sNig1NHmDEtnPq6ibjLSSFwdkdUylt0cyH2Q=;
        b=Tgk9qSm80ZFvuHAk2hjDWm9hmWHyMAFhJeIzscpPPIs0Glsh57hT4wRdgBiqhX62Ajz7qW
        ePM/ABozz8yo5scLagq6XTzh2fSyE0O0GFNKCWi6m1EoTO41NhkHb0UnekHUr6YfSsf7XA
        qf0HL5kAvwWNtre+MRgIF53024nO9J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667857656;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlVbo42sNig1NHmDEtnPq6ibjLSSFwdkdUylt0cyH2Q=;
        b=vEJQnljCKIsMt0jZnSmxqtA6QM7E66/z63M7wHL5TIEsbPv1j6QdnP892ieVefiZ6EZbgj
        BRlcDqfoSETxBOCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14CFD13AC7;
        Mon,  7 Nov 2022 21:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZY5FA/h8aWOrKgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 07 Nov 2022 21:47:36 +0000
Date:   Mon, 7 Nov 2022 22:47:33 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Minchan Kim <minchan@kernel.org>
Cc:     ltp@lists.linux.it, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Martin Doucha <mdoucha@suse.cz>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <Y2l89dt/t8M6+9go@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2l3vJb1y2Jynf50@google.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Minchan,

> On Mon, Nov 07, 2022 at 08:11:35PM +0100, Petr Vorel wrote:
> > Hi all,

> > following bug is trying to workaround an error on ppc64le, where
> > zram01.sh LTP test (there is also kernel selftest
> > tools/testing/selftests/zram/zram01.sh, but LTP test got further
> > updates) has often mem_used_total 0 although zram is already filled.

> Hi, Petr,

> Is it happening on only ppc64le?
I haven't seen it on other archs (x86_64, aarch64).

> Is it a new regression? What kernel version did you use?
Found on openSUSE kernel, which uses stable kernel releases 6.0.x.
It's probably much older, first I've seen it some years ago (I'm not able to find kernel version), but it was random. Now it's much more common.

Test runs on VM (I can give qemu command or whatever you need to know about it)
I'll try to verify it on some bare metal ppc64le.

> Actually, mem_used_total indicates how many *physical memory* were
> currently used to keep original data size.

> However, if the test data is repeated pattern of unsigned long
> (https://github.com/torvalds/linux/blob/master/drivers/block/zram/zram_drv.c#L210)
> zram doesn't allocate the physical memory but just mark the unsigned long's value
> in meta area for decompression later.

> Not sure you hit the this case.
Thanks for a hint, I'll try to debug it.

Kind regards,
Petr

> > Patch tries to repeatedly read /sys/block/zram*/mm_stat for 1 sec,
> > waiting for mem_used_total > 0. The question if this is expected and
> > should be workarounded or a bug which should be fixed.

> > REPRODUCE THE ISSUE
> > Quickest way to install only zram tests and their dependencies:
> > make autotools && ./configure && for i in testcases/lib/ testcases/kernel/device-drivers/zram/; do cd $i && make -j$(getconf _NPROCESSORS_ONLN) && make install && cd -; done

> > Run the test (only on vfat)
> > PATH="/opt/ltp/testcases/bin:$PATH" LTP_SINGLE_FS_TYPE=vfat zram01.sh

> > Petr Vorel (1):
> >   zram01.sh: Workaround division by 0 on vfat on ppc64le

> >  .../kernel/device-drivers/zram/zram01.sh      | 27 +++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)

> > -- 
> > 2.38.0

