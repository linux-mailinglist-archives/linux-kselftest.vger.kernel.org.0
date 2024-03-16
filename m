Return-Path: <linux-kselftest+bounces-6375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7EA87DBE0
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Mar 2024 00:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC5B1F213EC
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Mar 2024 23:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854481C2A1;
	Sat, 16 Mar 2024 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="AgukHK8g";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="h48abKKo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F871CA89;
	Sat, 16 Mar 2024 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710630017; cv=none; b=i1ZVXJQd7xZVV9iO/xmfxutTmNBEdjaYiDbskxa6cmX92IRlMEhQaHmogbo5SZU2gIPHMYmQTahejaXWpGXKtFHmZrL20mKQwr2kWE+6We6/gzIcuAEAP02LVTicXGO8lh0tO7SfBjtmfpp851qEnZrAVomMxuN7/w9vor3sFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710630017; c=relaxed/simple;
	bh=7sSSt5Yz0idkMqXTZc75pIzHjJubIjqTNnybg7IV4GU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XJYVSZSRRv/xDirtKjd/i/SiAu03oxUoNvGoF2GJA548DbJBT0NJQRUgsW61EEKGSbc7nWVcExVNsI8fe2xgA40Ov90NQtZ4BLN9Pj4aR4eBGmGsfB3b42Q2UXik6527JpPTQ29spdCXA1Ajg/Q5HoaoJqmV+t7fpxvcA82B7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=AgukHK8g; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=h48abKKo; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 90FC560197;
	Sun, 17 Mar 2024 00:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710630002; bh=7sSSt5Yz0idkMqXTZc75pIzHjJubIjqTNnybg7IV4GU=;
	h=Date:To:Cc:From:Subject:From;
	b=AgukHK8ghARO0YNBzK9tbznjlmq+M4Do/P9fz0+CYwLP9+4jPojkZxYKHco0HAn8J
	 qoE9XTMxYNfHyiAu3z2RFpaJ3XwQAe6g3U/GDfJ+GYM8o7kVKfjzwyteEuS4Y1A6Yj
	 GCQG8yX47OTl6cyujngfTAaMFvY6xnOBY4TWTmA4Wyie35uBdRGaaitK+yvEeX4oFj
	 bspeTmKG4+MGgxhZEoBT/Z5hJNkHjZfQLaVFHcJBJkV/mJJ2I8MQa8Dt2Y/yFwP/k+
	 XfpxsLArBmh3Qoui0GBXYVY9WJm3+uYkvsqaneispT7QN5HNIqI/G/zExFm8j/k2zP
	 tviycT1yM6sgA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ymcr31toCm2y; Sun, 17 Mar 2024 00:00:00 +0100 (CET)
Received: from [192.168.178.20] (dh207-43-170.xnet.hr [88.207.43.170])
	by domac.alu.hr (Postfix) with ESMTPSA id 872096017E;
	Sat, 16 Mar 2024 23:59:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710630000; bh=7sSSt5Yz0idkMqXTZc75pIzHjJubIjqTNnybg7IV4GU=;
	h=Date:To:Cc:From:Subject:From;
	b=h48abKKoGx7zd9TR50o6PBQ3N/0Y4co+FQgfuerlK3ZJHQK97kQhmeIdYW0IfY5ai
	 RDHPCuGrJ5L0NJrcmeeMCYF6j7icEGjfvuBdsENHHnfu7ZNVQk80KS4BDA7J48vjOt
	 e1EQ4UipKgmBajmyjqUnYBIp8/2ycqaMkqEhTdo8SaTdMAVcNnQEGQKZKJNTYXuTkz
	 vX/2usfO83W9GhxMK2yQqkBdoPZkHAIuJxGqGKYeaS0/SYGm5kwe6+NK/atwCYNUOa
	 AbVNrtmjqdnKGyVokW6IoShDaAe8X1liApYehaCRQQmNmtSTONBmX0idOLj1vd6Q1G
	 QZtT8VodN3WlQ==
Message-ID: <dfb4b2fa-1728-43f2-ad73-f06145399fc9@alu.unizg.hr>
Date: Sat, 16 Mar 2024 23:59:54 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Ahern <dsahern@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Po-Hsu Lin <po-hsu.lin@canonical.com>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [BUG] selftests/net: icmp_redirect.sh: 12 out of 40 test result with
 [FAIL]
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

With the commit v6.8-11167-g4438a810f396 in vanilla torvalds tree, there seem to be problems with
the icmp_redirect.sh tests.

The iproute2-next tools were used, commit 7a6d30c95da9.

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

These errors are not introduced with this commit, but were already present at least in 6.8-rc7.

Hope this helps.

Best regards,
Mirsad Todorovac

