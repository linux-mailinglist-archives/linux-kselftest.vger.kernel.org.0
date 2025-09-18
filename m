Return-Path: <linux-kselftest+bounces-41895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC79B86BD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 21:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E35580883
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 19:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F42E5D32;
	Thu, 18 Sep 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsShNhSl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB92E54D1;
	Thu, 18 Sep 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224671; cv=none; b=AJQvXQhkHvTmTGrqGarZU8gO1TfjUTHx6zODRQuFFbUKTmRwmTXa5gf1uPDSwfdKAXvsQeN9BecOSD818daOpDaPorGNaQGYjlENjcb568NFJT/6VBdR3i5b4M3z8g+JhXQYojkPgtZNw0DOnQGKMBYEhTS7P+DFdCz12IUVC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224671; c=relaxed/simple;
	bh=3YA+RKjt5eLwcy44RlCM6dNazad9TJ2w7e1lAKycE+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pgZITVxuFhY2S9m+AUhOmXxkbKqqRERYjVWtJI73Ibj7byfanTqT2rgzdkGwfRQTcQrzOTfd2T3doXBhaUqKCPLZViFDOmix+lwunTcYUOgCzd0JwxW5gvu3Aw7Lqal079vxETsL9SlHT3pFGRMtiSZbt3UjhN/hBc+uAiea7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsShNhSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66369C4CEF0;
	Thu, 18 Sep 2025 19:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758224670;
	bh=3YA+RKjt5eLwcy44RlCM6dNazad9TJ2w7e1lAKycE+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LsShNhSlOosgCCjv3ZZn1EVchSl3vU8pr8DxN45VfTpA5TG2NX6aNYeu9rPMq5DBg
	 udxhVjXaA1OG9vRBXO6ooa13dAV140tSVHM84bLL29YKK+CfS5jAFtU304qGLreLuD
	 0fcV0Z5wAlRxYX6CztaqfsoaovPvVn0IN0niD909yU01a1ebTtWyycg0U0Id17i1c3
	 QJFjj93cWYLoSNwhwpVYJBWVL+cwittfC4Lt4tTACTKH+/nNUgvaRGpFb15Y+lXeAC
	 /RDo3Sr/O1jJSP19VGLgtyY62tsYggT3lcx+iW6HMvLFGNRZVfimRTTmLpr5HNSbex
	 d04r+4NOL9KnQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 18 Sep 2025 20:42:06 +0100
Subject: [PATCH v4 1/2] KVM: arm64: Expose FEAT_LSFE to guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-arm64-lsfe-v4-1-0abc712101c7@kernel.org>
References: <20250918-arm64-lsfe-v4-0-0abc712101c7@kernel.org>
In-Reply-To: <20250918-arm64-lsfe-v4-0-0abc712101c7@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3YA+RKjt5eLwcy44RlCM6dNazad9TJ2w7e1lAKycE+4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBozGEXE5gzxW4DG9tsIWlE41BKvJvGpyQ63RKmO
 HOUNqzPdgaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaMxhFwAKCRAk1otyXVSH
 0F5vB/9btFoOAaaoJWCjjm7nW75Ob1/HiIkQfOGZ2fXHaFGNJBNqxyUxKlocd2E4VYhzrPXdqhn
 WIn8Be+Su4uKhY3qEuZkOxJHJ1popYnXrqdtq2PWVLZRlGKNHTWNNrpGRw9qeX2bsHnusJtACOu
 d9rkXvLKAX5t4K9pv4Khk652f8VCjBd7oIZWz2e1y+Vbiv/fHHyA6MvAodcFl88f5WX2Hge1Rvo
 GxtpOVwLqSv6J5I7gK1HmGsV3NPII5OmQoqD1w3g1jdrdK4D488GCMF4FYWs900EUPNlQHzu4IY
 eKEy/SfjPQLvbzN4fg1Zk71QJxkD0AeCRTjB1axR6IbenZlC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_LSFE (Large System Float Extension), providing atomic floating point
memory operations, is optional from v9.5. This feature adds no new
architectural state, expose the relevant ID register field to guests so
they can discover it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 82ffb3b3b3cf..08e2cb94bff3 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1642,7 +1642,8 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 			val &= ~ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_WFxT);
 		break;
 	case SYS_ID_AA64ISAR3_EL1:
-		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_FAMINMAX;
+		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_LSFE |
+			ID_AA64ISAR3_EL1_FAMINMAX;
 		break;
 	case SYS_ID_AA64MMFR2_EL1:
 		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
@@ -2991,6 +2992,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
 	ID_WRITABLE(ID_AA64ISAR3_EL1, (ID_AA64ISAR3_EL1_FPRCVT |
+				       ID_AA64ISAR3_EL1_LSFE |
 				       ID_AA64ISAR3_EL1_FAMINMAX)),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),

-- 
2.47.2


