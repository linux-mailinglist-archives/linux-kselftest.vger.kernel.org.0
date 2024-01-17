Return-Path: <linux-kselftest+bounces-3168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78414830C2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 18:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1257E1F21F81
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F23822EE0;
	Wed, 17 Jan 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBevjfMZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8222636;
	Wed, 17 Jan 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705513277; cv=none; b=i9v6W4pFuy9GGoR7wsfonwnyQDTBhiezlnTvfpUEk1gkbDCVnqslPcf9j1zd/dSAfVhxDfjRQyLzjkdKUgrvJ9bnK8ig39UJwEVpTtiaaaXQSjSnb/mnd7HpMJyKX8ZO5jNqoQZbyoQSwynBqEAuUomNpoftNsekhVISY8cVLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705513277; c=relaxed/simple;
	bh=oMyiDD+Iv9PCZrZI/1gZAt5oqiBycCP8w9pHbV1lWu4=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=PMS3JKNnFYHfb2sZqv6mqdYH8/AjDA9cjUJjUW7HdDjffxC1fXGT+ZPmwsyntJulvkezwz32rs+FEJyrWn9ZuG7Ot11Vq542odLt904cFRtQtoUSHTtndV4XpHrY4TNrQhOtVv7X67Mjq5/rzXREYHn7ZlwNeD6OZ2KvJxFvEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBevjfMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42424C433F1;
	Wed, 17 Jan 2024 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705513276;
	bh=oMyiDD+Iv9PCZrZI/1gZAt5oqiBycCP8w9pHbV1lWu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBevjfMZJTsk0Z3N2eXC9xsiFZfpBm+jywM0ZqHd+H8ixc7g1WKJjwuH6xtzFfBD2
	 J/2kI0FLLvGFJZN4w8D6tmXCEt4L5wRmZio7hi+UHK1KJfw/mRDpDl7HjqPpnf4RU8
	 rqMCyz93kzjJHrIZ6uBDtVnNNvb5d0THqQ/RUACMVD+C0WgEmm8rYEyfKMeGoVowR8
	 p1/w87TVGdRe5AEc1BSDEQn6sv5oXKeQeodwLxz0UzRKhdNjjCtXYfuLpL1qjXbRLk
	 xD1bt4pTdG61tolFQUqZjEDIqew5YSFbsSGrjl2HSQMbWLPWwKsm4WGRqvZoskDOwi
	 /d5zpsGQIe1hQ==
Date: Wed, 17 Jan 2024 11:41:14 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] of: Create of_root if no dtb provided by firmware
Message-ID: <20240117174114.GA2779523-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-5-sboyd@kernel.org>
 <20240115203230.GA1439771-robh@kernel.org>
 <cdaadf62222a705cda198dd96dc7c73d.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdaadf62222a705cda198dd96dc7c73d.sboyd@kernel.org>

On Tue, Jan 16, 2024 at 05:18:15PM -0800, Stephen Boyd wrote:
> Quoting Rob Herring (2024-01-15 12:32:30)
> > On Fri, Jan 12, 2024 at 12:07:47PM -0800, Stephen Boyd wrote:
> > > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > index da9826accb1b..9628e48baa15 100644
> > > --- a/drivers/of/Kconfig
> > > +++ b/drivers/of/Kconfig
> > > @@ -54,9 +54,14 @@ config OF_FLATTREE
> > >       select CRC32
> > >  
> > >  config OF_EARLY_FLATTREE
> > > -     bool
> > > +     bool "Functions for accessing Flat Devicetree (FDT) early in boot"
> > 
> > I think we could instead just get rid of this kconfig option. Or 
> > always enable with CONFIG_OF (except on Sparc). The only cost of 
> > enabling it is init section functions which get freed anyways.
> 
> Getting rid of it is a more massive change. It can be the default and
> kept hidden instead? If it can't be selected on Sparc then it should be
> hidden there anyway.

The easier option is certainly fine for this series. I just don't want 
it visible.

> > >       select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
> > >       select OF_FLATTREE
> > > +     help
> > > +       Normally selected by platforms that process an FDT that has been
> > > +       passed to the kernel by the bootloader.  If the bootloader does not
> > > +       pass an FDT to the kernel and you need an empty devicetree that
> > > +       contains only a root node to exist, then say Y here.
> > >  
> > >  config OF_PROMTREE
> > >       bool
> [...]
> > > @@ -195,6 +191,17 @@ static inline int of_node_check_flag(const struct device_node *n, unsigned long
> > >       return test_bit(flag, &n->_flags);
> > >  }
> > >  
> > > +/**
> > > + * of_have_populated_dt() - Has DT been populated by bootloader
> > > + *
> > > + * Return: True if a DTB has been populated by the bootloader and it isn't the
> > > + * empty builtin one. False otherwise.
> > > + */
> > > +static inline bool of_have_populated_dt(void)
> > > +{
> > > +     return of_root != NULL && !of_node_check_flag(of_root, OF_EMPTY_ROOT);
> > 
> > Just a side comment, but I think many/all callers of this function could 
> > just be removed.
> > 
> > I don't love new flags. Another possible way to handle this would be 
> > checking for "compatible" being present in the root node. I guess this 
> > is fine as-is for now at least.
> 
> Ok. I can add a check for a compatible property. That's probably better
> anyway. Should there be a compatible property there to signal that this
> DT isn't compatible with anything? I worry about DT overlays injecting a
> compatible string into the root node, but maybe that is already
> prevented.

I worry about DT overlays injecting anything...

I don't think it is explicitly forbidden, but I have asked that any 
general purpose interface to apply overlays be restricted to nodes 
explicitly allowed (e.g. downstream of a connector node). For now, the 
places (i.e. drivers) overlays are applied are limited.

We could probably restrict the root node to new nodes only and no new 
or changed properties.

Rob

