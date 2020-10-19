Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B118029213F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Oct 2020 04:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgJSCul (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 18 Oct 2020 22:50:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49321 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgJSCuk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 18 Oct 2020 22:50:40 -0400
Received: from mail-lj1-f200.google.com ([209.85.208.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kULFu-0005NV-FS
        for linux-kselftest@vger.kernel.org; Mon, 19 Oct 2020 02:50:38 +0000
Received: by mail-lj1-f200.google.com with SMTP id r19so4705388ljj.9
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Oct 2020 19:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTrK0pAVZQQtS/tzM7uwTIFZMUuNtDoL2D9yFspbaVY=;
        b=QvvI9hIoDQUS0ri5CCfHDdXSJSoXx0PWn6xfyVdq2hf62gJkSykvWuuK9VbWx5pf/U
         mTZCfOGa398Y5v/nhr/mwaxcKlg+Oa6NIAmim/9Qdz0l0SZtoB65xVzLLMMY2CBz32FF
         1BPUMXXDISj7vbGsonbhybtJkUBeOHcxMh8+LdEI9+H/xIcwSIfGytY9oo7DbFf1wZ1f
         FnOTG2ECd9NrijSwtJ9KRNmAuHA37FI13WrkTZmg9Zqa64X6UOa6Fkxhf2g3ZlybWkA7
         695rtA3Be2OuWgjKBokj5cW3Thd7fWnG3lJespXvXCD4RMgidKwmRWoZym9Gf7jLe869
         HNsQ==
X-Gm-Message-State: AOAM532DwfNE2E9ARcdVHIAkCocm2XSpInKFN7KO8fxxGnYOjFY/FMS8
        ajv10k1b1rE668jWvzbgx7+xIrWIdFbckeLIG4cBiIFW/8yBrPmSJyaliAj+pEr8OfvxTRMGJGz
        vAs8LUaaatymkXgmfq8+sWreQSs9zhrK4H10Q/vkA3ayoA8F65OBHbM8yVmsK
X-Received: by 2002:a2e:b610:: with SMTP id r16mr5420425ljn.145.1603075837823;
        Sun, 18 Oct 2020 19:50:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykKr5i72+Z18iQtWw3/e6ifc5NFHwy1z43A4/0WmlyHcQutDyhot3re5YEu2SGMKKEoY3zxU0o520TJ6gK/gM=
X-Received: by 2002:a2e:b610:: with SMTP id r16mr5420418ljn.145.1603075837589;
 Sun, 18 Oct 2020 19:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201016041211.18827-1-po-hsu.lin@canonical.com> <20201016163248.57af2b95@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201016163248.57af2b95@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Mon, 19 Oct 2020 10:50:26 +0800
Message-ID: <CAMy_GT_vTmVRi-pjysaw1ccwek0r+w12zZokKDmMsCd+ut5eaQ@mail.gmail.com>
Subject: Re: [PATCHv4] selftests: rtnetlink: load fou module for
 kci_test_encap_fou() test
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 17, 2020 at 7:32 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 16 Oct 2020 12:12:11 +0800 Po-Hsu Lin wrote:
> > The kci_test_encap_fou() test from kci_test_encap() in rtnetlink.sh
> > needs the fou module to work. Otherwise it will fail with:
> >
> >   $ ip netns exec "$testns" ip fou add port 7777 ipproto 47
> >   RTNETLINK answers: No such file or directory
> >   Error talking to the kernel
> >
> > Add the CONFIG_NET_FOU into the config file as well. Which needs at
> > least to be set as a loadable module.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> Doesn't apply :( Could you rebase on top of:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/
Ah OK, I was using the next branch in kselftest, will resend another one.
Thanks.
