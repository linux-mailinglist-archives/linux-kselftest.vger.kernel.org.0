Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51292293AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 10:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgGVIhT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jul 2020 04:37:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57479 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGVIhS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jul 2020 04:37:18 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <paolo.pisati@canonical.com>)
        id 1jyAFY-0005xW-P2
        for linux-kselftest@vger.kernel.org; Wed, 22 Jul 2020 08:37:16 +0000
Received: by mail-ua1-f71.google.com with SMTP id h10so356111uar.6
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 01:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+bYSyuCUZFAkGtII1RmdIT7fMN+AO1fhPK7l1587qY=;
        b=owjLbTKKWKDpeQztKfy+O63OLvWA4GpmQuwaWb1h6oHPT4zO7FGtGkLD1sadb/B7de
         eKiSRPA6fAxaVECHN9gahIZZH1XHEe5MWOQUS1IHNG59o2wpRJ//x+PF0HcxUOTLjVBr
         osPpzcbzD5Vxp0erUws/+SVM5cwiFDr4TGOjtiYWtd3DTx20sBOqe1lM3iOTsiB5Ojlz
         FTCZTUYihlg9WLen9GRW98iU9IOXyKLQXHoVa/uzFNOa2G7PCjGAJIqzh2B97VQ3NoTD
         OHMb58wg6TE5zpNJElJx/8+mzAulAeMlaAsDK8ekHFA8wil9FK6lVNSq1IuhqzEC1Cwm
         iKIQ==
X-Gm-Message-State: AOAM5331iTs5LGGgZgrIpJ6onFg0LtEOIDyC+f4ouWp0VymddGgiIaJC
        IwYfJaGWEiQZ9cjBCT9kuvsEWFcC692g0bIms/20HvrMAUtopRYr1hlddr+ASMRAyQWM0rGkiyg
        r9kmSWBxQN8xvnBghCem9hIjdNLo/OMSUGSyQ68vvcZ/9dAlIxObjBrUAsebMaw==
X-Received: by 2002:a67:1105:: with SMTP id 5mr24340545vsr.174.1595407034591;
        Wed, 22 Jul 2020 01:37:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHhx8M1zvoxC/SgvLXUeJNSlv9KoZs9SK1CB828zfYcRVOHt6JU+7hR5X5KsNVtgCDY7YsQoWp9nuI8gUSZfk=
X-Received: by 2002:a67:1105:: with SMTP id 5mr24340530vsr.174.1595407034362;
 Wed, 22 Jul 2020 01:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FuTSeN8SONXySGys8b2EtTqJmHDKw1XVoDte0vzUPg=yuH5g@mail.gmail.com>
 <20200721161710.80797-1-paolo.pisati@canonical.com> <CA+FuTSe1-ZEC5xEXXbT=cbN6eAK1NXXKJ3f2Gz_v3gQyh2SkjA@mail.gmail.com>
In-Reply-To: <CA+FuTSe1-ZEC5xEXXbT=cbN6eAK1NXXKJ3f2Gz_v3gQyh2SkjA@mail.gmail.com>
From:   Paolo Pisati <paolo.pisati@canonical.com>
Date:   Wed, 22 Jul 2020 10:37:03 +0200
Message-ID: <CAMsH0TTQnPGrXci3WvjM+8sdJdxOjR9MnwFvv4DS6=crMCAt4A@mail.gmail.com>
Subject: Re: [PATCH v2] selftest: txtimestamp: fix net ns entry logic
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jian Yang <jianyang@google.com>,
        Network Development <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 21, 2020 at 6:26 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Fixes: cda261f421ba ("selftests: add txtimestamp kselftest")
>
> Acked-by: Willem de Bruijn <willemb@google.com>

Besides, is it just me or this test fails frequently? I've been
running it on 5.4.x, 5.7.x and 5.8-rcX and it often fails:

...
    USR: 1595405084 s 947366 us (seq=0, len=0)
    SND: 1595405084 s 948686 us (seq=9, len=10)  (USR +1319 us)
ERROR: 6542 us expected between 6000 and 6500
    ACK: 1595405084 s 953908 us (seq=9, len=10)  (USR +6541 us)
    USR: 1595405084 s 997979 us (seq=0, len=0)
    SND: 1595405084 s 999101 us (seq=19, len=10)  (USR +1121 us)
    ACK: 1595405085 s 4438 us (seq=19, len=10)  (USR +6458 us)
    USR: 1595405085 s 49317 us (seq=0, len=0)
    SND: 1595405085 s 50680 us (seq=29, len=10)  (USR +1363 us)
ERROR: 6661 us expected between 6000 and 6500
    ACK: 1595405085 s 55978 us (seq=29, len=10)  (USR +6661 us)
    USR: 1595405085 s 101049 us (seq=0, len=0)
    SND: 1595405085 s 102342 us (seq=39, len=10)  (USR +1293 us)
ERROR: 6578 us expected between 6000 and 6500
    ACK: 1595405085 s 107627 us (seq=39, len=10)  (USR +6577 us)
    USR-SND: count=4, avg=1274 us, min=1121 us, max=1363 us
    USR-ACK: count=4, avg=6559 us, min=6458 us, max=6661 us


In particular, "run_test_v4v6 ${args}       # tcp" is the most
susceptible to failures (though i've seen the udp variant fail too).
-- 
bye,
p.
