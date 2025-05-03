Return-Path: <linux-kselftest+bounces-32278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E245AAA8301
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 23:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4964217DD06
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6201AB528;
	Sat,  3 May 2025 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE5uofEH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E418DF80;
	Sat,  3 May 2025 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746307215; cv=none; b=J8s+dp21iDysisYq5J7iEfWwt18htwDrxL+cHANsSIWIh+9MNYz98YUQeJxr4ys7oC85ItzKUYT1z9B+Kub8850i355rJkLNolrAq7TWO5MWyEyDFNrpYQPd2YHBOzALfPSmk7fBuXi3kkHVSaxGW7IElIKUsmHwFA3o3ct/eNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746307215; c=relaxed/simple;
	bh=cFb0ULAf5jdb7TStOgkvOO/Tm4mPzvHjjiakbPlwEvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKUC16XWvuEBm/Rbxfs96XNacUh0RFqfwADh7611+faWWu0fhX7Yk38UrQ3/9Klsspnu6l6hGlHH3jwBOOi1pfI2xK08S0qqq8gJ5MrWF0JJ26L+mqBtVRAn35FAQl/IA8+boi735k3QtqpPCPesh8iKFabnqopFLb5xOF21IVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE5uofEH; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f0ad744811so24799136d6.1;
        Sat, 03 May 2025 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746307213; x=1746912013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vllDTIDOtw9hOtdxWDzvdQ7W4F51fxv/uqswZoJV5Gs=;
        b=kE5uofEH6L1tuCvkHmWSX4PdwlQHC2I3vxAPyqf6PshbOJoO15fr5R5gdMEtyGDzP6
         e8h/fIoHE1/qDKowVW+NOaEiiFZgRmhmjfLV0jCoNydb5mSDt5qH4pSUAnVQ6rZVwuCs
         Ta4BbjGSDT/9aT2lt4iWFXEy133hQY8More+HeEeFp+68MA3pLn4WR7HzpnwPhRjI657
         xQTtmcuDDTowC9xjJpQd5UkSftmYo8024K3/zgFeDNuRzQ5Sp0XlR0NUj2xnjp7tS/OG
         8MwuNNskbTvDpO3M/XhneZeM5pwRViu5ww0BQRYIQTCU1g3gZUAcwPYGJyWDUzX8w6FK
         vvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746307213; x=1746912013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vllDTIDOtw9hOtdxWDzvdQ7W4F51fxv/uqswZoJV5Gs=;
        b=BzXyTgOgwrsMK7PHsWQ9MfHtc5lsretiR7stBhzNMeCExEyW7ghiItTiki75Dbw2dv
         L5hHYfGOZdKpzzelLpXSq0ad3izTHgpusVdmQ07DEi5yCmlgPUlNRhwErjmXewkZxH6g
         a2VWdznfHOKjoTI6q+t9GqSXjwPAi1XNnRWlKCo9zvu2mUKbpPCAj2t6FQjOfy5t03Pc
         b3o8l82OcFKGdQOJyA2XnEA7IpURY3zKYhCN6ZFM2HMAPLP83alWzwPGx1MuHAC/ffiD
         dXPFWAtDz7LsXrE0lMQPau6Xd2BZhDg9LkdFFrumqiGwn7mz92YD96qbcvh9Wk3NlexG
         ZbHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnwufGp3SDK8naR67NnwLAw7bsNl/x7HPt4jK2WF4mp/Ew4j4sBsup75UoVy81OA+qjJLmsJ8fhlj3kU4=@vger.kernel.org, AJvYcCXUGMaZfKdl4DgvpA+3mFgFoGsRB1TSk+auvr3z4ttG0ngvUzhGheqRGVbC3MfuA80FhBCUegxoVx7rciafjor2@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQUIZQCY6vqpCYkoJSrsv2+Oxkskr7GKIt1kgGMVmbM5g8rW1
	8/thGxlAQCDHEUBNTTwF5PN7Li0G46CYKHwBma4xaX6tQqlsDFa8
