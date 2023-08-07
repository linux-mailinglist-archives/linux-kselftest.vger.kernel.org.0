Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D508C771915
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 06:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjHGEoz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 00:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHGEox (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 00:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B142110FA
        for <linux-kselftest@vger.kernel.org>; Sun,  6 Aug 2023 21:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691383449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+2EbnFZV7yJtZskjh+cWG4NxmXWzvfmJSRPX0ne/hU=;
        b=OlEYEIfpnSCjPVP9mcGtb1nLi/1kv7EgxA9ptvERTLbwDPaXvxjGQSqwohWwrIuSQ9bX87
        wz3uTH8sQwhVP6ny1mfVEHaJ4JGmKNBt6jtv6a54IDaRrpW2xVsFD1n1MgAuNnbArzzHE+
        0cPTkYUxS5SpoQwxtr53YskKzS+firo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-wTxsbczzPo-K5BCoo71WTA-1; Mon, 07 Aug 2023 00:44:08 -0400
X-MC-Unique: wTxsbczzPo-K5BCoo71WTA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-564656d952aso2631932a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 06 Aug 2023 21:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691383447; x=1691988247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+2EbnFZV7yJtZskjh+cWG4NxmXWzvfmJSRPX0ne/hU=;
        b=NbThUuC90NOIuhAY/k6aNWqLqmmlXiIlxlgaMZ2UjvZdT8AQBTOLkhy0gmA9O4eVr2
         nkQyVVSbBuzejTUmLxQxvu95q3TJ0yUgBzGy8heFpdnv09Q66vymW4TqsTzcpQ/Vhd/s
         5tUUQzt6GPtjHHIC2iCoreOPXBPPx7cjEETqCmQZvWYP+VAKVTouR/52UoVvIdYREKKJ
         6ezglVdyLSbsm61UrGarf3w4b63y2p6Df9S5dRfn6KSwt6HR/Jh3JT3F5KQN3Xks7er2
         UIOo4lQ4uD516v/4Cg8EurGNveyhTp5Y4LSdYwLB3MZ0mOSwY8exkx5xachl8FINx+O+
         +wbg==
X-Gm-Message-State: AOJu0YxzcInep0m+IHUn1nruwBzqVGLzNZzzWaz4qY41bG4bQwFeUWOi
        hVif3zCYZIhvGR7uGOyyPlCkftiuSmHVlzBkvMVYuFKo1s0jEwXhXsUyRmuWqASgMVD6EF9Rbt5
        KlNqJAx3iveDmTZHeSK1mOgR8g34D
X-Received: by 2002:a05:6a20:1006:b0:125:f3d8:e65b with SMTP id gs6-20020a056a20100600b00125f3d8e65bmr7292035pzc.18.1691383447541;
        Sun, 06 Aug 2023 21:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDShi2vAdRaNGp+RB4NdbaHvukAeLo4WlRfe0u382qDdlhARlZSEovvdd8LQZl2heUKcBudQ==
X-Received: by 2002:a05:6a20:1006:b0:125:f3d8:e65b with SMTP id gs6-20020a056a20100600b00125f3d8e65bmr7292025pzc.18.1691383447235;
        Sun, 06 Aug 2023 21:44:07 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
        by smtp.gmail.com with ESMTPSA id iz7-20020a170902ef8700b001b895a17429sm5697860plb.280.2023.08.06.21.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 21:44:06 -0700 (PDT)
Date:   Mon, 7 Aug 2023 14:44:00 +1000
From:   Ian Wienand <iwienand@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Martin Doucha <mdoucha@suse.cz>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <ZNB2kORYiKdl3vSq@fedora19.localdomain>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <ZMycl7xKyJoQNpcu@fedora19.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMycl7xKyJoQNpcu@fedora19.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

After thinking it through, I think I might have a explanation...

On Fri, Aug 04, 2023 at 04:37:11PM +1000, Ian Wienand wrote:
> To recap; this test [1] creates a zram device, makes a filesystem on
> it, and fills it with sequential 1k writes from /dev/zero via dd.  The
> problem is that it sees the mem_used_total for the zram device as zero
> in the sysfs stats after the writes; this causes a divide by zero
> error in the script calculation.
> 
> An annoted extract:
> 
>  zram01 3 TINFO: /sys/block/zram1/disksize = '26214400'
>  zram01 3 TPASS: test succeeded
>  zram01 4 TINFO: set memory limit to zram device(s)
>  zram01 4 TINFO: /sys/block/zram1/mem_limit = '25M'
>  zram01 4 TPASS: test succeeded
>  zram01 5 TINFO: make vfat filesystem on /dev/zram1
> 
>  >> at this point a cat of /sys/block/zram1/mm_stat shows
>  >>   65536      527    65536 26214400    65536        0        0        0
> 
>  zram01 5 TPASS: zram_makefs succeeded

So I think the thing to note is that mem_used_total is the current
number of pages (reported * PAGE_SIZE) used by the zsmalloc allocator
to store compressed data.

So we have made the file system, which is now quiescent and just has
basic vfat data; this is compressed and stored and there's one page
allocated for this (arm64, 64k pages).

>  zram01 6 TINFO: mount /dev/zram1
>  zram01 6 TPASS: mount of zram device(s) succeeded
>  zram01 7 TINFO: filling zram1 (it can take long time)
>  zram01 7 TPASS: zram1 was filled with '25568' KB
>
>  >> however, /sys/block/zram1/mm_stat shows
>  >>   9502720        0        0 26214400   196608      145        0        0
>  >> the script reads this zero value and tries to calculate the
>  >> compression ratio
> 
>  ./zram01.sh: line 145: 100 * 1024 * 25568 / 0: division by 0 (error token is "0")

At this point, because this test fills from /dev/zero, the zsmalloc
pool doesn't actually have anything in it.  The filesystem metadata is
in-use from the writes, and is not written out as compressed data.
The zram page de-duplication has kicked in, and instead of handles to
zsmalloc areas for data we just have "this is a page of zeros"
recorded.  So this is correctly reflecting that fact that we don't
actually have anything compressed stored at this time.

>  >> If we do a "sync" then redisply the mm_stat after, we get
>  >>   26214400     2842    65536 26214400   196608      399        0        0

Now we've finished writing all our zeros and have synced, we would
have finished updating vfat allocations, etc.  So this gets compressed
and written, and we're back to have some small FS metadata compressed
in our 1 page of zsmalloc allocations.

I think what is probably "special" about this reproducer system is
that it is slow enough to allow the zero allocation to persist between
the end of the test writes and examining the stats.

I'd be happy for any thoughts on the likelyhood of this!

If we think this is right; then the point of the end of this test [1]
is ensure a high reported compression ratio on the device, presumably
to ensure the compression is working.  Filling it with urandom would
be unreliable in this regard.  I think what we want to do is something
highly compressable like alternate lengths of 0x00 and 0xFF.  This
will avoid the same-page detection and ensure we actually have
compressed data, and we can continue to assert on the high compression
ratio reliably.  I'm happy to propose this if we generally agree.

Thanks,

-i

> [1] https://github.com/linux-test-project/ltp/blob/8c201e55f684965df2ae5a13ff439b28278dec0d/testcases/kernel/device-drivers/zram/zram01.sh

