Return-Path: <linux-kselftest+bounces-14853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF1948F95
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD882834C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE461C68AE;
	Tue,  6 Aug 2024 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKh1XZWm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313611C688D;
	Tue,  6 Aug 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948777; cv=none; b=G2jGpZqN7fY2vSuXdJTTjWDQmkxKF+yxVMgb348nYo5LymnKj1ARkQWH2yhagEACKOcg2Ajzl9CUpMahC8/FmSWtwB8s3mwvxHwCefoH7A7rloCY1WJvM4eAWbanB7DtWugoH4lcP3Ma4NC+ky34K04ckWRpzuPtcJfXPBAOnlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948777; c=relaxed/simple;
	bh=/55xrf/HuMLBT6TGFOESB6Qj7so2A9YjCR50+l6/JaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2Y8cTE9eTpnxGfTI5y+mDdesuvTj5t91C+BoH42VBnSRVLo18WD1ucbvM0AqaPFfMdlrXS3HKBUA77WEQda/+GoJ2a/ygL0zssBesI2UhIncWhf3Jm2iUmOxlR4lRsj4/6kr+VeLKhKQlQiK/lj4NxLbuv12tO6QjN8XdFTTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKh1XZWm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281da2cdaeso711035e9.2;
        Tue, 06 Aug 2024 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722948773; x=1723553573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwC3+x5PmJt8tLZdNyQYdkJXkd65oNOA/vjxCPkni7k=;
        b=IKh1XZWm2soWkzdWnHRzvGgLpygQbq/Hq55ZBo2T9olvvbWQZUloFQFykUxjWl2S9Y
         XnKcT615qDxGDF+zwYOrisQtq4qbG1Ifw81LBCM5nUQg9kVfPDEZiiJYrWrgUHWrndzZ
         Ak3J+0guMd5S1NFh/c2JzfrA6GIbDbNvj8Ue5jZcVe2BL6HpHujxf8EQlyrMy+AV7uKo
         a4Ky5yYkhc7c8Mz599tZCsc2L7mlSWF8Hb1WTyxu1X7/b1fagqCsqo6gAHR21zbeMkI2
         BmbElep7EuGS8mSuIctKJ9h3Dlc0cLuO5mcE6RM7joJjKxtI303hHP0fUOTYecbvf8jr
         9Fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948773; x=1723553573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwC3+x5PmJt8tLZdNyQYdkJXkd65oNOA/vjxCPkni7k=;
        b=bObXXXhKe3MA7bKebSnvFYf1VzowzWjO4vqQPThSNKIAKsh+WxyySs6bwowdPwL5Jw
         tyo/n1DoVLctEIO0fkB8e+ovTOOdRPYGxH59lQxyAOpK9GYL6zf5uSz8Z4ypw+ksOrUE
         lP/Su7x4pjxVc9aC0PpkEjkWMno47Ixe9K4UYY8FqW/ML3gRTkmrBJs5vYMcG+N2v9un
         i+0h+36zD46EvIcrwsawftG3QRK8JsZB114kPgSDYVUsdh01BPsZq83wif3E/C+Quzhg
         MknGwDqMwgDoDMVgi3i7K8PGYs2A7p63t3KUJAFqvEnRcf+FWqyi84V1thkORS8msreS
         GzJg==
X-Forwarded-Encrypted: i=1; AJvYcCV7aiztsGby+Bvowbe7DqKJkgiH+I9AE9fZmZVwXhs9CCmd1zfEgS0nvhV8SzojgBY3UMZKq/yErPU=@vger.kernel.org, AJvYcCVBplm6LHW3a7/Q04v4JOkpWTI+LlklaW+GVqOqmbxOEh4wiNbQNpJLLBlLvnaaViCex5tUeDJXVkr5L34v@vger.kernel.org, AJvYcCVZmZx5uGcXCjPd6q5MCPcgvMx2nlnAgzbV5fYz6OKlbtliq+cUqlGOsA/5jGJdLu6AcH8HL11LXasFyUke463N@vger.kernel.org, AJvYcCVqczIJe4nYaoo1g2NtOjsJEhS6sawddiogGRrEch64YSJwbCR9XhUZ6956MZAYQBbtjNpNWzkpMZL1T10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykjg5jipIITWhpj2VfyJ0WvP1sbwE0j+3xQrkCoTD/4jDqukap
	9r2votB2nKg081WX7S3tlJG/u8sjEd1SkUoMQjKfXWX7kagrsP3P
