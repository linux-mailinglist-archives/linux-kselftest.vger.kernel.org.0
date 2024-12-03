Return-Path: <linux-kselftest+bounces-22720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E359E10C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 02:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3533B2145A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 01:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6522E3EE;
	Tue,  3 Dec 2024 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="arW77eKu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE0847C
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733189332; cv=none; b=EQQ2p2Nlj3WxHPCm3neSdqmekchaEVjrTEgjE/0UkvoGrEoLJ4v7Y5XoCLe+sxcDlRvtuUJDl5Of8wuduCYSvS32tQCETeF3/wfwJY3gJoa+3XelUOyHKx/919oKf6j0BbDev0Tgh6UxeeEoCPscEvSpKgcpuRO7/icwMYDo/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733189332; c=relaxed/simple;
	bh=8iV3hNlKi9ZAJH64zDJz1j35OcXaCtTfWFhvtZPXAEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jy8LAUszb+TJ8JEHX8nqX5DzpKTQKjgZhstqVE+aAZjEthI1qwtpqmXmHvDnMU5YW/aT7t2Us7n7h+oDCym4R38UCjyJQwJ/c7mwzcYfph/Pk4dmb4M7T3L5k/Xs3+pbqqAPajBwxQ2VkzYNOwY2dChJcGSv35klv9qWKDXHXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=arW77eKu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-215513ea198so22930975ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 17:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733189330; x=1733794130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWNYXKMiPapz1Mt6v6Pm3WNUSi3yE7uDCRcmv8yYg64=;
        b=arW77eKuP0QYvhkv7Jp7RqsaMZT+qE/T7r7FgRsIbR82tcgmJkyAc27+O1cRxuWoLh
         1XodkzKGabGzyusrQ01HyOKlr5mhZxN3NgRpdJzu8S+705FBdiB8tM1xcwMgFT5+kT01
         iXcaSw7S/JiB7IAOgJZllLRstwyMpOVeX+sDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733189330; x=1733794130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWNYXKMiPapz1Mt6v6Pm3WNUSi3yE7uDCRcmv8yYg64=;
        b=ipO3uWb9xW3eUnYKXdQagLfZrpjXDI0IEAe3Fvh2h4S74QsL/xIJ7flx0bt7LS9Yag
         Wkum9dudiT7IMiUGU4lEubvG2Rmjy6xNeiMgtVFqqowIuSx+oETH6SSlB0wAoURwe3iU
         UBO8FkKDp+Jk4PsdSLpjVArt18o3n92V5oIJXhI5Ot5KezLzLcuUMGeF/Bvfh5nXWbQl
         F1Q5cpECNt8RdMwA0jkscD8XyG2o6c1mNhGeMPNDtlSUAyV6fF+/5JdswmDOdLEX0VgF
         P0mO1/q2zNCY4QVotDgE8CF/v+6Tcz50JozCBoBz7+BRBvCb9cxwFxW0zChxYVZ9PPBP
         HxBg==
X-Forwarded-Encrypted: i=1; AJvYcCUnr+ot8wbD0+9ke96WCz9a5+qWG7b7PWKRdde5rb0opaSUU5jLhyjn/YajctLZAAFM4nET+ppKPfw+jlVwhYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlFlEGPc/OgmzdJmtZzYx0EYAy7hVtVAzMQ/I4betRbVhZU5rO
	Aha7O5iYoyLHKfgaMprecWmNS8dsUSVLhvPDuwaKNoWaQnZGL7ivhIMkZFxnjbc=
X-Gm-Gg: ASbGncvp4oQEBa+vZnbslPNIWGuOpcf+g2WPsYjipvCsmqZdDymWITabMG8jFa3hWNx
	GAURITyekboWse+3cpdH+/v09kyWfOKOi6MpDO9b0B4NazHlye8afusTzzU7V2sXUog+jcBfuCI
	1M5Dhs9sMLM/ryuapWySyWkUFU6+2XJSYotto9F2ybcJE6ytbmrQuXIZxTtIfo84Hfqsa+ex7oi
	hwjakZSCRno4O+Ka/9/Zx0dDt2LV1uNGNPjwW0bUVHGzFRPwOmoC32Sqg==
