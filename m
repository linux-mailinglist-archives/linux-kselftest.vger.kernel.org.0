Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4946686DB4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 01:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404603AbfHHXJH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Aug 2019 19:09:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36550 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404001AbfHHXJH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Aug 2019 19:09:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so44176217plt.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2019 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PshILyRjCCo0C5QCJz7frN2AnaNP8oJw8QYaH2iANig=;
        b=dbDwiA4Adn6NNb5EvA73thvbmUP2keuqre4+n/NxwEHqhexDztnDaNh7AsRSTZZe49
         hYpD3IzLcNsObNJn7jV0JwQOyof3bHoudWE9xbxMphJZ3xC6+cAju3iiWanCTUgT+RRy
         5BTDqjSStXzv50strdYe4GteQ70uxl48L/KiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PshILyRjCCo0C5QCJz7frN2AnaNP8oJw8QYaH2iANig=;
        b=XBxLpPZ9bIw8ZsfRJ1ytQX4wwY4bJjPdp8ZmtmcuL9PpAhqkN3Oqh5MlmLS+SwWcj1
         nYMhIKHjQlwbAztkNPiVi3Y98hbJLauDvxmdShkpobAXGJKBxGqadXAwPLCzOZFTDLKA
         Wad+yN+JyEnHpSFigqmB4kcNID6ehFVPPU8CiaT4vGppw9349o9L2bYaLxSFeI0uaO2c
         zjDtc06P3yhJm/9RXOkUZ0ghm/UaN1mLm8xDZbJen9KlhakfoBwEH3ub63RZkP1DmY+Z
         wUnPbknsHKVPh1VpwpHS+oeyWif/lHy449WyJVFRvb4+nVgot4MWRCUcbPDmh72V/jJz
         1Oog==
X-Gm-Message-State: APjAAAXgUfPnkltq+OiUmE4h/Z/TKvnjfNTjLpT8Gu1PUKh6HOQ9dpHC
        LpMbC0iuetFWLPOY1+caCpabHg==
X-Google-Smtp-Source: APXvYqwRMwQCoIwwE1SVnXBBenp7lYzRwUiHs8nPiovNgZn+1R84ViErtlLi11BYuAEM5u5dpbcusw==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr15179356ply.251.1565305746634;
        Thu, 08 Aug 2019 16:09:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o130sm157376311pfg.171.2019.08.08.16.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 16:09:05 -0700 (PDT)
Date:   Thu, 8 Aug 2019 16:09:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
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
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
Message-ID: <201908081608.A4F6711@keescook>
References: <cover.1563904656.git.andreyknvl@google.com>
 <CAAeHK+yc0D_nd7nTRsY4=qcSx+eQR0VLut3uXMf4NEiE-VpeCw@mail.gmail.com>
 <20190724140212.qzvbcx5j2gi5lcoj@willie-the-truck>
 <CAAeHK+xXzdQHpVXL7f1T2Ef2P7GwFmDMSaBH4VG8fT3=c_OnjQ@mail.gmail.com>
 <20190724142059.GC21234@fuggles.cambridge.arm.com>
 <20190806171335.4dzjex5asoertaob@willie-the-truck>
 <CAAeHK+zF01mxU+PkEYLkoVu-ZZM6jNfL_OwMJKRwLr-sdU4Myg@mail.gmail.com>
 <201908081410.C16D2BD@keescook>
 <20190808153300.09d3eb80772515f0ea062833@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808153300.09d3eb80772515f0ea062833@linux-foundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 08, 2019 at 03:33:00PM -0700, Andrew Morton wrote:
> On Thu, 8 Aug 2019 14:12:19 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > > The ones that are left are the mm ones: 4, 5, 6, 7 and 8.
> > > 
> > > Andrew, could you take a look and give your Acked-by or pick them up directly?
> > 
> > Given the subsystem Acks, it seems like 3-10 and 12 could all just go
> > via Andrew? I hope he agrees. :)
> 
> I'll grab everything that has not yet appeared in linux-next.  If more
> of these patches appear in linux-next I'll drop those as well.
> 
> The review discussion against " [PATCH v19 02/15] arm64: Introduce
> prctl() options to control the tagged user addresses ABI" has petered
> out inconclusively.  prctl() vs arch_prctl().

I've always disliked arch_prctl() existing at all. Given that tagging is
likely to be a multi-architectural feature, it seems like the controls
should live in prctl() to me.

-- 
Kees Cook
