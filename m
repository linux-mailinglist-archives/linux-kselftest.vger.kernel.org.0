Return-Path: <linux-kselftest+bounces-22831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FB79E422A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 18:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B9CB3D418
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E7120CCD7;
	Wed,  4 Dec 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="c63XBgaF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9820B80D
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329975; cv=none; b=TNEhH7nNLFVpVqBoOomUi/eScPxHlLS345CYPSJ2B9yniDwMwDoeC3aviZDed3tsFpwWxs8O2PQ1kYAPr+aebs5MYREafynXQKLXj+QbRllITzuFOMdKOO1PNzGWgtaxoOm6i8Z0p8wiBpe5sexKxnu1ZLMmxdu7rz7rR/TwfIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329975; c=relaxed/simple;
	bh=Z0dYTEMwvs7EPeBramaT98wi9z6hwRDhzo523x4GzXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HiAgPMItMX2l6b4x2tzd3kWlTUjvT7HfRNwCSE60Pel25RHUJO7i0yi9NPExHSYJ8fTh2nhHPrVSV2CMcD52Mehv1MWwML7Mp/61/ZLvUqY4IjLraQA5MZkXsUf6v3G4tfBdqJ6HMHRO6lKJ3Sjh3wCaydD4fMXQe1j6Vws3dqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=c63XBgaF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fc93152edcso19553a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2024 08:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733329972; x=1733934772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9F2gbv4yEGv6FWimwcogNz/DAberMpNHKWgDCnbd2w=;
        b=c63XBgaFWVjjICt1zdzR96hDRI7LWCGhDji9iAEFLGpRvbo87nWUc0Vy9k16wczuCQ
         B0jbr3o8laT/pdzxHbyEfz1m2zIZJS1N6UedFrvcF2LV6kAVMLJWoSRh8z94/VVPsaVo
         VgJQYpxtapRHZhbhROqd4/4oorsuR032rEuB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733329972; x=1733934772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9F2gbv4yEGv6FWimwcogNz/DAberMpNHKWgDCnbd2w=;
        b=I166/FqlGI8zGfqlrYxzN42nOzhtFTQZXMKLvXpiKMBQrLER0EyqDcT5/QPCHVcDxg
         Gqx3p6ew9hGwLbgbsCDvPpHOy6aDTY+2Kafc14jF6reH+7qO57AdUz6W3BSSN/jIM0Z5
         cNX25UXEyV7nRC/1NO416G9yejHUFuW+Eu3ahMXipS+fgeNbMcceNDcEIsw3xmSKnmEQ
         Klhck+HjzlifBKGgfTP/Y16UnXaxNoFn6Rqdsu96d3TW4YMEp+x7GTTeTZqDlDTvJS4D
         JgftkwqpM7mcUQEbRw9xrtXpsg3VZVDluwBhst2JKeG9TBge2XYf8AP/FAgc1blBHaH7
         +exg==
X-Forwarded-Encrypted: i=1; AJvYcCXt8jXe/yIow5DBImabe2NDkTIQFHgIyvoGenPBaKPNs21t4JW/4gOTDLoWqYEGGd4QS6KE400L+hbmp/XYcUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfaY2pALd1sNOR1lodlWxsGh/+v10FGi38EUJ6c8pXniZN9b3M
	3tPaTdJJbcJIRIzkAyQTBrrlqJSsQ4k4y25V7jaTZpIlivcArygf9dZzPcd2Zdc=
X-Gm-Gg: ASbGnctBWytTa6nGANT8x+fs6f02MTu4ixnvaXQXA30PZtmxov8qEwdbE0nvoyEEMpD
	wJCeMQEp/nadyYN5+4BI1UcrMxeEmFiPAoJ2VmZbYmmmGi8iwq2JmNBXswD7BNCwoxGGZypwaRu
	UsIzHMbFuDv9mwJk9JqYj0mrmL7yDeh2rf8FdE1TZl8lf6yxo8w3VeISJrVX4MkTC4k5lZX70H+
	i3Up0NXKXX35zucKyTOrg1aR7ax0UkyUMx+gSTxemhODA85iT2SDn+BiA==
X-Google-Smtp-Source: AGHT+IH+E1gXaxMcRBNlIPPX1i+yJ6kT0s/1DKSFVWFhZ1hgmYUfBlH8N4Ve1euLnBgvSAii6npH/w==
X-Received: by 2002:a17:902:f64d:b0:215:8fd3:d1b6 with SMTP id d9443c01a7336-215be6fca4fmr115273835ad.23.1733329970689;
        Wed, 04 Dec 2024 08:32:50 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215884744e6sm60591775ad.174.2024.12.04.08.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:32:49 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	stfomichev@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH net-next v2] selftests: net: cleanup busy_poller.c
Date: Wed,  4 Dec 2024 16:32:39 +0000
Message-Id: <20241204163239.294123-1-jdamato@fastly.com>
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

While here:
  - free the strdup'd cfg string for overall hygenie.
  - initialize napi_id = 0 in setup_queue to avoid warnings on some
    compilers.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - initialize napi_id to 0 in setup_queue to avoid clang warning as
     suggested by Stanislav. Tested with clang 10.0.0 and 18.1.8

 tools/testing/selftests/net/busy_poller.c | 88 +++++++++++++----------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/net/busy_poller.c b/tools/testing/selftests/net/busy_poller.c
index 99b0e8c17fca..04c7ff577bb8 100644
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
@@ -215,7 +223,7 @@ static void setup_queue(void)
 	struct netdev_napi_set_req *set_req = NULL;
 	struct ynl_sock *ys;
 	struct ynl_error yerr;
-	uint32_t napi_id;
+	uint32_t napi_id = 0;
 
 	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
 	if (!ys)
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

base-commit: e8e7be7d212dc2bc83b8151e51088666a6c42092
-- 
2.25.1


