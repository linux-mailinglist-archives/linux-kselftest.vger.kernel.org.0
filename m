Return-Path: <linux-kselftest+bounces-46633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D90C8E0D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 12:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA8F3AA167
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A6E32E128;
	Thu, 27 Nov 2025 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="TTL4FNxn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="th81SrRI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020732D450;
	Thu, 27 Nov 2025 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242997; cv=none; b=d9UFrzBpziK3QsbKQQOgRJ/3hTSBdlazKnmt76zoSXl5c54hlESdlrsYeAaY2jurpBPl7ytzI1v/J4NOXMkLti75dDT9PSgHf6S/BXeMkRATsIzC1j06w3+pAaNBSTdhhaT8xj8pTwqViHPT5ZzcTzzQkwv4ny+EmoZa43hSXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242997; c=relaxed/simple;
	bh=ni6eUbSRNbWSO2UkDBUKrlrMwCDYaUIFArrCsuDA4x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJXNZ2NRYtB3DoOOkVHnHfr/LG/VmyFrs5Q/LHhTzJpFivoVyBCq9phhhFznhK4UpQhTAryriOAUxaGDpDJfw/o5Qn7CH++yWZenGSB+IMhrAZgw1rwQru8/94qXKjkI1gJpQ1npv5G+rUWOSbmLkarvdQEIOsUd19hIxtLLK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=TTL4FNxn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=th81SrRI; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 35B49EC03C0;
	Thu, 27 Nov 2025 06:29:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 27 Nov 2025 06:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764242993; x=
	1764329393; bh=QMKuAR9oXiWSIw/hOTBIm/XyJDjajozFBENz+bR6HlE=; b=T
	TL4FNxnWsntUC/lYgUmzTEm69qVJKS+/DjfqjN8cE2kPJeG1nruzhD7d9fpITy/i
	aAybGNrNwe5Ji4ZceiFViNxM5pMG7gMnNbHnDOLu0Q3IOKgsTpiHEIlNniQleRfU
	QtSbXB8AHtr68wNE32ZSHSP0myfBVXOIoWOG4asEmGBY8M9XG+06GHrcHkcyMCsh
	CUDhIWjRhcFNNfFnwuG4YWE6mhuWsu0qWUJRi3EtTlPAfUCViz74e0Q+1U27Gpoy
	7wIgXd2d9WQ+lyaQMCEVVMYIfgp9L+669S5Q2BvtOaimZxp43tkxVaqt7ARLxV6w
	UAIbeYl1wmULnQJ96hjRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764242993; x=1764329393; bh=QMKuAR9oXiWSIw/hOTBIm/XyJDjajozFBEN
	z+bR6HlE=; b=th81SrRIciB63IQwlOMkOOWbL6XD44jsIJOsWSmhsq1T2GIKqm6
	9+pDcVawoYImrVnSCh1sasZtz0aTEjj0/aLMk0xItfjHX1gexJzpivVeQge5/Qy6
	cHJClr6C1UZnx1IWfUhiwwBldEJyYCGhwuRRbLVlNeA32Rcr+rc19e0QRrwVEvgX
	z9O0ILhWJ1qfXE3EoZuRV4AdrO4IMBpvnEtznIPozXCcKzIC+rb1Z5YNDSxsjBuT
	YvqmRl9kN6FxsKhCALGPl+8rbfShgxtL6gLX+svnWGHuccmSb/bDqrACJGTT16E6
	ctM8wzbckXjtBKUA2U1vJ5H3uZA6mLjiXdg==
X-ME-Sender: <xms:MDYoaXlAOKWxluzZutg6gAcOS27BypvAe07sc3oW1TeOIHMwBTKWqw>
    <xme:MDYoaUKZWSSPbK9a4nDn7ETSUYvxxENaEIlj88L99_yQC0UQg4Ctu_Il2oTmu8xy3
    hTv1XAQ2mg3U_CMnULDEG8wxiV0xOlKLgVQCJL2jmydnJ2HuYmqxrml>
X-ME-Received: <xmr:MDYoaU5cJeWFV9obmM4_hK5hwnLOMNvxYi-O0BN8jv7zGfjBAc3ridBhihXd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeejudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhgrlhhfsehmrghnuggvlhgsihhtrdgtohhmpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:MDYoaQ2A7mx7JbanJ0s2aVlywOBZjHepTcRI44VcdjJPxOTiS5FzOQ>
    <xmx:MDYoaSeqnAiyVHYqF6iRoVWANj4GoKJdhX5Jth942dVhQMx831NZTg>
    <xmx:MDYoaeeAVRipXQA4PZfC214sC66HoBn3wrrD9lqoj811PJNMIh1vhQ>
    <xmx:MDYoaVxIb0AnA87pOrctquLUd_A4-QnNRHdiei6DapKEJZmTNJkPNg>
    <xmx:MTYoaedOrNzoeVrNpgyXLKyZkGgGRMA0HlVTNt1FSUzBP338cmiRRAcH>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 06:29:52 -0500 (EST)
