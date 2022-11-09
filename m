Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E11623651
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 23:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKIWIJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 17:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiKIWIJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 17:08:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BBF2D771;
        Wed,  9 Nov 2022 14:08:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DDD1F337BA;
        Wed,  9 Nov 2022 22:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668031686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7urUNskayTd1SGPbO2jRA+qHJ9m4P64m8g/fnY2xxEc=;
        b=P8uXFlGhXKDLvAC/8peds9cZpAHDUAwEzRuseDyVYNHKwSPR/HYHBUm9H7Ur1a2lUIcyeH
        qT4u4B91xFS9SKUsVBIJnSptB0p8Gm7WNZE8i+HHSIn+IFg3omAQSUapC/n6puNDwZkdU2
        DAA/cr+hKvUlUwIoVE3nDVMIJM/Vz94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668031686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7urUNskayTd1SGPbO2jRA+qHJ9m4P64m8g/fnY2xxEc=;
        b=2KI7jo8WCBbi0rC6LB2o4uN2Dx9AP/bVharrGirY9awbEubefsqGuks6uGs9nzzo3qkxyK
        BFrH3x45c+mNGaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AB4A139F1;
        Wed,  9 Nov 2022 22:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GbG1FMYkbGM/GQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 09 Nov 2022 22:08:06 +0000
Date:   Wed, 9 Nov 2022 23:08:04 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>, ltp@lists.linux.it,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Martin Doucha <mdoucha@suse.cz>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <Y2wkxBEnbP9jM0h3@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <Y2l89dt/t8M6+9go@pevik>
 <Y2mJ42Ap7VIZu32Y@pevik>
 <Y2mrRxHhVi/QEiUf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2mrRxHhVi/QEiUf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sergey, Minchan, all,


> On (22/11/07 23:42), Petr Vorel wrote:
> [..]
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TBROK: "loop_read_mem_used_total /sys/block/zram1/mm_stat" timed out

> Looking at mm_stat_show(), mem_used can be 0 when mm_stat_show() is
> called on un-initialized device

> ---
> ...
>         u64 orig_size, mem_used = 0;
>         long max_used;
>         ssize_t ret;

>         memset(&pool_stats, 0x00, sizeof(struct zs_pool_stats));

>         down_read(&zram->init_lock);
>         if (init_done(zram)) {
>                 mem_used = zs_get_total_pages(zram->mem_pool);
>                 zs_pool_stats(zram->mem_pool, &pool_stats);
>         }
> ...
> ---

> Can you check if init_done() returns true in your tests?

I'm sorry, it took me some time to find machine where I'd be compile kernel.
Yes, init_done() returns non-zero (1), code goes into if clause and sets
mem_used. I'll check also for mem_used value.

Kind regards,
Petr
