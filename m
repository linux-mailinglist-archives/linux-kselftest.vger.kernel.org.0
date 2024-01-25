Return-Path: <linux-kselftest+bounces-3602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A20A83CD5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 21:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C760528C2F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF9E135A48;
	Thu, 25 Jan 2024 20:24:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sxb1plsmtpa01-13.prod.sxb1.secureserver.net (sxb1plsmtpa01-13.prod.sxb1.secureserver.net [92.204.81.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20822137C20
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214291; cv=none; b=jMaLsCnscE/DfxuhneHslFNZsSptw+LGURNsylwN6wOVdxC0rJmpOgo3AXbc5RapQRIetZbeS7Ayb9ZGJpkLXbdszyX+JbcDU/jhm0YDDkNz95VQmtSH8xtpLLGAz3ZFklQ54z9t++7gV9mcrTZe8jLCyoGh2p6RXS955JGLUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214291; c=relaxed/simple;
	bh=2iAHAYOxukd0KfNPaAPyXavkvqiO5H+yc5eKJzi8EC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hKTBalW9XR1ERTcF0jPeHxeeWNHrGqquIzl+DubgFQAEUrYPXvBi8NrFK0bZEAJcC9m4bDY6VfDiMttVG9vL1Q42WUfnxdyuWdBMpVSHWcM7C23BenlxXhNmnnIGJ89bwaidd1fCOM2d8JvrkA21fPT7XqJ2aq+fqyYWn/Mmzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exordes.com; spf=pass smtp.mailfrom=exordes.com; arc=none smtp.client-ip=92.204.81.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exordes.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exordes.com
Received: from exordes.com ([87.92.236.132])
	by :SMTPAUTH: with ESMTPSA
	id T5wFrD4qKFllpT5wTrOgjS; Thu, 25 Jan 2024 13:03:18 -0700
X-CMAE-Analysis: v=2.4 cv=IMqhCRvG c=1 sm=1 tr=0 ts=65b2be87
 a=2E+36ROA4JFpaWoRYG/7Xg==:117 a=2E+36ROA4JFpaWoRYG/7Xg==:17 a=eCYXQZmkAAAA:8
 a=N7fNtN1KWhDluukBlBYA:9 a=77AlN4CNbnqoG63BkLSu:22
X-SECURESERVER-ACCT: dai.lu@exordes.com
From: Lu Dai <dai.lu@exordes.com>
To: skhan@linuxfoundation.org
Cc: Lu Dai <dai.lu@exordes.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: fix dependency checker script
Date: Thu, 25 Jan 2024 20:05:04 +0000
Message-Id: <20240125200504.7175-1-dai.lu@exordes.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfO7irQ2YqjIVQYtnt9SKsJSVqn9XZ8HMtdAEQH6Pvlk0PYnuzeT3atCy1V17VmmG1aA7OcU3I6h7ibmMb+LYiN+MbPtpicAJqMGA9kdEeMuK0IJLbLL0
 wPjkBY+z/tZikzECFMH0sg5cNtBGbwUWllrU+CZbg0A29sTAxv7RtvmSne/0MQ0WTNDOJN5jYVFxwuOaZYFxgyj7smr/msu/ih4r8rYcl9St2cIkpmfYmAIe
 TGGLN9rnWoLrLv7v/G2U+g/E94Jcpmr7lGXOmC3zQWc=

grep|cut pipe will hang when there is no input for grep

Signed-off-by: Lu Dai <dai.lu@exordes.com>
---
 tools/testing/selftests/kselftest_deps.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index de59cc8f03c3..487e49fdf2a6 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -244,6 +244,7 @@ l4_test()
 l5_test()
 {
 	tests=$(find $(dirname "$test") -type f -name "*.mk")
+	[[ -z "${tests// }" ]] && return
 	test_libs=$(grep "^IOURING_EXTRA_LIBS +\?=" $tests | \
 			cut -d "=" -f 2)
 
-- 
2.34.1


