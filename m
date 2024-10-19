Return-Path: <linux-kselftest+bounces-20193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5838F9A4D88
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 13:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070F51F26F13
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 11:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35EA1E0B67;
	Sat, 19 Oct 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnKmWoay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A601E04B7;
	Sat, 19 Oct 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338748; cv=none; b=jEaUbJbEQVr1cIiVL5Hngc5IdGyODWCiOlKjD4hNkYdT21kyogSHl/MEdmejGxqmrCxSkgs+UvN4OJLHTwXaRKBTWTFOUGG5PkNG81dDiju2R6UJ9x1curV221B+GqwLpfyuYUrjEn9vIHdsuvmis6ORskY8dK5UAGT5SlpZ+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338748; c=relaxed/simple;
	bh=b7NVwrOnb2BCwyvcz8TEDalOhz7k0I5C6ajKPj0qW98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SF3Nv4P/LXoLqwasuOsOYYHFlGzyNjcWwEWJYrC5nFeBf1D6seB7V71HAigKc0pKWGTEskG5mFi0+XBNG7X9SrfXeYeToCOraktWu+H1xUeJK/urBaTjOefxkEbpWmw+QGkdqIs6Ok58e9QQG1u6k3al9ZeAs1w85Ppt+ojT8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnKmWoay; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso2332889a91.3;
        Sat, 19 Oct 2024 04:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729338746; x=1729943546; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcCobt2mC1z+TR6O67zCBK8k7nUf6ZEbehWixO+szIg=;
        b=JnKmWoay82sbZtMCS9piKcS1VseYvQwuDnrp+RwV/6ZbBHXdP0E2mfyA4NRgY5ORxk
         Th8lS+w1+0CpJseiqSuKWUU4chkOMOVxko8IweeGNBgN8Ry9MlwBkt1mjD+D9KC7cmd+
         CSAwrsZiML1QCwdkl1vsRJbOyFZOzPn4YhJ/eV0oseRzKBiX5+it0gPp2kOi4DVjqBTw
         BwBzHDJiRSfXiMt55oA4ggK8PXnSAO+WbWJfd0/4DcAQrLqz426LFIk5myXPMv3jUxlu
         qKA/qSLalkumhOWmnyIKLYfZEfUEC5uP6K5h0fRLFsyj0EoQ3E22wR/hEODlsAPiA9il
         918Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729338746; x=1729943546;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcCobt2mC1z+TR6O67zCBK8k7nUf6ZEbehWixO+szIg=;
        b=VydTk7Viy6a5Kyg6vDx5HuS0OpnWfKvMlqKaYTErOftUhQiGkwSj+YEgUF2Lv+yNKT
         34ekox23hi2cs7oHZCfLPsTzAwuJBCzZ2GS6Th+sD/uLEMYxz6mEXQ/mCdpxevV5FL98
         tiE6PSpiM2JipGaAMploHoPvrhqm/xV1CbO/pslxeSVU+udjuq8zaPSMU+sj3neahjAx
         L3LkUbFheJX0YLNOlSBNMNclKIeDi/kKdx2BNt6/69lZkWlZ4rL/6TAB5WnCPIzDCkW6
         8TG1N89BTfNh7qtRZdktQaKvHPJZEVU6hSqqRsLT1R8Z+qvYl5OvIsRbbEE68XHi8KsA
         f7iw==
X-Forwarded-Encrypted: i=1; AJvYcCXZvM2Q0q+1tpmdttcgYgjjfcoCJ81VdKamiEKXZo3ovue4reQcLnP+Cpo6CYac3h4OlNXuO3ShK+bj+fbnvVy4@vger.kernel.org, AJvYcCXkhnB/wleYrauaPLd2S8Rxd20ghto8i+EgEOxMyG13MEGTrHiB8iT27AwHPSJ/BcW893I274RIaiHq+0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+TVEtYGu94MG9y1RqmItGEhEynfK3ZYbCQJnYTOAHr3Y33vow
	/ZeOfYCrUI7Mk0JOsQmOhspZey3JtrHd3hFEsj/khbVDsVMrUyNH
X-Google-Smtp-Source: AGHT+IGr7TDoDZLZABzVodXS3kaumggPe/3qcRR5CFL22s1nHdPVZD8j+8SAtq9XqlCimG4JaBSK5A==
X-Received: by 2002:a17:90a:986:b0:2e2:d15c:1a24 with SMTP id 98e67ed59e1d1-2e56167f574mr6476351a91.23.1729338745837;
        Sat, 19 Oct 2024 04:52:25 -0700 (PDT)
