Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336FC762714
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjGYWzR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjGYWzD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:55:03 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3900010DC;
        Tue, 25 Jul 2023 15:54:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5576ad1b7e7so672491a12.1;
        Tue, 25 Jul 2023 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690325607; x=1690930407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdMg39YRMnpZU+razuRNbGr0OFnYUgy/lH2Eq5YC068=;
        b=McQdShKm7uojkgHTzatVRnDUG92ceS8qj+U9ZqcsLahYbXtfY9jRyAeYrcmLGMlORZ
         8nbM0PlmsgM+XkaTTbSnyGVVfgs0NCI39BUeVM5oa1jjZG0gc6Ld5I+DgH0Q/U8nz5yQ
         ASuZtHyF7Gqk+NuyubPRcdvRhw0/9TDafMupXiMWj0m5uPMfzGmIHXIoQm6iumYVfARA
         vXy0koEmSq3yzhWP+hYUfKDtxyKsZy2Fsns7RYzSL9IuO3yIrb+HRmPp3FxzFiJAlUJW
         dVD4/2JXrejvj0C7l4Wm+cq1U9bcTkaSXC4E708YIqrUJ/JkxPluONodGEF1nTuB4Ibg
         qrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690325607; x=1690930407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdMg39YRMnpZU+razuRNbGr0OFnYUgy/lH2Eq5YC068=;
        b=lCLu58Kr/XVF+R0zeA6MfLE+r+Jz5WEIAs254o3A3Fos0yBcLnn8RVZle2H2YJZyr5
         nYluT+e99+IAlJrpOLzXkHw51XFNxTqwAZUWGVMRLP9zXF+kzTfh0vB7UZ+nMoi1Q50S
         S2iXO+79vmUvHMjLnc5t0toz6iWeDGCiHjr6WN4NDlOVsAmRV4GewRq0IcRsa6LkblVI
         w7IzXEQSayPILQzKK/OkUWQH1T4T6qJp7PFHfKHJli19G4boFmsihVe2yskBEmhJh1f1
         kKrUKb4c6QzakWs9+USmGeR4rU3TOVCi0J72dYYMTmQ5Cey+Urh4A1ot7tgjY+T0d5cA
         2R+g==
X-Gm-Message-State: ABy/qLbYgDQzPEcIFk3LTpmUyJ67378gZz1SexY86NDtBpTidUhQjN8Q
        qbJYYQx8YAVCGDHtHOlV7DKK/vXNXds=
X-Google-Smtp-Source: APBJJlF1uQ1HTmMBZWfJCM/13TKczKsoaTeBKhlZrC38mHnED75QNfDg8decDDcGYLJxiQnkW+9quw==
X-Received: by 2002:a05:6a20:729a:b0:100:b92b:e8be with SMTP id o26-20020a056a20729a00b00100b92be8bemr454406pzk.2.1690325606910;
        Tue, 25 Jul 2023 15:53:26 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id e15-20020aa78c4f000000b00686bef984e2sm224354pfd.80.2023.07.25.15.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:53:26 -0700 (PDT)
Date:   Tue, 25 Jul 2023 15:53:24 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Alex Maftei <alex.maftei@amd.com>
Cc:     shuah@kernel.org, rrameshbabu@nvidia.com, davem@davemloft.net,
        kuba@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] selftests/ptp: Add support for new
 timestamp IOCTLs
Message-ID: <ZMBSZDk8hNoLg8ts@hoboy.vegasvil.org>
References: <cover.1690321709.git.alex.maftei@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690321709.git.alex.maftei@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 25, 2023 at 10:53:32PM +0100, Alex Maftei wrote:
> PTP_SYS_OFFSET_EXTENDED was added in November 2018 in
> 361800876f80 (" ptp: add PTP_SYS_OFFSET_EXTENDED ioctl")
> and PTP_SYS_OFFSET_PRECISE was added in February 2016 in
> 719f1aa4a671 ("ptp: Add PTP_SYS_OFFSET_PRECISE for driver crosstimestamping")
> 
> The PTP selftest code is lacking support for these two IOCTLS.
> This short series of patches adds support for them.
> 
> Changes in v2:
> - Fixed rebase issues (v1 somehow ended up with patch 1 being from the
>   first manual split of my changes and patch 2 being from rebase 2 out
>   of 3)
> - Rebased on top of net-next
> 
> Alex Maftei (2):
>   selftests/ptp: Add -x option for testing PTP_SYS_OFFSET_EXTENDED
>   selftests/ptp: Add -X option for testing PTP_SYS_OFFSET_PRECISE
> 
>  tools/testing/selftests/ptp/testptp.c | 73 ++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 2 deletions(-)

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>
