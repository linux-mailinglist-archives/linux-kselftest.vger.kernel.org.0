Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B1739AA7
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 06:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbfFHEA2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jun 2019 00:00:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45252 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfFHEA2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jun 2019 00:00:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so1139851plb.12
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2019 21:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJBSSsNH8TcUO3Ycp4J72yQtEEm/T/jL9xlaGf6pvZI=;
        b=SIGHIuBbHjdFD2NYvbt1juZyNlfYo8T13G3oRQwScPFyvz27E5QmOWxjQJHoK99WBn
         Ze60epVcGs+lOMqYkRKqCgC9UKlerLVaaZ1FhvQY+1i8DraNj5oIlnKwiTKses761SQn
         gTwBZBGZ3BV+37p5XRC1XuqiURHbiOTUskj5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJBSSsNH8TcUO3Ycp4J72yQtEEm/T/jL9xlaGf6pvZI=;
        b=TBG8yNFy77EQyOpxcYSk8KWkDO+NGuZr7JeS6ERwSr4UNQXAUy/s9PCywN2Gcvni5Q
         Eu+sHkfoYmM+9YEjBRr/fLp/ARrL6IeNfeYXMJ+xioxLMjSf23jlYWEXCbGd86i4egO8
         2eDQ2vUxDpVCu1Cp9G9HTs67vq4c8OLrXbil4xUJCjKUlC9L/y259itjUdpisIz3C2xV
         2IoXkITx166eKBIBhwhAFYFfOLQ6LJELZLJTPVuckEDMbZdnFUmUBNsOwtFLcWmMP3JQ
         Yraq/tK/jhHI60+R7m+9Sa9Xf94o0okz0gcUl8rPjwSGWWGugdTXx2hvnm+cMiLBVmAY
         fAcg==
X-Gm-Message-State: APjAAAXfu4g66+Lvx/FW3Oq+NcG10LtW5qhOpUqu0zc5pp2f4D+5Xm1I
        J3Pm6IF7S/3L/2Mxp0JL1fP7Rw==
X-Google-Smtp-Source: APXvYqzHeK0TqpcqthfQS0PvnOaTM79D0qX0jOvsUb1vmxMb45KBYDAyFtX8G3vNYgX7ILuQ8oms2A==
X-Received: by 2002:a17:902:a516:: with SMTP id s22mr20509311plq.178.1559966427983;
        Fri, 07 Jun 2019 21:00:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q1sm6873405pfb.156.2019.06.07.21.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 21:00:27 -0700 (PDT)
Date:   Fri, 7 Jun 2019 21:00:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v16 07/16] mm, arm64: untag user pointers in
 get_vaddr_frames
Message-ID: <201906072059.69C8284A0E@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <da1d0e0f6d69c15a12987379e372182f416cbc02.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1d0e0f6d69c15a12987379e372182f416cbc02.1559580831.git.andreyknvl@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:09PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> get_vaddr_frames uses provided user pointers for vma lookups, which can
> only by done with untagged pointers. Instead of locating and changing
> all callers of this function, perform untagging in it.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  mm/frame_vector.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/frame_vector.c b/mm/frame_vector.c
> index c64dca6e27c2..c431ca81dad5 100644
> --- a/mm/frame_vector.c
> +++ b/mm/frame_vector.c
> @@ -46,6 +46,8 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>  	if (WARN_ON_ONCE(nr_frames > vec->nr_allocated))
>  		nr_frames = vec->nr_allocated;
>  
> +	start = untagged_addr(start);
> +
>  	down_read(&mm->mmap_sem);
>  	locked = 1;
>  	vma = find_vma_intersection(mm, start, start + 1);
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Kees Cook