X-Gm-Gg: ASbGncsGbVLVNZ53I9aK4HIb48Mc2w2lj7izzYs1fl69Of1YHXnuhdzT42D41he1jeA
	9trYPUy9ZHFIR8k8zoUY4Np3AzvKRsdkxFvz11y+pbP/jdtZ9O9VtriCmX7j613Xx11Z1crypAb
	kVgfiJJrSlnLEkyxenaL+egTQMvYXO5oM0KRfM6bnxxYD2dbV5TBv0oNiNmC+8hPmD1lvQZFxWo
	j5hAckI/4sMMrn0f4maPySfhmPMl6lB6K2xrXrTGfRJ+WaAiV2u5BC2eZMF9c37b7kTaD6jwsji
	JGcm7KAIFZirTTulsTqO8UIueo4x2LAVGZdamEVMn028T9jD+tf4cpdEod6vw6ddnk2fQezO
X-Google-Smtp-Source: AGHT+IF+E50sm3xgvK7H1soj5wHqnu0tw7JsqkFtzxLx6NPto1aKYp8ETNVb+qv8/y8L5SITYOcA+A==
X-Received: by 2002:a05:6214:765:b0:6f2:b0a7:397e with SMTP id 6a1803df08f44-6f528d19badmr37029426d6.43.1746307212628;
        Sat, 03 May 2025 14:20:12 -0700 (PDT)
Received: from c65201v1.fyre.ibm.com ([129.41.87.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f47e88asm36028706d6.106.2025.05.03.14.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 14:20:11 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: shuah@kernel.org
Cc: brauner@kernel.org,
	akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v2] selftests: Fix some typos in tools/testing/selftests
Date: Sat,  3 May 2025 14:19:59 -0700
Message-ID: <20250503211959.507815-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250503195911.426158-1-chelsyratnawat2001@gmail.com>
References: <20250503195911.426158-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix multiple spelling errors:

 - "rougly" -> "roughly"
 - "fielesystems" -> "filesystems"
 - "Can'" -> "Can't"

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 tools/testing/selftests/filesystems/file_stressor.c           | 2 +-
 tools/testing/selftests/mm/gup_longterm.c                     | 2 +-
 .../selftests/thermal/intel/power_floor/power_floor_test.c    | 2 +-
 .../thermal/intel/workload_hint/workload_hint_test.c          | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/filesystems/file_stressor.c b/tools/testing/selftests/filesystems/file_stressor.c
index 1136f93a9977..01dd89f8e52f 100644
--- a/tools/testing/selftests/filesystems/file_stressor.c
+++ b/tools/testing/selftests/filesystems/file_stressor.c
@@ -156,7 +156,7 @@ TEST_F_TIMEOUT(file_stressor, slab_typesafe_by_rcu, 900 * 2)
 			ssize_t nr_read;
 
 			/*
-			 * Concurrently read /proc/<pid>/fd/ which rougly does:
+			 * Concurrently read /proc/<pid>/fd/ which roughly does:
 			 *
 			 * f = fget_task_next(p, &fd);
 			 * if (!f)
diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 21595b20bbc3..d50ada0c7dbf 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -158,7 +158,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		/*
 		 * R/O pinning or pinning in a private mapping is always
 		 * expected to work. Otherwise, we expect long-term R/W pinning
-		 * to only succeed for special fielesystems.
+		 * to only succeed for special filesystems.
 		 */
 		should_work = !shared || !rw ||
 			      fs_supports_writable_longterm_pinning(fs_type);
diff --git a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
index 0326b39a11b9..30cab5d425d2 100644
--- a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
+++ b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
@@ -56,7 +56,7 @@ int main(int argc, char **argv)
 	}
 
 	if (write(fd, "1\n", 2) < 0) {
-		perror("Can' enable power floor notifications\n");
+		perror("Can't enable power floor notifications\n");
 		exit(1);
 	}
 
diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index 217c3a641c53..a40097232967 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -37,7 +37,7 @@ void workload_hint_exit(int signum)
 	}
 
 	if (write(fd, "0\n", 2) < 0) {
-		perror("Can' disable workload hints\n");
+		perror("Can't disable workload hints\n");
 		exit(1);
 	}
 
@@ -99,7 +99,7 @@ int main(int argc, char **argv)
 	}
 
 	if (write(fd, "1\n", 2) < 0) {
-		perror("Can' enable workload hints\n");
+		perror("Can't enable workload hints\n");
 		exit(1);
 	}
 
-- 
2.43.5


