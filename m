Return-Path: <linux-kselftest+bounces-3128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAADA82FE5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 02:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B54288748
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 01:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EF11115;
	Wed, 17 Jan 2024 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC9n+TgG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245810E9;
	Wed, 17 Jan 2024 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705454841; cv=none; b=ssdnPpeIfg8yLfzVjOd6+y1tfY3aNXoCTd7w4kYNPteoJo6jF2vkXw2t0ISnDLqx0SvmsQ8sSi/8deelk8B+6I9+TRtuk6eNL0GpQfQiwk022Ivc1BG0NNbUACE7ZekOpnjowmblFJ1HIJfad3xOZKexJbZztR8NBKdLj4vCtBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705454841; c=relaxed/simple;
	bh=u7BlLrJyg8NJtw6cjGr372yJi8HU88SzdYtGR597Yxg=;
	h=Received:DKIM-Signature:Message-ID:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:In-Reply-To:References:Subject:From:Cc:
	 To:Date:User-Agent; b=txqydAxN3POfz9XoHsyLce6CL60GC5S5h2bnINv0+pKvZTL1IWo1VYrNAdOMHmMHtHhEGpHuxC7YH9FZShrt6fOrHfZ7i4NXQPraG8gHRBD8SvmNYPlMRlNn+EQUuHct2QgzRJE/KYoUN+IEt0EpAjdfybfF5F1Km3CPYV0Z+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tC9n+TgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5737EC433F1;
	Wed, 17 Jan 2024 01:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705454840;
	bh=u7BlLrJyg8NJtw6cjGr372yJi8HU88SzdYtGR597Yxg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tC9n+TgGzJdYa9eJaNIrd6YETp5ouaQa3aG/Bsb5/+N9Ozvs5fVcYmBG3R+99pSr5
	 6MQ+zqdLWmYJkkihzT5Ht0YQGPz5jNQVXsC52lwEWb6veqPJK0PgKqtIJWkAAsas2A
	 ESvqojtCoN+ZsgPbnn0qdAQ83dvbZj1vzayHDMbAv4f8xzdUDnTPAV6JFSe5KGMIBP
	 yO1jM5cRt4kuCl/+A2j/at9+4Kir3CEfkwNnX9m9EDx8HO8gBIGEM6Xd8aoajnN5sB
	 GddFcKCgyWf5RXom2kEzyux5c/FbyuQ9jy3E+OHf8D8+0yBoSIBN3fGRnwpt7PN5gn
	 NyOU6rMIxL3Kw==
Message-ID: <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-2-sboyd@kernel.org> <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 16 Jan 2024 17:27:18 -0800
User-Agent: alot/0.10

Quoting Mark Rutland (2024-01-16 03:51:14)
> Hi Stephen,
>=20
> On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > Call this function unconditionally so that we can populate an empty DTB
> > on platforms that don't boot with a firmware provided or builtin DTB.
> > There's no harm in calling unflatten_device_tree() unconditionally.
>=20
> For better or worse, that's not true: there are systems the provide both =
a DTB
> *and* ACPI tables, and we must not consume both at the same time as those=
 can
> clash and cause all sorts of problems. In addition, we don't want people =
being
> "clever" and describing disparate portions of their system in ACPI and DT.
>=20
> It is a very deliberate choice to not unflatten the DTB when ACPI is in u=
se,
> and I don't think we want to reopen this can of worms.

Hmm ok. I missed this part. Can we knock out the initial_boot_params in
this case so that we don't unflatten a DTB when ACPI is in use?

