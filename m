Return-Path: <linux-kselftest+bounces-8038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC318A5F68
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 02:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2ED31F21F17
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 00:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C1A4C98;
	Tue, 16 Apr 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSQkfxyl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D03D7A;
	Tue, 16 Apr 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228363; cv=none; b=YnZQX/TXoQtWwkIs9Fe2bgwDsO7qK5akl/1urYHXowPC7P5JeyZvGtkzpuAOeVMAQGxCNIPbgEvDUvKxRa924Ppr3+2gS5DpEfywv+D6tvoR8W6JIvLU/WDZrysh7r/0PMmvOJRbmP/Zx60Sf/Kx9IQTIJcy4SR/Fm9tlu7VnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228363; c=relaxed/simple;
	bh=7pnzslXkSvchRavsLakdswzhlJdLRYa1UEolq6woMV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9nK2Rl8ezXzGe4rdY3iWhrXYrmonNos0HtkjPECVDXTiuXkwHtHBw46eNtmgXorw0YWw07pWGKT3tBPqGnkSmuOJXN/lIJtDZkm0qvSpuhCHcYps61UAkbSg/AOv/7RILHbbZMm2wsVVxyGi71qU9Pa3hjiZm7tukzlu4EgQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSQkfxyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB903C2BD11;
	Tue, 16 Apr 2024 00:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713228363;
	bh=7pnzslXkSvchRavsLakdswzhlJdLRYa1UEolq6woMV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSQkfxylBHNUhOdARpP2zjR3Z2oq4gZ1icsg8IiyFVqbrS+8XXD/nINN4+l/jGeaq
	 Pv0nUDHZ7rccmNZ2N8aTx9bZsfoKMXf07Ohm1C9B8lBcNsjMr5r5dRkGLUFT2oyMOL
	 BFyy/BtJLjwjd01R9N9+PDL7VEYnLcoLZQeQRzmBhGxZ2C+98HvVVIJegNqyg5xe9G
	 E08lNcT9utWgiZg+VbbcGwQ8BMdw9cQDOFqaWmdNXsjS5W4P6a/A0+j1r7lEu4vP5U
	 ItGAh0JDZmZeSTI4EDhNm0LX3/H9hq2rljkpFnK2XgV3n/Lk9EmiVdP00izIXCh1Ah
	 0HSh5QuSR2Bkw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/6] selftests: drv-net: add config for netdevsim
Date: Mon, 15 Apr 2024 17:45:52 -0700
Message-ID: <20240416004556.1618804-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416004556.1618804-1-kuba@kernel.org>
References: <20240416004556.1618804-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Real driver testing will obviously require enabling more
options, but will require more manual setup in the first
place. For CIs running purely software tests we need
to enable netdevsim.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/config | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/config

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
new file mode 100644
index 000000000000..f6a58ce8a230
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/config
@@ -0,0 +1,2 @@
+CONFIG_IPV6=y
+CONFIG_NETDEVSIM=m
-- 
2.44.0


