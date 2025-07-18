Return-Path: <linux-kselftest+bounces-37603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8584B0AC13
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 00:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920791C27ABD
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8F6221FA1;
	Fri, 18 Jul 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLu/ihKp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AC917CA17;
	Fri, 18 Jul 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877017; cv=none; b=AUu0w50HSr9RTmLi6J3zB1nVBhfnPFXxlJ04tjWUeim5YHxjpA/w2ziwF2DQGDbDdzxIpNs2A64MV4Ya0yRf0UzF7Zj6YrLTZoLuQ2uwHhIYbyTsqVT0JPCwI0bLpYt51aO5omAP2xWLmmME8jayQkB8ptGXhaHoQp3iCtEckQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877017; c=relaxed/simple;
	bh=r0RFJLu3chixovmZTNacoWht9HF6iXxmx1ISjsYOiz0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OhCnEue9j8+V9UXbt8k0tRxv/827qsYcBTJz8uSboFo7TqzdpT8A/PPiMXLa0Cazwixl8OCI7zhhlLxH7l52XUkNnhoyh4n9QhaJQmzW3W03vG/tBB2U1lBbrC+Amu9ShoX+dmzhIhaJm9r5dPJ8lFaU23ze79/PS27HRYp8EHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLu/ihKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43A8C4CEF1;
	Fri, 18 Jul 2025 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752877017;
	bh=r0RFJLu3chixovmZTNacoWht9HF6iXxmx1ISjsYOiz0=;
	h=From:Subject:Date:To:Cc:From;
	b=dLu/ihKpKjUgyEXIOpeR0kCdH/cDC5wJMJ001PuWCEroEitYpMe1vBlha9QO3Clrv
	 xofa7OkpgiBjZEzm1EfX17MzviULfQhLdBJPYdKeXI+ExOpqW8jVpWdW10kA+orTgO
	 KCisHHtkQP68zy7t+8g2PUou7YW6mbi+TaGlHyZJA/qwhyeyzrEb1I2k5/SvEjzyQz
	 5lRN/T4WF6sI4afOP7EQw6u/fi5Wv8ah2afOeJd5D04gynbvPjJiobqmXmG6BGwdjw
	 s5ZjEUACfHsDZpIxqIiLsU+fymc8tYxPcTPan4t6c+2tyZz4zQV2wgAZ/4llbrGE3D
	 fX/VOOQjZs2tA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] kselftest/arm64: Fixes for fp-ptrace on SME only
 systems
Date: Fri, 18 Jul 2025 23:14:49 +0100
Message-Id: <20250718-arm64-fp-ptrace-sme-only-v1-0-3b96dd19a503@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnHemgC/x3MQQqEMAxA0atI1gZqHa14FXFRbaoBrSWVYUS8+
 xSXb/H/DYmEKUFf3CD05cRHyKjKAubVhoWQXTZopRtlqg6t7O0HfcR4ip0J0054hO1CO9XaOOO
 VqzXkPAp5/r3rYXyePxiB4KhqAAAA
X-Change-ID: 20250718-arm64-fp-ptrace-sme-only-ab327d7f0d32
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=broonie@kernel.org;
 h=from:subject:message-id; bh=r0RFJLu3chixovmZTNacoWht9HF6iXxmx1ISjsYOiz0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoesfUa9Bm1z2D3Gq+jJPU0PD2Vbmqp7+5TV6lQ
 wcKyMeQICCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHrH1AAKCRAk1otyXVSH
 0OvpB/4namfzyPgsrTcckROrMuyeAGcdlOIUq8Wm2ddk3GBx7yfxv3W18p8aeM4Je6ht/3LEKbP
 mrVsoA4b5Xqs3NpgK4GBrUg9LcEi8Itl4ORlap9Y6Oyna+kyuUrjZFTiDH8HuLeh6uJyzjMnlAT
 Va0LQevVR9lgdv+y5oqnYHLFE3uHUsiNauyoCOywzDXRmPRlrcz9x7cquaAkKB9WPm5I8LtHdf4
 uzkiGbMgjdTgPz7CAXYFuGwIzfUMk+d2CSKayhPH0x2zees02qrSZGcYQyWgIoPAVwlOXbyJwrY
 YE75j7eDRXa68rPLnYhZZuiZgGafvbB7VauXjqOAqYnJqIIw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When testing SME only systems I noticed that fp-ptrace does not cope at
all well with them, this series fixes the major issues so that the test
program completes successfully.  The reason I was looking at this is
that following the recent round of fixes to ptrace we do not currently
offer any mechanism for disabling streaming mode via ptrace, this series
brings the program to a point where it tests the currently implemented
ABI.  A further series allowing the disabling of streaming mode via
ptrace will follow.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      kselftest/arm64: Test SME on SME only systems in fp-ptrace
      kselftest/arm64: Fix SVE write data generation for SME only systems
      kselftest/arm64: Handle attempts to disable SM on SME only systems

 tools/testing/selftests/arm64/fp/fp-ptrace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250718-arm64-fp-ptrace-sme-only-ab327d7f0d32

Best regards,
--  
Mark Brown <broonie@kernel.org>


