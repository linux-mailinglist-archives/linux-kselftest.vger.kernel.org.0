Return-Path: <linux-kselftest+bounces-3127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD4982FE4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 02:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607EB1F26786
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 01:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E6310FF;
	Wed, 17 Jan 2024 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UufWcQ3z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A2810EB;
	Wed, 17 Jan 2024 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705454298; cv=none; b=F9blwx/qEDvhnUUiLeFuEejNeJXNKpAtrsoFbQDAAGiz1hV44azt36EzFkrdBunnMAevzCF0QIFwF8ac6R6TTulqwi0Z6jBQBfVaf0YRAfWCmbVAgkAL9jhklZodNdmUP8+f4p2ogHSX/g+HS6IY3sVISpICuw/N6F9u44GXHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705454298; c=relaxed/simple;
	bh=p9Rh3dyRs/5GUJfFv0bThfhcOx9k3Z/O3iFRLNLB+9Y=;
	h=Received:DKIM-Signature:Message-ID:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:In-Reply-To:References:Subject:From:Cc:
	 To:Date:User-Agent; b=gH4u//CE5tSH3omZWfQpDJoIy3pmLEe1RXL0wMkFf+0WFfkHcMM46VcRZuOJDVDy1K9W3RbuQmYWSRLmoTjI6GX3wWid2CZLunPq6MZlk6sKbVWKsbb+fppo/rtoBaxITmQXiXp4a6mgLkrNFSfMxN4Ja/alJ9/Xq8bNFtXm0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UufWcQ3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE289C433C7;
	Wed, 17 Jan 2024 01:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705454297;
	bh=p9Rh3dyRs/5GUJfFv0bThfhcOx9k3Z/O3iFRLNLB+9Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UufWcQ3zY5TXWZ9yO2rkxrBig+h80cgpqDs9jkj0hrKE5Zmv3LGgrQJYivFsPDX+1
	 JvpxG/EPiS70zVWhzBCsttd6P9KdHSTlHviGAuCzmt3MtSzpNEOrQGx9PKhfj/O7oK
	 2q1xpb5tJBIv6ovLlxzcfOxzIlBdoMnJIxdQOFOrYDtnXoyo1E3VLcMLZP4LLB8FAm
	 MIKw+D75L3kAOtUuOFQ6hNyub/u/JTwhltThkfnalFe08AnrrnBBW0ug6CabnNhs16
	 EXaHb9DeFDkkRgTIqjjlkgPIfDO6zCXuJO28H4TDnWXBpBL/1G+um75K/Op2/cH/12
	 5Ez9RKJe0ODOg==
Message-ID: <cdaadf62222a705cda198dd96dc7c73d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240115203230.GA1439771-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-5-sboyd@kernel.org> <20240115203230.GA1439771-robh@kernel.org>
Subject: Re: [PATCH 4/6] of: Create of_root if no dtb provided by firmware
From: Stephen Boyd <sboyd@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Date: Tue, 16 Jan 2024 17:18:15 -0800
User-Agent: alot/0.10

Quoting Rob Herring (2024-01-15 12:32:30)
> On Fri, Jan 12, 2024 at 12:07:47PM -0800, Stephen Boyd wrote:
> > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > index da9826accb1b..9628e48baa15 100644
> > --- a/drivers/of/Kconfig
> > +++ b/drivers/of/Kconfig
> > @@ -54,9 +54,14 @@ config OF_FLATTREE
> >       select CRC32
> > =20
> >  config OF_EARLY_FLATTREE
> > -     bool
> > +     bool "Functions for accessing Flat Devicetree (FDT) early in boot"
>=20
> I think we could instead just get rid of this kconfig option. Or=20
> always enable with CONFIG_OF (except on Sparc). The only cost of=20
> enabling it is init section functions which get freed anyways.

Getting rid of it is a more massive change. It can be the default and
kept hidden instead? If it can't be selected on Sparc then it should be
hidden there anyway.

>=20
> >       select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
> >       select OF_FLATTREE
> > +     help
> > +       Normally selected by platforms that process an FDT that has been
> > +       passed to the kernel by the bootloader.  If the bootloader does=
 not
> > +       pass an FDT to the kernel and you need an empty devicetree that
> > +       contains only a root node to exist, then say Y here.
> > =20
> >  config OF_PROMTREE
> >       bool
[...]
> > @@ -195,6 +191,17 @@ static inline int of_node_check_flag(const struct =
device_node *n, unsigned long
> >       return test_bit(flag, &n->_flags);
> >  }
> > =20
> > +/**
> > + * of_have_populated_dt() - Has DT been populated by bootloader
> > + *
> > + * Return: True if a DTB has been populated by the bootloader and it i=
sn't the
> > + * empty builtin one. False otherwise.
> > + */
> > +static inline bool of_have_populated_dt(void)
> > +{
> > +     return of_root !=3D NULL && !of_node_check_flag(of_root, OF_EMPTY=
_ROOT);
>=20
> Just a side comment, but I think many/all callers of this function could =

> just be removed.
>=20
> I don't love new flags. Another possible way to handle this would be=20
> checking for "compatible" being present in the root node. I guess this=20
> is fine as-is for now at least.

Ok. I can add a check for a compatible property. That's probably better
anyway. Should there be a compatible property there to signal that this
DT isn't compatible with anything? I worry about DT overlays injecting a
compatible string into the root node, but maybe that is already
prevented.

