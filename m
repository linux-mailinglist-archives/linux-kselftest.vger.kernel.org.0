Return-Path: <linux-kselftest+bounces-16380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8433A960441
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E891F22A2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84019AD6C;
	Tue, 27 Aug 2024 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow24/vp5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61299199FB9;
	Tue, 27 Aug 2024 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746794; cv=none; b=cB4rX69Nx2dC41lDu+M3pnNOOiaHc/JGi3TdO97lQxYsogsy2PRvgTgSjLl171j1AcjR3Vgn/AVjWgBofSmib9c1RDoLKeD6I1aWqrGxlqCeDCwXMN63kCNGg/QqUhKXcF7HgVf3nY62iuusqvEmM2M1qk3xAZwBEhwREYyy+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746794; c=relaxed/simple;
	bh=pst73USFY2/jm8Z3YTbF5rFAbRivyaR41QfG2nVz0AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRBGiw1F7aflo0uYWbYorBaVo8Y9x+73WahPu36IN6YEyWkRuRRPcTZk9NuIcsLMYfXcELmi02B3hVyh45/rzVk4p8kRefeSoBuNRJVseV3Q9u5m1N6PxdEH1S84Ko5pw+zSlob+MTRr0QWL+rV20JzPxg4kA3KzKgV/gmReWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow24/vp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94983C5812F;
	Tue, 27 Aug 2024 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724746793;
	bh=pst73USFY2/jm8Z3YTbF5rFAbRivyaR41QfG2nVz0AQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ow24/vp5ZCtwo0XpdwB0Y9vL3oKSdwvdNzJgXloLGSDGYKmYLNPmwJ8/J2xlNK4t0
	 k8yzCpYEV6x/Ery+H/COfa4KeND/ifqyAzZcTPyHnrcDOsGmAQZcNlq4ujQ//d0y+p
	 qa1iRLWWkWQqkseRVwsiwrJcxNxz/NDxYWZC9Iwr6ACCY32sR5XaGV0n5L4Z+jyrFF
	 XZbqypArH3/Jj0akhCoUQUttgcaLO96o62kIUl9ArZTyozb8xOujn5wQ86B2/QaD0q
	 PV1cUw8yBSxJpsvERQZUlmRvAavwCmMA6DafQv+Vn0FSmyRrUNejLFZCibXKpO76o9
	 H0Nx7sItz/zPw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 27 Aug 2024 17:19:32 +0900
Subject: [PATCH v5 4/4] selftests/hid: Add HIDIOCREVOKE tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-hidraw-revoke-v5-4-d004a7451aea@kernel.org>
References: <20240827-hidraw-revoke-v5-0-d004a7451aea@kernel.org>
In-Reply-To: <20240827-hidraw-revoke-v5-0-d004a7451aea@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724746785; l=5102;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=pst73USFY2/jm8Z3YTbF5rFAbRivyaR41QfG2nVz0AQ=;
 b=y3sUHaueIxVekOt4kgazqknNXdrYHIWgk1jscsc3h2ewTkzvw1IWUyaKLIEYM6K0dHVA4MOEM
 /8PheCYWlTgC9cWUOAGPWLjYbJ7Y0mhcd5ZxGV6wGX+15pAO6RCcktf
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Add 4 tests for the new revoke ioctl, for read/write/ioctl and poll.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

---

new in v4

Changes to v4:
- fix a few error messages
- also check for ENODEV errno when required
- use ENODEV instead of its plain value
---
 tools/testing/selftests/hid/hidraw.c | 147 +++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/tools/testing/selftests/hid/hidraw.c b/tools/testing/selftests/hid/hidraw.c
index 37372709130c..f8b4f7ff292c 100644
--- a/tools/testing/selftests/hid/hidraw.c
+++ b/tools/testing/selftests/hid/hidraw.c
@@ -3,6 +3,11 @@
 
 #include "hid_common.h"
 
+/* for older kernels */
+#ifndef HIDIOCREVOKE
+#define HIDIOCREVOKE	      _IOW('H', 0x0D, int) /* Revoke device access */
+#endif /* HIDIOCREVOKE */
+
 FIXTURE(hidraw) {
 	int dev_id;
 	int uhid_fd;
@@ -84,6 +89,148 @@ TEST_F(hidraw, raw_event)
 	ASSERT_EQ(buf[1], 42);
 }
 
