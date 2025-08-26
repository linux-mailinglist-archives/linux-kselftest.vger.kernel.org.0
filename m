Return-Path: <linux-kselftest+bounces-39945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45697B35F4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 14:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04201BA1483
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 12:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C4B341659;
	Tue, 26 Aug 2025 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcI6Twso"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2562340D9E;
	Tue, 26 Aug 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211999; cv=none; b=a1/KNxnqTPiUqAgobFUVZeYtQhs/EjsR7Rr+FAEJXVCWchdcBoW6gfcRkAHfdsGQmIE5Tx0V3MGfOgSTF//NasqSlMQfIxXht0D45xlyaqgd2r/EJ0Ytf0hns9xFjnCl43oTmYAYKKU32hbDCYhoxeQd0uwwyysoOX85UayAvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211999; c=relaxed/simple;
	bh=VCECJyDSKs2TTpt9lwvmhB5fy4SlZDLG640wB2jfk8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjP866/N+XQfMAsXNvZ3afgo5hl0cLU2XL6cICqb/HUk6NazbSx46633Hzy4Hl38h2hgf0DYKq2ZVZlPFLtLoTxGB9c/z54t4vY+9uEJ+V3DDBtnloxu7pmbowFcolUzE5oMK9DzWfaEPjM7wHzm1k/4q0bMIMqtVoCO3kH3SUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcI6Twso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3C1C113CF;
	Tue, 26 Aug 2025 12:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756211998;
	bh=VCECJyDSKs2TTpt9lwvmhB5fy4SlZDLG640wB2jfk8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qcI6Twso+0c+37Y9UNMH3/HsF3t6lFulri0NNMUYL4aotNU5Z3K8YGidGLvDSpieQ
	 RQwc2gvY5onbQj+HYD4WcqJNNWsb7QVXkiJnT09BG+BbYwb3eBGFMhgOyAmBjE6Hv7
	 CopLq+Tf36a/jY3I5O5UrcpFrpLPHxGr5yE76Gi2CmHc32OvsQwg0H8FGVmeWbLbkI
	 ARr2IZrbWXPzr5iPyzTWr2ImluPiOyblXzL7+sgoajuDY7xZqYyiK1EqBDO9IaYp+L
	 BankLm4D8YlxHJ+0hwv412bHcYVBxL4IdFDKrkhw138yO3uyfSCI8HmclCK0vkncMT
	 CC77lkOsQvXnA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 26 Aug 2025 14:39:40 +0200
Subject: [PATCH v2 2/3] selftests/hid: hidraw: forge wrong ioctls and tests
 them
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-b4-hidraw-ioctls-v2-2-c7726b236719@kernel.org>
References: <20250826-b4-hidraw-ioctls-v2-0-c7726b236719@kernel.org>
In-Reply-To: <20250826-b4-hidraw-ioctls-v2-0-c7726b236719@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756211993; l=5453;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=VCECJyDSKs2TTpt9lwvmhB5fy4SlZDLG640wB2jfk8I=;
 b=TJq8ncFg4FDeR+ln3/8/XvME1bGJbxZsCiSZre0/sw8Id6V896uwp1n5i9Odx674SiHHE9hJ8
 FcdwR+87ZGYAOtS1of95Mld0mcr0GsILs+XsllCI18ekttp2hMGQrek
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We also need coverage for when the malicious user is not using the
proper ioctls definitions and tries to work around the driver.

Suggested-by: Arnd Bergmann <arnd@kernel.org>
Co-developed-by: claude-4-sonnet
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hidraw.c | 127 +++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/tools/testing/selftests/hid/hidraw.c b/tools/testing/selftests/hid/hidraw.c
index 6d61d03e2ef05e1900fe5a3938d93421717b2621..d625772f8b7cf71fd94956d3a49d54ff44e2b34d 100644
--- a/tools/testing/selftests/hid/hidraw.c
+++ b/tools/testing/selftests/hid/hidraw.c
@@ -332,6 +332,133 @@ TEST_F(hidraw, ioctl_gfeature_invalid)
 	ASSERT_EQ(errno, EIO) TH_LOG("expected EIO, got errno %d", errno);
 }
 
