Return-Path: <linux-kselftest+bounces-21781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6321C9C3E4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 13:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2852A280F1B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2871D19CC0F;
	Mon, 11 Nov 2024 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4ilKO0v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0068C19C56D;
	Mon, 11 Nov 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327376; cv=none; b=Ld2VLXnVrPVxOjToFuD9OPLPzZ/ROqFGK8fDckpsJvGwJtevU8sw0NaRFjvQzpu6qcb9/U8Q35pONXM+mMhClAggExT96FrxcjmkcssGb2zsiSWRHDJZ06WlvV2mj2r0CSYvcZeQqiRqYofnUomBkpF7uh59DhCUeeB1aR3C3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327376; c=relaxed/simple;
	bh=BV7Xn35BMV1jT+4A1sr7uua2vkyzurfFQLo7RPGezh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pReJwmr7AQCorqUIkVTVtzfISDawuq41iXoXyXJ/S4JIlDgQ5KzjHjVPAghbK8Cg45vnjfzZ+3Gaapv5H99BlssIu+fwYyjzEcH9fFI/HnYT+WFDNwY+sUJMrdavwpnzUx5fRc4NAAraE4P3HH0ZL5jtGgwBZACKTopwSmE1h1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4ilKO0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B234C4CED5;
	Mon, 11 Nov 2024 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731327375;
	bh=BV7Xn35BMV1jT+4A1sr7uua2vkyzurfFQLo7RPGezh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4ilKO0v0eoay2cMchWsKbYQXgnW+i843l12asydw9fKw3DbkqIJPOTN4YduOt1pF
	 5N8BFiwvfOtbmUWvOho9KnbsqqfmHG5p4BRfYA5NnNgJ+ZL70xB+AvRSJLq2DfSlaY
	 PwybxqktLyqdkLiSIlrmxVKOKmS+ZW6algaZxTKTc7oR2u3jK0vtnMKC8mrtTRk6Bl
	 9QXJhcaDzMs6Ll+x55JO8us4w6d7RAiliW14ijueGhTjjxvGRaoZlhimNqMKdGbOGp
	 MDddyGLfsLiqeE1yLgiIQWokmeKB7149KDD0v9woCx1XuRUnfP+hQPYbD5rDl3F8AX
	 qxsWyCfEBIZ5Q==
Date: Mon, 11 Nov 2024 12:16:12 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/8] macsec: inherit lower device's TSO limits
 when offloading
Message-ID: <20241111121612.GY4507@kernel.org>
References: <cover.1730929545.git.sd@queasysnail.net>
 <8240c0181e851f169d815f59658a01fb9dfc5073.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8240c0181e851f169d815f59658a01fb9dfc5073.1730929545.git.sd@queasysnail.net>

On Thu, Nov 07, 2024 at 12:13:31AM +0100, Sabrina Dubroca wrote:
> If macsec is offloaded, we need to follow the lower device's
> capabilities, like VLAN devices do.
> 
> Leave the limits unchanged when the offload is disabled.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


