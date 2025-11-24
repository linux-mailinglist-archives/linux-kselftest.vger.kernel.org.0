Return-Path: <linux-kselftest+bounces-46369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD01C7FB8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 10:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2CD3A37E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3E2F9DA0;
	Mon, 24 Nov 2025 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CMIHuwnK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A22F616D;
	Mon, 24 Nov 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977810; cv=none; b=MdsHcg9FqFoAQdBRpV46V7cCY5IWJfWLKSwvyUom7lz3NM2XbUfGMK6Cm1Uafp4hJRP4t4RoiFQGCmPTgr5JWjsSRQma3QatEM96xBKnLCiHRr+0W625j2m48o/OuMFtDh5VsPzJpo3STH0TFljFeqVNdquuZYRgJj04t+Sw5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977810; c=relaxed/simple;
	bh=LxZgI/BgCV+x/kbUkQfquUDOFuD0bqEglFSAAPLuAS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs4RIdpRRs9XViRakgZizekbkROkwA5d8UyvFt1VizBF8p00cXcDuFpt0uX3YQpgjeJY3C2JcuO2djDdYLeWKBKLoKJ+8INmhnvi0ub9jq5GSjsagEyYeAJdDdH+pDn4I/ilF+MuBI1gd5z4XMMC2wYpskvM1CQ4E3PsuJ1hc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CMIHuwnK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iMHZA1AlgY9oU6CksOkiIy54t23xFkA+7gXdOleZJoU=; b=CMIHuwnKwOq/HY4qa7OGfnmuv1
	gK6uF9yDNUajgcjm9hFh+hmDa5V1WJh8GL+w8uDCUts8sqEp3b6iplHMNqg35N3MCAruVWPQK/QXM
	sPbxZ8i8FQIViMCZ5p9s8WtzWpmuiIhVE95QTiKF372mgq8lNm/EOR0znPzI4RbY1+PvBomm70l8r
	jLTPcbfXxRj9GkffXUKkcOtqCo14OITA06zBpZNKQJskee4BlK0UG94TqfgVyyLpxl6pqdkQkw5S1
	CnvausftrM5Y6CiNag9qiAVtfmvRl3z7JSVlb+vAt3XObqqNJwtO7WBPxIKYoO7MGJe1kPzXET7ny
	3HorODow==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vNTCo-002Utc-U8; Mon, 24 Nov 2025 09:49:59 +0000
Date: Mon, 24 Nov 2025 01:49:53 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/5] selftests: netconsole: validate target
 resume
Message-ID: <fsvnxeiiemxgwxlnfljzfocfzu343u4zoxfeglkgcdddgbvgjz@4u42evesbxmt>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
 <20251121-netcons-retrigger-v6-5-9c03f5a2bd6f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-netcons-retrigger-v6-5-9c03f5a2bd6f@gmail.com>
X-Debian-User: leitao

On Fri, Nov 21, 2025 at 12:49:04PM +0000, Andre Carvalho wrote:
> Introduce a new netconsole selftest to validate that netconsole is able
> to resume a deactivated target when the low level interface comes back.
> 
> The test setups the network using netdevsim, creates a netconsole target
> and then remove/add netdevsim in order to bring the same interfaces
> back. Afterwards, the test validates that the target works as expected.
> 
> Targets are created via cmdline parameters to the module to ensure that
> we are able to resume targets that were bound by mac and interface name.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

