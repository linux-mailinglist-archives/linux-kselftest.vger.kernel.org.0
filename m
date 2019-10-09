Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C57FD1780
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbfJISWN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 14:22:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37189 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731461AbfJISWN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 14:22:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id u184so3121822qkd.4
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Oct 2019 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2xenOjKhEjI3eIbcLRwgdoYJ+Yca/GheW1m8e/Y1fI=;
        b=iSGFQLIZfMmkjaRR51tXuM3S5frAEjjZKhlmjZn6k/5dU6gTR4YZL1HctIZjL8x0z/
         ztFPTbxc0PHe23byPLC7xn9GYkJ48Uf1y9rp53qA/9f03vwBMqkVohJmyFGOMXxP9e6v
         sFsTdk8Zu+xcdEHQyA+CKtmovzimXrCV294hmRTk8x/Bv8yo6sBowaspPa/3EeLHumpz
         hV/wkjyDA9y02ysYOjSmOhczTBuRJU0LXfXcek851Z4Im3ASeABO7rbg3a3KEXJhkwct
         Gd84p/ulOFjVT0NuMpp4rdy/w7zXFE+bs3gXdd5ZtVedCG2dAlrojO7RD8+DqGPxiGMm
         OYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2xenOjKhEjI3eIbcLRwgdoYJ+Yca/GheW1m8e/Y1fI=;
        b=teBJDStISiB+CdVodptnT8Oo1WzshiTo2uV7XEwnm40RpBEeO6AjS2QWWB6PtCqtYx
         LllDaQ8mndZlGkyzQwus6RQzI+cs/yVRNdIV7I8Fb6bCUQLe3FDZconKBlQmX49Mnyct
         tRstTL1kWo5bwPnk8wkA4G1bZ32UfpRsDUA7TohNR3Hg/4nqw3vumALl0botljqY20PS
         CNewVvZJ1RzikGbD9EuBikR4gVM2HvxmxWOzFCokeHiPTgCb2YqOokc6F47U0DvskGl0
         BY5nLFRolsxOFT1sSyV8dHGe+V+R+A+b+VIU6MpUetWsS9dYP0uxd+rqTVmTaqL/usgj
         ibgA==
X-Gm-Message-State: APjAAAUCxyu4wOdBCMKbBMKkstmYFlPfyjsdTKR0IdnlDMDPBIoUCW1o
        xkso68jQODFLPDNfzDsYXa81u1teWn/s3BjgxxZ50Q==
X-Google-Smtp-Source: APXvYqyofEfweyiCTLlPPDZvFYgTchDbRQyfSzi96XRZBpMeCyWEE7EKAypqQSpLrRjLYrmmB/Kbuomn0N3J45JI3jc=
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr5147732qkm.250.1570645330350;
 Wed, 09 Oct 2019 11:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191009142446.6997-1-rpalethorpe@suse.com> <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
 <20191009145416.GA5014@rei.lan> <CACT4Y+ZL8ocQPpwR-_8+0PdF=r3AkFZKvOR==+P0y0GF67w1Vg@mail.gmail.com>
 <20191009180447.GD15291@rei.lan>
In-Reply-To: <20191009180447.GD15291@rei.lan>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Oct 2019 20:21:59 +0200
Message-ID: <CACT4Y+ZABX2z4Lxrvokf5DHz351xTys-gJPNhFjP+Zx6Qd2zsg@mail.gmail.com>
Subject: Re: [RFC PATCH] LTP Wrapper for Syzkaller reproducers
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Richard Palethorpe <richard.palethorpe@suse.com>,
        syzkaller <syzkaller@googlegroups.com>, kernelci@groups.io,
        shuah <shuah@kernel.org>, ltp@lists.linux.it,
        George Kennedy <george.kennedy@oracle.com>,
        Cyril Hrubis <chrubis@suse.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 9, 2019 at 8:04 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > Indeed, it's removed recursively by the test library.
> >
> > :popcorn:
> >
> > It took me several years to figure out how to more or less reliably
> > remove dirs after the fuzzer ;)
> > (no, unlink won't do ;))
>
> I guess that there are things such as immutable file attributes that has
> to be cleared and many more. Do you have piece of code somewhere that we
> can look into to spare us from reinventing the wheel?

Here is what we have:
https://github.com/google/syzkaller/blob/c4b9981b5f5b70dc03eb3f76c618398510101a1d/executor/common_linux.h#L2358-L2461
Maybe it can be simplified, but that's what we ended up with after
some organic evolution. At least the comments may give some hints as
to what may go wrong.
