Return-Path: <linux-kselftest+bounces-41643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927CBB7DBD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1A93246AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 00:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF131FBCA1;
	Wed, 17 Sep 2025 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="P889/CWc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803B20B22
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069778; cv=none; b=kGmli0UG0v2S7Ais65akw9eKECxH0DvTVQ2Hz3Xt9a5AHK3GyM076viT/9hmFchgwxh4DnZWveecsvTY4Pk+/BeFT6t1exC6ahvjDlec/x5I+jg0HV4Q/21htSC5FUNOFVxepw1QVOdZSAJNRxGLJbQ3t/U3g/PRw5HvVrq/TH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069778; c=relaxed/simple;
	bh=IoCZ6ZPxfmj61WyHvtWW0iu+5wmp6Y5xJVRbIn3IzA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dv3KzfYxHlLMJZLd6mt3AaURe095vTbVD6r8ETswpN6RXWxMKFZJddhHumx0zucmeOS1fvhLtmLmJoo0Py6cg2sEn301nlJjN30v8ugGlstJSiFMFnW7rO6qbqSFP34SJkgMB9p4bP9uHv6jB9QJ9XGjJlkZg3nV3PM7RJkTGwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=P889/CWc; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-26685d63201so26204265ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 17:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758069775; x=1758674575; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ATmFGymkybyKAm0NHpJujWlpTamfL92YEA1XMkuNKxM=;
        b=P889/CWcl31iCJ/5pcXBnFqq/b5z3SyNtnBDXY40wTLHcduH7ze3ouyLoqADDVWHmB
         PsfoBXBVdNHRxIiQgRrEQ/e8hhaMnLYq7nXEU6/vKT9se3nSRnxCrDSI9njk04dDlc+B
         jvwqr04b0veFRA0DZGJ42F4SQ8B4+JAuMw62dQkpwVT1M/bVLd03AUgohQqZduTN1gb5
         JBwyobdKUUCAEcWm588ycAzCLMsUscLPLfr8NG+OWqunw3YvlKK54JuLMF2LZICa4MPT
         55WAF8mqXvY2T179rl/c7/QgTb/MUCgj+9XxDeCIEdL+y8MIDYiTQefKn32IM/cIsIT7
         ANFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758069775; x=1758674575;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATmFGymkybyKAm0NHpJujWlpTamfL92YEA1XMkuNKxM=;
        b=GA8ETf4aLsQlacDjBmtMzAUJpb2UgoOa2o1HMivRifEmF9CHshz9WUcIkFcRS6MhmO
         kfutUDSNrcNp68NcvQ8jMYoqNjWTFQ7uRKil7eY8wvGNs85V5DNXbJxlKzAG9Ic9QI5P
         HRo/1L5k2tTqju10a8bR/yd1DmDmL9orSXXNxvJsFJpJuhg7h063MqSDlP+OJBqcC9jM
         l+OZwWlsfEYTcV1WKcVGo2j3BpFvHmmzHq+icNPGOFn3drUIisc9VVXXY3TXTvTGNkqF
         KkD0WFobvuHQH1k/01K2z/DUMW0UCQGdr7oUHUY24+J3z4N/oXg0SHE/OE6FlTQMHVr2
         HI4A==
X-Forwarded-Encrypted: i=1; AJvYcCWtnX0TaFY9ucvkdkvrVOZxX97UMK4AZgNT3M/yVACyMoJq+sQp2tq+3y5HkHA4N/OaUUjnIUZPLsL9G6IFyGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrt+OkT5cDDdfsX9XohXsE3ISkehJ8RzpY1PMkcQKQ223rZpjt
	rkzsMY/c7M+Myb9ZW4Vdj4bj0Hn1MZJ/f4x+W3wJ/dsjZiKjt4hwQQJImTKO+TEqS+B7Lgn2XfO
	RqGi0CWyICUjTI+mYNQIK+fUznsfDLbNefOpuiZbO0JLp5cygUkg3
X-Gm-Gg: ASbGncvnL/UOhhPxs/FkF0bN1kNg8d2JHtCPNSE59/SdsFsnZ+IzvxN5gwl4UY++6RO
	/MfaDE0hvTmWGV+oZltVWDhKB1uqlNI7gn0phUUd/HDxNS7MxrRIAxPBxVHGcJOrPDaeCO6QRi7
	TSsHW0IqkaJEKSvdG90TkDiIE1BMIwdS3BwCmavhwMqTarnl8hnSFsj8Hny7D++uez6INkh4L/5
	4cVh7+cFtC8DvVb2Z4iS1Z6sW61/4XEHoOK9EGKafCDr1UtJ9IMVVbJML0QN9Bp1hEbCNk6jpsW
	AIfnlcdbPAD3xODdHXjr3/e2gWkxODyWzdJMMR2t9tTukIes56TM/+NGYA4=
X-Google-Smtp-Source: AGHT+IGa74cu98ZPyPu6W012ECueI7Hm4NVYYwlDa0a5J3DAoHe3e4Ppjs5ycH+FwgrMvaLiDgzM7paLxaEo
X-Received: by 2002:a17:903:19d0:b0:25c:25f1:542d with SMTP id d9443c01a7336-268137f2336mr2357405ad.36.1758069774981;
        Tue, 16 Sep 2025 17:42:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-265c4769cccsm8241155ad.41.2025.09.16.17.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:42:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 49A0334028F;
	Tue, 16 Sep 2025 18:42:54 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2DCDBE41646; Tue, 16 Sep 2025 18:42:54 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 16 Sep 2025 18:42:52 -0600
