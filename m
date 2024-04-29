Return-Path: <linux-kselftest+bounces-9027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637238B5BB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDB01C20C96
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F132680C02;
	Mon, 29 Apr 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuwsAiRF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1937EEF2;
	Mon, 29 Apr 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401874; cv=none; b=qdGrTn7sUMKkzCbwpLDvFBegW0836c965rwy+78Xxrfqsz1QmkPcOKFaTqvFCeFvhyypvt+JQg0KBeypQzyk+IE2Fj27ub0hvPVETV1bYp/LBP6qb5wa0Bs976oi++TYUPeMjbZ4UTExfIGoexm3Vik9UxvyoqlBznFNp5njg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401874; c=relaxed/simple;
	bh=A5ZREJgKCRvW7P1Icrpp2yG+uJX4Xa3NZeRS99O14WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBFRstHucVionRxi4PF2sB6LS/tx57DYfCSUMuLpsh1Wv9L+O15+ez3uyGhVJgkZqnHHp6QRpwWxRt5BESHImWirkz69FDVEKBx6QytFGskbGyQ1ThYHu7Z0F1vF6QoHGNxlPVXWenRDoPrl775eISqnxFs6/Qm3vjFbBKCuolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuwsAiRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AA9C4AF50;
	Mon, 29 Apr 2024 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401874;
	bh=A5ZREJgKCRvW7P1Icrpp2yG+uJX4Xa3NZeRS99O14WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MuwsAiRFAwfnlKzjtVTRCjm2Sm4797RqSAEgd4srfb0hfTVzaq8x2pO4tMxbe0/yx
	 Z8nzvbr0c6yN2dqdvNzg3elmDuoiZsQ6dQe7cpDlMlEdtFgV7OIEN24RYUKacPtY/w
	 5DsnDjdS3LgUoC+obr1KMNXc0MwdeFTzy4e4dwOuHiqdD7HwbUuvXcAe4XrQK2BE5i
	 igfYpSpYt54IWjdlqHbQEsMsUXZhnuA5aVaWfBUY5TuHmpr3E8ZR/qHp2mv4gJ6Suz
	 PwyDmSwg29Jy+Qtn1MMD1saj8m9lIJoBYFqmOt35EakX9OVcPE7kLFhNVD6a6+D8+8
	 /OkNvkNBkOxKg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 4/6] selftests: net: py: avoid all ports < 10k
Date: Mon, 29 Apr 2024 07:44:24 -0700
Message-ID: <20240429144426.743476-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429144426.743476-1-kuba@kernel.org>
References: <20240429144426.743476-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When picking TCP ports to use, avoid all below 10k.
This should lower the chance of collision or running
afoul whatever random policies may be on the host.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 4930a90a64ea..b57d467afd0f 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -77,7 +77,7 @@ import time
     """
     Get unprivileged port, for now just random, one day we may decide to check if used.
     """
-    return random.randint(1024, 65535)
+    return random.randint(10000, 65535)
 
 
 def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):
-- 
2.44.0


