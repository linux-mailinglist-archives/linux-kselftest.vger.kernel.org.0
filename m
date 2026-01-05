Return-Path: <linux-kselftest+bounces-48171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAF1CF2166
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 07:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 394D4300FE27
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 06:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042BE2BCF5;
	Mon,  5 Jan 2026 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ahi4+sx0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF27F22097;
	Mon,  5 Jan 2026 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767595059; cv=none; b=uTP97coVDnsogJU/jTnKq6g2rT2i5KK0oT5b3ul5HH2CCc5ppTnSkpwpJ2Xujuy2+qR17rvLRUBPHAlbuxZeYHb2L0AdTuTooTWayQgoTxRwx53tdArtnuP+KIqv2aFu62G4EW/lHqNvp2rMiqf0/65JIw5uaqElGhVsHqRao2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767595059; c=relaxed/simple;
	bh=uKtCeE8JLza4obt2NU7Y+7OY8LjaSIfiEqzyaHz75lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amsvxz9jRGdICH6Zf6PtxRERS6kFAFuUPn/6Lylb+UjAMP6KGgihCuLpUgg+CY23Kx59ZqDpU+lMt88zEl95FiWbxOTTZolzOWV1D6Sn8sbG1GjFix4VhrG39T+cjOqyU+UbrlQTWwRm5ForeHwHqLQ6bQRwKp7rhVPJot6ZT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ahi4+sx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49E5C116D0;
	Mon,  5 Jan 2026 06:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767595059;
	bh=uKtCeE8JLza4obt2NU7Y+7OY8LjaSIfiEqzyaHz75lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahi4+sx0XG/Kpy6u5Y2lyeMGHWQjj7JaQwiY30PljjplShJWWQ/M6IvU6od6O9iTc
	 Hgc7lgwMNTxSQ71jhFaiqq4F0RszUjEVPVH3qSZTjss4V2oFRR/JKFMp2wyxL3s/yx
	 rA0jQDBuNS5aevytFGjyhc4z42yL1WbxlZcaRz94=
Date: Mon, 5 Jan 2026 07:37:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: caojiaqiang 00593155 <caojiaqiang@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, shuah@kernel.org,
	stable@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [5.15.y BACKPORT] selftests: net: test_vxlan_under_vrf: fix HV
 connectivity test
Message-ID: <2026010521-removed-unclasp-f5cd@gregkh>
References: <20260105063805.17044-1-caojiaqiang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105063805.17044-1-caojiaqiang@huawei.com>

On Mon, Jan 05, 2026 at 02:38:05PM +0800, caojiaqiang 00593155 wrote:
> From: Andrea Righi <andrea.righi@canonical.com>
> 
> It looks like test_vxlan_under_vrf.sh is always failing to verify the
> connectivity test during the ping between the two simulated VMs.
> 
> This is due to the fact that veth-hv in each VM should have a distinct
> MAC address.
> 
> Fix by setting a unique MAC address on each simulated VM interface.
> 
> Without this fix:
> 
>  $ sudo ./tools/testing/selftests/net/test_vxlan_under_vrf.sh
>  Checking HV connectivity                                           [ OK ]
>  Check VM connectivity through VXLAN (underlay in the default VRF)  [FAIL]
> 
> With this fix applied:
> 
>  $ sudo ./tools/testing/selftests/net/test_vxlan_under_vrf.sh
>  Checking HV connectivity                                           [ OK ]
>  Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
>  Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
> 
> NOTE: the connectivity test with the underlay VRF is still failing; it
> seems that ARP requests are blocked at the simulated hypervisor level,
> probably due to some missing ARP forwarding rules. This requires more
> investigation (in the meantime we may consider to set that test as
> expected failure - XFAIL).
> 
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Cao Jiaqiang <caojiaqiang@huawei.com>
> ---
>  tools/testing/selftests/net/test_vxlan_under_vrf.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/test_vxlan_under_vrf.sh b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
> index 6fadc8e2f116..1fd1250ebc66 100755
> --- a/tools/testing/selftests/net/test_vxlan_under_vrf.sh
> +++ b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
> @@ -101,6 +101,8 @@ setup-vm() {
>      ip -netns hv-$id link set veth-tap master br0
>      ip -netns hv-$id link set veth-tap up
>  
> +    ip link set veth-hv address 02:1d:8d:dd:0c:6$id
> +
>      ip link set veth-hv netns vm-$id
>      ip -netns vm-$id addr add 10.0.0.$id/24 dev veth-hv
>      ip -netns vm-$id link set veth-hv up
> -- 
> 2.22.0
> 
> 

What is the git commit id of this change in Linus's tree?

thanks,
greg k-h

