Return-Path: <linux-kselftest+bounces-21133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327BC9B6808
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB27D28459A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADCA213EF9;
	Wed, 30 Oct 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE6kC9Vp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09257213EF5;
	Wed, 30 Oct 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302832; cv=none; b=DOwuppoxwkVW7IEukgnUD1nB/KGcRl1iHwNzAuLuLcp2ZYO3NtJecvDImvBz1zIydIacXSZghgBe9biqz4DKio6xZBd0HJF+Nu4hkxCaZSMBorN1dh93HqVc8zTl1DE80BILYcYl8yFkr46X1wOpd+tFNzPuiw4vq74EbG8XQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302832; c=relaxed/simple;
	bh=d5RZlEZoZQWLA36Igji31xBn/i/cyogK0e7bQd2Qjxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TXoez6CF7W/Ou82pvkT6Awz9+nIx8WA+rFzb/6/NsPfRy3Xu8Ts7rJJLaDT62unhoc9YYcGqjhYZQbekFPfTNiZuPqcIo9EBFGJjvi1IbMKo14o6EroQbOgpR6EbKvcIgfZcStUPwzIIWAyD8jtNKwgM4dX6n55GUYOOyM/FzF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE6kC9Vp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13301C4CED0;
	Wed, 30 Oct 2024 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730302831;
	bh=d5RZlEZoZQWLA36Igji31xBn/i/cyogK0e7bQd2Qjxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LE6kC9Vp2diILokcnUpRlsrwDQfPQsstBugzooc4phd5BgpKs4mkQopLR6PPwqivF
	 AlumbnwM4FSLSN/+MCgf9q2b0+zIZaZDgPzvwPe3FBzbmqK5iguHllzHGL947EIVUh
	 x/TkslrdbSUB84l0sOQVTI3/tNuT5C0JHUNILf5ng88o0JyrZyvOaVJtEfqbEbw2nG
	 nM10jDiswl4yla5Kl63z5DTpO/qJZz+LctKHyYAizsP6eUGdMf7wo88Yox3autSBBb
	 CwB+6Tbf72XOH2qPIDMkBCFkzatlvNfGd4u+lBUUziSYSCLRlSCShBw+PnmqHKszcn
	 1W6YZiTQfUUrg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2024 15:34:46 +0000
Subject: [PATCH v2 1/9] arm64/sysreg: Update ID_AA64PFR2_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-arm64-2024-dpisa-v2-1-b6601a15d2a5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=771; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d5RZlEZoZQWLA36Igji31xBn/i/cyogK0e7bQd2Qjxc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIlNiwTEdbvvxdZNjtG17B+qexUFd/zK+1LTG2Pf0
 uEcgQ/+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyJTYgAKCRAk1otyXVSH0GmcB/
 4827Rw0eDqCZ+AaDtQjKU7piurbwTC77SJNfsazBehLVWhz5BdvY32a/+MFqwXh88hslkBGVDsWYNx
 zbcpgOTGqCS0049vdVFyaKiOHWN5jEKc4dDQAm1Kzw6t3aHkf69Ve1JcGUxCEt6S/mzOvrHauCujTZ
 mZDmWr5gqOLIlygP/RKq+ukcecLeSf7nSAFyPtk/lYQBFHvo80DlgpT91jc5qn2IGUeJJj9XbFbSxg
 ZTqSzwU9vyjgluDBUtC0dsqaEN2p60+ovsfgzTSp0vB2QxiFoCG7nM4HgKQYXQ0rk0siDCR502stwL
 r7v5J96I1dUYV9KKPHALHtNbFyLari
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 defines a new feature flags in ID_AA64PFR2_EL1
describing support for injecting UNDEF exceptions, update sysreg to
include this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8d637ac4b7c6b9c266156b4a8518d8d64c555461..72d6ff1a9c7588dc4894ec6d673791fde108a857 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1010,7 +1010,12 @@ UnsignedEnum	35:32	FPMR
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	31:12
+Res0	31:20
+UnsignedEnum	19:16	UINJ
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	15:12
 UnsignedEnum	11:8	MTEFAR
 	0b0000	NI
 	0b0001	IMP

-- 
2.39.2


