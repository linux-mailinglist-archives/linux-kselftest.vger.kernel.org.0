Return-Path: <linux-kselftest+bounces-42083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15700B92A86
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 20:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37923B2D92
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C131A55F;
	Mon, 22 Sep 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFCjiWvF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C1531A553;
	Mon, 22 Sep 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567161; cv=none; b=NxdLoG+56fJkMYMZzp2rzzuqlyvb77g8VzY4vPg/sr7tkGAWzruEAs19A9wYOKhZv2xJdCWDxQqaYP4Ru4CH57m96o5beUcw3DdYDc89bLKw3mBm2Qe2DxaAetUiuNcRx6FhKCU8acLmTfls/Id8bPKsX23sNQlWb9vJ4x9Ipkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567161; c=relaxed/simple;
	bh=zzPDjUd3ZXXbtwbaeNu8cGUP2U9NzJAtLzJgqUtgzkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkG6T5uDqHVfB+VauWKI6+b59i/QH02mg87SomNaA8YFE4wj3XjyjcYgyS+k7q09kHPZqq2dKr2PRmlFH9KKx5k86HRFU+x9C/2Q2U7d3XarL8Om6nuPT+YXz0K2kARs4tTyQ+osJJgRqKSJDw2BXEwU4J0oHN3iWzPd91J5MHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFCjiWvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EA8C4CEF0;
	Mon, 22 Sep 2025 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758567160;
	bh=zzPDjUd3ZXXbtwbaeNu8cGUP2U9NzJAtLzJgqUtgzkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UFCjiWvFdiUb0wZzf+2dUrxNH2q/9TmWe8mLqxDj852L09tSlE5NGMVPG0e/Uy5zh
	 N4enV7X6tpaTfmBlazdRrmJqUgJmqFkeLTR9P65OtGjiLpqhNaHVvWwX0s9Guuwbbl
	 GVOwpADhclbuZVWJX3Yic2USLVVHLgU2Ns7+/J7dQHl/H1zCV1Oemo1zX7ESbbDvRI
	 KyP22d1BoOCE1hyo75YZdqpyxikyvNEyDpOM9IEqhggbfjzBKoeHUlXO19xyx+JkxG
	 8UklWFXYgwIwr1TmyARoRILE5VieYGqcJvghWWMTgDck8LMFjEN3WZncJKBq4tT2YM
	 w7YQ4PrX7iZig==
Date: Mon, 22 Sep 2025 11:52:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] mptcp: pm: netlink: only add server-side
 attr when true
Message-ID: <20250922115239.21e4afaa@kernel.org>
In-Reply-To: <20250919-net-next-mptcp-server-side-flag-v1-1-a97a5d561a8b@kernel.org>
References: <20250919-net-next-mptcp-server-side-flag-v1-0-a97a5d561a8b@kernel.org>
	<20250919-net-next-mptcp-server-side-flag-v1-1-a97a5d561a8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 14:08:58 +0200 Matthieu Baerts (NGI0) wrote:
> This attribute is a boolean. No need to add it to set it to 'false'.
> 
> Indeed, the default value when this attribute is not set is naturally
> 'false'. A few bytes can then be saved by not adding this attribute if
> the connection is not on the server side.
> 
> This prepares the future deprecation of its attribute, in favour of a
> new flag.

Removing attrs from netlink messages is a bit of a gray zone.
If anyone complains we'll have to revert..

