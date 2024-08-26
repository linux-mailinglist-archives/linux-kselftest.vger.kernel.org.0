Return-Path: <linux-kselftest+bounces-16292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AF795F580
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B67B21B9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1120B194AF6;
	Mon, 26 Aug 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBzGZtah"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D0519413C;
	Mon, 26 Aug 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687295; cv=none; b=o7dGr6btvMGENsuvSby1ivwGZS92U1SV+FU6x7EN/8Dmuae0nHkZvntD31t7UG+0zmZ00WA5t1hWtF7VhY4tSHkYUrP+OLJGnLHBJPsb4h07w3zFOE4NrBVH+pLcYihaMaEt8AWFAt3Xf1cd/YgKLLQ/67ekA7Q5Y+ypG1EpQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687295; c=relaxed/simple;
	bh=G+InZdEellA5Fa695AuPGLjSD3WzX7SNoLqRZFTlhq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErQv4M4MW2PxE/cms/FG8FImey18XY2uAmYS4jLcJp5P3Ze1gvnKjUWcjIhDCl/q4lPBO51jotmXWg0y3rpdQHNFYArlsEBpj+j3SnvxIwl+aZ8Aj4zb87DFbzCRMl6bibvQxrNurg8CeFx9yYEdwus/TRme1goWlbN0RVIfCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBzGZtah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D306FC4FDE1;
	Mon, 26 Aug 2024 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687294;
	bh=G+InZdEellA5Fa695AuPGLjSD3WzX7SNoLqRZFTlhq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JBzGZtah3mr2YchvudG8OhPBm6GaQB7SQOHXdqhGi7HAZlGZSU9qTO/64JPYM9bQo
	 lCy20ebSkJJnRVIJ23JCkMUywBcekNhzWxUVd/PlkL1MrfQgR8GHKj4kalKooaIBQu
	 y5HfkjSbwKbYkS4gCT7+tDWk62YdGyWSh2f/J4EI5vG2svaUkjPsDbAxwKh9EYxCCy
	 qZIKJeqxSQaOlR2Wr8GHY4frPzHlrm7IHSdRhap+Sn8wNUaFCfDYiqdVeTMNuUJA2d
	 qc5BGPlbfkyRwKgTdPauDojRRZkOX1s/GyrzLQ5X75xLPIBG9t7Xk/0jaaCpfwxUfY
	 YXe/jz+iNGsCw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 27 Aug 2024 00:47:53 +0900
Subject: [PATCH v4 3/3] selftests/hid: Add HIDIOCREVOKE tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-hidraw-revoke-v4-3-88c6795bf867@kernel.org>
References: <20240827-hidraw-revoke-v4-0-88c6795bf867@kernel.org>
In-Reply-To: <20240827-hidraw-revoke-v4-0-88c6795bf867@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724687286; l=4826;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=G+InZdEellA5Fa695AuPGLjSD3WzX7SNoLqRZFTlhq8=;
 b=sdiGNtpL7TBXwpcAzrS32Zag0wy6xlF9x6XmngbEI8pih4rSjZV9ynYdcOR3pa73vcIISh4s+
 xnhY2q3YlkzBjcUIAM5tGVft08d+xOx03SnJ2iHJis2W0RMwVkLKf5k
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Add 4 tests for the new revoke ioctl, for read/write/ioctl and poll.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v4
---
 tools/testing/selftests/hid/hidraw.c | 143 +++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/testing/selftests/hid/hidraw.c b/tools/testing/selftests/hid/hidraw.c
index f8c933476dcd..669eada8886b 100644
--- a/tools/testing/selftests/hid/hidraw.c
+++ b/tools/testing/selftests/hid/hidraw.c
@@ -19,6 +19,11 @@
 	__typeof__(b) _b = (b); \
 	_a < _b ? _a : _b; })
 
+/* for older kernels */
+#ifndef HIDIOCREVOKE
+#define HIDIOCREVOKE	      _IOW('H', 0x0D, int) /* Revoke device access */
+#endif /* HIDIOCREVOKE */
+
 static unsigned char rdesc[] = {
 	0x06, 0x00, 0xff,	/* Usage Page (Vendor Defined Page 1) */
 	0x09, 0x21,		/* Usage (Vendor Usage 0x21) */
@@ -516,6 +521,144 @@ TEST_F(hidraw, raw_event)
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
+	ASSERT_EQ(err, -1) TH_LOG("read_hidraw");
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
+	ASSERT_EQ(errno, 19) TH_LOG("unexpected error code while writing to hidraw node: %d",
+				    errno);
+
+	pthread_mutex_unlock(&uhid_output_mtx);
+}
+
 int main(int argc, char **argv)
 {
 	return test_harness_run(argc, argv);

-- 
2.46.0


