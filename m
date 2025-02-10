Return-Path: <linux-kselftest+bounces-26189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAF9A2F29E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 17:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BF51883AD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D224F588;
	Mon, 10 Feb 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrXTm6rU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E1B24F58E;
	Mon, 10 Feb 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203889; cv=none; b=pEstUkwQ8TVRX702GKMbbnk/GuuGugbsihw39V8tNzExrD/XwuA0pR7LVp4exniRLCgxvA62czYKCKbmyQnThSWjFfX+bJHYdes/rDIvXw6h6BOKgdiKIaohtRky6bmawa0MvGcO5hxl2yEUXrL6lXRO9FZbLKOxcsMK49z4Up0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203889; c=relaxed/simple;
	bh=Ju+jLIC+hdALWDNfTRKoeZW9qn5r+NTUgbFhV/yjG5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujZJacQEyiaEsccjCEu2dyB95fYTIIyrxRDAraGPopI5fSPuQaqwqO1GpiYaLPTL0wOdoAoDpgj0MT9gVRZaj4/AzyfDQAziPykUl3GPdjpQHrW4LucDBFLEfju049WmhiLUV52QT5TPMJ4ByXSZlfnysBOn4ZxHARYTr9q13vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrXTm6rU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f62cc4088so45226985ad.3;
        Mon, 10 Feb 2025 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739203887; x=1739808687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lt/TBqL493WxqFjgvfkZ2tS4krtyuV+0wcigwiXRZIM=;
        b=nrXTm6rU0YgVlCbv4nn8RE9ZJXHcHGM0Ax2lnDYWix7c5tQynmMtMUqq7/oEI5qqdY
         pK6clt2aO9nu0NBBsKCgbk1wDpANIAdaNCssmJ8aZSpAsetdCb5QzwcvXazGWx2L/dPP
         UY9ExkGkVdjsCHS3kzVa7yLuaYIVHCrsxHXfTA1Dn2gf8AoP3PJU/zUHwq6Ri50y6eoT
         q++GvJk/q53xt6lR7vk4TH+an96wX61w2o+2TlYfia3bt5TP7cGKp9y/qc5ZC6+36dlx
         XVpsusIW4kGCmp7RKxKEFsD9nZMTWSmKzje+BMUzds/2o1Rlo4/zuEVYRJE5pbw4+vF9
         DSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203887; x=1739808687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lt/TBqL493WxqFjgvfkZ2tS4krtyuV+0wcigwiXRZIM=;
        b=Zq20xygWUjjmLwo3IUasS70jqgpvg5HTw+//kcJX5YNvlg0S6YmlX0G/cNxOdc6HHz
         58aNq1WDDXCh0maJld+DEMUBm6e+TN6fGxi24QdEPGUZpUlfl4YBM17tt1SANpgOxW92
         HqwL4BOX9ki3UNbyvkQ7ONVIDZ07+W4XSSHZVLxfl3F4qYwUV+rMNKYJC4YrR16T67jX
         Avh9eUJqwD5+OhjbEg5GK4m6FSKdKskL1PbZXHDBWEwXdsRtDWT4acSixeN1cZP1kySA
         8uBlGjXPamGg+FSKtnJ6mPWtgQY66XxWfVvmuuYAn82aPXYWoDyhweZfiYa2iuUzBMat
         VbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU//gfLljOI165jkY1MtgYeeLIZEXaK4rq/o62i+IIb+kPCQy2IS4D+jwInIQ1DhjVEt4/f5QFg7X5qI9ze74Klsp8VpIaR@vger.kernel.org, AJvYcCUiCv5CZWhWsW04IngWemx/7tf32yGbzsQ+5/UkM9opnqY7GcA2jJmxHHTCldJy6uqnv5a0PXAZTX48DJF/tdEn@vger.kernel.org, AJvYcCXNMxVyvHxtwwIpf3gc2CJ6V/7obEtH4OQ0/bCZMS0q/KEdHfG0ZzvFn0bKWsb0CvEEIsAp5FObEnADTME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVNhCF2k/bDnwllHUHpsa9Ryc38KzpI+V6DclR7ToRSQsVoWU
	GzaxYiAMrJs8rdzvY9gctvPrJD+P23AS4epGMF5j00Rs8gGfAGBs
X-Gm-Gg: ASbGnctsx2QD/QA0iKAXbYFH4cBOkBZpju+UR5LaFCQBKMx8di4OM+aRBQJQfn3Bgo3
	17/40TdXNejGj1VMS47QB4czi+uQKpbtigLzcYKDrxvmCUqOb3v5uu2aBu2VzHnyMo2G7k+lywP
	zS2dY4OZXSybrhRoXSmZ8NN+lXlIwFyfN+0YuYrHahn20TuHjcZF03hvDjwOBnyADs09S8DriG4
	wbt1wYbcaG6nBIpGF/V6E/bz4CjN8V78ySMUvi2R0K4EFVh4DXhH/eUxef9LHlILu+FUBuC6jOd
	82dH+IJ1e7kyyiph3ls3J9I=
X-Google-Smtp-Source: AGHT+IGBP1tsRARuyphuA4dc3+m2aWSwlcSZROST1syG8GihtPtpjMQ+VBiiwMW4vsoTibNHhabUyg==
X-Received: by 2002:a05:6a00:148d:b0:730:97a6:f06 with SMTP id d2e1a72fcca58-73097a61364mr3937341b3a.8.1739203885416;
        Mon, 10 Feb 2025 08:11:25 -0800 (PST)
Received: from linuxmint.. ([14.139.69.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73083c1f029sm3022516b3a.125.2025.02.10.08.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:11:24 -0800 (PST)
From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
To: mic@digikod.net
Cc: Bharadwaj Raju <bharadwaj.raju777@gmail.com>,
	gnoack@google.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] selftests/landlock: add binaries to gitignore
Date: Mon, 10 Feb 2025 21:40:57 +0530
Message-ID: <20250210161101.6024-1-bharadwaj.raju777@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the test creates binaries 'wait-pipe' and
'sandbox-and-launch' which need to be gitignore'd.

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
---
 tools/testing/selftests/landlock/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/landlock/.gitignore b/tools/testing/selftests/landlock/.gitignore
index 470203a7cd73..0566c50dfcad 100644
--- a/tools/testing/selftests/landlock/.gitignore
+++ b/tools/testing/selftests/landlock/.gitignore
@@ -1,2 +1,4 @@
 /*_test
 /true
+/wait-pipe
+/sandbox-and-launch
-- 
2.43.0


