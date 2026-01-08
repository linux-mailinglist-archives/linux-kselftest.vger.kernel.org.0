Return-Path: <linux-kselftest+bounces-48466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3966D00D56
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 04:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48707300486B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 03:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE66B290D81;
	Thu,  8 Jan 2026 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/dXpBx6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA628C87C
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842232; cv=none; b=tgtT2hZerVq/JqgHW4/OaWe0OJQ2ktu5SLAxD+ZHJwebKN5IjhNYdMrFlsAa0Gn75EYS/fZRU80URJBeeW3a2scf85nItsKGiyMUi7Y0KNe6lGH4ySRJ3cJdNPfWMuLMOB+sMF9/lcYbTbpvDJoWZZLNo6tAoy9pkaOXrYnCCNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842232; c=relaxed/simple;
	bh=m/P0rildx+y183ndtVmRLR1JNz17OTunVtyvraPM0LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGAy1OGY/iYS6Agdrcr9HW1oRLcCrPbaD2ucgiib8ECo2x998BM5U+szeimvuvf55F9AVMlcHtn33ApfGolCwv8AG33idkTAt4vXIbnJssic2OIzJfcz8z0Q+SMObzaISvo5UzG6C4bYJ6iWlPfhGVdU5qhTb2ByD2oX4hyYh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/dXpBx6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29f1bc40b35so33021815ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 19:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842231; x=1768447031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tltITiw95/9wtf2NIqRzgqZ2v8zq5SZjH8mYyCvye6E=;
        b=I/dXpBx69IMBRyEet7OAjy7Zxq4AvIibo4l/X2oVBa8QgFxW0OI8Ky0HQl4wVI+yl2
         oZK7F3mAQZ5iHDAX8UGoxL+t66mBuq5LiGNaT4vUH49G/U+aEnbudJkqiHZfgx8DWgTq
         6it/lyjbIZcu1d0NnuTfDfFZO+aM93Ix/MIovbgTXFpGhEDxF40DAuA+5pg7x7vWNPHF
         +kUP33uLRs5TErtpHbJFEOoVuCHyY5eKX6vbio7V604kr9gZTdUsp2XcAp380g9xk4xi
         8fglUXITUWalXAS7y5WEXEXw+gRZ8jEcQKZCC9aSt65FzwFFhBg2fySvhps3ZyhbHid5
         rvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842231; x=1768447031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tltITiw95/9wtf2NIqRzgqZ2v8zq5SZjH8mYyCvye6E=;
        b=pE+quT7x67tZeG3d75xTaOEH5hYA5tHDWNPU2XU1TJJrhsIwcRYLKQxhMVoivBxQW9
         E7dQHwj87oH7mJ4NjGXoKqU2Heoa/ZFgIL4xAUe25d8UPsU8TQ3Z8/RR2OfaGY1qoSH6
         87wpI7HHVifEX9X/Z6Ns1wjpwYtgwQ/mpKL94cSbUWvx0e/QcEiqe3GoU7zMm+dM7Akn
         n4kOHi64Qh/G4A8RCeYZb0wf6boieDkPsLTY4F8EYbJ6TyLYfd7IY0VTilcMakoLiMwV
         mSQ9gaHiuwLR4ahSC8gN/+2h1pU/wNxNWLMtVvSHpFP5JhS5BDaXtHWQ8rIo/uYM9nwL
         TKjg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0b02uTr6QGI+eWYNbbQlEt1h+AzrkICqDl+Ls3wjpRPnCAid9o1xvdDAtDd75ZyPw8s16YUsQtodnHqnjPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4yrqRa02du/xH/RhbhStJJa3Odt4appcUtsiIyWIwhqRKviIq
	mwSX0ZPrRUZLV+wSHT0jV4nV0+0bKg9S5iOrBrrNM3oi53/iPgWT3yRo
X-Gm-Gg: AY/fxX58RLCaGfzXnoow2QT8f0YMQiSZMLHa46/pHE1+gs8Nzwa8R2zhdSnCULTXxvI
	hkQBTzqHDXLwWCpMM9eGdnGcSK3RlsUsdP7QQU9JtLy3bRkLXvjht9LH7SF5QX/uEWkA6MY4csh
	1C1U0ZsvmmimbrlQ46hWtq/kgbU+RV44Wdx4e/uv7VxvSrhWB0wg7aw+UVYKTTp6EBbp91eTqtH
	6c68XnLDRTH70PCojWipcAWrXxYut4IrHnGBXeJpn75JJwdwWwBTbk6tejGL8mQVQTUUsKCjxsN
	ksRb4H7nh+T+831U6tKqG26jPu5cPhXlr60nO4WfImKArCTXvpNX3EEmVWMcYyfZuTm5MBDo0MZ
	HOcnqsnEXpY4gR1FrrgLsD2XVUG6KvtBKZLPqnPwxSEupl1i07wwq3ygQCRPOiXvQxM5JAKqMKu
	driNylu7NjtJ5Ug8z/MBpxn5LBeabEBDU4Uw94YV50otESWnQ4sU/ygoB8M0CbCtrcC81dWc0lU
	uPgawcLtkE=
X-Google-Smtp-Source: AGHT+IHrccX18hWgZN+cQEN8AOL+ajDQdYrjJ1ODhl4Q40AtMXaDPEaPREbLjSfBXOA87RJKcpynWg==
X-Received: by 2002:a17:903:3c27:b0:2a0:c84f:4124 with SMTP id d9443c01a7336-2a3ee4b4f21mr46877445ad.52.1767842230664;
        Wed, 07 Jan 2026 19:17:10 -0800 (PST)
Received: from u2404-VMware-Virtual-Platform.localdomain ([117.71.53.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm64031255ad.62.2026.01.07.19.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:17:10 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] selftests/mm: run_vmtests.sh: fix relative path handling
Date: Thu,  8 Jan 2026 11:16:04 +0800
Message-ID: <20260108031604.12379-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_vmtests.sh relies on being invoked from its own directory and uses
relative paths to run tests.

Change to the script directory at startup so it can be run from any
working directory without failing.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index d9173f2312b7..74c33fd07764 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -5,6 +5,10 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+# Ensure relative paths work regardless of caller's cwd.
+SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
+cd "$SCRIPT_DIR" || exit 1
+
 count_total=0
 count_pass=0
 count_fail=0
-- 
2.43.0


