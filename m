Return-Path: <linux-kselftest+bounces-23820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE1B9FF7C7
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F266D1882E07
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791FF1AB6DD;
	Thu,  2 Jan 2025 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmSRfDER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9319D8BB;
	Thu,  2 Jan 2025 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735812315; cv=none; b=SzRTqJdbZniMc4rixXC6Nr+YD8v+FGZjK3TZlrEUe1ZHUnx9IByZmLj4T+7gEvV/nxIM4wdEN+p3cVcN1hhVm4MFNrN3Ewv2YLuCcrBd552pfbOY/PfsDm0kcX3ku1ZLH+RDEtsNHbr0IOgdouMXZcY+U1aZqqkBh6/9dE0gsaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735812315; c=relaxed/simple;
	bh=E5B04nP/p1tjctc7tRaDi3KpmTPtDYnoyQ4NxS9KzGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XDsaal0m5zmsEhGkcR9aPri+3jHkuJ7oNx4Y4YNzEzZ8prDTamrevzlT+AGPnr2gyRdF/vqCydlXc0k+Mgp2S5yEEzjQFCHtov/wAI36/rc/Y6biTveDkxvZivrcZsFII9Fqzh7p5dC4ldJ/G+c/qaZ9L6BEMRM1p+7d3S+zi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmSRfDER; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b1f05caso150222135ad.3;
        Thu, 02 Jan 2025 02:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735812313; x=1736417113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9pqvO/HmvM8F30k0JXImorQhWQmk8hgeeTlW54kQmw=;
        b=GmSRfDERU4TdvSwWQjR2HchpZ9ijLb79HIvIM2i7QYfJuh0vBSoPbLVp0+yIvoU0Jw
         TsLIuLeA+qUVrHJ8sSI9G2stpG3sda6toc2XWW4aafvC+4+Gm7Zaul2CVjEK+AXZw2R/
         Hw/BfUYhwxANZzTcIYZJHDLFke5fYvyKug8H7pvgRskaSPeJzrg5FEk4OsFngCSUL0U/
         tYARLSJpYgMKEUu/4wwIT+XFs4IgvD7u0RtbsRyjscmWAwAe3IBhIXjoyJoXlaj07ih/
         mh5hs6OaRI5Ymc22hg8ozctTTrTEmy6iQJHyaEfh4f8zXKyg/e1D0hYanNzlsJSDuINm
         Oq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735812313; x=1736417113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9pqvO/HmvM8F30k0JXImorQhWQmk8hgeeTlW54kQmw=;
        b=q8gY5DBm6Gw9rejPlOVddUTd6OutJnPW7GnDkoRtBOW1V4OX6dT4BvYZCiocySYPiM
         dLHuZxuSuY46YVULoohNAHmfh2RcQFVqjiZyuEzIu6tHKn0G0PdeaLK688iGnBl3C1j5
         rs8ZIP6GlwVdFOB63YPP5Yevez3WqJe1WaPuqJJG8sGKHs3Nd5SUc2qpIx/xjXzuT05N
         UlZ9Gi3nx7baa01eMofBVFsvI7/QmF3ciecpnQkbkFX39cCi0aXpFHrDUwVTrEUriMjH
         wd2H8X3YaXAGZ/Prm2BZc6TZPQStM5UFjJMGb7H3N33+yTwlW3htlKgAyA8G8qmCEZUC
         EdqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl8giPWPLcb7KvHKlcBroAsd3+TPWuMIbD3r3GY9kW4Llo9lhNyWxkoPHK2sA69imHAsdaRlItbrwoVV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcbD1yWc3GnjgC2MkKfCro3SL8CuCPHm5eSe1BW0ub/W0NjDE
	WQREBGLwxTkKJlemcTZR5aRanGtiYD1FCLNrAC6yp/LOnKjmV7kpIOCFtg==
X-Gm-Gg: ASbGncvs93gdbNiu7aIgdQN2brf2CRLqkJhKwL0GUSz6a5gXJIJgXxJyUMf5NRRZl0E
	3Gp3arYI3TbQuyokJxQZ0EoMoobNN6D2lHd4DYvKuq6p78PO5GiLmfSfqZ3C11GA2gTLwLnUuwv
	UEv6nBgCoLJh4tOUE14DyJtnSZMsexNPaGNOZQpyqgWaiMEAKcX2dbtPUGxt7Rx2skNysfiPF2f
	zyZBq5DOpmOpcpsU2dldoxXcNpeInrcGAR9PfO2oEjAIaqqUkGs6sv95TrxrCUBwKAfVQ==
X-Google-Smtp-Source: AGHT+IGz+JOKRKnBWp+Kh76fkqrY6rwNqq4as+W+NSqOnua3pty4goNpTJyyEFi2UrgSyhbSUDMM/Q==
X-Received: by 2002:a17:902:fc4e:b0:216:31aa:1308 with SMTP id d9443c01a7336-219e6ec1da0mr683111145ad.34.1735812313322;
        Thu, 02 Jan 2025 02:05:13 -0800 (PST)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7457sm219759945ad.201.2025.01.02.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 02:05:13 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v7 2/2] selftests: tmpfs: Add kselftest support to tmpfs
Date: Thu,  2 Jan 2025 15:34:59 +0530
Message-Id: <20250102100459.1291426-3-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102100459.1291426-1-cvam0000@gmail.com>
References: <20250102100459.1291426-1-cvam0000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace direct error handling with 'ksft_test_result_*'
macros for better reporting.

Test logs:

Before change:
- Without root
 error: unshare, errno 1

- With root
 No, output

After change:
- Without root
TAP version 13
1..1
ok 2 # SKIP This test needs root to run!
Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

- With root
TAP version 13
1..1
ok 1 Test : Success
Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index 657b64857e82..290f11a81d2b 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -41,39 +41,39 @@ int main(void)
 
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
-			fprintf(stderr, "error: unshare, errno %d\n", errno);
-			return 4;
+			ksft_exit_skip("unshare() error: unshare, errno %d\n", errno);
+		} else {
+			ksft_exit_fail_msg("unshare() error: unshare, errno %d\n", errno);
 		}
-		fprintf(stderr, "error: unshare, errno %d\n", errno);
-		return 1;
 	}
+
 	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
-		fprintf(stderr, "error: mount '/', errno %d\n", errno);
-		return 1;
+		ksft_exit_fail_msg("mount() error: Root filesystem private mount: Fail %d\n", errno);
 	}
 
 	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
 	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
-		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
-		return 1;
+		ksft_exit_fail_msg("mount() error: Mounting tmpfs on /tmp: Fail %d\n", errno);
 	}
 
 	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 1, errno %d\n", errno);
-		return 1;
+		ksft_exit_fail_msg("openat() error: Open first temporary file: Fail %d\n", errno);
 	}
+
 	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
-		fprintf(stderr, "error: linkat, errno %d\n", errno);
-		return 1;
+		ksft_exit_fail_msg("linkat() error: Linking the temporary file: Fail %d\n", errno);
+		/* Ensure fd is closed on failure */
+		close(fd);
 	}
 	close(fd);
 
 	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 2, errno %d\n", errno);
-		return 1;
+		ksft_exit_fail_msg("openat() error: Opening the second temporary file: Fail %d\n", errno);
 	}
 
+	ksft_test_result_pass("Test : Success\n");
+	ksft_exit_pass();
 	return 0;
 }
-- 
2.34.1


