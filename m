Return-Path: <linux-kselftest+bounces-33247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89444ABA994
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 12:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E6F9E411E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 10:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280591F419B;
	Sat, 17 May 2025 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcRKAtMb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C21DE3A7;
	Sat, 17 May 2025 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747479421; cv=none; b=c+2ipc2gLL8YG9KSS0Zha7d79u3HkOQt3IqclkNc9J+oTLjcLupXAOUi84IZB4gRu6la4f5H5L9G1S7mzf+MOkfxWdSbnJONJqR/jJ/kBTrs/XPNuL0TkMDE3gj2c+P7Kh9A1dMdwWjVGmxZLIyusyzeC57wUFVzUWvgfEdHLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747479421; c=relaxed/simple;
	bh=TaOUUvJfOBQRRvg+2oaX4mZwU1C72eN4A3s8vUyQwqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nu/SprX6/fdGWexVoj6IT5dGfth2gbiijxyLEET4YPW3kRJWV54AV4Utx4S7zNcjBikr9T6f6cF4hSlHw/3Rng2vSiZdlm3wftvFONG55WRb49KDO7/xsO9h1rmiz+Qq8g+nHxl2jIFFSqaH/IwTQm12tgbPxydZZ5IZsFHC1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcRKAtMb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7426c44e014so3225492b3a.3;
        Sat, 17 May 2025 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747479419; x=1748084219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qxhz2TL1+lksmnlQygP7TKzX54zvkcpHG0iUspN9avE=;
        b=hcRKAtMbykSENCWcX0cQDv2dFeLmO0eSFHgL2dSxILu4W1aoh8pClsq/LlFFWkSWph
         5RyFrUmkRLHdbQcZhAfi9yFrBNABhxllAX0i/fmXzViLsMKqd2lr3W5QB7VeCa2y06Ro
         EXvKhYsybt1YasEiVON53YjbUHeeyqadNnrlbal5WuGdFI3TY+ZF7WX0Fc9ZfVP0oxNB
         cCCUkw/ZlDMcSGGPSh6tcrT5ZOrEBPmuqFO3qs+kX9Uii9D2Yx0QRjNXCmfn2HpkrFGN
         NDV89aOVj90Ons7RFubIZBfhhZOidWoZhj37JmhDhEllh73RxIkONgdFVKkwpEDbIbRZ
         6log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747479419; x=1748084219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qxhz2TL1+lksmnlQygP7TKzX54zvkcpHG0iUspN9avE=;
        b=TDqbIC808HtokEz3M+3DOApovi1A5n3DEhGHjIm5H1e4V/V4WaNkbfVq6e05UOhkYr
         nVslFfvfrFv059ql7zEX1qKP1/tDVhCMB+OOUVK7KOQ/c32G1PFd+Zige6MzS2158RGg
         p5kdbgZQaY+SobMETXJl1ecNYBFTT+yhF5/wqhKC/NP9O+9dTwT0cUZjJct79jeHs145
         +YCDyTlLNAn89Z15mlVfbc9Qm+yzjgiZu4bne8dc6xImRrX+k5rRNp6uTMzN+HM4DrGw
         RHEOauJFKpMUSxlLUOazBcgX2zzKY6tHH6xzWfOkY4aypsuIco7hR6aC2RL55FOU2msS
         eR/w==
X-Forwarded-Encrypted: i=1; AJvYcCUzmweXrN4mPYfNo3HUoMT1xZGWfFOBc4BEiz/VJd8eXYUp3RjSfkoY+fo2go61/vz6XM9ZVEtepvOjkE+VVEsd@vger.kernel.org, AJvYcCVW5K2d6ClvzWwOwa2Op6MmRkL6x/qjJKfKwe55/xkxQ2FkjNVhYV189ZTHG6JyANsksMGC4uMPGw==@vger.kernel.org, AJvYcCWMiTks0RES00AEmKtOMmX2nOfmWJVSy/VF1sSQc5Wy1YMVN1YU156d5K+AHBnjcYMaz536aT9vhNU13/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNzSG+54geihsA3JDXS3NW3KjmsfAfGQDpNFMxhCXiY4qVM5W+
	s46+zfp2H2m2qWYeruWe6SVRUepPfKAKGN65/BpwDCrz2dDwkjxw0SkTkIOfMQ0h95M=
