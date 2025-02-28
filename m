Return-Path: <linux-kselftest+bounces-27944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBFCA4A108
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 19:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E743B2BC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389225DD1D;
	Fri, 28 Feb 2025 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWJfdFCk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05C1F09B8;
	Fri, 28 Feb 2025 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765611; cv=none; b=tTn3qvfzD7/7pvwRCEOUo6X2HNez9Zc0bt1MQYKxZcdoHMYlnsWVgdAJXvK9gfKkBArb6WbgCzzDXkmGqTqp+3M3t9of5ND+F7sJcej/6Qxlfd+UT3MJ8J9Cw5M0hrMInqIZTHaB662sjFD6856XxX3ePXrpCXIPEdnFQIZabaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765611; c=relaxed/simple;
	bh=LNGek2KEOoXjwsDtMm0drAz/BTi7FE9zL0fgU5scCuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJS9E379aGmWHKcYrSTkblV4VEzM6v76dk5vo/CgEVOBN9r6zuYsXRisibZXCMAWZZ2OstcvWXmX8tm3nfJ1kojJXVrr9QEIOc3acy+wI1Qyk0szvcnTPgsNo3aLQ75zVq2JLmMjYNYecXxh6Pg3Y1Euam9dWwUdibfHXXW539E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWJfdFCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17211C4CED6;
	Fri, 28 Feb 2025 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740765609;
	bh=LNGek2KEOoXjwsDtMm0drAz/BTi7FE9zL0fgU5scCuc=;
	h=From:To:Cc:Subject:Date:From;
	b=sWJfdFCkuLChzaVVG2Q3xH+36H2Tzb90t2gwSQ6bQ4CRaC74cU8ZtkLyjol2ROJgs
	 wzMgK/URjcxHzzcqYTcyLk9j6jjXuwiLRpI84ngHIEvuqnBVTyw03fIdIdbZdweVV2
	 8kkn8d3b3LWzCYkX/mF56DXw1p5qJTEvBmEhNjK6/W8RAQ6k4H6fi5AhpxJxPTm5Jr
	 sL269Zlw5+jF1vSGO7E1OkbKyvlf1ZRLvYGXynlSiC14B77EUv1BfVxvUq0cmp7NGq
	 jkpjSTMrOAIUGHSz3IJh3htt8p0teRBnOWYe8CGPkgNQgwsKwvi7ANHfvJmYOEo/wC
	 YZj8NS3irHYTw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	petrm@nvidia.com,
	matttbe@kernel.org,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: report output format as TAP 13 in Python tests
Date: Fri, 28 Feb 2025 10:00:07 -0800
Message-ID: <20250228180007.83325-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Python lib based tests report that they are producing
"KTAP version 1", but really we aren't making use of any
KTAP features, like subtests. Our output is plain TAP.

Report TAP 13 instead of KTAP 1, this is what mptcp tests do,
and what NIPA knows how to parse best. For HW testing we need
precise subtest result tracking.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: petrm@nvidia.com
CC: matttbe@kernel.org
CC: willemb@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/README.rst | 4 ++--
 tools/testing/selftests/net/lib/py/ksft.py     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 3b6a29e6564b..eb838ae94844 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -107,7 +107,7 @@ Example
   1..1
   # timeout set to 45
   # selftests: drivers/net: ping.py
-  # KTAP version 1
+  # TAP version 13
   # 1..3
   # ok 1 ping.test_v4
   # ok 2 ping.test_v6
@@ -128,7 +128,7 @@ Example
 Run the test::
 
   [/root] # ./ksft-net-drv/drivers/net/ping.py
-  KTAP version 1
+  TAP version 13
   1..3
   ok 1 ping.test_v4
   ok 2 ping.test_v6 # SKIP Test requires IPv6 connectivity
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index fd23349fa8ca..3cfad0fd4570 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -207,7 +207,7 @@ KSFT_DISRUPTIVE = True
 
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
-    print("KTAP version 1")
+    print("TAP version 13")
     print("1.." + str(len(cases)))
 
     global KSFT_RESULT
-- 
2.48.1