X-Google-Smtp-Source: AGHT+IEkEkXNKeqwp+uHF5MIDYP23+ex35LTXHBjQB29zk0y1ZqwFJXKCLAB3ZudDVib1YsoGtjHvg==
X-Received: by 2002:a05:600c:1d04:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-428e6b80263mr64997365e9.3.1722948773334;
        Tue, 06 Aug 2024 05:52:53 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:b50e:24fa:fd17:c835])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d648a0sm179487255e9.10.2024.08.06.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:52:52 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	shuah@kernel.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	aholzinger@gmx.de
Subject: [PATCH v3 4/4] selftests: ALSA: Cover userspace-driven timers with test
Date: Tue,  6 Aug 2024 13:52:43 +0100
Message-Id: <20240806125243.449959-5-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125243.449959-1-ivan.orlov0322@gmail.com>
References: <20240806125243.449959-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for the new functionality of userspace-driven timers and the
tool which allows us to count timer ticks in a certain time period. The
test:

1. Creates a userspace-driven timer with ioctl to /dev/snd/timer
2. Starts the `global-timer` application to count the ticks of the timer
from step 1.
3. Asynchronously triggers the timer multiple times with some interval
4. Compares the amount of caught ticks with the amount of trigger calls.

Since we can't include <alsa/asoundlib.h> and <sound/asound.h> in one
file due to overlapping declarations, I have to split the test into two
applications: one of them counts the amount of timer ticks in the
defined time period, and another one is the actual test which creates
the timer, triggers it periodically and starts the first app to count
the amount of ticks in a separate thread.

Besides from testing the functionality itself, the test represents a
sample application showing userspace-driven ALSA timers API.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Return NULL in the pthreaded function (ticking_func)
- Process TIMER_NO_EVENT enum in the timer app output processing loop
V2 -> V3:
- Add new test case to cover invalid period sizes and frame rates for
the userspace-driven timers (to test the sanity checks in
snd_utimer_create)

 tools/testing/selftests/alsa/Makefile       |   2 +-
 tools/testing/selftests/alsa/global-timer.c |  87 ++++++++++
 tools/testing/selftests/alsa/utimer-test.c  | 170 ++++++++++++++++++++
 3 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/alsa/global-timer.c
 create mode 100644 tools/testing/selftests/alsa/utimer-test.c

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index c1ce39874e2b..0d5bd8ea900b 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -12,7 +12,7 @@ LDLIBS+=-lpthread
 
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS := mixer-test pcm-test test-pcmtest-driver
+TEST_GEN_PROGS := mixer-test pcm-test utimer-test test-pcmtest-driver global-timer
 
 TEST_GEN_PROGS_EXTENDED := libatest.so
 
