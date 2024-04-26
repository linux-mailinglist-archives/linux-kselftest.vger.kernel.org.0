Return-Path: <linux-kselftest+bounces-8929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9BC8B3E12
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 19:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC8D1F279C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA4E1802A5;
	Fri, 26 Apr 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="b5brXSr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC0117799F
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152195; cv=none; b=a7y3Kwl1iirTqFYlqk+8bivx6eWqc8rs8jrFZKrlwBY4O59oH5DvlAD7r5aR4TwaptPYiHCeN4FIQuq0EcFJccS1TLJ58wLYNTFEy1MmkVIwDOcvm3gR4Skh3dD3Et3md5j7ycZnk4056jLdhR9OqGYAvnqycJCNOuOQEdEE1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152195; c=relaxed/simple;
	bh=6kRuOtJ4a93MXDCwtzvP1VdtvY2kl4/ucaoZA2ZyQwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKg5FdrTj7qELQMYvKq1d0LwjrV8nq9pUsOUHPeU/hkz05sMCzn1sotMrRgn1TDE/e4/yWkUar7WxA6nLvGHrECobEeJ4ohi6nc+CboDVaX7a8nY3qTq1KP5o+ctFMbV7HtX7sqswETr/tk+ukvpb/TshzPALZ120ahdMJZ2NVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=b5brXSr/; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VR01625gfzVFG;
	Fri, 26 Apr 2024 19:23:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714152186;
	bh=6kRuOtJ4a93MXDCwtzvP1VdtvY2kl4/ucaoZA2ZyQwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5brXSr/ayXj1jxkxMnO/ban2apbqGPXZGnhyjDGWltc9xixX/hbl2lO891HwPkLS
	 ccZSTRqsUl4IDTS8VMnIpn9sdePz/T7iJ0V2bwHMBEsfimRZLrZ492bWldGsXOa5gw
	 k18BGvGa1prg06wt4moxAesuZk7X4nne4B3LlAbA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VR0155F9lz4b8;
	Fri, 26 Apr 2024 19:23:05 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1 2/5] selftests/landlock: Fix FS tests when run on a private mount point
Date: Fri, 26 Apr 2024 19:22:49 +0200
Message-ID: <20240426172252.1862930-3-mic@digikod.net>
In-Reply-To: <20240426172252.1862930-1-mic@digikod.net>
References: <20240426172252.1862930-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

According to the test environment, the mount point of the test's working
directory may be shared or not, which changes the visibility of the
nested "tmp" mount point for the test's parent process calling
umount("tmp").

This was spotted while running tests on different Linux distributions,
with different mount point configurations.

Cc: Günther Noack <gnoack@google.com>
Fixes: 41cca0542d7c ("selftests/harness: Fix TEST_F()'s vfork handling")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240426172252.1862930-3-mic@digikod.net
---
 tools/testing/selftests/landlock/fs_test.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 9a6036fbf289..46b9effd53e4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -293,7 +293,15 @@ static void prepare_layout(struct __test_metadata *const _metadata)
 static void cleanup_layout(struct __test_metadata *const _metadata)
 {
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(0, umount(TMP_DIR));
+	if (umount(TMP_DIR)) {
+		/*
+		 * According to the test environment, the mount point of the
+		 * current directory may be shared or not, which changes the
+		 * visibility of the nested TMP_DIR mount point for the test's
+		 * parent process doing this cleanup.
+		 */
+		ASSERT_EQ(EINVAL, errno);
+	}
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, remove_path(TMP_DIR));
 }
-- 
2.44.0


