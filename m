Return-Path: <linux-kselftest+bounces-39286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C3DB2BAC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551D1626DFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E8625A2AE;
	Tue, 19 Aug 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfXaSVT7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F87FBAC
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588624; cv=none; b=UO4xa3VzKDeaCWnDR0mZNI/TvKYkrzJs5x0J65Xv8jWP01xecCM87mw7y6hS3/F8u4jCc5iDMzBTd3a/gJJWPkkQvMugLefYG39CR91iY4yCagK7DSOozQjCHlqXPSJCa8Jkx9nm0qrXdtp7GbAZD4JnBwZLY9WRHbZJncdXoj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588624; c=relaxed/simple;
	bh=5SWrOqsOjRXtQmZBkktmi7W8AxcP0JV2xVyFi1knU3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qL8xDCZVbafcGY9QYpKsBhStcHYu4JWDDAK7kbG6wQPIwL0Hu9sRA4pbher400V/So+D6isljsvnGt2isiFZWJM8yLI0xfsXa92ADeVjN4IFFDPycevUmmlGL4n0WAXomUSXayrU+8lYd98qEQiAt4np/feJpcTkjRDdw+ZJsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfXaSVT7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9dc56a7a3so634268f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 00:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755588621; x=1756193421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ/4MiuH+uKPxmrL1oBiKZlLklwBZnyUMBYuRZJW6Rg=;
        b=BfXaSVT7Fc1Vl7JGznOiVqu21/lDWGyAY3T09vblUW3qVwGKOoJA12zSDELQ++nnip
         yha69UASUBU8mCZtc4m+FZzXFMRLwugNtY+2jJ1DM7rjJGF+Ogo3E4YSwXLJrOuMUXSr
         05OYWv5btJgxAEKw84c3Stfd+hCXksGDYijGvb0J83M1h0ZBdZP6vHE0kF4OJ7uE3B7e
         rZdKacIJfN2WTh7jff1QjDnPnAhli/zjFbHiYgD8gBtASUSWmM+x6Eh+EYpmy41y8ZgZ
         PWa8d7NncuSFDP9h1i07EvOL5rLaJ68+6m3lPr9pQIp6KgSk4cf72OYW49gnppyd4gIV
         g+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588621; x=1756193421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZ/4MiuH+uKPxmrL1oBiKZlLklwBZnyUMBYuRZJW6Rg=;
        b=KVIa1ogsSiohYbc2NtElXhSoDjvGXNGNH+N1BjRKMRHjX14z2lRUZursD7dmWVFsK9
         rwAymHZnXGYGghZaWv2+Wzg9lrsRcIufIB/bWKRNYXYonf2Gq1UQW17t3RZUaml/ZEiT
         GYcI2UCYs+MwQaNFie8RQeeAEwvo1PHOS2oZV+v5BviJeoVqdTD1Dj1+Hhq+X3PvPdPo
         gZQGkBDM1BdJDoC1GpklLGAASjPAhBdaLLzU7mNfMNBNU3AZpUo7/K/exscIvSgYyZpe
         70KmaUW36MBsSyDTcMMaqN9oI3kUDnaKYA7PUDfqcrAlcGLiJ11FqtPkwdVXlFzMhPFP
         xdNw==
X-Gm-Message-State: AOJu0YyK7Tc3Vhb7yRdnD6iaYbfRqXbXmZCL5xd3DHcBs7etcuqTU2xK
	WnUKOrmNZ95lrsrIrapp7g6vVDtLJ5z7yyRiG9FDiojQRCQpGJ9p7ophmkfNFC8N
X-Gm-Gg: ASbGncuxtVwgwHbSIy3JssWVDiKttbhibpgQ59+Flqt37vqlDuxO4pZ8tx6KANlzfUA
	KQ9SA5VDPr/jKGp7SnpfVKHiExlqopiuH8uG7p7feuZKbo+DPYOxrrTHZOrja82yLAjtNpu8kXX
	TZimgSTy5yAIm1H+AQT3Hz8yLqjaWnb0KDBSM/eX8QUwdkoTxwNSGd97iWIdGoEpeOzjuW4NyH/
	s2elQ498w/k0ufAo25ofWhmJzrfCfG+fYql00FDp1zwpDtwyzya9jsxVSZ8Af46KEC95CNacmJn
	/hpUext17afXEgDR+7ow+49hZuGNrE542jLTKPdpP9Hn5lguEs0uBSaWx2jXGm/kPoeGwsOn7s7
	8hwciR3Xk85KTrOMqRbguCiPDww==
X-Google-Smtp-Source: AGHT+IGv6czHuUnpXLot4prHKRHjCN3RGKKWdPoEbqzzyH5T85wFHsShB48xmwxssxWxNbqyfd5i7Q==
X-Received: by 2002:a05:6000:2307:b0:3b9:1677:471f with SMTP id ffacd0b85a97d-3c0e9f00014mr478984f8f.1.1755588620884;
        Tue, 19 Aug 2025 00:30:20 -0700 (PDT)
Received: from bhk ([41.231.66.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077789c92sm2423425f8f.52.2025.08.19.00.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:30:20 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v2] selftests:ftrace:Improved event description
Date: Tue, 19 Aug 2025 08:28:56 +0100
Message-ID: <20250819073015.125292-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-Changed pid to PID to make it more clear

-Changed 'restricts' to 'restrict' instead to align with imperative form

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Changelog:

Changes since v1:
- Changed patch title to align with conventions.

- Reverted a typo in event/event-pid.tc "Event tracing" => "event
  tracing"

- Changed patch development to 6.17-rc2 from 6.16-rc7

 tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc | 2 +-
 tools/testing/selftests/ftrace/test.d/event/event-pid.tc    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
index 9933ed24f901..aa83be738e69 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# description: event tracing - restricts events based on pid notrace filtering
+# description: event tracing - restrict events based on PID notrace filtering
 # requires: set_event events/sched set_event_pid set_event_notrace_pid
 # flags: instance
 
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
index 7f5f97dffdc3..90ba7c794062 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# description: event tracing - restricts events based on pid
+# description: event tracing - restrict events based on PID
 # requires: set_event set_event_pid events/sched
 # flags: instance
 
-- 
2.50.1


