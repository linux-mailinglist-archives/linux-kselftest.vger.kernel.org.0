Return-Path: <linux-kselftest+bounces-3089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DEB82F456
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 19:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEF91C22349
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2550110A1A;
	Tue, 16 Jan 2024 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be9BcZVs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF51CF80;
	Tue, 16 Jan 2024 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430072; cv=none; b=tbw7L1nK6PpUAUjKsE2XMY8xFxqpWTjyxRDii8/0YWV5GZT9epRclhvG/XV84drxMPKGZHCqScD16XDoLkLhBRxFUvbyHdQzNod9D65Y+bLvf/OSYX+X09OFfGJkTyW8rhHu8fmj+YPCvi7K2ywRky6WU7WJYbtxleWyNE7RvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430072; c=relaxed/simple;
	bh=1XGdL4iTtq6KeGrch5Q/sxaqTYIocADsyus4kQ7Jpxg=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=qMEUtjAXmb68epssvF86fWe2fn0tbReZYDE2QvbQlwCZXLypc4uUPK9C6e5fNM9m+AeaCbD0oITfxxUE1Jh9SOiI9ZYagcaskLGxXmHh3KgwYad63eAhH1gyiuGGD3rRq86lpvxS7+Ju6KVw37s83Yq/MQ4fPnYqieYLfEQt3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be9BcZVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21411C433C7;
	Tue, 16 Jan 2024 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705430071;
	bh=1XGdL4iTtq6KeGrch5Q/sxaqTYIocADsyus4kQ7Jpxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=be9BcZVsH1aVQRpV2+125MmIdBDWwB5qdsXgAfCOSCNULXrkzptDglhizgsTMJkNt
	 x8Yd/x1k9lCxquMgBNPauUATTrGqNiUyjuvaGHPHhdGLCC6u2Hj3KYg1WE7v3BB0PD
	 soNwyLN20tnexw/vGjQo3WAbC2udjy8x7cPmEjnts4L1KS1Q/cJ5pKOsJjjlGpfVR3
	 sPR6zg81W5Odfoi8d/P423I/iGsbu0ZJobVrBbtQv+aJyJgz02hdIBp8Bgy4ATCbBn
	 Fpd53lSzw6qYSFO632iX7n+6tiZJwLv2KdSkA9WNlL8SfSpFgFFuBiIeiZ6pHmliOg
	 u8YQd5BxyJEkQ==
Date: Tue, 16 Jan 2024 10:34:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 shuah@kernel.org, jiri@resnulli.us, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: netdevsim: add a config file
Message-ID: <20240116103430.600fdb9c@kernel.org>
In-Reply-To: <397aaa82985c749f03d0c6dc034e479d49df1b32.camel@redhat.com>
References: <20240116154311.1945801-1-kuba@kernel.org>
	<397aaa82985c749f03d0c6dc034e479d49df1b32.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jan 2024 18:40:49 +0100 Paolo Abeni wrote:
> On Tue, 2024-01-16 at 07:43 -0800, Jakub Kicinski wrote:
> > netdevsim tests aren't very well integrated with kselftest,
> > which has its advantages and disadvantages.=C2=A0 =20
>=20
> Out of sheer ignorance I don't see the advantage?!?
>=20
> > But regardless
> > of the intended integration - a config file to know what kernel
> > to build is very useful, add one. =20
>=20
> With a complete integration we could more easily ask kbuild to generate
> automatically the kernel config suitable for testing; what about
> completing such integration?

My bad, I didn't have the right words at my fingertips so I deleted=20
the explanation of advantages.

make run_tests doesn't give us the ability to inject logic between
each test, AFAIU. The runner for netdevsim I typed up checks after
each test whether the VM has any crashes or things got otherwise
out of whack. And if so kills the VM and starts a new one to run
the next test. For make run_tests we can still more or less zero
in on which test caused an oops or crash, but the next test will=20
try to keep going. Even if we force kill it after we see a crash
I didn't see in the docs how to continue testing from a specific
point.

So all in all, yeah, uniformity is good, the hacky approach kinda
works. Converting netdevsim to make run_tests is not a priority..

