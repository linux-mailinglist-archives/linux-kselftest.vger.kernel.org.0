Return-Path: <linux-kselftest+bounces-10837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33658D390A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 16:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4994A1F23B4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C36157E94;
	Wed, 29 May 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="YRhVqDOa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7066157A48;
	Wed, 29 May 2024 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992576; cv=none; b=W9IQUOTqwVEG/1kpOhZaTAeOYPqBeQi7EZ+jPjE1jS7R4l7JL1AzLXT1npowCqSZJ0xgzMEsyYGoUq/EKIm2hmfmsgoC2hKMJE+3oQYyS/21igSH1SF2+58PSDvc/GhrfGCJPggAjmGVyQujKTmRImOE9TI+R/PTy607Z8mvymA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992576; c=relaxed/simple;
	bh=rtTnp6DNjxdV478Y4SxUq0UJyuySEc8owZ4xpBLB7IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djtqnXQZdDkuQ69odhiWN0sf1Y6XhLf5yjmTYE5jV9nWYWKrgSxZF5jN9hm6xoIaDTyj1lMWDdc8fwZ/RTRBMVfWZjED5luMuELB/F5/VX4QsDb9YQ1wlI8zNwXbh8JYxmNE2n9I1hJ5UdCAInjGxL8B/CfydNz77/1w4+ZgE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=YRhVqDOa; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8B9EE883F4;
	Wed, 29 May 2024 16:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716992572;
	bh=yzK/jJThiq2QGD8NcEQ2x+5IClGOW3kK8VcfEbej7CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRhVqDOa5ILpGXEkvulDSTLN2eWhxyONzpse+orLOwBEj6Ghfgl2Vo0NoMdezVYA2
	 oD1/wwjlPAzrmcVGIDfijLlc+6mMR8WvnhAAW7vYghiDYCDQPcVRxCxoiz6Eu+YpUk
	 isefaqW6hm7c5QvnkzylAjab4n5R7u7QzWVvFSntREeS1C0FlzOpyPLoxqXQUfG7rN
	 2DH2IrTENFSLzalxyPsLLuwFdZLToEHKJ4leqekuTwKe5MnKmQ3v7ji+46OPBe/Aik
	 nerVql4rjruGqSm2Y+YZ3QcFJ/V2PF+zQK9zm1JM8EjRr4JGqZig5DSDyFvpDBPQHs
	 humnfSara3ufQ==
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Arvid Brodin <Arvid.Brodin@xdin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Shuah Khan <shuah@kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] selftests: hsr: Extend the hsr_redbox.sh test to use fixed MAC addresses
Date: Wed, 29 May 2024 16:22:32 +0200
Message-Id: <20240529142232.2625747-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529142232.2625747-1-lukma@denx.de>
References: <20240529142232.2625747-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Fixed MAC addresses help with debugging as last four bytes identify the
network namespace.

Moreover, it allows to mimic the real life setup with for example bridge
having the same MAC address on each port.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 tools/testing/selftests/net/hsr/hsr_redbox.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/hsr/hsr_redbox.sh b/tools/testing/selftests/net/hsr/hsr_redbox.sh
index 1f36785347c0..998103502d5d 100755
--- a/tools/testing/selftests/net/hsr/hsr_redbox.sh
+++ b/tools/testing/selftests/net/hsr/hsr_redbox.sh
@@ -96,6 +96,21 @@ setup_hsr_interfaces()
 	ip -n "${ns4}" link set ns4eth1 up
 	ip -n "${ns5}" link set ns5eth1 up
 
+	ip -net "$ns1" link set address 00:11:22:00:01:01 dev ns1eth1
+	ip -net "$ns1" link set address 00:11:22:00:01:02 dev ns1eth2
+
+	ip -net "$ns2" link set address 00:11:22:00:02:01 dev ns2eth1
+	ip -net "$ns2" link set address 00:11:22:00:02:02 dev ns2eth2
+	ip -net "$ns2" link set address 00:11:22:00:02:03 dev ns2eth3
+
+	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3eth1
+	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3eth2
+	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3eth3
+	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3br1
+
+	ip -net "$ns4" link set address 00:11:22:00:04:01 dev ns4eth1
+	ip -net "$ns5" link set address 00:11:22:00:05:01 dev ns5eth1
+
 	ip -net "${ns1}" link add name hsr1 type hsr slave1 ns1eth1 slave2 ns1eth2 supervision 45 version ${HSRv} proto 0
 	ip -net "${ns2}" link add name hsr2 type hsr slave1 ns2eth1 slave2 ns2eth2 interlink ns2eth3 supervision 45 version ${HSRv} proto 0
 
-- 
2.20.1


