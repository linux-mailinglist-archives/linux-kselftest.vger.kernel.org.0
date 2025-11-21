Return-Path: <linux-kselftest+bounces-46247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E49C7A867
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8023A0541
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6B434F49F;
	Fri, 21 Nov 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wG3b5Yw1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FB3491D0;
	Fri, 21 Nov 2025 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738337; cv=none; b=q8G/NzdYZAmFlKshJqDVvAsgKJGuVcXuMoPNSvfmdRxgySWyQIyTQYXxiv009W7CrC4syqI/OoeTuK82AQlK+uw5fN2zJcG+qawDZKc2/hX/MLWBvdKRR5oX3uRapUVo8ae8HoIAHQwmgj9DkiLkLhyGBauGw93K3apfwmsYaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738337; c=relaxed/simple;
	bh=y7oQeRPoffRXu0lHhJODcf++MoBaEO+GN5fcbYqXIYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii5TAMUSZEVwgm8y85j6mjz0Qkj5kWc4qPpq3Fo1dAvzpbW99F97/a1t2GXxerZSHVaCUL3ebSfl6s6nzv4HZeMryO3B6pvZLWCzzOKsumOc+kTaItQ7bMt6bK48jtXwf2TbR+5B76lhTklB92vYR5fZ9NLYvLEID+n/DM6RjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wG3b5Yw1; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3BnDGIBBtu6aiQu1hlvO9exCvMMGHHOsjfJAngsYcSk=; b=wG3b5Yw1Q5LR0hcvx+FKIp/kby
	7EePXmYWeGm4mQFJLDoFM1l4X90pJlYhzI5fIQoIxlmS/7Jlq7p8x3sSF+MomtN9au3SfzVAjX9Lm
	12v7hmBCEZwbJy8G+7zVIjJ+AMyBY+J3htrE+C7boexTm9rtE4wPmvGKYJukJCbOnicZD/ZBves3n
	1gypKs2Pa55f4fYzRUaARk7SFISeiTiSFjogfD9SPPHPwIlqIDtjAqeEktd5T6LNjoBLuGuJX++pz
	t8Oxlae7J7QlsEgiIjbflaq+LiIHty0ZBN3b6lzIayVhLXoD+HUHopbAtVdg3nDbs7wLj9EugNAnT
	+n7JxPrw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vMSuD-000Dvw-3x; Fri, 21 Nov 2025 15:18:37 +0000
Date: Fri, 21 Nov 2025 07:17:33 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: netconsole: ensure required log
 level is set on netcons_basic
Message-ID: <umgmczd42unovrgok26h2iaw3ur3njmcgeodgqjgup3mxwkscn@rbukzn2d6gfi>
References: <20251121-netcons-basic-loglevel-v1-1-577f8586159c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-netcons-basic-loglevel-v1-1-577f8586159c@gmail.com>
X-Debian-User: leitao

On Fri, Nov 21, 2025 at 03:00:22PM +0000, Andre Carvalho wrote:
> This commit ensures that the required log level is set at the start of
> the test iteration.
> 
> Part of the cleanup performed at the end of each test iteration resets
> the log level (do_cleanup in lib_netcons.sh) to the values defined at the
> time test script started. This may cause further test iterations to fail
> if the default values are not sufficient.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

