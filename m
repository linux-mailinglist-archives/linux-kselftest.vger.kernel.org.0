Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B654F39ABE
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 06:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfFHEFF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jun 2019 00:05:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37398 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFHEFF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jun 2019 00:05:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id 20so2155022pgr.4
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2019 21:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7MRDr4KJ8a0CcLFRNA6a6rBwJKdO40+h9uyHwhos1XY=;
        b=FihBxmn2dVJ6Rw2WItUxtjZpswcNWCrx4UusJNMmjDUeSXGlPeke41oTHXObrS9v9s
         auz9bPPxx2drUDHwQFTWyjmSfE251zoGthyYFhJV5WSoJ0SYpqwBy7GNBhwklPOXO6Qg
         gWZEmprLR6lDNUGcv9V07ySSkX/PEr3KR97+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7MRDr4KJ8a0CcLFRNA6a6rBwJKdO40+h9uyHwhos1XY=;
        b=jIVuI9b2O1R9hOgkPtptADEGpwgT86/WGZLyydTIr4fgjOYf/tbqMkEwwd2QGAFeHS
         4jyAgxDb6wBZNOybEZ638NQMEeIXhlZfMsa4yXe2psHcMvFIaZeiRTP2TXi+/fRMgOCC
         lPeMaK7IoQhQ7fu6C6Vb0Ch43Rj1xiy8YxpauOu42Dlf+NwUqJpVn7n6oqwMkJWB0en5
         ASFVIc/sFxDTy59Py2K0yNZXeHHn5qRpnO1nqbVf8n7JemFwY+0ghJpNR7bZ9vH+vevh
         EBwaFGx/+VTZ8iPj9SpVmg/JTTwukXwtOmIO4/Uz+EKpgdamoqi8YunNVhZQq1KlwVRz
         eh8Q==
X-Gm-Message-State: APjAAAXxmdLS5yqpRiEP7AfXuTkqqsL0Pob3ag0DPr0Rv4agvRlw4OuV
        8EN5fzXGGwpLKLeZwuSroBCNZQ==
X-Google-Smtp-Source: APXvYqwInYsY/wUHZ9P1C1XrBfyqppKEaGOwIlzHhH7Qkl6+K82Iixjx8HiJ+/il/stbMYBMbkFxfA==
X-Received: by 2002:a63:4045:: with SMTP id n66mr5882121pga.386.1559966704443;
        Fri, 07 Jun 2019 21:05:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z14sm3301959pgs.79.2019.06.07.21.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 21:05:03 -0700 (PDT)
Date:   Fri, 7 Jun 2019 21:05:02 -0700
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v16 14/16] tee, arm64: untag user pointers in
 tee_shm_register
Message-ID: <201906072104.B6A89D8CB@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <dc3f3092abbc0d48e51b2e2a2ca8f4c4f69fa0f4.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3f3092abbc0d48e51b2e2a2ca8f4c4f69fa0f4.1559580831.git.andreyknvl@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:16PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> tee_shm_register()->optee_shm_unregister()->check_mem_type() uses provided
> user pointers for vma lookups (via __check_mem_type()), which can only by
> done with untagged pointers.
> 
> Untag user pointers in this function.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

"tee: shm: untag user pointers in tee_shm_register"

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/tee/tee_shm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 49fd7312e2aa..96945f4cefb8 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -263,6 +263,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>  	shm->teedev = teedev;
>  	shm->ctx = ctx;
>  	shm->id = -1;
> +	addr = untagged_addr(addr);
>  	start = rounddown(addr, PAGE_SIZE);
>  	shm->offset = addr - start;
>  	shm->size = length;
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Kees Cook
