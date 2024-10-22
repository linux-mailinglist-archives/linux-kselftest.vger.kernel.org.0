Return-Path: <linux-kselftest+bounces-20420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969DF9AB762
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 22:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5C91C23F88
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F81A08DB;
	Tue, 22 Oct 2024 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnV6PnIy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4376E1BDA89;
	Tue, 22 Oct 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627458; cv=none; b=We/posloJl+suU9H4V1sZrfoMSO0x+25SxZdMWevnE1J0e8WmV8m4vv7PbCu0UXUuSKHm83A9cnohEifEFMxdfZIGKxekQvhUKa6JCb6Fq0lIrcGc5Bj/TOOX6A1SJtpqbv+vjbY4mdmpvJ7eZqbg5G5ZSsn04UHqSrgDWPCO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627458; c=relaxed/simple;
	bh=T/LpGdAqbCENOzb45jhG1O4Oa7I14+ESSEV89GZTlmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juUBK8lH2mpXO1GToe3bfmIE3w35I0cRbabE9B5JP7ptKReTO1vGxF3dbQ7Frk+kQYshvkoPFWTOI1bwSpo0wXIVrObxj1WJDuUcjn6KeMN/pvZ33WFYabQVK0fYOIXDdOWZSBvJiU4qs1yUfIZDeJnuurk7ve8Yqn2eV1aloLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnV6PnIy; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso953933566b.1;
        Tue, 22 Oct 2024 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729627455; x=1730232255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hatEP+Fej9bXOQWJZd5WckT7eSEdtgm4yaQHG/Q8RoE=;
        b=LnV6PnIycdS/SG2UkLBUa99t7J3AZjqG8FMcW0CCF7wyNQJQDMYH6p82h7eCgD63Gu
         DW5Y/OvsrVOD5K90wb276CDL3YkEcDrbnoxJAO68QbRUfXD6pR/X6v/KcLlo6BqbV4zb
         8y1fhbPHwWcgXqKF81Wp9DQs7vAFTRKDaSpEayH2p8eNsqMhhGUxpGsCiXGOxIada44y
         Yi1c/LlS1W3qDM7S1Yz2MELUKHOGu2PLMa+wbZkT56+Y23B5vg3aUDUcjNpue8mFAYG5
         sI0zxCdnxMOsXetBnAVjZpy9CRwOsjWhyt5BvAHT3N6aY7cYhAK9wSq8hTwQlDxZLuZc
         AdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729627455; x=1730232255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hatEP+Fej9bXOQWJZd5WckT7eSEdtgm4yaQHG/Q8RoE=;
        b=ieCWXLIQP+OApxMYFCUuGk2WEqhlXO2vkkN7ror51GLOjTFZBTdbbPoCo0kMZ81SGV
         0gNqfF0KzVvbJIbGD91EZqmYhasTcIYomNgCWalANnrgLiT0DQIW4/kYsfqT84JrRa3p
         iuXZZPyK/RcvqZKRojEbA9xTB+SKef1bKiz4eykcXHTZrMfoDoKGM1i5JC2OiAvkVLeL
         r3IiAXrF+1rNudriDuZnGws5zKqp5L058gI48MLfjVvVHZxOAUAb7BpeHBeTe9Lbxt33
         ElfcNjIFbuBFyiZ9uvXJF05XE+WZ4CT/3qsUpaEwFp6QPbRO4rqnoM9N7iQ7Rd/2W7Sg
         MdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6wGITxU+VH/Re4r05d+mQzq6rHrA9Wh8fMQh4mtv9nhakjcZjiHDKeakQ8QC40SsbLi3+b0R0Mtc8KMU=@vger.kernel.org, AJvYcCXsa7osZovmDTpLfzDQnOBMdALmYYcY7XO3eWweJRBn3n3tslMvHkFQCmj4W9uDcmKeoZ1X1UToptlzeyjtl5/W@vger.kernel.org
X-Gm-Message-State: AOJu0YzoEsGdPRTpV4AyE3FuXkAyF1F0pq3bPDe/OQSvzYE/bjUmilbY
	sYocJqPM1WFLc3lda0PgxqUlBlkWfcmY7UUydnJaQ+2XgmQ5ZOFG
X-Google-Smtp-Source: AGHT+IHr+KbkteF3BQofMieMcUIXOEO1bsHJWGnErLq5b38VoEbRlh5y6ihcPUNLSk4HTXJbnLeFSA==
X-Received: by 2002:a17:907:97d6:b0:a9a:3fd8:9c95 with SMTP id a640c23a62f3a-a9abf92ccfdmr17351166b.47.1729627455316;
        Tue, 22 Oct 2024 13:04:15 -0700 (PDT)
Received: from alessandro-pc.station (net-93-66-158-115.cust.vodafonedsl.it. [93.66.158.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6383sm381045466b.6.2024.10.22.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:04:13 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH 1/2] selftests/intel_pstate: fix operand expected
Date: Tue, 22 Oct 2024 22:03:44 +0200
Message-ID: <20241022200346.5610-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running "make kselftest TARGETS=intel_pstate" results in
the following errors:
- ./run.sh: line 90: / 1000: syntax error: operand expected
(error token is "/ 1000")
- ./run.sh: line 92: / 1000: syntax error: operand expected
(error token is "/ 1000")

This fix allows to have cross-platform compatibility when
using arithmetic expression with command substitutions.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/intel_pstate/run.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index e7008f614ad7..0c1b6c1308a4 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -87,9 +87,9 @@ mkt_freq=${_mkt_freq}0
 
 # Get the ranges from cpupower
 _min_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $1 } ')
-min_freq=$(($_min_freq / 1000))
+min_freq=$((_min_freq / 1000))
 _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
-max_freq=$(($_max_freq / 1000))
+max_freq=$((_max_freq / 1000))
 
 
 [ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`
-- 
2.43.0


From d6500cf7c800bd39ae3ef2930cece5b3be460c0b Mon Sep 17 00:00:00 2001
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
Date: Tue, 22 Oct 2024 17:22:13 +0200
Subject: [PATCH 2/2] selftests/intel_pstate: cpupower command not found
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    skhan@linuxfoundation.org,
    anupnewsmail@gmail.com

Running "make kselftest TARGETS=intel_pstate" results in the following errors:
- ./run.sh: line 89: cpupower: command not found
- ./run.sh: line 91: cpupower: command not found

if the cpupower is not installed.

Since the test depends on cpupower, this patch stops the test if the cpupower
is not installed.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/intel_pstate/run.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index 0c1b6c1308a4..6a3b8503264e 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -44,6 +44,11 @@ if [ $UID != 0 ] && [ $EVALUATE_ONLY == 0 ]; then
     exit $ksft_skip
 fi
 
+if ! command -v cpupower &> /dev/null; then
+	echo $msg cpupower could not be found, please install it >&2
+	exit $ksft_skip
+fi
+
 max_cpus=$(($(nproc)-1))
 
 function run_test () {
-- 
2.43.0