Date: Thu, 27 Nov 2025 12:29:51 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC net-next 11/13] selftests: ovpn: add test for bound device
Message-ID: <aSg2L5eAAEhyHMxM@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
 <20251121002044.16071-12-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121002044.16071-12-antonio@openvpn.net>

2025-11-21, 01:20:42 +0100, Antonio Quartulli wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> Add a selftest to verify that when a socket is bound to a device, UDP
> traffic from ovpn is correctly routed through the specified interface.
> 
> The test sets up a P2P session between two peers in separate network
> namespaces, connected via two veth pairs. It binds to both veth
> interfaces and uses tcpdump to confirm that traffic flows through the
> expected paths.

The current setup doesn't really test that, since it would also work
without SO_BINDTODEVICE (traffic still flows through the expected veth
if I pass "any" instead of veth1/veth2 to the new_peer commands).


[...]
> diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
> index d926413c9f16..c802e4e50054 100644
> --- a/tools/testing/selftests/net/ovpn/common.sh
> +++ b/tools/testing/selftests/net/ovpn/common.sh
> @@ -66,9 +66,11 @@ setup_listener() {
>  }
>  
>  add_peer() {
> +	dev=${2:-"any"}

nit: no user of add_peer is patched to pass this extra argument


> diff --git a/tools/testing/selftests/net/ovpn/test-bind.sh b/tools/testing/selftests/net/ovpn/test-bind.sh
> new file mode 100755
> index 000000000000..fd7c3c8fdf63
> --- /dev/null
> +++ b/tools/testing/selftests/net/ovpn/test-bind.sh
> @@ -0,0 +1,103 @@
[...]
> +run_bind_test() {
> +	dev1=${1}
> +	dev2=${2}
> +	raddr4_peer1=${3}
> +	raddr4_peer2=${4}
> +
> +	touch /tmp/ovpn-bind1.log
> +	touch /tmp/ovpn-bind2.log
> +
> +	ip netns exec peer1 ${OVPN_CLI} del_peer tun1 1 2>/dev/null || true
> +	ip netns exec peer2 ${OVPN_CLI} del_peer tun2 10 2>/dev/null || true
> +
> +	# close any active socket
> +	killall $(basename ${OVPN_CLI}) 2>/dev/null || true
> +
> +	ip netns exec peer1 ${OVPN_CLI} new_peer tun1 ${dev1} 1 10 1 ${raddr4_peer1} 1
> +	ip netns exec peer1 ${OVPN_CLI} new_key tun1 1 1 0 ${ALG} 0 data64.key
> +	ip netns exec peer2 ${OVPN_CLI} new_peer tun2 ${dev2} 10 1 1 ${raddr4_peer2} 1
> +	ip netns exec peer2 ${OVPN_CLI} new_key tun2 10 1 0 ${ALG} 1 data64.key
> +
> +	ip netns exec peer1 ${OVPN_CLI} set_peer tun1 1 60 120
> +	ip netns exec peer2 ${OVPN_CLI} set_peer tun2 10 60 120
> +
> +	timeout 2 ip netns exec peer1 tcpdump -i veth1 "${PROTO,,}" port 1 -n -q > /tmp/ovpn-bind1.log &

Maybe add
2> /dev/null
to clean up a bit the script output?

> +	tcpdump1_pid=$!
> +	timeout 2 ip netns exec peer1 tcpdump -i veth2 "${PROTO,,}" port 1 -n -q > /tmp/ovpn-bind2.log &
> +	tcpdump2_pid=$!
> +	sleep 0.5
> +
> +	ip netns exec peer1 ping -qfc 50 -w 1 5.5.5.2
> +
> +	wait ${tcpdump1_pid} || true
> +	wait ${tcpdump2_pid} || true
> +}
> +
> +run_bind_test veth1 any 10.10.10.2 10.10.10.1
> +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
> +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
> +
> +run_bind_test veth2 any 20.20.20.2 20.20.20.1
> +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
> +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
> +
> +run_bind_test any veth1 10.10.10.2 10.10.10.1
> +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
> +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
> +
> +run_bind_test any veth2 20.20.20.2 20.20.20.1
> +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
> +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
> +
> +cleanup

And also clean up the log files? (maybe via "trap <function> EXIT" so
that they get removed as well if the test fails)

-- 
Sabrina

