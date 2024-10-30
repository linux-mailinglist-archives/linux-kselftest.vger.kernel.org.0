Return-Path: <linux-kselftest+bounces-21136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B149B6811
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C3A2846A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AA6214430;
	Wed, 30 Oct 2024 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmaP/4CB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E8214427;
	Wed, 30 Oct 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302841; cv=none; b=EVGwmhnOplY58kD9sKkBRYCla7NwBI7ktYNYVjqYGA7aMBkHTosp6iUFxXmKpbt8wfhdy9ruaugT0KTM9+MX08mUrrFjryCBwFZUhopxP8JuWj7WCQK75/JLxE99f6DKw38yq6MP2vS/nBz4SKaML5X5MqJfrxE3XKpURDUltQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302841; c=relaxed/simple;
	bh=FN01wAAM5D8ZMfrYQkBkqRMg6r+p3qmFRREh7tSlgYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fXY4FuOX3K/neC55SG09EZioj60+67h1zF722HlPve7SfdsDSzeBwrDQL6jXBCJ4AI8fBCy1yj78pxr9uaoVsFl2ibhm/dD8jzp5IxtUrFbBm6n0SfVVDGM4nI/15sVBCXWjNpbIUuKr39fi7gPXolnyvBlVQvssLbLIO8Qv8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmaP/4CB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28559C4CECE;
	Wed, 30 Oct 2024 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730302840;
	bh=FN01wAAM5D8ZMfrYQkBkqRMg6r+p3qmFRREh7tSlgYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dmaP/4CBao90I3Fpz3A6RkeO3fqUrBc0oqdXmCYtUTHBPGt2x8hh2co1r/v0XiwIT
	 rVBpFI1RevLqZXLsQEgY6fTb0F1agHMt8knWCz9qaPOU7oVIPj9cDU1LOMvw1sc+e4
	 UCXaIRmq42a8RNk9HAs7EG54w3cFAv8HsgjWjSqutuFLa3wKmsFEKq1Z9thVHwkDUy
	 VBKkW1J4cJSs8t51Jlx8EHLgVM1mj0y1UPRb2epv2wJo9nXdgJPJTtxCVUueQhsNTD
	 GSV+KPRvJv2vVPXNeMNC21BtmxA1KzG/+lyNhQfWy+45zyPDF5EDE4iTd3sJZvYweL
	 kQyJEIUGjz7/g==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2024 15:34:49 +0000
Subject: [PATCH v2 4/9] arm64/sysreg: Update ID_AA64ZFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-arm64-2024-dpisa-v2-4-b6601a15d2a5@kernel.org>
References: <20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org>
In-Reply-To: <20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FN01wAAM5D8ZMfrYQkBkqRMg6r+p3qmFRREh7tSlgYo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIlNkn1v+3TMugRaozhq/4idLPqH9dYXDmZSSjXgF
 mvI8qvGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyJTZAAKCRAk1otyXVSH0HUYB/
 97EFuVEk+UlGSqdYuXJbRyWltmlzHR9eqszm9kMl95KEEbUNMB3WO0Tktucy03Ciw4VrvbWon6ttDa
 OS1t4TgB7uvEu3FCtBwBcg6ywrIKyj11U8S+ybag36mTSf24aobg9cf4xhE5O9snXvFaM6/h+tWMrb
 0bYARjvx/n7F20LSfLOppiglAfHrQ6GAf+jPYKUyvgvAse1XKSqLNSlj4GJSYxxp16LHZZDDQDtdi8
 9HnoqZvlg+Z48oMaNEPVyFFlcUryQbbB8HG/GV8NXD9qSBA3eqOdB3PMIF9TGFwVyDc3tRVAuxbw2w
 aYfCCt0yyy8EzvUpJRYSp2S7JZ5UyT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 introduces SVE 2.2 as well as a few new optional features,
update sysreg to reflect the changes in ID_AA64ZFR0_EL1 enumerating them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 26f1350c9d2e3baf39ac3bdcc96fc1e6deb5a5c6..d487c78520b97c8f96c70181e39eccb91d6fe1af 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1040,7 +1040,10 @@ UnsignedEnum	55:52	F32MM
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	51:48
+UnsignedEnum	51:48	F16MM
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	47:44	I8MM
 	0b0000	NI
 	0b0001	IMP
@@ -1058,6 +1061,7 @@ Res0	31:28
 UnsignedEnum	27:24	B16B16
 	0b0000	NI
 	0b0001	IMP
+	0b0010	BFSCALE
 EndEnum
 UnsignedEnum	23:20	BF16
 	0b0000	NI
@@ -1068,16 +1072,22 @@ UnsignedEnum	19:16	BitPerm
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	15:8
+UnsignedEnum	15:12	EltPerm
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	11:8
 UnsignedEnum	7:4	AES
 	0b0000	NI
 	0b0001	IMP
 	0b0010	PMULL128
+	0b0011	AES2
 EndEnum
 UnsignedEnum	3:0	SVEver
 	0b0000	IMP
 	0b0001	SVE2
 	0b0010	SVE2p1
+	0b0011	SVE2p2
 EndEnum
 EndSysreg
 

-- 
2.39.2


