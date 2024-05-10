Return-Path: <linux-kselftest+bounces-10009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C04E8C23B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 13:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04361F26181
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883FB16F0D0;
	Fri, 10 May 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKKX7of/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9F165FDB;
	Fri, 10 May 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341019; cv=none; b=fsGUKMhQFsrUdOLZt7eYBu93Jmb+2HzbWgukGkBS2EiFMxJlAPHj5M0gtZibOi/t8nhdVi8IpQAsvWWp134JskjY9NfJ+hwiQdpwq7psmmL65qvA4d+O1ZlVb9J3UTlljPdXw99MNu/BHSyiDS7oMAW2UwsEoH/W3UtKMgAFmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341019; c=relaxed/simple;
	bh=5z9iBvSKEdgu9Xl5Hny1G4TaDtGgtLK/fL7E2bgJydQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utv0mDP+GKc8c7sBiYDYexdQspj2xFNAciLE/zatvys2zATRJVG067FDB1Sfmkrrku9J2dp+KbdSRHEVEPlNub7E6F4KHssJrn4nEbOMoNsAu+jjM9tvWNhNAki1tUS8V1VhMgI7P248Fv7VVJTC/7VqqjippC/9I9/8iivbgt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKKX7of/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A056C113CC;
	Fri, 10 May 2024 11:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715341018;
	bh=5z9iBvSKEdgu9Xl5Hny1G4TaDtGgtLK/fL7E2bgJydQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKKX7of/ht+MREMXRj7s1k+gk3W3k9hnHsSeGYXFH0989S7Dii8AWlo//k6ucQKTJ
	 ZCafRoqUTRdpSCnSMPtzZ7IqJRydapqfcqaByBY6FpBsyocjig52ATxf3ogzclEkCt
	 m9MjyKgbYVADGz0EZU7Llp5WcoGSky89E/UeociOc+6wdGEpPiGuyGhxwk9806jJrf
	 8WhtrAKzSbaf8PGhokBSz+Om9oCuOYTOk85uNwlY4evZvA79XB3ZOctFexUnq49Z67
	 afpGw+P+6Rls/T7mF6hU9uWBjGGswn29AxyIJ8BVczR4Ch4CypFWxOdiBPjC7oaj/M
	 s+YHJCwIRT/TQ==
Date: Fri, 10 May 2024 12:36:53 +0100
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: epoll_busy_poll: Fix spelling mistake
 "couldnt" -> "couldn't"
Message-ID: <20240510113653.GR2347895@kernel.org>
References: <20240510084811.3299685-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510084811.3299685-1-colin.i.king@gmail.com>

On Fri, May 10, 2024 at 09:48:11AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a TH_LOG message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

