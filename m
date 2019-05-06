Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F08B1549D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 21:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfEFTuX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 15:50:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41730 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEFTuX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 15:50:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id g190so2982534qkf.8
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ESsJ96JGC0CvnjgihpL/0kogE+VQksbbiyHqcPsgGyM=;
        b=mAg8m7rSPAxM5D+1qNjO71dhsXUrQSGF8zaXxmrvN1W1e7B7fEhL/nFNC4QmlTH5S/
         9FjLthJrMSnJTSlBNmAzOuj+WEEEHBw1j3jchmVO404WkT8GTT4n4WekZCWvQcvu4KOF
         mx0V5cfxdymPVb2Ruxoza7w5KItB51NAJ5xivBL7H4fj5rRig8CXPXI75f55CKvkZyYC
         Gs093sJb6bHKcKo1jSkGyp2Pk8c68+e+QijlfKiUVNZuBsCjguF+Uc/8jtTaC+sffP6g
         22gO2vicgInFZL3gRZwFvB6M65AQIPZr/G+9s6iQjRuVRTS6fQK5LrCRIMT4SjvjNieX
         MViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ESsJ96JGC0CvnjgihpL/0kogE+VQksbbiyHqcPsgGyM=;
        b=KoJGrBFEZQbYzCasryIMecAZdG8UuSOohZhuX46kxRNkTXmRWZ7sseArHSbiLvZ3ri
         osWMu+GpddYXn46ZQXVQJkhEA/VJLSl7hKU2fht03vTwrymFDuTAMxcunJfHbEEfnevR
         07zPdhi8q5SRhXdXYna4QearKPBLyott61pYniKBd1g3+3WKcN6aUBD09dgECpYaTphG
         Lc0XmX20ltzsSS4MkRBZ6HFnb2jETfX53rNtyj8V+uyPLiJlPjGrVeebZLFcnCO5O2UF
         0iHfyH2IW793mgXq7ovb6RbeoMFmfNycR0RilPvNNz91S10HgsyJMWIe7aE2IMnIFcGu
         CVqg==
X-Gm-Message-State: APjAAAXMdYJSFSevUV63Le2Cd9EKIgtzouT7Mbw+0b++/bNdQO6BSCE1
        l9+IITGvrJhu3g7mcjw9Bclqyw==
X-Google-Smtp-Source: APXvYqweK3T+QR6CpnWc0KpWvE878/YztoCohPUsZDawCWkz4P9i6ckWrJvxSZLqhWTPckszjgD1bg==
X-Received: by 2002:a05:620a:16b4:: with SMTP id s20mr10803976qkj.34.1557172222493;
        Mon, 06 May 2019 12:50:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id o44sm9303175qto.36.2019.05.06.12.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 12:50:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNjcy-0007kq-Cs; Mon, 06 May 2019 16:50:20 -0300
Date:   Mon, 6 May 2019 16:50:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
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
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v15 13/17] IB, arm64: untag user pointers in
 ib_uverbs_(re)reg_mr()
Message-ID: <20190506195020.GD6201@ziepe.ca>
References: <cover.1557160186.git.andreyknvl@google.com>
 <66d044ab9445dcf36a96205a109458ac23f38b73.1557160186.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d044ab9445dcf36a96205a109458ac23f38b73.1557160186.git.andreyknvl@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 06, 2019 at 06:30:59PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> ib_uverbs_(re)reg_mr() use provided user pointers for vma lookups (through
> e.g. mlx4_get_umem_mr()), which can only by done with untagged pointers.
> 
> Untag user pointers in these functions.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 4 ++++
>  1 file changed, 4 insertions(+)

I think this is OK.. We should really get it tested though.. Leon?

Jason
