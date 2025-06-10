Return-Path: <linux-kselftest+bounces-34557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9028AD373E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DDA17AABC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716942980B7;
	Tue, 10 Jun 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6W8ANdd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A62E28C5A6;
	Tue, 10 Jun 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559349; cv=none; b=qFCmVERmvIG/ht3dyypWZ6Pjwn+xtkc2tQSKN4l0WEcsgDfBWZ7IkWtVDNIgJjejgUfYJtCaZwU8jJvOpoGWHj7kaw4d1q4usr7bjMkuXEYMCxpRQTxWzxQfj1Dmdl0fKUe9QANKUv5r8wl+eEgQD29PeFTcprrfP41m48QFPAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559349; c=relaxed/simple;
	bh=/1iUBspDEJPAm1syGxDL8nO0vqi84Psh/DKw5YFPtZY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CvPLHi+TGSDMVcYqztj0+4yrv31JusalcJq3Q5853mTJd65vFZcwGqBO71BoX3d3AKSgj6BgvIN/fn2ep7CUgOIfxUb3z4I3yTOyxxOjcBdbEReMyzRp1AGYhtS6TTT5sn5AsN23+V79d9bt+e0k7LybCYt/lquVR9/4pYaB8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6W8ANdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF41C4CEED;
	Tue, 10 Jun 2025 12:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559349;
	bh=/1iUBspDEJPAm1syGxDL8nO0vqi84Psh/DKw5YFPtZY=;
	h=From:Subject:Date:To:Cc:From;
	b=S6W8ANddI6Mxzhu+bXnGcpy8S6b5KZK+nZEs+R3mO2Auw38nnZC1tRvDbYZdoa1+0
	 Hpw84ytsKQ6UMY3RRV/KpuP9rMKbz5z/VDVqfpA/FGAgQKBEjEt8xVp4m0HPidvSGV
	 rlWFHjMs6YaD7pNrWyWC+0HX4Q5gFH7lzSCIOtHu8Dwg2EMFR8sWn72aaDRdAikOJw
	 EI6QgZONtHdHf1uf+Vq4aah3loDxstGSWePBaHay6Kj9nIO9hBjGyL84cFpp9ODwu3
	 WK47sJd+a+goDLNyagg+vBxTgzplTDmDiXhFFQJxdXvwVJj2kJGEArcbvXvm3SmqnK
	 WXav1c4Uxba4Q==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] kselftest/arm64: Add coverage for the interaction
 of vfork() and GCS
Date: Tue, 10 Jun 2025 13:29:43 +0100
Message-Id: <20250610-arm64-gcs-vfork-exit-v2-0-929443dfcf82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADglSGgC/22NQQ6CMBBFr2Jm7ZjSUIquvIdhUWEKE5SaKWkwh
 LtbcevyveS/v0IkYYpwOawglDhymDLo4wHawU09IXeZQSttlNE1OnlWJfZtxOSDjEgLz1g62zl
 vK6OJIE9fQp6XPXtrMg8c5yDv/SUVX/sLVur8P5gKVHh3rlNe1caW9jqSTPQ4Bemh2bbtA6YdR
 OS5AAAA
X-Change-ID: 20250528-arm64-gcs-vfork-exit-4a7daf7652ee
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/1iUBspDEJPAm1syGxDL8nO0vqi84Psh/DKw5YFPtZY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoSCgu82PSVmQPG9g1oJQrsyvsTSf2h9mS1ONCsW21
 mqjhbFOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEgoLgAKCRAk1otyXVSH0BMCB/
 98zbKt51BDbhAYnQSZMke8OJDPGCHrlTF1lGFJxPCARcuIDzBp0prKAYytmm00o9LOAKqSVTyCpegx
 36l/v8Ig3awVYYtpl5D3hnvGppd5weMjb59iEegi0cJaNRIHjnSYKjI8XjnlrRrRV+hkr1QsjDOdYE
 OF4si6AwG9Nskqf/O295slJO/OyJZiy/Jn7aKHbpXQE8Ldw9KckocVneCaqLoBhxDs0MeigiSicVpN
 97h4+IpmCEA45bBJhCoZNTGDP000E5Fq3/bOuLfWZLbY8fbCEaHD7MeDP+QqAHAzowbXjJcirYclA1
 FJ9v/u3BYt8jGyR6+o/ue1MRNC4WRw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

I had cause to look at the vfork() support for GCS and realised that we
don't have any direct test coverage, this series does so by adding
vfork() to nolibc and then using that in basic-gcs to provide some
simple vfork() coverage.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Add replacement of ifdef with if defined() in nolibc since the code
  doesn't reflect the coding style.
- Remove check for arch specific vfork().
- Link to v1: https://lore.kernel.org/r/20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org

---
Mark Brown (4):
      tools/nolibc: Replace ifdef with if defined() in sys.h
      tools/nolibc: Provide vfork()
      kselftest/arm64: Add a test for vfork() with GCS
      selftests/nolibc: Add coverage of vfork()

 tools/include/nolibc/sys.h                    | 57 +++++++++++++++++-------
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 63 +++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c  | 23 ++++++++--
 3 files changed, 124 insertions(+), 19 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250528-arm64-gcs-vfork-exit-4a7daf7652ee

Best regards,
-- 
Mark Brown <broonie@kernel.org>


