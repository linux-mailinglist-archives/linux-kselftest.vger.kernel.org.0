Return-Path: <linux-kselftest+bounces-18846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D498C91E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 01:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71561C240BE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 23:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0BC1D0154;
	Tue,  1 Oct 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLfN8hK6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3D1CF7D1;
	Tue,  1 Oct 2024 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823934; cv=none; b=ifJuV3sGb95EoNA4LwM5yXLf1993+rQyx6HT1086ek+t4PnHuFDDxKK/FQlh3AJckLfpRxwy0BOrbRztAZcoZQqSeK2Xw+bppenrnBaslG8OuTjoLG0uAGDDNilarB0DVOzV5fkotlgxd1GgpiBHz+uueIzobAmzXBpgGkg7X0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823934; c=relaxed/simple;
	bh=qbIXmU2eUtmemMq8xp+h1yj3ghFTmpSN4hiSxbQmL24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cqjhJijQiEKei/4eOx6pSznT3KHOjObRX9Fpvqpr5JUcRFEGv2ahoYAEi8IMB+ESe1g3MBsw5nl2mcHriBoxX3/shVecNg8Vd+qq4UTBezPz6m/xBhwivPooeyhBqquA9qlx6JX4jRxqnRFDjUdToA1U56yeVV+n3P0EjxSlMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLfN8hK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A385C4CEC6;
	Tue,  1 Oct 2024 23:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823933;
	bh=qbIXmU2eUtmemMq8xp+h1yj3ghFTmpSN4hiSxbQmL24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iLfN8hK6fHJsCL43iSYWHnlQe8lmB/0kpA5kef24n6vIHD3puN6AUc0DPk4sOqABb
	 wWAjZyCkgL0G9BIFMcx8vXrgyMxvMHHfYAHX+x+mB0u7AfBeK8aepBzLUdkq6pOEZv
	 N56GqM7jshutguOWelLOOIe09qymjx/165hlaMxOg7nQT69Losj8yjFsr85AwUTXyZ
	 c+lc9rAWrd+ijT8JfypMqXpIHR89Q94sffXErVyiSHR+KNkso6Qb3wgi5CScjjwN3+
	 cA7pnI/kGEugcQvkMWCHyU01V4KUQOzIthpcHlAIkQa2BGUJojXKuFps2EShSHPk/9
	 U6SlBWyZTQfgw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:59:09 +0100
Subject: [PATCH v13 30/40] kselftest/arm64: Add GCS as a detected feature
 in the signal tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-30-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, David Spickett <david.spickett@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qbIXmU2eUtmemMq8xp+h1yj3ghFTmpSN4hiSxbQmL24=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7b2/iy2LdLJp3um+baJpFqFpKYtxnFOd3PCELd
 fKwZqKaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+2wAKCRAk1otyXVSH0NHEB/
 9EKBm0Nlsi2M1QMfMGnwSQGrHLQyo0Ec2/WoKudVqFQEvsSyGbPTSFYvGmQ1dt68l8+uMZJF6ZolQ6
 +p9amzeznqBLv2udaMcOQCbVRNUVkhWWEVPH03tjMMJ2JCfAhJiu5tWmU+AO3dNrD0+IKLhlvAy7a4
 ytAjYf8dykZi4yMOOBEZVFM2y0oDkNBzrnLNudtDx1M0m5EGTdCOtsOuOgbcYE3iCawBsDuPo5PVii
 W2sqXjLa0a3JOYmFrJ+qR3PhmfLgNx6tlv0SDPPQuPqi6bStN5a3v662I9gyQ3nFzHQQPFLgjdhlGT
 zbzEjrNGMmUur+kCBdWhwHlyVS3mx9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for testing GCS related signal handling add it as a feature
we check for in the signal handling support code.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/test_signals.h       | 2 ++
 tools/testing/selftests/arm64/signal/test_signals_utils.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index 1e6273d81575..7ada43688c02 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -35,6 +35,7 @@ enum {
 	FSME_BIT,
 	FSME_FA64_BIT,
 	FSME2_BIT,
+	FGCS_BIT,
 	FMAX_END
 };
 
@@ -43,6 +44,7 @@ enum {
 #define FEAT_SME		(1UL << FSME_BIT)
 #define FEAT_SME_FA64		(1UL << FSME_FA64_BIT)
 #define FEAT_SME2		(1UL << FSME2_BIT)
+#define FEAT_GCS		(1UL << FGCS_BIT)
 
 /*
  * A descriptor used to describe and configure a test case.
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 0dc948db3a4a..dcc49e3ce1eb 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -30,6 +30,7 @@ static char const *const feats_names[FMAX_END] = {
 	" SME ",
 	" FA64 ",
 	" SME2 ",
+	" GCS ",
 };
 
 #define MAX_FEATS_SZ	128
@@ -329,6 +330,8 @@ int test_init(struct tdescr *td)
 			td->feats_supported |= FEAT_SME_FA64;
 		if (getauxval(AT_HWCAP2) & HWCAP2_SME2)
 			td->feats_supported |= FEAT_SME2;
+		if (getauxval(AT_HWCAP) & HWCAP_GCS)
+			td->feats_supported |= FEAT_GCS;
 		if (feats_ok(td)) {
 			if (td->feats_required & td->feats_supported)
 				fprintf(stderr,

-- 
2.39.2


