Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B82F5480F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 09:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiFMHyR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 03:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiFMHyP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 03:54:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB27C101E9
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jun 2022 00:54:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i15so4457703plr.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jun 2022 00:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hpn8xKMupt7XEX09PSz3ZuublRBIDfWXnEUdq5eq7AQ=;
        b=jwz/9Uk3Ukruh/+3uCLAl0gN3fxTRTLdBUpi+YVjuDbuusyyV8T4wbhCc9VD5/SWKL
         sm0zDWivrhxKYz//Sr5nA7xCCh3B1MTPcaW+HstFWXokn/73hRaJweY2+O+Jm+k/pjRH
         LX60j1nsUXZyL7aHw9XFZhrjKpa/Mx4tsfgjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpn8xKMupt7XEX09PSz3ZuublRBIDfWXnEUdq5eq7AQ=;
        b=yb+JZIayQmg7XrdOcWAJFU1nFZOYkunmqtm5fuVFr3oBaaf/7nekbb5jAuo17rKjej
         eUYeoeb7qIRGyRaQdCPljZgPZCRIJk0FSWJSTzcLWa746AcCoRWY7uZ87QYA7zbnp0MW
         p4YyhGn/KKR8ZgMQzYfsOAKmnVSQKGL0a5hMx+yoGrlr27jIgL2BsMu2RlvLlxtsvKxj
         YFzzug7R5UxqeNd0HpESYySSzyta4tvPR9SsOQhP3PPsiXbXLzob9NZPUwRDHFfBxnOS
         T8GxgBnB9P2O0vbwUupvjx6SP4DWkJp5MyYL/A1k5f/k8wYQ771mtIrEK72AZlBvsSoT
         WYow==
X-Gm-Message-State: AOAM531ELQ48pvHZAERHaJawk8Gtvs1nD+7ghSusRXdWoTEtLrKg6NK3
        Ap0Q2mVp4zkm8Zfou15KOJg+6Q==
X-Google-Smtp-Source: ABdhPJzw+r+KZp6HaFIa0h8yS/hJIq5Vjwc0cbEbPxqFKY3UeaK9n504TSuqOw+3dgCtnHVK0EF1Eg==
X-Received: by 2002:a17:902:dac5:b0:164:13b2:4916 with SMTP id q5-20020a170902dac500b0016413b24916mr58042646plx.32.1655106853304;
        Mon, 13 Jun 2022 00:54:13 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:de22:3777:8b31:5148])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a414c00b001ea6a20d354sm4538957pjg.2.2022.06.13.00.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 00:54:12 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:54:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
Message-ID: <YqbtH9F47dkZghJ7@google.com>
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com>
 <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com>
 <YqAL+HeZDk5Wug28@google.com>
 <YqAMmTiwcyS3Ttla@google.com>
 <YqANP1K/6oRNCUKZ@google.com>
 <YqBRZcsfrRMZXMCC@google.com>
 <CA+G9fYvjpCOcTVdpnHTOWaf3KcDeTM3Njn_NnXvU37ppoHH5uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvjpCOcTVdpnHTOWaf3KcDeTM3Njn_NnXvU37ppoHH5uw@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On (22/06/12 20:56), Naresh Kamboju wrote:
> 
> I have tested this patch and the reported issue got resolved [1].
>

Many thanks for the tests.

Quite honestly I was hoping that the patch would not help :) Well, ok,
we now know that it's mapping area lock and the lockdep part of its
memory is zero-ed out. The question is - "why?" It really should not
be zeroed out.
