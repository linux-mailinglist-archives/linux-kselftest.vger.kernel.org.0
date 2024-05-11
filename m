Return-Path: <linux-kselftest+bounces-10099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494398C32B9
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 19:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063CA282129
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 17:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E12224D7;
	Sat, 11 May 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gfqOwzmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C441BC53
	for <linux-kselftest@vger.kernel.org>; Sat, 11 May 2024 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715447705; cv=none; b=tCBe1lV3HFkNIR2wGGV/p700/HrH/vaYqqdCOuMmqr5wNol62El5MjNXcDWh+ZChi8421RsZjaB/h1/W7zOBYkhHcG2rcUP5TuWaVuGxyTwmASW0HbP7ag1gfdetHqdn6MFQO8+KicWOs/UeGGOgEBniu6g/jx8CM2PyFs4JXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715447705; c=relaxed/simple;
	bh=7YexxkTj1uuMmulLuHFcKF1u4yf9zWrpmFdXbDjUUew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggvqRimpunXAaGzWBFo0lrGGtZDiukC0h5RlAkCTdsnOGm82e5U0N1ULeDD0hGQuhwmDETQrPideCIHeNZPforSVgh3y56ImAS6FR+FeSUPSKeZQuJLo8wUzzCU0Yy4bcO0buw9R/eAfhTfqMBdpZ9c4zI5n/D2XojGISLpvtj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gfqOwzmW; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VcC6j4l9Nzlhq;
	Sat, 11 May 2024 19:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715447693;
	bh=BOAMdKa6zMCZ8yXBmY/WMF8aDinkuEUhN8IHqnGG5tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfqOwzmWgq26VJdO5r+2pUX1fnIVDnjds6dUYGUuKCRG05yD0VhlhJWYHajvnVU7J
	 UiCgAZnpi6SjAUM/8yTKx64V3LSKJDrhZoia1tU3/cSOSuVLU0YVJg13Mx5SFGODTk
	 uoFFPa/QPlodaf3CfDHfqYRyLzclXop5fgct9+Ks=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VcC6h5cQRz7lK;
	Sat, 11 May 2024 19:14:52 +0200 (CEST)
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
Subject: [PATCH v7 02/10] selftests/landlock: Fix FS tests when run on a private mount point
Date: Sat, 11 May 2024 19:14:37 +0200
Message-ID: <20240511171445.904356-3-mic@digikod.net>
In-Reply-To: <20240511171445.904356-1-mic@digikod.net>
References: <20240511171445.904356-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20240511171445.904356-3-mic@digikod.net
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


