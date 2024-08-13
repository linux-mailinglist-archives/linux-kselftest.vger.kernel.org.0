Return-Path: <linux-kselftest+bounces-15215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE397950481
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 14:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E91F285C23
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C986519AD89;
	Tue, 13 Aug 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJIND7GZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8777199EAC;
	Tue, 13 Aug 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550965; cv=none; b=kamvog38eScKAUQJRutpk2PiWYTjMb/JkuJ3Mh9Ym2YmvMxpzi4ro4opi86jm1iKROa+qAiIUGYsB+xY7s9Z1FyWHUo7gnYPAoJGNk0YkqHFL46h8ZiBw4gRl4ppxBu/3y6yHMPlPU4hxaphTx0fqJeukJ4V4ES7IzbKNqERMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550965; c=relaxed/simple;
	bh=d431flfCwo5JfiJIOuZNQ+jUtORnGIbQuMDW0ScCtm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBWVPoeAepw7SXLgUCKU9QXeAAJrS9NbhiUtf8tfnAHq8By2gsIfs/MirY4OmRyBfDQaTGJ0+bxNzA3uw6btVp1b1/zsmuKK2ZdpNudujty/Q7KV880eIetiEXTwg4KVP3FT/nNwkR5V6XWO3syCO/V01NxVbjvSFEH38rH62TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJIND7GZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36830a54b34so177634f8f.0;
        Tue, 13 Aug 2024 05:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550962; x=1724155762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh5/S5HpIcMewQ8ZsaGFHflrB5SYUJo8r1Ryc6FFp3I=;
        b=CJIND7GZYAHSakYAIxuK7TxxT7jJGMqWUToBCH+57Zo/KatpxRTsyy6Z00FRo9r/tY
         QFpiLNTk5h+dkuKKRPLmX1tFW4Dhb0QYjgkpp+Af+O2E1C1+2uPKWP+ABaBzX9IRXpgv
         LblFADwMmwyf/8gLxbYnRGTGsf5jZdPjNT//qGMMQo+AC35WXXQgEhtVJI1zOqQOM/mo
         7a/caOrveH8uI4lfatjZcBkW81IHn/qX515x2JiwTfnBjGFl2BmwHXr8/aGnq87+ICV0
         eDhrn9+ULB6xTuD5FnuNx87lR4ZKWMmdnKAkObJZ+twDjgv0kHznLBWVeIZZ0ivcDzBo
         Nmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550962; x=1724155762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nh5/S5HpIcMewQ8ZsaGFHflrB5SYUJo8r1Ryc6FFp3I=;
        b=K492cdmmAdpQBv+D1HxkyBBgx+ohoCqzf0WmMI1pUsYgEZTDd71lM4DroJesJDSdSI
         eUzAz/pDoXCNVYRHm25Mz2EJIIlxxvhnpxY4JeQNwui6Ba/sN5Mhsn5WZvLbhM7l7jlV
         GeH2hFVvSOEV4zYXzqrCLhFmCRENfeHcb6yiNjPpuQD7N34sVE/uPu4cZsjo54dmaURc
         Ei9omhskJY263DacKVhQHakULCFAbTvPi+MBgQ7pTkPSJJhgNK2NQe76dZKJIrFmnvQP
         IxKIpROI09vljL7f1f/ld64iJ30HOcsG3mBciWNTY+tdOS01g3LPCdsWW785ZW6Mfi+8
         AUYA==
X-Forwarded-Encrypted: i=1; AJvYcCWPxxSVhLTTeMPg8PMp4Ke947wRG2pbIJbxoihELtFckwv5yLANPZyrUzNiiZaj23SViXWlzfoPhp2TOtJgjqiR+2ooV2XdRg8S+b0dkXTvJzr+t93WD0lPfD3JUmP9+quDGuOepJ6V1FLIuHhHqnqaIT53T34QPsHjvT5zoccq0kivdpV21akLE0CsIDmBagxT1DGtTYl6/RzqetnpmSnTLxOw+cY=
X-Gm-Message-State: AOJu0Yyl33A5dFKnSEaxMMmIKH9edDzQA34Z6LoITE3oXMavOaIQfTF7
	y0sTxaXJlnJPlUNSdEeAZ/M7CIRD+qkBMg7v8dVjnXXbBHYUozZB
X-Google-Smtp-Source: AGHT+IGlWKm0lXBfHU2WHl9N6+ZqcxebPNvJLurPjr4HSVJZ4cXLC7Fdm3rSVjtrwhZKuMsqYdzFbw==
X-Received: by 2002:a05:6000:1561:b0:365:da7f:6c13 with SMTP id ffacd0b85a97d-3716fbe0c4fmr868229f8f.2.1723550962074;
        Tue, 13 Aug 2024 05:09:22 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:6db6:f2bf:8865:5d31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb52sm10204590f8f.74.2024.08.13.05.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:09:21 -0700 (PDT)
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
Subject: [PATCH v5 4/4] selftests: ALSA: Cover userspace-driven timers with test
Date: Tue, 13 Aug 2024 13:07:01 +0100
Message-Id: <20240813120701.171743-5-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813120701.171743-1-ivan.orlov0322@gmail.com>
References: <20240813120701.171743-1-ivan.orlov0322@gmail.com>
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
V4 -> V5:
- Update the test to use snd_timer_uinfo `fd` field when getting the
timer file descriptor

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
index 000000000000..32ee3ce57721
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
+#define UTIMER_DEFAULT_FD -1
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
+	ASSERT_EQ(ioctl(timer_dev_fd, SNDRV_TIMER_IOCTL_CREATE, self->utimer_info), 0);
+	ASSERT_GE(self->utimer_info->fd, 0);
+
+	close(timer_dev_fd);
+}
+
+FIXTURE_TEARDOWN(timer_f) {
+	close(self->utimer_info->fd);
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
+				       &self->utimer_info->fd);
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
+		.fd = UTIMER_DEFAULT_FD,
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
+	ASSERT_LT(ioctl(timer_dev_fd, SNDRV_TIMER_IOCTL_CREATE, NULL), 0);
+
+	close(timer_dev_fd);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


