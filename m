Return-Path: <linux-kselftest+bounces-5862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3CF871116
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 00:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB08B2834E4
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 23:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6EB7C6DB;
	Mon,  4 Mar 2024 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwTfVa4N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021551E86E;
	Mon,  4 Mar 2024 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595384; cv=none; b=P+QMGTvUe3l4C3hXLR4UDPO1H5XKVlXwEhL+U5JLLz9pPQC1QYkwl8SCPmfIMEqrICYW007gjFYB9JfUAu2LM2zkPhcAvBtVoW2JzGPvhF0gZ/hdg30PqVpked1cztTsF39qSPi4OoGaL8ZHOG7HZgEEzjSSUriafeY7XZ2o16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595384; c=relaxed/simple;
	bh=zD4aQTIVjooBfUJtU0BUb2mrLEa7n8Z7akmW+sGwu6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eceXLEmsXM5Tb7aEnm0c7VzGKK+i+hIQhD7eggcNilKSifqfonfv/mO8xqXtekJVRSIpH6WU+ab4e76N1MfTVz7j6xmwZeEt36gBYBn8q3RmenkCJi5a0h8D5cn2QQTKc9ki9rh7zNjE1EUFSJ5SE77sM3Mbf/yUHWZipLmTfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwTfVa4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062A2C433C7;
	Mon,  4 Mar 2024 23:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595383;
	bh=zD4aQTIVjooBfUJtU0BUb2mrLEa7n8Z7akmW+sGwu6Y=;
	h=From:To:Cc:Subject:Date:From;
	b=hwTfVa4N1x+M/8qizFnFCv7/A77ZIWGs5rtYbDMiKHp7CLe5HaxJSa9pwEaZxA/4H
	 3/LZuV+ReNHz5wY+Nzc87pXzlizRGNDfsxWisYCOPXlXbnzVHreTLvQdrlGTZYGldC
	 wdal9IEsQkO8AojOG1phQGI5ZfzO3NMrQC2HTJ2gcQi5wmk9vaJuL8c1VDaISTanPT
	 pnLD+D/WKt496woFqUK5xkKBC8rUtrcUamUamzYi6SKwVQXtUD+i+LgLAXTh3C0oph
	 Ud2VMLoV+qFOa5ytIn2/leeqFMaBdYf4kljco1nXZmFsmYMYtu4qZqQDB2NkQhET5j
	 An/4tgXibCzzQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	ivan.orlov0322@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	jglisse@redhat.com,
	akpm@linux-foundation.org,
	keescook@chromium.org,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH net-next] selftests: avoid using SKIP(exit()) in harness fixure setup
Date: Mon,  4 Mar 2024 15:36:20 -0800
Message-ID: <20240304233621.646054-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selftest harness uses various exit codes to signal test
results. Avoid calling exit() directly, otherwise tests
may get broken by harness refactoring (like the commit
under Fixes). SKIP() will instruct the harness that the
test shouldn't run, it used to not be the case, but that
has been fixed. So just return, no need to exit.

Note that for hmm-tests this actually changes the result
from pass to skip. Which seems fair, the test is skipped,
after all.

Reported-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/all/05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk
Fixes: a724707976b0 ("selftests: kselftest_harness: use KSFT_* exit codes")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
This needs to go to net-next because that's where the breaking
patch was (mis?)-applied.

CC: ivan.orlov0322@gmail.com
CC: perex@perex.cz
CC: tiwai@suse.com
CC: broonie@kernel.org
CC: shuah@kernel.org
CC: jglisse@redhat.com
CC: akpm@linux-foundation.org
CC: keescook@chromium.org
CC: linux-sound@vger.kernel.org
CC: linux-kselftest@vger.kernel.org
CC: linux-mm@kvack.org
---
 tools/testing/selftests/alsa/test-pcmtest-driver.c | 4 ++--
 tools/testing/selftests/mm/hmm-tests.c             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
index a52ecd43dbe3..ca81afa4ee90 100644
--- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
+++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
@@ -127,11 +127,11 @@ FIXTURE_SETUP(pcmtest) {
 	int err;
 
 	if (geteuid())
-		SKIP(exit(-1), "This test needs root to run!");
+		SKIP(return, "This test needs root to run!");
 
 	err = read_patterns();
 	if (err)
-		SKIP(exit(-1), "Can't read patterns. Probably, module isn't loaded");
+		SKIP(return, "Can't read patterns. Probably, module isn't loaded");
 
 	card_name = malloc(127);
 	ASSERT_NE(card_name, NULL);
diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 20294553a5dd..d2cfc9b494a0 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -138,7 +138,7 @@ FIXTURE_SETUP(hmm)
 
 	self->fd = hmm_open(variant->device_number);
 	if (self->fd < 0 && hmm_is_coherent_type(variant->device_number))
-		SKIP(exit(0), "DEVICE_COHERENT not available");
+		SKIP(return, "DEVICE_COHERENT not available");
 	ASSERT_GE(self->fd, 0);
 }
 
@@ -149,7 +149,7 @@ FIXTURE_SETUP(hmm2)
 
 	self->fd0 = hmm_open(variant->device_number0);
 	if (self->fd0 < 0 && hmm_is_coherent_type(variant->device_number0))
-		SKIP(exit(0), "DEVICE_COHERENT not available");
+		SKIP(return, "DEVICE_COHERENT not available");
 	ASSERT_GE(self->fd0, 0);
 	self->fd1 = hmm_open(variant->device_number1);
 	ASSERT_GE(self->fd1, 0);
-- 
2.44.0


