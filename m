Return-Path: <linux-kselftest+bounces-30999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205AA91052
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D733C189559F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39261A287E;
	Thu, 17 Apr 2025 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZQLo9yd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55386352;
	Thu, 17 Apr 2025 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849556; cv=none; b=rRv3aXE+izwdZVUEj1c75VUJ15dx9Z3H6Z1KSW05FPycG8+yF2IPn1K0zJxPijG8ODVY1gWqJL/N6SMXxJXXzGoKm7CjZnKi1zCXThWYpHOCwIU+2I8YgGlVEapFFhruAWpel5oNNm5tjKIjyDfQObDj1CGiZTY8/0h74+thVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849556; c=relaxed/simple;
	bh=tPu3T/ssrLPDpFX8WvOwNRnWMZeoT9OAjrJWDn8Vwx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ChMDC51LxTroJ6oHZfGm/GF71cSeH9FTjAw0Dau73e/X1kaDvinIUGtz3aWbkPa/2TR6SyfpCZZRPqaj2INamjhpVFGufOFPC3UuRwOZrHjoxRnhps/4a/d8/CRzpai51532TAUGINSV1g4+oYym0C0mSo1Bt8HSVPEfbcXgzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZQLo9yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E07C4CEEA;
	Thu, 17 Apr 2025 00:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849556;
	bh=tPu3T/ssrLPDpFX8WvOwNRnWMZeoT9OAjrJWDn8Vwx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oZQLo9ydMVLxzdYzQ9RK60r1FW7dPEbCTAswkPteIJsmUr9GgXFv4hORixeSsURCy
	 1nA2hduyaKSogcRqAh4udgKbcrbK+aAWA4TSkbXQV3oIOa07NuoMFEXI0iPXYsd+Ra
	 j8OIsoTdAXXGIX9mK/P5fi27y85Z6FqHoRpwKLGIdemJpWddIfyExaGTObjnNWH63T
	 PQQyLLohAloBiBEBcFMEbqkNxYL/oJocYeaih47rsJFS8bxK4UeI2p1+D8ld2TCUaG
	 ptYMwS8zZ4O4kLQ+Uh6ge9YZYqzfFjgjCIv62eGnLxrO5wKxx3fB1u2iwTSJi2GrYb
	 0Iu6G1L+bXzCQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:07 +0100
Subject: [PATCH v5 03/28] arm64/fpsimd: Check enable bit for FA64 when
 saving EFI state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-3-f469a2d5f574@kernel.org>
References: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
In-Reply-To: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tPu3T/ssrLPDpFX8WvOwNRnWMZeoT9OAjrJWDn8Vwx0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEpxxYFzzmZ8wZSn8UroEkSMQbZKdAPgqAK1wThy
 CmeEtziJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKcQAKCRAk1otyXVSH0Lh7B/
 40Li96Qf1d/u6urBOWrA+jCl0rvogHJVY5H5GpHIDuVmr6+HdGdtQrG5obR2zPCrprSLLQe90fg7hR
 DFvslYEmd6jP6muZG32DInOuNHGtkcKpiwj2wMETd03Z+140KCFgGIPqiqnUYDZS5lqjjvziCOC0Lj
 WM8zMEKwcLDTbHjSLBZFFUmVX/VurzizBZQ8LFk3Sv5LvD52SFBalF7jP2KcfPJWxMjnvExXOR3vgs
 GCfJd/llnvJfqLsntJSmNUryVoxx8kwgqGGek+nIhC5kbQ382lH0bwXQq0Tzzw8yuvfJDPCGGqehS+
 b1VMi9LCt97sPMvJHga3V/84q/gvR/
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
index 266ce7a9f195..83a4f8d3e895 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1913,6 +1913,11 @@ static DEFINE_PER_CPU(bool, efi_sm_state);
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
@@ -1947,7 +1952,7 @@ void __efi_fpsimd_begin(void)
 				 * Unless we have FA64 FFR does not
 				 * exist in streaming mode.
 				 */
-				if (!system_supports_fa64())
+				if (!fa64_enabled())
 					ffr = !(svcr & SVCR_SM_MASK);
 			}
 
@@ -1998,7 +2003,7 @@ void __efi_fpsimd_end(void)
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


