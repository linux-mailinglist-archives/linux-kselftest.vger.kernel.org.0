Return-Path: <linux-kselftest+bounces-34534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B58DAD2BC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 04:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36E516D6CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 02:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907F199FB0;
	Tue, 10 Jun 2025 02:09:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37419E97C;
	Tue, 10 Jun 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749521349; cv=none; b=Id7ZBTig9n2Te7ArLtAzNjqpA4g7wmGEbCzYPSlXfpyMLCzETziVr/PMqyLmh+DXZ7yJ6u3lQCSBBBLLLfoblmpxPwVrOiYnHDJq4pOuf1v72eQm2aGA8ZSyls0E304NZSZzmnSMYpOpg4lW7B+tFN8ggD94p9HYtHhNg/Mt+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749521349; c=relaxed/simple;
	bh=R6mmVgX/egzbHlhwR9y9hO9y5Huowy5XWmmI365cG5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNZDX9gyvhsgQFlx7ORom3VHYhebdAnTsS8JtSVI955Bc3hybMP7CPiACZKicTpqCencrHDFLkZhLispfJOsvhTkmATNVw8iJ40yTMUb0bbJi4kkq7uVggGdFK6FccmyBCkpxtOr6rBgrfHh2eGGOH3+DHqjViW5neo77mWoG84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d38cfa9773so240139285a.2;
        Mon, 09 Jun 2025 19:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749521346; x=1750126146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnC+Ue98VGwpV1vtakqaEuSsenEtL0aLmlbs58YHsHo=;
        b=mU5WpwvWhR6wed2/rbCh+qcdOEcASE5VfrqA9xsS/tKFs62K/jDj0KCQrmIdWAJT48
         l0gxW5nyCWCwatwDcpviPDmjsPcQTYQkaSeBMudxGEN6hn3ywgmeYk99AafUlkg4tOuH
         Zd9jIteXOC5UagcyCro8IrfTTrRIMfJXZZ5DLt9bAS99e8UQCIe2uxu4DvdQ5O5YDmdq
         e/+c9ceFrq2Qe3RZ2vbmzAOrAu4uHkMSqFA+/cvEgqdjalxgZpcquQLnaxHi2LNa1bs2
         p3/jqeMWCRXO5S88uOPUZbxDZs9vdTkgkqtxRpJtM/mLvIR56BiJCChkJvBolqNeROwR
         gJkg==
X-Forwarded-Encrypted: i=1; AJvYcCVukgb4zGcmYj5Fn/lFBRtAbjB0U5zUONPeGBC0x/cn9JNLE/hWjNJJ7Tdck3/Ym0lyo4jq3XJB/AbarxnHzELD@vger.kernel.org, AJvYcCXwRhDTlwlvR99w0194BBfjOK6u5+Vg8GMuV8m+gKkOOwJxDdra1JKGT2qpmvh/sIUBPOSNmbkzDSDkBiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3CbGYHA5GDq3jbJZ7+MRVnGOkRtXpMO8Cxw55bH9LqCl+2/GB
	u+OGnhYoMKlrLn5OIrvVcGCVIWQ1cqymuAe4eV8aAuiZxvLdj5ASv3MTR8HRJczdPxE=
X-Gm-Gg: ASbGncv0H8T4tjP4AypMBgmCuwAo8vZACm7y/sZMYvMaAtSG2dCi1y1vfnuNn89tXHy
	fnx8DalTA6zo6j7hqkF8FrSJ4D/FgIdqmJrnoyI5CKzrDNZY6dxggrFCTN4dgVEqEUhx0M0awz+
	p6swS40lKgLv51XLL4s7LH3mkJU+oxUuftnxgptWR0UN4ZiB1ZwX6UWL41rvKSOz2q7dbzgBMsC
	T1AhzTBR2++wyQJbAzqRnkgcFmjCRvfxqhpw7q1qJ7Wh0Re9YgKk4Vd3zyOWUHWElBSbfVb/Zyn
	7sUhdFnNRs8xNbYWr0kRUJn1ukqslanv2tMJD1BkhRh4Q3Q358khFMwOtie85T8n+SJamFh2F25
	RY7fTJy9SEBdY2RehBKzJCYKwROTIF2RO
X-Google-Smtp-Source: AGHT+IEpYM8ahTYjImVeejxYctTzQ7p3eG/kdEb36tgX6d7LZKmW7ECK+T3BxI49eTz/gjbe32Mf2Q==
X-Received: by 2002:a05:620a:1d07:b0:7d0:9bd7:f9ae with SMTP id af79cd13be357-7d39f563ac5mr145491985a.2.1749521346094;
        Mon, 09 Jun 2025 19:09:06 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d2513357dbsm626472385a.13.2025.06.09.19.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 19:09:05 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RESEND] selftests: add missing include
Date: Tue, 10 Jun 2025 10:08:40 +0800
Message-ID: <20250610020839.2799222-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I failed to build this test on Ubuntu 24.04.
Compiler complained about undefined functions mount, umount and some
mount related flags.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 tools/testing/selftests/pid_namespace/pid_max.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 96f274f0582b6..c3ee8a2eff75b 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -12,6 +12,7 @@
 #include <syscall.h>
 #include <sys/mount.h>
 #include <sys/wait.h>
+#include <sys/mount.h>
 
 #include "../kselftest_harness.h"
 #include "../pidfd/pidfd.h"
-- 
2.43.0


