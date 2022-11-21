Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4256631D01
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 10:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKUJlS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 04:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiKUJlR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 04:41:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F4F51C08;
        Mon, 21 Nov 2022 01:41:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89EBD21AC3;
        Mon, 21 Nov 2022 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669023675;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x4svcpQifmjNQouc72E4WUVyl0JmTYJ7FIcleg5VVfk=;
        b=Za0f7AJe52OAjDc+cUdFIv/Y3rnSPBO8l20gpsDrU1H93th+sbNje4hWKKXjRqFXYV3YrY
        RqVP7Mcm/stCzCkCyaKDEXv1yAc9FnowwdBJbI8KnQ9J4peC3pcY/zvjV41XJ1jrL4svS/
        gyMG0jMUz7BfWw+tSp9ZGPMdecMJuTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669023675;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x4svcpQifmjNQouc72E4WUVyl0JmTYJ7FIcleg5VVfk=;
        b=NFMaWY01+uSO0f1Y0Zr7QgM+Cnj/KWqdg9BIFqEYLqsVklQOuUf4c23ApJ7B9VcYgP5ynm
        +M8hE/zF9aNf0vCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26C491377F;
        Mon, 21 Nov 2022 09:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fMYECLtHe2MkdAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 21 Nov 2022 09:41:15 +0000
Date:   Mon, 21 Nov 2022 10:41:13 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Martin Doucha <mdoucha@suse.cz>, Minchan Kim <minchan@kernel.org>,
        ltp@lists.linux.it, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <Y3tHuWygsBqmmpwV@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
 <Y22b3wWs2QfMjJHi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y22b3wWs2QfMjJHi@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sergey,

> On (22/11/10 15:29), Martin Doucha wrote:
> > New version of LTP test zram01 found a sysfile issue with zram devices
> > mounted using VFAT filesystem. When when all available space is filled, e.g.
> > by `dd if=/dev/zero of=/mnt/zram0/file`, the corresponding sysfile
> > /sys/block/zram0/mm_stat will report that the compressed data size on the
> > device is 0 and total memory usage is also 0. LTP test zram01 uses these
> > values to calculate compression ratio, which results in division by zero.

> > The issue is specific to PPC64LE architecture and the VFAT filesystem. No
> > other tested filesystem has this issue and I could not reproduce it on other
> > archs (s390 not tested). The issue appears randomly about every 3 test runs
> > on SLE-15SP2 and 15SP3 (kernel 5.3). It appears less frequently on SLE-12SP5
> > (kernel 4.12). Other SLE version were not tested with the new test version
> > yet. The previous version of the test did not check the VFAT filesystem on
> > zram devices.

> Whoooaa...

> > I've tried to debug the issue and collected some interesting data (all
> > values come from zram device with 25M size limit and zstd compression
> > algorithm):
> > - mm_stat values are correct after mkfs.vfat:
> > 65536      220    65536 26214400    65536        0        0        0

> > - mm_stat values stay correct after mount:
> > 65536      220    65536 26214400    65536        0        0        0

> > - the bug is triggered by filling the filesystem to capacity (using dd):
> > 4194304        0        0 26214400   327680       64        0        0

> Can you try using /dev/urandom for dd, not /dev/zero?
> Do you still see zeroes in sysfs output or some random values?

I'm not sure if Martin had time to rerun the test. I was not able to reproduce
the problem any more on machine where the test was failing. But I'll have look
into this during this week.

Kind regards,
Petr
