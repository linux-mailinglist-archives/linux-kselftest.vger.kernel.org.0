Return-Path: <linux-kselftest+bounces-21270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0A29B8921
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 03:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3151C2110F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 02:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ACD132132;
	Fri,  1 Nov 2024 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GECURCh+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577AA17C91;
	Fri,  1 Nov 2024 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427141; cv=none; b=Y51xTQMLQH/GbESCOWuGrhA+o3Yh3qzKOg9CUfYcgWkTLFqGEER/jORs/b5Z04KS/DFHjMql0p99EfRbTbOE6R9Gc50GS/Bu1aoNeCnuH1z2xuonX92v40EpGabtGMSLiGZNaXNGFLEHd1iH+uYjYytb7E9yi2Cy1ANNBKXYKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427141; c=relaxed/simple;
	bh=YMMN0kGRmg3R22Sz56LclOIFIQLcsBnPC/LGFhXLclY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njiK6erTOKPjlpgS7CfbUisXT735UbNvurk1xdet21tz4bnHno17Q5K55VDLqFmTxHTLCz3phRxVw1IoLnotly329SKKOXdJbRA4ZZ/A235+tLQv5WQ9Ti88Iasn1cC2x+AJMD0WAL7UPDkhFSG6YoFOpPidTfeTO4Ylj7EeofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GECURCh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090C5C4CEC3;
	Fri,  1 Nov 2024 02:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730427139;
	bh=YMMN0kGRmg3R22Sz56LclOIFIQLcsBnPC/LGFhXLclY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GECURCh+OUkxqRa+boLfm4juiqNbm7Zh6TkvbVbAwpp01+2FtFb7/2EOlVUx+OAai
	 L7fgp2AsPujMebJP4WaMVnxrRDen9wrQhDv7YRPXNGvNdvro+69TiPuzzii/KLISeP
	 XmkwxTnI1vlA8GfI4gR9xMNeQO1d3JQqkzS+uCA6zD8BLmOmwogw4G8SY6B2QP8bUv
	 +xjx9dRRgmcYdRJUMlU7+lDnIEQFpZr9A8MBAHUnrb7Nz4beAc+U2yaCTa1fGlb/ox
	 FHSPPp0JDcV8om7/lb0CWPmMzey/E8hJIb+WP0U2ge90cWgKx4goUXmNBCctHuk60o
	 nmLDJBGJcrUIw==
Date: Thu, 31 Oct 2024 19:12:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, steffen.klassert@secunet.com,
 antony.antony@secunet.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next v11 00/23] Introducing OpenVPN Data Channel
 Offload
Message-ID: <20241031191218.5a90f357@kernel.org>
In-Reply-To: <47b7f78a-0eba-4823-9e2d-2b9d1d2d7cf3@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
	<47b7f78a-0eba-4823-9e2d-2b9d1d2d7cf3@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 11:00:05 +0100 Antonio Quartulli wrote:
> It seems some little changes to ovpn.yaml were not reflected in the 
> generated files I committed.
> 
> Specifically I changed some U32 to BE32 (IPv4 addresses) and files were 
> not regenerated before committing.
> 
> (I saw the failure in patchwork about this)
> 
> It seems I'll have to send v12 after all.

I'll apply patch 1 already, it's tangentially related,
and no point rebasing.

