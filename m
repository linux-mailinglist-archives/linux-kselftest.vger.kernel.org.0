Return-Path: <linux-kselftest+bounces-46137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C450AC75EB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 19:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 663124E02AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593A3596E7;
	Thu, 20 Nov 2025 18:31:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B51828A1F1
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663487; cv=none; b=dWuSvMbw/UIOOZaW1peSVzuzjoR2fjIXg4oKs6rLUyViAKhzsiVtx+OO0QE2IAiJD+0wJXqwg/gT11+v2Qq4jj9nxj/R+vIa0RSbJ1SzTNyAac5B7/4kKE/OmtEYjureEC5RDviga1tgEIo85h7/dpoNC1EDBF751Fuw3FKECjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663487; c=relaxed/simple;
	bh=RJWdSMJFkKKpmT8nR8qTiYD6gXE6h7WjUQL4kfxvCDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3KcyOmkUgbVi4/ELxQTWcko6Oa0GZSl7hnjSyhHR6OROZlXc99OhOouIu3uLUZVwsD/qwIbF7Jev65QXdqDxfxUXJCxLDx27qohAS5GtHIF7LhVQvGAYEHg5jRNr9KL8bAXbEH4rK19S36sMOk4qdfCWpcjy4/Puai8Dk11KCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-559a4d6b511so163585e0c.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 10:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763663484; x=1764268284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Pbbkcq4vJY4dhlOt9k4VzFX7B2ssH1NKcQYU3Egds=;
        b=dec/DXzZUdNtE2yfi0mnbtlPfE4Ospy6fQCZpxAXEDOPAAnjH5I9Rx7kjzxW/9k0yM
         WnC/WVjV58+IvVsBNFed9YLp8quQZvPKpFTpNSeBB89n1QbxCahjY0mTBHfNXch2eQc8
         tDEHswttxrSfE8DU4gqlVUQQ/V+70O9+jnykyDfUV8+UcM5O7ZRZprGWSQPa7RKpb4E2
         CYymGGJfS5rTOw8Q9MHpnuizZH4fsPZ3I234eQY9WIPxxCKiqOxOw18dHCWdX5bwvnnM
         TiUvFbFoSAj7Pp0oFBuDVYPgk+nsrlGYqJtHL+qwK/4uMTZEkTAQYggv9xyE5G2l9RmQ
         KbDw==
X-Forwarded-Encrypted: i=1; AJvYcCVJZS/ClZApeQkcQS1pDtA64eGQPCbii8CFJwie0RzRBeq5CecHVhr5D1xN7SPaJqBWke+6DzCyTtsPBSVOhvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOjcRGekvPwDgS1Ti+6SDLpI86aPoD6A8rPIJJVcIDjM9B3Y6S
	AzCoNDPTKOPoLVoeR44rDRhFYg3ZSEyqGg+wIN8d5XL7VX5sg/7Oh2LFwr19GB6i
X-Gm-Gg: ASbGncsGGLOkLZj5hBa0HeXm+W7rEHdZcTmuoKc9XCOirFB5/PFVrx6tBuirMABVjeT
	yzaPuPPBgi+rds+aCiM/vrj8M8lm9h33MaiRFTluolSsfRC/QLcsb9IKL0FvmfWz+SNmn6igQU7
	x2xvI8+VYjdzxB4lJvgkKXrFLpJXfx6HupDTb+a6HtXkjurjmePAWXezOOadbhnCdyfXZDm+VgR
	VhPbzlYlxToUJkl9lD7U3PIosr3sOj/vRQBFLthghISwkDREslJiY7HcY53BZG2dZ5JInXFXam3
	aOazoiWrX614SFOBiu3YcC0gNtt5Vg5Y60JFm0BILQxoiN56aMQ9Y5tLxmSC8ebzxVqVepr3+Jd
	F4WIxYjb1jtQKMIQmC79g3kIMYb6GUzRKjrEoz+i4sp1Nn2GpXmiIMeqXhjVG3gmvhxpL0/bo9u
	x4MpVU10i6CpCJ9OwYK6wase5JO9+1q6ZIcng7YuipWu+EA8BOwRI3
