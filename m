Return-Path: <linux-kselftest+bounces-33169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40777AB97E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 10:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8C51BA77D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED4E22DA1D;
	Fri, 16 May 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MopWwZ6j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5841D6DBB;
	Fri, 16 May 2025 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384970; cv=none; b=BjpGuG6+Ua7gT/9LjKaE0ElXssELxB+974d1TPhPktAJ3rbxMssMT/1Rbk8X96YpjLe+/v2iZeNPmEcUIT4hd3EsAH5BQP/M2VeHJhqL1BSG/ns6MKS7ueJh8K9u+BV0hFVFM7fwWSyEM8c7CDSHtJrMg0ovEzCXgzYjo+oxe8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384970; c=relaxed/simple;
	bh=by5pBvbbYKfPrWlA0s1flVcWPDVxuZa4g6UpvBzbqs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pzJaJSRGM5UBx0W3UN97O3Ict0vlVFG2AvcTFzFBRQXtFmF0tAE1uNMngFiDy+NFB/0Eaixgi/y1b1jl2KSV0LUn4gUVfhj1TxCiFry4vw1gKh4sAGk25UkUccbx6HDSYP+0hku/Y/ycDM7zvCtWAIvg6rlznwaDbosS/pAO8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MopWwZ6j; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54b1095625dso2146104e87.0;
        Fri, 16 May 2025 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747384967; x=1747989767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ozVXZJSiT9O1HxZpbWEc2vaFp9bt9sbgaI+WguSf/+E=;
        b=MopWwZ6juPcAQLZuzOUfqdrW29Nz/ZL+y6OOonLCZMoLR4PuqdVke+UTtpZ7KQMQV0
         k83GuhemhzT5dPHTXdGUz0vQUFvWVBoW+Cg9X+5gbASxAerYuK/MyDubXCbIyYznyqCd
         uw5XS2RJ3b6T4bvfBC69kQrr0Om52rQy6LDxjUeF2n4SJb4/BCJCQ5jeKermXH2BXhzg
         FigcuPYbYJkeFYSr7Dui3SsPsrgU+aI6zM7Hpz8fhUPuYvBJNJYQC5dYhoReOPzZgA/p
         qXBaT1IhZxd96GG4ihBm1ziJ/f3bBlAVtV301w2XKRiKN+b4LQgkTynYSD+PjnxdEJtU
         35Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747384967; x=1747989767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozVXZJSiT9O1HxZpbWEc2vaFp9bt9sbgaI+WguSf/+E=;
        b=ukamgxD6sHJtIYQ21CRgbzuOhTaVTTPoj7XihpSKFV/Z1iV1PS1rXiGXma5t+Nujho
         6SR/eTmzxApUO8hnHfxKVK1UXhbvkEG3Oq3NsNOXp0QIq00DeO1ioPHEaqYVnPY+RBFX
         jl0IxT7S+uPQNhcrIgtzEZq7IRlAHz+kyjSmI1kNXmjhjz1n+g69G6+PZ5IFpSB1S66t
         hK2eg0BBQfCJ5u1crh7MV/LasSKUIQV+VtvJ0yniLovGSbYEcSGk9XIacySEc406kUw4
         ilgxpYiSQ243LJdPvC8ItdxAsJBteS5RkrK6UduWrrk4sn88ogwGyRX/4zSl53i9UNIb
         MP6g==
X-Forwarded-Encrypted: i=1; AJvYcCUKATYGcZPRm7cUSHr3/WvMJzYGAQZSwj2oRzjXoc4RIB1kNvSfB5MnLWmsnkvWTdWn/ts2AhjLrKX8t8g=@vger.kernel.org, AJvYcCVtRPWtUU3hfvM6Yq0AixN4Z4GenMD00OR9DYmuiRzCUBj74qNp4WpEgK1AdJJkxiI4zig1Ye4TTbJK@vger.kernel.org
X-Gm-Message-State: AOJu0YxXg3tf/qmAXXyS3rVUA3+j+KTxDswqC7c+H1t3K6wMkIxjB1UF
	kucEZbTaIC5lZv0/MMz1YIO/cDfvf8tc3JIbQ1YuUjxh8ctDvgPH2zta
X-Gm-Gg: ASbGncveEveV8n5a97JevANj4zkObDYFumGIQ4OskuukQQyhUCVIQ2ff1YXYe3V+KV+
	mTZsJUBCM+G2+U6i38RAxuv4QM+igMR0R0JUMIHtv6Ht72bdYLvw20J3pGaEcRz+iy+mri2fSGe
	fqMbDAXE6a9OExLdvOEKgAo/SwWZohBgk/Wjb9szPM5mMhPMEw6Q3qRpTrkzs/i4AL7YZSXbTWc
	V8QX+sQASOBVNIr5JutscomRUhG0HFYW6veSlaXEkVhpJhUOPpLhoWrayG8EgGZAqsDZA9nzGaF
	X8rYOfK5Mgyalu/0g0LYqOnx3r1R4nMzeXt1Xuj7B91cfjxK53uiX0RGp8kxh2d34Eiekrgkhc1
	FggRFFxoZWoV/NLRN2C9vg+C5PzqUuL58K5tHlkUM0uYT0vza
X-Google-Smtp-Source: AGHT+IFGS+/vRu8QmHS2IfGwI+6i4JVpaDHRHX9D9FFRAFxbB9uqhODsx+sDPiCkOfiV2KRSQftTCg==
X-Received: by 2002:a05:6512:6604:b0:54f:bf70:7b60 with SMTP id 2adb3069b0e04-550e722f6d5mr584788e87.35.1747384966897;
        Fri, 16 May 2025 01:42:46 -0700 (PDT)
Received: from uuba.fritz.box (2001-14ba-53-1500-af87-7c77-739c-7417.rev.dnainternet.fi. [2001:14ba:53:1500:af87:7c77:739c:7417])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703f6d5sm326931e87.243.2025.05.16.01.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 01:42:46 -0700 (PDT)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: skhan@linuxfoundation.org,
	shuah@kernel.org,
	alexandre.belloni@bootlin.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH v2] selftests: Improve test output grammar, code style
Date: Fri, 16 May 2025 11:42:33 +0300
Message-Id: <20250516084233.66594-1-hannelotta@gmail.com>
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

Notes:
    v1 -> v2: Improved wording in RTC tests based on feedback from
    Alexandre Belloni <alexandre.belloni@bootlin.com>

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
index be175c0e6ae3..930bf0ce4fa6 100644
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
+		SKIP(return, "Skipping test since alarm has only minute granularity.");
 
 	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
 	ASSERT_NE(-1, rc);
@@ -306,7 +306,7 @@ TEST_F(rtc, alarm_wkalm_set) {
 	if (alarm_state == RTC_ALARM_DISABLED)
 		SKIP(return, "Skipping test since alarms are not supported.");
 	if (alarm_state == RTC_ALARM_RES_MINUTE)
-		SKIP(return, "Skipping test since alarms has only minute granularity.");
+		SKIP(return, "Skipping test since alarm has only minute granularity.");
 
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