Received: from Emma ([2401:4900:1c96:190:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5611d4416sm3907065a91.19.2024.10.19.04.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 04:52:25 -0700 (PDT)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Sat, 19 Oct 2024 11:52:21 +0000
Subject: [PATCH] selftests: tc-testing: Fixed typo error
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-multiple_spell_error-v1-1-facff43b5610@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHSdE2cC/x2M3QpAQBQGX0Xn2pbdZOVVJPn5cGqxnUVK3t1m7
 uZi5qEAYQSqkocEFwfetyg6TWhYum2G4jE6mczkOtNWrac72Du0wcO5FiK7qLI3hZ0iyC3F1As
 mvv9t3bzvB441ahhmAAAA
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
 Anup <anupnewsmail@gmail.com>, Karan Sanghavi <karansanghvi98@gmail.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338742; l=4399;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=b7NVwrOnb2BCwyvcz8TEDalOhz7k0I5C6ajKPj0qW98=;
 b=BlyI5J3X1LqLKvIWVA3maYCsIRRglafKpwm/auGhgCrwsbvdUdAFdImyxM2YNILQY1cVEY7v3
 UoyVldmqCDHCZ6KrQyI92OU+aOn5usrMUDwRbuMZoKYSc/E1Vix/20N
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Corrected the multiple and different typo errors in json files

- "diffferent" is corrected to "different".
- "muliple" and "miltiple" is corrected to "multiple".

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 tools/testing/selftests/tc-testing/tc-tests/filters/basic.json  | 6 +++---
 tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json | 6 +++---
 tools/testing/selftests/tc-testing/tc-tests/filters/flow.json   | 2 +-
 tools/testing/selftests/tc-testing/tc-tests/filters/route.json  | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json b/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json
index d1278de8ebc3..c9309a44a87e 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json
@@ -67,7 +67,7 @@
     },
     {
         "id": "4943",
-        "name": "Add basic filter with cmp ematch u32/link layer and miltiple actions",
+        "name": "Add basic filter with cmp ematch u32/link layer and multiple actions",
         "category": [
             "filter",
             "basic"
@@ -155,7 +155,7 @@
     },
     {
         "id": "32d8",
-        "name": "Add basic filter with cmp ematch u32/network layer and miltiple actions",
+        "name": "Add basic filter with cmp ematch u32/network layer and multiple actions",
         "category": [
             "filter",
             "basic"
@@ -243,7 +243,7 @@
     },
     {
         "id": "62d7",
-        "name": "Add basic filter with cmp ematch u32/transport layer and miltiple actions",
+        "name": "Add basic filter with cmp ematch u32/transport layer and multiple actions",
         "category": [
             "filter",
             "basic"
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json b/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
index 03723cf84379..35c9a7dbe1c4 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
@@ -67,7 +67,7 @@
     },
     {
         "id": "0234",
-        "name": "Add cgroup filter with cmp ematch u32/link layer and miltiple actions",
+        "name": "Add cgroup filter with cmp ematch u32/link layer and multiple actions",
         "category": [
             "filter",
             "cgroup"
@@ -155,7 +155,7 @@
     },
     {
         "id": "2733",
-        "name": "Add cgroup filter with cmp ematch u32/network layer and miltiple actions",
+        "name": "Add cgroup filter with cmp ematch u32/network layer and multiple actions",
         "category": [
             "filter",
             "cgroup"
@@ -1189,7 +1189,7 @@
     },
     {
         "id": "4319",
-        "name": "Replace cgroup filter with diffferent match",
+        "name": "Replace cgroup filter with different match",
         "category": [
             "filter",
             "cgroup"
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
index 58189327f644..996448afe31b 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
@@ -507,7 +507,7 @@
     },
     {
         "id": "4341",
-        "name": "Add flow filter with muliple ops",
+        "name": "Add flow filter with multiple ops",
         "category": [
             "filter",
             "flow"
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
index 8d8de8f65aef..05cedca67cca 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
@@ -111,7 +111,7 @@
     },
     {
         "id": "7994",
-        "name": "Add route filter with miltiple actions",
+        "name": "Add route filter with multiple actions",
         "category": [
             "filter",
             "route"

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241017-multiple_spell_error-8b267ffffe47

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


