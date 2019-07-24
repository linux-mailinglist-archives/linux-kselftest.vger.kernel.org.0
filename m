Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2D0E7315A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2019 16:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGXORC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 10:17:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42724 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXORB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 10:17:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so21025287pff.9
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2019 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVEa+BrbD+ybsnA2U1ljAFs3yPdamhmoGuSiTUjWPJ4=;
        b=DWU4WjGAtgl8VCFFOjc8wXQ0g23uMAUtJpd38Z3oaJgwn4NfatixOvhmdpOdL+fxhG
         e0wlc3X1shT5Iq30jjbbWGUReEBT4OBXlYiiQUhWx2Q7uiFMfOEneT8NH6f9J2qp0V5H
         uul5tf2SvUAF38K7907CwJA6dKexcEorDJsv/KoSqA3HSUAO6tsOMxjz0hFsJBWrp9kB
         d53dWGlSvFswyl6j+n5LUh4qGYRvo3+KwFNfAV8S+2jUqD0GvKKHxnABV1FWZ1+b1OBh
         oB2T3ZDN/Zfw5qlFjUWW5qYsM2z/YZXngByjiqcmIeT7gWGze9CMbYqnOAvNwjkoL4TA
         mEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVEa+BrbD+ybsnA2U1ljAFs3yPdamhmoGuSiTUjWPJ4=;
        b=QccyCdz+6LCC1FiePfyd8UZzDCO1KV9ZeTAeeQrbV8Lq7sHofzBY2g7XV5+c65YGEm
         0SRuaKbIvBeAeGZcSU6s8UjLdBky0OY4G5UFFeP2s6KetGMx0pkmArXzDnDn/fAkxv6K
         6h8sBDXj8jRbnoWFCmTj99kgHnS/ElqnCVvy/zVh73wqndeMzKNG/S3C2K7j9Gwk/rbi
         9sh7f4AWO97c/EgWKYfXkWFH/SeAe++8q/AqyCpNbjb6eRaR+ss3kaigyn3jt4kf9BCY
         KES5AtTXQs1SjW6Pcpg0IINTHd5kfXVHfgAVwhBFyg5DRT93lo1mWWefbU5rwAsk8/FF
         KLLA==
X-Gm-Message-State: APjAAAV5/UjRgmSihZm//Wm4oh44M2rwzDsKnzKVGV1RS3ZXPBmlHkZv
        fY62VfutWE9ZjS5WT7z4GRNK0jo+ezKnRUM+5byGnA==
X-Google-Smtp-Source: APXvYqz2dMxGxnq2kAfIP49TpeG4FcaV+yTvRZ4CcUcR9QT0oeQ2GoQPtuki1B+xbKFnrASZfeBQUkyN7t1WRbfNCv8=
X-Received: by 2002:aa7:86c6:: with SMTP id h6mr11779914pfo.51.1563977820600;
 Wed, 24 Jul 2019 07:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563904656.git.andreyknvl@google.com> <CAAeHK+yc0D_nd7nTRsY4=qcSx+eQR0VLut3uXMf4NEiE-VpeCw@mail.gmail.com>
 <20190724140212.qzvbcx5j2gi5lcoj@willie-the-truck>
In-Reply-To: <20190724140212.qzvbcx5j2gi5lcoj@willie-the-truck>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 24 Jul 2019 16:16:49 +0200
Message-ID: <CAAeHK+xXzdQHpVXL7f1T2Ef2P7GwFmDMSaBH4VG8fT3=c_OnjQ@mail.gmail.com>
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
To:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org,
        Kostya Serebryany <kcc@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 24, 2019 at 4:02 PM Will Deacon <will@kernel.org> wrote:
>
> Hi Andrey,
>
> On Tue, Jul 23, 2019 at 08:03:29PM +0200, Andrey Konovalov wrote:
> > On Tue, Jul 23, 2019 at 7:59 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > === Overview
> > >
> > > arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> > > tags into the top byte of each pointer. Userspace programs (such as
> > > HWASan, a memory debugging tool [1]) might use this feature and pass
> > > tagged user pointers to the kernel through syscalls or other interfaces.
> > >
> > > Right now the kernel is already able to handle user faults with tagged
> > > pointers, due to these patches:
> > >
> > > 1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
> > >              tagged pointer")
> > > 2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
> > >               pointers")
> > > 3. 276e9327 ("arm64: entry: improve data abort handling of tagged
> > >               pointers")
> > >
> > > This patchset extends tagged pointer support to syscall arguments.
>
> [...]
>
> > Do you think this is ready to be merged?
> >
> > Should this go through the mm or the arm tree?
>
> I would certainly prefer to take at least the arm64 bits via the arm64 tree
> (i.e. patches 1, 2 and 15). We also need a Documentation patch describing
> the new ABI.

Sounds good! Should I post those patches together with the
Documentation patches from Vincenzo as a separate patchset?

Vincenzo, could you share the last version of the Documentation patches?

Thanks!

>
> Will
