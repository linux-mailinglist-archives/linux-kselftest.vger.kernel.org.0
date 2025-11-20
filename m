Return-Path: <linux-kselftest+bounces-46140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D8C76174
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 20:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32BF9356B83
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 19:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D95288514;
	Thu, 20 Nov 2025 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IubsUJVs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241D27A477
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667211; cv=none; b=QTLx3Rrp35mEg9a7tiRd2lQdrP0tAntKYp5fPzQuOXxVVV2Qyw0rsNo3e4jaEA3evsdGtwYIptRZqDHQeSh9psEzRJR/ACxhRep79+JoPAkuY59ErUpwp+tL7FG1r78uM/lsDE4Yn14nSvrWm9crd6fjXJubOiZNruEFXNNYIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667211; c=relaxed/simple;
	bh=hzYdS2RbjjdpNPkRll9+qBCneRKVB6myqbcq8DhMp4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYy2CK4PSbXQ8My3SNzcVdDDcjfEkeIOx4NoDPmRgxkXJ48X+FOIoYOo+A/5NVLHr86WdADVh4ko3ClnF2gHpmP0YG2SYZKKloG/k4dkn51aHowsnTt2+ubvgfxM/k5UwzKaKkaATYhl8jpsQVUL0dBY1pJ61dMkl8GtbwWdlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IubsUJVs; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2ed01ba15so105345785a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763667208; x=1764272008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJbOTvKtBkMETxUQbFFc6nVU6t/7S/ESP6xTtKSK0tM=;
        b=IubsUJVsozjeY2Y4jN50q/fx1c4JbqqwWtVNLozAKP6oHvzL7bYZiqv2sOsvHXv92j
         xtbvwVUHcJfYaC5ydUgAxU3ZBgBtCvMnHYWjgA4Bt+ez638hPh0auuIVTV5QnL3cq9Vi
         gdq/h4LzTHAnaCcPPBZ7miB+PdphgmZKyq5aoZhv97qooz2FwNoRdcuqdqtZnAOckH9d
         PF+UBh0W8hInqjFod7jv31MhqJsDM/HGF2OZ+bga9IX7bW3tN+ZEw3Vqk+lIeSw7hdRf
         0j6il7WIzRiDXfnptOfoOAhN0g5V6mb5BRXbr9U4B5uga4awi7QuS1KR7+8ON1rnBkpv
         QbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763667208; x=1764272008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJbOTvKtBkMETxUQbFFc6nVU6t/7S/ESP6xTtKSK0tM=;
        b=OPC57g6Ruv7bDfOxaFzd1+xrFv0SktFAn6n77/17eJId4YP1HiEgttPM/5MXDZYgd2
         3s42/hgvwim4S1yaicrpX62ANeqaF/6GRjUhhqjkbkJCknQ7zMSkI40cHQ4aizKGiTS8
         mElzqQv7hLmOIlpkfu2bXUj0yowqIUMLq92m3qFN729Ku3dluqftgmRY0OlP3pbllUgC
         nz3TGtaV8gjDDZIH0GuAKi20dPVCxVFEyUE+A2baD3JQ1ycL7TnntScc+W9q1OZrNWRL
         Jp686EbEwlbae4ItUGtzXzh85+OH7rpeoZM10Ii4Wlb33YDlGKnvbUYwzAkcAvaRaytR
         J4kw==
X-Forwarded-Encrypted: i=1; AJvYcCU9D1uLHs2sCEICW08ec9rTgbCCuiDiLiFYsdmJ9hsVMBwl6sSwhSzoXjUrlNaLaD6ed/QLwBv+ZIRlOjye73g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJc5u0+sUEsQKoId2TOH+sV6K0bpnzu+XwyPXq7gbhsh85CPo
	1Xhp1Z8GzZd6TL06pDYRg5MCTgKyyJ168hr6vchWkmabkvwvvNaiX0ZkqAGzGARfjsk=
X-Gm-Gg: ASbGnctirW5PoyoZvNCipfft/sBHpUK+SHw5T3UldGRf7avNyyPU4K2JEOMk6+5bLT7
	15L8Uylpmhoo5/tZlbvSVn7vMF6hq91PQ5mJ/pfs4mME+sng1pJINzJ4dY9sr6P1GToslu60bJb
	v0pO0ZLBMl1e9tEqtaRE2+WDaFRq1hYpjalIzDsBqlszstY1PyfX4z8XIEeaYgP2sIXkKjbPMl1
	lzwoLB7Ej4JyJiNnt/Sb7WmbhLv5cCPYbwzwA67tG5apCRfqPyI2xHBWJBA+7OH+U0VMdkt67T/
	bVAADrKEknDPRRf7YE/EFMIWYcLj0Yumi8ougwdgH5YgKTu1EPEltNOYMOt0CtUUDZZNyvTebyY
	2al5Ynjz/pdU9GRAOdfzsUfv0+o844U9+/SVCi2iUXd0Gzi0a/2+qA+MLmjEywEubhOsGUTamN3
	P3TjG+ifjrjmyJk7DwO62ryDl9ylvTBpzdAG0VDJAnH2ZMVG+hDOlXkk6p
