Return-Path: <linux-kselftest+bounces-34186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE0ACBDA8
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 01:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B913B1890C78
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 23:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73700151991;
	Mon,  2 Jun 2025 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6tmLEu9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD62C3251;
	Mon,  2 Jun 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748906202; cv=none; b=lHJmoOyNplS+uXqHgsdfU+hNmm6d61Sv2Atb7AWgws3rYMCaQyhpCRz8yjd6B0h88jN6y1DCH6aXOKI38x17q9q5HVTLhdZmmWeM8wwyX98iPBHx3zZ7khSt2B+mRaNV0WDEAqG50fJpqG/1QvurzqO9aQqyT82fTTOhFIWTwHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748906202; c=relaxed/simple;
	bh=wuNpe20+onO7k+0xVYg9b6FKIsEIXOHA2lHpopy+8gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIloaZqODmT9iv1U67lsIw5ZbAvFYoa8SaM8dOyOlSnw/PoCpOcssv1EmXvRsjHv+9LCMLyzICeF0jjtVt6bpezawfL4BFGFLxbayolvmNPwuHdF/6f61bbnRyIPB7kB/wEzRKdu6BUK7vm3MWoDH6PUkarX1IuIzf+JmtrSrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6tmLEu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570EAC4CEEB;
	Mon,  2 Jun 2025 23:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748906201;
	bh=wuNpe20+onO7k+0xVYg9b6FKIsEIXOHA2lHpopy+8gk=;
	h=From:To:Cc:Subject:Date:From;
	b=b6tmLEu9lSNC23UVrVXGvOanX/POFNM6+dxYqYsFCjlVEVzWZppSS4LXkG1l2EFPK
	 RwrhD9BBZkst0jj/zQ78PP0FubBPiZeeQS2mtA/QBuLuCc2NDNNP/AH57Xlbp1/+cA
	 YrRYDT1DepoWizF8N8EAT5aFoeuZeVpNhzPndR08obx/1aiJYGZuW5kdsXOA0HKVRe
	 euhHNu9jPpevNk+FIZbSKfciJuFSWJ42KLVmBIPPE37h8CgSKvC9I5KBvjoEk+sqM0
	 UHStajj7pGRTIvaVyTrUN25k5z6FjIApXWJ3cPBFqjXzQk2jMSF1VYZ5i2dvyVKt3g
	 jZOYixB7ikPZg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: drv-net: add configs for the TSO test
Date: Mon,  2 Jun 2025 16:16:40 -0700
Message-ID: <20250602231640.314556-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing config options for the tso.py test, specifically
to make sure the kernel is built with vxlan and gre tunnels.

I noticed this while adding a TSO-capable device QEMU to the CI.
Previously we only run virtio tests and it doesn't report LSO
stats on the QEMU we have.

Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/config | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/config

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
new file mode 100644
index 000000000000..ea4b70d71563
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -0,0 +1,6 @@
+CONFIG_IPV6=y
+CONFIG_IPV6_GRE=y
+CONFIG_NET_IP_TUNNEL=y
+CONFIG_NET_IPGRE=y
+CONFIG_NET_IPGRE_DEMUX=y
+CONFIG_VXLAN=y
-- 
2.49.0


