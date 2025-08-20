Return-Path: <linux-kselftest+bounces-39375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE29B2DF0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 16:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C548D1C27878
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18C26FA5B;
	Wed, 20 Aug 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNWEv3kR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C09626E6E2;
	Wed, 20 Aug 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699322; cv=none; b=Z8joIzdCo7WsJPgZmJmyodsWNM9kcjVK3jCmP1anwOge2O9gHY90dMnxpeOF/K2LvDnaERRtKqS657s81S5up3RFhT73I1Uatr8qK+V5GrEHbaohWjUw9T80JzlygQvtc62mUtTmJxqZWJ0RKY6gYZOqSy2ziq8HwyQFibXnVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699322; c=relaxed/simple;
	bh=OQQckPddTneOzG/6ku3q22aHRtDHjLTy5HAplDzg1tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXCxe9taBSnqsqA0oeOqkJMeSdJXLRIgx0ovzDs01nPhRL5mhy8Dab2qWGiBrmQ88zd7IH3gHVwH52GZyAxc6OOrPt0HFwvqGU3L8VLeCzX4RyzJz5xAssBN/AVWO+y+WvsqggfZ1k4JM3me7gvDSiieFLpZmNjweb9smh4zPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNWEv3kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919EAC116B1;
	Wed, 20 Aug 2025 14:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699321;
	bh=OQQckPddTneOzG/6ku3q22aHRtDHjLTy5HAplDzg1tg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GNWEv3kRuhJHrg6O8tl9v9XZLUFLD5DX16vsK30S6lje+sJFYSmjGbB5HpZj/VPgh
	 TDjZKX/ifXH7uGh2e+lt7646z7sUlNbnz6+lOCG8Mz8jXy7MI8j1YuGTTbZ6xvJH57
	 jipPJ0uow4hRXRF1c9KdTNVp7S/7eHElmjC41cq9gGl5NWpuyuvWT/+siB4JT/9bLe
	 /aNUEQKLFu8uTm2VkYmAVmqpyepUEFvJtP7oB+4uX3e0gzpo1f3/X+2vkk3/0bUNcC
	 ONwDv7rhR+cpmmZAq0WBuge5vLArgQg88mDxDZj2kF5TweQ54w0nK3wrsLdzD07/Gh
	 iecJL+cNHgT6g==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 20 Aug 2025 15:14:41 +0100
Subject: [PATCH v15 1/6] arm64/gcs: Ensure FGTs for EL1 GCS instructions
 are disabled
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-arm64-gcs-v15-1-5e334da18b84@kernel.org>
References: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
In-Reply-To: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=828; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OQQckPddTneOzG/6ku3q22aHRtDHjLTy5HAplDzg1tg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBopdhuIy7mFDmV+0H0uG28RgkPLA3n2FYlocioI
 EkRcIIBg3qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKXYbgAKCRAk1otyXVSH
 0EAMB/9fwOu0l6w/AEd6V5PAmGwzmw1euLwLI/cTXKU6biaBsNLRTXJ/0qSF5OuHWpuYaFtAvb7
 5JVxDwGYoBJUtTP4kv7zLeHbkkP1xc3a3HFYU7tMh7YhvCyxsIIFFGT1wIHS2NW00PUT91fY+hy
 OZnNkn2ndCuLB0FXpxCyUhYzLPtOnPai3lWS6jy4CY2PAjpILWDLWIYP9C65647CGACa9rgKi3+
 vE5zmbmP0py0s0vB+n7RJZOPZvS/FoTmL8bZTf0fGuUap+2ssl3Lt8NCHDc3u8Kc+AUZ5qaOdHt
 XS1223r7Fnm1G2lVW4qLxjwGKhlABshmaJQ1tpwiRIKjHWoT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The initial EL2 setup for GCS did not include disabling of EL1 usage of
GCS instructions, also disable these traps.  This is the first disabling
of instruction traps, use x2 to store the value to be written.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 46033027510c..0ac14ea4dbc8 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -355,6 +355,10 @@
 
 .Lskip_gce_fgt_\@:
 
+	orr	x2, x2, #HFGITR_EL2_nGCSEPP_MASK
+	orr	x2, x2, #HFGITR_EL2_nGCSSTR_EL1_MASK
+	orr	x2, x2, #HFGITR_EL2_nGCSPUSHM_EL1_MASK
+
 .Lset_fgt_\@:
 	msr_s	SYS_HFGRTR_EL2, x0
 	msr_s	SYS_HFGWTR_EL2, x0

-- 
2.39.5


