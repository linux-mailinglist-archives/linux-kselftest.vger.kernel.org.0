Return-Path: <linux-kselftest+bounces-35746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20E9AE80ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638F9189FB15
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CDB2D4B67;
	Wed, 25 Jun 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpyGyihb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338292D4B49;
	Wed, 25 Jun 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850698; cv=none; b=jDwjWqza7KloEKTSqqX24Bf9seTLPzPmjXRcIaVnVHQzLU42Hc4sSnZsQbGsCVuw9V7pYxrQueRcPbMtBvkgzY/RCxjQQhseuXBDS3gH1p8YhWvKUPZ8YvIZaidgWWtb9Aj73+Un6ocfpVGtnyrgIzpccOfp9OcFLBYHdmXnq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850698; c=relaxed/simple;
	bh=Rg1wsJ3gpmGTtJKL2YMiJAj+B1RPC9bu8N2e6PnFCu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jD/uYLyG5yEYqz+JlienoLXFyLw29SBhv2JxVfoCxWWnRaZdLv2ZE5dH+U3FoRKNH6dUVHgVYdaN7JQSzCqotvZfdUO3VHMSqjMH1uWm/xsdXZ9XK7UJfd+JM+sAwryJYOWGiWiQzbTCOJUd0QGOzpfRO+V2a8+hLOcdciybb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpyGyihb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6899C4CEEA;
	Wed, 25 Jun 2025 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850698;
	bh=Rg1wsJ3gpmGTtJKL2YMiJAj+B1RPC9bu8N2e6PnFCu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RpyGyihbqD4osWIxx766bzikgutuVsKv2kJfogvSQEnJLKvfPgZjow5BFr7eKrJGd
	 nVqPnK7Cpb4hKmlat/8RsQSDh/COUmxsz1XlYw0goEgmZp13iy0v8MGXVI/Lf1PoDw
	 jCEoNrvmDSFSCwkerikaVSufhU+2xOuRm8RuWMB2k2jzvZvsvKCptrlnfPDr8idu9y
	 PpBGYTMjijmlabT2Hzw2rtehx/CnqFK+tYK/sfmeRRbNuWLUQTHF39I+ZFpFdd+EWM
	 WQ8Iwy5KES4j9XxeZbSJWT+KwRVN1Vwn7y14Awldipbl6+w94dzZTVeO4RmHRzmFWJ
	 ruVERYfHrHkqA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:47:54 +0100
Subject: [PATCH v6 03/28] arm64/fpsimd: Check enable bit for FA64 when
 saving EFI state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-3-114cff4ffe04@kernel.org>
References: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
In-Reply-To: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Rg1wsJ3gpmGTtJKL2YMiJAj+B1RPC9bu8N2e6PnFCu0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xnioDhhGxNI6CJ8F21YKG6+7JQI3B5kNGiW
 oZlAcAeLtCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcZwAKCRAk1otyXVSH
 0Pq3B/0W/8d0AqujRf5FkiOLjTfmDdxP+CMDwt08arRHr3OU9IGUWwK8fP0bRQjvTFWITJo2TN1
 jSRYk79ugbeXg9Q3bQb6v9u38fDCXclXrv7w4v6E+E2I1rjGmOxB5d8uzL+9ukCFnouTU6vDfO3
 RkOc2bybDx6DXcn8J7iXNsxcXnhcFxxfwgU7Nd5FfR3yPWWaX8Yt8oPdZ+VJp4CskT6cQ8NOr6t
 mRuaWfVSwywiiHzJjNNKO14bkTT0IbEGaAWVagyNR8M+W6vKY2y07zPFH1i8hnttzC2hfTr38Ij
 t2f98tbcw0eQBm4QeNRVBIwtByNMvrtz4p5A/Y3aj15aDMZR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently when deciding if we need to save FFR when in streaming mode prior
to EFI calls we check if FA64 is supported by the system. Since KVM guest
support will mean that FA64 might be enabled and disabled at runtime switch
to checking if traps for FA64 are enabled in SMCR_EL1 instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 77f9dfaffe8b..de2897d6208c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1908,6 +1908,11 @@ static bool efi_sm_state;
  * either doing something wrong or you need to propose some refactoring.
  */
 
+static bool fa64_enabled(void)
+{
+	return read_sysreg_s(SYS_SMCR_EL1) & SMCR_ELx_FA64;
+}
+
 /*
  * __efi_fpsimd_begin(): prepare FPSIMD for making an EFI runtime services call
  */
@@ -1940,7 +1945,7 @@ void __efi_fpsimd_begin(void)
 				 * Unless we have FA64 FFR does not
 				 * exist in streaming mode.
 				 */
-				if (!system_supports_fa64())
+				if (!fa64_enabled())
 					ffr = !(svcr & SVCR_SM_MASK);
 			}
 
@@ -1988,7 +1993,7 @@ void __efi_fpsimd_end(void)
 					 * Unless we have FA64 FFR does not
 					 * exist in streaming mode.
 					 */
-					if (!system_supports_fa64())
+					if (!fa64_enabled())
 						ffr = false;
 				}
 			}

-- 
2.39.5


