Return-Path: <linux-kselftest+bounces-39811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62381B331AB
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 19:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A262B3B0982
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A89E2DFA3E;
	Sun, 24 Aug 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En+ufxB6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103923817F;
	Sun, 24 Aug 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057518; cv=none; b=QaPwT3UxQCCJ9eBWy8UfCkvazWd5jovB7kyJAlwkv8a6wPtO3tc7ImdKib/tejFE/Vw7afYNuddOGwaB9+9T5Y94s1vryGM6mfS8WwaKZ7v4Yq0AMaK31vE3zhVLXbHjIL292IodGWvZPAxq12o5IXaJ17Z7R1da/pl1y60KmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057518; c=relaxed/simple;
	bh=Qn1rLDsoDKdKMJtbLpMwuMUtY/s55I3PHJwzXWWALlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZRtP+JV03IKKVDN8x+AmKvpquNpSxAmWz6y2J/mY91kHbyRE0p7/N9JMWe36iZ8WBSvdaR3orTyQ22ZLyMPZJ8HJ3bwTtcPfMwV3hrj7qUtB68BeXywp6gE1x0+V9F/tvXap3sLRJ4MFf4MIxQjXQ8jHhbW7+0oajoDAi+in2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En+ufxB6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3252589a47cso1436439a91.0;
        Sun, 24 Aug 2025 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756057516; x=1756662316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ+8aiR8UiVTbRBI5Iee92MSTMcmbyyBr1SPn1NeZCA=;
        b=En+ufxB6nCgOrBJOYtrO5hF+dmGouF2WEGQw7NLY+KsN5PklKUMaDDTqSZHMw4e14K
         gP1VZfFb2fGYT8pQVj/UPU6O49n7FFRSfvDazdmNYNkrFaYWvC3Kxs4wsroP/5n8Vszm
         PhMa9DZsnF51JMQLRPef1y4Tih9ogrrxZjSn25nbcnZO1nqMiwy3Y6Da2+uwAy8OSnIC
         6ppZrsFAzR9HMs/XQ8JohG+i6d8Zqq3P2Ni4tZJZCJWMNHNuFuRalF6v5kt9PlJ311Iu
         b5PGVQ89FOrF7A1kp/u+OjutyIfOMAwkVioYq6XLIUNBvL4LmLlOpHUyYUKKG2Fz9qD/
         IoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756057516; x=1756662316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJ+8aiR8UiVTbRBI5Iee92MSTMcmbyyBr1SPn1NeZCA=;
        b=wMELkxrsTdROK2rkS6oWZLdpMJcC5AhALlCmktraXaKDf9I1/kCLEypMImJsiw17dH
         jktmVwXBA1ei2Qlr9MBHr8J0i8oXf86eI3L/S2avCVzPeVmZWumU/riFD+v9DCG+51EN
         j9v79j61iYpqLqNqLQml9WC6r/NvFPAkwfFUlt4nNObfDvdjomzurwjUzxLcGIyM9lBW
         IQ/1AZlVbSHnP+AyiaXyydJo9v9fmHZCgeiZWwxWLFfduIqU71YHoCel8BntLtFPWI/X
         Gt0If3NbNE1Z6oUrZYjAF9w7yp6Ss7zAUTLGI92p0xCzEQoiS0Tq6tGHCGqhZgghQApP
         YEGg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7h8KL+o+9V9YJVB6UqDzsymePLILC2kJyRjiLZK4+oP7g/BYV4hdZA3jEzsw7R+1DfXY0FbHZzohrYA=@vger.kernel.org, AJvYcCW79ehWgApZO91y6F4HKKDBZSbk9Mp4mntREsNy6QgoG6pPDMK/doM7asy6nmCJ4Q6ImcWhrHNk/PnzkcgNAj/3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5ljhLFNiuCJZB2ClQdiA7bH7tQ/Wwms3dgx0/3430zhQe9CW
	JV+plYY4Q0rZLCIvfburfZOKGUTBcpF77J/3hwBp0aAAG7lCDqjc7naTA2m2a/PEyeQ=
X-Gm-Gg: ASbGncvyWUCw0Q7vz5N12KVDglb/TagbB0M4L7Xi+LcrLnuW5076evriwk7iqLrCdHZ
	bK7V6vUXwQq3el2i1wY0UqicWUI5J+frWysw+MX7Hjy2HQLlX+5tFznIXTiwTYRsORItXTt+skB
	tGSHztDGpBPsgZz3VV9hnHG7LxN2o6Cz4xh0dbYtuKsqJsDlnSgsSBTDdoctz6z0V+6rko1FyLL
	xicJNj0sY8HG/ggQ4VydYTxWvlcJLBjzr87glZm0JK+yqYalMHXIxo4T0GJvFYzt4oCg4xLZ/eO
	y1yn42Ouk8Lwh8/NZuRnnDOSTWwhErVih7cvZFvW8YsufA+30CVmYhVgnsaJY7LLqzIxmvfmj1b
	LxJd4dawGryrq/4od4vSW3yHJPdglSr4dlAuNAA==
X-Google-Smtp-Source: AGHT+IGRlY7vdLCHeCVOI3ODz+y7+V14awNjyQPDIDRhWG8D/tYKlJmLN+n6Xo3IsWmM0h1ISPXdKQ==
X-Received: by 2002:a17:90b:2892:b0:31c:39c2:b027 with SMTP id 98e67ed59e1d1-3251d496bd7mr13013074a91.7.1756057515592;
        Sun, 24 Aug 2025 10:45:15 -0700 (PDT)
Received: from localhost.localdomain ([114.79.178.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e39cb4b8sm380438b3a.92.2025.08.24.10.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 10:45:15 -0700 (PDT)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: skhan@linuxfoundation.org,
	shuah@kernel.org
Cc: Prithvi Tambewagh <activprithvi@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/filesystems: Grammatical correction in error message
Date: Sun, 24 Aug 2025 23:11:36 +0530
Message-Id: <20250824174137.5913-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Grammatical correction in error message for TIOCGTPTERR failure

Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 tools/testing/selftests/filesystems/devpts_pts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index b1fc9b916ace..b7652df7888b 100644
--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -129,7 +129,7 @@ static int do_tiocgptpeer(char *ptmx, char *expected_procfd_contents)
 			fret = KSFT_SKIP;
 		} else {
 			fprintf(stderr,
-				"Failed to perform TIOCGPTPEER ioctl\n");
+				"TIOCGPTPEER ioctl operation failed\n");
 			fret = EXIT_FAILURE;
 		}
 		goto do_cleanup;
-- 
2.34.1


