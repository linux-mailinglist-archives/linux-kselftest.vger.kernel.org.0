Return-Path: <linux-kselftest+bounces-3081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEBF82F1BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837881C235D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB71C29F;
	Tue, 16 Jan 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7q/IYC7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A871C294;
	Tue, 16 Jan 2024 15:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743F8C433F1;
	Tue, 16 Jan 2024 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705419792;
	bh=oKwJ2H75NG3mbe13Xcn0PDoVq1dGnh4QOFBgFzKOMHM=;
	h=From:To:Cc:Subject:Date:From;
	b=L7q/IYC7BpP6X5WM1G3upi8mdRoTMMN1rQKTP9spxdeJHpRIbIxZOxnTOkpFK0TD+
	 5QbwvZklg5dq3JFgOMh4uY9o9JMCCWHACyrkgtpa9COSEN136baurN6WVBkbKf2WPm
	 WcdgHA0/itMo6nxzaQk7lGl9l4aFw7TqRVsSBboZTzI+lHrutYU8BVe83nbHLmSI2i
	 sbyiBAmkMOoxxa6kKeAM6CAnqYsmgfdFcPAAT4vVO6jvymHvHQge3WLYNdpKituKsQ
	 LDUZXyJvaijy/KA7qhC64AvvjHLn/SlM/xAwmiEBo0ZteiRxnn/ts3qoq5Yv0iJDQf
	 a+KGfWownWIDQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	jiri@resnulli.us,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: netdevsim: add a config file
Date: Tue, 16 Jan 2024 07:43:11 -0800
Message-ID: <20240116154311.1945801-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdevsim tests aren't very well integrated with kselftest,
which has its advantages and disadvantages. But regardless
of the intended integration - a config file to know what kernel
to build is very useful, add one.

Fixes: fc4c93f145d7 ("selftests: add basic netdevsim devlink flash testing")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: jiri@resnulli.us
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/netdevsim/config | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/config

diff --git a/tools/testing/selftests/drivers/net/netdevsim/config b/tools/testing/selftests/drivers/net/netdevsim/config
new file mode 100644
index 000000000000..adf45a3a78b4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/config
@@ -0,0 +1,10 @@
+CONFIG_DUMMY=y
+CONFIG_GENEVE=m
+CONFIG_IPV6=y
+CONFIG_NETDEVSIM=m
+CONFIG_NET_SCH_MQPRIO=y
+CONFIG_NET_SCH_MULTIQ=y
+CONFIG_NET_SCH_PRIO=y
+CONFIG_PSAMPLE=y
+CONFIG_PTP_1588_CLOCK_MOCK=y
+CONFIG_VXLAN=m
-- 
2.43.0


