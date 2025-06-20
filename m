Return-Path: <linux-kselftest+bounces-35463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A29AE242F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E823BF47B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 21:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A58F23958F;
	Fri, 20 Jun 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DyzeQwiG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E542376EF;
	Fri, 20 Jun 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455589; cv=none; b=sF8JSqGcX6cutanm7kMg3BUFSIr6aWnsp5D9fZlk22m+vemFazCXjdjrKk27Fo2c+7L/k/G2YwIhq9aYv/iXHC2imkWC8Vn05o/0hmKSS5DS63doJdOjmjGlh1mqU1r/grXLzicXrCsrE2JJrKAdMNdZ/kwSkN2XwryW7xlIBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455589; c=relaxed/simple;
	bh=C2vgoysKylfmcrNzQLq3BsQt6CzbAM6YNXWLVhmaDUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nKm9ktt1yXiUEElvpW/djBB/HQeAHq+a8AHDR0K6HfsHcxp+f9dSFQe0B++OaLHirosXSOdBrhSIFSCWJLECYCPQXT/jYuVDq/uOS/IV2STBkZsFKCw27PA3PeqT4fOJEVbMb5GsunenLi4rlqgPrgsLwey0728e1TUYIrSl6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DyzeQwiG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750455579;
	bh=C2vgoysKylfmcrNzQLq3BsQt6CzbAM6YNXWLVhmaDUc=;
	h=From:Subject:Date:To:Cc:From;
	b=DyzeQwiGFW5lkCiZhCN2e95mcPv6p14Uw6toQglLghVNxvYGSos1+9wa58Eowb/BW
	 5hbMXPUC0njVN+7xBCaPKZenknWa2wWMXp8GMkDcR9j2y6fYJI4+MQFnDmhJ43y2S1
	 0KbuRabwVMpEAvh7dqKMxzmt9ycsQT1+ndl8ApLs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] selftests/nolibc: integrate with kselftests
Date: Fri, 20 Jun 2025 23:39:29 +0200
Message-Id: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABHVVWgC/x3MQQqAIBBA0avErBPMSqurRAursQbCwpEIpLsnL
 d/i/wSMgZBhKBIEvInp9BlVWcCyW7+hoDUblFSt1JUW/jxoXgTj4SJyZFH31pjGyE4ZBTm7Ajp
 6/uU4ve8HG57Bp2IAAAA=
X-Change-ID: 20250616-nolibc-selftests-39a774708272
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750455578; l=977;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=C2vgoysKylfmcrNzQLq3BsQt6CzbAM6YNXWLVhmaDUc=;
 b=Zfq2d8U0y+i1o/sm7ch8nTLLUXpzgksVYTkeQZrCB2JmquPhJ3rU7v8DmPSlPGX/R+6XMAIfH
 s1GaG0J6iWxDB5BHupgSPzOmsFuzaBBs8FC4elXd9Iq6K212PDonCaN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Hook up nolibc-test with the kselftests framework.
This enables CI systems and developers to easily execute the tests.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      selftests/nolibc: drop implicit defconfig executions
      selftests/nolibc: split out CFLAGS logic
      selftests/nolibc: rename Makefile
      selftests/nolibc: integrate with kselftests

 tools/testing/selftests/Makefile                |   1 +
 tools/testing/selftests/nolibc/Makefile         | 346 +-----------------------
 tools/testing/selftests/nolibc/Makefile.include |  10 +
 tools/testing/selftests/nolibc/Makefile.nolibc  | 340 +++++++++++++++++++++++
 tools/testing/selftests/nolibc/run-tests.sh     |   2 +-
 5 files changed, 363 insertions(+), 336 deletions(-)
---
base-commit: d7161bd24e41eee5a3cca5bd8caaf1afdf9120c9
change-id: 20250616-nolibc-selftests-39a774708272

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


