Return-Path: <linux-kselftest+bounces-18960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE198ECBC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 12:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C503B2303E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A80149C54;
	Thu,  3 Oct 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3y8GoBY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89E1B969
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727950521; cv=none; b=lZOrEjLYX6VvmGZguQO8jHYLMkhk87mg/0aW5owayn0WrAVh/k8N5t7xtQsL8D4f9hewI8y11yYsYdpjKagJNWOW0Ge8p01ve6uoDHbDCDW874Ne6uOkzl0DUVUeHvXVG3JTlB55HVI91zMjFcN0dIg8zDSsoK8EmKk68LVKyNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727950521; c=relaxed/simple;
	bh=W/q391NOLcv4N9mlbQz9RJQksLSfpRms186k8UVJH4c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JasGlw2noAbufdDVczUH09XRHXbJ8TBovLXfIA7Ra5vZK5gRtaPqhbEixEuGOyU61reYKyE8DTttpFQb5QCYaRaBCUUQAxALjmkIRmJVp8nQwbL7+1kD+AQ8Cz5zAovhdu32Ze004sxGEl3F2HK9C30csOeOr+9djzBJ9Htiepg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3y8GoBY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d7124939beso11370297b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727950519; x=1728555319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hHKdquS6rEAHEJhD2/T+ynunH+V8kyPoT7KF23CFusM=;
        b=a3y8GoBYEUUmN0ipH1yRF5e6otP0uwaVzf+ITX/k2bky84yi6Wpnwg9vhhV2AEqRsR
         VhKSZrxBugrWirlQP3pjTy5PEKCTaHHuI+y3tErZts6zo6T3rLGbfMq3WVO3IY1yMnP8
         gxlJaw7womYP+V9v97n+j3mvID+c60atfPlanRGVdeElIWfiDd5X++szhUvlV2m6ST9c
         Ox/PXcM90Qh19L28U8XWUIirO3ZtLC3Kk6EZOy68IbTXbsPg1A7Qi6MbTb7zNkrPMniJ
         P6hQgZRahf5XG1JRm1+ZX4JiAaroC7kqbbxzoIHEyAABuz0juV9aLOLfGHjWyhMKlxeG
         RzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727950519; x=1728555319;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHKdquS6rEAHEJhD2/T+ynunH+V8kyPoT7KF23CFusM=;
        b=O8dS6CxLuGbQ1Ab4xjka1zd/EoiMLuSKFYvnd7oiGUY6jjUi2ATHyvYCc158xoV/3k
         nEtnP7+q6no72Fg946nPlNJOPKlnYg8c6Y0e9Of9qPCVJsRwTAmWLvk2JNfC/pCs8SFA
         we/yKnKF/g7LfKaUIhz98JxEZKQxbod7pqH5kz/+s57JRzusq1V2CNOhnRMmGUgBoAUc
         BjkZTtb2VSR3E6yHc14gbpWoKJMO9aHb7i8yYFBk0BroCkZ30hyKyNrcY1xbXSmxB5WL
         bgW6M5F9Q6YY3lcnDqhVWXkhoEl7pnI4D5U8jx89BrHIi6wWSGdj0dWexQ0WK/fPRDPI
         LVRg==
X-Forwarded-Encrypted: i=1; AJvYcCUHmuJ1nNPcMt2g9FggYKgDXd46JRBHbykhH6vhu8jcDgtjQNr1dF3tp0O2vVdPt9llA6Z6gzIL8KYRNgkSAkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQ5F/9ZAyjmz+W4Uclsawa2qIgCMlaB6TgwT+O8zwvdLbVTyH
	/dUf8L3axalWvmvMd965MALZaenx9v5w1rae7O015kXdzREguTSGdr2iGSZz6PY+L4qft0vpbhB
	3aBzE3A==
X-Google-Smtp-Source: AGHT+IHbTtVLF5lQRzT0cojiPwAXbALhrRqnHeQPHtnAhxKUugHPtymnjGPCwftIdoHQpZYJ1Eb0btP9KbgV
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:12b:2883:ac1c:9f5])
 (user=maheshb job=sendgmr) by 2002:a05:6902:f08:b0:e16:4d66:982e with SMTP id
 3f1490d57ef6-e26383bed76mr15020276.5.1727950518812; Thu, 03 Oct 2024 03:15:18
 -0700 (PDT)
