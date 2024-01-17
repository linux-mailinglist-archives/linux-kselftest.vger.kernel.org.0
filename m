Return-Path: <linux-kselftest+bounces-3175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA04830FE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 00:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47E31F25D36
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 23:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23851E891;
	Wed, 17 Jan 2024 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxeT3GBz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B61286B9;
	Wed, 17 Jan 2024 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532450; cv=none; b=i7TNyqKFgHzVHCqyq9nQTayf0JtgxKR67IoJachSoH95ywRnjroZbgTdQ9/fpvXCKjgu3koN3GGPAS+x5wm+7x5Iqk3RvSWUMpitSS/3+RyI/0E5KSiqfODvkdNs10Y0YeEo66l91pOqSGM0GUQx8g6ARv/OM7vJIETjjEyHQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532450; c=relaxed/simple;
	bh=fyXBSC0bnHo3boCpQubXQI92k6WFO1uOlIbnTuqgLD4=;
	h=Received:DKIM-Signature:Message-ID:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:In-Reply-To:References:Subject:From:Cc:
	 To:Date:User-Agent; b=IaBZx9CrwHe7JHXVyjqG3Nf6Glh9LzCsJPfotAucvZiiF8IXXoFV05nMgrIIXp1nac8SrpHABsPiIxnESFWft0xe+fbQwkkYl3TTP8Tn+3b73kytU1JFeWk/T9EO68KQYe1a6wKuy8nrXriUgGCsvAI/40Fhr1T245vaKdzqSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxeT3GBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAA2C433C7;
	Wed, 17 Jan 2024 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705532450;
	bh=fyXBSC0bnHo3boCpQubXQI92k6WFO1uOlIbnTuqgLD4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WxeT3GBztptAaY54E7E/IibQmlI2auDqcjQAJU/gbKcJrpG8pzf4C7/y1Z3dWzZLM
	 C3E7KEby6UhIR9QxS/hXvDl6n8eBw+MdcCGzH5yULampXTr/OV2rJLG11LvS9RRIYn
	 YzrKFeKcLsRcvhdr0fNVMSHKSf2pNYsWc1rDfKFpxAjY7Fq70WYgFnxZbaQTF5F5AK
	 49xUOHmYbNMTvV9nsg29O/JNZUvnx4yb22BH/iUncI2nMgA9h7/UEOvfcq6VTOJbc5
	 yXO/XavnF5W6YWnqKq5QzKcjtF2A3erD1aVIOVPukufVmT4wvd8LbVFYOul5+8E2zE
	 tqh93Yr9GR9WQ==
Message-ID: <c3f239caee806419a8ad0ed45a627947.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240117175448.GB2779523-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-2-sboyd@kernel.org> <ZaZtbU9hre3YhZam@FVFF77S0Q05N> <434b21afe1899b1567f3617261594842.sboyd@kernel.org> <20240117175448.GB2779523-robh@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
Date: Wed, 17 Jan 2024 15:00:48 -0800
User-Agent: alot/0.10

Quoting Rob Herring (2024-01-17 09:54:48)
> On Tue, Jan 16, 2024 at 05:27:18PM -0800, Stephen Boyd wrote:
> > Quoting Mark Rutland (2024-01-16 03:51:14)
> > > Hi Stephen,
> > >=20
> > > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > > Call this function unconditionally so that we can populate an empty=
 DTB
> > > > on platforms that don't boot with a firmware provided or builtin DT=
B.
> > > > There's no harm in calling unflatten_device_tree() unconditionally.
> > >=20
> > > For better or worse, that's not true: there are systems the provide b=
oth a DTB
> > > *and* ACPI tables, and we must not consume both at the same time as t=
hose can
> > > clash and cause all sorts of problems. In addition, we don't want peo=
ple being
> > > "clever" and describing disparate portions of their system in ACPI an=
d DT.
> > >=20
> > > It is a very deliberate choice to not unflatten the DTB when ACPI is =
in use,
> > > and I don't think we want to reopen this can of worms.
> >=20
> > Hmm ok. I missed this part. Can we knock out the initial_boot_params in
> > this case so that we don't unflatten a DTB when ACPI is in use?
>=20
> You mean so we don't unflatten the boot DTB, but instead unflatten the=20
> empty one, right? That sounds fine.

Yes. Note, I don't have any ACPI arm64 system on hand to test anything
with :-(

>=20
> Another thing to check is kexec because it will still need the original=20
> DTB I think. Though if you are doing ACPI boot and kexec'ing, kexec may=20
> write out everything needed by the next kernel and the empty DTB would=20
> work just fine.

Yeah, it looks like dt_is_stub() will keep doing its thing there. The
empty DTB will have nothing in it and so kexec with ACPI and the empty
DTB will continue to use ACPI, and then the empty DTB will be added in
again.

> Of course those users booting with ACPI and then=20
> kexec'ing to DT boot will be broken. Perhaps that's a feature...

I don't know how this part works. If you kexec to DT boot won't you run
through startup again and initial_boot_params will have a non-empty DTB
in it? I'd think this would keep working.

