Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924C64423AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 00:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhKAXF1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 19:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhKAXF1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 19:05:27 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D5C061764
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Nov 2021 16:02:53 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id f4so34635076uad.4
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Nov 2021 16:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ri3QvIoL0Xe7eiVrSIf1ef7CY78Kkt5tzf6nCUl2RkQ=;
        b=Whh3qBjhddGxX0QnCft+XUHDm0GqNYRpD+93dmFtJPjjuzlMFhcnRbIHZSSh0PsAFA
         OZlnoBgSS7jpmeFNjcMfJ4zaWwuO9R9zf4vWssNMDvdv460Nyp8BSmJYucW/mhI5nWln
         XW7Hoazqpi3OpoEkcMCxmioVHZ3HnGLhtQ+f0rPLM5Sc7vx5Ltq6tiGWF4+RmQjAJkcD
         TO7FLuUL0kE+H3GPq79HdQOemT7j3xODQr4sQmWlW3gRgKtUrcuIarYNoyKM3QtW76FR
         BiMC9kPmBlrQH2P/23FBeHOcq2RS2LY9+zBNM24BxKwi0oXXr04ub0puxBIadjMqN8jN
         b3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ri3QvIoL0Xe7eiVrSIf1ef7CY78Kkt5tzf6nCUl2RkQ=;
        b=Xn9rz3sTTyTO21QUVL1VUY1iQFpxj53r2PRFOzVdkpBbKDPliPta9xoJqOSgH1tBn5
         ZaDEKtPsVA76BMN61/0KXZ/UyJbo/VAv9f+PT3DGxz5If+8QUaCpRQhHRNJLegOwwq/L
         dmY39JTXwMk8PisIfM2fFO70+P7U2sTzYli675x0eRUOA4yPBylBBIguG2ceP3rED+5r
         vWMR04YfB1EHbdip7FDBNHTRoO/r617oabPQcMlYrT9vPiFXe3xfSJRWexaZ5OZrjscI
         AkAGIkYY5+E1Mk1cQvG2NjJwdezW6aKTDurwYt5oDTIQ9GOIFDM7YPkSky1rFiZ1Cud/
         LwJg==
X-Gm-Message-State: AOAM533JbKMm1XPtZJqTDgGHT0//ckYc3icvNxBH8f0xTjCMJAvVG1Be
        O7B3mXKK12DM4vcl8KozFLPd0Mc/VEE=
X-Google-Smtp-Source: ABdhPJxUu1xVy8WXTfdFXQ6QBMPu9TN5J39Is2ESoTT7kPw8g/CGYI86acXq3t1MkkgjwhFrp+3jXA==
X-Received: by 2002:a67:a20d:: with SMTP id l13mr34260838vse.59.1635807772581;
        Mon, 01 Nov 2021 16:02:52 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id v13sm2710769vsi.0.2021.11.01.16.02.51
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 16:02:51 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id e5so34568375uam.11
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Nov 2021 16:02:51 -0700 (PDT)
X-Received: by 2002:a05:6102:1612:: with SMTP id cu18mr27229906vsb.49.1635807771319;
 Mon, 01 Nov 2021 16:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211101040609.127729-1-liuhangbin@gmail.com> <20211101040609.127729-5-liuhangbin@gmail.com>
In-Reply-To: <20211101040609.127729-5-liuhangbin@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 1 Nov 2021 19:02:14 -0400
X-Gmail-Original-Message-ID: <CA+FuTSesPTGL7B9MOGgb_9Xni9ni_1pDeS+Dm9=vUu1j6GT_qg@mail.gmail.com>
Message-ID: <CA+FuTSesPTGL7B9MOGgb_9Xni9ni_1pDeS+Dm9=vUu1j6GT_qg@mail.gmail.com>
Subject: Re: [PATCH net 4/5] kselftests/net: add missed toeplitz.sh/toeplitz_client.sh
 to Makefile
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Andrea Mayer <andrea.mayer@uniroma2.it>,
        Coco Li <lixiaoyan@google.com>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 1, 2021 at 12:06 AM Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> When generating the selftests to another folder, the toeplitz.sh
> and toeplitz_client.sh are missing as they are not in Makefile, e.g.
>
>   make -C tools/testing/selftests/ install \
>       TARGETS="net" INSTALL_PATH=/tmp/kselftests
>
> Fixes: 5ebfb4cc3048 ("selftests/net: toeplitz test")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 8a6264da5276..514bbed80e68 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -31,7 +31,9 @@ TEST_PROGS += gre_gso.sh
>  TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
>  TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
>  TEST_PROGS += srv6_end_dt6_l3vpn_test.sh
> +TEST_PROGS += toeplitz.sh
>  TEST_PROGS_EXTENDED := in_netns.sh setup_loopback.sh setup_veth.sh
> +TEST_PROGS_EXTENDED += toeplitz_client.sh

Thanks for adding the files. They are indeed missing.

But they are not intended to be run from kselftests, as this tests nic
hardware features. So both files should be under TEST_PROGS_EXTENDED?
