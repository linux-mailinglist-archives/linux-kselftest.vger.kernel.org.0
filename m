Return-Path: <linux-kselftest+bounces-14260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E893CF0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386192834CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31FB17837B;
	Fri, 26 Jul 2024 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmoFDmTx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0EA1779B7;
	Fri, 26 Jul 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980123; cv=none; b=bwub2TCPczmG1dPqDZZLp7uXQZxECxWLwXlLhC2liFfRBgnOBKPGxwyJqbvzbJ1ync66geg/TBK157nI/ZCP+n1ZfgSub9NnCjieUnIhMf+u/XQu8aQR1+0MbhXt/1nH4DazNQ41lmE0DcE47cuzuAq1ZAvUgQYn3JWXkSgmUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980123; c=relaxed/simple;
	bh=sRhC1/eNq0wYE3YDq/roJ/WP2LhS7VpTVS2S6gaTwqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCyznX7xC3MTHYdHBwtd0oNZv2bTjjU32xNciortUua9taNNDA25rFS0knrKmHLdcAosPcdfSd9Pxj61AUtZSb+8/mvB8OEalr5xkOMdJYZNlLD2UgCfJgmawTqUUoWWlnPqZlyJI373WuA+69dkNlIapbbHLrpKsf6Tqb9P9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmoFDmTx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36841f56cf6so219084f8f.3;
        Fri, 26 Jul 2024 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721980120; x=1722584920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la7lcKEwKEGn8Fv+57F+e6rGx+AWHyToQl67Dmq/COk=;
        b=VmoFDmTxhP/Aj8/eLMtQ1f9J774NMIh3u3wVEUcBjzbt+0j0gWR1lrRakx1Q/hzOvT
         a7tZv1W7pT1Cy0FMGKhweoObcQIeA75Ak8486iNZIv/wsaSlKatyBnVqbGlwv5WOaC4W
         52JKXHEliRt6j/Ab6vU393oEMnNwbiHquGYlIHozJjecG6kJYQM+AZDo3o+2A/6Fzg6S
         udsQL48Mbjo0vx+ghE41xzhDoUPtwUchqifQQyCJGOrNM0OmGAxA8dpPnfeSYIiXZaiy
         w/86NeOKbITb/fWJEdUIx9I6bhZUoHU/rXzLYNkZ4o75Y3Kpqaaf5rnbLyFoE73kj1cN
         GqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721980120; x=1722584920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la7lcKEwKEGn8Fv+57F+e6rGx+AWHyToQl67Dmq/COk=;
        b=i0hx2vAsV3gyYXyRGg866VNt0O6Nr87wm/9DBAQlkFQY/SYrnWajAzjoLTlbamPOqG
         tygmCuc4MVVyoTt4abqr+mJuSzCHyx6dZ5YnNBGoZIqyfdttQ3iubLeu352ZvtITsCcc
         zOdsPMmNpVal+akZRX7nP1QD7351iPvVlVwHlQE7Nkr98ioy6pBj86d8Kd6YX4jgaN6z
         RfnalzNAOE+k1D48y7nACaMv4IIbW1NowSpmzoeU/XTFJVPbWOAiTdv2UexRZb/dKerp
         Py/EhoFH3I4qOrOrlrT7r/fbjQRpaNWTR7JzV3k/fnHu9+dv0i9oJeyKXZMHmtE+YiUM
         KE7g==
X-Forwarded-Encrypted: i=1; AJvYcCUEPbeZ5IwpBrj7vO0o7KRD8ku6sdoD8+LpEPjLYCpGY03lRPAcR6WpvKfQH41WszEPcxt/2D3IJiih3iPV@vger.kernel.org, AJvYcCUJ2fvnS03ThN+Hmb1Zh06S6sj7K+QwF5bddiERDe7Eua+rQQL71zZBKFDaq8lt9JjjIzcCzl8qOLfBzu0=@vger.kernel.org, AJvYcCVphH6MjhTqAAQkfFFYzjf3pgTukVOtrBuQyNs/8OktxC0krYXQot0tIGnuAtMnhLIi3XhoZ9c5qyM=@vger.kernel.org, AJvYcCX8JIkODQf0/vuLpwuE1KG+HVK6Xk1Ncm/5xg66dblpdnYHq6RR5v5pT+KYeXZCcnkoxIl0NGQmqoODv5Uk0WIT@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSS2hJeHr4NnYlEA8NnKr9oJ8cpyDZ5hRO7lSZNYxZ1tWyS7G
	eJbeOpLeTRDcutvIQd00hkL6/keCryA4Qi20J35s+jgmjJY1vFNbQKjSRA==
X-Google-Smtp-Source: AGHT+IEBka+hLmP5gdbWHwy6tMpDugy1Xfwgx9rym0bPiDe5tU87sSi1ByzNT5/B2flaz3BJnbaM0A==
X-Received: by 2002:a05:600c:3b21:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-428057706aemr20201495e9.3.1721980119743;
        Fri, 26 Jul 2024 00:48:39 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:68e5:11ce:4d88:9958])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6368sm66045565e9.38.2024.07.26.00.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:48:39 -0700 (PDT)
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
	aholzinger@gmx.de
Subject: [PATCH 4/4] selftests: ALSA: Cover userspace-driven timers with test
Date: Fri, 26 Jul 2024 08:47:49 +0100
Message-Id: <20240726074750.626671-5-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726074750.626671-1-ivan.orlov0322@gmail.com>
References: <20240726074750.626671-1-ivan.orlov0322@gmail.com>
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
 tools/testing/selftests/alsa/Makefile       |   2 +-
 tools/testing/selftests/alsa/global-timer.c |  87 +++++++++++++
 tools/testing/selftests/alsa/utimer-test.c  | 133 ++++++++++++++++++++
 3 files changed, 221 insertions(+), 1 deletion(-)
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
index 000000000000..38de90e507fe
--- /dev/null
+++ b/tools/testing/selftests/alsa/utimer-test.c
@@ -0,0 +1,133 @@
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


