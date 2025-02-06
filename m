Return-Path: <linux-kselftest+bounces-25922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA7EA2A92B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 14:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1FC1679F9
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA2B22E3F8;
	Thu,  6 Feb 2025 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeKkSgdc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5122D4C8;
	Thu,  6 Feb 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847478; cv=none; b=OZEk/YKkpbYaP3XK+RA5Sq2o07C4kGOMjVaMVItUbT2/QT3PetNlIut7b9PoZD0QLYHoizZn9FK6isQ3M+tj/CPM48VquyqOQB4hgqkQ0QgzXek5rv2mHKb5wzOswyj/S6i/KhXI4aqTwp3V6cZAdJUQWf7TnCgStg2Cw+BNW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847478; c=relaxed/simple;
	bh=ybQDpWto7Ts5raVIcAX6NSYDyWqx0RU1mx56olGlWVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpNbgbrhHlcW6e3Gp3r1JTalokYq/XnDTj8XsivRDl7zv7qYCdxK+HbJIVEWhmt1tuAcPqQZ+kqO6htrPEesTocCXHVX6l1EX+0d9nPLB6ywMGv53LBYD/UbEMp+A3ILWp+mM4OucVtujfNMBbP8dhBJx3SA3Hxl5znsFjzX/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeKkSgdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DCDC4CEDD;
	Thu,  6 Feb 2025 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738847477;
	bh=ybQDpWto7Ts5raVIcAX6NSYDyWqx0RU1mx56olGlWVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XeKkSgdco0CPCvU4KIobj+XZUy7KmihX5/lYiFbshT2tb313tp2QuCu4Vwcll7l+i
	 Lbn+HcAQgkkEMOtjGeYR+tvoEAIN7b9tvDsERaRSIBbg8hXxfakG2QSuYUkY3NuLv2
	 225rJmRK2hsYyw1MtcHIiIK4dwmx1dvWCeSBGFaD2oiFRk3OZa5sSykxZ+l0i+L3z5
	 uHnJrq9qg8folZgmUV0O6sVSz4iPvwl+COjOwtywyRmp6lU5DCFDboOkEhqt7jQMYo
	 k+0Zvz9iYE1YnVNmV8Qo/D0/661IteSQo2xKaKPppubnyVxu6I103lMbA67liH5EtF
	 zaaDtZP/lKYCw==
Date: Thu, 6 Feb 2025 13:11:13 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v4 11/17] net: pktgen: remove some superfluous
 variable initializing
Message-ID: <20250206131113.GR554665@kernel.org>
References: <20250205131153.476278-1-ps.report@gmx.net>
 <20250205131153.476278-12-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205131153.476278-12-ps.report@gmx.net>

On Wed, Feb 05, 2025 at 02:11:47PM +0100, Peter Seiderer wrote:
> Remove some superfluous variable initializing before hex32_arg call (as the
> same init is done here already).
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>

