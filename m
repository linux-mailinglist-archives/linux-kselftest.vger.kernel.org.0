Return-Path: <linux-kselftest+bounces-44976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A558FC3BD73
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 15:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692741B25664
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA5340A6D;
	Thu,  6 Nov 2025 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUuuZgH7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E63191D3;
	Thu,  6 Nov 2025 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440066; cv=none; b=eJytfkQXOnFVfjqmAmnpSV8QPIkyAVTGxh5r/2zMsFbhnydJr4dBU3C7W2kP0i3qceiMcfS58UGobpCeAAu47+B9SgjHz8Uy0U5ETONpY2xdcqNv1pkceZ+S/R/hDWBUKrLcvFHbyZQNWmfk7sblDTsgUI4jOtj0PRwtkwsTHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440066; c=relaxed/simple;
	bh=jZwU5Q5k5Hv/99JNHI6SHIbM5weSSTkab1oATNjTjEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9mYifAKZH5a49uQjXp8LMRoloWmkHtA6PwkwO6Zg63lLFX4JIdjAy/r3tyGAluaeve9exmmUUVY3OAH0u1onX2UIeq0U5zjPrNPFHSrrZu8DnYzNt/1tRy6qpHNSA5D+jBydDrzP3EFzd3qnPGdQw2rQKlaDVtOE2yyADeXC2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUuuZgH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FEAC4CEF7;
	Thu,  6 Nov 2025 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762440066;
	bh=jZwU5Q5k5Hv/99JNHI6SHIbM5weSSTkab1oATNjTjEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fUuuZgH7+fyp15S3A7Zbg1vGuRp32+ExBwYBM6a1kdDdLZufYKcjsfL1dUi6OXttk
	 uKep1rFjt1Swu7d9oTmBxfENFcdX2oE+eao/ViC6aD2jugUjy546rNTtsXx6CXoCOC
	 /Gfs1bFJ8m27MWOXpjH7i16lZTF1dFfmDtOxdg0Ck7yo5Tgakq/PHVHk+nkDGOwKPw
	 M4HKxlznv1QRXOmZ1JyGaLI5p+eWM5ywj1dQrSmM8nk9PjtWuKWLmW+HZX89Ei7Dgs
	 BMM0lDVNeV96YcivP4VDH0RKcGxlJ+PK+sHv1j8bw3ydwglfM7MxuA3nSQ6LKLgY/f
	 7sPu99YISlZbA==
Date: Thu, 6 Nov 2025 06:41:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jan Stancek
 <jstancek@redhat.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?= <ast@fiberby.net>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, Ido
 Schimmel <idosch@nvidia.com>, Guillaume Nault <gnault@redhat.com>, Petr
 Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
Message-ID: <20251106064104.135b73de@kernel.org>
In-Reply-To: <aQwJLKka-_pBGq_g@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
	<20251029082245.128675-3-liuhangbin@gmail.com>
	<20251029163742.3d96c18d@kernel.org>
	<aQnG8IYsY3oyYekf@fedora>
	<20251104164804.540a9b8d@kernel.org>
	<aQsDA7ufLlIwSf1h@fedora>
	<20251105161319.0591f96e@kernel.org>
	<aQwJLKka-_pBGq_g@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Nov 2025 02:34:20 +0000 Hangbin Liu wrote:
> > > The display-hint is required; otherwise, the displayed src and dst fi=
elds
> > > appear as binary data, and setting the rule=E2=80=99s src/dst values =
also fails. I
> > > haven=E2=80=99t checked the code yet, but with
> > >   - display-hint: ipv4
> > > the IPv6 addresses are also displayed correctly :) =20
> >=20
> > Heh, we should have called the hint "ip" in that case :) =20
>=20
> I saw the display hit supports "ipv4-or-v6",=20

Ah!

> but genetlink-c.yaml doesn't have "ipv4-or-v6". Do you know why?

Probably just wasn't used until now. It should be in all the schemas.

