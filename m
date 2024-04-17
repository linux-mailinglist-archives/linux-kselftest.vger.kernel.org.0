Return-Path: <linux-kselftest+bounces-8284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780768A8F32
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 01:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F512828E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 23:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B138148318;
	Wed, 17 Apr 2024 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHNLo1hD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF7146D4A;
	Wed, 17 Apr 2024 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395519; cv=none; b=YHKfBVHphdT8k+t7PhT8KJxfEgLTN/c3bt57n+w1OhSmiozagsV/HsLpzRHs+nUetYNhlGWdcLSy4N41FUjHrj7q7IaX4Y+P4OglUPHv2UTmblttCNIktjXmi4QEjyqIfTzxK6NuEksJEIKIQkgLDnHj7/kU405/Ba9ftoDdmBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395519; c=relaxed/simple;
	bh=Mr2VNEUpo3DU0d44FbFWmm6+gnfBS9B1jp/iVDpK4jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjhERbvkJh4Px0Wo8X0o8PeYPNwYG/hUxJ23ubAgYBnGMJbx5Dq/3dG59AotwzJtL/TOYVuGDyg3nO43IHwKSVvhH440Ja6fNzBNSdgArNROI1WPZOHuXDuL4d/2e9EciKu9m1qcy09KQnPEhovoHRhJttQCh8L1ccbT34Z4h1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHNLo1hD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2726C32781;
	Wed, 17 Apr 2024 23:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713395519;
	bh=Mr2VNEUpo3DU0d44FbFWmm6+gnfBS9B1jp/iVDpK4jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHNLo1hD1RuPfROfXFk+PQ9HqymFwXZ0Czh43t9o5xb3vu2hOsjRY8SYBbyhi3xzC
	 3+GNUXbclLrcSUhH9vF/J0O7dH9C0RmZNy9LZU9L4ue8zs9jjA5IVFidDfsKK7rpsT
	 eI3i8lM/tK1a8RYIEgvYNf7I05JD8WYFuvhoRnaXAkxMK2FwHZJ+/wHNTgIoLkJqD1
	 EhkMsMxaq6IedWRiS/n2WMYCtG/d49FZc+GzG6Axa/hsyFIi2oc6o5fEoHJZYk9F0Q
	 1Netjohc7p45OUKMYeaddo7uKwhNYs20cSykff/8sg8ItKk+X1vXEI4dmI2bPDOTcS
	 6nrj9QzvUz8QQ==
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
Subject: [PATCH net-next v3 7/8] selftests: net: support matching cases by name prefix
Date: Wed, 17 Apr 2024 16:11:45 -0700
Message-ID: <20240417231146.2435572-8-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417231146.2435572-1-kuba@kernel.org>
References: <20240417231146.2435572-1-kuba@kernel.org>
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
 tools/testing/selftests/drivers/net/ping.py |  3 +--
 tools/testing/selftests/net/lib/py/ksft.py  | 10 +++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 7dd197836ff1..58aefd3e740f 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -24,8 +24,7 @@ from lib.py import cmd
 
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
-        ksft_run([test_v4, test_v6],
-                 args=(cfg, ))
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 25f2572fa540..fe4025dc5a16 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -81,7 +81,15 @@ KSFT_RESULT_ALL = True
     print(res)
 
 
-def ksft_run(cases, args=()):
+def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
+    cases = cases or []
+
+    if globs and case_pfx:
+        for key, value in globs.items():
+            stats_with_pfx = bool([pfx for pfx in case_pfx if key.startswith(pfx)])
+            if callable(value) and stats_with_pfx:
+                cases.append(value)
+
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
     print("KTAP version 1")
-- 
2.44.0


