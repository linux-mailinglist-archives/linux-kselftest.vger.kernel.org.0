Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F36B228542
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 18:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgGUQ0P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgGUQ0P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 12:26:15 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF99C0619DB
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 09:26:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i3so16571061qtq.13
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBP7qP0FYUChGaa0hrCulaczX/efODgBvnjZrXBVhPI=;
        b=nUKUr55EXExbEWdGOSEgTubGim/24Vyuixpdf0xLuViukQ1HYqXJ7wLSsx+StUT43t
         K7S55wPrevvD8wkT/jrhclLmMejSUMDLw/wfvqShS0D/yhLD7MZQeo5BKdYi4rR98vdh
         A4Abp/qboL4FVZMjQwFlFG/Qg49E4D6cnF+/nV1uHLYdZC2dmvQK1VAuuU6ef+ygSSnQ
         8nE6dM9lGyZyn4qkp8Fh/bl8PGghxxHCR1zTT9HnL1uv9lfgENAOh4F46b94eDP/ywhC
         fHczpcKRfaXaS77iH+rIzwkD7Z+il6u/vAyKFt8XUshWYfbGW0VPWA07ft3AHzYXsQOH
         rEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBP7qP0FYUChGaa0hrCulaczX/efODgBvnjZrXBVhPI=;
        b=ptob/Jf8W4ga+mhs3iUPJ+j2khoQR/hTFGHPb8zgakz6bA8F4yVVeknOnVUWxx1Qdr
         /SaXG8uBORT7atw6pZXrHuQ/smCP1PvF+JHz1MkPcL6SwVQiuV38yNZww/gGl64E4hRe
         hivZYG1U6JAcKPDtggVsxvE5bMOeo4qTl1Ed2VCHfO50r3CdspAzDeSpLGpersWBcx7B
         oTZZLR5C5cmx4y7bwjJI5Rn734M1GHLZrg2WNLZjRlXkW+pBLu97cnU/6jAlKGOqO9eV
         1UUqf29JV/7JKmx/lFYGYUf1Z8Dc4bm6+8SVeT4iwYKAtglntIpQap4NfKROZTcO97qu
         iIhQ==
X-Gm-Message-State: AOAM533lpiM09tCDZY9ZQstVCt4MwmesI1q9rXMsGOPoxX6YFyO+Qf2M
        EF7aqZcC0xRU1Vcuab5zxWgI6YFq
X-Google-Smtp-Source: ABdhPJzc07NSdHq/S+xC5sPDate4lalPxJRPEL5XYfrKzsv95BGGSF1LT5y/1DQ4IZjXj/NrmuveuA==
X-Received: by 2002:aed:2c87:: with SMTP id g7mr30876977qtd.346.1595348773661;
        Tue, 21 Jul 2020 09:26:13 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id n63sm2556351qkf.21.2020.07.21.09.26.12
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 09:26:12 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 2so10247035ybr.13
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 09:26:12 -0700 (PDT)
X-Received: by 2002:a25:6d87:: with SMTP id i129mr42670421ybc.315.1595348772036;
 Tue, 21 Jul 2020 09:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FuTSeN8SONXySGys8b2EtTqJmHDKw1XVoDte0vzUPg=yuH5g@mail.gmail.com>
 <20200721161710.80797-1-paolo.pisati@canonical.com>
In-Reply-To: <20200721161710.80797-1-paolo.pisati@canonical.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 21 Jul 2020 12:25:36 -0400
X-Gmail-Original-Message-ID: <CA+FuTSe1-ZEC5xEXXbT=cbN6eAK1NXXKJ3f2Gz_v3gQyh2SkjA@mail.gmail.com>
Message-ID: <CA+FuTSe1-ZEC5xEXXbT=cbN6eAK1NXXKJ3f2Gz_v3gQyh2SkjA@mail.gmail.com>
Subject: Re: [PATCH v2] selftest: txtimestamp: fix net ns entry logic
To:     Paolo Pisati <paolo.pisati@canonical.com>
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

On Tue, Jul 21, 2020 at 12:17 PM Paolo Pisati
<paolo.pisati@canonical.com> wrote:
>
> According to 'man 8 ip-netns', if `ip netns identify` returns an empty string,
> there's no net namespace associated with current PID: fix the net ns entrance
> logic.
>
> Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>

Fixes: cda261f421ba ("selftests: add txtimestamp kselftest")

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks for the fix.
