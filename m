Return-Path: <linux-kselftest+bounces-42048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51CDB8FB39
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 11:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4613BF59F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EE0284892;
	Mon, 22 Sep 2025 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6ZOOOpn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326D224D6
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532260; cv=none; b=ow3rE8HN8pomCrACAfZQGlLuEr2v70bCiM+sqOJbhnkbPAOkVp1jd/8b4RlpeSIrQcL202cssF5FzPovYRUJMBXMdyBMQlb+Axrl9o3PM+uot1Xrgqvk8ZYjEkD0H6RI//+b+IePYLKLJbv7HROqA0OUkUrYj1y/GfwVCGySaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532260; c=relaxed/simple;
	bh=t55ecTqmrNR8pRq7si7fT2qybwnmjw3prAlly92kfiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5etLUFVgSuPNY5cnm5Ugy2dnskWMc4w/2j6XpFSo1Y5nSEHHGd/ljK/YyVLlXMgzFIVQ0FpauldVv3NHPs3lg3W/tLzWcJPV8JF7x/DATTHs8X3zHpfe4eDXRvA+rzVGrngg4jZzcMi1LGcI2kRMv72HkSdhfMOVGqHkPM2oWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6ZOOOpn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f3405c38aso697974b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758532258; x=1759137058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyn8ad9UA4c5mQKVC6pbDxbJmyFUn7gmW4IP75tq2Qk=;
        b=O6ZOOOpnI6uJXh095LyaV/bOJAEP2ENUT4HiJpLDZ8w/+9tN5o+ksl002TF2ynP9eg
         kmMpfEOruJXxSnUpcEglVOj8nO7bfu9yYUpGy3r8vA4hmHoU0EF4gw9D2aJAhwIwQhiq
         zm9f8LNjwi5NMpNJGVrn9fmd+MssNhF3HixmKX7xJO9QUEx0Nrl9V3x/IVXKPatoWMSO
         SBNY5sFkjQ4sWVOSOFHTw3v4LFyqtuFMptbj7v6hrXQb++ddKPdFTU1gRcCZKh47vEpb
         WrYVRFbwmn5ESj88vcy5hDxb6lxKvPH+MpiaQYhEH3NQLm5eO02MNv8JAcKdKlfpjvUe
         2N0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532258; x=1759137058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xyn8ad9UA4c5mQKVC6pbDxbJmyFUn7gmW4IP75tq2Qk=;
        b=t/lMPiLJSXBkM7/g7t76C0RCBIoDhtBLhDu8F7i3JX2cSgo/1g4oskAM0/SoVtNima
         lwjf5k46dp1A/J3rezWa5jNE3izp7FsrXJG5TZFk1jx4lufx8U7eJsdusPg3XKA4qOKO
         sELZ4Ub671P1QgRPW0xEK9esRJZdmMU6MmqwsYTyUCFb6xvNpAMHlO3RLPlrvB3vAMnH
         TuAuskIx0aV3MbJVQMDphS8MMRkTIm47klQKon3BrmIJDDkeevaNdhdJLC6aHCMq/Jiw
         00fiTYG4ACSsWzBmTYgOwW+6YMzxTxPbnGLb+TKnbmNmyCYR2gVAQQGVkTcHmW+1PtVe
         xwNw==
X-Forwarded-Encrypted: i=1; AJvYcCW/J61sNw1iB7xvuBoZvpnLec/CwodNl5mN/FTVWiexupt+yISJXfqU7nL+cB/v+6IdR2/uQilokP/2TUzcJoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvfw0zHf824/OUBIrP78XFOfDVD4EGI6BxRP34fN9bzCdpk+a/
	urbU5MyjXaYlTXg7c3Br/0NazOONMQwYEno6BzryNeMaL/+yNiR1lM55h34FcxUe
X-Gm-Gg: ASbGncsf5wjoWgBaLYEQ6su+d8QNXjbvts1nnwUkSWMjxqGjrDmWSll7cEhRVsuz2jF
	yeIttXGPhxc7PMGzu864SiJTAas1a5zYLbZ2myBUXhoSqAXIpbiZXIF43MHK6TqXq1ecYIB/bjn
	/C9K0El/f+MCsXGfb7F1ZhiqsgirSwEOxYFFH4gxAtcCuhhaRYU/n21Nvz3na+76yE4XvgJsiuO
	aJqRqdJtcbL+hHv9btVKdQ3ZLavLhzlHuvqL8gMKxO8ICCS5HFfVtH+AWlGWJSmb7T7blH3Dx/6
	6DlSno7xDr16MUgyK/57sYaEpC3dnpbn+giaGJDgPGE2XD5rAV9gN5GzG+G/dCzc6L8P82xClTS
	XIw6ibEK39VPbQgorJIe6VpKl
X-Google-Smtp-Source: AGHT+IFywvuV6sf+8L28eCngThE4JSpP1kQ056fqUT9xEvnRoOaaMQ+9VfNKwtFq9Yq4w4biAlyygg==
X-Received: by 2002:a05:6a20:9150:b0:24a:a45d:7a32 with SMTP id adf61e73a8af0-29272a5daa2mr16952132637.45.1758532258093;
        Mon, 22 Sep 2025 02:10:58 -0700 (PDT)
Received: from archlinux ([36.255.84.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f4190cc8dsm1393548b3a.2.2025.09.22.02.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:10:57 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH 2/2] selftests/cachestat: add cleanup for leftover tmpshmcstat binary
Date: Mon, 22 Sep 2025 14:40:42 +0530
Message-ID: <20250922091042.149117-2-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922091042.149117-1-madhurkumar004@gmail.com>
References: <20250922091042.149117-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some kselftests generate temporary binaries that are not tracked
by TEST_GEN_PROGS. Add EXTRA_CLEAN entry to remove tmpshmcstat
during `make kselftest-clean`.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/cachestat/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cachestat/Makefile b/tools/testing/selftests/cachestat/Makefile
index 778b54ebb036..c48065d791a9 100644
--- a/tools/testing/selftests/cachestat/Makefile
+++ b/tools/testing/selftests/cachestat/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := test_cachestat
+EXTRA_CLEAN := tmpshmcstat
 
 CFLAGS += $(KHDR_INCLUDES)
 CFLAGS += -Wall
-- 
2.51.0


