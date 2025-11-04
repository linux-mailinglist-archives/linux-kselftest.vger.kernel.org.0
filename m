Return-Path: <linux-kselftest+bounces-44685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541EBC2E818
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 01:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4443B9A65
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 00:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0F24A1E;
	Tue,  4 Nov 2025 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgXUiDOz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047392110;
	Tue,  4 Nov 2025 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214730; cv=none; b=Dd4I/K5eHi6h2xtvEm2RYOy2Vj14fbTvkILl+ZViLTctfrumjfA0ZiBvnv82ip101dBNRwv9eid+wwM7exug9PuxTr+eGHnsQcEk0aeTnFLEvUrmbl+hcODY0LtjdXAg+gwvZ0mj39IEsFABYwCSKo2ziYx5gUbFdv0RJ6djaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214730; c=relaxed/simple;
	bh=b0RGm9gpzb6CZrC8+ypQu01AKjID3VKFXIUN2yTNvh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPys7hxxnXF8o0vL4Yt6TGJ2ZDDwYoLUOohtb/YY6kIK2Z0FUklAJC9Fg8ytDJ9zzIcEE1IFgil56cYTYEY7e+m7ROBhvpLFb32+IGimioUS8Zn0V7ra3sbYc0YdLuhf9BrOnvYLEnPNWF0OIgPaAewV4w9gn3dcjAl5hcXM3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgXUiDOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3B2C4CEE7;
	Tue,  4 Nov 2025 00:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762214729;
	bh=b0RGm9gpzb6CZrC8+ypQu01AKjID3VKFXIUN2yTNvh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TgXUiDOzkLHD1SkUy6OXCDbxJ0A+9SzyLx8lXjcqHdQ7oe3vLNYH/UN+zsDIy70M1
	 vaJs/t7Gj4qF5sYkP9vZl/k0ag4VY02WPSRAio9X2CyhK3M+2txtxQuDTeQi+4FJAS
	 83sdVc0crVMjtmE+9vLeFwVFVli2DNM71q1Gf3A+CF9tM/eQ4MIBtcDF9IjQPUN8sy
	 ZLyxDUHdj8Az9wKgvPx5glcrETRWHnPS7YCjb973oj5s2SndYD/i9iTpTvYG+Oxazp
	 D3jqcgfrK+nlo5vnRYUISKrLjrd4nua6NoalvCxtDTYK4vpjoyP26JubmLHqJPQmcT
	 levB7kUwfdEoQ==
Date: Mon, 3 Nov 2025 16:05:27 -0800
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
Subject: Re: [PATCH net-next 3/3] selftests: net: add YNL test framework
Message-ID: <20251103160527.2813b61c@kernel.org>
In-Reply-To: <aQg5y_Feg6YQ7Odl@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
	<20251029082245.128675-4-liuhangbin@gmail.com>
	<20251029164159.2dbc615a@kernel.org>
	<aQL--I9z19zRJ4vo@fedora>
	<20251030083944.722833ac@kernel.org>
	<aQQVYU1u3CCyH8lQ@fedora>
	<20251031112406.403d1971@kernel.org>
	<aQg5y_Feg6YQ7Odl@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 05:12:43 +0000 Hangbin Liu wrote:
> On Fri, Oct 31, 2025 at 11:24:06AM -0700, Jakub Kicinski wrote:
> > > I just do `make install` in tools/net/ynl. Both the ynl scripts and specs are
> > > installed. So I think the specs are also tested.
> > >
> > > I didn't get here. The `ynl` calls pyynl.cli:main, that should be enough.
> > > Do you mean we should find the `cli.py` path and call it like
> > > `$source_code/tools/net/ynl/pyynl/cli.py --spec
> > > $source_code/Documentation/netlink/specs/xxx.yaml ...`?  
> > 
> > More or less. But it needs to know how to install itself when kernel
> > selftests are installed. Maybe it's not worth the complexity and we
> > should add the script under tools/net/ynl. Easier to refer from there.  
> 
> Hmm, how should we execute the script under `tools/net/ynl`? Use the cli.py
> like:
> 
> ./cli.py --spec ../../../Documentation/netlink/specs/xxx.yaml
> 
> Or use the installed name `ynl`
> 
> ynl --family xxx ...

I think under tools/net we don't have the kernel selftest infra.
This is not great because we lose the integration benefits,
but it gives us the ability to.. do whatever want..

I think relative paths would be fine? I believe that if you run cli
from its directory you can use --family and it will refer to the
in-tree specs automagically ?