Date: Thu,  3 Oct 2024 03:15:06 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241003101506.769418-1-maheshb@google.com>
Subject: [PATCH net-next] selftest/ptp: update ptp selftest to exercise the
 gettimex options
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Kselftest <linux-kselftest@vger.kernel.org>
Cc: Mahesh Bandewar <mahesh@bandewar.net>, Mahesh Bandewar <maheshb@google.com>, 
	Shuah Khan <shuah@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

With the inclusion of commit c259acab839e ("ptp/ioctl: support
MONOTONIC{,_RAW} timestamps for PTP_SYS_OFFSET_EXTENDED") clock_gettime()
now allows retrieval of pre/post timestamps for CLOCK_MONOTONIC and
CLOCK_MONOTONIC_RAW timebases along with the previously supported
CLOCK_REALTIME.

This patch adds a command line option 'y' to the testptp program to
choose one of the allowed timebases [realtime aka system, monotonic,
and monotonic-raw).

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/ptp/testptp.c | 62 ++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 011252fe238c..58064151f2c8 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -146,6 +146,7 @@ static void usage(char *progname)
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -X         get a ptp clock cross timestamp\n"
+		" -y val     pre/post tstamp timebase to use {realtime|monotonic|monotonic-raw}\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname, PTP_MAX_SAMPLES);
 }
@@ -189,6 +190,7 @@ int main(int argc, char *argv[])
 	int seconds = 0;
 	int settime = 0;
 	int channel = -1;
+	clockid_t ext_clockid = CLOCK_REALTIME;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -198,7 +200,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xy:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -278,6 +280,21 @@ int main(int argc, char *argv[])
 		case 'X':
 			getcross = 1;
 			break;
+		case 'y':
+			if (!strcasecmp(optarg, "realtime"))
+				ext_clockid = CLOCK_REALTIME;
+			else if (!strcasecmp(optarg, "monotonic"))
+				ext_clockid = CLOCK_MONOTONIC;
+			else if (!strcasecmp(optarg, "monotonic-raw"))
+				ext_clockid = CLOCK_MONOTONIC_RAW;
+			else {
+				fprintf(stderr,
+					"type needs to be realtime, monotonic or monotonic-raw; was given %s\n",
+					optarg);
+				return -1;
+			}
+			break;
+
 		case 'z':
 			flagtest = 1;
 			break;
@@ -566,6 +583,7 @@ int main(int argc, char *argv[])
 		}
 
 		soe->n_samples = getextended;
+		soe->clockid = ext_clockid;
 
 		if (ioctl(fd, PTP_SYS_OFFSET_EXTENDED, soe)) {
 			perror("PTP_SYS_OFFSET_EXTENDED");
@@ -574,12 +592,46 @@ int main(int argc, char *argv[])
 			       getextended);
 
 			for (i = 0; i < getextended; i++) {
-				printf("sample #%2d: system time before: %lld.%09u\n",
-				       i, soe->ts[i][0].sec, soe->ts[i][0].nsec);
+				switch (ext_clockid) {
+				case CLOCK_REALTIME:
+					printf("sample #%2d: real time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				case CLOCK_MONOTONIC:
+					printf("sample #%2d: monotonic time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				case CLOCK_MONOTONIC_RAW:
+					printf("sample #%2d: monotonic-raw time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				default:
+					break;
+				}
 				printf("            phc time: %lld.%09u\n",
 				       soe->ts[i][1].sec, soe->ts[i][1].nsec);
-				printf("            system time after: %lld.%09u\n",
-				       soe->ts[i][2].sec, soe->ts[i][2].nsec);
+				switch (ext_clockid) {
+				case CLOCK_REALTIME:
+					printf("            real time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				case CLOCK_MONOTONIC:
+					printf("            monotonic time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				case CLOCK_MONOTONIC_RAW:
+					printf("            monotonic-raw time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				default:
+					break;
+				}
 			}
 		}
 
-- 
2.46.1.824.gd892dcdcdd-goog


