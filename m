Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7A631C34
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 10:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiKUJAA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 04:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUI77 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 03:59:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9978CDF95;
        Mon, 21 Nov 2022 00:59:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 463F61F897;
        Mon, 21 Nov 2022 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669021197;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9eI0l3L5J3waSLvW+eC332jj5gD4Rcqx/oy4092T7U=;
        b=uJNWoBaxwvTkrgcPCkmSH5N8lmksBFO6vBhMcKeC2W7lOUh2gTFKNUCWjI6fbYlxpP4bPc
        FekS8LKjm1E6B5wm3peAwXuznfWm6rE2l2WmGEaZSqIF05/CrJqQtHQvIhenohiltd0lPR
        V2J68v0dm4icKuYkLMj6IUjdDe79bbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669021197;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9eI0l3L5J3waSLvW+eC332jj5gD4Rcqx/oy4092T7U=;
        b=mwKTVaxEkEJfXDxmby4hh4uyjgP5plQNW4zg0K0s18PEbBjnSvse2OmeQrilKUMTFtMoFK
        tjiy0rAVGrz7aCDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0E0D1376E;
        Mon, 21 Nov 2022 08:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BGsKOQw+e2MxXQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 21 Nov 2022 08:59:56 +0000
Date:   Mon, 21 Nov 2022 09:59:55 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Li Wang <liwang@redhat.com>
Cc:     ltp@lists.linux.it, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kselftest@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: [LTP] [PATCH 1/1] zram01.sh: Workaround division by 0 on vfat on
 ppc64le
Message-ID: <Y3s+Czg8sBsGYO+1@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <20221107191136.18048-2-pvorel@suse.cz>
 <CAEemH2fYv_=9UWdWB7VDiFOd8EC89qdCbxnPcTPAtGnkwLOYFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEemH2fYv_=9UWdWB7VDiFOd8EC89qdCbxnPcTPAtGnkwLOYFg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Li,

> Hi Petr,

> On Tue, Nov 8, 2022 at 3:12 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Repeatedly read /sys/block/zram*/mm_stat for 1 sec. This should fix bug
> > on ppc64le on stable kernels, where mem_used_total is often 0.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  .../kernel/device-drivers/zram/zram01.sh      | 27 +++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)

> > diff --git a/testcases/kernel/device-drivers/zram/zram01.sh
> > b/testcases/kernel/device-drivers/zram/zram01.sh
> > index 58d233f91..76a8ccab4 100755
> > --- a/testcases/kernel/device-drivers/zram/zram01.sh
> > +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> > @@ -105,6 +105,26 @@ zram_mount()
> >         tst_res TPASS "mount of zram device(s) succeeded"
> >  }

> > +read_mem_used_total()
> > +{
> > +       echo $(awk '{print $3}' $1)
> > +}
> > +
> > +# Reads /sys/block/zram*/mm_stat until mem_used_total is not 0.
> > +loop_read_mem_used_total()


> This is not a looping function to check if mem_used_total is equal to zero,
> the loop part is by means of the TST_RETRY_FUNC macro.
Thanks for your review!

> So, I'd suggest renaming it to check_read_mem_used_total().
Agree. Unfortunately even this didn't help on ppc64le system where I was able to
reproduce it, thus probably not worth to merge.

Unfortunately later I was not able to reproduce the problem any more, I'll try
it more this week.

Kind regards,
Petr

> Reviewed-by: Li Wang <liwang@redhat.com>



> > +{
> > +       local file="$1"
> > +       local mem_used_total
> > +
> > +       tst_res TINFO "$file"
> > +       cat $file >&2
> > +
> > +       mem_used_total=$(read_mem_used_total $file)
> > +       [ "$mem_used_total" -eq 0 ] && return 1
> > +
> > +       return 0
> > +}
> > +
> >  zram_fill_fs()
> >  {
> >         local mem_used_total
> > @@ -133,9 +153,12 @@ zram_fill_fs()
> >                         continue
> >                 fi

> > -               mem_used_total=`awk '{print $3}'
> > "/sys/block/zram$i/mm_stat"`
> > +               TST_RETRY_FUNC "loop_read_mem_used_total
> > /sys/block/zram$i/mm_stat" 0
> > +               mem_used_total=$(read_mem_used_total
> > /sys/block/zram$i/mm_stat)
> > +               tst_res TINFO "mem_used_total: $mem_used_total"
> > +
> >                 v=$((100 * 1024 * $b / $mem_used_total))
> > -               r=`echo "scale=2; $v / 100 " | bc`
> > +               r=$(echo "scale=2; $v / 100 " | bc)

> >                 if [ "$v" -lt 100 ]; then
> >                         tst_res TFAIL "compression ratio: $r:1"
> > --
> > 2.38.0


> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
