Return-Path: <linux-kselftest+bounces-21677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDDB9C1E6E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 14:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D6F1C21A5F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 13:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809251EF937;
	Fri,  8 Nov 2024 13:49:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E01EF098
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073770; cv=none; b=qDnXU+dMdX1sWdkSF+j2MsW6wSYKliGYQ49/5jEWfRSR/HjILWf8kOh6CCQLZ6nB4prkwONuC3OLzAZfKcYhs1gIc2bsg5IpDva8M8I2p34vlv2LV5GSQURvqjlMlKGf6z/A2y4Ou6sHfRPtzRpWmD5/31GQVHgd+SYqdDd4bLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073770; c=relaxed/simple;
	bh=1oejkrjc90HVTjmm/gZTKFFAXSGfBoJXAnsx7NI55H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ql5WZkNILGbJa1iR6fu41HpgafrPr5XA8ZV186fOgbhODaLvzoJKrazh6GXgXfHQ8Yg48EJF/FoXfoIYcWdus11Kw51nWTr91/IgjDyzFJMc/8ssVroy88QVkkuPZxQtkftuLTWZDw3nSbahxCFNtqZg9uCsS1h+7T6ILDIroYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8748C4CED7;
	Fri,  8 Nov 2024 13:49:28 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/4] kselftest/arm64: Fix compilation of SME instructions in the arm64 fp tests
Date: Fri,  8 Nov 2024 13:49:20 +0000
Message-Id: <20241108134920.1233992-5-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108134920.1233992-1-catalin.marinas@arm.com>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMSTOP/SMSTART require the SME arch extension for the assembler. Add
'.arch_extension sme' to za-test.S and zt-test.S.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 tools/testing/selftests/arm64/fp/za-test.S | 1 +
 tools/testing/selftests/arm64/fp/zt-test.S | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index f902e6ef9077..9ebeab6ce5c0 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -16,6 +16,7 @@
 #include "sme-inst.h"
 
 .arch_extension sve
+.arch_extension sme
 
 #define MAXVL     2048
 #define MAXVL_B   (MAXVL / 8)
diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
index c96cb7c2ad4b..ad550463d31d 100644
--- a/tools/testing/selftests/arm64/fp/zt-test.S
+++ b/tools/testing/selftests/arm64/fp/zt-test.S
@@ -12,6 +12,7 @@
 #include "sme-inst.h"
 
 .arch_extension sve
+.arch_extension sme
 
 #define ZT_SZ	512
 #define ZT_B	(ZT_SZ / 8)

