Return-Path: <linux-kselftest+bounces-48314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A43CF96AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 17:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 404AD303D916
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30C33B6CA;
	Tue,  6 Jan 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVXwrdpj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0B33B6C2;
	Tue,  6 Jan 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717679; cv=none; b=p/Uj0xZyPx+V4UVx7aTJjEApSETmoJZuCbj2/4rPv3+X2UHEqLSs72y6lZgpZbm/Ssqu/Gof2EDhbOv+Zu0g/bTZmWXD9oGjpmWVhKbT+UICeelJa/bj8/WHOntskzU/khSVnMWxx81WHKaViPxqqyklmCrnTm9O4JJgzMlWhvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717679; c=relaxed/simple;
	bh=ze09838bu4tgioSjBEqALwERPyBGKXw8MzIwdv5zFGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I25X+TMY2Qbjsz/ov7VPmmwDLeBYHVyuBghN/d67tJkvkNBS9xdCjR1vcrpIoXQUduAVASglIqXX7DbzRy95NSNQJJAw024zFpgeyUwPmbdbRRQ4wW+DNESOZOVKparaIznDZvVm0ruDv6RD75Du6QF8WVSSTgfbghoyxwVNGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVXwrdpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40264C19424;
	Tue,  6 Jan 2026 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717678;
	bh=ze09838bu4tgioSjBEqALwERPyBGKXw8MzIwdv5zFGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QVXwrdpjRxTlKijpAHvck0fcvXPwrVxZcxwi2UyVL0cQ4ZxkPJ/5QnQMJK+9T0W88
	 p90vDS2NWetnNMSAg/7uOoejUa330IJitHPLPJyfEIULJM2mhae6+i3NRwRMY9PCKi
	 sDb8MhBVb5D/1nPb8Juz2VEvWz3f13GuWqohRWbVfjZmA5WCbI4fRBH3lAuDQOxQpf
	 pQFYXpuJ6XjxCpZVH6iFOIw65f4Sl/HNdgHKNUCZgtv1WLB38yP5vAKxUpIJpzVbG6
	 V1HBo0Wuw1+m8vAzKxswsIlV4x91v6M48Pkiu1IsYNpEINpUW+fTAFTtlNVpHhL75H
	 JhYrrKwPbT3Ig==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Jan 2026 16:35:45 +0000
Subject: [PATCH v4 5/5] KVM: selftests: arm64: Use is_aarch32_id_reg() in
 test_vm_ftr_id_regs()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-kvm-arm64-set-id-regs-aarch64-v4-5-c7ef4551afb3@kernel.org>
References: <20260106-kvm-arm64-set-id-regs-aarch64-v4-0-c7ef4551afb3@kernel.org>
In-Reply-To: <20260106-kvm-arm64-set-id-regs-aarch64-v4-0-c7ef4551afb3@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Oliver Upton <oupton@kernel.org>
Cc: Ben Horgan <ben.horgan@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ze09838bu4tgioSjBEqALwERPyBGKXw8MzIwdv5zFGY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpXTsdxCQGJi+W81ZooYRjsa6d9nw9aQbV7Isdo
 0qUUg6pwlaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaV07HQAKCRAk1otyXVSH
 0DXLB/0cXvjbU+zB17kgrZhMg1U0LcQUAP3jU78hE6JW/2AxfQk3FGYKuHLAU35CW7RPJAn+UFW
 R/kcXTN0X6QvAQzE28x99PfulzNjaiAzzrE2XAF72ljHq5FLMoiFM8LCytx3z0oz0VBBTaHDBBy
 GjtYk/60l2OFUZ0k0xmBi9R5eO+SLe2J/qEx6YVCO3+4zz4iiWsdZMrZZAfQ/ioG9B/ZaRcmn8d
 MRaKsNEfAUhN6cv3JNHPG9byRn9JSCerGCTJtQPGABp7T6O43CCBRoBrSmz867KaZka4ci1Jdui
 c5eYwZLQ8ajj+3Gzj8Ab77ihqbjYAeU8MO7B0iWk9pQeP4vb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

test_vm_ftr_id_regs() uses a simplified check for 32 bit ID registers since
it knows it will only run on ID registers. For clarity update this to use
the newly added is_aarch32_id_reg(), there should be no functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 908b3c8947d9..f703c6cfe132 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -503,7 +503,7 @@ static void test_vm_ftr_id_regs(struct kvm_vcpu *vcpu, bool aarch64_only)
 
 		for (int j = 0;  ftr_bits[j].type != FTR_END; j++) {
 			/* Skip aarch32 reg on aarch64 only system, since they are RAZ/WI. */
-			if (aarch64_only && sys_reg_CRm(reg_id) < 4) {
+			if (aarch64_only && is_aarch32_id_reg(reg_id)) {
 				ksft_print_msg("%s on AARCH64 only system\n",
 					       ftr_bits[j].name);
 				ksft_test_result_skip("%s invalid write rejected\n",

-- 
2.47.3


