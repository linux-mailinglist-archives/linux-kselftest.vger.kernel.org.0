Return-Path: <linux-kselftest+bounces-29436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AF5A693C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 16:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A247A7A8C2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175BE1D7E41;
	Wed, 19 Mar 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1U06T0G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3171D54D6;
	Wed, 19 Mar 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398857; cv=none; b=P/t8nlhy1nGRGuaDlEJnJIfPzVpAXh3bfyO5Ok9wxmX6sO+Eq7SeEMRg+XDQgOAnCTWtzU/GtUHYltjGauQdpnn46emj466nDPOQwYVWkdVhvvQWVPX4JyTwT3Mx8lznxarfu0YPn0q4HeOKMKg6dWHs+xGoUzfpyhHpQ4aqOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398857; c=relaxed/simple;
	bh=t7182vdIDgs+oikEeLBlWsg0xS2dFudd982pDffPAbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOve1T4L7LcyNIps4gzE/Z20TKIApc6/HNJFJHlK8h/8dZekWfH+uVyKEOZDJgmVTCBt/itVxJpZk2g4MgZ+TkhDQHiujVgELlBJWcOyeKCWoGYKoN9Q+Gt0nHzhrakphPn5/vss9BsTYFHT1TRTofh8vTyl/vGh/1QrFaZa064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1U06T0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BD6C4CEE4;
	Wed, 19 Mar 2025 15:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398856;
	bh=t7182vdIDgs+oikEeLBlWsg0xS2dFudd982pDffPAbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1U06T0GcQIcQ+B7fYVGB4O2hDuYgmh9vr4Vw97z/8XCKdlvsCskEqxWwNk7fCbXZ
	 d/Q/hNdrAllWB4yAbUjFReWVk9uj2qMmK4YmuYSaVzqPdpWW7G0SQaCHxJwBtz0pfZ
	 itnyxx/h0QaVF5Dwc/hibhPXIo8t27Zh72dyTCLSUG9xDj+aliC7Zg/ihCd1fcm2sK
	 DkdndfXC2mk/1uwJf0vuwOv4eNlAnZIkTO5xynp4Ed0VeFYgZYsdF/uOXky3VWZCT9
	 Q7DNUc6w/NPPfuvZDHsyPqBvePGMb4aYoL1PyWxyxBfRH4Ie6/k4YvCT8RI0mk2/Ge
	 BAXsrDQ1ayv7g==
Date: Wed, 19 Mar 2025 15:40:48 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/6] netconsole: implement configfs for
 release_enabled
Message-ID: <20250319154048.GG768132@kernel.org>
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
 <20250314-netcons_release-v1-2-07979c4b86af@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-netcons_release-v1-2-07979c4b86af@debian.org>

On Fri, Mar 14, 2025 at 10:58:46AM -0700, Breno Leitao wrote:
> Implement the configfs helpers to show and set release_enabled configfs
> directories under userdata.
> 
> When enabled, set the feature bit in netconsole_target->sysdata_fields.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


