Return-Path: <linux-kselftest+bounces-15128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CCF94E2F4
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 22:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF28B20D37
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 20:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D4E166F13;
	Sun, 11 Aug 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUZkGSNY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA78815F40B;
	Sun, 11 Aug 2024 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407828; cv=none; b=IITr3mdtMwblTesXsYukIvyBbJNQ47yBnNpIhdTCn5d4XBmAWAXEBcfOYCBq1QmV9cX8jrCX1fauozPzdfF/ORSqMozQ+jWtaoWghsrQcQadp77uXY56NXslE9YwoxmAfc1rkaJQory2QqOIp2jWWYncC3pomdcVwJPFvNTTHxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407828; c=relaxed/simple;
	bh=JjLluQklqpNwBZCHdf4Cyd/jl15V8S+7lKs23g7Duvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5Siwh3DBXXjxybRed8VV6ckbq2BqWQ3q8GgMjLcZuWPKHVgnxK3xIXSzqzlziKlMoEWqrHukk4a0aNI9r/A22aMa3D7D+/dnkBJFV90mGrwefuMpbElZkWmf/GP2VQwrlFT7zFvI27csTEtaOFrYIBWet2CKhrFF6l6NfnEZwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUZkGSNY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428098e2b3bso4713755e9.3;
        Sun, 11 Aug 2024 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723407825; x=1724012625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVutRztXV96m5hbYm4va8HGYVqLQMpPcXgqWeL4MLhg=;
        b=SUZkGSNY9sof/KpDD9HAONBkN53OXY9kLb84QA9eg0djT+Q9V1BODZnG6YbmZGsvhg
         ITKlAfNfpC//31/LSzcdkd9SbD4Rmj6aG9+JeYbW5GUdar0IWB9EGrdpOSk/XV+rEj8e
         G+2cP28iYDp1+wwaKCi0x6/aXCqIrpjlu8kzqcWPSXLIjPr4xktOj87ROBfpCwrj7AHz
         0PCwXOYoZlwhBiV8prncnE08l96aT19XnX4eLlJSYuUdaxjSDmyO/COMPSnA2kyJUbVz
         Ch1ErCnue1Tp2SA8ODjElJn0NLiN4nMaVVYfIFAHtPLjcomgGgeW04jJPtgxOuyEu6xz
         vEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723407825; x=1724012625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVutRztXV96m5hbYm4va8HGYVqLQMpPcXgqWeL4MLhg=;
        b=FHVmednw7MnDvR5V1H/zvypPtzX2zJ98tCa14yJf143DTu2XYicVhZER6QjaE9J7tl
         jdVSIMtCUw+vJyu5rZsJZnjf2xUJWzw5+JWr94lrXCUUz+X7yliWEpef63CiPw+fPfgo
         9T8qWgfYfKO+1KAhc2WIy5sqkNh+LmOkkXC+Ye97hCTwhciA8xUqE+zQxdBkHyYUi4Qy
         CPI8AR8rPYu+MZlKyjwD5CVaypKePPQIfFxkUhQIFE+yFEQEE5+SZ2nMblKFIGDabHn6
         o7qyrWZd6G51zUbYmyNAxpEgTWhS194J2x2deMrF60dfWcp00h3GZiCL0yrOhJoBKslU
         eDjA==
X-Forwarded-Encrypted: i=1; AJvYcCXs/TbRcdNEvTp65rW2QJn9RAbupokscYH2wMzexpc5uX+ZIKFMdNDfJdLuPcJw7HEAkbdupSMPXsrj3Bt5jVEQImTdAjNEG5K4lSQGIBJjOqizVRU/OOpkdNCDRPsgoocQrQnBas82ORzNSd6o1tjD/AxsG2ZaMyFF1VLXalM7QWDQmUv5Dq8ix7c6I99QyGZ3F/oh0cuj1WUYGcSg8S4zVC4737c=
X-Gm-Message-State: AOJu0YxV47zkWpJ6Ps62+ELkHALawfEbMiQSiUVT2NTeMwJyrUYSF49p
	h9dqonN8+M46NDFuIzGMy4pPwtSAhMBUt+iOR9fr4FEecliYggh3
