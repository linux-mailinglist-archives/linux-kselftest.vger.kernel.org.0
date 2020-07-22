Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722D3229889
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 14:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbgGVMu1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jul 2020 08:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMu1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jul 2020 08:50:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52345C0619DC
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 05:50:27 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 11so1814480qkn.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+el/4IjxY5c/A2Xkjehcvj/Zw3lDkjmnm4fPzj7FEY=;
        b=K5CLDhMO8VOhCWsQmJTWzgBr8pNoz9/g9XoMr2GBxhc4faqvibRjSC7ijhfd0rj4Or
         EAh4KUB+a8SDhfvg2DstycRIHsTbwwOUwrLyIwBC77KG0mWVNaca++DEe3Do+NQS9tAK
         rJh4ulyrFi3MypW6toTUSRapLAxXFRZVnfbivL42DORirSSCTkq8ztYBSa9mwppHubMx
         uasntbPhG1oeuxsz4lYhUVcTP3gvoH1kWTz4h6ozQDe6asb7eC//LcxUvXVwRSZtxfoA
         BkEWy3oWL114hJC06FQLhFbRuMtBkc1lBfEiihWT1tMOAdE+6JtzE6qLS49NkhBjmJ4t
         oh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+el/4IjxY5c/A2Xkjehcvj/Zw3lDkjmnm4fPzj7FEY=;
        b=G2DpJmSHtmTijQ1Vgb7q+W6MxSsJZMmTyQIBouHx0+FZ96qANlF+NaH6f9iyk28nG4
         n+Xom2VQYo24NzfjXUJvLsnzctDQsK6mSQlP+o7N0kbRxtIpU4KrmIAxe7qh7tfA47CX
         mWQPLcGYk03/9OqyxsdmS42qzW2JQYQdZuy97hUu39c78wmfGDhsKdflNqS44LnSUGvf
         HlTjoMVC6OSTOPAjb6SO4xxJvcU/BHlUT3s9Asvtc5TbDdDsnfWP+/5wHwtwN7zZGiba
         51unNPdxB3Z97xLXKJ1ECvX5LHURruBh7z6O5UIwammP2LsfSg6RA++lUOaws4UsEWk4
         wf+Q==
X-Gm-Message-State: AOAM531XoX+Xm5fJ5qz3MPmnuGGSaCd0q7+7TL+3LXL8wc2t7DfOLtRw
        damkC81jhTNcpu8fLcAbbfUjQtvR
X-Google-Smtp-Source: ABdhPJwaTNdfn5gC5Sg+Nz3eGeua5a/3tP+DsspLKFSvvyF4Fo5Ib5onQjEaEbpT/p7RjEIdgZJc3w==
X-Received: by 2002:a05:620a:2444:: with SMTP id h4mr24083912qkn.352.1595422225951;
        Wed, 22 Jul 2020 05:50:25 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id t5sm5056049qkh.46.2020.07.22.05.50.24
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 05:50:24 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id j1so945621ybh.10
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 05:50:24 -0700 (PDT)
X-Received: by 2002:a25:cc4e:: with SMTP id l75mr50937615ybf.165.1595422224171;
 Wed, 22 Jul 2020 05:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FuTSeN8SONXySGys8b2EtTqJmHDKw1XVoDte0vzUPg=yuH5g@mail.gmail.com>
 <20200721161710.80797-1-paolo.pisati@canonical.com> <CA+FuTSe1-ZEC5xEXXbT=cbN6eAK1NXXKJ3f2Gz_v3gQyh2SkjA@mail.gmail.com>
 <CAMsH0TTQnPGrXci3WvjM+8sdJdxOjR9MnwFvv4DS6=crMCAt4A@mail.gmail.com>
In-Reply-To: <CAMsH0TTQnPGrXci3WvjM+8sdJdxOjR9MnwFvv4DS6=crMCAt4A@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 22 Jul 2020 08:49:47 -0400
X-Gmail-Original-Message-ID: <CA+FuTSc0V4TGMF6KhZVkLfv1=OXXdV+J3ufKuXd0GhrHb2hjbw@mail.gmail.com>
Message-ID: <CA+FuTSc0V4TGMF6KhZVkLfv1=OXXdV+J3ufKuXd0GhrHb2hjbw@mail.gmail.com>
Subject: Re: [PATCH v2] selftest: txtimestamp: fix net ns entry logic
To:     Paolo Pisati <paolo.pisati@canonical.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
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

On Wed, Jul 22, 2020 at 4:37 AM Paolo Pisati <paolo.pisati@canonical.com> wrote:
>
> On Tue, Jul 21, 2020 at 6:26 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Fixes: cda261f421ba ("selftests: add txtimestamp kselftest")
> >
> > Acked-by: Willem de Bruijn <willemb@google.com>
>
> Besides, is it just me or this test fails frequently? I've been
> running it on 5.4.x, 5.7.x and 5.8-rcX and it often fails:
>
> ...
>     USR: 1595405084 s 947366 us (seq=0, len=0)
>     SND: 1595405084 s 948686 us (seq=9, len=10)  (USR +1319 us)
> ERROR: 6542 us expected between 6000 and 6500
>     ACK: 1595405084 s 953908 us (seq=9, len=10)  (USR +6541 us)
>     USR: 1595405084 s 997979 us (seq=0, len=0)
>     SND: 1595405084 s 999101 us (seq=19, len=10)  (USR +1121 us)
>     ACK: 1595405085 s 4438 us (seq=19, len=10)  (USR +6458 us)
>     USR: 1595405085 s 49317 us (seq=0, len=0)
>     SND: 1595405085 s 50680 us (seq=29, len=10)  (USR +1363 us)
> ERROR: 6661 us expected between 6000 and 6500
>     ACK: 1595405085 s 55978 us (seq=29, len=10)  (USR +6661 us)
>     USR: 1595405085 s 101049 us (seq=0, len=0)
>     SND: 1595405085 s 102342 us (seq=39, len=10)  (USR +1293 us)
> ERROR: 6578 us expected between 6000 and 6500
>     ACK: 1595405085 s 107627 us (seq=39, len=10)  (USR +6577 us)
>     USR-SND: count=4, avg=1274 us, min=1121 us, max=1363 us
>     USR-ACK: count=4, avg=6559 us, min=6458 us, max=6661 us
>
>
> In particular, "run_test_v4v6 ${args}       # tcp" is the most
> susceptible to failures (though i've seen the udp variant fail too).

Not for me. The interval bounds have been set as is based on previous
experience.

Are you running it inside a VM? Especially qemu without kvm
acceleration could increase jitter.

The reports are not far outside the bounds. They can be extended a bit
if that considerably reduces flakiness.
