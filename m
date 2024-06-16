Return-Path: <linux-kselftest+bounces-12022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3217909E88
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 18:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9191F21149
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464451AAD7;
	Sun, 16 Jun 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5jtIKFh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EBF168DE;
	Sun, 16 Jun 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718555340; cv=none; b=ihl0rbpSNrONzmIQhLcmOvWvg4T1eQa1Xy0hs0QnsEZI3z9dp/9Hiux6Qns1sbifHnR6m/YMP1cMnv8wEX+iHEw/iME5oOyjLVaElqt4G8iM21KBL6MwTKh1lyuV15m03h9xbkwRox3bQeaHO60DWzJr2p0JCL6lrs6h8OcCMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718555340; c=relaxed/simple;
	bh=AjpkQ1R0cxxcEbQlT5eCZO6aymAJ5tRooRIJfGKtiSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s218B/8fmpeYKCOlnqzhkZQ3iijMljAu0BtiLUeqvLtS8raG/tp56JJw9xIh9NlrIIVa6p2Xr27Gasoma44mCAkMU6NQv6iC/CHsz4qdULqdVqxP4ZOyY96Oz/uPwm6W3O1Fn61wuqKfcDm+Ea0BoDwamxOBu5hc/TTvSjF5JPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5jtIKFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D75C2BBFC;
	Sun, 16 Jun 2024 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718555339;
	bh=AjpkQ1R0cxxcEbQlT5eCZO6aymAJ5tRooRIJfGKtiSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5jtIKFh+ustKUXdinTNaosvn2z2toUyznb/wyqnP0gEVU11BOUp61Y7spF3ZnN+E
	 oQms6Ffv8gX3r/Kt2SgZMssB84clxACWfmxN5wDNahOfYu8d4D5l/2oHqgQ5ndIHxc
	 weuKKHaU8H0kxIeh9LrCac+TjG3bomkHeD8fOK4qcUOhN6sva+ioz7zA4g652uHQ5b
	 p7ujePh/G7iAWGK5z7NOjS/ioJ4j5j1NnGuFC9o1+O3E0K/oGEcCbdp4vazXPO5FS0
	 PiqFsB2Pk36c223Z0yC4Ham4hacZFpp1S3HABW1+PG9nRBGrIuuPFxL486vC6sy2st
	 fzd39KrIOILEA==
Date: Sun, 16 Jun 2024 17:28:55 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kernel@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [RFC net-next 5/7] selftests: openvswitch: Support
 implicit ipv6 arguments.
Message-ID: <20240616162855.GK8447@kernel.org>
References: <20240613181333.984810-1-aconole@redhat.com>
 <20240613181333.984810-6-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613181333.984810-6-aconole@redhat.com>

On Thu, Jun 13, 2024 at 02:13:31PM -0400, Aaron Conole wrote:
> The current iteration of IPv6 support requires explicit fields to be set
> in addition to not properly support the actual IPv6 addresses properly.
> With this change, make it so that the ipv6() bare option is usable to
> create wildcarded flows to match broad swaths of ipv6 traffic.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 43 ++++++++++++-------
>  1 file changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 5545e5cab1d6..2577a06c58cf 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -200,6 +200,19 @@ def convert_ipv4(data):
>  
>      return int(ipaddress.IPv4Address(ip)), int(ipaddress.IPv4Address(mask))
>  
> +def convert_ipv6(data):
> +    ip, _, mask = data.partition('/')
> +
> +    if not ip:
> +        ip = mask = 0
> +    elif not mask:
> +        mask = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
> +    elif mask.isdigit():
> +        mask = ipaddress.IPv6Network("::/" + mask).hostmask
> +
> +    return ipaddress.IPv6Address(ip).packed, ipaddress.IPv6Address(mask).packed
> +
> +

nit: Perhaps one blank line is enough

>  def convert_int(size):
>      def convert_int_sized(data):
>          value, _, mask = data.partition('/')

...

The nit above notwithstanding, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>


