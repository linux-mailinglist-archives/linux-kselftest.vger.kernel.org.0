Return-Path: <linux-kselftest+bounces-29982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E23FA77B00
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 14:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03A83A8C5D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93177202F90;
	Tue,  1 Apr 2025 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1WHpXJe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9C20126C;
	Tue,  1 Apr 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510580; cv=none; b=JNjQ9hENYqvKy04sZejwzsgE1erXWHF6a5g7sGT7TOhaJYRfHvBq9cES3lOWrmuMoy2SMQtUIfOsnviyyZ+DNfMS6DpqPqGwsB4h34qswwNh01955k5uT/7kw0unMRrVLt8ZmSfQIH+1Y/8cIaqfaeWnIXAZPLAcPbOH5Hnne74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510580; c=relaxed/simple;
	bh=c19//HNrqEQBqZ67n+APOuFQ7dukVDXVxLfv/BFk4EU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnWCOwySlYVK+NZx65v5kVlMMI96eOwPZObZVr+SIRHTEc3hiaPqbrCg7OGdIw1dWFQdjgkgr2F+tgzFIHnqG+xty9kvQEwWpPU1UwRVBrRh2E5LhXqSdJSx5n0wwMZ8iO/d5lyB8qbBCgT0MGDDze9nlbuIhJ3V/RscdvEteKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1WHpXJe; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5a88b34a6so529775885a.3;
        Tue, 01 Apr 2025 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743510578; x=1744115378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OWng5/2s6GWs8zHreVaEDSeKr8dlawpVVjY3ffnQIK0=;
        b=F1WHpXJeKGZU8gVdrX7VenIraLa3c/4HaUZ40bnWHWnLWken5sVvLcQw8ETuV507Sn
         HWNns6FgRHGTbGK4BUyNd9cg+VILGb6j3D+Fn0g+MFzOU/t7qMfIJ/efBRIAM9JoMRbn
         mP31jK7U1sm4exRJY7rZ7eVp8PwlECAPyE+eKGDaE6ndGgGG+r0IQG6EyVS9RUNxpXDH
         cnDOOUs6bqYjz03F6lgrxiBCeSnr57kMZhsd2gnX9F3Ep3jL5w7qTN35kpnSOazdNN3g
         Tet3ME1IeSMBinkQn8mBZMEPuRdSSF5rmsfO/D7FKPYDmjtAqoiYuHoV2kVJ7j4MBhrB
         LkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743510578; x=1744115378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWng5/2s6GWs8zHreVaEDSeKr8dlawpVVjY3ffnQIK0=;
        b=al2F1s1BBC4u8H9sMJItz1KA8JLsedpc0h3hZgArySGhaapreUO1fo8oqK4UlooC9C
         1wQ1eDtIVFx0KVoCREU+OQ8zt6iKu+cnuIb/mtLWNtQIvfuWM9iE4Cx+yZEiUPJD8KHs
         3beGjLV40Tk+NtmeDixGdI9i2yMJXzvUd/ysn/iA5TXWjIjukEuQ6fT8/65XvP4dc/mD
         nFis2a9sV3Ctdr1uwOvUqrTcpTat/9vcdN+mOh3w2klu2RVPOnFy2N1FK7VCtNAxynNT
         pzWTEXSYYCGU3pU3ulS4BhBWqDWZastAVP30fkEAGIm5i8WY2ab6Z0UlDPOnxuHaLH/1
         +cug==
X-Forwarded-Encrypted: i=1; AJvYcCUvqLXe3M+JH7KwsR7tLJq4SG9A9k+kQ1hgyTm0jO6FRwcVJ5GDrKyZwPlskbEPyt/6ooWQCTRzoic5vXh+lCw3@vger.kernel.org, AJvYcCWscFSewkUPYZhnsGP1KxxLKGBHZYXHzC91lEkPNgI95990MVN4Z2k9t7RgkAZZdnrKnCChwcH6iLsljqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzA9A07ibNRTxIhD7g96K+1E41WwOP5i9VFJmFblzRuDi+3Mo
	oaSfqZkcSkdKvimiVnfurDL4wYMIGWZVbXUGIcieTFk8FaUO72OP
