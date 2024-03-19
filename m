Return-Path: <linux-kselftest+bounces-6412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463B487F679
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 05:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011A1282410
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 04:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A36234CD5;
	Tue, 19 Mar 2024 04:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="dTbGXcN1";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="TkXBWaQr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B08282D6;
	Tue, 19 Mar 2024 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710824031; cv=none; b=drTqft+g2kfUbuoWMQMrnBd3t96VaJvN7dnwwdKrMdfkNrfDxv91N+sndL6vXFfvrLkXuzyNeuqI45Kl8Nsw+3ksd4S6feqcOTYzAXT+hsRgsjzBCleWKBtlsvrkR/5KtKlhNnkqD7lyV/XdzTTl1LKtc09Q+K4Yu09VZDPepk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710824031; c=relaxed/simple;
	bh=zZn7Upq/7Rmu/paLumUmW+plDE5Fu9KZBEeKadc9p4s=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=LYT9l7kTuQY+ihD5vNCGvjklVlFjANr6YnkSwm2YLZyEB7xzRl5gR5EdqIhHyjmjIDXm+QfVw7UfwBn0mDhvREsGJpZel+d/qeR7fZ8665ItCKsg9l7GTZEgK1tmBih2djaAzyje2EA00SMywybmlv9MFclwJszK6pxob2bSCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=dTbGXcN1; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=TkXBWaQr; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 74A9A60189;
	Tue, 19 Mar 2024 05:53:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710824022; bh=zZn7Upq/7Rmu/paLumUmW+plDE5Fu9KZBEeKadc9p4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dTbGXcN1bEuEIgbsvgy/bTxg1CdbyFKc5QrPjaRxZsHYZhT5VAv4vLeMZqE6+vcoI
	 fuSOpIN2lepwx4XhfNdb2ahDeqGcB3RHwgPgZ6un/RRZkmeV5FVLvHDnPb+ssrzpLY
	 c3KakvX1l3zfD0fPjrG/JMRwXeKJDtYTWWRCxdfBdxHIbk2bos/8OD47nAsEXiT+8+
	 5B36Q1KfH1xGM7DKgBJEm92TN/LFQcojFgecCU5RO8NIOXab8CArqTEnNu7q35Ii16
	 yhqeEYDknm59cZzakUNU6DNdjnvULcyP+nFVR9GjnzDkasJGmoA41ZNyAGJ4ba2quT
	 izWqWbosCOmKQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8BQsnKvH-BV2; Tue, 19 Mar 2024 05:53:39 +0100 (CET)
Received: from [192.168.178.20] (dh207-42-61.xnet.hr [88.207.42.61])
	by domac.alu.hr (Postfix) with ESMTPSA id 935F960187;
	Tue, 19 Mar 2024 05:53:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710824019; bh=zZn7Upq/7Rmu/paLumUmW+plDE5Fu9KZBEeKadc9p4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TkXBWaQr8OQPSJN/gqzBvwIdxMJBGRDB22ftH/NIcmNEjsSITwzpTyhQXS/eDJwl+
	 Ud+tpEnEvLjSSxDXQQfgpp4clDXBHMDbe+Ft1Y/HrNswPgv+hOIHSq+24Akt4UPneD
	 iD3CQj4kaxBI+p6DvLsPghcgMd1VtnWhBmiP76qgySMAwUvihnJVHYYv/kqcI2SV+Y
	 /KvhsMZUBwqKrEEMGDQVDFXN95tZSG9ALBBopgDUP7cYYqoHEcW5DXdwkotvBw3LNV
	 +DUu05W5NhEEWvSn9BzraDROWfRQqFFTClfREPMRtRLgQ4+D87CTfznnihO51FVZ01
	 nk5spEs81xyVg==
Content-Type: multipart/mixed; boundary="------------hd9evn7wWYQ8HRfG60L9uekV"
Message-ID: <cf4f320d-f031-4c27-a9c6-8880e32444a0@alu.unizg.hr>
Date: Tue, 19 Mar 2024 05:53:38 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] selftests/net: icmp_redirect.sh: 12 out of 40 test result
 with [FAIL]
To: David Ahern <dsahern@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Po-Hsu Lin <po-hsu.lin@canonical.com>
References: <dfb4b2fa-1728-43f2-ad73-f06145399fc9@alu.unizg.hr>
 <ZfepK3xItcv3ARVV@Laptop-X1> <2b5e831b-baf1-4681-b3b1-b223df07ab83@gmail.com>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2b5e831b-baf1-4681-b3b1-b223df07ab83@gmail.com>

This is a multi-part message in MIME format.
--------------hd9evn7wWYQ8HRfG60L9uekV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/24 15:42, David Ahern wrote:
> On 3/17/24 8:38 PM, Hangbin Liu wrote:
>> Wild guess, the last change of icmp_redirect is my netns update. Maybe
>> there are something default sysctl settings in netns cause the error?
> 
> It is most likely sysctl settings. It would be good to chase those down
> and make sure we have the script setting them.
> 
> Mirsad: What OS are you testing with? That script has a verbose option
> (-v) to get more output like the commands run and pause-on-fail (-p) to
> manually debug at that point.

