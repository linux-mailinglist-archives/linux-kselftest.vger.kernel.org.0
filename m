Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D688A63B926
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 05:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiK2Eij (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 23:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiK2Eii (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 23:38:38 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0A130555
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 20:38:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so12202518pjg.1
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 20:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=48Xm3VfV4sx0+bUZmYTNZIpSa0XzNl3vvIQW42o7jJQ=;
        b=T5LUfnFRWiWAdf7zeRpoyRCNSY164AYnoRT7heMBmwvQh/rkonGTMP2fDaxZ3cb3zq
         WgnsezEnwq9KAb5FRfzcc5muJkJxXkVwjBgn2+VHTj+wotmFhoJq5rNh+hOLZk0LZ3g/
         Ozt9Ev52HQoPAwOc9bKAd0REmzrYFGjcYLOh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48Xm3VfV4sx0+bUZmYTNZIpSa0XzNl3vvIQW42o7jJQ=;
        b=qfZ1+nEsXEtG7RUOd/JgLBRvRdDYLwOx9BMRqCmD6q7vGVI5NdYpn1j1hHWqAYXHi8
         QT7quJdJ5EuqAilUVXfwvYI4PyhBZMgdvRLfq4IjaxJ3jnEOt9Zy/RdaCqVxtRj5zJ52
         yR8RBiAgufMYWjLxSvV/hCblKwm0lhRSStlb2gpuWglavLd2ou4oKz8LSsbgD8TPRQlD
         MF7DnJv1WoFspiEjtQYJc27x+Q4CznRPGCNr6LMao0xnOsCAtk/ceEyP931XqwkHzsNu
         AkYvdlKaF2uqRDaKrz6n701x7/O9mk3FS04eLk7WCs8ji0aHAU5K8+o4qCPMEDhrq1/U
         y31g==
X-Gm-Message-State: ANoB5pk5JHjFPxgI5Wd4Ft3M2HQ5EaL34xBhq8rjrMWrIqcewPY8CuST
        /dzBVAAlt9JnHSv4+VawAnLDXA==
X-Google-Smtp-Source: AA0mqf5c3WV2DuftkVuXZ0Ps8inmw7FchDxrXziCDRwmtaUhnUDq6si8XtaqqqnfHmFIrk0qg4O0fg==
X-Received: by 2002:a17:90a:fb86:b0:219:26b5:d41e with SMTP id cp6-20020a17090afb8600b0021926b5d41emr12318785pjb.20.1669696716694;
        Mon, 28 Nov 2022 20:38:36 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:2565:b2f5:cacd:a5d9])
        by smtp.gmail.com with ESMTPSA id o42-20020a17090a0a2d00b00219133d0f4esm321809pjo.9.2022.11.28.20.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 20:38:36 -0800 (PST)
Date:   Tue, 29 Nov 2022 13:38:30 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Martin Doucha <mdoucha@suse.cz>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, ltp@lists.linux.it,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <Y4WMxqyVlAt0Sp3g@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
 <Y22b3wWs2QfMjJHi@google.com>
 <9489dd1c-012c-8b5d-b670-a27213da287a@suse.cz>
 <Y3zlrBQ8fgJyNm7G@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3zlrBQ8fgJyNm7G@pevik>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On (22/11/22 16:07), Petr Vorel wrote:
> > On 11. 11. 22 1:48, Sergey Senozhatsky wrote:
> > > On (22/11/10 15:29), Martin Doucha wrote:

[..]

> > > Can you try using /dev/urandom for dd, not /dev/zero?
> > > Do you still see zeroes in sysfs output or some random values?
> 
> > After 50 test runs on a kernel where the issue is confirmed, I could not
> > reproduce the failure while filling the device from /dev/urandom instead of
> > /dev/zero. The test reported compression ratio around 1.8-2.5 which means
> > the memory usage reported by mm_stat was 10-13MB.
> 
> Martin, thanks a lot for reruning tests. I wonder problems on /dev/zero is a
> kernel bug or just problem which should be workarounded.

Hmm. Does CONFIG_KASAN show anything interesting?
