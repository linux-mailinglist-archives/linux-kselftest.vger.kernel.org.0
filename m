Return-Path: <linux-kselftest+bounces-10722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5798D045B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 16:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A443B2F7B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F98A61FEF;
	Mon, 27 May 2024 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8D+O5fH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7361FEB;
	Mon, 27 May 2024 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819517; cv=none; b=q0uDcc+jz8AX473tuIxKuFNZsU/eXKMZZKTW/A8/SbXry3boKF6n3MyGwIHZ3C1AnpU8AKKGM/eEo0jbshWqDQP4lughyQajJha+e0pKTM3dp7/sweHVkOVoMnwyOzoHSpqFw6q4uRfOEYo6mXyYYw/HZm5DF5NMRSZn8RNr/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819517; c=relaxed/simple;
	bh=sCvrPt4WIobpFxpQmj0P7zdxczqjn5m5qnrJFzhjgTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0ahq0/KSZDwHlwbwiZSnJdIOiQzSNfC/mmwKCS8l3Yr2Epos50cK9ToywqNOJXlVo2b2qMcc7oTUNLJs9lKyw6oZGWFlr094Ns9kJiGgiV+o+E+2XYLOrC268adxAo5AARJC/Fi8/q0h5K9bimL4e8vC1iJToobl9r80HT2R28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8D+O5fH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88656C32781;
	Mon, 27 May 2024 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819516;
	bh=sCvrPt4WIobpFxpQmj0P7zdxczqjn5m5qnrJFzhjgTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8D+O5fHRVxNqMGBllpdrRn3ja1tOzmQi25ld2N04MFsT6H40eTv3qQcu0afvkl5K
	 qybr8uKLE2mA6LlbpXKy8A5foLr9rieWfSUzH0RnWvSjVwfORFS6BKoE2PsD5c0LGp
	 S9PTGQWTIghYTlg8zWImJhpmeYcVt8v07Bd74cLwBkZ3dVtDpWSFl2gmZavHgOLGXP
	 Ex+kRy0vaS3aBqV/mGzXq17+Uf7XNNWIETAa0UKmmXZRBHglZud6vV8tvlozCRnodW
	 frQEnMhc6ol31mjHRt5WHXlXK68QBUyA82EP+trXQUkcaLtoxSgH8Qi9y3/ufJETL3
	 fx60yy+TmHgcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/13] kselftest: arm64: Add a null pointer check
Date: Mon, 27 May 2024 10:18:02 -0400
Message-ID: <20240527141819.3854376-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141819.3854376-1-sashal@kernel.org>
References: <20240527141819.3854376-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 80164282b3620a3cb73de6ffda5592743e448d0e ]

There is a 'malloc' call, which can be unsuccessful.
This patch will add the malloc failure checking
to avoid possible null dereference and give more information
about test fail reasons.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20240423082102.2018886-1-chentao@kylinos.cn
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/tags/tags_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
index 5701163460ef7..955f87c1170d7 100644
--- a/tools/testing/selftests/arm64/tags/tags_test.c
+++ b/tools/testing/selftests/arm64/tags/tags_test.c
@@ -6,6 +6,7 @@
 #include <stdint.h>
 #include <sys/prctl.h>
 #include <sys/utsname.h>
+#include "../../kselftest.h"
 
 #define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
 #define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
@@ -21,6 +22,9 @@ int main(void)
 	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
 		tbi_enabled = 1;
 	ptr = (struct utsname *)malloc(sizeof(*ptr));
+	if (!ptr)
+		ksft_exit_fail_msg("Failed to allocate utsname buffer\n");
+
 	if (tbi_enabled)
 		tag = 0x42;
 	ptr = (struct utsname *)SET_TAG(ptr, tag);
-- 
2.43.0


