Return-Path: <linux-kselftest+bounces-22540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F079D98F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 14:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6162162201
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 13:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59D41D5160;
	Tue, 26 Nov 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="tDdg/Uwa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13760946C;
	Tue, 26 Nov 2024 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629543; cv=none; b=QvF2z+35ctzWWSaszVdI+LHm71vKis5nN507nM9BWp4iyqmDy00xSvigiZKOis94y/EoNJ3p48JK4g6K/87NBasc6gBfg5sDftT+QuDUq6O4DpWMKKh/tF8nUCYD/EssO8RDCjq152SjJfhoD4mDpYm/I6ooqZWrB5HEWjArjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629543; c=relaxed/simple;
	bh=pZ2YZdpgemFDCM+U+LkA/ySjT+wKLlrQ03YQqJSyhxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jbtXab75SBJ2+t0RiI3ySH35G2o0ZGTlalRjgkKcyRrZ57Z4OzheJXB6HcFkZoA4dAE+Q6l4Bzk65fhi7IZ56FlZArHI6/e2KUuWMZurm4iqd5jWSulFWdezTKyxNhwzqp71xMQ2kcBoK/E8/70FtqG6To7NflkvNeBiIm3iLM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=tDdg/Uwa; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1732629543; x=1764165543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RSXk5sIMAikPeTQyZJR0m9fbpuoQIFByJet2DRoFnyc=;
  b=tDdg/Uwa/d66o7DATTHrmdFI8Tc/Fb/L2tohpruce1RY2sA4kyt4UgJz
   dhO9XbwM1j8vynpnB0uteCr4Wt2Tg15PjctKqeI4YbKS4DBHpWMbrt7oc
   abnN0rq7Be10O5Cmkz7H4DzGmhJk665XfkgGFhK0tq3IHa1aob3088qg4
   s=;
X-IronPort-AV: E=Sophos;i="6.12,186,1728950400"; 
   d="scan'208";a="778791635"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 13:58:57 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:51298]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.116:2525] with esmtp (Farcaster)
 id 9b821c50-75a6-4ca0-bdd1-44056ebbaa70; Tue, 26 Nov 2024 13:58:55 +0000 (UTC)
X-Farcaster-Flow-ID: 9b821c50-75a6-4ca0-bdd1-44056ebbaa70
Received: from EX19D008EUC003.ant.amazon.com (10.252.51.205) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 26 Nov 2024 13:58:54 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D008EUC003.ant.amazon.com (10.252.51.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 26 Nov 2024 13:58:54 +0000
Received: from email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 26 Nov 2024 13:58:54 +0000
Received: from dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com (dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com [10.253.68.42])
	by email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com (Postfix) with ESMTP id 6BA7E801E0;
	Tue, 26 Nov 2024 13:58:53 +0000 (UTC)
Received: by dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com (Postfix, from userid 5466572)
	id 2945BB5BE; Tue, 26 Nov 2024 13:58:53 +0000 (UTC)
From: Maximilian Heyne <mheyne@amazon.de>
To: 
CC: Maximilian Heyne <mheyne@amazon.de>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Peter Hutterer" <peter.hutterer@who-t.net>, <linux-input@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests: hid: fix typo and exit code
Date: Tue, 26 Nov 2024 13:58:50 +0000
Message-ID: <20241126135850.76493-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The correct exit code to mark a test as skipped is 4.

Fixes: ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 .../testing/selftests/hid/run-hid-tools-tests.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/hid/run-hid-tools-tests.sh b/tools/testing/selftests/hid/run-hid-tools-tests.sh
index bdae8464da865..af1682a53c27e 100755
--- a/tools/testing/selftests/hid/run-hid-tools-tests.sh
+++ b/tools/testing/selftests/hid/run-hid-tools-tests.sh
@@ -2,24 +2,26 @@
 # SPDX-License-Identifier: GPL-2.0
 # Runs tests for the HID subsystem
 
+KSELFTEST_SKIP_TEST=4
+
 if ! command -v python3 > /dev/null 2>&1; then
 	echo "hid-tools: [SKIP] python3 not installed"
-	exit 77
+	exit $KSELFTEST_SKIP_TEST
 fi
 
 if ! python3 -c "import pytest" > /dev/null 2>&1; then
-	echo "hid: [SKIP/ pytest module not installed"
-	exit 77
+	echo "hid: [SKIP] pytest module not installed"
+	exit $KSELFTEST_SKIP_TEST
 fi
 
 if ! python3 -c "import pytest_tap" > /dev/null 2>&1; then
-	echo "hid: [SKIP/ pytest_tap module not installed"
-	exit 77
+	echo "hid: [SKIP] pytest_tap module not installed"
+	exit $KSELFTEST_SKIP_TEST
 fi
 
 if ! python3 -c "import hidtools" > /dev/null 2>&1; then
-	echo "hid: [SKIP/ hid-tools module not installed"
-	exit 77
+	echo "hid: [SKIP] hid-tools module not installed"
+	exit $KSELFTEST_SKIP_TEST
 fi
 
 TARGET=${TARGET:=.}
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


