Return-Path: <linux-kselftest+bounces-8528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873038AB914
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 04:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B988B1C20D83
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D075CFC1C;
	Sat, 20 Apr 2024 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHwS0G5K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E9134BF;
	Sat, 20 Apr 2024 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581563; cv=none; b=lD/fb2WOdAESk9wsHmIDL+JTc4n3E262KZz4vPa9r6jQvTKztdSjZ2za/XQ5G6ezIO/3gIryZpRQm6j0XC2KW6GxSW0kX2uWHZrpNReEKd7vo9c6aCInCWrN+jeqz80OH3zsp4ZexGM2cu4m21Yp2rursjX9Eu0C31d8ZMC/LRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581563; c=relaxed/simple;
	bh=2aBKBmiU5u7RKO297YDu3WlUAOmbxnH+Jhv/GmAxX/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2M1d2lfZmei54KNQfijqqEbk7CIKE38EnC84vDoLGy61/M31BA0x9pk5hHv9usSl0N3Bfacq07SgayrlvACUx+qPPDe4FXaKgdWbfCILJ0JaNcPXWmv3gIhKYo8OVNRbl94sWOV6MWcNSwtmCxvkVAcOCe/HIAFI0nUaMcC/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHwS0G5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1895C4AF08;
	Sat, 20 Apr 2024 02:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713581563;
	bh=2aBKBmiU5u7RKO297YDu3WlUAOmbxnH+Jhv/GmAxX/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lHwS0G5KDZDTn7VRSC6yknsjAdVszHLbHMXrgZBX77MuxdIPiUP5dcUy+F8zYPXVP
	 yY74e/J7Ccov0G4XlUtn2cpz1bsjZPsSHtF3sEyLIF6RKFxSW3JCvNaf3/lHlmGuNf
	 FHBKCKYUZupuPL1gor2zh6P0kkik21+xq6biojrC6vTvU8ZWji940Rkb7JuNiWHfa+
	 +IdDarxiWfVYRVsJ6Mn7U52OOcWiDHONQhBa5MS0uFKE9XA17lCc53bGjzwxNTUn2k
	 xbNpTv/z1eMKe3MpQFp4YxxZROfjuO9xkCG390bSvs4DxK/05bGH8uLWtsBvLno19O
	 WRszNYOFpjxGw==
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
Subject: [PATCH net-next v5 5/7] selftests: net: support matching cases by name prefix
Date: Fri, 19 Apr 2024 19:52:35 -0700
Message-ID: <20240420025237.3309296-6-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025237.3309296-1-kuba@kernel.org>
References: <20240420025237.3309296-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While writing tests with a lot more cases I got tired of having
to jump back and forth to add the name of the test to the ksft_run()
list. Most unittest frameworks do some name matching, e.g. assume
that functions with names starting with test_ are test cases.

Support similar flow in ksft_run(). Let the author list the desired
prefixes. globals() need to be passed explicitly, IDK how to work
around that.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v4:
 - spell the code out a little to make it clearer
---
 tools/testing/selftests/drivers/net/ping.py |  3 +--
 tools/testing/selftests/net/lib/py/ksft.py  | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index e75908d7c558..9f65a0764aab 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -18,8 +18,7 @@ from lib.py import cmd
 
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
-        ksft_run([test_v4, test_v6],
-                 args=(cfg, ))
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index e7f79f6185b0..f84e9fdd0032 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -99,7 +99,18 @@ KSFT_RESULT_ALL = True
     print(res)
 
 
-def ksft_run(cases, args=()):
+def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
+    cases = cases or []
+
+    if globs and case_pfx:
+        for key, value in globs.items():
+            if not callable(value):
+                continue
+            for prefix in case_pfx:
+                if key.startswith(prefix):
+                    cases.append(value)
+                    break
+
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
     print("KTAP version 1")
-- 
2.44.0


