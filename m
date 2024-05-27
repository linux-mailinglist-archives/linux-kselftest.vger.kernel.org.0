Return-Path: <linux-kselftest+bounces-10711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29758D038A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640E51F283DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546FB17967E;
	Mon, 27 May 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNp+/j79"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8A179675;
	Mon, 27 May 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819297; cv=none; b=YTSsD6g0OERzmfWTAL5fJ7Hg/TARZ9eRF7VChSQBMUe1Vvb86PQyvyQHIeLtSct3GvVTa7IGDqlN+K8KcWp+dM6a7AUGrJKPwtdT4V5FLtR6ggdGsKTXA7TMVzGNIPAhLF4a7hDtIAU311Q6puIPpuL43F5ZJOHWWm7IUJlwpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819297; c=relaxed/simple;
	bh=sCvrPt4WIobpFxpQmj0P7zdxczqjn5m5qnrJFzhjgTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNvcBFxBoos9gxaMlZhT+Vv4I/aVq+H79YWrpZbkr1CmtraZPZDDjkWYHDOaMZCIvg/JVmJ4qLE1qilXW4USusIiYRttscUotEi/YAjZRnpK1HHLZb+OC9ppoCYbB/aRM5DIuCPf6wiwPrkiqxlZ9ZZUr6Xz/VBHRqxw9v9n33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNp+/j79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A28C32789;
	Mon, 27 May 2024 14:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819297;
	bh=sCvrPt4WIobpFxpQmj0P7zdxczqjn5m5qnrJFzhjgTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNp+/j79JMbkD+VbSEOImNDMUWi5ahQp43yy019Rm4MjOObaIyTmpW93TiE4IPSQl
	 eBMRwVMuQug7bcsoBqkjRRYVH/a/ZW0DMSt0VJ/oYXGSdrgTNN8Dr+g0jrpBn8LuwK
	 vs3VxWgBuyMzeV75U4t3isCylLLLIN69rPKGUAiqUYBnvWrNRIIZE+M/hhTJoxhZOG
	 ir5KE3J0jJUAlf0kHf03egJv1clqnlmZ6gV81Ms0C4EHVGGcgoW7/LhYehu/F/qwPr
	 BW/h7nx/WZDMuQLLMuUpuXwizDjZA+YdhXnzmovsbkyyVZ/BVlz6XK5+9CMwe1UMdQ
	 kSWUcUhXgheQA==
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
Subject: [PATCH AUTOSEL 6.8 18/30] kselftest: arm64: Add a null pointer check
Date: Mon, 27 May 2024 10:13:27 -0400
Message-ID: <20240527141406.3852821-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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