X-Google-Smtp-Source: AGHT+IHCTq1Zk/MD/Ujfw4d/tAUSwET+t+o+J8FV8aYZe12KaxouyY8RccXe1WSUosVyPZAbfPJrwA==
X-Received: by 2002:a05:6000:1868:b0:366:e4b4:c055 with SMTP id ffacd0b85a97d-36d6035504dmr3461457f8f.7.1723407824663;
        Sun, 11 Aug 2024 13:23:44 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:24a1:28fd:3a06:5636])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd31edsm5553305f8f.98.2024.08.11.13.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:23:44 -0700 (PDT)
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
Subject: [PATCH v4 4/4] selftests: ALSA: Cover userspace-driven timers with test
Date: Sun, 11 Aug 2024 21:23:37 +0100
Message-Id: <20240811202337.48381-5-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811202337.48381-1-ivan.orlov0322@gmail.com>
References: <20240811202337.48381-1-ivan.orlov0322@gmail.com>
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

Also, the timer test includes a test case which tries to create a timer
with invalid resolution (=0), and NULL as a timer info structure.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Return NULL in the pthreaded function (ticking_func)
- Process TIMER_NO_EVENT enum in the timer app output processing loop
V2 -> V3:
- Add new test case to cover invalid period sizes and frame rates for
the userspace-driven timers (to test the sanity checks in
snd_utimer_create)
V3 -> V4:
- Use the new structure declarations to define timer info
- Calculate the timer resolution in userspace from frame rate and
period size
- Remove majority of test-cases for invalid timer test as we don't do
many sanity checks in the kernel anymore
- Move `global-timer` into the TEST_GEN_PROGS_EXTENDED list as it is
not a standalone test but an app called from `utimer-test.c`
- Add test case which tries to pass NULL as a timer info structure for
the timer creation ioctl

 tools/testing/selftests/alsa/Makefile       |   4 +-
 tools/testing/selftests/alsa/global-timer.c |  87 +++++++++++
 tools/testing/selftests/alsa/utimer-test.c  | 164 ++++++++++++++++++++
 3 files changed, 253 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/alsa/global-timer.c
 create mode 100644 tools/testing/selftests/alsa/utimer-test.c

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index c1ce39874e2b..25be68025290 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -12,9 +12,9 @@ LDLIBS+=-lpthread
 
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS := mixer-test pcm-test test-pcmtest-driver
+TEST_GEN_PROGS := mixer-test pcm-test test-pcmtest-driver utimer-test
 
-TEST_GEN_PROGS_EXTENDED := libatest.so
+TEST_GEN_PROGS_EXTENDED := libatest.so global-timer
 
 TEST_FILES := conf.d pcm-test.conf
 
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
index 000000000000..f7a90ead8c5a
--- /dev/null
+++ b/tools/testing/selftests/alsa/utimer-test.c
@@ -0,0 +1,164 @@
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
+	struct snd_timer_uinfo *utimer_info;
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
+	/* Resolution is the time the period of frames takes in nanoseconds */
+	self->utimer_info->resolution = (NANO / FRAME_RATE * PERIOD_SIZE);
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
+TEST(wrong_timers_test) {
+	int timer_dev_fd;
+	int utimer_fd;
+	size_t i;
+	struct snd_timer_uinfo wrong_timer = {
+		.resolution = 0,
+		.id = UTIMER_DEFAULT_ID,
+	};
+
+	timer_dev_fd = open("/dev/snd/timer", O_RDONLY);
+	ASSERT_GE(timer_dev_fd, 0);
+
+	utimer_fd = ioctl(timer_dev_fd, SNDRV_TIMER_IOCTL_CREATE, &wrong_timer);
+	ASSERT_LT(utimer_fd, 0);
+	/* Check that id was not updated */
+	ASSERT_EQ(wrong_timer.id, UTIMER_DEFAULT_ID);
+
+	/* Test the NULL as an argument is processed correctly */
+	utimer_fd = ioctl(timer_dev_fd, SNDRV_TIMER_IOCTL_CREATE, NULL);
+	ASSERT_LT(utimer_fd, 0);
+
+	close(timer_dev_fd);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


