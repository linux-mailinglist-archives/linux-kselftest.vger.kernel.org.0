Return-Path: <linux-kselftest+bounces-34267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3355CACD07F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 02:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04A816EA7B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 00:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24294A29;
	Wed,  4 Jun 2025 00:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5Bv7FGv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF741862A;
	Wed,  4 Jun 2025 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748996216; cv=none; b=IID5EWb1Xox4LEvHWXNC/nVDT/kPEbTyAH9GP/5oiHgLUpiMnhxJjWGJoLcujJBleIPOPtotjwkpQDY+tYpIAGOSwiaTqWtWNT44ZrgfL9WhlibAdAOZZrWoWMnmlCd2ZwnB60OtAxMYSDd2ozbbJDXPl4CSxwCNrWydiP2mZPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748996216; c=relaxed/simple;
	bh=wuVxKqPUYUcPef/+YL/hdii5VLNfuH4RwN+dr1Zn0+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5gwd+sxl5IlcZVFZfqyALHL6ZtqR5V65BMHyr54uRKDdBwh7xHsUQcc5TaOrQgIiYgNHszuNoyixN2WTEAmbpmsvy5jX5NHu/QebwasC5+cWbO9/iAknTWcCr2Uvo0O3q/ozQYyIOnzykKJNEGCaS+3PgK4ft9lZ7JWXJndFqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5Bv7FGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B729C4CEED;
	Wed,  4 Jun 2025 00:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748996215;
	bh=wuVxKqPUYUcPef/+YL/hdii5VLNfuH4RwN+dr1Zn0+g=;
	h=From:To:Cc:Subject:Date:From;
	b=r5Bv7FGvTGE9p6yVPUV703QPWsrcRYLY1GQ9FnSp84uKeLW5PV/Md1R5FcF4Ll0pl
	 2JrHvhxEb+z+YzkE2l9sxPxGKUeju8p0kkE78O1CdnLUiYzu3yDvPq+5M6C5Dne7m3
	 E9Nr5xCeyEifNT8Az0cOVovjSfrISo6HtBEiKmzfjhzPyo3mzmP+4o026iYCv727Z7
	 6evgX52VzF5e9XcsrSds5VNpZu2qNYO/IyPuEmI6KrhRLAnbeUh+2h6IW83B+auXKI
	 7slLkjaxvs/e76sKVo7xWmmoJYnKTryLer81g/yWhX6vVcrr+PmIouw5iohVAVWACQ
	 oDVy24luQWjhA==
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
Subject: [PATCH net v2] selftests: drv-net: add configs for the TSO test
Date: Tue,  3 Jun 2025 17:16:52 -0700
Message-ID: <20250604001653.853008-1-kuba@kernel.org>
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
v2:
 - drop NET_IP_TUNNEL
v1: https://lore.kernel.org/20250602231640.314556-1-kuba@kernel.org

CC: shuah@kernel.org
CC: willemb@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/config | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/config

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
new file mode 100644
index 000000000000..88ae719e6f8f
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -0,0 +1,5 @@
+CONFIG_IPV6=y
+CONFIG_IPV6_GRE=y
+CONFIG_NET_IPGRE=y
+CONFIG_NET_IPGRE_DEMUX=y
+CONFIG_VXLAN=y
-- 
2.49.0


