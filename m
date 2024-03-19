Return-Path: <linux-kselftest+bounces-6415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1917287F689
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 06:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C51F223CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 05:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F140853;
	Tue, 19 Mar 2024 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="KHApn1sA";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="RAxickzH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E03E493;
	Tue, 19 Mar 2024 05:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710824727; cv=none; b=oo+IyLxPxPd+CTKHttXhAziLSAhCHFlKohQcggqWlwxFhM3cMtl/ANVuTTJMc7Pgz30V7owNDzg31htim/KBbLcoNdFR+NVAr7Tj3kC0EHXAKyrt+DC0P0/WLdm7efQMpq3u+5cYu6Pt6fEU0IIXHru50m/Hkm7ob5NwViEKGgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710824727; c=relaxed/simple;
	bh=V/h/2UB0ye7BWG+rglcMzEJz+D10kE0Rqav85M1zd2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bs2F2HMEVZ+LyIDDp9WNWIp98aJ2aUKVjJ/8xBJXX2k2C6AOaALX0nqnZKGXwz5qG9MKETKXIRmTVoIVJIutfIIkq5n3QgEYU9xU2AX8T85Eiljm7wLEHoe+6o0wWHn1SuIkf0S2vcUgqSmdCYvByvfiIA7AMOx0+lcjTfperlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=KHApn1sA; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=RAxickzH; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id A577460189;
	Tue, 19 Mar 2024 06:05:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710824719; bh=V/h/2UB0ye7BWG+rglcMzEJz+D10kE0Rqav85M1zd2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KHApn1sAVDE4b1E53M5bIOvB0yq8xfj9FrlV9DZZYyeuCungdL6RKR+tRilTVQqaH
	 3ke6dVDldj4xFvaKjH+nBDOOuK1OznP64GBV3Y+uSDpcsQ/+a+6j1vjdbvDpvFiK1x
	 X4eyRgnTSOzpQCjuF3tloPgcCoTiVQuLAWC47xXJgGNj8AWfNvYiXfjZFN6vRT6UOp
	 r5/wAfJTlCQGnmAcPjQx7nJ2AQWprrg6gl4asbgAaqroVXi7sT8GEr0FzpPWErIXHb
	 qZeqZw+qy0ELkwKVtCK716m0wicNXbXymTBz/mbTQUD8LBWhnL/wrHISzULuKJN+qC
	 u7VkjtieFTVPw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dLD-WYm40Yxa; Tue, 19 Mar 2024 06:05:16 +0100 (CET)
Received: from [192.168.178.20] (dh207-42-61.xnet.hr [88.207.42.61])
	by domac.alu.hr (Postfix) with ESMTPSA id 8CAC160187;
	Tue, 19 Mar 2024 06:05:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710824716; bh=V/h/2UB0ye7BWG+rglcMzEJz+D10kE0Rqav85M1zd2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RAxickzHwyPhmxuoSY7awkoZ6Lwe8VGbmUY/RI3xY72oKjPIzgOGjXCGvvK3euh78
	 rJQ2a68GJHsXE+WkWZsZy1eeRvTTG6d8aNtTKiEx5YCFUzdWmPQtP1V+wtJraCFhkO
	 0i6hN2xsba4sNLHVvBxKH1pkDDcERVR7TcACgeydCzOjaC+bWPsh6ge8oUgPPRAqhT
	 fjnoXdIC1DbW9eVWXO163t5jh8skeMm4LUsscdZ2RI86aJ0+VI7qULDunRXW425QK5
	 iAOfqvH/hpTBmUPjS2EuZQS1hW5ldJj7+0YfFHN+7mK0wYduncoX5W3y+Clmwfa3S9
	 BXttHkPRytfyw==
Message-ID: <f005453c-c7cf-4e1d-b266-ffe1cf8fc79e@alu.unizg.hr>
Date: Tue, 19 Mar 2024 06:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] selftests/net: test_vxlan_mdb.sh: 84 out of 642 tests
 [FAIL]
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>
References: <5bb50349-196d-4892-8ed2-f37543aa863f@alu.unizg.hr>
 <Zfe2cGv_EWFAZXAJ@Laptop-X1>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Zfe2cGv_EWFAZXAJ@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/24 04:35, Hangbin Liu wrote:
> On Sun, Mar 17, 2024 at 12:19:12AM +0100, Mirsad Todorovac wrote:
>> Hi,
>>
>> While running kselftest on vanilla torvalds tree kernel commit v6.8-11167-g4438a810f396,
>> the test suite reported a number of errors.
>>
>> I was using the latest iproute2-next suite on an Ubuntu 22.04 LTS box.
>>
>> # Tests passed: 558
>> # Tests failed:  84
>> not ok 90 selftests: net: test_vxlan_mdb.sh # exit=1
> 
> FYI, I tested with 6.8 kernel with net tree. All passed.
> 
> Data path: MDB torture test - IPv6 overlay / IPv6 underlay
> ----------------------------------------------------------
> TEST: Torture test                                                  [ OK ]
> 
> Tests passed: 642
> Tests failed:   0
> 
> # uname -r
> 6.8.0-virtme
> 
> Thanks
> Hangbin

Hi, Hangbin,

I am running an Ubuntu 22.04 LTS configuration.

I tried it again with 6.8.0-net-next-05204-g237bb5f7f7f5 and iproute2-next
from this repo: https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

RESULTS:

# Data path: MDB torture test - IPv6 overlay / IPv6 underlay
# ----------------------------------------------------------
# TEST: Torture test                                                  [ OK ]
#
# Tests passed: 558
# Tests failed:  84
not ok 90 selftests: net: test_vxlan_mdb.sh # exit=1

David said there may be something in sysctl.conf:

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

Best regards,
Mirsad

