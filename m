Return-Path: <linux-kselftest+bounces-10836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3309C8D3906
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 16:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8954B22D74
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 14:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B0A157A72;
	Wed, 29 May 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BbxHiInL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B804157A6B;
	Wed, 29 May 2024 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992575; cv=none; b=MVcPiVxgXHbNuZi9AuF0otpPW77jC1JqjyUg6Eo2DnDoDHmk4S7Lb0pYXLrdDxw6na6uI6cfRn8+fVXnIn5m5/zeENwC3hySqZcdCHNW7ILP2GigmiolB2bmsYzAREJGxT/Qkchs0CNssxRcnndHlRT3Er1No0ZzFQWc4gkOzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992575; c=relaxed/simple;
	bh=i1+W9fRwSuY7cIzxg3UDgG1qLL/tZ34N8qpXL2awnyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HKBuH1FOYNHQ9qArSybn7xSSRizWsB/6qEoJTQcG763S2nchEj0ZcII+cnbc9L9RmANDaZBwAS42HhLW/l6y4xk/e/IiPe30n8ljOVWRKm9jQzhqK0NH0AW+ABrjBPEqAi31a56a/DAY9gwv+hyMc52GZkhERP39SO9n/l1WSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BbxHiInL; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3D6CA88271;
	Wed, 29 May 2024 16:22:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716992571;
	bh=I2oVJcFLXkPCNKP7PqlC/eM5qW7lVm4lSg1L40401TI=;
	h=From:To:Cc:Subject:Date:From;
	b=BbxHiInLCDYI73Rz+vptL1jC0UDd5SG0btzkGHuWikdKesGmooljxpvLXUtRoRiHi
	 kzJOVYaTdvr7TJ1ZFEqqD3RWyt8m+60aoMzcjFn03jiqXVtq71jTe4BpGn4b+uf+Ij
	 9Iw1qdHYnrczTQiDuNfUvtVu9I/pSQz9WA/dk0tLyGfBJzknA3paTa0kISfUCrw6Lg
	 qTWt5SIayv9SjxxBL9IuAZW9A1L4cjdDTKy3d1yHpX0TUntmvkzfggxI+uveKnMiNq
	 FsJMyrsZ9Ad50KjQR0mblh5cqpyvUH+H7GMsT8Nea1ZNHl2VNlklA3BoxL2Vxx8fYf
	 NpPPc6IW2BLFw==
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
Subject: [PATCH] selftests: hsr: Extend the hsr_ping.sh test to use fixed MAC addresses
Date: Wed, 29 May 2024 16:22:31 +0200
Message-Id: <20240529142232.2625747-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 tools/testing/selftests/net/hsr/hsr_ping.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
index 3684b813b0f6..f5d207fc770a 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -152,6 +152,15 @@ setup_hsr_interfaces()
 	ip -net "$ns3" addr add 100.64.0.3/24 dev hsr3
 	ip -net "$ns3" addr add dead:beef:1::3/64 dev hsr3 nodad
 
+	ip -net "$ns1" link set address 00:11:22:00:01:01 dev ns1eth1
+	ip -net "$ns1" link set address 00:11:22:00:01:02 dev ns1eth2
+
+	ip -net "$ns2" link set address 00:11:22:00:02:01 dev ns2eth1
+	ip -net "$ns2" link set address 00:11:22:00:02:02 dev ns2eth2
+
+	ip -net "$ns3" link set address 00:11:22:00:03:01 dev ns3eth1
+	ip -net "$ns3" link set address 00:11:22:00:03:02 dev ns3eth2
+
 	# All Links up
 	ip -net "$ns1" link set ns1eth1 up
 	ip -net "$ns1" link set ns1eth2 up
-- 
2.20.1


