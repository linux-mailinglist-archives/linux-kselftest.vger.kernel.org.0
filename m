Return-Path: <linux-kselftest+bounces-23135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 225E49EC146
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 02:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4014F16904C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9703D1925A0;
	Wed, 11 Dec 2024 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDiDvLos"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA4189B8B;
	Wed, 11 Dec 2024 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879077; cv=none; b=SO5k7QSmaocUlVZHa+xvu60cJQNJS6VKVp54e2PULK/Z3IyH553/syqXeOVH+05Vayrzq81MRQiZ2v7WaX7riIDJYtGgmhoVDY4wzpRYy45v4GjP6NKclCcI2NoGcC+aLIp0dtoyNunj3DlClIQBm8jSktKEPro9TRGS8rBxT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879077; c=relaxed/simple;
	bh=cqa9T0MNY7qNBa8+pChF2cmZR6wFtD7tZyVA8NOA6J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHIhNSfp23X2m/dTCFN9uEpmihH3GNz41TyzlKuPoxCbWN1tSCAVhfIjoq+37jMTT06JFX+hHuH4EyqQZ7Vyfk/++lJzqn0bRo8+WKPe7wE+YAtLWqxkopbfdTjGKur19ZciN3iIqxdP/wsgNsrrgJkIWweWQ8nBid1KD1J/tRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDiDvLos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FBDC4CED6;
	Wed, 11 Dec 2024 01:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733879077;
	bh=cqa9T0MNY7qNBa8+pChF2cmZR6wFtD7tZyVA8NOA6J4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qDiDvLosMAeoUxr9SihZ3ILKudU/BVJh4lLGBAugsc/KHPXGnx+G9DtCAg4R8vHPW
	 j88hA7fFwNEAG300xv32mQWoTRLHXmcfveTF+YIBzPecpdCI9C4WVbNlJ5OQ5VwCKD
	 haS28GDVs/x4GSfJy76lp0R1/w5qTTsbLhA46X1A0B2u2N7sxIJKWW0woWm7jjRWna
	 dxqHYnltFlZXKrHXIMzXF0btDPg8+QB1jFvVPNYosB3A1ZQ+9VGOjVAXLm++qW6O2X
	 uj9p2HxG9Sqy+JdV9SbrxxAGvxCzdHJLwWz86wThB2aqamlj5fsMC9yk9lbyIYOLJ8
	 Rw6b/DJOxMFRA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 11 Dec 2024 01:02:49 +0000
Subject: [PATCH v4 4/9] arm64/sysreg: Update ID_AA64ZFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-arm64-2024-dpisa-v4-4-0fd403876df2@kernel.org>
References: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
In-Reply-To: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
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
 h=from:subject:message-id; bh=cqa9T0MNY7qNBa8+pChF2cmZR6wFtD7tZyVA8NOA6J4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnWOURA0EIxA9EPjbiIzbTF6VFtD542aCt4lwFY1dz
 Hjf1NxuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1jlEQAKCRAk1otyXVSH0OyGB/
 9PoRZOcDRzdK5RkE64k95GMgMXaKq4noetvS+e48Gk5VG/GQ+go7FE4LWN2OwC4d0VckiFO2Ao2dJm
 uMyo9FPEEf8T1/Da6MrYnX4TeJCbb6h2kGB8sWf2WPY0csMfdlHrK/1ZAL1IWsoVxIADPFmMHpgkIa
 OGF3HnscxDl6pv7++vOj1cPoMP3ouKipg5YjQsqLdtYaO/F/Ubo1HAiOqtI+/x4PsSd3GNGozaORTX
 U6U36tdqpx32O6rlZ1GmYonRcnEXqosreEwZeSwT5oF5d8McPLT9vW3mXlNREZPJzWtz35SoZXt6Br
 7XMfsyvLJNWXTPDzGOdhPbN7PBT2I5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 introduces SVE 2.2 as well as a few new optional features,
update sysreg to reflect the changes in ID_AA64ZFR0_EL1 enumerating them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 14284a120a5796bb510a0382984236eba9bf73ab..c792bd3b0afbb5fb7e438a4d760d9f2d15621eee 100644
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
2.39.5