X-Google-Smtp-Source: AGHT+IGbEzi2B/fdmEUDKCIROhYT2JP0fyCOnD7k3UKC0LeDmcUiyVBCvzRNp2FpMcYdye5eGVBcdw==
X-Received: by 2002:a05:6122:2202:b0:55b:305b:4e46 with SMTP id 71dfb90a1353d-55b8b7e75fcmr252525e0c.18.1763663483439;
        Thu, 20 Nov 2025 10:31:23 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7d2356sm1385495e0c.22.2025.11.20.10.31.22
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 10:31:22 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dfcfbcbcc0so440776137.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 10:31:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFh4lSIQ+9Fy1thzLBaHhLqoH7Epq0GNblplO/kGsbNp9g0d7BzNHuQQukaCxqijjWIOoD7b5hUEL117ulJYw=@vger.kernel.org
X-Received: by 2002:a05:6102:5705:b0:5db:da81:2541 with SMTP id
 ada2fe7eead31-5e1d851b50cmr75313137.12.1763663481782; Thu, 20 Nov 2025
 10:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>
 <20251120164933.GV17968@ziepe.ca> <20251120170744.GA236839@ziepe.ca>
In-Reply-To: <20251120170744.GA236839@ziepe.ca>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Nov 2025 19:31:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVsyu_vnYiV7EcChd3a6czUCh4Gis3hL8uDVmbDcGo06w@mail.gmail.com>
X-Gm-Features: AWmQ_bnRxfo1Tg8SkmQbZPhLq64ESeWKE0re-uwHoKs8zI4GSfe8l_ubdewUL4Q
Message-ID: <CAMuHMdVsyu_vnYiV7EcChd3a6czUCh4Gis3hL8uDVmbDcGo06w@mail.gmail.com>
Subject: Re: [PATCH] genpt: Make GENERIC_PT invisible
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	KUnit Development <kunit-dev@googlegroups.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

CC kunit

On Thu, 20 Nov 2025 at 18:07, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Thu, Nov 20, 2025 at 12:49:33PM -0400, Jason Gunthorpe wrote:
> > On Wed, Nov 12, 2025 at 03:08:05PM +0100, Geert Uytterhoeven wrote:
> > > There is no point in asking the user about the Generic Radix Page
> > > Table API:
> > >   - All IOMMU drivers that use this API already select GENERIC_PT when
> > >     needed,
> > >   - Most users probably do not know what to answer anyway.
> > >
> > > Fixes: 7c5b184db7145fd4 ("genpt: Generic Page Table base API")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/iommu/generic_pt/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Actually, it doesn't work :\
>
> $ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> [13:01:26] Configuring KUnit Kernel ...
> [13:01:26] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=x86_64 O=build_kunit_x86_64 olddefconfig
> Building with:
> $ make all compile_commands.json scripts_gdb ARCH=x86_64 O=build_kunit_x86_64 --jobs=20
> ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> This is probably due to unsatisfied dependencies.
> Missing: CONFIG_IOMMUFD_TEST=y, CONFIG_DEBUG_GENERIC_PT=y, CONFIG_IOMMU_PT_VTDSS=y, CONFIG_IOMMU_PT=y, CONFIG_IOMMU_PT_AMDV1=y, CONFIG_IOMMU_PT_X86_64=y, CONFIG_GENERIC_PT=y, CONFIG_IOMMU_PT_KUNIT_TEST=y
>
> Can you add this hunk and send a v2?
>
> --- a/drivers/iommu/generic_pt/.kunitconfig
> +++ b/drivers/iommu/generic_pt/.kunitconfig
> @@ -1,4 +1,5 @@
>  CONFIG_KUNIT=y
> +CONFIG_COMPILE_TEST=y
>  CONFIG_GENERIC_PT=y
>  CONFIG_DEBUG_GENERIC_PT=y
>  CONFIG_IOMMU_PT=y

Do you really want to enable CONFIG_COMPILE_TEST in a .kunitconfig?

Hm, that .kunitconfig already enables IOMMUFD_TEST, which is
documented to be dangerous (why?), and already enabled by allyesconfig
(except on GENERIC_ATOMIC64 architectures).
IOMMUFD_TEST cannot select GENERIC_PT, as that would lead to
a recursive dependency (and I am not a huge fan of test code auto-enabling
extra attack surfaces^W^W functionality).

Or perhaps:

-       bool "Generic Radix Page Table"
+       bool "Generic Radix Page Table" if COMPILE_TEST || KUNIT

?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

