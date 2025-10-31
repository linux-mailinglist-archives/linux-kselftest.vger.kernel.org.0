Return-Path: <linux-kselftest+bounces-44546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B9DC268D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 19:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72CB3B59C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 18:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CF7351FB9;
	Fri, 31 Oct 2025 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIbAYb89"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB91155757;
	Fri, 31 Oct 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935049; cv=none; b=nVPkDWLYaShIjPE0eygirR6pH0JKyOO6Ikc7plsjJLW3pgmnbyUNuUWe0UGdUR217zNQtFwKdlvIBzrQY+T2agyQ56XnR3PUHp9yLSOXYcNqJ2G9sSBLO1/o9dLVc009gWLZ/J6z2bVgppOH5ABh9Xk6bUa+z8Iydv3Fuea/xNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935049; c=relaxed/simple;
	bh=WtHrfhXL3ZdHRsXVS7Yudx+vMtICj4ek1mO5rE/hBTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oN6hRgNKvyl8/LACNsSCtF7LjMhqayVNXe93/MDAtKjqf0cwzsMYnfED/lQnCaox3JcmmvfLiuAShqWmyKfBVRuXcwH7yULIKPfCTfEABVosbLrJ5dppvwZdRRuh+FBPK/8zE7JqOHK6pJw+uwZETYpH03s61IgUJyhfIAYwBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIbAYb89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1EBC4CEE7;
	Fri, 31 Oct 2025 18:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761935047;
	bh=WtHrfhXL3ZdHRsXVS7Yudx+vMtICj4ek1mO5rE/hBTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mIbAYb89ihj/e+sscAPrJSK4Rz2AMzSJWajHg4/axpcN1hV3yoV7q8xli7Mv2D/Ji
	 JaeRFwJhZ9slgAhh4rGOxUp1xvkqoVt1V350d5mMsZ8v7ZZCPt/AxXHLv/dx2FmWGO
	 mLz6jTlTaUFfkB7LG8+WMtSQI18SygpIIVk6nXG0kBON9O+AAcEf5xc5Ytysc5AKXm
	 WykRbnudSWf0LP+CSLaM7oZcwuDTCade5R/BZQ55qQsXXqthGWSaN1oHfzkcW7wZ1s
	 ZoOHa9Q+ZhJ/9fSHZULGC3GDHZlh5XkVuETGfR78HrPejQc9kEljsry55qUS68LTva
	 qVhnXJZQAuGVg==
Date: Fri, 31 Oct 2025 11:24:06 -0700
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
Message-ID: <20251031112406.403d1971@kernel.org>
In-Reply-To: <aQQVYU1u3CCyH8lQ@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
	<20251029082245.128675-4-liuhangbin@gmail.com>
	<20251029164159.2dbc615a@kernel.org>
	<aQL--I9z19zRJ4vo@fedora>
	<20251030083944.722833ac@kernel.org>
	<aQQVYU1u3CCyH8lQ@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 01:48:17 +0000 Hangbin Liu wrote:
> > > Kind of. With this we can test both the system's YNL and also make sure the
> > > YNL interface has no regression.  
> > 
> > Meaning we still test the spec, right?  
> 
> I just do `make install` in tools/net/ynl. Both the ynl scripts and specs are
> installed. So I think the specs are also tested.
>
> > To state the obvious ideally we'd test both the specs and the Python
> > tools. Strictly better, and without it adding tests for new Python
> > features will be a little annoying for people running the selftest.  
> 
> Yes
> 
> > Maybe the solution is as simple as finding and alias'ing ynl to the
> > cli.py ?  
> 
> I didn't get here. The `ynl` calls pyynl.cli:main, that should be enough.
> Do you mean we should find the `cli.py` path and call it like
> `$source_code/tools/net/ynl/pyynl/cli.py --spec
> $source_code/Documentation/netlink/specs/xxx.yaml ...`?

More or less. But it needs to know how to install itself when kernel
selftests are installed. Maybe it's not worth the complexity and we
should add the script under tools/net/ynl. Easier to refer from there.

