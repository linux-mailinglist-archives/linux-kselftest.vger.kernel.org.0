Return-Path: <linux-kselftest+bounces-33086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDD1AB8C3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC831B67337
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6D021C182;
	Thu, 15 May 2025 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDItQ5RO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98C6136;
	Thu, 15 May 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326186; cv=none; b=NadK7Re6AeLpGqAzcbKb/bJRjWlKQRdRwPjA6hI5M8puibkznwlQmz11Hgrouv5XXpJl4B6g/U/IDcU3lRStl9IdvF2CmNn5OPrKls9Hlu3DkQzc1XN4TLMdNXyhGTm+jNSdt52ikhPct2muj0Vtyfq2AeGUtlF1NAe8ncd1ogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326186; c=relaxed/simple;
	bh=4PeltixS0ZjxoFdAg+eqlIc8IJMNXf6PIDLy8FRgSj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QEmBuny6kt5R6sJuQwXhdOsp1zAqJin9dyiKbscfGcgVIq7wtFXxlQP9FZaDfo4ltiEvUvhNVFZvOSu+7SU2ggqj0RDfXg66iTTLkbts0IOnT4NYznmEspjES098zWi56wk8J5m9BMPor2aDW8pTTodB3KgNrtvweaffI6BxafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDItQ5RO; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54fcb7e3474so1118354e87.2;
        Thu, 15 May 2025 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747326182; x=1747930982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCFjabn3SLWW2FICgQ4T2s8QKlbYsJc5jtTAjYixcjQ=;
        b=KDItQ5RO1oESTvgDaJV1riR8IyJcWbW2aK38H6WCDJfhg8mgN0uC8CwqIKsMm7mwoa
         /vr2B4/7DIHe7IglOiwvacJf0D1p3SbWhkg2plo/S6HxRY7f2N99/vwTCHmiSyCuvGiz
         jv2Mbj1YKG5yndmnA+bnfjumCHNti0pgD+97Z5B6OBt9zasvw4LJNfxgPL7pkEkzJ+HO
         D9GswCv5ri5+sz8s7S/YiQo0epVjnJCmosRcxh3g/hVsKsIc5qNO9lvpTzG7mjg6EGeN
         +xoqUHUcKSW6bj+kxeUHmOZGOwO0+BwEF0GvRNfRrP5RoeK8gEm8p4P03VZmeZb/QH47
         vPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747326182; x=1747930982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCFjabn3SLWW2FICgQ4T2s8QKlbYsJc5jtTAjYixcjQ=;
        b=Z4proIC0e1zY7sR+0Ep6sAjSwK22/vvAWzPUQoaRt7NBbkbAxn1SJFBkRe5JlJiOFc
         UsmteXKHc+m1PekjOueBjxTQl3AZFI/4Pj0A0nd20W0w9VlJGuKM/UbuUuK2dCLDJYnQ
         kEo3KYIh594lPgmjr1I+q+ZGPZv8wN+50xs0K9Rl+PhvU7Pp7rU9Tyl9SGhMBbtjjQDB
         F8wM3AORLao85u4MR2AR3EK+zy/ndM3M6dA7phB7jqLup5nutndi69L+rICAnnuOXTEH
         M0ZbLH4p4O2tHiupgLY6d3TsKOH2bvAV+yS5Mrp9AtMYa9+xIUrFq1hiWzzkEBeRsdxK
         08aw==
X-Forwarded-Encrypted: i=1; AJvYcCUj8Uie0m5hKvdPjVFHJmyLtagcuNBuKG7oUpW7Vnr1IY0XpMvFuAhCLvswDPM5RPrlfUKp6buITE+Yn78=@vger.kernel.org, AJvYcCV5WAeQtCfPJVFPjG2W56ocqNPt9HVwG9nnt21dJdWOArnlGD1onjcm/hyCjKe8MBtvFkup83Gp5iZ5@vger.kernel.org, AJvYcCWR+47PlTc9mBtlW8ChudoIqoqznk4kzixjqn8Q8fQLHxpkxokM8RAOFwv6l+lzI0LxoSY/hzlT11t0rgOAtpX7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Ku0v+Oa0qC4ruzl1QEa5qlPt5+2vhgRPwWWBYTLoJ08qWlZy
	K26jL/3UQJCqAhU6mtHwzT0EN1tB1uemLW7gdb9zIVF+O6cepUJjrIF9xr6ekrANr04=
X-Gm-Gg: ASbGncsyziXdkpVwN07YzSGxHUR74dS7LU+/7PUqtlpmGVrIBYIyILYJeHS0ETo0KHH
	U8AUe50G9AuC4jIIXzk+yBF6dllmjN7IwQsuBbZa8oJKUg2zcU31NP3pg8BCQQTG+cZn/XuQrMr
	4V+yZ9vE4THw9+WvAypoKoyv9B71RKRhw2t0J0a3aXlAF9CqRrL1jOj1cjjmactxNC3ZqjT1/64
	bWlTYZUsepunrdN/vgDHoP1yda10C1pinZUMxzZ2jWr8NaUnKwiJwGfffWNC3zmAun53EjvNRtx
	17fQRWUgvUWHrar2yLlw7fJwK0CaupIqwRb4+lT9B+WcVK8Hbqs4TdbynMX+D6dIu6RDDwl41ja
	4cV4SxxDUiNqx60OGEYOjN93ewyw7iVat/c9hlMZdIxAROmRuALYW+Hzj
