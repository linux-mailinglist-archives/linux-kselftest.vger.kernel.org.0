Return-Path: <linux-kselftest+bounces-21593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC969BFFDE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 09:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D59283C30
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398AF1D63F1;
	Thu,  7 Nov 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="FIcGb/bO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE118754F;
	Thu,  7 Nov 2024 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730967792; cv=none; b=ZzytUUwaKCJcIb0Ib3dufAgHy1b6V/DCNhvhwFGD9RfiuZXrlkFl8bhGP4BFVMKft6L7ZsWS28PiaaR9BhdlM7gLqX2pH+ZPvqsWLgu3tO+BCD21WB5r7+YN+LhCStHEbDBTDnciY8EJPSGt7MCbb6cvXcW6fNsCgSOPrtEld10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730967792; c=relaxed/simple;
	bh=Q2GSmVIISTS2anK4abVbSWAkn8WydlilysNNoztLfTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edkHSa4D+kGmqOpROpbUzh0WqQ1jmrax9wyXXSxRSZ0fS6x5QuwcVun05RnJ0GEL1651rxt2fJPjArIkgh/2P0QJnvRms28HMbcDE9dxkAuNXSkozgDZW+gEFELgCh5t3bCOs+f/QR3zDTAewCt/Oui/unn/mSh+OnlIuonMsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=FIcGb/bO; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=M/3rlViT9D+L9ncSWn/0ufpEXuzN61pptP4kPOAdcPw=; b=FIcGb/bOLHOj6ThuUTFYD8+Fqa
	Vk9oPPYaWZ87+u6pui+N/daP9ZApO6BmSkH6KhvuOZH1++/hMzbVkLi7PM1J4vxOWXTwIEqPyMj8q
	yJ9LDjIywQ9xEv+PN1cjIcuvwC4c8+Gp717OUrE/hbrNrS0HNgNwM7GNh5TJMpgjG6HAEKxuSOtgW
	LnOa476D9WYCETQAV19j3Jtwc4UAh3GKIg9t+B2YlFyMpGTvwd+P8DV0qelR59o3S9LRDrsGr0xc1
	FgOpQsBIbPU9iiXWLBtNjUI+XhLS6qxrrkKL9Avkz3ATLRV2ZyNzMq0v0nUwgMXGUui98qznHnlRJ
	E3V08nCQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1t8xnE-000000003Lz-2FDx;
	Thu, 07 Nov 2024 09:23:04 +0100
Date: Thu, 7 Nov 2024 09:23:04 +0100
From: Phil Sutter <phil@nwl.cc>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: wireguards: use nft by default
Message-ID: <Zyx46O0qLtXAs80X@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241107025438.3766-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107025438.3766-1-liuhangbin@gmail.com>

Hi Liu Hangbin,

On Thu, Nov 07, 2024 at 02:54:38AM +0000, Hangbin Liu wrote:
> Use nft by default if it's supported, as nft is the replacement for iptables,
> which is used by default in some releases. Additionally, iptables is dropped
> in some releases.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> CC nft developers to see if there are any easier configurations,
> as I'm not very familiar with nft commands.

Basically looks good, just a few minor remarks:

> ---
>  tools/testing/selftests/wireguard/netns.sh | 63 ++++++++++++++++++----
>  1 file changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
> index 405ff262ca93..4e29c1a7003c 100755
> --- a/tools/testing/selftests/wireguard/netns.sh
> +++ b/tools/testing/selftests/wireguard/netns.sh
> @@ -44,6 +44,7 @@ sleep() { read -t "$1" -N 1 || true; }
>  waitiperf() { pretty "${1//*-}" "wait for iperf:${3:-5201} pid $2"; while [[ $(ss -N "$1" -tlpH "sport = ${3:-5201}") != *\"iperf3\",pid=$2,fd=* ]]; do sleep 0.1; done; }
>  waitncatudp() { pretty "${1//*-}" "wait for udp:1111 pid $2"; while [[ $(ss -N "$1" -ulpH 'sport = 1111') != *\"ncat\",pid=$2,fd=* ]]; do sleep 0.1; done; }
>  waitiface() { pretty "${1//*-}" "wait for $2 to come up"; ip netns exec "$1" bash -c "while [[ \$(< \"/sys/class/net/$2/operstate\") != up ]]; do read -t .1 -N 0 || true; done;"; }
> +use_nft() { nft --version &> /dev/null; }
>  
>  cleanup() {
>  	set +e
> @@ -196,13 +197,23 @@ ip1 link set wg0 mtu 1300
>  ip2 link set wg0 mtu 1300
>  n1 wg set wg0 peer "$pub2" endpoint 127.0.0.1:2
>  n2 wg set wg0 peer "$pub1" endpoint 127.0.0.1:1
> -n0 iptables -A INPUT -m length --length 1360 -j DROP
> +if use_nft; then
> +	n0 nft add table inet filter

Using inet family captures IPv6 traffic, too. You don't seem to
explicitly configure it, but the usual auto-config traffic may offset
rule counters. If you care about such side-effects, you may want to use
ip family instead.

Tables are family-specific, but generic otherwise. So you could add a
table for testing in each netns up front:

| if use_nft; then
| 	n0 nft add table ip wgtest
| 	n1 nft add table ip wgtest
| 	n2 nft add table ip wgtest
| fi

> +	n0 nft add chain inet filter INPUT { type filter hook input priority filter \; policy accept \; }
> +	n0 nft add rule inet filter INPUT meta length 1360 counter drop
> +else
> +	n0 iptables -A INPUT -m length --length 1360 -j DROP
> +fi
>  n1 ip route add 192.168.241.2/32 dev wg0 mtu 1299
>  n2 ip route add 192.168.241.1/32 dev wg0 mtu 1299
>  n2 ping -c 1 -W 1 -s 1269 192.168.241.1
>  n2 ip route delete 192.168.241.1/32 dev wg0 mtu 1299
>  n1 ip route delete 192.168.241.2/32 dev wg0 mtu 1299
> -n0 iptables -F INPUT
> +if use_nft; then
> +	n0 nft delete table inet filter

Here just flush the table (drops only the rules):

| n0 nft flush table ip wgtest

Cheers, Phil

