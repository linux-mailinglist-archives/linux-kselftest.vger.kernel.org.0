Return-Path: <linux-kselftest+bounces-38729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC1DB21908
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A4A7A680B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B9A2D9EE3;
	Mon, 11 Aug 2025 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mnr0yXgB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D582D8781;
	Mon, 11 Aug 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954028; cv=none; b=c0Wb/pqKLYyo1YG6F3I8s8uWZvrLGJUwkQBZZsXwBHHeNQqrGg+k0+BiXPRQI43gLgmmezAV+jzzDpcSPjrflCeiSqHZi/tRqLb8E/64+/Zsjy3FYjLHxL5LDjG2PKB4RTi9xv7+eXzfyS3N54RFmr9kQ/jD1gWXfDyY1P5lCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954028; c=relaxed/simple;
	bh=wgBFxlnaNWfDrQ1L/aOL9irFdGma24Z2xxiCY0ZFqS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWymdojgTb20gYxv3vqoJjD8s/ApSh0Caso1k2juPW+mweUmhbHSLc1+6XTEa+ZRmtHYqAruTeQJu/wWuvfMJXVqJyiLWcRORS19JVEOZES4yxO4eIvdM2rXq5Lym7xzqyCFGRjX26gsB/dN2YbuQ4cK2s6D3+7x3iPforK587o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mnr0yXgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ED4C4CEF1;
	Mon, 11 Aug 2025 23:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954028;
	bh=wgBFxlnaNWfDrQ1L/aOL9irFdGma24Z2xxiCY0ZFqS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mnr0yXgBwEmmx10d2gwYjuuBc5qUHy/RmwBcw7EKh4OWxYS4UZ8AuPCD29OvClNiA
	 k1uPzP+/1vvmvHw7xl+pOVv8kB8vWz9SPJ4hnRKjQkR9l2y8Uph06ChmDP3wkfuoQQ
	 pbbcURN5Tve0Sm85vW4/V9QrqVlIBQEHu8kUslF8AQ81m2O3KbEJ9ibn5NWmH2n4Zl
	 pipMfurqYl/O/zY7efY6m11I1bpi2/IyKdGjA6WdaDnpgii8dxrWKUM3XaOyYrLhNX
	 2tkW+6kc/5HE8ibP3uK3YS87wPRy+RRHBaCeW6jAWbCGbPViXwVMtl9+LzXPxWRKVg
	 qWbLwmhxQoObQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	noren@nvidia.com,
	linux-kselftest@vger.kernel.org,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/5] selftests: net: terminate bkg() commands on exception
Date: Mon, 11 Aug 2025 16:13:33 -0700
Message-ID: <20250811231334.561137-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811231334.561137-1-kuba@kernel.org>
References: <20250811231334.561137-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a number of:

  with bkg("socat ..LISTEN..", exit_wait=True)

uses in the tests. If whatever is supposed to send the traffic
fails we will get stuck in the bkg(). Try to kill the process
in case of exception, to avoid the long wait.

A specific example where this happens is the devmem Tx tests.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index f395c90fb0f1..4ac9249c85ab 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -117,6 +117,7 @@ import time
                          shell=shell, fail=fail, ns=ns, host=host,
                          ksft_wait=ksft_wait)
         self.terminate = not exit_wait and not ksft_wait
+        self._exit_wait = exit_wait
         self.check_fail = fail
 
         if shell and self.terminate:
@@ -127,7 +128,9 @@ import time
         return self
 
     def __exit__(self, ex_type, ex_value, ex_tb):
-        return self.process(terminate=self.terminate, fail=self.check_fail)
+        # Force termination on exception
+        terminate = self.terminate or (self._exit_wait and ex_type)
+        return self.process(terminate=terminate, fail=self.check_fail)
 
 
 global_defer_queue = []
-- 
2.50.1