X-Gm-Gg: ASbGnct8drkiS51g10Icc4FIfY2uWKT08JbVNq7NdJaU8VQlF9p2+LPs5eLr2mp4Z25
	U66c/BO9qp/km+vQxLFTR2jn2nObWBM3Pq5jujfkoUdvVRH4XfHABIxP5CHFC/PDiwB5P7NwSAQ
	yLBopOFa6F0IEhTdI/gjmRqu1uihWHDBnLco9drKPvJK+nnwVIfVW6zVblgepLTIUEhrYHmNYVX
	bQ3w3PmO3yyCop6iNjx0t5YtRDrsQ/JM2YyovmxiKfoIFGfxxINVJWg4wGZplbHrznSIWddS4ms
	j0JDKqMifjIvfDB1YBOYiCLHQN5xsZ4qGbp7jqTKYoAVdjLoBb/Iuf/l
X-Google-Smtp-Source: AGHT+IHO67d4bD9vKGuF4OOCneEyWlZIzB22Vg0XjvWyrehUow9WWekmGrZtRTC/IR+uMs+D7SKBeg==
X-Received: by 2002:a05:620a:2405:b0:7c5:65ab:4ff2 with SMTP id af79cd13be357-7c69087cef7mr1548316185a.46.1743510577694;
        Tue, 01 Apr 2025 05:29:37 -0700 (PDT)
Received: from ownia.localdomain ([156.226.172.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7764c7fsm648646385a.84.2025.04.01.05.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 05:29:37 -0700 (PDT)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weizhao Ouyang <o451686892@gmail.com>
Subject: [PATCH] selftest: rtc: skip alarm test if RTC is minute resolution
Date: Tue,  1 Apr 2025 20:29:23 +0800
Message-ID: <20250401122923.10848-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip second resolution alarm test if RTC is minute resolution.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 tools/testing/selftests/rtc/rtctest.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index e103097d0b5b..b8d196f1c5f6 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -28,6 +28,7 @@ static char *rtc_file = "/dev/rtc0";
 enum rtc_alarm_state {
 	RTC_ALARM_UNKNOWN,
 	RTC_ALARM_ENABLED,
+	RTC_ALARM_MINUTE,
 	RTC_ALARM_DISABLED,
 };
 
@@ -100,6 +101,9 @@ static enum rtc_alarm_state get_rtc_alarm_state(int fd)
 	if (rc < 0)
 		return RTC_ALARM_UNKNOWN;
 
+	if (param.uvalue & _BITUL(RTC_FEATURE_ALARM_RES_MINUTE))
+		return RTC_ALARM_MINUTE;
+
 	if ((param.uvalue & _BITUL(RTC_FEATURE_ALARM)) == 0)
 		return RTC_ALARM_DISABLED;
 
@@ -230,6 +234,8 @@ TEST_F(rtc, alarm_alm_set) {
 	alarm_state = get_rtc_alarm_state(self->fd);
 	if (alarm_state == RTC_ALARM_DISABLED)
 		SKIP(return, "Skipping test since alarms are not supported.");
+	if (alarm_state == RTC_ALARM_MINUTE)
+		SKIP(return, "Skipping test since alarms have minute resolution.");
 
 	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
 	ASSERT_NE(-1, rc);
@@ -298,6 +304,8 @@ TEST_F(rtc, alarm_wkalm_set) {
 	alarm_state = get_rtc_alarm_state(self->fd);
 	if (alarm_state == RTC_ALARM_DISABLED)
 		SKIP(return, "Skipping test since alarms are not supported.");
+	if (alarm_state == RTC_ALARM_MINUTE)
+		SKIP(return, "Skipping test since alarms have minute resolution.");
 
 	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
 	ASSERT_NE(-1, rc);
-- 
2.45.2


