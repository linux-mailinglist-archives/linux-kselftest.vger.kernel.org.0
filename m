Return-Path: <linux-kselftest+bounces-12651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D784A916AD3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 16:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58FB8B24939
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6529C16FF43;
	Tue, 25 Jun 2024 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl0mNoxN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821B16FF31;
	Tue, 25 Jun 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326507; cv=none; b=DUzHy2qAp/Ar6da/qslb7BKGvtoCa1URkz2GJCKHaPJWbKRy3alYqnCNSwKeFJ1HaU9sUIewDq76zvMibnCws3pFIGRPhxp5UgBankUU1srbPJWPZuFsUMLkPWLhBYk5wdc0jLB7V0EbhIOMTmwnQcWLip4cNFLeIiO7+skm14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326507; c=relaxed/simple;
	bh=7Xoqa/8SM4/teyTc5YVyyz/aN2GVZH2+fbzkHrtRClc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBhvIYbqzKRv3jEIPteWqV1W1We9hjGBjWqUNBxMlKqCBWMXAJhYSmv5+89ukKuewOWfCWlP3yS8fBh8m4qjYILcX4iGGYApbdbbGoQB/2ywQ/XefEaFfeaXs2lsU8KVGRbVN0CGFujYoTG7kWZcwTbZLXXswrdQU5H+wXcas50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl0mNoxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C7CC32786;
	Tue, 25 Jun 2024 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719326506;
	bh=7Xoqa/8SM4/teyTc5YVyyz/aN2GVZH2+fbzkHrtRClc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kl0mNoxN/PcCwlqXY6XVVhDiKjRsivVxEBgCN5Wt06JThBYPf9EN05TzDJE8AV0W8
	 +h6qlKhJCJZ3ZL/aMcxIE841wgMP3Hkm+reT3vl0Ivw5ir9Dhe/nulXdu0gBTdT9pl
	 3k2PbH4g+FI8s42V9hIiatJMk3tb4HnaSYF3jWYbjYOwKA94pjBW1ZjTcnfAKWawNt
	 pdGo2OM7YrVXnreO9yEdUgj5474Clp9VqFrtqIZ1WLtyZlfJZ8SqnG0lRBttK3NqQk
	 C61DFIL2qme0jd4ThkSt9psSznSPHi9tlQYeAW0Q3MxCZOpBjTXPLFnmIerpw/Cc91
	 lH7a4uWEEnmsQ==
Date: Tue, 25 Jun 2024 07:41:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Shuah
 Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
 =?UTF-8?B?QWRyacOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
Message-ID: <20240625074145.69fc9d9f@kernel.org>
In-Reply-To: <f7t1q4lgldr.fsf@redhat.com>
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org>
	<f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com>
	<e4f69335f90aae3f1daa47ba8f69b24ea15ed3b7.camel@redhat.com>
	<f7th6dhgnvm.fsf@redhat.com>
	<20240625070654.6a00efef@kernel.org>
	<f7t1q4lgldr.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 10:14:24 -0400 Aaron Conole wrote:
> > Sorry for not checking it earlier, looks like the runner was missing
> > pyroute:
> >
> > # python3 ./tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > Need to install the python pyroute2 package >=3D 0.6.
> >
> > I guess run_cmd counter-productively eats the stderr output ? :( =20
>=20
> Awesome :)  I will add a patch to ovs-dpctl that will turn the
> sys.exit(0) into sys.exit(1) - that way it should do the skip.
>=20
> When I previously tested, I put an error in the `try` without reading
> the except being specifically for a ModuleNotFound error.
>=20
> I'll make sure pyroute2 isn't installed when I run it again.
>=20
> Thanks for your help Jakub and Paolo!

BTW I popped the v2 back into the queue, so the next run (in 20min)
will tell us if that's the only thing we were missing =F0=9F=A4=9E=EF=B8=8F

