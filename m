Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923B64AA7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2019 20:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfFRS7G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jun 2019 14:59:06 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:32806 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbfFRS7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jun 2019 14:59:06 -0400
Received: by mail-yb1-f193.google.com with SMTP id h17so6515862ybm.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2019 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2DDWkzfly8h++f2u7ETcCEDtyV1BipVpATFf3iGFj8=;
        b=ajUxc5+WJTxSIoBZ8SzOIP0EH5Oo4BIYMnTAueKHonh90SwDslBsrBqH/p5BpVV1lE
         bd8TeYNgekt+y1cFqWvfRhaaJktj/9HlmdRNP7O58u1L65J44e2TAoQ8mMwBrd2BehYY
         obhYCp/B5KF22P/dc7ZBTYUlxM50LS5cqX29I4OO2r4135df2kSGUOrYLAFBYkCwCbo6
         cqjc1a96YiF6gxE5t85rWZKUyG+cGcX32J5aHJGR0RYnFzCFaVXB0BKAWWinXwoZqMuA
         SssoPo5k02S7ZyalbCbsr+FvpZ8E+vHGkIcj1lW+J8TKA/Kd79OAsr3tVxdiBndDDKUG
         R+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2DDWkzfly8h++f2u7ETcCEDtyV1BipVpATFf3iGFj8=;
        b=Y1kwX8KPIKOnjGcymLO1JLnWUW6/Ii5iVipLyGbsJRg362uu84F07U9frM2ePu2cYq
         tI20L/E1KuuXnWQUrIuaIK2EK+X3Gx2SzD6OpqOIVd7y9T9jx5g1u+sk8eM/BohHTJmd
         RadS/tCoUV2W7m125GS1siMPaqrooLVnhuVf12NH2kUuCXtk+Vbwj580u5OJ6jT7L0Km
         5V3+z1qQOQVPC3zZYcrysTxlTiQIaggl3qsx6qzx7dE66ySj/kkbbWOY+b9eGP5jIt3w
         7JkG36/uDHPYKU3ZbgPBeUyULtlzxw8SopdVNrvmjL8i62tlx51M1LSbddkhxEZMt3S2
         S9uw==
X-Gm-Message-State: APjAAAXoxajMay1cQrhhiyeSywu6gAVcD4RAvBSHPVdeMuZvyse3iqji
        +ol5RQnls4yKuz6uerGY7WoZHzr2
X-Google-Smtp-Source: APXvYqy+r2Q9BQxwP31gTzGq5XnI6xFToACyojUAhcmlUCJGivGPXDVJr4xo7CxR2hSODgX+zJP/Fg==
X-Received: by 2002:a25:943:: with SMTP id u3mr59362481ybm.293.1560884344290;
        Tue, 18 Jun 2019 11:59:04 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id j188sm4160911ywj.18.2019.06.18.11.59.02
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:59:03 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id 186so7172607ywo.4
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2019 11:59:02 -0700 (PDT)
X-Received: by 2002:a0d:c0c4:: with SMTP id b187mr41089130ywd.389.1560884342538;
 Tue, 18 Jun 2019 11:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FuTSfBFqRViKfG5crEv8xLMgAkp3cZ+yeuELK5TVv61xT=Yw@mail.gmail.com>
 <20190618161036.GA28190@kroah.com> <CAF=yD-JnTHdDE8K-EaJM2fH9awvjAmOJkoZbtU+Wi58pPnyAxw@mail.gmail.com>
 <20190618.094759.539007481404905339.davem@davemloft.net> <20190618171516.GA17547@kroah.com>
 <CAF=yD-+pNrAo1wByHY6f5AZCq8xT0FDMKM-WzPkfZ36Jxj4mNg@mail.gmail.com> <20190618173906.GB3649@kroah.com>
In-Reply-To: <20190618173906.GB3649@kroah.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 18 Jun 2019 14:58:26 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdrphico4044QTD_-8VbanFFJx0FJuH+vVMfuHqbphkjw@mail.gmail.com>
Message-ID: <CA+FuTSdrphico4044QTD_-8VbanFFJx0FJuH+vVMfuHqbphkjw@mail.gmail.com>
Subject: Re: 4.19: udpgso_bench_tx: setsockopt zerocopy: Unknown error 524
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Fred Klassen <fklassen@appneta.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 18, 2019 at 1:39 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 18, 2019 at 01:27:14PM -0400, Willem de Bruijn wrote:
> > On Tue, Jun 18, 2019 at 1:15 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jun 18, 2019 at 09:47:59AM -0700, David Miller wrote:
> > > > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > Date: Tue, 18 Jun 2019 12:37:33 -0400
> > > >
> > > > > Specific to the above test, I can add a check command testing
> > > > > setsockopt SO_ZEROCOPY  return value. AFAIK kselftest has no explicit
> > > > > way to denote "skipped", so this would just return "pass". Sounds a
> > > > > bit fragile, passing success when a feature is absent.
> > > >
> > > > Especially since the feature might be absent because the 'config'
> > > > template forgot to include a necessary Kconfig option.
> > >
> > > That is what the "skip" response is for, don't return "pass" if the
> > > feature just isn't present.  That lets people run tests on systems
> > > without the config option enabled as you say, or on systems without the
> > > needed userspace tools present.
> >
> > I was not aware that kselftest had this feature.
> >
> > But it appears that exit code KSFT_SKIP (4) will achieve this. Okay,
> > I'll send a patch and will keep that in mind for future tests.
>
> Wonderful, thanks for doing that!

One complication: an exit code works for a single test, but here
multiple test variants are run from a single shell script.

I see that in similar such cases that use the test harness
(ksft_test_result_skip) the overall test returns success as long as
all individual cases return either success or skip.

I think it's preferable to return KSFT_SKIP if any of the cases did so
(and none returned an error). I'll do that unless anyone objects.
