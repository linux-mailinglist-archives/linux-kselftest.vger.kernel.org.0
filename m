Return-Path: <linux-kselftest+bounces-26724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63413A37233
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 07:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C51D7A137C
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 06:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2337DA67;
	Sun, 16 Feb 2025 06:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZn5QLWc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A2367;
	Sun, 16 Feb 2025 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739685728; cv=none; b=N51vp+h+vkbPJrU8/wDiN1wu6KGrSr1eCSPmpUFEumStKcnjaq1rUA/6LcCeb8LW8OK73uirA21AsOU3htIRXkOkIBy1pdnylqElGxisyLwr4uD/bNf/NrBq4ct7iP/SHpb0Bm6Gury78HBi6xG+Yz9PWz3joEflmnNP4/8TkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739685728; c=relaxed/simple;
	bh=hcjsDuh0U0A8LjyDBKt+IPLeJ4woUgRCjbuicyVm1UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVQXfHTbSUyo1kshYBG8KQ8n/SfbSSKGxYOH6CitzZB0/Ooryp26FjaaRWGprW73DoG2PgCjSpq6BaUpw5291ryubs1XZWS+TFPU/ptPsRh29s47FF/vQwBUW1jp2KZOm4i26rqsiXioZu8ITXKaMTht4DSvkIo8LWR3A74MHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZn5QLWc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22128b7d587so799025ad.3;
        Sat, 15 Feb 2025 22:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739685726; x=1740290526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JA+U6KzuA4UAyNmQvUy/BMVw1zu+iaGbuv6srT8ddec=;
        b=cZn5QLWchpZEx4q5onwECJoe04e+Tv0RP7HAgyGTHmeCrAAcEAaFLCGif1DDL+XbkE
         8zivxNHsOJY+4lIBtCebGsT8gCz/Ggj+rWcdzeq8yKS4Hny8x4OTDo8TwuWf3rX5/iPp
         jb7tOaGVDwYiIprC7pWL/ABBFs0UIzt81t9xeTFJYnbX6fhG73Tqf4ZK+gqWom4ooJUR
         HYNEIgK9z5h4RVrLmKqGGB21TyKh1eLH+dMr34LwNW7CNx42petXdndR+7mmUPY1Q8Ek
         vEvMlgKdrcNAR3kTGD2oRQGKlowXos8gJb4eWYp18ZTXiKr8N2GAyHrymd0btE3pKTv7
         g9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739685726; x=1740290526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JA+U6KzuA4UAyNmQvUy/BMVw1zu+iaGbuv6srT8ddec=;
        b=TAA2ErAAncXCC71x8G4L3rdnwwvpHXSJQ6aXwFLFszOynBPAzOsRsW9PSpKrIWb9Om
         SM2yjg8PQq8Y8XdCLdtuba+ng2RlX7rg4TVR7bm5umjPXM2+x8dNYyR5YeJR/yaZodaQ
         wrQHWA0+LtRJWlkOcs7fRVvnosYkCvJ0hJ1D0qAzhro76f8NJqX3yJvSujkSMoy9Oqis
         hoTpRBTouyTNzhyoIfXV1wPXxXgowkPJ9uBnK+KCZebhtVLF5zMDMbQ2CpriV1vjv06Z
         0MkapkoNjvvdfAiVQBjTaS+JX/7wMzeKZ3+pP4lg6F5L3xW7A1PDzv94CDQ86udEB6KK
         XGiw==
X-Forwarded-Encrypted: i=1; AJvYcCVGr2KtaMsmgXQMjcgXAIrRUIUy4d1vtleV865fbEaniA90GfXoSFSjTlJ6uTU9ijUnoFwGlxRLDR+/yVQa5qP1@vger.kernel.org, AJvYcCWtAvntl1Ghtxum0K7D/aRSn06fnTzgN0sDXAXOWT1jSaRiQj7ICRkTjNaVxk1woUOVKaNzyxdV8/BQpWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrQXINxt2aamxY6iBKiN5SPSiogwzYP7qx+96OQYs9wz+xqR2
	yAe06UUt0UjS/Aywpr7spMfcbjvzXOctxo/povnWedGY94vppZXV
X-Gm-Gg: ASbGnctqtFtl8cJnPWlnTwM9t8NmKBrBO+E7Gl6zziwEopNnuLBZgbDZAuMaa/q5SuM
	4hk23CDM6ApfzMaDGIMeDDvN3dGneIrR8MXXNh3BKOdNsg73eYbJSAJV6tUpwdf3GXqpbhSSJXw
	SRaGKX27NBOvWKGNPFMVauIaBY7Ah6rCL1xTfQ1LPzvvnkBuF5STqZh4+liv2myZIa61S8W9zto
	lryYWK8AaFvNW2jGmY3tC810ENCPG3wQZA/NEcyUjYNeW51WEXZ8WJZHf6M8mW2Tg+mqdnzYzUh
	g4k2YZHiY3+g92PfezR4gqvRfwrK/j6NU0SA
X-Google-Smtp-Source: AGHT+IGIDroiUkEpw9xnnB1kjya0EMZMRrdA5yFJN+D8WymGzRmQMIbAasD1j9eMc0l0BDSKJxHuOQ==
X-Received: by 2002:a05:6a21:6b04:b0:1ee:68d5:3be4 with SMTP id adf61e73a8af0-1ee8cbd2ab5mr8274726637.42.1739685726335;
        Sat, 15 Feb 2025 22:02:06 -0800 (PST)
Received: from localhost.localdomain ([14.139.69.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73268821c54sm1934173b3a.146.2025.02.15.22.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 22:02:05 -0800 (PST)
From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
To: kees@kernel.org
Cc: Bharadwaj Raju <bharadwaj.raju777@gmail.com>,
	joel.granados@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] selftests/sysctl: fix wording of help messages
Date: Sun, 16 Feb 2025 11:31:50 +0530
Message-ID: <20250216060151.6155-1-bharadwaj.raju777@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix paramter -> parameter, and recomended ->
recommended in sysctl.sh's help messages.

Also correct grammar: "number amount of times
is recommended" etc -> "the recommended number of
times".

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 84472b436c07..a8e5736e89a8 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -764,7 +764,7 @@ sysctl_test_0007()
 	fi
 
 	if [ ! -f /proc/cmdline ]; then
-		echo -e "SKIPPING\nThere is no /proc/cmdline to check for paramter"
+		echo -e "SKIPPING\nThere is no /proc/cmdline to check for parameter"
 		return $ksft_skip
 	fi
 
@@ -884,7 +884,7 @@ usage()
 	echo "Valid tests: 0001-$MAX_TEST"
 	echo ""
 	echo "    all     Runs all tests (default)"
-	echo "    -t      Run test ID the number amount of times is recommended"
+	echo "    -t      Run test ID the recommended number of times"
 	echo "    -w      Watch test ID run until it runs into an error"
 	echo "    -c      Run test ID once"
 	echo "    -s      Run test ID x test-count number of times"
@@ -898,7 +898,7 @@ usage()
 	echo Example uses:
 	echo
 	echo "$TEST_NAME.sh            -- executes all tests"
-	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 number of times is recomended"
+	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 the recommended number of times"
 	echo "$TEST_NAME.sh -w 0002    -- Watch test ID 0002 run until an error occurs"
 	echo "$TEST_NAME.sh -s 0002    -- Run test ID 0002 once"
 	echo "$TEST_NAME.sh -c 0002 3  -- Run test ID 0002 three times"
-- 
2.48.1


