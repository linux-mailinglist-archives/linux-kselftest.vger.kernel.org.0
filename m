Return-Path: <linux-kselftest+bounces-3336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D2836D2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2F11F28075
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F75B67753;
	Mon, 22 Jan 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJBd4t8W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF26774D;
	Mon, 22 Jan 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940914; cv=none; b=stBQwGpK6JL838Fy8uZUOJulCvx76LWWpuR9te5TDgWnGsDX08pBcoZXOlUQisrwMyHCQE7tBv9i5AbeEubUW7zmb/obJhypxuns9n4sUqudp8clicDBmXxbdlK4HBxKEYsc3vZBe/064+Xcynfu0RWp4rlM8HmqS3msF31Uynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940914; c=relaxed/simple;
	bh=Qp/OLT7QLi4uk/x6r4Fkb7gvrzfeB7lceJVKTlrTKU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uatbYq8vyyHkviNBU6CGZQCByWwE66z9cWXH8416BPXyfzNpal9QHl1mrMdboIAzxvUuha/dwtYU/kOJKE+UmaPmYdRq3wJvsmiGovy4ZLO6NcwueYZE4rLSYBmWzxLATcQ8E5SpLVd+XHTBWZAt30ABJhmqOXr5lLGVAyy4BB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJBd4t8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A90C43390;
	Mon, 22 Jan 2024 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940913;
	bh=Qp/OLT7QLi4uk/x6r4Fkb7gvrzfeB7lceJVKTlrTKU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mJBd4t8Wz6DQYM52XvR1xzeJT76x93XM4CBh9LG6VHAPu0HfY1g4lM4jxyWTXBezX
	 AqXM0knEHnLvLpzwSK+GnLXnvO+y/1dPgTClV2BhZ0Hop+jeqawCipI7xs6jzWn+s4
	 wS5nJFQ9Zsns0L1dgG+Yv6cOHSLDwFl402uknGVo0SGxe8PH2ifXI1BelWaJ66jQKR
	 nulaAboEGn/ESXabiGjyMjCcyX1TpO47YXQTghkhbu/WwHT0KEDmZCShwUyrdG5uFz
	 3nzur7dhfpMOwRfnPznlXU+LCGcH9cwgCiwic6fdkRrwduUQLvy71msqEyyN5l0nHw
	 ASWSgqR6k5G2A==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 16:28:05 +0000
Subject: [PATCH v4 02/14] arm64/fpsimd: Enable host kernel access to FPMR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-2023-dpisa-v4-2-776e094861df@kernel.org>
References: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
In-Reply-To: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <dave.martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Qp/OLT7QLi4uk/x6r4Fkb7gvrzfeB7lceJVKTlrTKU0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpec4p+G3EKXzQYPPBophA42SzK8ipBGJr+BQD+Y
 4h4az9SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6XnAAKCRAk1otyXVSH0APPB/
 9xqKY6eNJoqiWFlOSWK23QCd5rnjH3s/Kwah7jqWMC5p74IUPkIAyjJ0g30PqPJOm+cRQY+C2YtAP/
 0f86fU80gP45qXi6UQxtZWH4zMEEgVMjrIAl1LNBqITyqwggoOYmoMfECskFmpZNaLYJbtwkwgwN+H
 Xb9++lrRSPSoFZAu4QugFYofnRXIZ2PF74A+S9oGCKtcBdsyYhvEZ538xIV9xndSQ4CcIXvbTJ1SKu
 hMr1g63KI8nzOKJTW6i7xJFyIGwH9jH6VF5Q38ETcqXmes7GU0zCTwAJzPhLuZwta/T3eCuTs1y1/U
 3+pPBVhIVNBW2O0eF+Wz/+sBR8LS0b
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_FPMR provides a new generally accessible architectural register FPMR.
This is only accessible to EL0 and EL1 when HCRX_EL2.EnFPM is set to 1,
do this when the host is running. The guest part will be done along with
context switching the new register and exposing it via guest management.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 3c6f8ba1e479..7f45ce9170bb 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -105,7 +105,7 @@
 #define HCRX_GUEST_FLAGS \
 	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
 	 (cpus_have_final_cap(ARM64_HAS_MOPS) ? (HCRX_EL2_MSCEn | HCRX_EL2_MCE2) : 0))
-#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En)
+#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM)
 
 /* TCR_EL2 Registers bits */
 #define TCR_EL2_DS		(1UL << 32)

-- 
2.30.2


