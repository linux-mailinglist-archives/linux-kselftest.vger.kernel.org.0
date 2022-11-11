Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CEA624F10
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 01:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKKAsk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 19:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKAsi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 19:48:38 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25381F2CA
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 16:48:37 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b29so3524898pfp.13
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 16:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/gUNRy1qZIXrqUZUL7883/f/GJegibYfXZQZVngW38U=;
        b=VWZwrH2WTLZH7q/x1ZgpdvYSrGqwsN5f7i9ypcQ7UreI7sa/e03yNK6qv9VxqDlXP8
         i04ZhlEljAEqFDY6vjaYs/QXE3J3167rQ2D69YQqoO8AcyVoep415lPw40kShPC8NBdV
         9bzPkkL603xzDjwINJOebgWujA4I8bQIIWYOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gUNRy1qZIXrqUZUL7883/f/GJegibYfXZQZVngW38U=;
        b=IT9cggEKbRDy3PCVIrS8wZIcZfR3ts658iEnBvDh3M2Uf18vXLug5r20pSeUpFlZ2Y
         /sO00CfHkYdYMfPd3qmXua8HL95qt99vrgcYNwoM9if6omZsf7daIJM9PL/6k7Q7oTIc
         LYvvXwmLjkptHcmrL2eEfnGIFc1aMBPlbMaWbwpcz/I1PsNsw+4ZijX3sxBr3kVu5HVD
         VGehMQFJKzQEAlUOfmh+164e2DinubXcvuelSuw391u+7fgnK8viT49BBP0fLsYt0TEe
         UjiUOla++S+JsLQbw+MnRcutQaVimRwnoGxP2rxkNQLYWtPptkg/lQT/odDl+b5I9siO
         h6BQ==
X-Gm-Message-State: ACrzQf2lixvfWWUYxbOGwjgaa35l98eOE9CdOuFpA1JrUR1yvKAnJR51
        l5wVklpkjGBl/cpWVZ1BW1xkuA==
X-Google-Smtp-Source: AMsMyM7sIWgS/0TfYwBT7X/dzMu66eUOL/4N1tpn2UCyic5dZmo1cMUhDUlzUKuzT+rqzDYvi7knxQ==
X-Received: by 2002:a63:fc14:0:b0:43c:2e57:97df with SMTP id j20-20020a63fc14000000b0043c2e5797dfmr3852168pgi.189.1668127717205;
        Thu, 10 Nov 2022 16:48:37 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id g6-20020a632006000000b004388ba7e5a9sm221005pgg.49.2022.11.10.16.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:48:36 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:48:31 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Martin Doucha <mdoucha@suse.cz>
Cc:     Minchan Kim <minchan@kernel.org>, Petr Vorel <pvorel@suse.cz>,
        ltp@lists.linux.it, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <Y22b3wWs2QfMjJHi@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On (22/11/10 15:29), Martin Doucha wrote:
> New version of LTP test zram01 found a sysfile issue with zram devices
> mounted using VFAT filesystem. When when all available space is filled, e.g.
> by `dd if=/dev/zero of=/mnt/zram0/file`, the corresponding sysfile
> /sys/block/zram0/mm_stat will report that the compressed data size on the
> device is 0 and total memory usage is also 0. LTP test zram01 uses these
> values to calculate compression ratio, which results in division by zero.
> 
> The issue is specific to PPC64LE architecture and the VFAT filesystem. No
> other tested filesystem has this issue and I could not reproduce it on other
> archs (s390 not tested). The issue appears randomly about every 3 test runs
> on SLE-15SP2 and 15SP3 (kernel 5.3). It appears less frequently on SLE-12SP5
> (kernel 4.12). Other SLE version were not tested with the new test version
> yet. The previous version of the test did not check the VFAT filesystem on
> zram devices.

Whoooaa...

> I've tried to debug the issue and collected some interesting data (all
> values come from zram device with 25M size limit and zstd compression
> algorithm):
> - mm_stat values are correct after mkfs.vfat:
> 65536      220    65536 26214400    65536        0        0        0
> 
> - mm_stat values stay correct after mount:
> 65536      220    65536 26214400    65536        0        0        0
> 
> - the bug is triggered by filling the filesystem to capacity (using dd):
> 4194304        0        0 26214400   327680       64        0        0

Can you try using /dev/urandom for dd, not /dev/zero?
Do you still see zeroes in sysfs output or some random values?