+/*
+ * After initial opening/checks of hidraw, revoke the hidraw
+ * node and check that we can not read any more data.
+ */
+TEST_F(hidraw, raw_event_revoked)
+{
+	__u8 buf[10] = {0};
+	int err;
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[1], 42);
+
+	/* call the revoke ioctl */
+	err = ioctl(self->hidraw_fd, HIDIOCREVOKE, NULL);
+	ASSERT_OK(err) TH_LOG("couldn't revoke the hidraw fd");
+
+	/* inject one other event */
+	buf[0] = 1;
+	buf[1] = 43;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, -1) TH_LOG("read_hidraw");
+	ASSERT_EQ(errno, ENODEV) TH_LOG("unexpected error code while reading the hidraw node: %d",
+					errno);
+}
+
+/*
+ * Revoke the hidraw node and check that we can not do any ioctl.
+ */
+TEST_F(hidraw, ioctl_revoked)
+{
+	int err, desc_size = 0;
+
+	/* call the revoke ioctl */
+	err = ioctl(self->hidraw_fd, HIDIOCREVOKE, NULL);
+	ASSERT_OK(err) TH_LOG("couldn't revoke the hidraw fd");
+
+	/* do an ioctl */
+	err = ioctl(self->hidraw_fd, HIDIOCGRDESCSIZE, &desc_size);
+	ASSERT_EQ(err, -1) TH_LOG("ioctl_hidraw");
+	ASSERT_EQ(errno, ENODEV) TH_LOG("unexpected error code while doing an ioctl: %d",
+					errno);
+}
+
+/*
+ * Setup polling of the fd, and check that revoke works properly.
+ */
+TEST_F(hidraw, poll_revoked)
+{
+	struct pollfd pfds[1];
+	__u8 buf[10] = {0};
+	int err, ready;
+
+	/* setup polling */
+	pfds[0].fd = self->hidraw_fd;
+	pfds[0].events = POLLIN;
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	while (true) {
+		ready = poll(pfds, 1, 5000);
+		ASSERT_EQ(ready, 1) TH_LOG("poll return value");
+
+		if (pfds[0].revents & POLLIN) {
+			memset(buf, 0, sizeof(buf));
+			err = read(self->hidraw_fd, buf, sizeof(buf));
+			ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+			ASSERT_EQ(buf[0], 1);
+			ASSERT_EQ(buf[1], 42);
+
+			/* call the revoke ioctl */
+			err = ioctl(self->hidraw_fd, HIDIOCREVOKE, NULL);
+			ASSERT_OK(err) TH_LOG("couldn't revoke the hidraw fd");
+		} else {
+			break;
+		}
+	}
+
+	ASSERT_TRUE(pfds[0].revents & POLLHUP);
+}
+
+/*
+ * After initial opening/checks of hidraw, revoke the hidraw
+ * node and check that we can not read any more data.
+ */
+TEST_F(hidraw, write_event_revoked)
+{
+	struct timespec time_to_wait;
+	__u8 buf[10] = {0};
+	int err;
+
+	/* inject one event from hidraw */
+	buf[0] = 1; /* report ID */
+	buf[1] = 2;
+	buf[2] = 42;
+
+	pthread_mutex_lock(&uhid_output_mtx);
+
+	memset(output_report, 0, sizeof(output_report));
+	clock_gettime(CLOCK_REALTIME, &time_to_wait);
+	time_to_wait.tv_sec += 2;
+
+	err = write(self->hidraw_fd, buf, 3);
+	ASSERT_EQ(err, 3) TH_LOG("unexpected error while writing to hidraw node: %d", err);
+
+	err = pthread_cond_timedwait(&uhid_output_cond, &uhid_output_mtx, &time_to_wait);
+	ASSERT_OK(err) TH_LOG("error while calling waiting for the condition");
+
+	ASSERT_EQ(output_report[0], 1);
+	ASSERT_EQ(output_report[1], 2);
+	ASSERT_EQ(output_report[2], 42);
+
+	/* call the revoke ioctl */
+	err = ioctl(self->hidraw_fd, HIDIOCREVOKE, NULL);
+	ASSERT_OK(err) TH_LOG("couldn't revoke the hidraw fd");
+
+	/* inject one other event */
+	buf[0] = 1;
+	buf[1] = 43;
+	err = write(self->hidraw_fd, buf, 3);
+	ASSERT_LT(err, 0) TH_LOG("unexpected success while writing to hidraw node: %d", err);
+	ASSERT_EQ(errno, ENODEV) TH_LOG("unexpected error code while writing to hidraw node: %d",
+					errno);
+
+	pthread_mutex_unlock(&uhid_output_mtx);
+}
+
 int main(int argc, char **argv)
 {
 	return test_harness_run(argc, argv);

-- 
2.46.0


