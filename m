Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B10E41F97D
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Oct 2021 05:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhJBDSF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Oct 2021 23:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhJBDSF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Oct 2021 23:18:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2247C061775
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Oct 2021 20:16:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso8031570wme.0
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Oct 2021 20:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRRgfa1jwx7KE2gon3snTWAPopiduxwAu3R+KiFpgDY=;
        b=jx1xhiSilBXMu76bopUb6ItbtlOyagKNfcpW8OjlefPp7C0d9SNepFS4COaotvA8jj
         r7OHttaOwK5XCQiwsSDJzyaRUogxlqjBPElrCn6cf7zJpU31tlhEbTAsLQxXH97doSF6
         Qc5lw9NjMGktXIEiKJKIj/Put4dMq15TkHIOUsVrZ1a4x2KH+v2eKQyEkaW5VNSDbmh6
         s45uWM+XkrQGaowGAXL6HQA8Gk6F0XnNc811RlZgH/9nzDyu3Oe3yVgtBB5bjXx3+tRk
         7fNDtYWlf1mNxQJiBG6dnWkUgjv/uboTFHzN3zsi++JFqm7MW6siwR3fXkQnUHs6Ezxs
         xmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRRgfa1jwx7KE2gon3snTWAPopiduxwAu3R+KiFpgDY=;
        b=U+C8I3YCPfqCHOEVfA9oZnNILoe3N+bsq+4QA7S7+XHitlx4caV/uu02zvzDOQ5xNG
         tzQMO9jTtnvxd/fcrEZVcK7vG817LPbVltHm+YAaz+ST0tdvD6T99BgGpEbV+XLPO+Jz
         dpfmdgfx+bRJibs098q8Zq/cwRIl7xQoDvE0/lsGxa6dqp32mXk2ZD04Am+1Ub9xjr89
         C/W7ShyU5DVWeLUsXkq/erLNcfHiSGpg0rQjaGfG5O/dKaSs6ML/EIjeCR1WoTrjKOpl
         /M/SccuqfAtm2u6Mg8QOAZJ+hegXhiLnMtze1bSyKcG5VPXFCOtKjXhAheeH54buggVn
         5XOQ==
X-Gm-Message-State: AOAM530BLUIOn+O4pSi2hsrH0zJ/DiYtvh2k4kWN4PaKO/Z7up6+NWYX
        SEurrTD/fVuOdKMzo3Gp+sP1/M30+q36q+zhspxptQ==
X-Google-Smtp-Source: ABdhPJyO9HFau+hWBe01yGl1Ur2Sfe8aqf+C/e/nBua4KbCJn+N0dKGm6mZHbBD+nCv9dPEjsgY+dCtDl/jQ+YoArlQ=
X-Received: by 2002:a05:600c:1c1d:: with SMTP id j29mr7500373wms.49.1633144578094;
 Fri, 01 Oct 2021 20:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211002022656.1681956-1-jk@codeconstruct.com.au> <20211002022656.1681956-2-jk@codeconstruct.com.au>
In-Reply-To: <20211002022656.1681956-2-jk@codeconstruct.com.au>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Oct 2021 11:16:07 +0800
Message-ID: <CABVgOSkuN7XPPvnBQFm_h80eFpx_fT0veDPxMefVbiNa_ZQG8g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] mctp: test: defer mdev setup until we've registered
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 2, 2021 at 10:27 AM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> The MCTP device isn't available until we've registered the netdev, so
> defer storing our convenience pointer.
>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---

Haha -- you sent this just as I'd come up with the same patch here. :-)

With these changes, alongside the rt->dev == NULL in
mctp_route_release() crash fix mentioned in [1], the tests all pass on
my system. (They also pass under KASAN, which bodes well.)

This fix is,
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

[1]: https://lore.kernel.org/linux-kselftest/163309440949.24017.15314464452259318665.git-patchwork-notify@kernel.org/T/#m1a319b6932dd2bffaf78ab2d3b4c399282f7bda2



>  net/mctp/test/utils.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
> index e2ab1f3da357..cc6b8803aa9d 100644
> --- a/net/mctp/test/utils.c
> +++ b/net/mctp/test/utils.c
> @@ -46,17 +46,17 @@ struct mctp_test_dev *mctp_test_create_dev(void)
>         dev = netdev_priv(ndev);
>         dev->ndev = ndev;
>
> -       rcu_read_lock();
> -       dev->mdev = __mctp_dev_get(ndev);
> -       mctp_dev_hold(dev->mdev);
> -       rcu_read_unlock();
> -
>         rc = register_netdev(ndev);
>         if (rc) {
>                 free_netdev(ndev);
>                 return NULL;
>         }
>
> +       rcu_read_lock();
> +       dev->mdev = __mctp_dev_get(ndev);
> +       mctp_dev_hold(dev->mdev);
> +       rcu_read_unlock();
> +
>         return dev;
>  }
>
> --
> 2.30.2
>
