Return-Path: <linux-kselftest+bounces-31361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF09A97A93
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 00:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EBD3A727B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 22:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2241B270577;
	Tue, 22 Apr 2025 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/g49wdH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB31EBFE3
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745361471; cv=none; b=OtH6zcLpPJvhSscIeA5S+18M01HzB3/j455hvJL5YJ/PiDnOOGpPNjZO+X00KiKgi1UOS/XjCmOUv1Tl2WTrhj0SlXBLFZv0yW0rp4M/cOasa1E7HO5CimBX4hD/xCM5hJIPHNPdjKN9HdibzHIBsChUcLTsWMi2xC7KDCRMzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745361471; c=relaxed/simple;
	bh=c76CTCwwGHjrPlAt2M4vqt5K3rtWhVxg5mZ5se/nyJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZapFD2uRMMmtcI6V7mKw9RqjMH72PdtkKNRTvETDy3TJ6fZebZdUQhwF8cAgdmdIehBXI+OnenAUkozYbXmPNb2LHPPAHHaui1Cbt9qpQYTIb76S4w7TsfWmNNO2lBT1l6Gz21A4tSrIZ8IcHHqWjw62+kwNhgKG5lYZKNsG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/g49wdH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-739be717eddso4447352b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745361469; x=1745966269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=muAp7kvxG623udCdaGnyCztPlrCiwXOLUw7zKbCImSQ=;
        b=B/g49wdHTd9ACIT+BrC+eQ5ofGkCjYC4teihd3Nc8XOoAyCLFxRXXMfBHT6gBbGW1B
         rR0TjZRC05YYKwZ0rYvF8RcAAxePciIPFruNdcqRXznnnOT0nc7M0XhpT6kpgZMzOlZ1
         e7QmgzmsXk1tZoQcwz3v2cmQzD5lvJxT06aOZ5g+lMswz+J8ovLKgtUDctxtqj9TbmGJ
         /8NbpJ2pPCHyQA/ItkZIzLZOHClmDgawgY8mXVNLqkHUbItCn5fgckPvp3oRRvXwfXJ7
         gA+K5eESMiKG/ZowrfewNnuZC5uQKsLlEhh+VfjUd1+hQzDI0jWFH3M2ulMWpb543UiC
         IfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745361469; x=1745966269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muAp7kvxG623udCdaGnyCztPlrCiwXOLUw7zKbCImSQ=;
        b=ddB1IVTHOeII8mj07Tl+gVYPGkwAwCJmjfyC00jh5A4IDGoVpbKDKBNy6hz8ttxzA9
         mYu5qENB2jX41pPzfHAR5SJXk4yY3lUuUSbfn7B49X7k5hRbmCDX7l0RXdCE/zQrNSu7
         HCcJp8Wy8gEw5uM/MSJL1EVV8R4rrfZrEbCOXGXGFCHHLXbJBraqUfDQwd3GcQ/raSzx
         JIC//Vr/Ad9LE2yiE/po6PTgBuBn1HGn66Rv57j9DNhEjqhQzW2/9qt3YpeXiX36k6/8
         8GP5sTlI69hBNeaVxQ66UK+wz+RptGnfU9IWSlnGjP+SG9IQ4RXp5Ub1w2Tc3LaoJwLy
         f1iQ==
X-Gm-Message-State: AOJu0YxreZJIJ+Js39tsbxVNEEQA5W7Asunml3Oy8p4cyM4GfDk4WrvJ
	8PF2q8k2iWCFDcDqb089Sn11CiwQ4J7Yjkzso4PvssVrqN1x7YY+
X-Gm-Gg: ASbGnctatQs4xEvvE0cfloQJ7QZXqFIZrUdyW/znwgAn6ysmw6hdZADJUzoYSziYbE4
	dk2+uUg9qydj2YqXMnwCSFFgvlEo3AAwIPFz4a5pgMa8iLqGmemKgW7o6DgCxanb9CG5Fb3PN0M
	7JGXSsh6aaDLiaQ5N8a6z1Soais0MlKb0jsRJRuYCcmyXbCG/Vk1taZGY8PsA7LGTlmZK4xzcWg
	bOvB9EIl01NOHXupnvZ3qjadm6PJSXF/8HIn0G4Zrb2PAEliIrld7J5tYjZsgdaT9F0TzvQpMwc
	PCbP/FuLgga5G76f1ZaouCcbMhyKpTrhs0vQAovuxg==
X-Google-Smtp-Source: AGHT+IFKj4/zEDBOObu4VQRwy8oPG0mL4zsEVOUojuDL/MUGAvM35VpEwbg5L1sk61zzmD6HkIxmwA==
X-Received: by 2002:a05:6a00:66d7:b0:73d:f930:cbd4 with SMTP id d2e1a72fcca58-73df930cbfdmr8819543b3a.4.1745361468817;
        Tue, 22 Apr 2025 15:37:48 -0700 (PDT)
Received: from dev-machine.lan ([2605:59c8:c4:cd10::1ef])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e4912sm9516879b3a.60.2025.04.22.15.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:37:48 -0700 (PDT)
From: Niko Nikolov <nikolay.niko.nikolov@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	Niko Nikolov <nikolay.niko.nikolov@gmail.com>
Subject: [PATCH] selftests: pid_namespace: Fix pid_max build with missing mount header
Date: Tue, 22 Apr 2025 15:37:42 -0700
Message-ID: <20250422223742.16511-1-nikolay.niko.nikolov@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add #include <sys/mount.h> to pid_max.c to fix build
errors caused by implicit declarations of mount()
and umount2(), and undefined symbols MS_PRIVATE, MS_REC,
and MNT_DETACH.

Signed-off-by: Niko Nikolov <nikolay.niko.nikolov@gmail.com>
---
 tools/testing/selftests/pid_namespace/pid_max.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 51c414faabb0..972bedc475f1 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <syscall.h>
 #include <sys/wait.h>
+#include <sys/mount.h>
 
 #include "../kselftest_harness.h"
 #include "../pidfd/pidfd.h"
-- 
2.49.0


