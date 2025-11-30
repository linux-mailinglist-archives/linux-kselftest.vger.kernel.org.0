Return-Path: <linux-kselftest+bounces-46764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6B0C95185
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 16:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A0A634383D
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC827FB37;
	Sun, 30 Nov 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn/G2uxe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD527AC3A;
	Sun, 30 Nov 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764516765; cv=none; b=omiXYt01Kdazh3nM/1UAG+H+MUPJapluBMRgVWAIlETmY6Mc/Ygh95NYcz6fRDckFxoJjfMq/dylDhbx4dqzl+wMEgALStZR+zEoi3kjPYZGosea7sRn7OIXX7tHIhStT/L6kcYdxikQMQ1ufB3qDP4rxQjofkQ9lTKkKOBggjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764516765; c=relaxed/simple;
	bh=/1sIUxqxsoF0Xd4JUcRMS3WV6NsVeNEAUXVY/vhXkhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQCL7WEL1siSUUttlUE48Hfz9WgvztgELA+x3mSXRjNdMz4ri4xmCQrSzrXEYz9Ju6z5D34wNx79s1e/c8c227oxvRjULQVASlgFg77gS7aXnhYBZw3Azl78PmnmWds/JdGXnZz2Q2wTCT/hz32jPtoINNGvoht+Tgk0KxljS+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn/G2uxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2E3C4CEF8;
	Sun, 30 Nov 2025 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764516765;
	bh=/1sIUxqxsoF0Xd4JUcRMS3WV6NsVeNEAUXVY/vhXkhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tn/G2uxeWmE5T22HVwcUb7kPOasopBQOOo2cGMHDLcpnUyVYRpTw+e+kspqGQ+52p
	 AtxX16S1AB+iahvwlnOWGmx3TdJPvh/LLsqowDtGH9RAq0bC+hqfCO8Ato4F0KeCxW
	 utgCIBJYhoQy62k1pj2+QLTvZ0Z+JOSkXCSc4GwmvBhc9CaI/Vk47DzCqu/VdiSVdI
	 ouJX5Pf2aI7LABs0DPrd9OvP7zDfSzi8olBXEVIfkePdnZauInRJg2KnhsKmOKbYaX
	 lbctyHf+6WrdbkzR3DGir/pTaOlL7Mz1QzF6djya+qRKv2fxS3f9lZfhvzaRVjO6pd
	 qXbz8+9REa9pg==
Date: Sun, 30 Nov 2025 15:32:40 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 4/4] Documentation: netconsole: Document
 send_msg configfs attribute
Message-ID: <aSxjmObA4bEluqA0@horms.kernel.org>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
 <20251128-netconsole_send_msg-v1-4-8cca4bbce9bc@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-netconsole_send_msg-v1-4-8cca4bbce9bc@debian.org>

On Fri, Nov 28, 2025 at 06:20:49AM -0800, Breno Leitao wrote:
> Add documentation for the new send_msg configfs attribute that allows
> sending custom messages directly through netconsole targets.
> 
> The documentation covers:
> - How to use the send_msg attribute
> - Key features and requirements
> - Use cases for direct message sending
> - Example of periodic health check implementation
> 
> This feature enables userspace applications to inject custom messages
> into the netconsole stream without going through the kernel's printk
> infrastructure, which is useful for application monitoring, testing,
> and debugging purposes.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


