Return-Path: <linux-kselftest+bounces-3469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA9C83B0DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D107D1F22FEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9358812A168;
	Wed, 24 Jan 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hKZTYt6z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D67F7F2
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120391; cv=none; b=bIkZyGB/goyxQHoPQ7+Gce3+f0QENy7uJK1pEuFONChaWWtNE7zw9P1loVTZ/qW8PxikyZFZCaIxLDwujFuY5NtXQRlpsX34Kz+VJW84qnTWFK+2Li8D7Zm/os+cXiYQUpqD+vs4nnPsTaojgbLmnr+qtos1YgGPVr/TUi4jB24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120391; c=relaxed/simple;
	bh=2SHR9FJSHmpmQEnrTkrOd4u6y8dYPE+jYTMnavJVZ10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m0Ps7krfKCnvRtC8V7WeasQjLBekGQuDp1BBk7K9dtIlYMAPhQkkpCpuMkbZfw8vn5YaFPzGQOBvS5WqVk0wj6+f8vJ4EEd78S4DLVn5PlSIhtB9S2zrDV7+XJIo0TrWNqobeWyVXbDqPC7CkaRSOOSs6qo5UFJJBEuSzmoN4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hKZTYt6z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d730b6943bso20349205ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 10:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706120389; x=1706725189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LilT+84arpVB7ic1mUnPbpXL4IkNHurS4WyyyTTg1s8=;
        b=hKZTYt6zd1XDaJSZYZJKM2A2cDEWUlA1qhZZja6gdTm8/549zP0fvZpGen8LLU6RTB
         gbFRoS/X0GJuHz5lkBeisFTeqLlVhtP2i2hp7fTVfeYkuksOlBoOmESeEXJTWiX5zSS7
         MHF+UdIhEAMAZaHeaxpQhQYChvPk3dQUHDivbD7Oj3FWTgDu6fwBObOEnt726JB/AHWj
         kBewwlOzC9RCybLZExxB85vkE3lkQGrIvN80KpxIV2CVIH2ZZr2V7xP7O95UQtaX3cJh
         1DO3p0tnFtjnsIJlQeLPF8MtCApd5JRL/r4TkiTzyBbvdmx4l9KLicAZUrFXLEG0Wv9t
         ajXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120389; x=1706725189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LilT+84arpVB7ic1mUnPbpXL4IkNHurS4WyyyTTg1s8=;
        b=FDWbvmkeDAiphPemFwoA+9yErv0Bx06nLfvB/27qsRaIHoVLObszs2CoxWtNPr6j9S
         3xjhN+PPcmM9vNwXe97n9wFT3jjj2tnmVcl6lFtedSpRaV/KFKaVjNKi4lToLvZ4vqoG
         Sx5zGWRdJ8xZFNjtppZzlST6L8u5mEORz6/w2nLxFxy6L9XypP6TI+/97c5KMJf+qMX3
         cP4ccsqRc17IcgQJrvIlOj2l2KCxE2Q79ogfoPFdKutDxMB+8lbC2Hj1eo+crMecv32j
         nmX1gMAHpd2cd9eRI6VByfRyF2tQSswasfKg5s7VLzNDCq53MxekL2A0FPMqk4K4/cfl
         PNVQ==
X-Gm-Message-State: AOJu0Yw/3P4jVwyqe9bQRwcbpV9KtWSj+Gz7XchfBWDWWt1NglkO/3MD
	298QS0xvyQuMLYoVeUl8kDPwOSa5RSWN0CcguyBgdZIKaFTYVlAxzY6Py5ibiw==
X-Google-Smtp-Source: AGHT+IGO5NziFeNJSMCoCa+lcUVWrD168W9To4nBZxA3JZx9FvVHotwTH2Sbg9XaZeYWKNY/dOBn7A==
X-Received: by 2002:a17:902:b414:b0:1d7:7811:625f with SMTP id x20-20020a170902b41400b001d77811625fmr801875plr.7.1706120389288;
        Wed, 24 Jan 2024 10:19:49 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id kd4-20020a17090313c400b001d74ce2ae23sm5577084plb.290.2024.01.24.10.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:19:48 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	kuba@kernel.org,
	vladimir.oltean@nxp.com,
	dcaratti@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 0/5] selftests: tc-testing: misc changes for tdc
Date: Wed, 24 Jan 2024 15:19:28 -0300
Message-Id: <20240124181933.75724-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1 and 3 are fixes for tdc that were discovered when running it
using defconfig + tc-testing config and against the latest iproute2.

Patch 2 improves the taprio tests.

Patch 4 enables all tdc tests.

Patch 5 fixes the return code of tdc for when a test fails
setup/teardown.

v1->v2: Suggestions by Davide

Pedro Tammela (5):
  selftests: tc-testing: add missing netfilter config
  selftests: tc-testing: check if 'jq' is available in taprio tests
  selftests: tc-testing: adjust fq test to latest iproute2
  selftests: tc-testing: enable all tdc tests
  selftests: tc-testing: return fail if a test fails in setup/teardown

 tools/testing/selftests/tc-testing/config                      | 1 +
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json     | 2 +-
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json | 2 ++
 tools/testing/selftests/tc-testing/tdc.py                      | 2 +-
 tools/testing/selftests/tc-testing/tdc.sh                      | 3 +--
 5 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.40.1


