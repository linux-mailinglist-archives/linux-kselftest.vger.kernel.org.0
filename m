Return-Path: <linux-kselftest+bounces-33446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF931ABEB23
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 07:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5304A66F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 05:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4376722F163;
	Wed, 21 May 2025 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CByK7fmL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CC22D4F2;
	Wed, 21 May 2025 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804152; cv=none; b=N8FNEcp56QlZUwDU4YL7EUmznoLoqH55acNBYTN1VwP7A8kfnGv5ivDvaCTX2yKLSZ9Hx9eb9/Bn1X0r4pGzjFnv9n/1uPJRVtMYzJD0EN3lZ5Nt4vsYUOiyr3OOAHTX9WgT5WXxoa+WXWkiQxzwaCPY7L2qAJxY71ITK1h3bcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804152; c=relaxed/simple;
	bh=oF2C4nz7YhujYMmwzGwXXlGgny9pDbjMH6QdlRzkVFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Su8Eo9oqMgL8dujzEPKq/bloXYi4OoveVIvaVptPRKY7gBy3OVcrpaDEUiaO5xMTh8z9zIsEPtgMb95The7jTYMSB4cG+OHmS/vOHdwRxagXhS98Rt7Goa2jgfLtKCr9Hi716YhDQ3kA0GwMJTEdByLviHjr3pd5pQyZlfYsJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CByK7fmL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74019695377so4858388b3a.3;
        Tue, 20 May 2025 22:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747804150; x=1748408950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7VQmCzVFvBem7BEULeC/ezxM7T1lAwqR334gl85J1w=;
        b=CByK7fmLnLmkBQ8qGuJekdqTbdykPUiMYzccJ9ETln8ES99OUA6cyHs9yd7iWGZoDP
         8rE3tQcFLqWTM4uIgkD0y0pCDuOFhmZT0AdWOkRlQh0zGisWYhSiP+195PAELl21wKtE
         y4T6433L6eLlBXI28ADHQyCAk/QxNXjXuNGDkL2j5Ivrka6E2OC7O1VBKvdKbcBqrdag
         qIhRXC3f/Oh8rjbTI0PvP/7e6Ffy4Q/RIFkmjNk64ohKAOkQCk8lySDAGbkIajnLxdN+
         xmYBBak0vVjFnle9bpx5nZ5eXNgL7bdT+kOHVWN0n86leHxvHsyXQA8yp3MShwDrsqwE
         B/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747804150; x=1748408950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7VQmCzVFvBem7BEULeC/ezxM7T1lAwqR334gl85J1w=;
        b=j6El7ZzHMl+4DnTmj5WjJg+KeiIRfhrltetHJWqrp3HQubRBwI8Afg5LWWm9l/7h38
         60n3lpFtS0fSAtbu3eWt+mb7LXlbMrjkXBbZYq6vdukeqdJcBzEqEFewC+HDu3dQyYls
         HbLtHPtoOrM1FmPeWIimwVW+8f9xEPcZj2kykvFL+7G6EQryZrNqYVmYbBWSx0G/VaPt
         uAHpIikqHg0WuvAdl3+qprJ46NuUYkkMtR60xAfHeYK0BxjfwpyezAKDppnpHqdF2lRg
         xiVHttyiwTGHJsYqNj7rpLRTKzfHELCYtgMtmakS/pXuEPg2lMlajFr//HRgQY4CN+JG
         0I5w==
X-Forwarded-Encrypted: i=1; AJvYcCU6RiA9nPrYybCvqbNgnOnWE4P2C1r4Y4O44O2Un6qlVTEguFihod9Vxq0VpDRkTBl2ZwD1SfMRWBPU+ICZ6NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaBlysHU53o0E2T96ipxLRx5Kua5q68MCtYarb4clmpd7wdrpI
	ASZVaS2ReAfeXJAASCLnBwjrkaf6VSZsajNaKMBVbc0SVVxsqHEH35WA
X-Gm-Gg: ASbGncveVtyPDUBCtuHasbD6XehAKdzjWOPK8peB1tpm/CRphluY2aHIgCS8ZmJtAKR
	mfvfGdAtDXrwBXvTq71ZSWLxIJKUCJWlPmJcRmM+iDDYaTF47u4N0puRB+err+c+gKZWeCLdCOi
	DRXDRcDMl013FQ5tXeNLZ+N/epJKw58lj8od/mR1eV3cZkHumV7/7q5tjwmYDeWiVufcTVtOHaU
	ww8rjKh3J82Et1xt9Q3w9244iMpRM2DWbWVm36IA3BpTmgTXppzsuvFYvvTAhPkFuCByx9egNx8
	+A0jPIE1HfzODcTC3WzNz9BBX0Cu5xCMzbXS4ssFlrOTuHWAXYjQ9Xnqmlh7dLBzFuKjSMCMLqx
	n8k4E5yefKcyn8q4YmOEpb7NAtZx1
X-Google-Smtp-Source: AGHT+IHh6Inhnokw4rbwT20mfrVae9IcLmnFQgitRWClEVjJgAmeXA9M9Dt5VSBe2sFqevmUeM+Rrw==
X-Received: by 2002:a05:6a21:1807:b0:1f5:93b1:6a58 with SMTP id adf61e73a8af0-2162188b87emr30491253637.8.1747804149931;
        Tue, 20 May 2025 22:09:09 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:aebf:fcbc:c222:fc3d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986d9c3sm8718738b3a.121.2025.05.20.22.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 22:09:09 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: brauner@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH] kselftest/pidfd: Make all test functions return int
Date: Wed, 21 May 2025 01:09:06 -0400
Message-ID: <20250521050906.629641-1-ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pidfd_test suite currently defines six test functions,
four of which return an int, while the remaining
two return void. This is inconsistent.

To address this, convert the two void-returning test
functions to return int, bringing them in line with
the rest. For now, the functions always return 0.

Fixes: 740378dc7834b ("pidfd: add polling selftests")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 tools/testing/selftests/pidfd/pidfd_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index fcd85cad9f18..645ac8e35033 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -492,7 +492,7 @@ static int child_poll_exec_test(void *args)
 	return 0;
 }
 
-static void test_pidfd_poll_exec(int use_waitpid)
+static int test_pidfd_poll_exec(int use_waitpid)
 {
 	int pid, pidfd = 0;
 	int status, ret;
@@ -528,6 +528,7 @@ static void test_pidfd_poll_exec(int use_waitpid)
 		ksft_exit_fail_msg("%s test: Failed\n", test_name);
 	else
 		ksft_test_result_pass("%s test: Passed\n", test_name);
+	return 0;
 }
 
 static void *test_pidfd_poll_leader_exit_thread(void *priv)
@@ -558,7 +559,7 @@ static int child_poll_leader_exit_test(void *args)
 	exit(0);
 }
 
-static void test_pidfd_poll_leader_exit(int use_waitpid)
+static int test_pidfd_poll_leader_exit(int use_waitpid)
 {
 	int pid, pidfd = 0;
 	int status, ret = 0;
@@ -608,6 +609,7 @@ static void test_pidfd_poll_leader_exit(int use_waitpid)
 		ksft_exit_fail_msg("%s test: Failed\n", test_name);
 	else
 		ksft_test_result_pass("%s test: Passed\n", test_name);
+	return 0;
 }
 
 int main(int argc, char **argv)
-- 
2.45.2


