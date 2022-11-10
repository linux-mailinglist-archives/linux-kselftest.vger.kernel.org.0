Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E30624E31
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 00:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKJXEp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 18:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJXEo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 18:04:44 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D031DA41;
        Thu, 10 Nov 2022 15:04:43 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u6so2783684plq.12;
        Thu, 10 Nov 2022 15:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PxXXft/nkkyC+qO3NZ0NZRsgWMaldSAxbQ9lxvKRGY=;
        b=T6C7YIAMYHacLdrESecsyvPNePaxfqKM6ZzXAgY/O9enpon/fyk4AwNgl21buw2/tg
         xmg6tTuw9bDi37AmyBpjGUQbxADCwvSk8/Cm7Q5ceUWvRAb3jTO8xLahRHhj13EQv2+C
         L8roGgR/WnzAEfbC/SBSxdDo7OjR6NNkhheKPiuQQJxhZhhcVpC60ppB5Uocn9O26SNO
         K7f01Uy0UWye2FRcS/mAfg3t/m/H7du4d81vo66lkm7yS2742p05r2+fFnuwWjSbTWse
         rg/sN8qJQyOgFL/8eTz2ab00JzSmsiBefMNT6JbZs1bpZmwEKonlZa0TS0beQpAeJ0Eg
         a1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PxXXft/nkkyC+qO3NZ0NZRsgWMaldSAxbQ9lxvKRGY=;
        b=dQlmBTPnBUbRmea2h5O1TY5BTKTp07CuEk28CxoRTUZB55ie7FDlRoWWf7UOnGi0IY
         MBRtX92ri6gDdtz43yHIF1Vh5kMQVjIdSLA/NLSQgSqRVzvriMuh0wnnL2MbL7FAeW+Z
         AvadSU351VctUjnetQNUlNQ8s8pBWEm+31/rsLSo/zGVtoI11fMSRJKldDk1jwe2yFbE
         3GANfhiOV1FtE6kh8bMeVhi+S+cMI4wjn25rF+/3p2nAAfLS51HEcH9lY0RiAL3+5R4x
         bnPd6iDMuDbh1NaOg8v/iXmyOjnxQgHSNVs4XpVxUNPUro1OPL5o/bIUiBNiQS0Pxn9z
         2o0A==
X-Gm-Message-State: ACrzQf3KUGeDbbSQYA3O46ZcVPwpXW8embX3bPwqf26KZl8vNjIqbZ/R
        KNbhso4fCJjB/UhYQFXgG00=
X-Google-Smtp-Source: AMsMyM4KtyUZ+RLI3SgeEuwc5nKbDYT6Ih/qwJK99ZzTPQW52wv+CeCQTrbrzNKVmuN6P5egPGp+Gg==
X-Received: by 2002:a17:90b:3d8d:b0:212:ccda:88bc with SMTP id pq13-20020a17090b3d8d00b00212ccda88bcmr2476638pjb.212.1668121483057;
        Thu, 10 Nov 2022 15:04:43 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8c0b:3260:c81c:119d])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0018875b76945sm185565pll.274.2022.11.10.15.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 15:04:42 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 10 Nov 2022 15:04:40 -0800
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
Message-ID: <Y22DiF5Q5EDUIrZE@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <Y2l89dt/t8M6+9go@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2l89dt/t8M6+9go@pevik>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 10:47:33PM +0100, Petr Vorel wrote:
> Hi Minchan,
> 
> > On Mon, Nov 07, 2022 at 08:11:35PM +0100, Petr Vorel wrote:
> > > Hi all,
> 
> > > following bug is trying to workaround an error on ppc64le, where
> > > zram01.sh LTP test (there is also kernel selftest
> > > tools/testing/selftests/zram/zram01.sh, but LTP test got further
> > > updates) has often mem_used_total 0 although zram is already filled.
> 
> > Hi, Petr,
> 
> > Is it happening on only ppc64le?
> I haven't seen it on other archs (x86_64, aarch64).
> 
> > Is it a new regression? What kernel version did you use?
> Found on openSUSE kernel, which uses stable kernel releases 6.0.x.
> It's probably much older, first I've seen it some years ago (I'm not able to find kernel version), but it was random. Now it's much more common.
> 
> Test runs on VM (I can give qemu command or whatever you need to know about it)
> I'll try to verify it on some bare metal ppc64le.

Hi Petr and Martin,

Thanks for testing and meaning information.

Could you tell how I could create VM to run ppc64le and run the test?
I'd like to reproduce in my local to debug it.

Thanks!
