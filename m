Return-Path: <linux-kselftest+bounces-9530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53688BD34D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3811F26590
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454A8158A05;
	Mon,  6 May 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Lgb5I+d0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547B15749A
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014535; cv=none; b=q/sJ6RoMAwMxVhYHqrF/jLsu0GGP2SSRARFEdGSMOsHE9oUJuFZKCQy/UhaLCRSUC8JGztcsyT3z/54dNgnGetqLwYd2v4McQAod5jWmbzT58qJzWO11HY+FH5LYhshwnT37E/l6H9Jchx/suZOfng3FeeYI7a70FgXjBjCnjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014535; c=relaxed/simple;
	bh=JPA1fOZ/TX0peHJB7KO41oFcLeZ7LaXWPj+Nzss7qbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6VYn45nLDBlmjc8s2gKfnGNhwCoyPFF9ZAt+Q5g7oSYjgCv6HZjZPutnys0vx7M03P4xg+l+O7OYyp3DjHRUcQ1HQ60p0ZcOzFIeDvsMKOEB0fPZpe0pPu9uirUgZlqLJCNVyrZ7SX2FDs+REc5PxM6hobamJQb1dcB/TMnilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Lgb5I+d0; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VY6wY5rqXz1Fk;
	Mon,  6 May 2024 18:55:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1715014525;
	bh=JPA1fOZ/TX0peHJB7KO41oFcLeZ7LaXWPj+Nzss7qbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lgb5I+d0VxsIAbFEmVXHDVGGkFweKwCSHMITrUzR2VCSUhUbUVVlK3ipGN4KXJpoj
	 XlDeOotxMMhB7sEV80vDlVVCmuy51vcKDVpwfKsgY6H4H7e2pmrepQZfK7gi5j1Kpd
	 aVLlmq3roA+RwrwxiT4o7QUveKAFEVn2MgXjs2M4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VY6wX7241z4kq;
	Mon,  6 May 2024 18:55:24 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6 02/10] selftests/landlock: Fix FS tests when run on a private mount point
Date: Mon,  6 May 2024 18:55:10 +0200
Message-ID: <20240506165518.474504-3-mic@digikod.net>
In-Reply-To: <20240506165518.474504-1-mic@digikod.net>
References: <20240506165518.474504-1-mic@digikod.net>
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

This was spotted while running tests in containers [1], where mount
points are private.

Cc: Günther Noack <gnoack@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Link: https://github.com/landlock-lsm/landlock-test-tools/pull/4 [1]
Fixes: 41cca0542d7c ("selftests/harness: Fix TEST_F()'s vfork handling")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240506165518.474504-3-mic@digikod.net
---

Changes since v1:
* Update commit description.
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
2.45.0


