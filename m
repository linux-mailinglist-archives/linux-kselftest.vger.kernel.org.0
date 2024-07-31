Return-Path: <linux-kselftest+bounces-14556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DFF943410
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4E82829B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735461BBBC7;
	Wed, 31 Jul 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2MBkEav"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B01CAA9;
	Wed, 31 Jul 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442942; cv=none; b=u3535e0STKDCCLuViS0mwO1feH4cpfwJ2WZCvTY1150eKUt37mHdSKvF7sTNwFd9pZZ8S5+M6rvHAyG2aNpnRGJ84fZf+v/h7Oxm+Y+K7s3Qp5s98E+FkDL9QJShloRzZlOS7rgqKajRN1SN7vrLQEJL99n+r/5lNM/FOCsiG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442942; c=relaxed/simple;
	bh=4xS0pD2n/vpTAJI9k2seY/mT9WcQsaPxpoFu1kzIwSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ePgAz01CxZkM6c3nG86HyRMmoUSNQX4uOmxRfhW6arp0Uavl1WM3iPz/1huXPi1kQHoVPslAEyX4/CYnir9hv2PpNZputmMt4fI3DdnYxm8D4UruaXqYBJFPbOmftQfR+tO07AbFF2olnTAWmeYyw34Ku9Y8w13LpHQnolKhgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2MBkEav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC3EC116B1;
	Wed, 31 Jul 2024 16:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722442941;
	bh=4xS0pD2n/vpTAJI9k2seY/mT9WcQsaPxpoFu1kzIwSY=;
	h=From:Date:Subject:To:Cc:From;
	b=C2MBkEavnwa7rJ0kZ6GI52VlH99xH0jl9GgQckr4U22QF1wbaiyYfZS2iN4ZFMVPo
	 3q39Q5+M5eeaEBGfXwDM/YBr8h61g4cd+XHy3ibH7EWN3WEvp0EkeCOmfVzh+0Mcnh
	 AT6hJ/Io+sUULd9tDslVf+aTTDWJKHB4dtXpsKep8+nIB/+9e+AspZiFJ0ONroji50
	 BKnBXAPFJ7PdKYoswBaWwFj1nHzFWHBDSiKd5D8mhpdtmAu+yNhxKdmnOFpchzqzbB
	 6oPhsqyb/l9AOyVmJhcXk2kjTNQGwQqGOJ4FPn01qBt3fJKw8J2FCZEhVen4ShKzGE
	 WcxzWG4VQZMAg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 31 Jul 2024 17:21:13 +0100
Subject: [PATCH] KVM: selftests: arm64: Correct feature test for S1PIE in
 get-reg-list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-kvm-arm64-fix-s1pie-test-v1-1-a9253f3b7db4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHlkqmYC/x2MSQqAMAwAvyI5G2i1WvEr4qHVqEFcaESE4t8tH
 gdmJoJQYBJoswiBbhY+9gQ6z2BY3D4T8pgYClUYZUuN672hC1ttcOIHRZ9MeJFc6IzytaeqGa2
 HlJ+BkvGvu/59P+CCE1pqAAAA
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4xS0pD2n/vpTAJI9k2seY/mT9WcQsaPxpoFu1kzIwSY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmqmS6GOeWEWP62/aXDViXEkZrsrUtBn51zh/OWFiZ
 uDkGI/aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZqpkugAKCRAk1otyXVSH0E06B/
 9VOmuwqQYplgVUUsHIPEJG5GVO9uTAgm62aij3o6EomU20qF9CObSRrFct3b0xaucS568Co/VI6tpp
 gWS3LZJAz5GqV1E1ZynABm+8i9Fo8tVfaWY/E16wv4/DSNNOYApn7+5p7p+sodTV6y2v5y4rWulO9D
 DnT2pOYhB6A163lBIbSdOuFoeLfDRcvA0ou2OICK3GUDa0H5993gqjVbJhh8dSmvSA43qhm6yLW7Oe
 qotWzu21jHfs+PPxIPBVstkTPueah2l0mESFTOOGEi7PcMIUMF7uCjrpiJZqwowtAyjyeL1Iyqcjl4
 4yOCGR/2Cb/u/Y8Hf+11+sr7jTugSm
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The ID register for S1PIE is ID_AA64MMFR3_EL1.S1PIE which is bits 11:8 but
get-reg-list uses a shift of 4, checking SCTLRX instead. Use a shift of 8
instead.

Fixes: 5f0419a0083b ("KVM: selftests: get-reg-list: add Permission Indirection registers")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 709d7d721760..4abebde78187 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -32,13 +32,13 @@ static struct feature_id_reg feat_id_regs[] = {
 	{
 		ARM64_SYS_REG(3, 0, 10, 2, 2),	/* PIRE0_EL1 */
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
-		4,
+		8,
 		1
 	},
 	{
 		ARM64_SYS_REG(3, 0, 10, 2, 3),	/* PIR_EL1 */
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
-		4,
+		8,
 		1
 	}
 };

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240731-kvm-arm64-fix-s1pie-test-a40b6be58d7b

Best regards,
-- 
Mark Brown <broonie@kernel.org>


