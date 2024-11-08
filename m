Return-Path: <linux-kselftest+bounces-21675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861A39C1E6D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 14:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE8B1F21816
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 13:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A7F1EF95E;
	Fri,  8 Nov 2024 13:49:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1541EF937
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073767; cv=none; b=JMdSkvWBQJ/HXWTj0Pj83vb8f2Tk4kdIR/OVRJwDQK4wlkyxGXJolDXDAs/9PF3z/qkP+FK5Z1uzRgHsLaxYc+TAaGkOMMUOl/3uto6UN8+EJDs0/Lqpoq9F6axftMTbKf+p5Gl5cydk8qd64srzjsKvkU+653RoKTRLqhwfsr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073767; c=relaxed/simple;
	bh=9bKsogD2OWhfTMBzSLX1Yk0aZ1Ch1C6TsE6iHtWB2vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q14j83pouUcC/tTLX/JGUElHGolL2vaBKcEURItysE5qiqm7zifzwmX2yqAgdQ58u5MnBNlCyHwnygDT/IQW61jaV/gcGpteC6FnKU5mq1BUbibjGb8eF6PQeBEKO7ETEKAN6eB87m1KWsgHXPV7YgL5ABg+puoAzenLu+ver2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC906C4CECD;
	Fri,  8 Nov 2024 13:49:25 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/4] kselftest/arm64: Fix printf() warning in the arm64 MTE prctl() test
Date: Fri,  8 Nov 2024 13:49:18 +0000
Message-Id: <20241108134920.1233992-3-catalin.marinas@arm.com>
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

While prctl() returns an 'int', the PR_MTE_TCF_MASK is defined as
unsigned long which results in the larger type following a bitwise 'and'
operation. Cast the printf() argument to 'int'.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 tools/testing/selftests/arm64/mte/check_prctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/mte/check_prctl.c b/tools/testing/selftests/arm64/mte/check_prctl.c
index f139a33a43ef..51e3f41a54d1 100644
--- a/tools/testing/selftests/arm64/mte/check_prctl.c
+++ b/tools/testing/selftests/arm64/mte/check_prctl.c
@@ -85,7 +85,7 @@ void set_mode_test(const char *name, int hwcap2, int mask)
 		ksft_test_result_pass("%s\n", name);
 	} else {
 		ksft_print_msg("Got %x, expected %x\n",
-			       (ret & PR_MTE_TCF_MASK), mask);
+			       (int)(ret & PR_MTE_TCF_MASK), mask);
 		ksft_test_result_fail("%s\n", name);
 	}
 }

