Return-Path: <linux-kselftest+bounces-16552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F59962A97
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 16:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87EE285228
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 14:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D3C19F464;
	Wed, 28 Aug 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdbJy58m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C55381C2;
	Wed, 28 Aug 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856162; cv=none; b=IEPm3rFgDnHlGbCjs4w+dRIPhNFDwLFHXHp0mLqfzdoolBcWCaDaaUqlXuqWHeF8F8q1aq6hSOay7h7wGJpislCzv64U24NzJIo0rwjPgHZnDU7D0iC1gMr6UYjMoOUxJdJjqlq38cqVDYUArC0hdTeHnRHvqlj2p0g0g6iX7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856162; c=relaxed/simple;
	bh=ZnjUWwzDDWSrIRf/mXzGYXNplU4Fek+1fHvDDLOzt4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKhghAlMDNJdmtbm+hUydsyAEbHG3J5h2F/8/vyCk+1TPWWC0CBNfQ27VZonvKGumCuZkt/pZB0OWUNNK+qbtLCvW/H8C6pVs6alCa7gMAKyklyeEZQozCORnWN7pXHgPe/kczJlRk0kJ8hBQqanPXONrry8hmY+4kX6xi1fyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdbJy58m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F71C4CEC1;
	Wed, 28 Aug 2024 14:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724856162;
	bh=ZnjUWwzDDWSrIRf/mXzGYXNplU4Fek+1fHvDDLOzt4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NdbJy58m8uwzM/Bwm2Y8EsLLcOvQyr1AGo1NGnYrAzu/3wXKn9+VV+ZA7+Z99MBr0
	 mMdZ5hiKKiQW004W643tUczFA/ALbzZwdaC7p4MSBYRP1rORCLhZ2YYQNSSEmSmime
	 OtcB6avyQ1iXCP5AZmx/kCdQMXzq8qHfbdIUQDljk8YGcp5vZllw39Or7XKvguFteP
	 nCdDQr+rXyZIPsuJY4RfnX4UXaJ8qyZd0uMmKeuf5iKIUOmdsStTpc/Ec/ntx1y2bt
	 1t5KRTfET/gkioSguDzJO0vcaFvqLygTatYhZdPBr/Bve32EDeQ+gVcvvjy4Z+Lf42
	 GLNOa2COIcmfw==
Date: Wed, 28 Aug 2024 07:42:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: fw@strlen.de, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef
 Kadlecsik <kadlec@netfilter.org>, David Ahern <dsahern@kernel.org>, Shuah
 Khan <shuah@kernel.org>, rbc@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org (open list:NETFILTER),
 linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: Re: [PATCH nf-next v3 1/2] netfilter: Make IP_NF_IPTABLES_LEGACY
 selectable
Message-ID: <20240828074240.2abaa74c@kernel.org>
In-Reply-To: <20240827145242.3094777-2-leitao@debian.org>
References: <20240827145242.3094777-1-leitao@debian.org>
	<20240827145242.3094777-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 07:52:40 -0700 Breno Leitao wrote:
> +++ b/tools/testing/selftests/net/config

You gotta check all the configs, net is now fine, but bpf still breaks.
There may be more configs we don't use in CI.

BTW I'm not saying anything about the change itself. There's a non-zero
chance that netfilter maintainers made the option hidden on purpose..

