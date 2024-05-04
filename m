Return-Path: <linux-kselftest+bounces-9467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAE28BBD5B
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 19:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480FAB2159F
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D991E871;
	Sat,  4 May 2024 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTi3d5Bv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74B3CF63;
	Sat,  4 May 2024 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714842582; cv=none; b=KBaQOJE05QAuUWXO4NPQMiyHPGCY1F/diImtju8iFmOI839/rJhks4mxJUgOeTRoL6LUHBs9124ptLyKlc0Zi+U04KY8T+xBqmzQlxWmZzGCUho/cVXXsj4iS1rju5kQg0MJl3OsEUfaDW2xA5dWn3Q4sG8LZ2SZ0mTsrVGkH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714842582; c=relaxed/simple;
	bh=RN8sM9rwjZwwdKGVaNRPJTpQKo7jfPTufLurlZ3XD3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S1LDUBou6wEjqoYvucZsfCqT+TLTFI5a6vaW9M4BO3jL22ex2WNAsvXFjswIhTyc+qbPEU6AYGwbPxLdnT4xCcpypdjMJuwhGKuWGXMrhrSlozPaXFuuwtOOCdCPO4S0W8gwwhKRYNUWRe1a8CYOt09ItliQhXGT+VJYZmmpFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTi3d5Bv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59b178b75bso47717266b.0;
        Sat, 04 May 2024 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714842579; x=1715447379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce7oQnjKrRdar2TNOfb/eaRIm+cuGYdS0Jy3xtMZjsU=;
        b=WTi3d5BvJIvrz0ffw5mpoMPhS9jNp7+svdjQlgQRh1Jyr2qLIXVYSY6d1IKmFjiFtc
         65M8QoP22j6N06nVHTtb18xtD5nbaO9QHcg1/L9e4Tv71JM23I6RmefBdehO238aS84I
         RZsPlGe4kbdHpsgVnN6pTluY3QnEa0WN172aLQyft6caEiPlKJOYq2nEUONxApwgpf21
         igRhY0nMhoDU3n2oELj2d8zhzmG4hzlFhF2mIqNqXc+Ye6I94z4cfJYrm5DVWL1R4RvJ
         edkfAOka79Da/Q4k52eIrVVsMasVyG2YV7OLzrMWwXPLt+heEXy/+8BhVgRyxct7YJVu
         B1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714842579; x=1715447379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ce7oQnjKrRdar2TNOfb/eaRIm+cuGYdS0Jy3xtMZjsU=;
        b=XD/SxNfCf0KqBV2DU5cOW2lQgSv1aGe5/iFtk5oiN+TK3uPddhbx9DgTifAtuR1x4u
         29XVmRH2pGU6flFZUEULwZen4Dsx9auRZuwrXgzRhjVZ1QQBJCrCbqwp5TR2ctMTJU28
         /iEqJf2ltdmw5yAFcmOyev4AUwCCT3z5xTTAOMcn/Rn9vK2aGLXp3VK38NfUUPk3ooIw
         N0iclEEl48rXFN5bJkQIVj1Z0fWfb0f1iZTIriluWSx3ApTCRzAKzs0O0MofzCyZJTWR
         kJhFlwDUogtaV0GpEP47qvl81YZ7gpPSh3BxZowyYi57noSLgVvQ1xvcop6mH7AeFmAa
         kfOw==
X-Forwarded-Encrypted: i=1; AJvYcCVkqnqDrKPhHMDHrNTXDXydAhDEWMYalhROjGo3orzkdA+DQfobbhw7deXBrls5+EO1mq0rFnFIyWmDmna+eyCk9zoY1uIEry8WzAFp
X-Gm-Message-State: AOJu0YwFgpuNUJhcu0FCneB1avENN1l/8H1KO838+lUWwM/HSdNDXXKo
	CD0kLMl7FHuj7pS0aZvj23rhNnJEg+UH08K5pOLFr4SlJk/tGYGyYmEYOg2/ebWFXHYW
X-Google-Smtp-Source: AGHT+IHEZMxELsmkFExVZ32eKoE6VP7sNTw3UDjsB9mia7KxznttVdNLQa5l7PlqUnPTFxSru20zHA==
X-Received: by 2002:a17:906:52cc:b0:a59:9f11:2b66 with SMTP id w12-20020a17090652cc00b00a599f112b66mr2113454ejn.36.1714842578767;
        Sat, 04 May 2024 10:09:38 -0700 (PDT)
