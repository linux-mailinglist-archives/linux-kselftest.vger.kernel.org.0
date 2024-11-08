Return-Path: <linux-kselftest+bounces-21690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C640E9C2045
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A4B2167E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C7B2038C0;
	Fri,  8 Nov 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="triUdN6v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7502038BD;
	Fri,  8 Nov 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079347; cv=none; b=YNiUSaJ1r0aYT52CLxjsE44X7fUBcZeR2IfeSfAPWV/uSqdX+rPZCz5SEOVuF8lkMtFww3Z4dS6yy6lEp384bevoAWZdcVQ+FZQswdcOT1glrIERVmstDb192vg582IJudS86XhLI7xja5IH62J0bkyiwWuYLzt4Z0Y7ynyu5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079347; c=relaxed/simple;
	bh=9MmFQC6J2fkpekXm5iWYwsyMilxxoBeL/WcxpybUov4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p79N8MH+9hjrb3O765yQlJFK39R+kPk7BZEsP1LWdd9N7c0tJGiEgNcUpytQAeHJJnhjlZQIEatK2mZjp0NjSOgZnJ4y7otM8oiVYk07b8p/IHKQ68AaCSB+jx2EoI826GD3lRiHPMEGIoBoC6Xjyb3ApRjZBfU31UjJ8gLsngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=triUdN6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B975C4CECF;
	Fri,  8 Nov 2024 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731079346;
	bh=9MmFQC6J2fkpekXm5iWYwsyMilxxoBeL/WcxpybUov4=;
	h=From:Date:Subject:To:Cc:From;
	b=triUdN6vkvHdywvVxNXLrYvEeFlYEHBRIZ/tKEH47DJNYeBPeeOjixkBD4d36qyzH
	 kEKvTDVmwdijOoMY13OV3xpSEABzm5vOfuHE42JrriSKBHBz1EOCcvyGas0p+68ZK7
	 XvJx6hdUCLqr8hgRW2d+YGJ+nuX1XaGhwAniedxqxXtIxcnSgHGTgUkwjVGoJnjzJe
	 dchB3JhCXprzY/bSRUXYa+gQtD6tiMXG57rkezV+DbDcHvfFox9Cu4XtPdWc2ESaIq
	 6RIbMGASdT5gvbThPufafY85hOC1KF5RonfUF/z0ZgnArT9VcphBn/iQA5kMFoRqxW
	 lkokMX5H42PCw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 08 Nov 2024 15:20:46 +0000
Subject: [PATCH] kselftest/arm64: Fix build with stricter assemblers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-arm64-selftest-asm-error-v1-1-7ce27b42a677@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE0sLmcC/x3MywqDMBBG4VeRWTuQqKniq4iLWP+0A/XCjJSC+
 O6GLr/FOScZVGDUFycpvmKyrRm+LOj5jusLLHM2Va5qvHcdR10eDRs+6YAdHG1hqG7Kc9uF1iG
 4qZ4o57siye+/HsbrugE4X0FnagAAAA==
X-Change-ID: 20241108-arm64-selftest-asm-error-d78570e50b3b
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9MmFQC6J2fkpekXm5iWYwsyMilxxoBeL/WcxpybUov4=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhnQ9nQ1lLpar7slFR1WUXHNSeZ+0XW3V+quWdxckBHjKJpQ2
 pxh2MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQAT0f7J/lc4dOHBddzHebKc7P8cFf
 KUn6KyoL7GlL1L5f0tkSpx3Rf/rFTXcjn8T3T4MKnih4Bs12c3hSWnpPoLnGxcuiIXt+4KsfbRVp3y
 4Wy9bdrlCOV/azqkpjxnXpn+18/lP1+rvPusa3HqQd+f371aqROiHpOv3Gq10eh6rvqr7GMnFFxzSn
 fKua5X7j7AxRGZaHhqw2vtmcwX/nVo7UqsX6Gy6lmA+IFXd6UW2rz/u+Xfj1ML1237nBXB8YwjSGq7
 d+62sy+Mrvil9y64X5eW5JMUt4qrmo0lnFF2ystTX6d27Z5r+4AjY5vunnkexskmOxRnW/SrWs8qz4
 0rXMt9Na2vaO7X+Ei3LoMPPkxHAQ==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

While some assemblers (including the LLVM assembler I mostly use) will
happily accept SMSTART as an instruction by default others, specifically
gas, require that any architecture extensions be explicitly enabled.
The assembler SME test programs use manually encoded helpers for the new
instructions but no SMSTART helper is defined, only SM and ZA specific
variants.  Unfortunately the irritators that were just added use plain
SMSTART so on stricter assemblers these fail to build:

za-test.S:160: Error: selected processor does not support `smstart'

Switch to using SMSTART ZA via the manually encoded smstart_za macro we
already have defined.

Fixes: d65f27d240bb ("kselftest/arm64: Implement irritators for ZA and ZT")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/za-test.S | 2 +-
 tools/testing/selftests/arm64/fp/zt-test.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index 95fdc1c1f228221bc812087a528e4b7c99767bba..9c33e13e9dc4a6f084649fe7d0fb838d9171e3aa 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -157,7 +157,7 @@ function irritator_handler
 
 	// This will reset ZA to all bits 0
 	smstop
-	smstart
+	smstart_za
 
 	ret
 endfunction
diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
index a90712802801efb97dc6bf8027fb9ceac8f0a895..38080f3c328042af6b3e2d7c3300162ea6efa4ea 100644
--- a/tools/testing/selftests/arm64/fp/zt-test.S
+++ b/tools/testing/selftests/arm64/fp/zt-test.S
@@ -126,7 +126,7 @@ function irritator_handler
 
 	// This will reset ZT to all bits 0
 	smstop
-	smstart
+	smstart_za
 
 	ret
 endfunction

---
base-commit: 95ad089d464da2a4cd4511fb077f25994104c8f1
change-id: 20241108-arm64-selftest-asm-error-d78570e50b3b

Best regards,
-- 
Mark Brown <broonie@kernel.org>