X-Google-Smtp-Source: AGHT+IHCegKWeqNw4OuOgqVeFqsnY+bgb7Wi7Ds+b9y3wDfqkRtj7JkJIMAmz/s2Ds/9mDj0Q2A0EQ==
X-Received: by 2002:a05:6512:2614:b0:54f:c526:cb4f with SMTP id 2adb3069b0e04-550e7193e9dmr10237e87.1.1747326182178;
        Thu, 15 May 2025 09:23:02 -0700 (PDT)
Received: from uuba.fritz.box (2001-14ba-53-1500-40a0-caf2-378-9836.rev.dnainternet.fi. [2001:14ba:53:1500:40a0:caf2:378:9836])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f16236sm16554e87.42.2025.05.15.09.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 09:23:01 -0700 (PDT)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: skhan@linuxfoundation.org,
	shuah@kernel.org,
	alexandre.belloni@bootlin.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH] selftests: Improve test output grammar, code style
Date: Thu, 15 May 2025 19:22:49 +0300
Message-Id: <20250515162249.29510-1-hannelotta@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add small grammar fixes in perf events and Real Time Clock tests'
output messages.

Include braces around a single if statement, when there are multiple
statements in the else branch, to align with the kernel coding style.

Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 tools/testing/selftests/perf_events/watermark_signal.c |  7 ++++---
 tools/testing/selftests/rtc/rtctest.c                  | 10 +++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
index 49dc1e831174..6176afd4950b 100644
--- a/tools/testing/selftests/perf_events/watermark_signal.c
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -65,8 +65,9 @@ TEST(watermark_signal)
 
 	child = fork();
 	EXPECT_GE(child, 0);
-	if (child == 0)
+	if (child == 0) {
 		do_child();
+	}
 	else if (child < 0) {
 		perror("fork()");
 		goto cleanup;
@@ -75,7 +76,7 @@ TEST(watermark_signal)
 	if (waitpid(child, &child_status, WSTOPPED) != child ||
 	    !(WIFSTOPPED(child_status) && WSTOPSIG(child_status) == SIGSTOP)) {
 		fprintf(stderr,
-			"failed to sycnhronize with child errno=%d status=%x\n",
+			"failed to synchronize with child errno=%d status=%x\n",
 			errno,
 			child_status);
 		goto cleanup;
@@ -84,7 +85,7 @@ TEST(watermark_signal)
 	fd = syscall(__NR_perf_event_open, &attr, child, -1, -1,
 		     PERF_FLAG_FD_CLOEXEC);
 	if (fd < 0) {
-		fprintf(stderr, "failed opening event %llx\n", attr.config);
+		fprintf(stderr, "failed to setup performance monitoring %llx\n", attr.config);
 		goto cleanup;
 	}
 
diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index be175c0e6ae3..8fd4d5d3b527 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -138,10 +138,10 @@ TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
 		rtc_read = rtc_time_to_timestamp(&rtc_tm);
 		/* Time should not go backwards */
 		ASSERT_LE(prev_rtc_read, rtc_read);
-		/* Time should not increase more then 1s at a time */
+		/* Time should not increase more than 1s per read */
 		ASSERT_GE(prev_rtc_read + 1, rtc_read);
 
-		/* Sleep 11ms to avoid killing / overheating the RTC */
+		/* Sleep 11ms to avoid overheating the RTC */
 		nanosleep_with_retries(READ_LOOP_SLEEP_MS * 1000000);
 
 		prev_rtc_read = rtc_read;
@@ -236,7 +236,7 @@ TEST_F(rtc, alarm_alm_set) {
 	if (alarm_state == RTC_ALARM_DISABLED)
 		SKIP(return, "Skipping test since alarms are not supported.");
 	if (alarm_state == RTC_ALARM_RES_MINUTE)
-		SKIP(return, "Skipping test since alarms has only minute granularity.");
+		SKIP(return, "Skipping test since alarms have only minute granularity.");
 
 	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
 	ASSERT_NE(-1, rc);
@@ -306,7 +306,7 @@ TEST_F(rtc, alarm_wkalm_set) {
 	if (alarm_state == RTC_ALARM_DISABLED)
 		SKIP(return, "Skipping test since alarms are not supported.");
 	if (alarm_state == RTC_ALARM_RES_MINUTE)
-		SKIP(return, "Skipping test since alarms has only minute granularity.");
+		SKIP(return, "Skipping test since alarms have only minute granularity.");
 
 	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
 	ASSERT_NE(-1, rc);
@@ -502,7 +502,7 @@ int main(int argc, char **argv)
 	if (access(rtc_file, R_OK) == 0)
 		ret = test_harness_run(argc, argv);
 	else
-		ksft_exit_skip("[SKIP]: Cannot access rtc file %s - Exiting\n",
+		ksft_exit_skip("Cannot access RTC file %s - exiting\n",
 						rtc_file);
 
 	return ret;
-- 
2.39.5


