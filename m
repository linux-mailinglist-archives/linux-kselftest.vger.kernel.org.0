Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A164C620113
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 22:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiKGVZp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 16:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiKGVZX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 16:25:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2F255AE;
        Mon,  7 Nov 2022 13:25:19 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so15956267pji.1;
        Mon, 07 Nov 2022 13:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wNv+1Bf4cquI/EHzjAENJoFB1/c9LVYJtIsCgpVko8=;
        b=Jw6IIZMnJN8JA5mVqxvAC/JS5MSwwZq9MH1YW0YXr+YI0Rn6aZf1ylYXIhcjfGpccl
         OnVT9b1yKNxTh+141tJniQkx5kDbL8zOpBv/yMPmWyshQfk7LWXZlbtDaFYtvo4yli6P
         FUeV920E7vf0PUFor8tH/A4oRy2wFuwbOJNsCtXsBJv/12VxaLKNU1EHFvhkfK5UrpG/
         LgrybxTGYFB6O04yCAKoC5C2gqQoyWiK+l2CP0N0bCfGC03iZT09c4Sf51xAAJyOQfBo
         NqCjOnKXglh04J9KD7ui9eoSmj+50jYivPazBST1fT0HFTzn+qUcQAvCi1RiI75GHVbm
         yi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wNv+1Bf4cquI/EHzjAENJoFB1/c9LVYJtIsCgpVko8=;
        b=YsZ2uN+7sHlichWjjLhGPD/DqWHvW45btO/69z8PsrX5bxy/+aHQ5tzOqMarMAiVRN
         KCnESU70GWjDJkam6HEEYVnhMLKcKEkGljKH4IY13aKQOpfpQiJzHwWzW9EPAnA0ZR1U
         8qz6Bb6FrnRTS5x5J1skE8Qc29V4GE46lO7ftZw7Ihv3H23utBlhxHrVKe7gCEZK1oWN
         zxyHrJcz2cibjcNrLqEH8f1rpRx44PxAlM1TqmZS+ntTiqIDD9NCMz2sSBu2VUI3FQ8q
         xZcPrIwFQ/1/JY05b4OolJ6tGsW6AokGkrcOYx0vC+eiNGF3tIvGODIRozMXxsj7aIGR
         jQZw==
X-Gm-Message-State: ACrzQf0JVpF7H+rtrAWWz76zuYxB1N3soMkGn/UpsimPW14o6V20WKV2
        L1dqJ7kyVLAymey2/DmZOxw=
X-Google-Smtp-Source: AMsMyM6pg7jfZjs5E3oG1Xo6bI3H420NG+af23uX8ad0Qpws6uAeEJnrSoNhYF1g+EVi5zjcrRskjg==
X-Received: by 2002:a17:90a:7e10:b0:213:9e81:87e2 with SMTP id i16-20020a17090a7e1000b002139e8187e2mr56152275pjl.1.1667856319181;
        Mon, 07 Nov 2022 13:25:19 -0800 (PST)
Received: from google.com ([2620:15c:211:201:594a:f636:e461:590b])
        by smtp.gmail.com with ESMTPSA id h20-20020aa796d4000000b00560a25fae1fsm4887216pfq.206.2022.11.07.13.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:25:18 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 7 Nov 2022 13:25:16 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Martin Doucha <mdoucha@suse.cz>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <Y2l3vJb1y2Jynf50@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107191136.18048-1-pvorel@suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 08:11:35PM +0100, Petr Vorel wrote:
> Hi all,
> 
> following bug is trying to workaround an error on ppc64le, where
> zram01.sh LTP test (there is also kernel selftest
> tools/testing/selftests/zram/zram01.sh, but LTP test got further
> updates) has often mem_used_total 0 although zram is already filled.

Hi, Petr,

Is it happening on only ppc64le?

Is it a new regression? What kernel version did you use?

Actually, mem_used_total indicates how many *physical memory* were
currently used to keep original data size.

However, if the test data is repeated pattern of unsigned long
(https://github.com/torvalds/linux/blob/master/drivers/block/zram/zram_drv.c#L210)
zram doesn't allocate the physical memory but just mark the unsigned long's value
in meta area for decompression later.

Not sure you hit the this case.

> 
> Patch tries to repeatedly read /sys/block/zram*/mm_stat for 1 sec,
> waiting for mem_used_total > 0. The question if this is expected and
> should be workarounded or a bug which should be fixed.
> 
> REPRODUCE THE ISSUE
> Quickest way to install only zram tests and their dependencies:
> make autotools && ./configure && for i in testcases/lib/ testcases/kernel/device-drivers/zram/; do cd $i && make -j$(getconf _NPROCESSORS_ONLN) && make install && cd -; done
> 
> Run the test (only on vfat)
> PATH="/opt/ltp/testcases/bin:$PATH" LTP_SINGLE_FS_TYPE=vfat zram01.sh
> 
> Petr Vorel (1):
>   zram01.sh: Workaround division by 0 on vfat on ppc64le
> 
>  .../kernel/device-drivers/zram/zram01.sh      | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> -- 
> 2.38.0
> 