X-Google-Smtp-Source: AGHT+IGpaR+w3wp4votZhuUNdazIQPQ2JUOa4gTel/dGSMeoCPvMZg4kNVugdag6pW8h3TthvdJcbg==
X-Received: by 2002:a05:620a:7103:b0:8a2:45ba:1b5e with SMTP id af79cd13be357-8b33860b8eamr108942585a.28.1763667208042;
        Thu, 20 Nov 2025 11:33:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3294321dcsm208458485a.13.2025.11.20.11.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:33:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMAPG-000000015S2-37Ge;
	Thu, 20 Nov 2025 15:33:26 -0400
Date: Thu, 20 Nov 2025 15:33:26 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	KUnit Development <kunit-dev@googlegroups.com>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] genpt: Make GENERIC_PT invisible
Message-ID: <20251120193326.GB233636@ziepe.ca>
References: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>
 <20251120164933.GV17968@ziepe.ca>
 <20251120170744.GA236839@ziepe.ca>
 <CAMuHMdVsyu_vnYiV7EcChd3a6czUCh4Gis3hL8uDVmbDcGo06w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVsyu_vnYiV7EcChd3a6czUCh4Gis3hL8uDVmbDcGo06w@mail.gmail.com>

On Thu, Nov 20, 2025 at 07:31:10PM +0100, Geert Uytterhoeven wrote:
> Hi Jason,
> 
> CC kunit
> 
> On Thu, 20 Nov 2025 at 18:07, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Thu, Nov 20, 2025 at 12:49:33PM -0400, Jason Gunthorpe wrote:
> > > On Wed, Nov 12, 2025 at 03:08:05PM +0100, Geert Uytterhoeven wrote:
> > > > There is no point in asking the user about the Generic Radix Page
> > > > Table API:
> > > >   - All IOMMU drivers that use this API already select GENERIC_PT when
> > > >     needed,
> > > >   - Most users probably do not know what to answer anyway.
> > > >
> > > > Fixes: 7c5b184db7145fd4 ("genpt: Generic Page Table base API")
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > >  drivers/iommu/generic_pt/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >
> > Actually, it doesn't work :\
> >
> > $ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> > [13:01:26] Configuring KUnit Kernel ...
> > [13:01:26] Building KUnit Kernel ...
> > Populating config with:
> > $ make ARCH=x86_64 O=build_kunit_x86_64 olddefconfig
> > Building with:
> > $ make all compile_commands.json scripts_gdb ARCH=x86_64 O=build_kunit_x86_64 --jobs=20
> > ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> > This is probably due to unsatisfied dependencies.
> > Missing: CONFIG_IOMMUFD_TEST=y, CONFIG_DEBUG_GENERIC_PT=y, CONFIG_IOMMU_PT_VTDSS=y, CONFIG_IOMMU_PT=y, CONFIG_IOMMU_PT_AMDV1=y, CONFIG_IOMMU_PT_X86_64=y, CONFIG_GENERIC_PT=y, CONFIG_IOMMU_PT_KUNIT_TEST=y
> >
> > Can you add this hunk and send a v2?
> >
> > --- a/drivers/iommu/generic_pt/.kunitconfig
> > +++ b/drivers/iommu/generic_pt/.kunitconfig
> > @@ -1,4 +1,5 @@
> >  CONFIG_KUNIT=y
> > +CONFIG_COMPILE_TEST=y
> >  CONFIG_GENERIC_PT=y
> >  CONFIG_DEBUG_GENERIC_PT=y
> >  CONFIG_IOMMU_PT=y
> 
> Do you really want to enable CONFIG_COMPILE_TEST in a .kunitconfig?

IDK, why not?

> Hm, that .kunitconfig already enables IOMMUFD_TEST, which is
> documented to be dangerous (why?)

It builds in a kernel module with a uapi that is kind of unsafe.

Though, hmm, maybe that is some weird a leftover I don't recall that
this kunit needed IOMMUFD_TEST stanza at all..

>  and already enabled by allyesconfig (except on GENERIC_ATOMIC64
> architectures).  

I guess allyesconfig would do that.

> IOMMUFD_TEST cannot select GENERIC_PT, as that would lead to a
> recursive dependency (and I am not a huge fan of test code
> auto-enabling extra attack surfaces^W^W functionality).

Yes

> Or perhaps:
> 
> -       bool "Generic Radix Page Table"
> +       bool "Generic Radix Page Table" if COMPILE_TEST || KUNIT
> 
> ?

It would work, that does seem like a better choice if someone wants to
make the kunit run in a normal disto kernel.

Thanks,
Jason

