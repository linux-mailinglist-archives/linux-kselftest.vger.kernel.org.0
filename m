Return-Path: <linux-kselftest+bounces-21601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B43EF9C070E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC4D1F22105
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F411EF08E;
	Thu,  7 Nov 2024 13:17:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7507B322E
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Nov 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985459; cv=none; b=f2YPCtDATgmK06HhrT1D/9KxRXKUUQCvBl24yyjn2pUbiUURRn8xC0qkqfoYle1Pj4ltg8xUrGc+tAzHsmkSJdjSFipXWUW2Sjnqr1Brjh8TOX83G4fN03y767enlqRw/R+xrP0K0mir+zJTti0TvRXqmHICFi3pO0YcnBqoD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985459; c=relaxed/simple;
	bh=CHZ7QQlwVUkYoN4fFdMyI0YGcgnUYP/RLyTwB7dWOYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNx5RxXN5tlN6jHtUKqra1V6B+hGELyGT5yZFOWs2Szsv2emkHYPby4gDa6suS2KyAoeRdQdBISMXGbUoXPsNmEaTb/TxMg7D2LNSszsTEu5oGAYM3CvFcNqP18ka7HXb9/DSUf20pOHPPNssjvGdfuULN0W4oGm7FICz4KwT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 808B7497;
	Thu,  7 Nov 2024 05:18:04 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35CED3F66E;
	Thu,  7 Nov 2024 05:17:33 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	yury.khrustalev@arm.com,
	will@kernel.org,
	linux-kselftest@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: [PATCH] selftests/mm: Define PKEY_UNRESTRICTED for pkey_sighandler_tests
Date: Thu,  7 Nov 2024 13:16:40 +0000
Message-ID: <20241107131640.650703-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6e182dc9f268 ("selftests/mm: Use generic pkey register
manipulation") makes use of PKEY_UNRESTRICTED in
pkey_sighandler_tests. The macro has been proposed for addition to
uapi headers [1], but the patch hasn't landed yet.

Define PKEY_UNRESTRICTED in pkey-helpers.h for the time being to fix
the build.

[1] https://lore.kernel.org/all/20241028090715.509527-2-yury.khrustalev@arm.com/

Fixes: 6e182dc9f268 ("selftests/mm: Use generic pkey register
manipulation")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

Based on arm64 for-next/pkey-signal (49f59573e9e0).

---
 tools/testing/selftests/mm/pkey-helpers.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 9ab6a3ee153b..319f5b6b7132 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -112,6 +112,10 @@ void record_pkey_malloc(void *ptr, long size, int prot);
 #define PKEY_MASK	(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
 #endif
 
+#ifndef PKEY_UNRESTRICTED
+#define PKEY_UNRESTRICTED 0x0
+#endif
+
 #ifndef set_pkey_bits
 static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
 {
-- 
2.43.0