Received: from xps-15.. ([194.110.115.30])
        by smtp.googlemail.com with ESMTPSA id jl24-20020a17090775d800b00a599acaff03sm1776818ejc.19.2024.05.04.10.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 10:09:38 -0700 (PDT)
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Amer Al Shanawany <amer.shanawany@gmail.com>
Subject: [PATCH] selftests/capabilities: fix warn_unused_result build warnings
Date: Sat,  4 May 2024 19:09:16 +0200
Message-ID: <20240504170916.131580-1-amer.shanawany@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the following warnings by adding return check and error handling.

test_execve.c: In function ‘do_tests’:
test_execve.c:100:17: warning: ignoring return value of
 ‘capng_get_caps_process’
 declared with attribute ‘warn_unused_result’ [-Wunused-result]
  100 |                 capng_get_caps_process();
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
validate_cap.c: In function ‘main’:
validate_cap.c:47:9: warning: ignoring return value of
 ‘capng_get_caps_process’
declared with attribute ‘warn_unused_result’ [-Wunused-result]
   47 |         capng_get_caps_process();
      |         ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
---
 tools/testing/selftests/capabilities/test_execve.c  | 12 +++++++++---
 tools/testing/selftests/capabilities/validate_cap.c |  7 ++++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 7cde07a5df78..47bad7ddc5bc 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -82,7 +82,7 @@ static bool create_and_enter_ns(uid_t inner_uid)
 {
 	uid_t outer_uid;
 	gid_t outer_gid;
-	int i;
+	int i, ret;
 	bool have_outer_privilege;
 
 	outer_uid = getuid();
@@ -97,7 +97,10 @@ static bool create_and_enter_ns(uid_t inner_uid)
 			ksft_exit_fail_msg("setresuid - %s\n", strerror(errno));
 
 		// Re-enable effective caps
-		capng_get_caps_process();
+		ret = capng_get_caps_process();
+		if (ret == -1)
+			ksft_exit_fail_msg("capng_get_caps_process failed\n");
+
 		for (i = 0; i < CAP_LAST_CAP; i++)
 			if (capng_have_capability(CAPNG_PERMITTED, i))
 				capng_update(CAPNG_ADD, CAPNG_EFFECTIVE, i);
@@ -207,6 +210,7 @@ static void exec_validate_cap(bool eff, bool perm, bool inh, bool ambient)
 
 static int do_tests(int uid, const char *our_path)
 {
+	int ret;
 	bool have_outer_privilege = create_and_enter_ns(uid);
 
 	int ourpath_fd = open(our_path, O_RDONLY | O_DIRECTORY);
@@ -250,7 +254,9 @@ static int do_tests(int uid, const char *our_path)
 			ksft_exit_fail_msg("chmod - %s\n", strerror(errno));
 	}
 
-	capng_get_caps_process();
+	ret = capng_get_caps_process();
+	if (ret == -1)
+		ksft_exit_fail_msg("capng_get_caps_process failed\n");
 
 	/* Make sure that i starts out clear */
 	capng_update(CAPNG_DROP, CAPNG_INHERITABLE, CAP_NET_BIND_SERVICE);
diff --git a/tools/testing/selftests/capabilities/validate_cap.c b/tools/testing/selftests/capabilities/validate_cap.c
index 60b4e7b716a7..65f2a1c89239 100644
--- a/tools/testing/selftests/capabilities/validate_cap.c
+++ b/tools/testing/selftests/capabilities/validate_cap.c
@@ -28,6 +28,7 @@ static bool bool_arg(char **argv, int i)
 int main(int argc, char **argv)
 {
 	const char *atsec = "";
+	int ret;
 
 	/*
 	 * Be careful just in case a setgid or setcapped copy of this
@@ -44,7 +45,11 @@ int main(int argc, char **argv)
 		atsec = " (AT_SECURE is not set)";
 #endif
 
-	capng_get_caps_process();
+	ret = capng_get_caps_process();
+	if (ret == -1) {
+		ksft_print_msg("capng_get_caps_process failed\n");
+		return 1;
+	}
 
 	if (capng_have_capability(CAPNG_EFFECTIVE, CAP_NET_BIND_SERVICE) != bool_arg(argv, 1)) {
 		ksft_print_msg("Wrong effective state%s\n", atsec);
-- 
2.43.0


