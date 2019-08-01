Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579337DBDE
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2019 14:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfHAMsu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Aug 2019 08:48:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35202 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbfHAMsu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Aug 2019 08:48:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so27852431pgr.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Aug 2019 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATAFhJly7oayn4QwVxAmF/cKx18eZXYIEq5cLXvpdzg=;
        b=mjC+j0aaEEkkMHnLNHs9TEJqIdScFWRlkAZG8TbiBl3AyUZ8l5nLaU29ZLHSb7WvwH
         X3OlQDdgsBZjncfM3ONy8Dqcuih1q2WnbLztoEOKMtf5vefqmMIHHwchJuo+ue+DCVka
         b9rui+0AvY5PeeX+qJY2jvBZQab/NzRkSsMupCgkTdlEDxE6K7Nu5zDKiMeGfnD3hicf
         2VPYUTHD9bJKAQWesHnbiPWY9rwW/eF7WIHmcnvL9DkrJEokfA1mnjx39I+4RQdt1WLM
         ieuyPRr8iw6XMHiEGmpinxm+wGAydMTsA6N4zI0Tg/WWtENcJ84NKdjINucR3C9EQWXN
         EQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATAFhJly7oayn4QwVxAmF/cKx18eZXYIEq5cLXvpdzg=;
        b=EAHTKD1g4oTp1NbdW/P1MzNaHjXsL3R1hJ/bCzEw89Vbnce93DzgXf+QytfmLMiJpm
         lSZOojHu8lXDj4heoaznPMgj/bDhdEGM9c+SGSLI1OzFuUOIrHPqg1KpGCLnBCFjNYKG
         v/oPb9/1pkFUxNejjjF/RarIbHUdHakLVspCrsQlU/+YZfZZuuxxFe59jekaPvC6PnRp
         oRozmsXLBvenj5oNyz2mTE95rSAWL24vxQcf9s2pIQ7FJGeabAR+3kxV+qpukJFfYUsI
         t/HZ7jq/5pbldrEMAHIjkL8T7VWMFRY5AXMbN2FWA6MX4lr/1e3tchTSrD/qxKkKBxyI
         K9+w==
X-Gm-Message-State: APjAAAVnH/UbK6n5p/dkOUA2G+IAZvFT34RB0ZL4pNI9INdwFxkE3rYB
        WiQ7t/2U8xTVTYE2ZzRe05mnAwH4VOlx7eQoTOzO/A==
X-Google-Smtp-Source: APXvYqyuYmWo+CP2FzNWYkHFT0ZLT3W5Y5OJQeMQdVh76HiNmdD4jPQ2fznL3kD7gDek9Cqsx8/zBcK9HOnHQgVpStE=
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr118476394pgq.130.1564663728917;
 Thu, 01 Aug 2019 05:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563904656.git.andreyknvl@google.com> <8c618cc9-ae68-9769-c5bb-67f1295abc4e@intel.com>
 <13b4cf53-3ecb-f7e7-b504-d77af15d77aa@arm.com>
In-Reply-To: <13b4cf53-3ecb-f7e7-b504-d77af15d77aa@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 1 Aug 2019 14:48:37 +0200
Message-ID: <CAAeHK+zTFqsLiB3Wf0bAi5A8ukQX5ZuvfUg4td-=r5UhBsUBOQ@mail.gmail.com>
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
To:     Kevin Brodsky <kevin.brodsky@arm.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 1, 2019 at 2:11 PM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>
> On 31/07/2019 17:50, Dave Hansen wrote:
> > On 7/23/19 10:58 AM, Andrey Konovalov wrote:
> >> The mmap and mremap (only new_addr) syscalls do not currently accept
> >> tagged addresses. Architectures may interpret the tag as a background
> >> colour for the corresponding vma.
> > What the heck is a "background colour"? :)
>
> Good point, this is some jargon that we started using for MTE, the idea being that
> the kernel could set a tag value (specified during mmap()) as "background colour" for
> anonymous pages allocated in that range.
>
> Anyway, this patch series is not about MTE. Andrey, for v20 (if any), I think it's
> best to drop this last sentence to avoid any confusion.

Sure, thanks!

>
> Kevin
