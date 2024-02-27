Return-Path: <linux-kselftest+bounces-5494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EBA869DEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 18:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39808B3085F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716C14E1A0;
	Tue, 27 Feb 2024 17:35:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A775F4C63D;
	Tue, 27 Feb 2024 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055308; cv=none; b=DdiVwXecPb1BEJKXSCRR5Tey4wsZdmXEy1ImsLELcnclY5aLwLe4kopKXO0lxYGVvXzgylRLj6KSnaeM5fayY6xG0cAWar1XBocuxEA1CPPA9Sy8B0Y1s+XlxmyQdMmwYu7FG1qSFoN0tzcYWOYwr+xIN4bKhWZirGrMcYN5e0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055308; c=relaxed/simple;
	bh=hQ2ryKGeq/r38RlaFN/f0EoXXlr9M7MA/Gh4pDclvGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPxDP0Q/IDEwbooYMwHJdaAAsf9oC6PEGWQnIIoD0hBHzPmZCyMpPjaVz62PQPjeCJP9aal/6QVlAXB2OqmD7HqzkKCux080q9tPihuhggZnQ2MQoya+ZrFAgpDro2yNl+W6DIx7Y4526Mpoz97iFCA1XA8/SCMcQ7C3+7g8dvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6984ADA7;
	Tue, 27 Feb 2024 09:35:43 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFCFE3F73F;
	Tue, 27 Feb 2024 09:35:02 -0800 (PST)
Date: Tue, 27 Feb 2024 17:34:58 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 5/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <Zd4dQpHO7em1ji67@FVFF77S0Q05N.cambridge.arm.com>
References: <20240217010557.2381548-1-sboyd@kernel.org>
 <20240217010557.2381548-6-sboyd@kernel.org>
 <20240223000317.GA3835346-robh@kernel.org>
 <20240223102345.GA10274@willie-the-truck>
 <CAL_JsqJSeSHeWV3YJE9n2NuY+s_iE6f7N5C_oguEJn7jTZ20xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJSeSHeWV3YJE9n2NuY+s_iE6f7N5C_oguEJn7jTZ20xA@mail.gmail.com>

On Fri, Feb 23, 2024 at 11:17:02AM -0700, Rob Herring wrote:
> On Fri, Feb 23, 2024 at 3:23 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Feb 22, 2024 at 05:03:17PM -0700, Rob Herring wrote:
> > > On Fri, Feb 16, 2024 at 05:05:54PM -0800, Stephen Boyd wrote:
> > > > Call this function unconditionally so that we can populate an empty DTB
> > > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > > When ACPI is in use, unflatten_device_tree() ignores the
> > > > 'initial_boot_params' pointer so the live DT on those systems won't be
> > > > whatever that's pointing to. Similarly, when kexec copies the DT data
> > > > the previous kernel to the new one on ACPI systems,
> > > > of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
> > > > one) and copy the 'initial_boot_params' data.
> > > >
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: <linux-arm-kernel@lists.infradead.org>
> > > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > > ---
> > > >  arch/arm64/kernel/setup.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > Catalin, Will, Can I get an ack on this so I can take the series via the
> > > DT tree.
> >
> > Mark had strong pretty strong objections to this in version one:
> 
> Yes, I had concerns with it as well.
> 
> > https://lore.kernel.org/all/ZaZtbU9hre3YhZam@FVFF77S0Q05N/
> >
> > and this patch looks the same now as it did then. Did something else
> > change?
> 
> Yes, that version unflattened the bootloader passed DT. Now within
> unflatten_devicetree(), the bootloader DT is ignored if ACPI is
> enabled and we unflatten an empty tree. That will prevent the kernel
> getting 2 h/w descriptions if/when a platform does such a thing. Also,
> kexec still uses the bootloader provided DT as before.

That avoids the main instance of my concern, and means that this'll boot
without issue, but IIUC this opens the door to dynamically instantiating DT
devices atop an ACPI base system, which I think in general is something that's
liable to cause more problems than it solves.

I understand that's desireable for the selftests, though I still don't believe
it's strictly necessary -- there are plenty of other things that only work if
the kernel is booted in a specific configuration.

Putting the selftests aside, why do we need to do this? Is there any other
reason to enable this?

Mark.

