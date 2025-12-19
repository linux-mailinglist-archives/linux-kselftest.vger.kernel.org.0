Return-Path: <linux-kselftest+bounces-47742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D668CD1A09
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 20:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 946883001BC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 19:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A834107D;
	Fri, 19 Dec 2025 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu6X3hu1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D60221DAE;
	Fri, 19 Dec 2025 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172531; cv=none; b=BTw10cw8/u38vYjAaVj7MdRIbp91y9/ccL0KnhS3/LbaBCYyUkvE2Ofie78cJAKf/QfsdV6PV/BbCkHttfpOECe6RWhAtq2N3v1uwZNzKKXwMB0eNtmV3AwemJfA+tj3jCx5QRSzLtTyanGJi2M/XZOPzSXtEJaroydhrSSTr6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172531; c=relaxed/simple;
	bh=djKhHEwOK60o6/v7COi0fZNMDvLwIhB3VYDbW9TITiE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ElTOI251uWSnu5NgMbAk7axOln+Lk7vIAvE9LKb37zNv/Wog4jaS9E/JJ1kZoD6bAYsF1c8OOv9J57SPrNKtV3TVRa1m2PaF1jangqO9xBB9v+fVHsBfATCeUOlKfyMQwWp5QNQ96XWNmlsYCqTu024bNB6PQi3GbnPjP1K88Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu6X3hu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D1BC4CEF1;
	Fri, 19 Dec 2025 19:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766172530;
	bh=djKhHEwOK60o6/v7COi0fZNMDvLwIhB3VYDbW9TITiE=;
	h=From:Subject:Date:To:Cc:From;
	b=Cu6X3hu1SH740JSIHC08MNNEvXpKxenoEz4kPe9ibti6ydI4XTA9YubGW5NReMD1Q
	 fQXSNoKLT/2LdfUroQDmP1b6OISabbOvge3K8ibxiQiHg257skmM5sNwPa4UqHcDt0
	 IoaAQI4Lr3AhpoyrtMPni50cxyf3Z2/e0Z1i+vgfRXRC0sJqDmtDgdH31KwNkLBRZu
	 jevXFoOrW54S0lbnRtb6Ys6Y2fEe3erOn0N7s5bfByuiC5hviVOJN2Z1gTUtoGrYak
	 zjQ54D2LF2D5j8SphzcYpFUVTCCjSuL798lpa+JfCOlrq1Cdamx+64Nqa3QUwel56T
	 E3nQOAWYcHmNQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/4] KVM: selftests: arm64: Improve diagnostics from
 set_id_regs
Date: Fri, 19 Dec 2025 19:28:06 +0000
Message-Id: <20251219-kvm-arm64-set-id-regs-aarch64-v3-0-bfa474ec3218@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEanRWkC/4XNQQ6CMBCF4auYrq3plNqCK+9hXBSYQoOAmZJGQ
 7i7hZgYVyz/N8k3MwtIHgO7HGZGGH3w45AiOx5Y1dqhQe7r1EwKeQYhc97FnlvqteIBp3TkhE3
 g1lLVpg3L0phCF0pAxZLxJHT+tfm3e+rWh2mk9/Yuwrp+5UzsyBG44IV2KGpZgsnx2iEN+DiN1
 LCVjvLHAag9TiZOG+kkKKegdH/csiwf0h2fhhoBAAA=
X-Change-ID: 20251028-kvm-arm64-set-id-regs-aarch64-ebb77969401c
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Oliver Upton <oupton@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=broonie@kernel.org;
 h=from:subject:message-id; bh=djKhHEwOK60o6/v7COi0fZNMDvLwIhB3VYDbW9TITiE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpRads3BeObYkMUbxOa2L8G5cc9dXvTvMSBHGjT
 UgF8XJQfnyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUWnbAAKCRAk1otyXVSH
 0HZwB/9IkoCpvXO2yiOCeRPdgHwF4hNdXjVN52TdsH6yiRX495D77BhnPlvgk8kuX2nDu7TIn/S
 CY5IvV83CRbbmHVGYf30iDiBC9CC0uecVOV3MIIch4k/F5aP3cgm32Webw+tLbP0EFGX8U2ivph
 Z03pw06qQpU/esK80jabA+j/D5fEdTr0rkgZbd6MG0f1ImdJTiWDAm7IoZN09fp82t9e7m6h1qt
 D4H7ewKWliyTz3qrN5DFhyk+5/QKIr60unp9Y7oGi8lWdDdzldOHUCV0JzwtPKqRFNtTpWXb8ts
 JySIr9MDVzyTaNF1pSXdsa0THuADC7ZRGvVjglr/iqP0g1e2
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

Finally we have a fix for spurious errors on some NV systems.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Rebase onto v6.19-rc1.
- Link to v2: https://patch.msgid.link/20251114-kvm-arm64-set-id-regs-aarch64-v2-0-672f214f41bf@kernel.org

Changes in v2:
- Add a fix for spurious failures with 64 bit only guests.
- Link to v1: https://patch.msgid.link/20251030-kvm-arm64-set-id-regs-aarch64-v1-0-96fe0d2b178e@kernel.org

---
Mark Brown (4):
      KVM: selftests: arm64: Report set_id_reg reads of test registers as tests
      KVM: selftests: arm64: Report register reset tests individually
      KVM: selftests: arm64: Make set_id_regs bitfield validatity checks non-fatal
      KVM: selftests: arm64: Skip all 32 bit IDs when set_id_regs is aarch64 only

 tools/testing/selftests/kvm/arm64/set_id_regs.c | 150 ++++++++++++++++++------
 1 file changed, 111 insertions(+), 39 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251028-kvm-arm64-set-id-regs-aarch64-ebb77969401c

Best regards,
--  
Mark Brown <broonie@kernel.org>


