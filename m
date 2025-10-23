Return-Path: <linux-kselftest+bounces-43959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 028AAC0304C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBB3D567A46
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559CB34C9A3;
	Thu, 23 Oct 2025 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkbTB+21"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5634B198;
	Thu, 23 Oct 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244211; cv=none; b=YY0VsXFc5by16Prb4jwpdOSYI3nC1NneFRUtt6W0Yb6Lx6qT2JTzPAKB4l+M889M585RPDoI93lB7xObrSTxOdeM7Ft3LSVXcnk42rxfyNysF4itqeGskgFmcXL71GfpksqtpRBa7Ag2jAn9T+O1GJD8zjwwj6RY/y6ExXUVNBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244211; c=relaxed/simple;
	bh=ctSOOTT2O05fA9DTO6U9cx0ctplKI+PVoY2b8nJ8W74=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tZXaxKeuvx6g+SqG1QTr69oeukWiUGyKekTm0uifw3oRXxIpp5/CZMtOIXTu62g/7G0eOr2jzhv53Zxsm9dgdDIceFWD3D1ELoNPEwQLwSmnp6WzjQdRLZP5JFQEr/70npv73q8Wryluk6cUDq2X5RxTQ4lBuKiP/H6paCQgtN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkbTB+21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A765C4CEE7;
	Thu, 23 Oct 2025 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761244208;
	bh=ctSOOTT2O05fA9DTO6U9cx0ctplKI+PVoY2b8nJ8W74=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=SkbTB+21ChSHJquQXaq6RbYVwUsFJfRA8wQP1H2henPAllrtScPaYRaryg1bQh/9r
	 TByAFl0SQ1Z5JrXhGowt53T8lzFXaMvFPcTzPnst6KFSfJOIrfM9jV4dNAZK9AUnk6
	 AYfz2WVelWcmFdSTJLAm74R6Fc+cVj2KHk4hjj5LS4BC1HG19fCJ+6j41qtNMpH79F
	 HSP+aL6PVHarIt7rfQLC+X8IRtp0p8U9JoVw7yPoiX687Zn9P3JI0/9wmTJVpc9rJz
	 bGZby/ILpu3Lv+VI+gqtRkoBdxrPbuCdegh4UJnmpHJpidyV0FAEU/scKEv4QTdLrN
	 CY1u3UMETiJjA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 20:30:03 +0200
Message-Id: <DDPWYPG6IGBS.3K4HZRJN0UX0N@kernel.org>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Tzung-Bi Shih"
 <tzungbi@kernel.org>, "Benson Leung" <bleung@chromium.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <shuah@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Simona Vetter"
 <simona.vetter@ffwll.ch>, "Dan Williams" <dan.j.williams@intel.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop> <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com> <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop> <20251023145131.GI262900@nvidia.com>
 <2025102321-struggle-fraying-52ff@gregkh>
 <20251023155746.GL262900@nvidia.com>
 <DDPU75QB8MQ6.3HZ5N0GYKQ9QU@kernel.org>
 <20251023164809.GN262900@nvidia.com>
In-Reply-To: <20251023164809.GN262900@nvidia.com>

On Thu Oct 23, 2025 at 6:48 PM CEST, Jason Gunthorpe wrote:
> On Thu, Oct 23, 2025 at 06:20:02PM +0200, Danilo Krummrich wrote:
>> On Thu Oct 23, 2025 at 5:57 PM CEST, Jason Gunthorpe wrote:
>> > IMHO the rust code does it principally because the sync unregister
>> > life cycle model does not fit naturally into rust.
>>=20
>> That's not the case.
>>=20
>> In fact, we try to give as much "sync" guarantees as possible. For insta=
nce,
>> when a driver registers an IRQ the irq::Registration API enforces that t=
he IRQ
>> is unregistered before the registering device is unbound.
>>=20
>> As a consequence, the IRQ callback can provide a &Device<Bound>, which a=
cts as a
>> "cookie" that proves that for this scope (IRQ callback) the device is gu=
aranteed
>> to be bound.
>>=20
>> With this "cookie" we can then directly access device resources (such as=
 I/O
>> memory) that is within a Devres (and hence a Revocable) container direct=
ly,
>> *without* any locking. I.e. we can safely bypass the Revocable and hence=
 its
>> overhead.
>
> It is good news to hear it, but I think you are making the point I was
> trying to make.
>
> In rust if you have a Device<bound> and you skip the revocable
> locking, I'd argue that you don't need "revocable" at all, just
> enforcement of a Device<bound>.
>
> IOW the presence of revocable in rust, with all the locking, is
> because the sync life cycle model is not available.

That's not the reason, it *is* available.

Requiring a &Device<Bound> "cookie" to be able to access a device resource
directly is one part of it. The other one is to ensure that the device reso=
urce
is actually released once the device is unbound.

When a device is unbound the Revocable within a Devres container automatica=
lly
drops the device resource (i.e. calls the destructor, which, for instance,
unmaps and releases an MMIO memory region).

Subsequently, it also ensures that the device resources can't be accessed
anymore, even if a driver would hold on to the corresponding object instanc=
e:

Obviously, it can't be accessed with a &Device<Bound> anymore, because it i=
s
impossible that the caller is within a scope where a &Device<Bound> is pres=
ent.

And an access with Revocable::try_access() will fail as well, because Revoc=
able
knows internally that the destructor of the wrapped object was called alrea=
dy.

So, what we achieve is that as long as the driver uses safe code (i.e. no u=
nsafe
{}), there is no way for a driver to mess this up and produce a bug that af=
fects
the rest of the kernel.

While at the same time there is zero overhead in "sync" scopes, and non-"sy=
nc"
scopes, which we unfortunately need in some rare cases, are still supported=
 in a
safe way.

> Sounds like the idea is that the sync model will be widely available
> and the revocable lock will rarely be used?

That is correct.

