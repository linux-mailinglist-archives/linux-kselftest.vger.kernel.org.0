Return-Path: <linux-kselftest+bounces-44857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAECC3871B
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 01:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E44EC4E3BD2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 00:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382C7494;
	Thu,  6 Nov 2025 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQVj4e1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CA7CA52;
	Thu,  6 Nov 2025 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388001; cv=none; b=RQa7uZpvp031+oJgU60f74muXgCuije9Z+bpVw9oQvsFhNqoKPrewfWFuGBl9NZLJfoZgmlJXWqc6KfvK/CKEb/kqF2AH2xjtspItvGwqiLcFZhk6CAM/AEnQbGWTkwv3EwxTq7kF7jLTvipWklA12yuOfNY06aKM427u6poGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388001; c=relaxed/simple;
	bh=ObVdtDfNvDGCloet95db6zbqxebwnJkzexi+flUko8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmTiGrjlW5MIVLiyMcJ63qaEaixAA1y/p1aEGcgqPaeuaZTKe3HOZPevLRzh6a5Bwq174yFtOT1wJ7BH1IVbNLAUV08PO3c0S/p1kVmgm7vLcEGrtgkh6P9GRrO59SZDTuugbt4CbDckHw8xphMqG94cWgQ509i71zNL43M20Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQVj4e1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DD2C4CEF5;
	Thu,  6 Nov 2025 00:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762388001;
	bh=ObVdtDfNvDGCloet95db6zbqxebwnJkzexi+flUko8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mQVj4e1CqHXE2KrtPx53ZQeScBDwV1Rf5YU9Fc/O9vVeMgIAa63r31XSygd6giq67
	 Zc5A+f+pVh5SCF27BbWhobTDXU4ItXU1PEgPGDN+9UucBVxkogOttfueFkUKWTeXgc
	 j6ay7C7XRbx+HRZou+6M2WqinlDAPDvjQ7C13zWlmmOqLj/q1n6YAYGQl07q5hKMxO
	 QD84xz+Vufyh3rozCclUbbpdVtIhT/3BITTlCFCYRTkobnvPPkRtyuPuZ21azoyAtG
	 GERrt5Yf3O5ddNnRLf0h9QOwyitqUnFNlKRR25ldBDVRRHJCxlCCtlHOP3pS3m0IJs
	 nrff2hvLUMoXg==
Date: Wed, 5 Nov 2025 16:13:19 -0800
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
Message-ID: <20251105161319.0591f96e@kernel.org>
In-Reply-To: <aQsDA7ufLlIwSf1h@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
	<20251029082245.128675-3-liuhangbin@gmail.com>
	<20251029163742.3d96c18d@kernel.org>
	<aQnG8IYsY3oyYekf@fedora>
	<20251104164804.540a9b8d@kernel.org>
	<aQsDA7ufLlIwSf1h@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Nov 2025 07:55:47 +0000 Hangbin Liu wrote:
> > > I just realize that most of the address/src/dst in rt-addr/route are
> > > dual stack. The same with FRA_DST. We can't simply change binary to u=
32.
> > > So can we keep this u32 -> binary change? =20
> >=20
> > Ah, should have looked at more context..
> > Yes, and in that case without the display-hint? =20
>=20
> The display-hint is required; otherwise, the displayed src and dst fields
> appear as binary data, and setting the rule=E2=80=99s src/dst values also=
 fails. I
> haven=E2=80=99t checked the code yet, but with
>   - display-hint: ipv4
> the IPv6 addresses are also displayed correctly :)

Heh, we should have called the hint "ip" in that case :)

