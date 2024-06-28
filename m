Return-Path: <linux-kselftest+bounces-12937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC091C25B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 17:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C28428311A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA691C9EBB;
	Fri, 28 Jun 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3vG/TLa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED015539F;
	Fri, 28 Jun 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587727; cv=none; b=Yk7+mq2jEa8w/qzoiNn4n2KbVcBMTotVL8p3IyAeAl8TAgY6eMqFEL+HkmueC6ukAxp261Q0aV7LZz+kNLXEkRZgR17XruGHTC5g2wp7Fui7dl344yvn9PugtOrESGmDt3ZfXNlOWVevPGouLHZYG1pgsQ6G7RDhZJ00IZ7BeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587727; c=relaxed/simple;
	bh=DDENOZzeHl+kBVs4BKNGyc6D6XpemEBqKAxdWnYJtOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2qW5k98AVJKNDmbJzEi5NSU0GgcgW+oo81LsiHHQGGHhqHjA5Z2uiHbF5PFceZJqv5gTeXS7lVun3y23nt0o4RNTL25vRjLJ61tA5wcxrCkk3Ttd7LQ3PPiEu67J0sfMf26AtNDvE0O2rE/cPuAt20QyhyVUxpV+tvh13wH2ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3vG/TLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DD4C116B1;
	Fri, 28 Jun 2024 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719587727;
	bh=DDENOZzeHl+kBVs4BKNGyc6D6XpemEBqKAxdWnYJtOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X3vG/TLar+MiwX17rkYmtJ3PgB1s+uJ+Y/6i873DtsmGpfz5ZmgzlT5nV5yRNkskI
	 58zMGhdPnuL5NL0ZSKvuK0G63iIlSkdH/vRHCl1Dnx9DihsiOV9uuu5eWh3gfHxcUe
	 B3XSzq1OMLkLm4AcZ2X50gtBihEIaNtItvtfRv5aV3Yz3Zo2Nl53YnMRlYlTS4uVTD
	 MfF5UQGgWY0AB32+mwiCqPLnXW/CnUcMtg1BN1xJfAZvDrx3JuDUVEquTkOglYnmn0
	 74xE+uQDmHBqZJVZhCmt1EQSS1sGenazgAeudPyIPEcBQa+DaDvd7TE0y2FFZR15dj
	 ZBPLPoEjyr9Zg==
Date: Fri, 28 Jun 2024 08:15:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, =?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v3 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
Message-ID: <20240628081526.66a6b5c6@kernel.org>
In-Reply-To: <20240625172245.233874-1-aconole@redhat.com>
References: <20240625172245.233874-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 13:22:38 -0400 Aaron Conole wrote:
> Currently, if a user wants to run pmtu.sh and cover all the provided test
> cases, they need to install the Open vSwitch userspace utilities.  This
> dependency is difficult for users as well as CI environments, because the
> userspace build and setup may require lots of support and devel packages
> to be installed, system setup to be correct, and things like permissions
> and selinux policies to be properly configured.

Hi Aaron!

I merged this yesterday (with slight alphabetical reshuffling of
the config options). The pmtu.sh test is solid now, which is great!

I also added the OvS tests themselves, and those are not passing, yet:
https://netdev.bots.linux.dev/contest.html?test=openvswitch-sh
Could you take a look and LMK if these are likely env issues or
something bad in the test itself?

