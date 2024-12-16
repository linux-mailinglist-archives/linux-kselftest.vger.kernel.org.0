Return-Path: <linux-kselftest+bounces-23428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F019F39E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 20:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5F07A129F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AD82080F1;
	Mon, 16 Dec 2024 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RceAWJ5Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B0206F35;
	Mon, 16 Dec 2024 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377388; cv=none; b=lrZXCR3k5P+qQnnLRvRVfq4RuRB77HeRQ8TeAfA55kmJr0p7lU7tlEyL12lkg8TIafoOS7++0pY2pqP2sVchIikRtf9OndKuyNG6lNZwqKGg5TUbShAocq5+cCax0e0NxXxRqlttPCXx525j8f/6pyKgY9maM6cFj4gpACtDdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377388; c=relaxed/simple;
	bh=zob8cBbXpNsaY9MTVMiTWopsdDQ7UbvHJyGMOED+hro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Egll8SH6sb6nhRrDaioF27RGEvSzdQOM2+6jwbQTjM6CdkxBWAGLCOevGkBDPfZQMN6a/LNzIKPI9YYPuP0MKPfy1IsMM0cpWj87jKgZosMVB0gAuSFHXwN2QSMPDppSjy7SwHRM95eFgpmmAE4u9kDIgAWiUz6d9ETvFQTZzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RceAWJ5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C88EC4CED0;
	Mon, 16 Dec 2024 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734377387;
	bh=zob8cBbXpNsaY9MTVMiTWopsdDQ7UbvHJyGMOED+hro=;
	h=From:Date:Subject:To:Cc:From;
	b=RceAWJ5Q2b4cYp49HafjaGkvIF9zm69/z/2HLKc3IS9jz5zzn38GD+oTZSnh2IbYc
	 jr+FOGAmx09yngJSQoX/EYvhpQNh9STzPtn0RqhJ/PSyAPPXLtlmHYXc7KdNDDUhAJ
	 tcBc1lJv/sytueVF9aHmsvhJC06GcDzdMSuPfzI7yHeQQLR9nLWrKQto8qFTJhhAiF
	 VQwcTGXNvF7V2nZOyYp+r1YhWaoAYRiJvOaOvGB92CEOa9edLORlo1EAslUr9y/KCC
	 DCIw9DDaSLGIseq2rxT1fqdK9+Gsz1Ov0gw8UN1e9QvGgV7eqS2Ofxbxy08XEY0gm0
	 T3kdVHQTcTJPw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 16 Dec 2024 19:28:24 +0000
Subject: [PATCH] KVM: arm64: Fix set_id_regs selftest for ASIDBITS becoming
 unwritable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-kvm-arm64-fix-set-id-asidbits-v1-1-8b105b888fc3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFd/YGcC/x3MSQqAMAxA0atI1gZsndCriIvWRg3iQCMiiHc3u
 Pzw+A8IRSaBNnkg0sXC+6Zh0gSG2W0TIQdtsJktjDUVLteKLq5VgSPfKHQqQCccPJ+CjadAtvS
 1Czno44ik7P93/ft+dELguG8AAAA=
X-Change-ID: 20241216-kvm-arm64-fix-set-id-asidbits-9bede25b7ad3
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zob8cBbXpNsaY9MTVMiTWopsdDQ7UbvHJyGMOED+hro=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnYH+o8aXSlFkq0JGBg1lM1VwGO+DbhuBYGgA0lSnu
 em750Y2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2B/qAAKCRAk1otyXVSH0HySB/
 9KXCZ0JRJ0FegaopfpAL6MwAVzZ47XDi1i0B4ODxl5pBgFCnLOSZOzxG1WNdAKaNxymgQOG9TyZNq+
 7ReuXTGTiZspw2CqVdH3ypZNWzIgfkRzNg8hYx+nli6lddmcubxQE94D75DmMTJAAz+jZVraqxmSSs
 vlZxm1WG8s1gN5WfYEwkrsnxQkCsjDoRTlVKg4oVOs6X7Kc3ePbuvIwk1exGMWGZ8uHUaTab9+r5sl
 ej+WQt7MSuXLY2ymYH6oaITPjt+FJM0kDNg6k1J962MLyfQEMkpS3m2z36sGgVFlsspasqbgMStuif
 qk7g0Ba+4gaA/8CXKp9bQ91TfgI9K/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In commit 03c7527e97f7 ("KVM: arm64: Do not allow ID_AA64MMFR0_EL1.ASIDbits
to be overridden") we made that bitfield in the ID registers unwritable
however the change neglected to make the corresponding update to set_id_regs
resulting in it failing:

# ok 56 ID_AA64MMFR0_EL1_BIGEND
# ==== Test Assertion Failure ====
#   aarch64/set_id_regs.c:434: masks[idx] & ftr_bits[j].mask == ftr_bits[j].mask
#   pid=5566 tid=5566 errno=22 - Invalid argument
#      1	0x00000000004034a7: test_vm_ftr_id_regs at set_id_regs.c:434
#      2	0x0000000000401b53: main at set_id_regs.c:684
#      3	0x0000ffff8e6b7543: ?? ??:0
#      4	0x0000ffff8e6b7617: ?? ??:0
#      5	0x0000000000401e6f: _start at ??:?
#   0 != 0xf0 (masks[idx] & ftr_bits[j].mask != ftr_bits[j].mask)
not ok 8 selftests: kvm: set_id_regs # exit=254

Remove ID_AA64MMFR1_EL1.ASIDBITS from the set of bitfields we test for
writeability.

Fixes: 03c7527e97f7 ("KVM: arm64: Do not allow ID_AA64MMFR0_EL1.ASIDbits to be overridden")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/set_id_regs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/set_id_regs.c b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
index a79b7f18452d2ec336ae623b8aa5c9cf329b6b4e..3a97c160b5fec990aaf8dfaf100a907b913f057c 100644
--- a/tools/testing/selftests/kvm/aarch64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
@@ -152,7 +152,6 @@ static const struct reg_ftr_bits ftr_id_aa64mmfr0_el1[] = {
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, BIGENDEL0, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, SNSMEM, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, BIGEND, 0),
-	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, ASIDBITS, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, PARANGE, 0),
 	REG_FTR_END,
 };

---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241216-kvm-arm64-fix-set-id-asidbits-9bede25b7ad3

Best regards,
-- 
Mark Brown <broonie@kernel.org>