Hi, David,

I am running an Ubuntu 22.04 LTS box, with the iptools upgraded to iproute2-next
tree of March 15th, on the torvalds tree.

Right now I have tried it against the net-next tree, and I get the same result:

# timeout set to 3600
# selftests: net: icmp_redirect.sh
#
# ###########################################################################
# Legacy routing
# ###########################################################################
#
# TEST: IPv4: redirect exception                                      [FAIL]
# TEST: IPv6: redirect exception                                      [ OK ]
# TEST: IPv4: redirect exception plus mtu                             [FAIL]
# TEST: IPv6: redirect exception plus mtu                             [ OK ]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [FAIL]
# TEST: IPv6: mtu exception plus redirect                             [ OK ]
#
# ###########################################################################
# Legacy routing with VRF
# ###########################################################################
#
# TEST: IPv4: redirect exception                                      [FAIL]
# TEST: IPv6: redirect exception                                      [ OK ]
# TEST: IPv4: redirect exception plus mtu                             [FAIL]
# TEST: IPv6: redirect exception plus mtu                             [ OK ]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [FAIL]
# TEST: IPv6: mtu exception plus redirect                             [ OK ]
#
# ###########################################################################
# Routing with nexthop objects
# ###########################################################################
#
# TEST: IPv4: redirect exception                                      [FAIL]
# TEST: IPv6: redirect exception                                      [ OK ]
# TEST: IPv4: redirect exception plus mtu                             [FAIL]
# TEST: IPv6: redirect exception plus mtu                             [ OK ]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [FAIL]
# TEST: IPv6: mtu exception plus redirect                             [ OK ]
#
# ###########################################################################
# Routing with nexthop objects and VRF
# ###########################################################################
#
# TEST: IPv4: redirect exception                                      [FAIL]
# TEST: IPv6: redirect exception                                      [ OK ]
# TEST: IPv4: redirect exception plus mtu                             [FAIL]
# TEST: IPv6: redirect exception plus mtu                             [ OK ]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [FAIL]
# TEST: IPv6: mtu exception plus redirect                             [ OK ]
#
# Tests passed:  28
# Tests failed:  12
# Tests xfailed:   0
not ok 45 selftests: net: icmp_redirect.sh # exit=1

So, it is probably the sysctl you said, but I cannot tell which one.

My /etc/sysctl.conf looks like this (I think something like Libreswan VPN required these
to be redirects turned off):

#
# /etc/sysctl.conf - Configuration file for setting system variables
# See /etc/sysctl.d/ for additional system variables.
# See sysctl.conf (5) for information.
#

#kernel.domainname = example.com

# Uncomment the following to stop low-level messages on console
#kernel.printk = 3 4 1 3

###################################################################
# Functions previously found in netbase
#

# Uncomment the next two lines to enable Spoof protection (reverse-path filter)
# Turn on Source Address Verification in all interfaces to
# prevent some spoofing attacks
#net.ipv4.conf.default.rp_filter=1
#net.ipv4.conf.all.rp_filter=1

# Uncomment the next line to enable TCP/IP SYN cookies
# See http://lwn.net/Articles/277146/
# Note: This may impact IPv6 TCP sessions too
#net.ipv4.tcp_syncookies=1

# Uncomment the next line to enable packet forwarding for IPv4
net.ipv4.ip_forward=1

# Uncomment the next line to enable packet forwarding for IPv6
#  Enabling this option disables Stateless Address Autoconfiguration
#  based on Router Advertisements for this host
#net.ipv6.conf.all.forwarding=1

net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.all.rp_filter = 0


###################################################################
# Additional settings - these settings can improve the network
# security of the host and prevent against some network attacks
# including spoofing attacks and man in the middle attacks through
# redirection. Some network environments, however, require that these
# settings are disabled so review and enable them as needed.
#
# Do not accept ICMP redirects (prevent MITM attacks)
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
# _or_
# Accept ICMP redirects only for gateways listed in our default
# gateway list (enabled by default)
# net.ipv4.conf.all.secure_redirects = 1
#
# Do not send ICMP redirects (we are not a router)
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.icmp_ignore_bogus_error_responses = 1
#
# Do not accept IP source route packets (we are not a router)
net.ipv4.conf.all.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
#
# Log Martian Packets
net.ipv4.conf.all.log_martians = 0
net.ipv4.conf.default.log_martians = 0
#

###################################################################
# Magic system request Key
# 0=disable, 1=enable all, >1 bitmask of sysrq functions
# See https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html
# for what other values do
#kernel.sysrq=438

Thank you.

Best regards,
Mirsad
--------------hd9evn7wWYQ8HRfG60L9uekV
Content-Type: application/x-xz; name="sysctl-all.conf.xz"
Content-Disposition: attachment; filename="sysctl-all.conf.xz"
Content-Transfer-Encoding: base64

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
scRn+wIAAAAABFla

--------------hd9evn7wWYQ8HRfG60L9uekV--

