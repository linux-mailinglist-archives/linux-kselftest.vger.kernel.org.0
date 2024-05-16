Return-Path: <linux-kselftest+bounces-10303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90E68C799D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 17:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B41CB20E16
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B690514D2BD;
	Thu, 16 May 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeovySx5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C60314D42C;
	Thu, 16 May 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873993; cv=none; b=eVqwV2haHW/k3nja1cu6s9NPHvei9YjVAAYt0whzwhmMWybuBmEZ2TNOMmJiNXns9URMVHT2avLng4QtwScu2kdcdQyDp8Jn/6YS1FeqvCZ4yB6CwJYjYAJMkylozo/JAdV4bR1j9m8AsU7Ht5nTmv9sSqJ/TA/KCBYop/a4IAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873993; c=relaxed/simple;
	bh=s7vc9H6+GdysQnL6nsgzkQ5gcbPBh3yCFJlL/w0sugk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYEtY4oxLip/iTCRGMoPp70wIVw7kIdILgY9COF4JBtrPYl715jBwGtYD9/eUlCJ1bu/EEJ4JKxwsnn3RcNzCGmCLYiDx5FJu8caU0yIKtepnNSvtYZ5b8rDSc5iXMFVIe4bRsU+TWk5AjOJ8Segqp6sqQI2wuOQwP5b2UExWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeovySx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6A0C113CC;
	Thu, 16 May 2024 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715873993;
	bh=s7vc9H6+GdysQnL6nsgzkQ5gcbPBh3yCFJlL/w0sugk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NeovySx5koO0EYBTxCKD+gRrFfzcA390Nb8kPK7RC+NflGJbZ8rQTZYWZt2tnzBUe
	 SS0hI0dhKUV6bl3czMsKIMkYypDlCrmxgujFFCh9MrvONTMr3NK/oNHBjgK+BIDeQU
	 a+8RVl6ghuBdaI0+x69pIvpiCuN7UoCX1Gvkwgg4RHNeXynyRnnxz8QKnBp1+vthgW
	 95Hqdjju21pIv2+Uqh9efZ9c1/8DStu74LiMQesKww3TsemY8H7nsV4qGzGOO7Q9DV
	 yG2Vcv3yv2fmhR2YLm6Py8CprO2ykGkBwZx1BXHxNfjp+MRjgtWTFn6p9Kbu2K3kWy
	 Dn4/Zly5pg3VA==
Date: Thu, 16 May 2024 08:39:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>, Ido Schimmel
 <idosch@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Tobias
 Waldekranz <tobias@waldekranz.com>, Jaehee Park <jhpark1013@gmail.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests/net: use tc rule to filter the na packet
Message-ID: <20240516083951.15610afa@kernel.org>
In-Reply-To: <20240514071130.2121042-1-liuhangbin@gmail.com>
References: <20240514071130.2121042-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 15:11:30 +0800 Hangbin Liu wrote:
> Hi Jakub, would you please help check if this fix the
> arp_ndisc_untracked_subnets flake issue on debug kernel?

It didn't get ingested by the CI because there's a conflict with
something else that got merged into lib.sh. Could you rebase / repost?


At a glance the problem in the CI is that it times out on debug kernels:

# overriding timeout to 7200
# selftests: net: arp_ndisc_untracked_subnets.sh
#     TEST: test_arp:  accept_arp=0                                       [ OK ]
#     TEST: test_arp:  accept_arp=1                                       [ OK ]
#     TEST: test_arp:  accept_arp=2  same_subnet=0                        [ OK ]
#     TEST: test_arp:  accept_arp=2  same_subnet=1                        [ OK ]
#
not ok 1 selftests: net: arp_ndisc_untracked_subnets.sh # TIMEOUT 7200 seconds

So it consumed full 2 hours and didn't finish.

