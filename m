Return-Path: <linux-kselftest+bounces-42858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A71AEBC2F21
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 01:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDAE74EB850
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 23:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850BE26C3AE;
	Tue,  7 Oct 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW+ErZWA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58719264628;
	Tue,  7 Oct 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879632; cv=none; b=HbZ3kEJYLiVZDpmi+enl88mPpw7yx+UeFIyiwhyyjqYqUGWYFdRZOcPyAjD/WYy71muZlBHnU1oFObuZ0UqR0Hk/EXyhPxarQPoa+ixOPFiCK8NrP5ooQ0tHXmylVBpk6etB3uJfewv5q2YGMZy3nxfHoJl235aSdVAddWllpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879632; c=relaxed/simple;
	bh=ikVsaaymFTSbxS7sSm0h84zBgeHeyOBLLVM99r5/yiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyAzI0P6g2Hz0C4JbncnQIZY5ApodieWTxhK8qz7Nl0cLreGmGnKdmTolaloexMOAKIDKlQNWZwF6UxKPgOSjy39cWLISXlaPYa8jQt6lBBPQBDn40otY7JqsYMnvsk3HHcVXgLIPi7BkMrFUf5+uBGqktIvbGVa3AnO6SAHup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW+ErZWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93206C4CEFE;
	Tue,  7 Oct 2025 23:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759879632;
	bh=ikVsaaymFTSbxS7sSm0h84zBgeHeyOBLLVM99r5/yiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NW+ErZWA/obnmq1bZosyOi1E2n/RUxJK6aTyGr0sR/9DLi0DUbsg4o3GIud1ihNVU
	 4iI8W5bjgLY9oW75LL38pKI0C1KJBtTVUX9XxirYnQm3ZmtYiqce0V7D8NW6+OXjF4
	 NQAj5STeRkFD/p2tXN3ZN7vYpOnzJtbBc9cAOC4GBOGRr570Q51OIyrBBs+HEJJmaX
	 gKs0fj+Js+isLq2Z2UtUmPyByjKbyBr8Qg+hpOuF+TjpXuyYJhh6q0I/f2vIjueE3u
	 /bSWlbZ9adDSciMUOo/gCXRa+5hPfLaE5OFY0USsi6J1xI6f7cppG615aOsfgdCFQX
	 VkWiYPlom7d1A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	joe@dama.to,
	willemb@google.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 9/9] selftests: drv-net: pp_alloc_fail: add necessary optoins to config
Date: Tue,  7 Oct 2025 16:26:53 -0700
Message-ID: <20251007232653.2099376-10-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007232653.2099376-1-kuba@kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel config for error injection as needed by pp_alloc_fail.py

Reviewed-by: Simon Horman <horms@kernel.org>
Fixes: 9da271f825e4 ("selftests: drv-net-hw: add test for memory allocation failures with page pool")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: joe@dama.to
CC: willemb@google.com
CC: sdf@fomichev.me
CC: almasrymina@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index e8a06aa1471c..2307aa001be1 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -1,3 +1,7 @@
+CONFIG_FAIL_FUNCTION=y
+CONFIG_FAULT_INJECTION=y
+CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
-- 
2.51.0


