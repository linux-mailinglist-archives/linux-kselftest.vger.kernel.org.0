Return-Path: <linux-kselftest+bounces-11102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BB38D7F05
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 11:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71521C215AF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD38F8624F;
	Mon,  3 Jun 2024 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="brt+wWA/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74C12EBDB;
	Mon,  3 Jun 2024 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407235; cv=none; b=uD1YZXSfkcnZt5KfB/8Ngdydow/z6CSfONhZnAWDYAwKXzrmV3MohyteHono/mHd3df7OUHDZLMBlGREVlevF0jqr7ACPIQbXSc+ruQL/CZaCFGkThYJUBpbByGivkCd+fQnJzz2COc7i1D2c8W6gtvBOU1kzWCFV/ytlmZdxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407235; c=relaxed/simple;
	bh=i1+W9fRwSuY7cIzxg3UDgG1qLL/tZ34N8qpXL2awnyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ILLnUEcS+AO5pNsMN6UlL1ivvOrAvtDM8xIR7AxLNgfRWF82YqWcntJDY3Oxy/lFvbgnCsWpWUfVqKJRWDq9hX13P+Omi2kSllWHhdEBCG6i+I3FO6Qdl2Wc+zEceeiM/MoSm/dgqdLN4EYWycN4KPYYA7bPuuw0NnoUmd4mqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=brt+wWA/; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1F1A687D2F;
	Mon,  3 Jun 2024 11:33:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717407231;
	bh=I2oVJcFLXkPCNKP7PqlC/eM5qW7lVm4lSg1L40401TI=;
	h=From:To:Cc:Subject:Date:From;
	b=brt+wWA/jQ+G5PMyeMQOk03ryMEGzHCQWbNukTz93hXQC9fip0hznUt3NChgz1ijl
	 tNyovUR/JX3QjNfyMTn+EuLU7U71+IMNDXWvshwP0JTSZ7cgEOadkCOzw7WRll/Mch
	 EFdgy+QANClX8ItbWxUJBv69yfUQnc+38v2si3K5aOUZWVKbXRugxtZOEeytFsz7sC
	 jTgGqPmhk2ecmWh7HApr3dWkj6oiSbiEyGYmnMqnTp1e1zB38krqcbAfMMmnCmm+2b
	 OPyHKxZybw0we54dCzoyQ5doNE/W+DeP/rBlNf0JNoJzBhD2aPejUWtxuzT/+Pg2KG
	 698KWU+j8pc4Q==
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
Subject: [PATCH net-next] selftests: hsr: Extend the hsr_ping.sh test to use fixed MAC addresses
Date: Mon,  3 Jun 2024 11:33:21 +0200
Message-Id: <20240603093322.3150030-1-lukma@denx.de>
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