X-Gm-Gg: ASbGncuZPrGeE7eOVDGMoDpQ/SK2QK1bymMzRsuYbWvRfQtEHB3P2f7FBaZ2btAbRUj
	YEtw5aNH/i1pN1IQLvxMPDrn/Fide1g7rV8x8fF4JHji5bh8hDr3ypLW73XMhgDXQIL/qPglucV
	VXdE6fAeggQgQaNN3NWBzedgPvFZRS4qvdtq14WGzQV0G98cL6DVkBXmmFgVaqWdB00hX0bB0Il
	02A/tsEf70upcBptIGcoKyCY7Eb1th3UGQ822ovnNv4oA/Xfos9xmGBtiyJw9RCVfaHyNvroDID
	RN19gS47dQc8jXYJ1JqfFFE7T6Re4LNfX0IS5U8zZD779ZJ4TRnulRDPjRjRTck=
X-Google-Smtp-Source: AGHT+IEyohYK5wDYwRvsjeOzzJ3z49rlbGmQNUgPMxSJe2CH1kN97HeVrQHblZ2cwgCHYKWzwlPM3Q==
X-Received: by 2002:a05:6a21:7e86:b0:218:bbb:c13d with SMTP id adf61e73a8af0-2180bbbc1b0mr6619521637.13.1747479418722;
        Sat, 17 May 2025 03:56:58 -0700 (PDT)
Received: from fedora.. ([103.102.144.175])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8ead7sm2961955a12.46.2025.05.17.03.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 03:56:58 -0700 (PDT)
From: Nidhish Chauhan <solemnsquire@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org,
	alexandre.belloni@bootlin.com
Cc: Nidhish Chauhan <solemnsquire@gmail.com>,
	nux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] selftests: rtc: fix grammar for more clarity
Date: Sat, 17 May 2025 16:26:48 +0530
Message-ID: <20250517105649.18163-1-solemnsquire@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some grammar mistake and improve clarity of output messages
and comments in rtctest.c. Fix format of message in accordance to
other output messages in rtctest.c.

Signed-off-by: Nidhish Chauhan <solemnsquire@gmail.com>
---
 tools/testing/selftests/rtc/rtctest.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index be175c0e6ae3..42456dd90095 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -138,10 +138,10 @@ TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
 		rtc_read = rtc_time_to_timestamp(&rtc_tm);
 		/* Time should not go backwards */
 		ASSERT_LE(prev_rtc_read, rtc_read);
-		/* Time should not increase more then 1s at a time */
+		/* Time should not increase by more than 1s at a time */
 		ASSERT_GE(prev_rtc_read + 1, rtc_read);
 
-		/* Sleep 11ms to avoid killing / overheating the RTC */
+		/* Sleep for 11ms to avoid overloading or overheating the RTC */
 		nanosleep_with_retries(READ_LOOP_SLEEP_MS * 1000000);
 
 		prev_rtc_read = rtc_read;
@@ -163,7 +163,7 @@ TEST_F_TIMEOUT(rtc, uie_read, NUM_UIE + 2) {
 	rc = ioctl(self->fd, RTC_UIE_ON, 0);
 	if (rc == -1) {
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip update IRQs not supported.");
+		TH_LOG("Skipping test since update IRQs are not supported.");
 		return;
 	}
 
@@ -192,7 +192,7 @@ TEST_F(rtc, uie_select) {
 	rc = ioctl(self->fd, RTC_UIE_ON, 0);
 	if (rc == -1) {
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip update IRQs not supported.");
+		TH_LOG("Skipping test since update IRQs are not supported.");
 		return;
 	}
 
@@ -252,7 +252,7 @@ TEST_F(rtc, alarm_alm_set) {
 		 */
 		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
+		TH_LOG("Skipping test since alarms are not supported.");
 		return;
 	}
 
@@ -324,7 +324,7 @@ TEST_F(rtc, alarm_wkalm_set) {
 		 */
 		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
+		TH_LOG("Skipping test since alarms are not supported.");
 		return;
 	}
 
@@ -384,7 +384,7 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
 		 */
 		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
+		TH_LOG("Skipping test since alarms are not supported.");
 		return;
 	}
 
@@ -454,7 +454,7 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 		 */
 		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
+		TH_LOG("Skipping test since alarms are not supported.");
 		return;
 	}
 
@@ -494,7 +494,7 @@ int main(int argc, char **argv)
 	case 1:
 		break;
 	default:
-		fprintf(stderr, "usage: %s [rtcdev]\n", argv[0]);
+		fprintf(stderr, "Usage: %s [rtcdev]\n", argv[0]);
 		return 1;
 	}
 
-- 
2.49.0


