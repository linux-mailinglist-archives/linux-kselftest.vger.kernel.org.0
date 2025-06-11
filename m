Return-Path: <linux-kselftest+bounces-34770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A316AD6127
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10249189785A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8E235BEE;
	Wed, 11 Jun 2025 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFHX9zkH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1B1BD9CE;
	Wed, 11 Jun 2025 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677027; cv=none; b=JYcR9/Ivhv+Yt4x6GEHgR2QZV1SnK+wh9BbDu2rh3kAH1fPSblvb848nw2Q57u6tmi7mmRLtHf1gj7htYpvyJaGyIjt/2t1gu1u7nuYzC0zAZfh+CGg8FUvmSz4k+BOYw1MflGv1qs12Ehgmtd01MwTVBzenHbA+wkCz/A96ENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677027; c=relaxed/simple;
	bh=KwDlr2NcpOH/WfeOqVZYlad0IdNSL1ybFymSn4u6kDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZNv8R6z7hiZGAvhK9mtYbg/iBCRS03R29BHcR8wtvJ4JO2vlGOrfwB2KrTLRd/a6UeqcN1+GRCUVhH1U8ZIfx75wA/l5mtMRIs0kPWlpGwq6zANhna9m9fG45ELKX85hXtH+RrygCWyUZ+3fWNOrw7AhBj2kNVyEjpFJFhvC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFHX9zkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31839C4CEE3;
	Wed, 11 Jun 2025 21:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749677027;
	bh=KwDlr2NcpOH/WfeOqVZYlad0IdNSL1ybFymSn4u6kDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZFHX9zkHacxxUyWFRQDAmVX78eHKBAF+OUfJxyRyZv+E0MdeZ2SmNtfQ/S8CHOD1v
	 GFFWxIU4/eIQ43nEEzDMSb1Rn2UDkeuDC86XeUDCnQE9hY8hqMtCtpX53y5J5ctp9d
	 HpH6FtprjuEK6kVrB7irHRtmTcTUYlEOWRlwtqroDT8ltBrYo0fcV4a6/S4pPm8w2e
	 v54HaxIZGOQV6m52+gZeLwsLyl0nvHstA+P/nnuSpH/Jd8+VVtHTBdQh4OEo/K2W13
	 mH6pROhufqp0CO/zm+EDoz8Q2eWv1WV/Axp8awh5wwTHLSeo7ps/fA/9WjqGw0gGM3
	 2354vrHs+SVww==
Date: Wed, 11 Jun 2025 14:23:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, "Maciej
 =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=" <maze@google.com>, Lorenzo Colitti
 <lorenzo@google.com>
Subject: Re: [PATCH net-next, v2] selftest: Add selftest for multicast
 address notifications
Message-ID: <20250611142346.4c3456f0@kernel.org>
In-Reply-To: <20250610094045.3829667-1-yuyanghuang@google.com>
References: <20250610094045.3829667-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 18:40:45 +0900 Yuyang Huang wrote:
> This commit adds a new kernel selftest to verify RTNLGRP_IPV4_MCADDR
> and RTNLGRP_IPV6_MCADDR notifications. The test works by adding and
> removing a dummy interface and then confirming that the system
> correctly receives join and removal notifications for the 224.0.0.1
> and ff02::1 multicast addresses.
> 
> The test relies on the iproute2 version to be 6.13+.

Thanks for the test. Could you please add it to another (perhaps
a new?) test? rtnetlink is the main configuration interface for 
networking, if we add all test cases that relate to it to a single
file it will quickly become huge.
-- 
pw-bot: cr