X-Google-Smtp-Source: AGHT+IGt5WbOAM0L8F7DeypmXThouFU45yqNTHy92A7JuVHfqSlriRd2Dnq7v8Tti+0NfHckZUsSXw==
X-Received: by 2002:a17:902:c943:b0:215:58be:3349 with SMTP id d9443c01a7336-215bdf0784bmr8410745ad.14.1733189330379;
        Mon, 02 Dec 2024 17:28:50 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215b08965b4sm8846065ad.180.2024.12.02.17.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 17:28:49 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] selftests: net: cleanup busy_poller.c
Date: Tue,  3 Dec 2024 01:28:38 +0000
Message-Id: <20241203012838.182522-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various integer type conversions by using strtoull and a temporary
variable which is bounds checked before being casted into the
appropriate cfg_* variable for use by the test program.

While here, free the strdup'd cfg string for overall hygenie.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/net/busy_poller.c | 86 +++++++++++++----------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/net/busy_poller.c b/tools/testing/selftests/net/busy_poller.c
index 99b0e8c17fca..ef62d7145598 100644
--- a/tools/testing/selftests/net/busy_poller.c
+++ b/tools/testing/selftests/net/busy_poller.c
@@ -54,16 +54,16 @@ struct epoll_params {
 #define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
 #endif
 
-static uint32_t cfg_port = 8000;
+static uint16_t cfg_port = 8000;
 static struct in_addr cfg_bind_addr = { .s_addr = INADDR_ANY };
 static char *cfg_outfile;
 static int cfg_max_events = 8;
-static int cfg_ifindex;
+static uint32_t cfg_ifindex;
 
 /* busy poll params */
 static uint32_t cfg_busy_poll_usecs;
-static uint32_t cfg_busy_poll_budget;
-static uint32_t cfg_prefer_busy_poll;
+static uint16_t cfg_busy_poll_budget;
+static uint8_t cfg_prefer_busy_poll;
 
 /* IRQ params */
 static uint32_t cfg_defer_hard_irqs;
@@ -79,6 +79,7 @@ static void usage(const char *filepath)
 
 static void parse_opts(int argc, char **argv)
 {
+	unsigned long long tmp;
 	int ret;
 	int c;
 
@@ -86,31 +87,40 @@ static void parse_opts(int argc, char **argv)
 		usage(argv[0]);
 
 	while ((c = getopt(argc, argv, "p:m:b:u:P:g:o:d:r:s:i:")) != -1) {
+		/* most options take integer values, except o and b, so reduce
+		 * code duplication a bit for the common case by calling
+		 * strtoull here and leave bounds checking and casting per
+		 * option below.
+		 */
+		if (c != 'o' && c != 'b')
+			tmp = strtoull(optarg, NULL, 0);
+
 		switch (c) {
 		case 'u':
-			cfg_busy_poll_usecs = strtoul(optarg, NULL, 0);
-			if (cfg_busy_poll_usecs == ULONG_MAX ||
-			    cfg_busy_poll_usecs > UINT32_MAX)
+			if (tmp == ULLONG_MAX || tmp > UINT32_MAX)
 				error(1, ERANGE, "busy_poll_usecs too large");
+
+			cfg_busy_poll_usecs = (uint32_t)tmp;
 			break;
 		case 'P':
-			cfg_prefer_busy_poll = strtoul(optarg, NULL, 0);
-			if (cfg_prefer_busy_poll == ULONG_MAX ||
-			    cfg_prefer_busy_poll > 1)
+			if (tmp == ULLONG_MAX || tmp > 1)
 				error(1, ERANGE,
 				      "prefer busy poll should be 0 or 1");
+
+			cfg_prefer_busy_poll = (uint8_t)tmp;
 			break;
 		case 'g':
-			cfg_busy_poll_budget = strtoul(optarg, NULL, 0);
-			if (cfg_busy_poll_budget == ULONG_MAX ||
-			    cfg_busy_poll_budget > UINT16_MAX)
+			if (tmp == ULLONG_MAX || tmp > UINT16_MAX)
 				error(1, ERANGE,
 				      "busy poll budget must be [0, UINT16_MAX]");
+
+			cfg_busy_poll_budget = (uint16_t)tmp;
 			break;
 		case 'p':
-			cfg_port = strtoul(optarg, NULL, 0);
-			if (cfg_port > UINT16_MAX)
+			if (tmp == ULLONG_MAX || tmp > UINT16_MAX)
 				error(1, ERANGE, "port must be <= 65535");
+
+			cfg_port = (uint16_t)tmp;
 			break;
 		case 'b':
 			ret = inet_aton(optarg, &cfg_bind_addr);
@@ -124,41 +134,39 @@ static void parse_opts(int argc, char **argv)
 				error(1, 0, "outfile invalid");
 			break;
 		case 'm':
-			cfg_max_events = strtol(optarg, NULL, 0);
-
-			if (cfg_max_events == LONG_MIN ||
-			    cfg_max_events == LONG_MAX ||
-			    cfg_max_events <= 0)
+			if (tmp == ULLONG_MAX || tmp > INT_MAX)
 				error(1, ERANGE,
-				      "max events must be > 0 and < LONG_MAX");
+				      "max events must be > 0 and <= INT_MAX");
+
+			cfg_max_events = (int)tmp;
 			break;
 		case 'd':
-			cfg_defer_hard_irqs = strtoul(optarg, NULL, 0);
-
-			if (cfg_defer_hard_irqs == ULONG_MAX ||
-			    cfg_defer_hard_irqs > INT32_MAX)
+			if (tmp == ULLONG_MAX || tmp > INT32_MAX)
 				error(1, ERANGE,
 				      "defer_hard_irqs must be <= INT32_MAX");
+
+			cfg_defer_hard_irqs = (uint32_t)tmp;
 			break;
 		case 'r':
-			cfg_gro_flush_timeout = strtoull(optarg, NULL, 0);
-
-			if (cfg_gro_flush_timeout == ULLONG_MAX)
+			if (tmp == ULLONG_MAX || tmp > UINT64_MAX)
 				error(1, ERANGE,
-				      "gro_flush_timeout must be < ULLONG_MAX");
+				      "gro_flush_timeout must be < UINT64_MAX");
+
+			cfg_gro_flush_timeout = (uint64_t)tmp;
 			break;
 		case 's':
-			cfg_irq_suspend_timeout = strtoull(optarg, NULL, 0);
-
-			if (cfg_irq_suspend_timeout == ULLONG_MAX)
+			if (tmp == ULLONG_MAX || tmp > UINT64_MAX)
 				error(1, ERANGE,
 				      "irq_suspend_timeout must be < ULLONG_MAX");
+
+			cfg_irq_suspend_timeout = (uint64_t)tmp;
 			break;
 		case 'i':
-			cfg_ifindex = strtoul(optarg, NULL, 0);
-			if (cfg_ifindex == ULONG_MAX)
+			if (tmp == ULLONG_MAX || tmp > INT_MAX)
 				error(1, ERANGE,
-				      "ifindex must be < ULONG_MAX");
+				      "ifindex must be <= INT_MAX");
+
+			cfg_ifindex = (int)tmp;
 			break;
 		}
 	}
@@ -277,8 +285,8 @@ static void run_poller(void)
 	 * here
 	 */
 	epoll_params.busy_poll_usecs = cfg_busy_poll_usecs;
-	epoll_params.busy_poll_budget = (uint16_t)cfg_busy_poll_budget;
-	epoll_params.prefer_busy_poll = (uint8_t)cfg_prefer_busy_poll;
+	epoll_params.busy_poll_budget = cfg_busy_poll_budget;
+	epoll_params.prefer_busy_poll = cfg_prefer_busy_poll;
 	epoll_params.__pad = 0;
 
 	val = 1;
@@ -342,5 +350,9 @@ int main(int argc, char *argv[])
 	parse_opts(argc, argv);
 	setup_queue();
 	run_poller();
+
+	if (cfg_outfile)
+		free(cfg_outfile);
+
 	return 0;
 }

base-commit: 65ae975e97d5aab3ee9dc5ec701b12090572ed43
-- 
2.25.1


