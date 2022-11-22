Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBC4633FDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 16:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiKVPHm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 10:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiKVPHc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 10:07:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3097A13CF2;
        Tue, 22 Nov 2022 07:07:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C75EC21D3E;
        Tue, 22 Nov 2022 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669129648;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p56F2nwME/RWURtSP2TSQAQXPWOVxd9VX0H+uS1eGS0=;
        b=vuXrQNe9cPzsddLz3LepnRY7WjGBC2hwqmeAZKHW2mROYJ+vEC/3MyEuYK6J+FbxDozZEm
        3segnSrLYCCTBO93SzOf8Ltn3wF/GcoR3rdoo9VdYNi5IePV3twf3X9QV69NrvRNMQYzbP
        n1lrJXRS3YN9Glh8ZQGjpKAm6Mi0c6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669129648;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p56F2nwME/RWURtSP2TSQAQXPWOVxd9VX0H+uS1eGS0=;
        b=GdC4hcnByfHfq5j9HOMxZvYvdEKAheoNPOxrH4K22oVhTseS4ITfKbDFlWzzX1TK2Cjf+X
        LZVb/9aXKFcYVcAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAD6613B01;
        Tue, 22 Nov 2022 15:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +6QnMq7lfGM6CwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 22 Nov 2022 15:07:26 +0000
Date:   Tue, 22 Nov 2022 16:07:24 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Martin Doucha <mdoucha@suse.cz>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, ltp@lists.linux.it,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <Y3zlrBQ8fgJyNm7G@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
 <Y22b3wWs2QfMjJHi@google.com>
 <9489dd1c-012c-8b5d-b670-a27213da287a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9489dd1c-012c-8b5d-b670-a27213da287a@suse.cz>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 11. 11. 22 1:48, Sergey Senozhatsky wrote:
> > On (22/11/10 15:29), Martin Doucha wrote:
> > > I've tried to debug the issue and collected some interesting data (all
> > > values come from zram device with 25M size limit and zstd compression
> > > algorithm):
> > > - mm_stat values are correct after mkfs.vfat:
> > > 65536      220    65536 26214400    65536        0        0        0

> > > - mm_stat values stay correct after mount:
> > > 65536      220    65536 26214400    65536        0        0        0

> > > - the bug is triggered by filling the filesystem to capacity (using dd):
> > > 4194304        0        0 26214400   327680       64        0        0

> > Can you try using /dev/urandom for dd, not /dev/zero?
> > Do you still see zeroes in sysfs output or some random values?

> After 50 test runs on a kernel where the issue is confirmed, I could not
> reproduce the failure while filling the device from /dev/urandom instead of
> /dev/zero. The test reported compression ratio around 1.8-2.5 which means
> the memory usage reported by mm_stat was 10-13MB.

Martin, thanks a lot for reruning tests. I wonder problems on /dev/zero is a
kernel bug or just problem which should be workarounded.

> Note that I had to disable the other filesystems in the test because some of
> them kept failing with compression ratio <1.

Yes, I noted that as well at least on exfat and btrfs (if I remember correctly).
It wouldn't be a problem to just use it for vfat if we agreed test should be
modified.

Kind regards,
Petr
