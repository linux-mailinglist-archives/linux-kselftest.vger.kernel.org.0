Return-Path: <linux-kselftest+bounces-40870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B7EB467A8
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 02:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD821C86E12
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 00:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C48139579;
	Sat,  6 Sep 2025 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4dlJ166"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69088315D36;
	Sat,  6 Sep 2025 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757120238; cv=none; b=oZbSbF59ssmljn2dgxr/E07Q2UTrpSv9vMdez9FZ0mrGLcmZfC0pMsMqExNsihMX8Tf2X+ze7mNjcaaLnLPku7CPgtWoHNFwIzJZvPqRPgDuy57TyRYuIldIdbxXiELX3LV4r5VmQcuQYke1wEYtyMSlk4dWSolApXrXdqkzesM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757120238; c=relaxed/simple;
	bh=+sxRfhIdsdoZlB5L4S41jEe1jcrgb7fs6x8au4XainE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moBshDMjdmltVfgvmdKrGxRjTrspC5AZ2wmY67I/xAHl83oNpT7W7JzHscyVqNGZ9bRvxXEafaZicZmquY+nkrZiSK81morK3O6jtBqb87v7j/Nyc7vRbMgs1hUXUTbuzoFtA9LybtOk7lKp4sIj5cbgWB2mwDcrEbGIk7zzlSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4dlJ166; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C38C4CEF1;
	Sat,  6 Sep 2025 00:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757120238;
	bh=+sxRfhIdsdoZlB5L4S41jEe1jcrgb7fs6x8au4XainE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q4dlJ166c3Mc7w9Hm0YH4+cdNBMm3EF+h/LSb5yMzlx+2HGzmNZigeJ/Ob94eUg2i
	 +FVKln9eBdMT6lw6Tz8vKND7MoBptqArhWcgy+qfhFPqagpFTchir6P7QaKmzuPKrp
	 KhEcJda1cRgJAqdWoW6rVITcu+8RNQyd35HaTxAnTzl9atJsxXjBpzM0hxDHfZFn8/
	 5y8h0fDfvWNQEgRb41skSC0h3JyxNvf3vBOkHhGa0lTfuV23m9oj06sbnNWgY7aDof
	 3C0KRlxSTubHdeJ6U03jwmBfP3mM7kleLoLTBRUhZkwv9IfFPmzgYIB/MzC6GzXYtb
	 aqJSz9GAUqn/g==
Date: Fri, 5 Sep 2025 17:57:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Yong Wang <yongwang@nvidia.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>, Andy Roulin
 <aroulin@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Amit Cohen
 <amcohen@nvidia.com>, Alessandro Zanni <alessandro.zanni87@gmail.com>, Li
 Shuang <shuali@redhat.com>, Xin Long <lucien.xin@gmail.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: forwarding: Reorder arguments to
 obey POSIX getopt
Message-ID: <20250905175716.098114bd@kernel.org>
In-Reply-To: <20250905173947.3164807-1-mmyangfl@gmail.com>
References: <20250905173947.3164807-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Sep 2025 01:39:41 +0800 David Yang wrote:
> Quoted from musl wiki:
> 
>   GNU getopt permutes argv to pull options to the front, ahead of
>   non-option arguments. musl and the POSIX standard getopt stop
>   processing options at the first non-option argument with no
>   permutation.
> 
> Thus these scripts stop working on musl since non-option arguments do
> not always come last. Fix it by reordering arguments.

Have you tested this? You seem to be breaking mausezahn.
-- 
pw-bot: cr

