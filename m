Return-Path: <linux-kselftest+bounces-14368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013D93F07E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 11:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27F41C220A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33851420D0;
	Mon, 29 Jul 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNTSa1vW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96FE13DDAE;
	Mon, 29 Jul 2024 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243580; cv=none; b=PfBth2nKplo+Recf9vTzkFKWNuvWfYx9t0DZ5/hPIz8/l9UZ2Y9bnXQxFbPhJ/qrgOFeFwSeYv8DeTfaEBf8DMX/VFySgPFAK+dziIXFWndXq/ZbOtjRllJxQ48pv1lNPhNiSnBy+C9GHR/e5z/Xwm8iYVvmZRBh5+MGLXWkBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243580; c=relaxed/simple;
	bh=l08lgEMB6AMQ9VKxEFqHNoD4YCli9+3L6tCRgwh0Flc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uV55JYDIXWnQJXhaOVgS0w74HwqtVp56eBkKQzusAWtlM9AVF/KZK0T/jHP+URAuXKQ2nCQmmmxUxmYqqFPgg8AsorrT5SiR+Q/sVRZiVPdSbgR7tlslHYBUSaQZyBodR0xm6GIlUZSZ7h4XLcGVGNAzrWAX4lkk7qvlMxhaW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNTSa1vW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36841f56cf6so301336f8f.3;
        Mon, 29 Jul 2024 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722243577; x=1722848377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpcUC/gtXojJN/CiyqGEY07Ph3Yr5arD3Bg1bEmMUnE=;
        b=CNTSa1vWQIPoo89h2T4H9B+vscA3TT6Axygqn7kC6mRjz2K0MSYiqWlP0yfJsvtuqd
         JHzttZ4rIs4mSXgnCDZhA8UoCmmTC5R7ObpMi+7Z6fLByvICprRO7APpIIkh52V30qRB
         dGbZE4sYrpjyaePqy047ft1xt5bLoYf/4BwPluktx73i73Ir2jWRtUrlJSL3Mq4iAZZA
         LgeXjm+IelgzRwLBbw9vBUKpCU9L4YvlVlAjzgkkDihQvNMC+vXnSHQ+Yz9+Jg7UrP64
         idLad673UdpwPdoDdOtFn7XFGEIywdzbBzaxf447zcgZ/iUyJXdZEG7UQ3Sqwvap4siW
         L37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722243577; x=1722848377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpcUC/gtXojJN/CiyqGEY07Ph3Yr5arD3Bg1bEmMUnE=;
        b=tN+qxUQI89dj261Jdiz9QlbTetop0yIOPYKAN0M8xN0qUco+/+5Qa9wnjE076uuNbW
         XbE2FSr7GbwvDsw+K2zI/4Y/scOh/ncZknWpBzWwdtjJL7HKdhW7v60bvFxyjH/OpL1N
         zpJIDLUGXmG7nHqtaRu26bH/BsCc7UvMAMJkp74h2HYvX3EF8I3VEKRIvqjcXC1mJ9Od
         LNaCM6xonfWU2BZt/85moIXOkEufudnMu0Qxe7tCSvxDW/DLtMn+jSM6haxTKKiMJX6N
         qyRlJS7h7TJTR9Vnu6/S28rEgeKYo7+QsLFu88ouYWy078xgOCQbrkvjO1wmj26ktgMz
         AYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9X7KMa8zLgq9Idw6fZjSTMoXnG7gsT6lLX9uo9nP5gPgQsjuQwc0yLttOXphK857Iep5xKB6apqEt5Io=@vger.kernel.org, AJvYcCUE6qEcnc27rEk+wYVdQT0Q4wyN0zBuFdjpet+pIMm07ZL82Ud6MZaYiDx2rdFwSA+jADigVCKKAbXoDOW6@vger.kernel.org, AJvYcCUGn0tyf/7e66aCCniEnCvQb3LlLjYx2lfjGqjpaAksJ6EpTfXp6zL6GnWZJ5laTGHEo6tkp9mwASM=@vger.kernel.org, AJvYcCWpbqoeE2qtxaRvdbvz3lO7QPI4iD7x0QIXo8ppIpHMCqohNZEKRpvGmJgWQ+h2YjlO7+0i2ClA/YvuvzCHiVQT@vger.kernel.org
X-Gm-Message-State: AOJu0YzTh0jyR9jAgX3Ldgrr1onWZzq/hZtdDXm8IzH+BpVGtlnrT0G8
	NCsRhD9UD6FIKJgniKQBRxJXTeP8HMAuwSU1WfcbGrqksHgb2d1n
X-Google-Smtp-Source: AGHT+IEDukh4bbv/MXsG2iqAEdWo7FbQ4vqcKp+kWjHzDZmIZjhbZ57xNvCJaMTnHMaWDi8F4NHoBg==
X-Received: by 2002:a5d:6d8d:0:b0:364:8215:7142 with SMTP id ffacd0b85a97d-36b34d1840emr5838579f8f.1.1722243577128;
        Mon, 29 Jul 2024 01:59:37 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([31.94.28.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857e46sm11715337f8f.67.2024.07.29.01.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:59:36 -0700 (PDT)
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
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v2 4/4] selftests: ALSA: Cover userspace-driven timers with test
Date: Mon, 29 Jul 2024 09:59:05 +0100
Message-Id: <20240729085905.6602-5-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729085905.6602-1-ivan.orlov0322@gmail.com>
References: <20240729085905.6602-1-ivan.orlov0322@gmail.com>
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
- Return NULL in the pthreaded function (ticking_func)
- Process TIMER_NO_EVENT enum in the timer app output processing loop

 tools/testing/selftests/alsa/Makefile       |   2 +-
 tools/testing/selftests/alsa/global-timer.c |  87 +++++++++++++
 tools/testing/selftests/alsa/utimer-test.c  | 137 ++++++++++++++++++++
 3 files changed, 225 insertions(+), 1 deletion(-)
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
index 000000000000..e4607a51f21b
--- /dev/null
+++ b/tools/testing/selftests/alsa/utimer-test.c
@@ -0,0 +1,137 @@
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
+#include <sys/ioctl.h>
+#include <stdlib.h>
+#include <pthread.h>
+#include <string.h>
+
+#define FRAME_RATE 8000
+#define PERIOD_SIZE 4410
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
+TEST_HARNESS_MAIN
-- 
2.34.1