Subject: [PATCH v2] selftests: ublk: fix behavior when fio is not installed
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ublk_fio-v2-1-04852e6bf42a@purestorage.com>
X-B4-Tracking: v=1; b=H4sIAAsEymgC/22MQQ6CMBBFr0JmbU2npEpdeQ9DDIUBJiolrTQa0
 rtbWLt8P/+9FQJ5pgCXYgVPkQO7KYM6FNCOzTSQ4C4zKKm0NHgSi30+7j07gQalMZWV0paQ77O
 nnj976lZnHjm8nf/u5Yjb+icSUaCoOq2ULg1Rd77Oi6dNbAY6tu4FdUrpB7jjgMKmAAAA
X-Change-ID: 20250916-ublk_fio-1910998b00b3
To: Mohit Gupta <mgupta@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Some ublk selftests have strange behavior when fio is not installed.
While most tests behave correctly (run if they don't need fio, or skip
if they need fio), the following tests have different behavior:

- test_null_01, test_null_02, test_generic_01, test_generic_02, and
  test_generic_12 try to run fio without checking if it exists first,
  and fail on any failure of the fio command (including "fio command
  not found"). So these tests fail when they should skip.
- test_stress_05 runs fio without checking if it exists first, but
  doesn't fail on fio command failure. This test passes, but that pass
  is misleading as the test doesn't do anything useful without fio
  installed. So this test passes when it should skip.

Fix these issues by adding _have_program fio checks to the top of all of
these tests.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v2:
- Also fix test_generic_01, test_generic_02, test_generic_12, which fail 
  on systems where bpftrace is installed but fio is not (Mohit Gupta)
- Link to v1: https://lore.kernel.org/r/20250916-ublk_fio-v1-1-8d522539eed7@purestorage.com
---
 tools/testing/selftests/ublk/test_generic_01.sh | 4 ++++
 tools/testing/selftests/ublk/test_generic_02.sh | 4 ++++
 tools/testing/selftests/ublk/test_generic_12.sh | 4 ++++
 tools/testing/selftests/ublk/test_null_01.sh    | 4 ++++
 tools/testing/selftests/ublk/test_null_02.sh    | 4 ++++
 tools/testing/selftests/ublk/test_stress_05.sh  | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
index 9227a208ba53128e4a202298316ff77e05607595..21a31cd5491aa79ffe3ad458a0055e832c619325 100755
--- a/tools/testing/selftests/ublk/test_generic_01.sh
+++ b/tools/testing/selftests/ublk/test_generic_01.sh
@@ -10,6 +10,10 @@ if ! _have_program bpftrace; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "null" "sequential io order"
 
 dev_id=$(_add_ublk_dev -t null)
diff --git a/tools/testing/selftests/ublk/test_generic_02.sh b/tools/testing/selftests/ublk/test_generic_02.sh
index 3e80121e3bf5e191aa9ffe1f85e1693be4fdc2d2..12920768b1a080d37fcdff93de7a0439101de09e 100755
--- a/tools/testing/selftests/ublk/test_generic_02.sh
+++ b/tools/testing/selftests/ublk/test_generic_02.sh
@@ -10,6 +10,10 @@ if ! _have_program bpftrace; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "null" "sequential io order for MQ"
 
 dev_id=$(_add_ublk_dev -t null -q 2)
diff --git a/tools/testing/selftests/ublk/test_generic_12.sh b/tools/testing/selftests/ublk/test_generic_12.sh
index 7abbb00d251df9403857b1c6f53aec8bf8eab176..b4046201b4d99ef5355b845ebea2c9a3924276a5 100755
--- a/tools/testing/selftests/ublk/test_generic_12.sh
+++ b/tools/testing/selftests/ublk/test_generic_12.sh
@@ -10,6 +10,10 @@ if ! _have_program bpftrace; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "null" "do imbalanced load, it should be balanced over I/O threads"
 
 NTHREADS=6
diff --git a/tools/testing/selftests/ublk/test_null_01.sh b/tools/testing/selftests/ublk/test_null_01.sh
index a34203f726685787da80b0e32da95e0fcb90d0b1..c2cb8f7a09fe37a9956d067fd56b28dc7ca6bd68 100755
--- a/tools/testing/selftests/ublk/test_null_01.sh
+++ b/tools/testing/selftests/ublk/test_null_01.sh
@@ -6,6 +6,10 @@
 TID="null_01"
 ERR_CODE=0
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "null" "basic IO test"
 
 dev_id=$(_add_ublk_dev -t null)
diff --git a/tools/testing/selftests/ublk/test_null_02.sh b/tools/testing/selftests/ublk/test_null_02.sh
index 5633ca8766554b22be252c7cb2d13de1bf923b90..8accd35beb55c149f74b23f0fb562e12cbf3e362 100755
--- a/tools/testing/selftests/ublk/test_null_02.sh
+++ b/tools/testing/selftests/ublk/test_null_02.sh
@@ -6,6 +6,10 @@
 TID="null_02"
 ERR_CODE=0
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "null" "basic IO test with zero copy"
 
 dev_id=$(_add_ublk_dev -t null -z)
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index 566cfd90d192ce8c1f98ca2539792d54a787b3d1..274295061042e5db3f4f0846ae63ea9b787fb2ee 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -5,6 +5,10 @@
 TID="stress_05"
 ERR_CODE=0
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 run_io_and_remove()
 {
 	local size=$1

---
base-commit: da7b97ba0d219a14a83e9cc93f98b53939f12944
change-id: 20250916-ublk_fio-1910998b00b3

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


