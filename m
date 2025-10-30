Return-Path: <linux-kselftest+bounces-44425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DCCC21048
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71A2F34FE09
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C2423B60A;
	Thu, 30 Oct 2025 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSCvkpnW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A7273F9;
	Thu, 30 Oct 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839243; cv=none; b=pMQR916WhsmriBBnV7NFaAeOLGwSN3D8IOYzdjcTWDsRN++ojxC7RLF2fD386HiJG3XqvM9Eqi49gAzIY2VgFC1IPJZh0D3iEW4LEDeolnTB/6e+BaZv7DMCRHKj46LL8so4NgShXG1XB81kDvkfa9YaejLsVNqBpagarpFDe20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839243; c=relaxed/simple;
	bh=+700ZoH9beBUCGWPdpdtRrHrZpBqINFzjki0JlY+WIM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WHKO0TWjTdYxzrFY396tbnpKttkJCC2CN/SDmotzIjD7REW/NMAeQ+9+UcPj1fH//HwTtOFY/1qzRugmxWJA7jgUQa7RaFKsd1EIVazlduuLXX4i46S3LBwTzZpi7MEUmm7jfLxDawfp25iOblOCGE7tpNnVRu95o31cQh3ys4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSCvkpnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F12C4CEF8;
	Thu, 30 Oct 2025 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761839242;
	bh=+700ZoH9beBUCGWPdpdtRrHrZpBqINFzjki0JlY+WIM=;
	h=From:Subject:Date:To:Cc:From;
	b=kSCvkpnWAFvxXim34lW/0VaSlUE+r7nA0g/2z6xu6EtrFLL2Vxbht1Nc94nIfPg6m
	 NyciTW/5MsbXMhB3A7mZMnwA1M9GMswJqHnSt6XRBMqzD0R5QdHMaP1pIjbYVEWpTj
	 SJDTOCYT8XrpFDTaHV9/BtROFkuBVIf3HKrlj/GpRm9vkH54ivvWSv2X0YQNlhtt8q
	 /Wo6Tzoa1TMzPNJyJQBnjNfILkKvE5wYcyzFUEvR+nnLsSjMvmeyEt90HbJjQTbg3a
	 nG61vRJaWR/jsQ1FlIDwoOyeA134/gRjPDZrS9jdMYQJQy8gTM12t7sPWYlTRkY+Vp
	 Ox4Pc/WR4heZg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] KVM: selftests: arm64: Improve diagnostics from
 set_id_regs
Date: Thu, 30 Oct 2025 15:42:46 +0000
Message-Id: <20251030-kvm-arm64-set-id-regs-aarch64-v1-0-96fe0d2b178e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHaHA2kC/x2M0QqDMAwAf0XybKAtrs79iuyh1kyDqCMRGUj/f
 cHHu4O7QEmYFF7VBUInK++bga8ryHPaJkIejSG48PAuPHE5V0yyxgaVDosoNCmmJHk2R8PQtl3
 sGucz2OMr9OHf/e/fpfwBox+vQW8AAAA=
X-Change-ID: 20251028-kvm-arm64-set-id-regs-aarch64-ebb77969401c
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+700ZoH9beBUCGWPdpdtRrHrZpBqINFzjki0JlY+WIM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpA4iFRz9aKzGShuvRtfEbfX3NhTm+GpE7qdJVU
 9mLWnT7HAiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaQOIhQAKCRAk1otyXVSH
 0MiEB/4gsZLaeP176xWNHCFoMI210dAWo/OxnDFWqQuSDbWvV74qEFThEfGIMWBjS79ZkCwZ9Hb
 +nG4LaTF85FPUVWs262tIEV/DtYiltFySzXW3sINV83pWZYijjNBr5x9jOtJZ9NCPJBObvWzC8g
 +e+8Odemr4DbLuKbuWcYZHgA9Ff/36CmqLOlzKXhxPaJgEj17A6wxRkY+ICqWTAAFScujFVyqHu
 CWKPM8IB5HlWx2qv6sHeJfRXun2NVXW91pxyiQTWBkhiuslmMvFhHGOptK/rGqf3DhK9f7cA28Q
 8Fr/NqxlzjWe7J8/TJsLN2MwKuu0TyPvvcVJcJ3vAB6rDh5c
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

While debugging issues related to aarch64 only systems I ran into
speedbumps due to the lack of detail in the results reported when the
guest register read and reset value preservation tests were run, they
generated an immediately fatal assert without indicating which register
was being tested. Update these tests to report a result per register,
making it much easier to see what the problem being reported is.

A similar, though less severe, issue exists with the validation of the
individual bitfields in registers due to the use of immediately fatal
asserts. Update those asserts to be standard kselftest reports.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      KVM: selftests: arm64: Report set_id_reg reads of test registers as tests
      KVM: selftests: arm64: Report register reset tests individually
      KVM: selftests: arm64: Make set_id_regs bitfield validatity checks non-fatal

 tools/testing/selftests/kvm/arm64/set_id_regs.c | 108 ++++++++++++++++++------
 1 file changed, 82 insertions(+), 26 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251028-kvm-arm64-set-id-regs-aarch64-ebb77969401c

Best regards,
--  
Mark Brown <broonie@kernel.org>


