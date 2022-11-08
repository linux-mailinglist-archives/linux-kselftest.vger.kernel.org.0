Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6C462058C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 02:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiKHBFS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 20:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiKHBFR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 20:05:17 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04F920BEC
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 17:05:16 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f63so12069140pgc.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Nov 2022 17:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9NiTraJTVI3GZSgQulM4QdB39VgKWNnbTrt/IiQ+Zs=;
        b=ZPTfykv3GFLo2GZPuvohfWNbYYG1PB0gSDVQ7SQgnq5zL9xmlEXwcKOTOFdR1t6yP5
         6sFjxRjPNbOpKCszIBZNELwVeWRE1cGMnsmIgWd5oTRdTLYRb84e+Odos42KCv6KtgXm
         2QZXjS80ZNX6fUoo3yOgmoLezTu6Y2Cep31SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9NiTraJTVI3GZSgQulM4QdB39VgKWNnbTrt/IiQ+Zs=;
        b=7+L5R7BJdBn98qtmrE4+hUD6UnwEXW6YhYTRFHybPhopLB5CSLz+6m4Hd6J701OgoZ
         EhRw4OmpIoLbkP80yfwnOSbhHg7OvsHNpnMckMssHCEa6S0J7B94x1GbBxkGst0pzv8w
         E9ct4BzQmuaDGz/QhByGz9kbScUs6CxHtr/2NwaTyk2Ck0f9GjoK3EzBFH29xzZ1XEgW
         37raT8EzW9IkTFJKe0OayFv4yWEnovPSbeHx4ygDGCyP3s6PK1X0rIBzhEe/p3QQHzjJ
         kL0q5t5BhzC6GRq9YJTk6IVk76d1EF9s7T7wwH9ZJyOsHQRKWCBeV1zKwJkCmc2BJuny
         ns9g==
X-Gm-Message-State: ACrzQf27O8lxSjx4FaPdxzqgVEQ6ElTeTF2rO8yDdY0Mk7nDJ2dlpIRv
        P+HafX66s9Etk2i/Y9xThyZvOg==
X-Google-Smtp-Source: AMsMyM4k/IRQ3yHRp4KWi+gUwm6Rw1wJ6/tpCXcW4fyYfLEBxbpPL1/bVgm/DLIXtSVfzSABqnOyNg==
X-Received: by 2002:a05:6a00:22cf:b0:56d:1c55:45d0 with SMTP id f15-20020a056a0022cf00b0056d1c5545d0mr50553101pfj.54.1667869516351;
        Mon, 07 Nov 2022 17:05:16 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d5d:1342:1172:9487])
        by smtp.gmail.com with ESMTPSA id k17-20020a63ff11000000b0046f9f4a2de6sm4743649pgi.74.2022.11.07.17.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 17:05:15 -0800 (PST)
Date:   Tue, 8 Nov 2022 10:05:11 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Minchan Kim <minchan@kernel.org>, ltp@lists.linux.it,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Martin Doucha <mdoucha@suse.cz>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <Y2mrRxHhVi/QEiUf@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <Y2l89dt/t8M6+9go@pevik>
 <Y2mJ42Ap7VIZu32Y@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2mJ42Ap7VIZu32Y@pevik>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On (22/11/07 23:42), Petr Vorel wrote:
[..]
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TBROK: "loop_read_mem_used_total /sys/block/zram1/mm_stat" timed out

Looking at mm_stat_show(), mem_used can be 0 when mm_stat_show() is
called on un-initialized device

---
...
        u64 orig_size, mem_used = 0;
        long max_used;
        ssize_t ret;

        memset(&pool_stats, 0x00, sizeof(struct zs_pool_stats));

        down_read(&zram->init_lock);
        if (init_done(zram)) {
                mem_used = zs_get_total_pages(zram->mem_pool);
                zs_pool_stats(zram->mem_pool, &pool_stats);
        }
...
---

Can you check if init_done() returns true in your tests?
