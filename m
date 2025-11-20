Return-Path: <linux-kselftest+bounces-46038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BBDC71C42
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E66012B4FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCE2773D3;
	Thu, 20 Nov 2025 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MykdhFt6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3D4275B1A;
	Thu, 20 Nov 2025 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604642; cv=none; b=lhfCU6PG8lvFNykeBOz2Nb+Xmhhu1uzrrDF+zeipgowgoXPoOoBJSrZy4LK+OYGhN/NOrNSt2LTPv7eX5dJmtcc84JNgHv4ed0CDH3y3P+So1zj+1QDjdBAb9NugbooiGZMtrVMQaTQ4D5kG0qOP+TccGe92NkoD7EfdKkAfidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604642; c=relaxed/simple;
	bh=TC3NeAdzyPqzUVrysuGRAx/a0xTXCanHM9wlhTwv0Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2Ht4Fp6B6Bm/5Klctfg+wnEIsHzg5M+XaWvhmIhJmhgP4oYGLjgJXDJW6/uBxBhyhXIrwGegUOM+2eqGq6i/8P299x7k+dH9ucdollDoJWnmW0TaougesvHAiiAfVSVsrVD6GwwBbKuAlt2Expry5tK3oHJs/sLrNm2+A7XQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MykdhFt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F165C113D0;
	Thu, 20 Nov 2025 02:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604641;
	bh=TC3NeAdzyPqzUVrysuGRAx/a0xTXCanHM9wlhTwv0Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MykdhFt67Z0YopS4qzScM1F2ADCf28wFNAPQplbYB4MF3BFDK+8NjLUwnYRf0Uy6g
	 v1sp0eQA70jDdbPT3XjPvk3z1a4I3JQvG2oRCOvVow+5WXqzqS6XgKZDf1/mmYK1+R
	 byzE8zp/F1NdOxw1Y0D2HwlKWC3cj6NHZlRwxk0OEHydP3626A+W4kHO41DhLRHHBj
	 lT3lu56Q0GZ/KipiNaSiqKVD+iOvLdk82aL0OLQ/hwmPO7KVHXMDSPoECe9DSCe8OZ
	 P55xRwqrxpzlxBF0vOB3RIx9tlBvQilEbOQ9utrQiHy92L2RjIyx0sFPBY5s3mgNm4
	 9iGUkLMl0f+qQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	krakauer@google.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 01/12] selftests: net: py: coding style improvements
Date: Wed, 19 Nov 2025 18:10:13 -0800
Message-ID: <20251120021024.2944527-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120021024.2944527-1-kuba@kernel.org>
References: <20251120021024.2944527-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're about to add more features here and finding new issues with old
ones in place is hard. Address ruff checks:
 - bare exceptions
 - f-string with no params
 - unused import

We need to use BaseException when handling defer(), as Petr points out.
This retains the old behavior of ignoring SIGTERM while running cleanups.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - Exception -> BaseException
v2: https://lore.kernel.org/20251118215126.2225826-2-kuba@kernel.org
---
 tools/testing/selftests/net/lib/py/ksft.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 83b1574f7719..2eed24244b8a 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-import builtins
 import functools
 import inspect
 import signal
@@ -163,7 +162,7 @@ KSFT_DISRUPTIVE = True
         entry = global_defer_queue.pop()
         try:
             entry.exec_only()
-        except:
+        except BaseException:
             ksft_pr(f"Exception while handling defer / cleanup (callback {i} of {qlen_start})!")
             tb = traceback.format_exc()
             for line in tb.strip().split('\n'):
@@ -181,7 +180,7 @@ KSFT_DISRUPTIVE = True
     @functools.wraps(func)
     def wrapper(*args, **kwargs):
         if not KSFT_DISRUPTIVE:
-            raise KsftSkipEx(f"marked as disruptive")
+            raise KsftSkipEx("marked as disruptive")
         return func(*args, **kwargs)
     return wrapper
 
@@ -199,7 +198,7 @@ KSFT_DISRUPTIVE = True
             return False
         try:
             return bool(int(value))
-        except:
+        except Exception:
             raise Exception(f"failed to parse {name}")
 
     if "DISRUPTIVE" in env:
-- 
2.51.1


