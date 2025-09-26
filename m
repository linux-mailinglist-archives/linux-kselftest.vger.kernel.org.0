Return-Path: <linux-kselftest+bounces-42470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FABBBA3FBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABED33AFA99
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA4C2FB08F;
	Fri, 26 Sep 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ/YDxsK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8E155C97;
	Fri, 26 Sep 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894842; cv=none; b=s6uouUfpUk/9n8/gRv5Po/9Iiv4I6Afn1oG/i5VCTagZ8RdyOlFdeN+S/vie40VRIqnBIUL/J7bdSpHSEBh0oZGBFNdMwjdraKaeebYthNgcCIH9GkDULmFkziplJ7xOmB9mti2Kope2wGlSe1L0B3YuSh74I9cWfApLnn0UR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894842; c=relaxed/simple;
	bh=BMpYSNDUXl280WlvWVXfxBQPAyVBZcXaOcysZF/yMFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POo13rL9rBANHx+kpT0OYFUlX3Q7xnb3qIZ6ZyVPI0Z9B6fS+J2CJT6PmDVNcTOaP4XeiL6QIApy5uZmG0HNGUWVMjDpZBErgA+HB17VzVC1elPcq/7pZbDKuxINAT8m8WC9BHcVm7qDjnHVacZVR5hFekaOmPSuN/RtxtDcp9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ/YDxsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34C6C116D0;
	Fri, 26 Sep 2025 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894841;
	bh=BMpYSNDUXl280WlvWVXfxBQPAyVBZcXaOcysZF/yMFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZ/YDxsKiLXAuUx+UQCDc9x0heZ8tAEY4UlUBBdhHqIQLhqS4jzN48pXunesfnbDU
	 1h5OHCNb9JF69PmGbDIRruo/cdozS+OfLOloEvTHeJBViMOJUQHPqyTNQD0+sg6HZa
	 K3fRZSDdW+9ejLvUepwsqcv1FgIdNlkpa3GZydpyszpckpufTt97O+J7FqLRuqRrh+
	 v1cheK1q/xW62i0GmG9rtwnoUJGuOK7Ylmo2J4lWqI441MIEzB69xv0lWUZBQYE40e
	 4W6Buv8aqOz2XqYsraheohjsBimofSCA7YVxJdZk0lfQemgTwYGABbrE8e4Pit/o5D
	 Qhv5C/09SHY5g==
Date: Fri, 26 Sep 2025 14:53:56 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 01/13] selftests: net: lib: Rename ip_link_add()
 to adf_*
Message-ID: <aNaa9GnRPoEkwePj@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <0b163cca1bf2ec44270e0fc89108f488d99d9c9d.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b163cca1bf2ec44270e0fc89108f488d99d9c9d.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:44PM +0200, Petr Machata wrote:
> Rename this function to mark it as autodefer.
> For details, see the discussion in the cover letter.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

