Return-Path: <linux-kselftest+bounces-843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE4D7FE31C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 23:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B92D1C208D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 22:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D408D3B1AA;
	Wed, 29 Nov 2023 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="JeKeSyOe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FD2172C
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 14:24:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfabcbda7bso11540785ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 14:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701296686; x=1701901486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVpR0IvniY+kstE90A1PQqhW/E4iWnd4RrGkFh8q6BI=;
        b=JeKeSyOehWuZQMxZqJhUjXlcX8gEDi9WAM01N2txLoyvDZN5djgQfbU678Rs8w3HM+
         c60C59u7rBk7zBa9oiN4nYmnwsODoBF2wQAyJkrPcPwHWWC1KnZQDpDDpkd8IXK3G6Py
         xz2JXeT6ZMzIcjkgakWtm138KOAkyf5uJeTi8oR5/i2VAME7apQ3HaIH6dGsPAn4IdaZ
         1b70YlZpmbLXzjTip7yInfKOWf9Yl6M7dPnBIIIPQO+cmaBxTR+mgmBXUleOlYNnRaQz
         ADwbAKa7jIQzGbz5T9X2zOLhxTSkhSuFFKP9QbSQrGEchiIqUdFPowyuRb8IVF1rNPTx
         gupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296686; x=1701901486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVpR0IvniY+kstE90A1PQqhW/E4iWnd4RrGkFh8q6BI=;
        b=tKji4u5lq3rIF2nrgHYq40aNvM1nj3jARDyKScsu1tHojT3eqWiV3xXo+u9b1AYu3P
         dnB4CCG+DFrHBo6V0xuv8+koOA8Qj29g4A+FjVfbIkOQEtbH1O/vvgZzeN0a/bcEFbIG
         kmBcUlud1UH1lyBY2ade36ViStPw3y2eDKwR3+BcifQbrq1JXsCQEhuM5ltCR9/DZ2hP
         IztoE0x30ZXMPyn3Zu14+GzZRvH4r3rnik5Lq4kgIM75b9w7+fgJEmCCLrIAvkVyqzaQ
         xfKtfJWzgQU0KuCDfEk3fHXJlRaaQIYTG5o/B3VmLxRz6J13IYTKIhHhRtzZQqVLzsNO
         7jlw==
X-Gm-Message-State: AOJu0YyN5zezgtpbZ6FoPaT0HWiiyjYC8Po8g4Hhf927dSPcK2P6IzYg
	cSauq/Xz+dkXPUWohtiCS544Hg==
X-Google-Smtp-Source: AGHT+IFClV4b7JkVRjSMctCqetKwaxnf7eXFOh+Igz9VqrhJWsfakYYRWHRsaNBmBLlbn2kZMOnaGg==
X-Received: by 2002:a17:902:f681:b0:1cf:a652:471f with SMTP id l1-20020a170902f68100b001cfa652471fmr29761107plg.26.1701296686007;
        Wed, 29 Nov 2023 14:24:46 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001cfb971edf2sm8663697plg.13.2023.11.29.14.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:24:45 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/4] selftests: tc-testing: more tdc updates
Date: Wed, 29 Nov 2023 19:24:20 -0300
Message-Id: <20231129222424.910148-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up on a feedback from Jakub and random cleanups from related
net/sched patches

Pedro Tammela (4):
  selftests: tc-testing: remove spurious nsPlugin usage
  selftests: tc-testing: remove spurious './' from Makefile
  selftests: tc-testing: rename concurrency.json to flower.json
  selftests: tc-testing: remove filters/tests.json

 tools/testing/selftests/tc-testing/Makefile   |   2 +-
 .../filters/{concurrency.json => flower.json} |  98 +++++++++++++
 .../tc-testing/tc-tests/filters/matchall.json |  23 ++++
 .../tc-testing/tc-tests/filters/tests.json    | 129 ------------------
 4 files changed, 122 insertions(+), 130 deletions(-)
 rename tools/testing/selftests/tc-testing/tc-tests/filters/{concurrency.json => flower.json} (65%)
 delete mode 100644 tools/testing/selftests/tc-testing/tc-tests/filters/tests.json

-- 
2.40.1