+/*
+ * Test ioctl with incorrect nr bits
+ */
+TEST_F(hidraw, ioctl_invalid_nr)
+{
+	char buf[256] = {0};
+	int err;
+	unsigned int bad_cmd;
+
+	/*
+	 * craft an ioctl command with wrong _IOC_NR bits
+	 */
+	bad_cmd = _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x00, sizeof(buf)); /* 0 is not valid */
+
+	/* test the ioctl */
+	err = ioctl(self->hidraw_fd, bad_cmd, buf);
+	ASSERT_LT(err, 0) TH_LOG("ioctl read-write with wrong _IOC_NR (0) should have failed");
+	ASSERT_EQ(errno, ENOTTY)
+		TH_LOG("expected ENOTTY for wrong read-write _IOC_NR (0), got errno %d", errno);
+
+	/*
+	 * craft an ioctl command with wrong _IOC_NR bits
+	 */
+	bad_cmd = _IOC(_IOC_READ, 'H', 0x00, sizeof(buf)); /* 0 is not valid */
+
+	/* test the ioctl */
+	err = ioctl(self->hidraw_fd, bad_cmd, buf);
+	ASSERT_LT(err, 0) TH_LOG("ioctl read-only with wrong _IOC_NR (0) should have failed");
+	ASSERT_EQ(errno, ENOTTY)
+		TH_LOG("expected ENOTTY for wrong read-only _IOC_NR (0), got errno %d", errno);
+
+	/* also test with bigger number */
+	bad_cmd = _IOC(_IOC_READ, 'H', 0x42, sizeof(buf)); /* 0x42 is not valid as well */
+
+	err = ioctl(self->hidraw_fd, bad_cmd, buf);
+	ASSERT_LT(err, 0) TH_LOG("ioctl read-only with wrong _IOC_NR (0x42) should have failed");
+	ASSERT_EQ(errno, ENOTTY)
+		TH_LOG("expected ENOTTY for wrong read-only _IOC_NR (0x42), got errno %d", errno);
+
+	/* also test with bigger number: 0x42 is not valid as well */
+	bad_cmd = _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x42, sizeof(buf));
+
+	err = ioctl(self->hidraw_fd, bad_cmd, buf);
+	ASSERT_LT(err, 0) TH_LOG("ioctl read-write with wrong _IOC_NR (0x42) should have failed");
+	ASSERT_EQ(errno, ENOTTY)
+		TH_LOG("expected ENOTTY for wrong read-write _IOC_NR (0x42), got errno %d", errno);
+}
+
+/*
+ * Test ioctl with incorrect type bits
+ */
+TEST_F(hidraw, ioctl_invalid_type)
+{
+	char buf[256] = {0};
+	int err;
+	unsigned int bad_cmd;
+
+	/*
+	 * craft an ioctl command with wrong _IOC_TYPE bits
+	 */
+	bad_cmd = _IOC(_IOC_WRITE|_IOC_READ, 'I', 0x01, sizeof(buf)); /* 'I' should be 'H' */
+
+	/* test the ioctl */
+	err = ioctl(self->hidraw_fd, bad_cmd, buf);
+	ASSERT_LT(err, 0) TH_LOG("ioctl with wrong _IOC_TYPE (I) should have failed");
+	ASSERT_EQ(errno, EINVAL) TH_LOG("expected EINVAL for wrong _IOC_NR, got errno %d", errno);
+}
+
+/*
+ * Test HIDIOCGFEATURE ioctl with incorrect _IOC_DIR bits
+ */
+TEST_F(hidraw, ioctl_gfeature_invalid_dir)
+{
+	__u8 buf[10] = {0};
+	int err;
+	unsigned int bad_cmd;
+
+	/* set report ID 1 in first byte */
+	buf[0] = 1;
+
+	/*
+	 * craft an ioctl command with wrong _IOC_DIR bits
+	 * HIDIOCGFEATURE should have _IOC_WRITE|_IOC_READ, let's use only _IOC_WRITE
+	 */
+	bad_cmd = _IOC(_IOC_WRITE, 'H', 0x07, sizeof(buf)); /* should be _IOC_WRITE|_IOC_READ */
+
+	/* try to get feature report with wrong direction bits */
+	err = ioctl(self->hidraw_fd, bad_cmd, buf);
+	ASSERT_LT(err, 0) TH_LOG("HIDIOCGFEATURE with wrong _IOC_DIR should have failed");
+	ASSERT_EQ(errno, EINVAL) TH_LOG("expected EINVAL for wrong _IOC_DIR, got errno %d", errno);
+
+	/* also test with only _IOC_READ */
+	bad_cmd = _IOC(_IOC_READ, 'H', 0x07, sizeof(buf)); /* should be _IOC_WRITE|_IOC_READ */
+
+	err = ioctl(self->hidraw_fd, bad_cmd, buf);
+	ASSERT_LT(err, 0) TH_LOG("HIDIOCGFEATURE with wrong _IOC_DIR should have failed");
+	ASSERT_EQ(errno, EINVAL) TH_LOG("expected EINVAL for wrong _IOC_DIR, got errno %d", errno);
+}
+
+/*
+ * Test read-only ioctl with incorrect _IOC_DIR bits
+ */
+TEST_F(hidraw, ioctl_readonly_invalid_dir)
+{
+	char buf[256] = {0};
+	int err;
+	unsigned int bad_cmd;
+
+	/*
+	 * craft an ioctl command with wrong _IOC_DIR bits
+	 * HIDIOCGRAWNAME should have _IOC_READ, let's use _IOC_WRITE
+	 */
+	bad_cmd = _IOC(_IOC_WRITE, 'H', 0x04, sizeof(buf)); /* should be _IOC_READ */
+
+	/* try to get device name with wrong direction bits */
+	err = ioctl(self->hidraw_fd, bad_cmd, buf);
+	ASSERT_LT(err, 0) TH_LOG("HIDIOCGRAWNAME with wrong _IOC_DIR should have failed");
+	ASSERT_EQ(errno, EINVAL) TH_LOG("expected EINVAL for wrong _IOC_DIR, got errno %d", errno);
+
+	/* also test with _IOC_WRITE|_IOC_READ */
+	bad_cmd = _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x04, sizeof(buf)); /* should be only _IOC_READ */
+
+	err = ioctl(self->hidraw_fd, bad_cmd, buf);
+	ASSERT_LT(err, 0) TH_LOG("HIDIOCGRAWNAME with wrong _IOC_DIR should have failed");
+	ASSERT_EQ(errno, EINVAL) TH_LOG("expected EINVAL for wrong _IOC_DIR, got errno %d", errno);
+}
+
 /*
  * Test HIDIOCSFEATURE ioctl to set feature report
  */

-- 
2.51.0


