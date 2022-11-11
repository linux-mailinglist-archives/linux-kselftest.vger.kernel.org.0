Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9F6256D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 10:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiKKJ3u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 04:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiKKJ3d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 04:29:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152A6116;
        Fri, 11 Nov 2022 01:29:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C95E222237;
        Fri, 11 Nov 2022 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668158970;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1dVUIpFQi8O7Feo048ZZ65SBEEuoI/CXn0xkHOeIQ8=;
        b=LZdrByDsfEwPhehQVcHHbocAJpkj6zR2HNxwZf7CERcVw9IZNSpweoj2AjG27HK+t/ZCBX
        mZj4iULIoNXFmrloqCiJmx8LLzvB82fWehyAZyEqQKyXc8eCHrc5kNSipU7vdsNeEHkZ1k
        p7kw37TBqMli/YQkAQpbe/zmXj4HSLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668158970;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1dVUIpFQi8O7Feo048ZZ65SBEEuoI/CXn0xkHOeIQ8=;
        b=ntvSU9jJFb8JO/N/C45DbT7XTcQeW8VRLcv/T1eopJaPSfX3aijtLJ7dx94qOUCXaxZ0E5
        0E9hnRihOKha/ECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A04B13273;
        Fri, 11 Nov 2022 09:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JCK3GPoVbmOQYgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 11 Nov 2022 09:29:30 +0000
Date:   Fri, 11 Nov 2022 10:29:28 +0100
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
Message-ID: <Y24V+AUuivt1F/Kw@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <Y2l89dt/t8M6+9go@pevik>
 <Y22DiF5Q5EDUIrZE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y22DiF5Q5EDUIrZE@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Mon, Nov 07, 2022 at 10:47:33PM +0100, Petr Vorel wrote:
> > Hi Minchan,

> > > On Mon, Nov 07, 2022 at 08:11:35PM +0100, Petr Vorel wrote:
> > > > Hi all,

> > > > following bug is trying to workaround an error on ppc64le, where
> > > > zram01.sh LTP test (there is also kernel selftest
> > > > tools/testing/selftests/zram/zram01.sh, but LTP test got further
> > > > updates) has often mem_used_total 0 although zram is already filled.

> > > Hi, Petr,

> > > Is it happening on only ppc64le?
> > I haven't seen it on other archs (x86_64, aarch64).

> > > Is it a new regression? What kernel version did you use?
> > Found on openSUSE kernel, which uses stable kernel releases 6.0.x.
> > It's probably much older, first I've seen it some years ago (I'm not able to find kernel version), but it was random. Now it's much more common.

> > Test runs on VM (I can give qemu command or whatever you need to know about it)
> > I'll try to verify it on some bare metal ppc64le.

> Hi Petr and Martin,

> Thanks for testing and meaning information.

> Could you tell how I could create VM to run ppc64le and run the test?
> I'd like to reproduce in my local to debug it.
I suppose you don't have ppc64le bare metal machine, thus you run on x86_64.

One way would be to install on host qemu-system-ppc64, download iso image of any
distro which supports ppc64le and install it with virt-manager (which would fill
necessary qemu params).

Other way, which I often use is to compile system with Buildroot distribution.
You can clone my Buildroot distro fork, branch debug/zram [1].
I put there in 3 commits my configuration.
I added 0001-zram-Debug-mm_stat_show.patch [2] on the top of 6.0.7 with little debugging.

What is now only needed is to 1) install on host qemu-system-ppc64
(speedup build + Buildroot is configured not to compile qemu-system-ppc64),
then:
$ make # takes time
$ ./output/images/start-qemu.sh serial-only

When I have ppc64le host with enough space, I often use rapido [3],
but that crashed stable kernel (another story which I'll report soon).

Hope that helps.

Kind regards,
Petr

[1] https://github.com/pevik/buildroot/commits/debug/zram
[2] https://github.com/pevik/buildroot/blob/debug/zram/0001-zram-Debug-mm_stat_show.patch
[3] https://github.com/rapido-linux/rapido