diff --git a/tools/testing/selftests/alsa/global-timer.c b/tools/testing/selftests/alsa/global-timer.c
new file mode 100644
index 000000000000..c15ec0ba851a
--- /dev/null
+++ b/tools/testing/selftests/alsa/global-timer.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This tool is used by the utimer test, and it allows us to
+ * count the ticks of a global timer in a certain time frame
+ * (which is set by `timeout` parameter).
+ *
+ * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <alsa/asoundlib.h>
+#include <time.h>
+
+static int ticked;
+static void async_callback(snd_async_handler_t *ahandler)
+{
+	ticked++;
+}
+
+static char timer_name[64];
+static void bind_to_timer(int device, int subdevice, int timeout)
+{
+	snd_timer_t *handle;
+	snd_timer_params_t *params;
+	snd_async_handler_t *ahandler;
+
+	time_t end;
+
+	sprintf(timer_name, "hw:CLASS=%d,SCLASS=%d,DEV=%d,SUBDEV=%d",
+		SND_TIMER_CLASS_GLOBAL, SND_TIMER_SCLASS_NONE,
+		device, subdevice);
+
+	snd_timer_params_alloca(&params);
+
+	if (snd_timer_open(&handle, timer_name, SND_TIMER_OPEN_NONBLOCK) < 0) {
+		perror("Can't open the timer");
+		exit(EXIT_FAILURE);
+	}
+
+	snd_timer_params_set_auto_start(params, 1);
+	snd_timer_params_set_ticks(params, 1);
+	if (snd_timer_params(handle, params) < 0) {
+		perror("Can't set timer params");
+		exit(EXIT_FAILURE);
+	}
+
+	if (snd_async_add_timer_handler(&ahandler, handle, async_callback, NULL) < 0) {
+		perror("Can't create a handler");
+		exit(EXIT_FAILURE);
+	}
+	end = time(NULL) + timeout;
+	if (snd_timer_start(handle) < 0) {
+		perror("Failed to start the timer");
+		exit(EXIT_FAILURE);
+	}
+	printf("Timer has started\n");
+	while (time(NULL) <= end) {
+		/*
+		 * Waiting for the timeout to elapse. Can't use sleep here, as it gets
+		 * constantly interrupted by the signal from the timer (SIGIO)
+		 */
+	}
+	snd_timer_stop(handle);
+	snd_timer_close(handle);
+}
+
+int main(int argc, char *argv[])
+{
+	int device, subdevice, timeout;
+
+	if (argc < 4) {
+		perror("Usage: %s <device> <subdevice> <timeout>");
+		return EXIT_FAILURE;
+	}
+
+	setlinebuf(stdout);
+
+	device = atoi(argv[1]);
+	subdevice = atoi(argv[2]);
+	timeout = atoi(argv[3]);
+
+	bind_to_timer(device, subdevice, timeout);
+
+	printf("Total ticks count: %d\n", ticked);
+
+	return EXIT_SUCCESS;
+}
diff --git a/tools/testing/selftests/alsa/utimer-test.c b/tools/testing/selftests/alsa/utimer-test.c
new file mode 100644
index 000000000000..fee4d21a1955
--- /dev/null
+++ b/tools/testing/selftests/alsa/utimer-test.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This test covers the functionality of userspace-driven ALSA timers. Such timers
+ * are purely virtual (so they don't directly depend on the hardware), and they could be
+ * created and triggered by userspace applications.
+ *
+ * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
+ */
+#include "../kselftest_harness.h"
+#include <sound/asound.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/ioctl.h>
+#include <stdlib.h>
+#include <pthread.h>
+#include <string.h>
+
+#define FRAME_RATE 8000
+#define PERIOD_SIZE 4410
+#define UTIMER_DEFAULT_ID -1
+#define NANO 1000000000ULL
+#define TICKS_COUNT 10
+#define TICKS_RECORDING_DELTA 5
+#define TIMER_OUTPUT_BUF_LEN 1024
+#define TIMER_FREQ_SEC 1
+#define RESULT_PREFIX_LEN strlen("Total ticks count: ")
+
+enum timer_app_event {
+	TIMER_APP_STARTED,
+	TIMER_APP_RESULT,
+	TIMER_NO_EVENT,
+};
+
+FIXTURE(timer_f) {
+	int utimer_fd;
+	struct snd_utimer_info *utimer_info;
+};
+
+FIXTURE_SETUP(timer_f) {
+	int timer_dev_fd;
+
+	if (geteuid())
+		SKIP(return, "This test needs root to run!");
+
+	self->utimer_info = calloc(1, sizeof(*self->utimer_info));
+	ASSERT_NE(NULL, self->utimer_info);
+
+	self->utimer_info->frame_rate = FRAME_RATE;
+	self->utimer_info->period_size = PERIOD_SIZE;
+	self->utimer_info->id = UTIMER_DEFAULT_ID;
+
+	timer_dev_fd = open("/dev/snd/timer", O_RDONLY);
+	ASSERT_GE(timer_dev_fd, 0);
+
+	self->utimer_fd = ioctl(timer_dev_fd, SNDRV_TIMER_IOCTL_CREATE, self->utimer_info);
+	ASSERT_GE(self->utimer_fd, 0);
+
+	close(timer_dev_fd);
+}
+
+FIXTURE_TEARDOWN(timer_f) {
+	close(self->utimer_fd);
+	free(self->utimer_info);
+}
+
+static void *ticking_func(void *data)
+{
+	int i;
+	int *fd = (int *)data;
+
+	for (i = 0; i < TICKS_COUNT; i++) {
+		/* Well, trigger the timer! */
+		ioctl(*fd, SNDRV_TIMER_IOCTL_TRIGGER, NULL);
+		sleep(TIMER_FREQ_SEC);
+	}
+
+	return NULL;
+}
+
+static enum timer_app_event parse_timer_output(const char *s)
+{
+	if (strstr(s, "Timer has started"))
+		return TIMER_APP_STARTED;
+	if (strstr(s, "Total ticks count"))
+		return TIMER_APP_RESULT;
+
+	return TIMER_NO_EVENT;
+}
+
+static int parse_timer_result(const char *s)
+{
+	char *end;
+	long d;
+
+	d = strtol(s + RESULT_PREFIX_LEN, &end, 10);
+	if (end == s + RESULT_PREFIX_LEN)
+		return -1;
+
+	return d;
+}
+
+/*
+ * This test triggers the timer and counts ticks at the same time. The amount
+ * of the timer trigger calls should be equal to the amount of ticks received.
+ */
+TEST_F(timer_f, utimer) {
+	char command[64];
+	pthread_t ticking_thread;
+	int total_ticks = 0;
+	FILE *rfp;
+	char *buf = malloc(TIMER_OUTPUT_BUF_LEN);
+
+	ASSERT_NE(buf, NULL);
+
+	/* The timeout should be the ticks interval * count of ticks + some delta */
+	sprintf(command, "./global-timer %d %d %d", SNDRV_TIMER_GLOBAL_UDRIVEN,
+		self->utimer_info->id, TICKS_COUNT * TIMER_FREQ_SEC + TICKS_RECORDING_DELTA);
+
+	rfp = popen(command, "r");
+	while (fgets(buf, TIMER_OUTPUT_BUF_LEN, rfp)) {
+		buf[TIMER_OUTPUT_BUF_LEN - 1] = 0;
+		switch (parse_timer_output(buf)) {
+		case TIMER_APP_STARTED:
+			/* global-timer waits for timer to trigger, so start the ticking thread */
+			pthread_create(&ticking_thread, NULL, ticking_func,
+				       &self->utimer_fd);
+			break;
+		case TIMER_APP_RESULT:
+			total_ticks = parse_timer_result(buf);
+			break;
+		case TIMER_NO_EVENT:
+			break;
+		}
+	}
+	pthread_join(ticking_thread, NULL);
+	ASSERT_EQ(total_ticks, TICKS_COUNT);
+	pclose(rfp);
+}
+
+static struct snd_utimer_info wrong_timers[] = {
+	/* Period size is not valid (=0) */
+	{ .frame_rate = FRAME_RATE, .period_size = 0, .id = UTIMER_DEFAULT_ID },
+	/* Frame rate is not valid (=0) */
+	{ .frame_rate = 0, .period_size = PERIOD_SIZE, .id = UTIMER_DEFAULT_ID },
+	/* Frame rate is too high (which results in resolution = 0) */
+	{ .frame_rate = NANO + 1, .period_size = PERIOD_SIZE, .id = UTIMER_DEFAULT_ID },
+	/* Causes overflow in resolution */
+	{ .frame_rate = 1, .period_size = ULONG_MAX / NANO + 1, .id = UTIMER_DEFAULT_ID },
+};
+
+TEST(wrong_timers_test) {
+	int timer_dev_fd;
+	int utimer_id;
+	size_t i;
+
+	timer_dev_fd = open("/dev/snd/timer", O_RDONLY);
+	ASSERT_GE(timer_dev_fd, 0);
+
+	for (i = 0; i < ARRAY_SIZE(wrong_timers); i++) {
+		utimer_id = ioctl(timer_dev_fd, SNDRV_TIMER_IOCTL_CREATE, &wrong_timers[i]);
+		ASSERT_LT(utimer_id, 0);
+		/* Check that id was not updated */
+		ASSERT_EQ(wrong_timers[i].id, UTIMER_DEFAULT_ID);
+	}
+
+	close(timer_dev_fd);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


