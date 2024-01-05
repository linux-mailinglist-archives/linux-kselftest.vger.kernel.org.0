Return-Path: <linux-kselftest+bounces-2657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AD582512B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 10:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20021F23747
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DF52421D;
	Fri,  5 Jan 2024 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="k53S5+Ch";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="F3veO7d3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5B24B51;
	Fri,  5 Jan 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id D6AE060173;
	Fri,  5 Jan 2024 10:41:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704447684; bh=qKJmrnjWkHPbpWrQi3wn/w/6aFlhApN2GLFP70rgZoA=;
	h=Date:To:From:Cc:Subject:From;
	b=k53S5+ChiDP5PKAJC0vZtf95BR6ZKhnVNVpPjw6eFHxIIr6u4N/qQ76C21AaRllgh
	 PoMNi+pWbUfSDyaCLIV0GUiSQEvbHj4wFyBKq7x70X85BHbpLt8C4Rurb5pN1HJV6i
	 hioUhumkj1oQnXswxLNO8viYPjuMuWpVHnhQ/6cMLrMfdqH5QFzFO5RcoGYBxDd5NN
	 600QoY023ZgMIEBSA9mG0+iY7nn9AT54S0uAWQv5EqByY1gpti61T+bxrM5GD3nant
	 nqap+35Taocv8kjgJgWCHp6fBYO9ZbDQiS44Cn5rWG6jaeyAAsvSj4oDP5BJDFGnAe
	 AmnwypuhNAbxg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d_wiY3UvOH3p; Fri,  5 Jan 2024 10:41:22 +0100 (CET)
Received: from [192.168.94.51] (unknown [212.15.178.51])
	by domac.alu.hr (Postfix) with ESMTPSA id EF57360161;
	Fri,  5 Jan 2024 10:41:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704447682; bh=qKJmrnjWkHPbpWrQi3wn/w/6aFlhApN2GLFP70rgZoA=;
	h=Date:To:From:Cc:Subject:From;
	b=F3veO7d3mmYHG8MrgSjoykPb7YrG3/6gh5QlUSwBGSabwGRdKB+ETnbSoib7dDk2W
	 QbaBSnS2KpMkkWb0sXangRnL9gUtqKoDRuznHNVjCV3vzCmG115CprzXSRkLoIdKIc
	 1zNr2TFH6mcUol1Nu2dP9tYuJNvo2D1aPRdKWq4UmFNLbKXpOPXfyztZAwE8przJpv
	 H5/L9caWaivDHTbqPg6PcOy1j3l9vLsu5my5jaIiKvmMH9bhzIZ9jK1XQVmL7UX2+z
	 pQmco0PxPk/bCvVHW7nv+jG7CIqHgbWTXznrFK6D1r6Wjs71xYh1nztBKy8UY5R7NN
	 wnGA15EVgrzsg==
Message-ID: <0b9a2827-c9c5-41d6-a4f1-dbd91262c474@alu.unizg.hr>
Date: Fri, 5 Jan 2024 10:41:20 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, hr
To: LKML <linux-kernel@vger.kernel.org>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: selftest: net: fcnal-test.sh TIMEOUT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, all,

The default timeout for tools/testing/selftest/net groups of tests is 1500s (25m).

This is less than half of what is required to run the full fcnal-test.sh on my hardware
(53m48s).

With the timeout adjusted, tests passed 914 of 914 OK.

Best regards,
Mirsad Todorovac


diff --git a/tools/testing/selftests/net/settings b/tools/testing/selftests/net/settings
index dfc27cdc6c05..ed8418e8217a 100644
--- a/tools/testing/selftests/net/settings
+++ b/tools/testing/selftests/net/settings
@@ -1 +1 @@
-timeout=1500
+timeout=3600

-----------------------------------------------------------------

[snip]
#################################################################
Ping LLA with multiple interfaces

TEST: Pre cycle, ping out ns-B - multicast IP                                 [ OK ]
TEST: Pre cycle, ping out ns-C - multicast IP                                 [ OK ]
TEST: Post cycle ns-A eth1, ping out ns-B - multicast IP                      [ OK ]
TEST: Post cycle ns-A eth1, ping out ns-C - multicast IP                      [ OK ]
TEST: Post cycle ns-A eth2, ping out ns-B - multicast IP                      [ OK ]
TEST: Post cycle ns-A eth2, ping out ns-C - multicast IP                      [ OK ]

#################################################################
SNAT on VRF

TEST: IPv4 TCP connection over VRF with SNAT                                  [ OK ]
TEST: IPv6 TCP connection over VRF with SNAT                                  [ OK ]

Tests passed: 914
Tests failed:   0

real	53m48.460s
user	0m32.885s
sys	2m41.509s
root@hostname:/

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

