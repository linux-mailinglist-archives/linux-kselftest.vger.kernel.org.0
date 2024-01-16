Return-Path: <linux-kselftest+bounces-3055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E482E7D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 03:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF97283DB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81DE388;
	Tue, 16 Jan 2024 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soVGgxma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795633C5;
	Tue, 16 Jan 2024 02:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAB8C433C7;
	Tue, 16 Jan 2024 02:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705370524;
	bh=9dhy1YNpX6OU4nivG/Pq4us59QGO8fhDuKoTrZ83teg=;
	h=From:To:Cc:Subject:Date:From;
	b=soVGgxmasZChb1hToyEQVBH02gBpmbBNpOAO6wkDjSixd6Pz/GILIe0LVrVJ6PsVF
	 d3izL6uqxu+G6G1q341kN4kvYT3qleUgzyzOiZTBR1BI0e2Ob0E/lwPW3NqPkYSEMu
	 68J6T5+ac1DatGxvTLA3COpDrBKLXvk6fSCSel0uD+GusfTdoa/zzzKEYOc7UvF/uZ
	 0IGWIK7HOxtMukF3PgDbV83JshWYB0uxkSWv5wq9xeDm7LgwtmTfWibTIZKwMQLIQ8
	 mbVRRYh/D9pjcwxY1CpWDPcx1aN3mc2KQfaTSkZYcQKtbn2WwCu6/rzqQimEF2vH2p
	 jOoENUaQiP1BQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	j.vosburgh@gmail.com,
	andy@greyhouse.net,
	shuah@kernel.org,
	bpoirier@nvidia.com,
	jon.toppins+linux@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: bonding: add missing build configs
Date: Mon, 15 Jan 2024 18:02:01 -0800
Message-ID: <20240116020201.1883023-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bonding tests also try to create bridge, veth and dummy
interfaces. These are not currently listed in config.

Fixes: bbb774d921e2 ("net: Add tests for bonding and team address list management")
Fixes: c078290a2b76 ("selftests: include bonding tests into the kselftest infra")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: j.vosburgh@gmail.com
CC: andy@greyhouse.net
CC: shuah@kernel.org
CC: bpoirier@nvidia.com
CC: jon.toppins+linux@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/bonding/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 70638fa50b2c..f85b16fc5128 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -1,2 +1,5 @@
 CONFIG_BONDING=y
+CONFIG_BRIDGE=y
+CONFIG_DUMMY=y
 CONFIG_MACVLAN=y
+CONFIG_VETH=y
-- 
2.43.0


