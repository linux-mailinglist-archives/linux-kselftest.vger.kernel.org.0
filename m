Return-Path: <linux-kselftest+bounces-45919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89699C6BC67
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A35D34E549C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF630BBBD;
	Tue, 18 Nov 2025 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TssLDxsn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966043702EE;
	Tue, 18 Nov 2025 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502716; cv=none; b=Ll2VBSvtt3e1vXV0iXHDssQW8mQD5h+9fQZfwZwR/WSqZM9En+ueAMKim9uWKcrgUUPisJumwf335+vsHyVarm2JK3GsOiBSxHSt/QsmSer0VYaVW7/D1GhCVbuCaRcnjs7tQIjxtEd5f+PJN5yqz0RdwIW3/GoJtBTyylw0dQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502716; c=relaxed/simple;
	bh=TQvVM2TR7HFC4SVwECRWwQOHKqctJzJEnikz7WpTbaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzOuWi6kxsZe9h+hnAeArtGIBrl8F3EtnVFNAqQndHiBmmmvo5uJzBzsURhI5DAoa8HwZsHeJHXEH42FixFlt/tLvBmnWNROERomkVcavHa2neLV7477aqEBw7GJ4Uzr5YSDjBtFIbv8FFzkWBov5JFFYzjsVCq3c5p0T551KiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TssLDxsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1322AC2BC86;
	Tue, 18 Nov 2025 21:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502716;
	bh=TQvVM2TR7HFC4SVwECRWwQOHKqctJzJEnikz7WpTbaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TssLDxsns0zO74JLRjPzrUJV3VUblu0vw7r/NgUK+hA7opGeVmpTixkTRY4dgKbVj
	 CG7U4UfFc2wUbicMGG4oSwEnub3kKGSum2iyCxdb17D0n7J6pP/OdnWqpgiHHj6Jlc
	 o545aj1XsCCOLvCBmuM9QpSIW/AygU/VoZZitTNaHMRRY1Wn7ypDA9Aog2ieJUM1l7
	 E7rmCeBNV/esw9QL10dTvT/cq2w06bWUFrJC7lNlZTCBgpHt/Iz/noN6lThzujARiu
	 6hgIHDqJ1tNtK7eqJCGI0EDj2jF16YDA592wmoLGuKS0tYY4B/VjmHBy0rbdLNiZNv
	 QnATcfEzJsjNQ==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 01/12] selftests: net: py: coding style improvements
Date: Tue, 18 Nov 2025 13:51:15 -0800
Message-ID: <20251118215126.2225826-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118215126.2225826-1-kuba@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
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


