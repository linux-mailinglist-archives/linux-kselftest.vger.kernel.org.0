Return-Path: <linux-kselftest+bounces-20847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D3F9B3BC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF642832EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278F9204F71;
	Mon, 28 Oct 2024 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZW5JlPa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B121EE011;
	Mon, 28 Oct 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147209; cv=none; b=tXVfi9+1RMGU22JASpKNNCLR0jY8qoXHFeBnVPQKwMN0SbfW+tJp9G9ZjFGOEIXkmC+MZuodA4khueLDR+82/N0sgg+cwp17Z71nh1aZ6+PPBGa1Fwkx3BOZr0tf17UzY6Sqeyh7NHZasPPI0nMQZ1oL6w2BPYi0M/Rh49lLCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147209; c=relaxed/simple;
	bh=2mKXsQoc2fyKgSSWiRx7xITP+IRuxdOT5z6VLLnJRWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApiNAKS7hz5FqgorjE2RhPEizaWNx9gXNQx1ZPMfNaw2D0gzxphrMZKNTlaQx1iF4tEf6A36QFYVQM90/OFLegH4IGiOnylyzVYTE++Ctb7I7F7Wb4oRqDDhfyRUnERPLTdeiK7WzDwCR5a5tFWFWA2N+ifpb5a1414rnHEkunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZW5JlPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABB6C4CEC3;
	Mon, 28 Oct 2024 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147208;
	bh=2mKXsQoc2fyKgSSWiRx7xITP+IRuxdOT5z6VLLnJRWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uZW5JlPa7Jf2Wi3UPnwob95dwUa+Yymhul5OdBj6Jaozp7ACx+rU6qXevUuXntaja
	 0I5tOq9S65apVsPbmdkc3sJ1Qjg9EegHskEzAzCAMU/wbiqnD53G9DM+ef81rEhzJS
	 0XYUYQr6vfpCcjix9vwsrIKiXZTqYJTZGMli8RRGHxSm4x8hEZmX4M9iA+duNZGQ92
	 wZIBDC4RLI3n0nahstbxzXduQ04uFXui6z56bxpWoU7zzL3ZizuARfhggcS/h/r5h5
	 3EHndF1XZok9TYL9vUzwTXxx+ekrhsqa2njRfz1v7xab4gGcnIuxxtD5yttPD+mfGG
	 s00lWU7T6ngHw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 28 Oct 2024 20:24:17 +0000
Subject: [PATCH 8/9] KVM: arm64: Allow control of dpISA extensions in
 ID_AA64ISAR3_EL1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-arm64-2024-dpisa-v1-8-a38d08b008a8@kernel.org>
References: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
In-Reply-To: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2mKXsQoc2fyKgSSWiRx7xITP+IRuxdOT5z6VLLnJRWs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnH/NrEBfq3hDnWISMfuy4nvcRlrxy6aWqNbzOnn1T
 Kfy2OBSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZx/zawAKCRAk1otyXVSH0PdhB/
 9hTgKJ81Iz+V9IlwBdnwA6n7okQi6Zkf3YceGZAfaWEzc7Y6xHwFw2JVNh/ABB/IoKkf/WaHxkJh+6
 SNGR63vWc7mN+r+9841M3YFAcusp3GEtRqvnqdtskMuRPRjBaqIOQvHT5xG/Pnn9RwwXWUf1DPttMf
 R1RvASwTi10oTmgEBV1NNxy9YKE437SbDmuK9Egwu0KhGlrEyy9gLrGP5TjjIG2SVT0NgozdP9Q5lL
 yEejpuvKl7L4GU8MCAYdLYpwyD1x/mJr8O+Mwks7lrVTO719nTMfyOseVCmdgtibLykpKbf3zVzcFZ
 Trs8CeDtjWaRe2pZn8DCmXmQy+98CV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

ID_AA64ISAR3_EL1 is currently marked as unallocated in KVM but does have a
number of bitfields defined in it. Expose FPRCVT and FAMINMAX, two simple
instruction only extensions to guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index dad88e31f9537fe02e28b117d6a740f15572e0ba..ab348c314d7963437e1876d441169f3ef4eff095 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2409,7 +2409,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_WRITABLE(ID_AA64ISAR2_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
-	ID_UNALLOCATED(6,3),
+	ID_WRITABLE(ID_AA64ISAR3_EL1, (ID_AA64ISAR3_EL1_FPRCVT |
+				       ID_AA64ISAR3_EL1_FAMINMAX)),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),
 	ID_UNALLOCATED(6,6),

-- 
2.39.2


