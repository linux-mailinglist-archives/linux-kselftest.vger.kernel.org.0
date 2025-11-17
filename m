Return-Path: <linux-kselftest+bounces-45782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C15CC662B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5C5D34C28E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 20:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D734B68A;
	Mon, 17 Nov 2025 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbUNOziz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE95A34B434;
	Mon, 17 Nov 2025 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413108; cv=none; b=d4Rv2EL0rMpTzj7yyYASNRFz2DEkDIVUG70Fgc/ud0uqa+MeK3/kUBbK+xGL6ydXTIWbn8FtfvNasRaBmQdnvtlaYu7+gpoFZ9cPyjrm2ksveczdRROMmoT5uEodKtQy48q6/PyUndNzCvezmL90MBY+fA9Egce5Zfr8YDnWj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413108; c=relaxed/simple;
	bh=TQvVM2TR7HFC4SVwECRWwQOHKqctJzJEnikz7WpTbaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5lE3WVr2s0NWgwRal7uDoFgTcbrorq3zurtGlCzEb4Bm7uMHyOEsR2l1zY/Iey/KYiaTKs+1SkaQLJIdsdxfxcojuEw71Ij5ATWhSacz1kMDhg44QR9ynjU96Y6jB5jaRNTkz9uZ7Yh4d3y/4exIB5/QC/JOJl2qMb05qdD0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbUNOziz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA6BC4CEFB;
	Mon, 17 Nov 2025 20:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413108;
	bh=TQvVM2TR7HFC4SVwECRWwQOHKqctJzJEnikz7WpTbaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SbUNOzizWGJhN+9KD/FD1pqne5KN8vvzfvkA27if13tuEuwRIMie4Q56AbTHLUE7E
	 CP5+Lgy8NdCXMCFRXeVCVGPZ9dWfh4jVy9fwKs6aSiQUGlfOchRg1ylMBynSesvUDF
	 AJfaCMFUkftQIUFd4P36R1W5yJAR26xOiImFgUXdCAysLD8K7SOLaG7QP88bjIFgXi
	 cCfV6nCzlQWlf/KG50mnTyaaESgMPRQLXOAobLK1gsgGPG2AQQPMt9vrFo+hZFmO98
	 smDDQBrIMrYWCPsEszbWPCsAx8RooaeR0GXlmuUVvQNHRJ98CNlahPHab4Bj9UMxMU
	 ZCtRWZkpQPKhg==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/12] selftests: net: py: coding style improvements
Date: Mon, 17 Nov 2025 12:57:59 -0800
Message-ID: <20251117205810.1617533-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117205810.1617533-1-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 83b1574f7719..56dd9bd060cd 100644
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
+        except Exception:
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


