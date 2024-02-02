Return-Path: <linux-kselftest+bounces-4023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080008474B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B706528FDF9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65EF1482FE;
	Fri,  2 Feb 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD0wNsNj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA71420B9;
	Fri,  2 Feb 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891409; cv=none; b=ZT/a1GldwC+nz8KMO7IxQTphMePq0QCGNZqDr1dM8DRPkrWdb+3HOzuqrGF0Xcumyv1u4gAmmcu7rbc557y0LPM5Ds4orkoIoFkkOxdDcpYcj57rjMifk+d23z8AGCvKA9gcwNQlsF4awqe0r/EQ00rMuG18jEROXc3ROiUsOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891409; c=relaxed/simple;
	bh=BWx5zc/9MunoZpEToFg41sUYEu6SA2ONTzdVIp4DFg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZLYAKPuW8xfRgdXmFnDfSzyMoBlVUv7HNRcg8eGeIDC51EG8VtKLeljlu3ZUwfPHa3WdKW2ZdjimTsBXmL93Ory+f9dD2lo9+9iGPwcX+7N6JpUepRabL0V3VbqklHC/YFguTRbBDfW5vLoepj2tIZgLnRcKoNtrUYm4NC04H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD0wNsNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38DBC433F1;
	Fri,  2 Feb 2024 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891409;
	bh=BWx5zc/9MunoZpEToFg41sUYEu6SA2ONTzdVIp4DFg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nD0wNsNjQI1fhiecntkw5a6Fp7hmW0qtJo1/A0aveYZgSTrwHYLmWnGWv4zOeLtTK
	 60PWwFzI7mkJ62Phn1vBRCDQ5aXOdukBrtWjUX/yjlzD6/h+IoreEoHhpR3lMCK08M
	 Ds+ATzgYHo3pBJ7m1dTef9ZuBxRZNNAy75WdYfHVkyQ2ZHydivsNZZBMpq876kE6KI
	 YKYSk4ZCHcGjR0Jzh0mqhawazabqc6drmLCcUcuqbWGReBDSLhwO6gLlBQfaS+oQt5
	 tWBoUCu/mXaVJkQWGlPe1UxcwwvY30RVROsfMuipUMmbowBNPSZjGJ7Rafrt/6H7KA
	 AJNSq2ugYDc+w==
Date: Fri, 2 Feb 2024 10:30:06 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <20240202163006.GA209874-robh@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org>
 <20240130004508.1700335-2-sboyd@kernel.org>
 <20240131205405.GA2249327-robh@kernel.org>
 <efe6a7886c3491cc9c225a903efa2b1e.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe6a7886c3491cc9c225a903efa2b1e.sboyd@kernel.org>

On Wed, Jan 31, 2024 at 02:59:53PM -0800, Stephen Boyd wrote:
> Quoting Rob Herring (2024-01-31 12:54:05)
> > On Mon, Jan 29, 2024 at 04:45:00PM -0800, Stephen Boyd wrote:
> > > Call this function unconditionally so that we can populate an empty DTB
> > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > Override 'initial_boot_params' to NULL when ACPI is in use but the
> > > bootloader has loaded a DTB so that we don't allow both ACPI and DT to
> > > be used during boot. If there isn't a valid initial_boot_params dtb then
> > > unflatten_device_tree() returns early so this is fine.
> > > 
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: <linux-arm-kernel@lists.infradead.org>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> > >  arch/arm64/kernel/setup.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > index 417a8a86b2db..ffb1942724ae 100644
> > > --- a/arch/arm64/kernel/setup.c
> > > +++ b/arch/arm64/kernel/setup.c
> > > @@ -351,8 +351,11 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> > >       /* Parse the ACPI tables for possible boot-time configuration */
> > >       acpi_boot_table_init();
> > >  
> > > -     if (acpi_disabled)
> > > -             unflatten_device_tree();
> > > +     /* Don't use the FDT from boot if ACPI is in use */
> > > +     if (!acpi_disabled)
> > > +             initial_boot_params = NULL;
> > 
> > I still think this is a problem for kexec. See 
> > of_kexec_alloc_and_setup_fdt(). You see it uses initial_boot_params. At 
> > first glance it looks like it would just write out everything we need. 
> > But for UEFI boot, I think we need all the chosen properties like 
> > linux,uefi-mmap-start preserved from the current boot for the next 
> > kernel we kexec.
> 
> Ok, got it.
> 
> > 
> > I think you'll have to check acpi_disabled in unflatten_device_tree() 
> > and unflatten the empty tree leaving initial_boot_params alone. That 
> > means our FDT and unflattened tree will be different DTs, but I think 
> > that's fine.
> 
> It's sort of scary given that 'initial_boot_params' is an exported
> global. Maybe that should be hidden away and accessed with a function
> instead so that this mismatch doesn't break something later on?

What you see now is after I did a pass of minimizing the number of 
users.

BTW, I've now got another use for unconditionally calling 
unflatten_device_tree() with this[1].

Rob

[1] https://lore.kernel.org/all/20240201194653.GA1328565-robh@kernel.org/

