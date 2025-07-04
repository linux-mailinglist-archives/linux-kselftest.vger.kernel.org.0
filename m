Return-Path: <linux-kselftest+bounces-36572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036F5AF94AC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A4D4A5B40
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7A309A5D;
	Fri,  4 Jul 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAmjcb7v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042743093DF;
	Fri,  4 Jul 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637044; cv=none; b=ePplMWJbHfMtizn9bCb1tDjx7P5uuA2SkW79QgBf/pFmZ8oZbC+G3rEktaQ7ivZoKIoYD0ZJhFahrYtxsnVfmudfd2GMEjr/7xQG/KdAKOTZI5Z3EpIJ92me2q0K3t8+E17WdzEsFBE3Hhr0tuXBX+IiiYrt6oDi5hskQDES7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637044; c=relaxed/simple;
	bh=03hm6Sl4iIRxFgfLxGYiEA4dHv+1WF4qqCJ3ZpbG5QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDF5a0bRFEo/6Ae/ApDumBf7hrdALreCe6cuyhIOVwPiWLyfvLD1lBdtDR+l+e0JOcxWrd0fTBM9K1kzXBWgkR//t4h6fxLcSgq1V9lqcXj1SoMG2s/NqUl9X+AmS58Er8ZeHMmK7hDkf+BQTT9xZ4CYWf+TmNFIytElW8g2RII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAmjcb7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AF1C4CEEB;
	Fri,  4 Jul 2025 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637043;
	bh=03hm6Sl4iIRxFgfLxGYiEA4dHv+1WF4qqCJ3ZpbG5QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAmjcb7vcyf0JwZjTkhsVpbsZSDya2mTo0kEtu7csJo60VFvT0vzK3DQ6LxRg+x6Z
	 6Vt+kxEEuw0nJeqnxsJBkyOq8KhzQ0t6loPAAT7aDPyexZH9xYdi2xhAV8ybWNFnX1
	 9ZMNOQW/XA/Je0ezzXOjP8tP3ovAGvhOADSLfLy31zb+rPJaRRPAHY/LTU2yXQTiLz
	 BV0OI195bUmSDgSmvKnlueuxWxW1RRPJK9ci5kj/jA87zra2u3bkfM9mWuDMk9V+o9
	 nCvR4zlt9gLV2EBHtyyR8Dw+CDmU05p8w/UYauSGyvcNAY5MNj2GwH7GH6Ws7YhVGa
	 uvFgFEE7NFrAA==
Date: Fri, 4 Jul 2025 14:50:38 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/7] netpoll: factor out IPv6 header setup
 into push_ipv6() helper
Message-ID: <20250704135038.GQ41770@horms.kernel.org>
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
 <20250702-netpoll_untagle_ip-v2-3-13cf3db24e2b@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-netpoll_untagle_ip-v2-3-13cf3db24e2b@debian.org>

On Wed, Jul 02, 2025 at 03:06:35AM -0700, Breno Leitao wrote:
> Move IPv6 header construction from netpoll_send_udp() into a new
> static helper function, push_ipv6(). This refactoring reduces code
> duplication and improves readability in netpoll_send_udp().
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


