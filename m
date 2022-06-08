Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE454247F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jun 2022 08:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiFHF2f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jun 2022 01:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiFHF2O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jun 2022 01:28:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD41538BD4
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Jun 2022 19:42:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u18so16450703plb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jun 2022 19:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eACAcP76K1gXeQHMPXfrh6MRwMHogkqclcM3ucohxaU=;
        b=DtL5BKl38TK1JmQCoo9VNTuilRXtIQQb8aA+2j5JWDKkTJMcHWV5I4ayrf85wEAp/D
         +SPamuT0V/GS1H3+TGA7bsJrj/vQJTAzHMhmUFqbAjw6QppecD8ydZLJWGxGusTbuS3B
         DrmzebuZhbfui1ZylFkqA44lBIOUX+RiD7kEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eACAcP76K1gXeQHMPXfrh6MRwMHogkqclcM3ucohxaU=;
        b=SHTk4v2FahirEO/bJ74p4STf6Sp6lAp3aYFO8wCeH4LvQJentbgTqzpP/yLt3IVYGs
         cuX9vvyXOUrQXJVUlqS0vOsmmoTvdnIpFP7FTZt9EI1PdJgrrpjQroEJXf+aeJB79Jmc
         VRNKKZT+70Ny0l2Ipzv1jbiBJlo/ImdD1hWfcEnGFCf5IUa0zV+zaKLNVgHEE0FCLxEG
         tK+JYpbTX4XZyRrvDy6CZl57AmUj5PX+Z+ObPmz5zkz70pUesr+lNn2YJRafuMXFrdeF
         ZhERUvPRsL8kyhLYYQ7Dklm1ZjsDAJ4W1DgEaiEG8xt13vAjNfmn76s0VRg3Idjt5/gt
         ak4A==
X-Gm-Message-State: AOAM5318D6hrF6umYQvmKE4yeEWDVIjx0WmbLiAYTd/RVX6PBm0fk93Y
        Dend1ERK0EWPxv1L+4lbEZMFFQ==
X-Google-Smtp-Source: ABdhPJzYCcpDtcoi5LZAO+0GSYALVef0pXg5v/EV8ii/oeXqYV5OV4RF4wJ5iDiynw1qdkxhjkSp7A==
X-Received: by 2002:a17:902:6bc6:b0:166:3c39:50a1 with SMTP id m6-20020a1709026bc600b001663c3950a1mr31493176plt.36.1654656158650;
        Tue, 07 Jun 2022 19:42:38 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:463d:a192:6128:66e])
        by smtp.gmail.com with ESMTPSA id n7-20020aa78a47000000b0051bb61c0eacsm13512317pfa.20.2022.06.07.19.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 19:42:38 -0700 (PDT)
Date:   Wed, 8 Jun 2022 11:42:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
Message-ID: <YqAMmTiwcyS3Ttla@google.com>
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com>
 <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com>
 <YqAL+HeZDk5Wug28@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqAL+HeZDk5Wug28@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On (22/06/08 11:39), Sergey Senozhatsky wrote:
> On (22/06/07 16:52), Minchan Kim wrote:
> > > rootfs: https://oebuilds.tuxbuild.com/29zhlbEc3EWq2wod9Uy964Bp27q/images/am57xx-evm/rpb-console-image-lkft-am57xx-evm-20220601222434.rootfs.ext4.gz
> > > kernel: https://builds.tuxbuild.com/29zhqJJizU2Y7Ka7ArhryUOrNDC/zImage
> > > 
> > > Boot command,
> > >  /usr/bin/qemu-system-aarch64 -cpu host,aarch64=off -machine
> > > virt-2.10,accel=kvm -nographic -net
> > > nic,model=virtio,maaacaddr=BA:DD:AD:CC:09:04 -net tap -m 2048 -monitor
> > > none -kernel kernel/zImage --append "console=ttyAMA0 root=/dev/vda rw"
> > > -hda rootfs/rpb-console-image-lkft-am57xx-evm-20220601222434.rootfs.ext4
> > > -m 4096 -smp 2
> > > 
> > > # cd /opt/kselftests/default-in-kernel/zram
> > > # ./zram.sh
> > > 
> > > Allow me sometime I will try to bisect this problem.
> > 
> > Thanks for sharing the info. 
> > 
> > I managed to work your rootfs with my local arm build
> > based on the problematic git tip. 
> > However, I couldn't suceed to reproduce it.
> > 
> > I needed to build zsmalloc/zram built-in instead of modules
> > Is it related? Hmm,
> > 
> > Yeah, It would be very helpful if you could help to bisect it.
> 
> This looks like a NULL lock->name dereference in lockdep. I suspect
> that somehow local_lock doesn't get .dep_map initialized. Maybe running
> the kernel with CONFIG_DEBUG_LOCK_ALLOC would help us? Naresh, can you
> help us with this?

Hmm, actually, hold on. mapping_area is per-CPU, so what happens if CPU
get offlined and onlined again? I don't see us re-initializing mapping_area
local_lock_init(&zs_map_area.lock) and so on.
