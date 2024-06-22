Return-Path: <linux-kselftest+bounces-12488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2AE91313A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 03:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F973282D4A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 01:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7371A10F9;
	Sat, 22 Jun 2024 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkDGJsgz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45190652;
	Sat, 22 Jun 2024 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719018088; cv=none; b=fmA73rxOoLeQWCcZZI9iU5SpXKka44wXVIA9CncSbPYEHs/JJzv2X7aZcoG94K7o6SU4o3ysccLHvJaxgc+rpfWm0jgMFriLgwvK8x0S1zygVekHT9uHlCbiNEnHrHC8tr7Zfy+UWZ82v/Vk89x5M1y8TiM5m5D9ekHAI29Eg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719018088; c=relaxed/simple;
	bh=11CUG9L/N6it3dxAYIeTEEPvihpXZm9lMnBasoZMrwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwsC2r4qJp7cA1TXkfM9VJlPQjFJuoPVzmx+Tq1X4SvBoHFRERNGUHNYpG5LXZHxm286YiJjesm9Ccs3y97CUeTNiQREhIHgu3fa+jnrki/tvzAfmdzDX+caCulIMkHssHiHBxAHrl3+5yyoxOmNgHUnERcmav4ROs46ILAzn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkDGJsgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5C8C2BBFC;
	Sat, 22 Jun 2024 01:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719018087;
	bh=11CUG9L/N6it3dxAYIeTEEPvihpXZm9lMnBasoZMrwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XkDGJsgzt4Yz/XcgF3c+cq432157LFDE5AEN6MPlqrO6b2isW/9I7/xQAiPCejueR
	 CiGHQKzGJpsyQmbFbKo5QgnAcwW7rROLNmLlNgUfTad+tHpn6AjBte8KyL637JYise
	 c/p1eFYmGKIKIAcYHr131YrGuniOfMYjB8wEsumNsijNdkEf9TBOr9zLdH8NzGaPLV
	 WfXhHKdk1B1Q6TkZ57srrcl5MX5prDFGOC21ej48+ZMrgIIAur6z4/bFmvdLPcx2V7
	 oTnnIvAJWpZbaEunXs0nOwZMQaF3awY9tmU0wXy0K7xRlbo9cwPdEQBFS9SJs+AXL5
	 yd4ziuVWJY+lg==
Date: Fri, 21 Jun 2024 18:01:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, =?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
Message-ID: <20240621180126.3c40d245@kernel.org>
In-Reply-To: <20240620125601.15755-1-aconole@redhat.com>
References: <20240620125601.15755-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 08:55:54 -0400 Aaron Conole wrote:
> This series enhances the ovs-dpctl utility to provide support for set()
> and tunnel() flow specifiers, better ipv6 handling support, and the
> ability to add tunnel vports, and LWT interfaces.  Finally, it modifies
> the pmtu.sh script to call the ovs-dpctl.py utility rather than the
> typical OVS userspace utilities.

Thanks for the work! 

Looks like the series no longer applies because of other changes
to the kernel config. Before it stopped applying we got some runs,
here's what I see:

https://netdev-3.bots.linux.dev/vmksft-net/results/648440/3-pmtu-sh/stdout

# Cannot find device "ovs_br0"
# TEST: IPv4, OVS vxlan4: PMTU exceptions                             [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv4, OVS vxlan4: PMTU exceptions - nexthop objects           [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv6, OVS vxlan4: PMTU exceptions                             [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv6, OVS vxlan4: PMTU exceptions - nexthop objects           [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv4, OVS vxlan6: PMTU exceptions                             [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv4, OVS vxlan6: PMTU exceptions - nexthop objects           [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv6, OVS vxlan6: PMTU exceptions                             [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv6, OVS vxlan6: PMTU exceptions - nexthop objects           [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv4, OVS geneve4: PMTU exceptions                            [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv4, OVS geneve4: PMTU exceptions - nexthop objects          [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv6, OVS geneve4: PMTU exceptions                            [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv6, OVS geneve4: PMTU exceptions - nexthop objects          [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv4, OVS geneve6: PMTU exceptions                            [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv4, OVS geneve6: PMTU exceptions - nexthop objects          [FAIL]
# Cannot find device "ovs_br0"
# TEST: IPv6, OVS geneve6: PMTU exceptions                            [FAIL]
# Cannot find device "ovs_br0"

Any idea why? Looks like kernel config did include OVS, perhaps we need
explicit modprobe now? I don't see any more details in the logs.

