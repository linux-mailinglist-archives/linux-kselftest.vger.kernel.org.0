Return-Path: <linux-kselftest+bounces-10716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3649D8D03E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 16:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB90E1F21841
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BBA16D300;
	Mon, 27 May 2024 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BibnUmgE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5619DF4E;
	Mon, 27 May 2024 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819390; cv=none; b=FTLJSjnIRFY5HDknuDPQmTwynsTtUrM4pQA7rn+a+jEokHjFG/O8sJ+7lQeNvFzjWmVdK/+K6FoOzdKj+x8HzHEUvE7v0r97swqJuzqY2bzTyN3MINYq+iinwCvRYOv/qVLimHXpzRumMPvZ6N/TKSLBT7HPlkz8IFUrqx3Bv1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819390; c=relaxed/simple;
	bh=sCvrPt4WIobpFxpQmj0P7zdxczqjn5m5qnrJFzhjgTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEb2M3wtbl+GzcHI93eM584huaDWBUHtMnQeel9QcZNJKVmYWbvzawJyeIizlkcm6AAK36ADB7fBpS7m0FwAOhunSqWoKXqr7cTzhkF7P4l0KHNAumltAZCyb7rp1bEhxWd+9S+RtWgcLryATIV8aQu+9iOK3Z3IKnsLRPVa/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BibnUmgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5ECC2BBFC;
	Mon, 27 May 2024 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819390;
	bh=sCvrPt4WIobpFxpQmj0P7zdxczqjn5m5qnrJFzhjgTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BibnUmgE6/ZDPe/Wn4phpoL6R8J7mh/2sHdsViFszcU+4lfY+eO4CcKBdnRRmWpJy
	 ieKwTcx8uoMou7fX9+s9RWz1f7jQ3j7qhOleV0LI/yvyyw6IWtCgQjYKvLTzf+r0XX
	 gvxf3XAwOp/vBa3bCp6T5R+IBJkeqLNtvv8uKjGQBANLiNfck00RLzv7n3YjKzF3iS
	 2weFKM0OlKAl1r6r8BAix3n7f1dbd9ulQ4KfT0V8tn6gvHPC8akNAY+JSVMmAQhfyL
	 Cmu2q//LwJGB6PAhxRkUTQmRtSIrUARM4Nbp0dmYaB400LXxpJ1a7HriV0VtFyA2C/
	 G5zgorv6WGlyw==
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
Subject: [PATCH AUTOSEL 6.6 13/21] kselftest: arm64: Add a null pointer check
Date: Mon, 27 May 2024 10:15:24 -0400
Message-ID: <20240527141551.3853516-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141551.3853516-1-sashal@kernel.org>
References: <20240527141551.3853516-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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


