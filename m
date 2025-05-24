Return-Path: <linux-kselftest+bounces-33738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B57AC30F4
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 20:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD873BC359
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30DE17A31C;
	Sat, 24 May 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIjWhbkv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DABAA944;
	Sat, 24 May 2025 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748111429; cv=none; b=BcTCR73bXp+68++dQZSTrMq7o2ELMDNj26qSFN+SMcmt9fQPk+GjVt419y7YSEqVqAzU8TIkK78uXSlPum369Y3SIRxNPPuQMs4Pd378x36e3T2vyYLIbeUGsTZ9r9xXfz+zBuTNvm8rOl2k3gFMVlUGmgTG2B5Hwc/SrY1HNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748111429; c=relaxed/simple;
	bh=KgFZHLlHE4tCjAIGU+SAPi0i4peCJodc8aQfjJHtHKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxZ/cX7uHVy6kn/0PzxmQmLOlM0f9pCg3DrpT+MpEQQYEOSjaEPnmOm2iNMLYfn9xdPIMn99KOtkxIcHudU6TD3kJ0pWZeqMrnHH9QrC5hhnJVLEWR1yrJx9qaBJ1SxOiPTNKz7zarkdTJUi9SOaevbE2Jj+UqfqfQ9SR8dj2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIjWhbkv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3110807523aso977506a91.1;
        Sat, 24 May 2025 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748111427; x=1748716227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ptEioHnAVvAUKnJdPwxhFZ3L9C1/tUVJ0BZdDlJ+Lhc=;
        b=SIjWhbkvkGnjB5LsYGFYwNf3C3KhLaqjg8/VBtO16Pidhmc4cSstgVMJjCw5Qcp1Gk
         ykptNRl06wXkzyWFt5Ir9fgw7fKkKfkukExkDDt72SCp29myadJb/UMOA5/THzCXeVnf
         AlCUpWVYCoF6kEmoQGhMqqJ7Txm312dVM7qKROm81Wgcpw2cPjX+mRLpz0dj9B4b/XFK
         yrovUppOpPhI8ySpbI0pl25TR/omIIX6JCsfLP9Np0moTKIA0bTbotQW7neLGGKe39pm
         lJy5eWdsZaYDH0HvMOB+XUQLM42m1X/4kjzbgiC47M00xSHHmwXkUBPHc6B+7W5HWaBs
         mnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748111427; x=1748716227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptEioHnAVvAUKnJdPwxhFZ3L9C1/tUVJ0BZdDlJ+Lhc=;
        b=ItgQIXjURZhXC7I679ZGC0ps1SvXPJjBOWkcI+/lpckVXQgmFoeLn0f6b2bNfAtYwE
         XcqjFV6swt3WgtOACCuQMoj6FObnpXNp8s3/WRmRyk4S28DzIOyBOTYHFGjKjH7xllzL
         Zcxh3R/aWr6dfaDL91tnt/6laEkPj2Yeyg0G27LIWSRokyRgeJzOI2d084tOo0W/LAK6
         dAX05aMVFTe2OUhsdYxc/P6ejORDxQcM3yvWnjBpNGtTG9NSju5lN/2b7wEJs/Mc2wjA
         JtGfyPlz6yjdAKvwCemD9A9rGmVRQEQ/wVOUsL5S/K325c17kVm5DEH0uGMHfcdHIxfX
         MNuw==
X-Forwarded-Encrypted: i=1; AJvYcCVQJg29lwMYsxbGZY5bhEqRRSKMx5odYL7ys8pHf2+s0QC0sssSVfxRKO8PklBaNhBeUVJDoRxYXSF3eeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ZP0QxLbxK3hINDpf7/mV7Tx7giGTXq0C7CH4srruTZUe+OUu
	ponWl/xQFprjOCetDMYDTMtuZQUkcdpMr1AT+shOu0CBEKKXOYx6oEhN
X-Gm-Gg: ASbGnctTf0vJy+SDmH/oadVdmH5PTYn/dPceeyQDMrbzGMvkUMjYWAZOVqpaFJy4P5W
	atDXV8elO2tv7wxMLnoNNkFNxBLM+loimp6BedNV7sO2BCoCmLt694wRI9QbsKC3emuEdtcwJKW
	8IZd/tn5efUmodQs1Opv5sJG5H9aJRX9dX8SgY2zqThDtMn28/6IRDrt2AwOxU4AqGxJk1IzCb2
	wzCHgx3ypY27Dgfrj6o0RFQoxEDaZe/0DE4ANQZ20vsTnYwYb/XuF3j3Y3Md/Umw7tF133t4fvj
	zzdEUnCx/GAVcXy/O2VjXSJW5qDOYAsI+ls679fJGVCUyUquTrbqRZWof2g=
X-Google-Smtp-Source: AGHT+IGx6+y5gdEayhWm7XgSWcATvJ7PdHAHgs6/RwuttZouUKYsIylhN3cCspsS7VQA6R5VHhQtEA==
X-Received: by 2002:a17:90b:4c0e:b0:310:cf8f:48df with SMTP id 98e67ed59e1d1-311106b2bcfmr5706128a91.10.1748111427278;
        Sat, 24 May 2025 11:30:27 -0700 (PDT)
Received: from Thushi.. ([171.76.80.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f3651611bsm10157682a91.49.2025.05.24.11.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 11:30:26 -0700 (PDT)
From: "Thushara.M.S" <thusharms@gmail.com>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	"Thushara.M.S" <thusharms@gmail.com>
Subject: [PATCH] selftests: timers: rtcpie: Fix checkpatch reported errors
Date: Sat, 24 May 2025 18:30:11 +0000
Message-ID: <20250524183011.114490-1-thusharms@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Errors reported:
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '<=' (ctx:VxV)
ERROR: spaces required around that '*=' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: space required after that ',' (ctx:VxV)

total: 6 errors, 0 warnings, 141 lines checked

Signed-off-by: Thushara.M.S <thusharms@gmail.com>
---
 tools/testing/selftests/timers/rtcpie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
index 7c07edd0d450..aa5a20fd8df2 100644
--- a/tools/testing/selftests/timers/rtcpie.c
+++ b/tools/testing/selftests/timers/rtcpie.c
@@ -75,7 +75,7 @@ int main(int argc, char **argv)
 	fflush(stderr);
 
 	/* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
-	for (tmp=2; tmp<=64; tmp*=2) {
+	for (tmp = 2; tmp <= 64; tmp *= 2) {
 
 		retval = ioctl(fd, RTC_IRQP_SET, tmp);
 		if (retval == -1) {
@@ -99,7 +99,7 @@ int main(int argc, char **argv)
 			exit(errno);
 		}
 
-		for (i=1; i<21; i++) {
+		for (i = 1; i < 21; i++) {
 			gettimeofday(&start, NULL);
 			/* This blocks */
 			retval = read(fd, &data, sizeof(unsigned long));
@@ -118,7 +118,7 @@ int main(int argc, char **argv)
 				exit(-1);
 			}
 
-			fprintf(stderr, " %d",i);
+			fprintf(stderr, " %d", i);
 			fflush(stderr);
 		}
 
-- 
2.43.0


